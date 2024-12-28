#include "./shifts.lp".

%----------------------------------------------------------------------
% Abbreviations
%----------------------------------------------------------------------
staff(ID) :- staff(ID, _, _, _, _).
staff(ID, CD) :- staff(ID, _, _, CD, _).
point(ID, P) :- staff(ID,  _, _, _, P).
date(D) :- date(D, W).
base_date(D) :- base_date(D, _, _).
prev_date(D) :- prev_date(D, _).
next_date(D) :- next_date(D, _).
past_date(D) :- past_date(D, _, _).
full_date(FD, D) :- base_date(D, FD, _).
full_date(FD, D) :- past_date(D, FD, _).

%----------------------------------------------------------------------
% Shift data related
%----------------------------------------------------------------------
shift_data(N, D, S) :- shift_data(ID, _, FD, S), staff(N, ID), full_date(FD, D).

% Suppresses warnings when there are no shift data
shift_data(dummy, dummy, dummy, dummy).

%----------------------------------------------------------------------
% Previous and next month shifts
%----------------------------------------------------------------------

% Define previous month's shifts as ext_assigned/3
ext_assigned(N, D, S) :- staff(N), prev_date(D), shift_data(N, D, S).

% Define next month's shifts (requested shifts) as ext_assigned/3
ext_assigned(N, D, S) :- staff(N), next_date(D), shift_data(N, D, S).

%----------------------------------------------------------------------
% Requested shifts
%----------------------------------------------------------------------

pos_request(N, D, S) :- staff_pos_request(N, D, S), staff(N).
pos_request(N, D, S) :- staff_def_pos_request(N, D, S), not staff_request(N, D).
neg_request(N, D, S) :- staff_neg_request(N, D, S), staff(N).
neg_request(N, D, S) :- staff_def_neg_request(N, D, S), not staff_request(N, D).

% Suppresses warnings when there are no reqeusts
staff_pos_request(dummy, dummy, dummy).
staff_neg_request(dummy, dummy, dummy).

% Abbreviations
staff_request(N, D) :- staff_pos_request(N, D, _).
staff_request(N, D) :- staff_neg_request(N, D, _).
pos_request(N, D) :- pos_request(N, D, _).
neg_request(N, D) :- neg_request(N, D, _).
business_request(N, D, S) :- pos_request(N, D, S), business_shift(S).
business_request(N, D) :- business_request(N, D, _).
leave_request(N, D, S) :- pos_request(N, D, S), leave_shift(S).
leave_request(N, D) :- leave_request(N, D, _).
na_request(N, D, S) :- pos_request(N, D, S), na_shift(S).
na_request(N, D) :- na_request(N, D, _).
manual_request(N, D, S) :- business_request(N, D, S).
manual_request(N, D, S) :- leave_request(N, D, S).
manual_request(N, D, S) :- na_request(N, D, S).
manual_request(N, D) :- manual_request(N, D, _).

% Define current month's shifts (requested shifts) as pos_request/3
pos_request(N, D, S) :- staff(N), date(D), shift_data(N, D, S).

%----------------------------------------------------------------------
% Dates-related
%----------------------------------------------------------------------

% Width of the shift table (number of days)
table_width(X) :- X = { date(_,_) }.
% Number of weekly rest
default_weekly_rests(X) :- table_width(W), X = (W / 7) * 2.
% Number of public holidays
num_public_holidays(X) :- X = { public_holiday(D) : date(D) }.
% Weekdays
weekday(D) :- date(D, ("Mo";"Tu";"We";"Th";"Fr")), not public_holiday(D).
% Weekends
weekend(D) :- date(D, ("Sa";"Su")), not public_holiday(D).
% Number of weekends
% num_curr_weekends(N) :- N = { date(D, "Su") }.
% Day os week
dweek("Mo";"Tu";"We";"Th";"Fr";"Sa";"Su").
% First date of shift table
first_date(0).
first_full_date(FD) :- base_date(0, FD, _).
% Last date of shift table
last_date(X)  :- X = #max { D : date(D, _) }.
% Past dates
past_date(D, PD, W) :- past_date(PD, W), first_full_date(FD), D = PD-FD.

% Suppresses warnings when there are no target predicates
public_holiday(dummy).
past_date(0, dummy).

%----------------------------------------------------------------------
% Work, rest, business, leave and na dates
%----------------------------------------------------------------------

% Days on which work shifts can be assigned
workable_date(N, D) :-
    staff(N),
    date(D),
    not business_request(N, D),
    not na_request(N, D).

% Days on which weekly rest shift can be assigned
weekly_rest_available_date(N, D) :-
    staff(N),
    workable_date(N, D),
    not leave_request(N, D),
    not public_holiday_available_date(N, D).

% Days on which public holiday offs can be assigned
public_holiday_available_date(N, D) :-
    staff(N),
    date(D),
    public_holiday(D),
    not business_request(N, D),
    not leave_request(N, D),
    not na_request(N, D).

% Number of requested business days
num_business_days(N, X) :-
    staff(N), X = { business_request(N, D) : staff(N), date(D) }.

% Number of requested leave days
num_req_leave_days(N, X) :-
    staff(N), X = { leave_request(N, D) : staff(N), date(D) }.

% Number of requested na days
num_na_days(N, X) :-
    staff(N), X = { na_request(N, D) : staff(N), date(D) }.

%----------------------------------------------------------------------
% Number of work and rest days
%----------------------------------------------------------------------

% Number of days that can be assigned as public holidays
num_available_public_holidays(N, X) :-
    staff(N), X = { public_holiday_available_date(N, D) }.

% Number of weekly rests for each nurse
weekly_rest_bounds(N, LB, UB) :-
    staff(N),
    table_width(WIDTH),
    num_na_days(N, NA),
    default_weekly_rests(DWR),
    LB = @weekly_holidays_lb(WIDTH, NA, DWR),
    CUB = @weekly_holidays_ub(WIDTH, NA, DWR),
    RWR = { pos_request(N, D, "WR") : date(D) },
    UB = @max(CUB, RWR). % Use RWR if RWR > CUB (sometimes happen)

% Number of work days for each nurse
work_days_bounds(N, LB, UB) :-
    staff(N),
    table_width(WIDTH),
    weekly_rest_bounds(N, WR_LB, WR_UB),
    num_na_days(N, NA),
    num_business_days(N, B),
    num_available_public_holidays(N, PH),
    num_req_leave_days(N, RL),
    UB = WIDTH - WR_LB - NA - B,
    LB = WIDTH - WR_UB - NA - B - PH - RL.

%----------------------------------------------------------------------
% Convert constraints on days of the week to dates
%----------------------------------------------------------------------

% Staff bounds
%% Weekday
staff_lb(hard_sp, NG, SG, D, V) :- weekday(D), staff_dweek_hard_lb(NG, SG, "Weekday", V).
staff_ub(hard_sp, NG, SG, D, V) :- weekday(D), staff_dweek_hard_ub(NG, SG, "Weekday", V).
staff_lb(soft, NG, SG, D, V) :- weekday(D), staff_dweek_soft_lb(NG, SG, "Weekday", V).
staff_ub(soft, NG, SG, D, V) :- weekday(D), staff_dweek_soft_ub(NG, SG, "Weekday", V).
%% Weekend
staff_lb(hard_sp, NG, SG, D, V) :- weekend(D), staff_dweek_hard_lb(NG, SG, "Weekend", V).
staff_ub(hard_sp, NG, SG, D, V) :- weekend(D), staff_dweek_hard_ub(NG, SG, "Weekend", V).
staff_lb(soft, NG, SG, D, V) :- weekend(D), staff_dweek_soft_lb(NG, SG, "Weekend", V).
staff_ub(soft, NG, SG, D, V) :- weekend(D), staff_dweek_soft_ub(NG, SG, "Weekend", V).
%% Holidays
staff_lb(hard_sp, NG, SG, D, V) :- date(D), public_holiday(D), staff_dweek_hard_lb(NG, SG, "Holiday", V).
staff_ub(hard_sp, NG, SG, D, V) :- date(D), public_holiday(D), staff_dweek_hard_ub(NG, SG, "Holiday", V).
staff_lb(soft, NG, SG, D, V) :- date(D), public_holiday(D), staff_dweek_soft_lb(NG, SG, "Holiday", V).
staff_ub(soft, NG, SG, D, V) :- date(D), public_holiday(D), staff_dweek_soft_ub(NG, SG, "Holiday", V).

% Point bounds
%% Weekday
point_lb(hard_sp, NG, SG, D, V) :- weekday(D), point_dweek_hard_lb(NG, SG, "Weekday", V).
point_ub(hard_sp, NG, SG, D, V) :- weekday(D), point_dweek_hard_ub(NG, SG, "Weekday", V).
point_lb(soft, NG, SG, D, V) :- weekday(D), point_dweek_soft_lb(NG, SG, "Weekday", V).
point_ub(soft, NG, SG, D, V) :- weekday(D), point_dweek_soft_ub(NG, SG, "Weekday", V).
%% Weekend
point_lb(hard_sp, NG, SG, D, V) :- weekend(D), point_dweek_hard_lb(NG, SG, "Weekend", V).
point_ub(hard_sp, NG, SG, D, V) :- weekend(D), point_dweek_hard_ub(NG, SG, "Weekend", V).
point_lb(soft, NG, SG, D, V) :- weekend(D), point_dweek_soft_lb(NG, SG, "Weekend", V).
point_ub(soft, NG, SG, D, V) :- weekend(D), point_dweek_soft_ub(NG, SG, "Weekend", V).
%% Holidays
point_lb(hard_sp, NG, SG, D, V) :- date(D), public_holiday(D), point_dweek_hard_lb(NG, SG, "Holiday", V).
point_ub(hard_sp, NG, SG, D, V) :- date(D), public_holiday(D), point_dweek_hard_ub(NG, SG, "Holiday", V).
point_lb(soft, NG, SG, D, V) :- date(D), public_holiday(D), point_dweek_soft_lb(NG, SG, "Holiday", V).
point_ub(soft, NG, SG, D, V) :- date(D), public_holiday(D), point_dweek_soft_ub(NG, SG, "Holiday", V).

% Suppresses warnings when there are no point bound definition
point_dweek_hard_lb(dummy, dummy, dummy, dummy).
point_dweek_hard_ub(dummy, dummy, dummy, dummy).
point_dweek_soft_lb(dummy, dummy, dummy, dummy).
point_dweek_soft_ub(dummy, dummy, dummy, dummy).

% Default positive/negative shifts
% * Positive/negative requests take precedence over default positive/negative requests
staff_def_pos_request(N, D, S) :-
    staff_def_pos_request_dweek(N, W, S), base_date(D, _, W), 0 <= D, not public_holiday(D).
staff_def_pos_request(N, D, S) :-
    staff_def_pos_request_dweek(N, "PH", S), base_date(D, _, W), 0 <= D, public_holiday(D).
staff_def_neg_request(N, D, S) :-
    staff_def_neg_request_dweek(N, W, S), base_date(D, _, W), 0 <= D, not public_holiday(D).
staff_def_neg_request(N, D, S) :-
    staff_def_neg_request_dweek(N, "PH", S), base_date(D, _, W), 0 <= D, public_holiday(D).

% Suppresses warnings when there are no default requests
staff_def_pos_request_dweek(dummy, dummy, dummy).
staff_def_neg_request_dweek(dummy, dummy, dummy).

%----------------------------------------------------------------------
% Define LB and UB for soft and hard shift constraints
%----------------------------------------------------------------------
shift_lb(soft, N, SG, V) :- shifts_soft_lb(N, SG, V).
shift_ub(soft, N, SG, V) :- shifts_soft_ub(N, SG, V).
shift_lb(hard, N, SG, V) :- shifts_hard_lb(N, SG, V).
shift_ub(hard, N, SG, V) :- shifts_hard_ub(N, SG, V).

% Suppresses warnings when there are no shift bounds
shifts_soft_lb(dummy, dummy, 0).
shifts_soft_ub(dummy, dummy, 0).
shifts_hard_lb(dummy, dummy, 0).
shifts_hard_ub(dummy, dummy, 0).

%----------------------------------------------------------------------
% Define LB and UB for shift patterns
%----------------------------------------------------------------------
pattern_lb(soft, PID, V) :- pattern_soft_lb(PID, V).
pattern_ub(soft, PID, V) :- pattern_soft_ub(PID, V).
pattern_lb(hard, PID, V) :- pattern_hard_lb(PID, V).
pattern_ub(hard, PID, V) :- pattern_hard_ub(PID, V).

% Suppresses warnings when there are no pattern bounds
pattern_soft_lb(dummy, 0).
pattern_soft_ub(dummy, 0).
pattern_hard_lb(dummy, 0).
pattern_hard_ub(dummy, 0).

%----------------------------------------------------------------------
% Past shift assignments related
%----------------------------------------------------------------------
% Number of shift S assignments in past for nurse N
num_past_shifts(N, S, X) :-
    staff(N), shift(S), X = { shift_data(N, D, S) : past_date(D) }.

% Number of past weekend offs for nurse N
num_past_weekend_offs(N, X) :-
    staff(N),
    X = { shift_data(N, D, S1) :
            shift_data(N, D+1, S2),
            past_date(D, _, "Sa"),
            past_date(D+1, _, "Su"),
            rest_shift(S1), rest_shift(S2) }.
% Max number of weekend offs
max_past_weekend_offs(X) :-
    X = #max { Y : num_past_weekend_offs(N, Y), staff(N) }.

% Number of past public holiday offs for nurse N
num_past_public_holiday_offs(N, X) :-
    staff(N), X = { shift_data(N, D, "PH") : past_date(D) }.
% Max number of public holiday offs
max_past_public_holiday_offs(X) :-
    X = #max { Y : num_past_public_holiday_offs(N, Y), staff(N) }.

% The number of consecutive days off (2 or more) in past for Nurse N
% TODO: Normalization based on the number of days working for this department
num_past_consecutive_rests(N, X) :-
    staff(N),
    X = { shift_data(N, D, S0) :
            shift_data(N, D+1, S1),
            shift_data(N, D+2, S2),
            past_date(D+2),
            work_shift(S0),
            rest_shift(S1),
            rest_shift(S2) ;
          not shift_data(N, D, _) :
            shift_data(N, D+1, S1),
            shift_data(N, D+2, S2),
            past_date(D+2),
            rest_shift(S1),
            rest_shift(S2)
        }.
% The number of consecutive days off
max_past_consecutive_rests(X) :- X = #max { Y : num_past_consecutive_rests(N, Y), staff(N) }.

%*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% シフトの種類
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 勤務シフト
working_shift("日";"N";"J";"S";"★";"☆";"A";"P").
% 夜勤シフト
night_working_shift("J";"S";"★";"☆").
% 週休シフト
weekly_holiday_shift("○").
% 祝日シフト
national_holiday_shift("◎").
% ソフト休暇シフト
soft_holiday_shift("年";"健").
% ハード休暇シフト（そもそも部署にいない，週休調整の対象）
% もし異動などで 14 日間 / ならば，週休も 4
hard_holiday_shift("特";"/"). % 「特」はここが適当？
% ビジネスシフト（そもそも部署にいない，週休調整の対象外）
business_shift("産";"育";"病";"出";"研").
% 休日・祝日シフト
regular_holiday_shift(S) :- weekly_holiday_shift(S).
regular_holiday_shift(S) :- national_holiday_shift(S).
% 拡張休暇シフト
valid_holiday_shift(S) :- regular_holiday_shift(S).
valid_holiday_shift(S) :- soft_holiday_shift(S).
% 翌日勤務シフトがあるシフト
consecutive_working_shift(S) :-
    next_shift(S, _), working_shift(NS) : next_shift(S, NS).  % : = such that

% 作成するシフト表の横幅（日数）
table_width(X) :- X = { date(_,_) }.
% 週休の数
default_weekly_holidays(8).
% 祝日の数
num_national_holidays(X) :- X = { national_holiday(D) : date(D) }.

% 平日
weekday("月";"火";"水";"木";"金").
% 週末
weekend("土";"日").

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 各看護師・各シフトごとの上限・下限の算出
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 看護師ごとの勤務日数の上下限
working_dates_bounds(N, LB, UB) :-
    staff(N),
    table_width(WIDTH),
    weekly_holiday_bounds(N, WH_LB, WH_UB),
    num_national_holiday_dates(N, NH),
    num_soft_holiday_dates(N, SH),      % 年，健
    num_hard_holiday_dates(N, HH),      % 幅固定：特, /
    num_business_dates(N, B),           % 幅固定：研, 病, 産
    UB = WIDTH - WH_LB - HH - B,
    LB = WIDTH - WH_UB - HH - B - NH - SH.

% 看護師ごとの週休の数
% TODO: 場合によっては設定ファイルで入力してもらったほうがよい（異動前に週休をとった回数が規定通りとは限らない）
weekly_holiday_bounds(N, LB, UB) :-
    staff(N), table_width(WIDTH),
    num_hard_holiday_dates(N, HH),
    default_weekly_holidays(DWH),
    LB = @weekly_holidays_lb(WIDTH, HH, DWH),
    CUB = @weekly_holidays_ub(WIDTH, HH, DWH),
    RWH = { staff_request(N, D, "○") : date(D) },
    UB = @max(CUB, RWH).     % 希望シフトで週休が CUB を超えていた場合は，それを優先
    %UB = #max {CUB; RWH}.     % 希望シフトで週休が CUB を超えていた場合は，それを優先

% 看護師ごとの祝日の数
national_holiday_date(N, D, W) :-
    staff(N), date(D, W), national_holiday(D, W),
    not soft_holiday_date(N, D, W), not hard_holiday_date(N, D, W).
num_national_holiday_dates(N, X) :-
    staff(N), X = { national_holiday_date(N, D, W) }.

% 看護師ごとのソフト休暇シフトの数
soft_holiday_date(N, D, W) :-p
    staff(N), date(D, W), staff_request(N, D, S), soft_holiday_shift(S).
num_soft_holiday_dates(N, X) :-
    staff(N), X = { soft_holiday_date(N, D, W) }.

% 看護師ごとのハード休暇シフトの数
hard_holiday_date(N, D, W) :-
    staff(N), date(D, W), staff_request(N, D, S), hard_holiday_shift(S).
num_hard_holiday_dates(N, X) :-
    staff(N), X = { hard_holiday_date(N, D, W) }.

% 看護師ごとのビジネスシフトの数
business_date(N, D, W) :-
    staff(N), date(D, W), staff_request(N, D, S), business_shift(S).
num_business_dates(N, X) :-
    staff(N), X = { business_date(N, D, W) }.

% 勤務シフトを割り当て可能な日
workable_date(N, D, W) :-
    staff(N), date(D, W), not hard_holiday_date(N, D, W), not business_date(N, D, W).

% 確実に勤務シフトを割り当て可能な日（workable から soft_holiday と national_holiday を除いたもの）
strict_workable_date(N, D, W) :-
    staff(N), workable_date(N, D, W), not soft_holiday_date(N, D, W), not national_holiday_date(N, D, W).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 曜日に関する制約を日付に展開
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 人数制限
%%% 平日
staff_hard_lb(G, S, D, B) :-
    date(D,W), weekday(W), not national_holiday(D), staff_dweek_hard_lb(G, S, "平日", B).
staff_soft_lb(G, S, D, B) :-
    date(D,W), weekday(W), not national_holiday(D), staff_dweek_soft_lb(G, S, "平日", B).
staff_soft_ub(G, S, D, B) :-
    date(D,W), weekday(W), not national_holiday(D), staff_dweek_soft_ub(G, S, "平日", B).
staff_hard_ub(G, S, D, B) :-
    date(D,W), weekday(W), not national_holiday(D), staff_dweek_hard_ub(G, S, "平日", B).
%%% 土日
staff_hard_lb(G, S, D, B) :-
    date(D,W), weekend(W), not national_holiday(D), staff_dweek_hard_lb(G, S, "土日", B).
staff_soft_lb(G, S, D, B) :-
    date(D,W), weekend(W), not national_holiday(D), staff_dweek_soft_lb(G, S, "土日", B).
staff_soft_ub(G, S, D, B) :-
    date(D,W), weekend(W), not national_holiday(D), staff_dweek_soft_ub(G, S, "土日", B).
staff_hard_ub(G, S, D, B) :-
    date(D,W), weekend(W), not national_holiday(D), staff_dweek_hard_ub(G, S, "土日", B).
%%% 祝日
staff_hard_lb(G, S, D, B) :-
    date(D,_), national_holiday(D), staff_dweek_hard_lb(G, S, "祝日", B).
staff_soft_lb(G, S, D, B) :-
    date(D,_), national_holiday(D), staff_dweek_soft_lb(G, S, "祝日", B).
staff_soft_ub(G, S, D, B) :-
    date(D,_), national_holiday(D), staff_dweek_soft_ub(G, S, "祝日", B).
staff_hard_ub(G, S, D, B) :-
    date(D,_), national_holiday(D), staff_dweek_hard_ub(G, S, "祝日", B).

%% 点数制限
%%% 平日
point_hard_lb(G, S, D, B) :-
    date(D,W), weekday(W), not national_holiday(D), point_dweek_hard_lb(G, S, "平日", B).
point_soft_lb(G, S, D, B) :-
    date(D,W), weekday(W), not national_holiday(D), point_dweek_soft_lb(G, S, "平日", B).
point_soft_ub(G, S, D, B) :-
    date(D,W), weekday(W), not national_holiday(D), point_dweek_soft_ub(G, S, "平日", B).
point_hard_ub(G, S, D, B) :-
    date(D,W), weekday(W), not national_holiday(D), point_dweek_hard_ub(G, S, "平日", B).
%%% 土日
point_hard_lb(G, S, D, B) :-
    date(D,W), weekend(W), not national_holiday(D), point_dweek_hard_lb(G, S, "土日", B).
point_soft_lb(G, S, D, B) :-
    date(D,W), weekend(W), not national_holiday(D), point_dweek_soft_lb(G, S, "土日", B).
point_soft_ub(G, S, D, B) :-
    date(D,W), weekend(W), not national_holiday(D), point_dweek_soft_ub(G, S, "土日", B).
point_hard_ub(G, S, D, B) :-
    date(D,W), weekend(W), not national_holiday(D), point_dweek_hard_ub(G, S, "土日", B).
%%% 祝日
point_hard_lb(G, S, D, B) :-
    date(D,_), national_holiday(D), point_dweek_hard_lb(G, S, "祝日", B).
point_soft_lb(G, S, D, B) :-
    date(D,_), national_holiday(D), point_dweek_soft_lb(G, S, "祝日", B).
point_soft_ub(G, S, D, B) :-
    date(D,_), national_holiday(D), point_dweek_soft_ub(G, S, "祝日", B).
point_hard_ub(G, S, D, B) :-
    date(D,_), national_holiday(D), point_dweek_hard_ub(G, S, "祝日", B).

%% 担当可能・不能なシフト
pos_def_request(N, D, S) :-
    pos_shift(N, W, S), date(D, W), not national_holiday(D).
pos_def_request(N, D, S) :-
    pos_shift(N, "祝", S), date(D), national_holiday(D).
neg_def_request(N, D, S) :-
    neg_shift(N, W, S), date(D, W). %, not national_holiday(D). 担当不能シフトは祝日であっても，指定曜日は担当不可とする
neg_def_request(N, D, S) :-
    neg_shift(N, "祝", S), date(D), national_holiday(D).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 簡略形の定義
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 曜日なし日付の定義
base_date(D) :- base_date(D, _, W).
prev_date(D) :- prev_date(D, W).
date(D) :- date(D, W).
next_date(D) :- next_date(D, W).
national_holiday(D) :- national_holiday(D, W).
workable_date(N, D) :- workable_date(N, D, W).
strict_workable_date(N, D) :- strict_workable_date(N, D, W).
hard_holiday_date(N, D) :- hard_holiday_date(N, D, W).
soft_holiday_date(N, D) :- soft_holiday_date(N, D, W).
date2fulldate(D, FD) :- base_date(D, FD, _).

% 作成するシフト表の開始日と最終日
first_date(X) :- X = #min { D : date(D, _) }.
last_date(X)  :- X = #max { D : date(D, _) }.
first_full_date(FD) :- base_date(0, FD, _).

% スタッフ ID, 点数
staff(ID) :- staff(ID, _,  _, _, _).
point(ID, P) :- staff(ID,  _, _, _, P).

% スタッフの希望シフトがある日
staff_request(N, D) :- staff_request(N, D, _).
% スタッフのソフト休暇シフトがある日
staff_soft_holiday_request(N, D) :- staff_request(N, D, S), soft_holiday_shift(S).
% スタッフの希望休暇シフトがある日
staff_valid_holiday_request(N, D) :- staff_request(N, D, S), valid_holiday_shift(S).
% スタッフの希望ビジネスシフトがある日
staff_business_request(N, D) :- staff_request(N, D, S), business_shift(S).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% シフトデータ（希望シフト含む）から前月・当月・翌月シフトデータの生成
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 前月シフトを ext_assigned/3 として定義
ext_assigned(N, D, S) :- staff(N, _, _, CD, _), prev_date(D), shift_data(CD, _, FD, S), base_date(D, FD, _).

% 前月に working shift があるならば ext_assigned/2 を定義
%ext_assigned(N, D) :- staff(N), prev_date(D), ext_assigned(N, D, S), working_shift(S).

% 当月シフトを staff_request として定義
staff_request(N, D, S) :- staff(N, _, _, CD, _), date(D), shift_data(CD, _, FD, S), base_date(D, FD, _).

% 翌月シフトを ext_assigned/3 として定義
ext_assigned(N, D, S) :- staff(N, _, _, CD, _), next_date(D), shift_data(CD, _, FD, S), base_date(D, FD, _).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 過去のシフトの担当回数データの生成
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 看護師 N がシフト S を担当した回数 X
num_past_shifts(N, S, X) :-
    staff(N, _, _, CD, _), shift(S),
    X = { shift_data(CD, _, FD, S) : first_full_date(FFD), FD < FFD }.

% 看護師 N の週末休暇数
num_past_weekend_offs(N, X) :-
    staff(N, _, _, CD, _),
    X = { shift_data(CD, _, FD1, S1) : shift_data(CD, _, FD2, S2), weekend(FD1, FD2), first_full_date(FFD), FD2 < FFD, regular_holiday_shift(S1), regular_holiday_shift(S2) }.
% 週末休暇数の最大値
max_past_weekend_offs(X) :- X = #max { Y : num_past_weekend_offs(N, Y), staff(N) }.

% 看護師 N の祝日休暇数
num_past_national_holiday_offs(N, X) :-
    staff(N, _, _, CD, _),
    X = { shift_data(CD, _, FD, "◎") : first_full_date(FFD), FD < FFD, national_holiday(FD) }.
% 祝日休暇数の最大値
max_past_national_holiday_offs(X) :- X = #max { Y : num_past_national_holiday_offs(N, Y), staff(N) }.

% 看護師 N の２連続休暇数（理想の上限は看護師ごとに異なるため，平等化が大変．いったん保留）
% num_past_double_reg_holidays(N, X) :-
%     staff(N, _, _, CD, _),
%     X = { shift_data(CD, _, FD1, S1) : regular_holiday_shift(S1), next_date(FD1, FD2), shift_data(CD, _, FD2, S2), regular_holiday_shift(S2), first_full_date(FFD), FD2 < FFD }.
% 看護師 N の連続休暇数（２連休以上）の回数算出
% TODO: 所属日数に応じた正規化が必要
num_past_consecutive_holidays(N, X) :-
    staff(N, _, _, CD, _),
    X = { shift_data(CD, _, FD1, S1) :
            next_date(FD1, FD2),
            next_date(FD2, FD3),
            first_full_date(FFD), FD3 < FFD,

            shift_data(CD, _, FD2, S2),
            shift_data(CD, _, FD3, S3),

            working_shift(S1),
            regular_holiday_shift(S2),
            regular_holiday_shift(S3)
        }.
% 連続休暇数の最大値
max_past_consecutive_holidays(X) :- X = #max { Y : num_past_consecutive_holidays(N, Y), staff(N) }.
*%

