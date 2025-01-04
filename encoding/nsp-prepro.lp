#include "./nsp-shifts.lp".

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
% - Either staff or point hard constraint must be satisfied if both exist; treat as an OR constraint

%% Weekday
staff_lb(hard_sp, NG, SG, D, V) :-
    weekday(D), staff_dweek_hard_lb(NG, SG, "Weekday", V), point_dweek_hard_lb(NG, SG, "Weekday", _).
staff_ub(hard_sp, NG, SG, D, V) :-
    weekday(D), staff_dweek_hard_ub(NG, SG, "Weekday", V), point_dweek_hard_ub(NG, SG, "Weekday", _).
staff_lb(hard, NG, SG, D, V) :-
    weekday(D), staff_dweek_hard_lb(NG, SG, "Weekday", V), not point_dweek_hard_lb(NG, SG, "Weekday", _).
staff_ub(hard, NG, SG, D, V) :-
    weekday(D), staff_dweek_hard_ub(NG, SG, "Weekday", V), not point_dweek_hard_ub(NG, SG, "Weekday", _).
staff_lb(soft, NG, SG, D, V) :-
    weekday(D), staff_dweek_soft_lb(NG, SG, "Weekday", V).
staff_ub(soft, NG, SG, D, V) :-
    weekday(D), staff_dweek_soft_ub(NG, SG, "Weekday", V).
%% Weekend
staff_lb(hard_sp, NG, SG, D, V) :-
    weekend(D), staff_dweek_hard_lb(NG, SG, "Weekend", V), point_dweek_hard_lb(NG, SG, "Weekend", _).
staff_ub(hard_sp, NG, SG, D, V) :-
    weekend(D), staff_dweek_hard_ub(NG, SG, "Weekend", V), point_dweek_hard_ub(NG, SG, "Weekend", _).
staff_lb(hard, NG, SG, D, V) :-
    weekend(D), staff_dweek_hard_lb(NG, SG, "Weekend", V), not point_dweek_hard_lb(NG, SG, "Weekend", _).
staff_ub(hard, NG, SG, D, V) :-
    weekend(D), staff_dweek_hard_ub(NG, SG, "Weekend", V), not point_dweek_hard_ub(NG, SG, "Weekend", _).
staff_lb(soft, NG, SG, D, V) :-
    weekend(D), staff_dweek_soft_lb(NG, SG, "Weekend", V).
staff_ub(soft, NG, SG, D, V) :-
    weekend(D), staff_dweek_soft_ub(NG, SG, "Weekend", V).

%% Holidays
staff_lb(hard_sp, NG, SG, D, V) :-
    date(D), public_holiday(D), staff_dweek_hard_lb(NG, SG, "Holiday", V), point_dweek_hard_lb(NG, SG, "Holiday", _).
staff_ub(hard_sp, NG, SG, D, V) :-
    date(D), public_holiday(D), staff_dweek_hard_ub(NG, SG, "Holiday", V), point_dweek_hard_ub(NG, SG, "Holiday", _).
staff_lb(hard, NG, SG, D, V) :-
    date(D), public_holiday(D), staff_dweek_hard_lb(NG, SG, "Holiday", V), not point_dweek_hard_lb(NG, SG, "Holiday", _).
staff_ub(hard, NG, SG, D, V) :-
    date(D), public_holiday(D), staff_dweek_hard_ub(NG, SG, "Holiday", V), not point_dweek_hard_ub(NG, SG, "Holiday", _).
staff_lb(soft, NG, SG, D, V) :-
    date(D), public_holiday(D), staff_dweek_soft_lb(NG, SG, "Holiday", V).
staff_ub(soft, NG, SG, D, V) :-
    date(D), public_holiday(D), staff_dweek_soft_ub(NG, SG, "Holiday", V).

% Suppresses warnings when there are no staff bound definition
staff_dweek_hard_lb(dummy, dummy, dummy, dummy).
staff_dweek_hard_ub(dummy, dummy, dummy, dummy).
staff_dweek_soft_lb(dummy, dummy, dummy, dummy).
staff_dweek_soft_ub(dummy, dummy, dummy, dummy).

% Point bounds
% - Either staff or point hard constraint must be satisfied if both exist; treat as an OR constraint

%% Weekday
point_lb(hard_sp, NG, SG, D, V) :-
    weekday(D), point_dweek_hard_lb(NG, SG, "Weekday", V), staff_dweek_hard_lb(NG, SG, "Weekday", _).
point_ub(hard_sp, NG, SG, D, V) :-
    weekday(D), point_dweek_hard_ub(NG, SG, "Weekday", V), staff_dweek_hard_ub(NG, SG, "Weekday", _).
point_lb(hard, NG, SG, D, V) :-
    weekday(D), point_dweek_hard_lb(NG, SG, "Weekday", V), not staff_dweek_hard_lb(NG, SG, "Weekday", _).
point_ub(hard, NG, SG, D, V) :-
    weekday(D), point_dweek_hard_ub(NG, SG, "Weekday", V), not staff_dweek_hard_ub(NG, SG, "Weekday", _).
point_lb(soft, NG, SG, D, V) :-
    weekday(D), point_dweek_soft_lb(NG, SG, "Weekday", V).
point_ub(soft, NG, SG, D, V) :-
    weekday(D), point_dweek_soft_ub(NG, SG, "Weekday", V).
%% Weekend
point_lb(hard_sp, NG, SG, D, V) :-
    weekend(D), point_dweek_hard_lb(NG, SG, "Weekend", V), staff_dweek_hard_lb(NG, SG, "Weekend", _).
point_ub(hard_sp, NG, SG, D, V) :-
    weekend(D), point_dweek_hard_ub(NG, SG, "Weekend", V), staff_dweek_hard_ub(NG, SG, "Weekend", _).
point_lb(hard, NG, SG, D, V) :-
    weekend(D), point_dweek_hard_lb(NG, SG, "Weekend", V), not staff_dweek_hard_lb(NG, SG, "Weekend", _).
point_ub(hard, NG, SG, D, V) :-
    weekend(D), point_dweek_hard_ub(NG, SG, "Weekend", V), not staff_dweek_hard_ub(NG, SG, "Weekend", _).
point_lb(soft, NG, SG, D, V) :-
    weekend(D), point_dweek_soft_lb(NG, SG, "Weekend", V).
point_ub(soft, NG, SG, D, V) :-
    weekend(D), point_dweek_soft_ub(NG, SG, "Weekend", V).
%% Holidays
point_lb(hard_sp, NG, SG, D, V) :-
    date(D), public_holiday(D), point_dweek_hard_lb(NG, SG, "Holiday", V), staff_dweek_hard_lb(NG, SG, "Holiday", _).
point_ub(hard_sp, NG, SG, D, V) :-
    date(D), public_holiday(D), point_dweek_hard_ub(NG, SG, "Holiday", V), staff_dweek_hard_ub(NG, SG, "Holiday", _).
point_lb(hard, NG, SG, D, V) :-
    date(D), public_holiday(D), point_dweek_hard_lb(NG, SG, "Holiday", V), not staff_dweek_hard_lb(NG, SG, "Holiday", _).
point_ub(hard, NG, SG, D, V) :-
    date(D), public_holiday(D), point_dweek_hard_ub(NG, SG, "Holiday", V), not staff_dweek_hard_ub(NG, SG, "Holiday", _).
point_lb(soft, NG, SG, D, V) :-
    date(D), public_holiday(D), point_dweek_soft_lb(NG, SG, "Holiday", V).
point_ub(soft, NG, SG, D, V) :-
    date(D), public_holiday(D), point_dweek_soft_ub(NG, SG, "Holiday", V).

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
pattern_lb(soft, PID, NG, V) :- pattern_soft_lb(PID, NG, V).
pattern_ub(soft, PID, NG, V) :- pattern_soft_ub(PID, NG, V).
pattern_lb(hard, PID, NG, V) :- pattern_hard_lb(PID, NG, V).
pattern_ub(hard, PID, NG, V) :- pattern_hard_ub(PID, NG, V).

% Suppresses warnings when there are no pattern bounds
pattern_soft_lb(dummy, dummy, 0).
pattern_soft_ub(dummy, dummy, 0).
pattern_hard_lb(dummy, dummy, 0).
pattern_hard_ub(dummy, dummy, 0).

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
