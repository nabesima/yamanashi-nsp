%----------------------------------------------------------------------
% A nurse can work on a workable day
%----------------------------------------------------------------------
{ assigned(N, D) : workable_date(N, D) } :- staff(N).

%----------------------------------------------------------------------
% Assigns shifts within the working days
%----------------------------------------------------------------------

% A nurse must work at least LB days
violation(hard, work_days_lb(N), LB, X) :-
    staff(N), work_days_bounds(N, LB, UB),
    X = { assigned(N, D) : workable_date(N, D) },
    X < LB.
% A nurse must work at most UB days
violation(hard, work_days_ub(N), UB, X) :-
    staff(N), work_days_bounds(N, LB, UB),
    X = { assigned(N, D) : workable_date(N, D) },
    UB < X.
% LB { assigned(N, D) : workable_date(N, D) } UB :-
%     staff(N), work_days_bounds(N, LB, UB), not soften_hard.

% assigned/2 has exactly one work shift
1 { assigned(N, D, S) : work_shift(S) } 1 :- assigned(N, D).

%----------------------------------------------------------------------
% Do not assigns shifts within the weekly rest days
%----------------------------------------------------------------------

% Weekly rest (Required because work days + weekly rest days != width
% when there are public holidays or requested leaves)
violation(hard, weekly_rest_lb(N), LB, X) :-
    weekly_rest_bounds(N, LB, UB),
    X = { not assigned(N, D) : weekly_rest_date(N, D) },
    X < LB.
violation(hard, weekly_rest_ub(N), UB, X) :-
    weekly_rest_bounds(N, LB, UB),
    X = { not assigned(N, D) : weekly_rest_date(N, D) },
    UB < X.

% LB { not assigned(N, D) : weekly_rest_date(N, D) } UB :-
%     weekly_rest_bounds(N, LB, UB), not soften_hard.

%----------------------------------------------------------------------
% Vertical constraints
%----------------------------------------------------------------------

% Allocates LB or more staffs
violation(T, staff_lb(NG, SG, D), LB, X) :-
    staff_lb(T, NG, SG, D, LB),
    X = { assigned(N, D, S) : staff_group(NG, N), shift_group(SG, S) },
    X < LB.

% Allocates UB or less staffs
violation(T, staff_ub(NG, SG, D), UB, X) :-
    staff_ub(T, NG, SG, D, UB),
    X = { assigned(N, D, S) : staff_group(NG, N), shift_group(SG, S) },
    UB < X.

% Allocates staffs who totally have LB or more points
% sat_staff_point_hard_lb(G, SS, D) :- point_hard_lb(G, SS, D, LB), LB <= #sum{ P, N : point(N, P), assigned(N, D, S), staff_group(G, N), shift_group(SS, S) }.
violation(T, point_lb(NG, SG, D), LB, X) :-
    point_lb(T, NG, SG, D, LB),
    X = #sum{ P, N : point(N, P), assigned(N, D, S), staff_group(NG, N), shift_group(SG, S) },
    X < LB.

% Allocates staffs who totally have UB or less points
violation(T, point_ub(NG, SG, D), UB, X) :-
    point_ub(T, NG, SG, D, UB),
    X = #sum{ P, N : point(N, P), assigned(N, D, S), staff_group(NG, N), shift_group(SG, S) },
    UB < X.

% Either hard bound of the number of staffs or the total of points should be satisfied
:- violation(hard_sp, staff_lb(NG, SG, D), _, _), violation(hard_sp, point_lb(NG, SG, D), _, _).

%----------------------------------------------------------------------
% Horizontal constraints
%----------------------------------------------------------------------

% Assigns LB or more shifts
violation(T, shift_lb(N, SG), LB, X) :-
    shift_lb(T, N, SG, LB),
    X = { assigned(N, D, S) : shift_group(SG, S) },
    X < LB.

% Assigns UB or less shifts
violation(T, shift_ub(N, SG), UB, X) :-
    shift_ub(T, N, SG, UB),
    X = { assigned(N, D, S) : shift_group(SG, S) },
    UB < X.

% Ensure equal assignment of shift LD, SE
:- staff(N),
    not 0 #sum{  1, D : assigned(N, D, "LD") ;
                -1, D : assigned(N, D, "SE") } 0.

%----------------------------------------------------------------------
% Constraints on consecutive working days
%----------------------------------------------------------------------

% Enumerate full consecutive work periods for each nurse
% The last day of the consecutive work period must be after the previous month's end.
% (this is to avoid consecutive work violations in the manual shift table for the previous month).
full_work_period(N, BD, ED) :-
    staff(N),
    consecutive_work_ub(UB),
    base_date(BD), ED=BD+UB-1, base_date(ED), -1 <= ED,
    work_date(N, D) : D = BD..ED.

% Each nurse must not exceed the full consecutive working days.
violation(hard, consecutive_work_days(N, BD), UB, UB+1) :-
    full_work_period(N, BD, ED),
    work_date(N, ED+1),
    consecutive_work_ub(UB).

% A shift requiring next-day work is not assigned on the last day of a full consecutive period.
violation(hard, consecutive_work_days(N, BD), UB, UB+1) :-
    full_work_period(N, BD, ED),
    ext_assigned(N, ED, S),
    has_next_work_day(S),
    consecutive_work_ub(UB).

has_next_work_day(S) :-
    next_shift(S, _),
    work_shift(NS) : next_shift(S, NS).

%----------------------------------------------------------------------
% Constraints on requested shifts
%----------------------------------------------------------------------

% positive requested shift must be assigned
violation(hard, pos_request(N, D)) :-
    pos_request(N, D),
    not 1 { ext_assigned(N, D, S) : pos_request(N, D, S) } 1.

% negative requested shift must not be assigned
violation(hard, neg_request(N, D)) :-
    neg_request(N, D),
    1 { ext_assigned(N, D, S) : neg_request(N, D, S) }.

%----------------------------------------------------------------------
% Auxiliary predicates
%----------------------------------------------------------------------

% Extends 'assigned/3' to 'ext_assigned/3'
ext_assigned(N, D, S) :- assigned(N, D, S).
ext_assigned(N, D, S) :- not assigned(N, D), fixed_request(N ,D), pos_request(N, D, S).
ext_assigned(N, D, "WR") :- not assigned(N, D), weekly_rest_date(N, D).
ext_assigned(N, D, "PH") :- not assigned(N, D), public_holiday(N, D).

% work_date/2 represents working days not only for the current month
% but also for the previous and next months.
work_date(N, D) :- ext_assigned(N, D, S), work_shift(S).
work_date(N, D) :- ext_assigned(N, D, S), business_shift(S).

%----------------------------------------------------------------------
% Hard constraints
%----------------------------------------------------------------------
:- violation(hard, _, _, _), not soften_hard.
:- violation(hard, _), not soften_hard.

% soften_hard is controlled by the nspsolver.
{ soften_hard }.

%----------------------------------------------------------------------
% Penalty
%----------------------------------------------------------------------
penalty(TYPE, CAUSE, LIM, VAL, W, P) :-
    violation(TYPE, CAUSE, LIM, VAL),
    W = (LIM - VAL) * (LIM - VAL),
    priority(TYPE, CAUSE, P).
penalty(TYPE, CAUSE, 0, 0, 1, P) :-
    violation(TYPE, CAUSE),
    priority(TYPE, CAUSE, P).

% for obj function
penalty(TYPE, CAUSE, W, P) :- penalty(TYPE, CAUSE, _, _, W, P).

cause_type(work_days_lb(N)) :- staff(N).
cause_type(work_days_ub(N)) :- staff(N).
cause_type(weekly_rest_lb(N)) :- staff(N).
cause_type(weekly_rest_ub(N)) :- staff(N).
cause_type(staff_lb(NG, SG, D)) :- staff_group(NG), shift_group(SG), date(D).
cause_type(staff_ub(NG, SG, D)) :- staff_group(NG), shift_group(SG), date(D).
cause_type(point_lb(NG, SG, D)) :- staff_group(NG), shift_group(SG), date(D).
cause_type(point_ub(NG, SG, D)) :- staff_group(NG), shift_group(SG), date(D).
cause_type(shift_lb(N, SG)) :- staff(N), shift_group(SG).
cause_type(shift_ub(N, SG)) :- staff(N), shift_group(SG).
cause_type(consecutive_work_days(N, D)) :- staff(N), base_date(D).
cause_type(pos_request(N, D)) :- staff(N), date(D).
cause_type(neg_request(N, D)) :- staff(N), date(D).

% if there is no department-specific priority, use the defualt priority
priority(soft, C, 1) :- cause_type(C), not dep_priority(C, _).
priority(hard, C, 10) :- cause_type(C), not dep_priority(C, _).

%----------------------------------------------------------------------
% Objective functions
%----------------------------------------------------------------------
% Minimize the total penalty in lexicographic order
#minimize { WEGIHT@PRIORITY,TYPE,CAUSE : penalty(TYPE, CAUSE, WEGIHT, PRIORITY) }.
% Maxmize the total reward in lexicographic order
#maximize { WEGIHT@PRIORITY,TYPE,CAUSE : reward(TYPE, CAUSE, WEGIHT, PRIORITY) }.

%----------------------------------------------------------------------
% Output related
%----------------------------------------------------------------------
% Date
out_date(D, FD, W)    :- base_date(D, FD, W), not public_holiday(D).
out_date(D, FD, "PH") :- base_date(D, FD, W), public_holiday(D).

#show.
#show ext_assigned/3.
#show out_date/3.
#show penalty/6.

%*
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 看護師ごとのシフトの上下限制約
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 勤務シフトを指定回数割り当てる
LB { assigned(N, D) : workable_date(N, D) } UB :-
    staff(N), working_dates_bounds(N, LB, UB), not soft_all.

% % 各看護師 N, 各日 D に勤務シフト S を１つだけ割当
% 1 { assigned(N, D, S) : working_shift(S) } 1 :- assigned(N, D).

% % 週休シフトを指定回数割り当てる
% LB { not assigned(N, D) : strict_workable_date(N, D) } UB :-
%     weekly_holiday_bounds(N, LB, UB), not soft_all.

% % ハード休暇シフト -> workable_day ではないので不要?
% :- staff_request(N, D, S), hard_holiday_shift(S), assigned(N, D), not soft_all.

% % ビジネスシフト -> workable_day ではないので不要?
% :- staff_request(N, D, S), business_shift(S), assigned(N, D), not soft_all.

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 補助述語の定義
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % 週休
% % ペナルティチェック時は，未割り当てセルを休みとしない
% weekly_holiday_off(N, D) :- not assigned(N, D), not staff_request(N ,D), staff(N), date(D), not national_holiday(D), not penalty_check.
% weekly_holiday_off(N, D) :- not assigned(N, D), staff_request(N ,D, S), working_shift(S), date(D), not national_holiday(D), not penalty_check.
% weekly_holiday_off(N, D) :- not assigned(N, D), staff_request(N ,D, "○"), date(D), not national_holiday(D), not penalty_check.
% % 祝日休
% % ペナルティチェック時は，未割り当てセルを休みとしない
% national_holiday_off(N, D) :- not assigned(N, D), not staff_request(N ,D), staff(N), date(D), national_holiday(D), not penalty_check.
% national_holiday_off(N, D) :- not assigned(N, D), staff_request(N ,D, S), working_shift(S), date(D), national_holiday(D), not penalty_check.
% national_holiday_off(N, D) :- not assigned(N, D), staff_request(N ,D, "◎"), date(D), national_holiday(D), not penalty_check.
% % 週休+祝日休
% regular_holiday_off(N, D) :- weekly_holiday_off(N, D).
% regular_holiday_off(N, D) :- national_holiday_off(N, D).
% % 週休+祝日休+ソフト休暇（年,健）
% % ペナルティチェック時は，未割り当てセルを休みとしない
% valid_holiday_off(N, D) :- regular_holiday_off(N, D).
% valid_holiday_off(N, D) :- not assigned(N, D), staff_request(N ,D, S), soft_holiday_shift(S), date(D), not penalty_check.

% % regular_holiday_off/2 を prev_date + date 区間に拡張
% ext_regular_holiday_off(N, D) :- regular_holiday_off(N, D).
% ext_regular_holiday_off(N, D) :- prev_date(D), ext_assigned(N, D, S), regular_holiday_shift(S).

% % valid_holiday_off/2 を prev_date + date 区間に拡張
% ext_valid_holiday_off(N, D) :- valid_holiday_off(N, D).
% ext_valid_holiday_off(N, D) :- prev_date(D), ext_assigned(N, D, S), valid_holiday_shift(S).

% % date 区間の assigned を base_date 区間用の ext_assigned に拡張
% % ペナルティチェック時は，新たな ext_assigned/3 を生成しないため認めない
% ext_assigned(N, D, S  ) :- assigned(N, D, S), not penalty_check.
% ext_assigned(N, D, S  ) :- fixed(assigned(N, D, S)), not penalty_check.
% ext_assigned(N, D, S  ) :- not assigned(N, D), staff_request(N ,D, S), not working_shift(S), not fixed(assigned(N, D, _)), not penalty_check.
% ext_assigned(N, D, "○") :- staff(N), weekly_holiday_off(N, D), not fixed(assigned(N, D, _)), not penalty_check.
% ext_assigned(N, D, "◎") :- staff(N), national_holiday_off(N, D), not fixed(assigned(N, D, _)), not penalty_check.

% % working shift と研（勤務扱い）のみ ext_assigned/2 を定義
% ext_assigned(N, D) :- ext_assigned(N, D, S), working_shift(S).
% ext_assigned(N, D) :- ext_assigned(N, D, "研").

% % 翌月の希望シフトは割り当てる（縦方向統計量算出のため）
% ext_assigned(N, D, S) :- staff_request(N, D, S), next_date(D).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 縦制約：各日 D，各シフト S，各看護師グループ G ごとの人数制約
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % 各日 D，各シフト S，各看護師グループ G に属する看護師数の下限制約
% sat_staff_point_hard_lb(G, SS, D) :- staff_hard_lb(G, SS, D, LB), LB { assigned(N, D, S) : staff_group(G, N), shift_group(SS, S) }.

% penalty(staff_soft_lb(FD, SS, G, LB, X), num_staffs(D, SS, G), PNL * (LB - X) * (LB - X), PRI)
%     :- staff_soft_lb(G, SS, D, LB), date2fulldate(D, FD), X = { assigned(N, D, S) : staff_group(G, N), shift_group(SS, S) }, X < LB,
%        _penalty("staff_lb", PNL), _staff_lb_priority(G, SS, PRI).

% % 各日 D，各シフト S，各看護師グループ G に属する看護師数の上限制約
% sat_staff_point_hard_ub(G, SS, D) :- staff_hard_ub(G, SS, D, UB), { assigned(N, D, S) : staff_group(G, N), shift_group(SS, S) } UB.

% penalty(staff_soft_ub(FD, SS, G, UB, X), num_staffs(D, SS, G), PNL * (X - UB) * (X - UB), PRI)
%     :- staff_soft_ub(G, SS, D, UB), date2fulldate(D, FD), X = { assigned(N, D, S) : staff_group(G, N), shift_group(SS, S) }, UB < X,
%        _penalty("staff_ub", PNL), _staff_ub_priority(G, SS, PRI).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 縦制約：各日 D，各シフト S，各看護師グループ G ごとの点数制約
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % 各日 D，各シフト S，各看護師グループ G に属する看護師の点数和の下限制約
% sat_staff_point_hard_lb(G, SS, D) :- point_hard_lb(G, SS, D, LB), LB <= #sum{ P, N : point(N, P), assigned(N, D, S), staff_group(G, N), shift_group(SS, S) }.

% penalty(point_soft_lb(FD, SS, G, LB, X), num_points(D, SS, G), PNL * (LB - X) * (LB - X), PRI)
%     :- point_soft_lb(G, SS, D, LB), date2fulldate(D, FD), X = #sum{ P, N : point(N, P), assigned(N, D, S), staff_group(G, N), shift_group(SS, S) }, X < LB,
%        _penalty("point_lb", PNL), _priority("point_lb", PRI).

% % 各日 D，各シフト S，各看護師グループ G に属する看護師の点数和の上限制約
% sat_staff_point_hard_ub(G, SS, D) :- point_hard_ub(G, SS, D, UB), #sum{ P, N : point(N, P), assigned(N, D, S), staff_group(G, N), shift_group(SS, S) } <= UB.

% penalty(point_soft_ub(FD, SS, G, UB, X), num_points(D, SS, G), PNL * (X - UB) * (X - UB), PRI)
%     :- point_soft_ub(G, SS, D, UB), date2fulldate(D, FD), X = #sum{ P, N : point(N, P), assigned(N, D, S), staff_group(G, N), shift_group(SS, S) }, UB < X,
%        _penalty("point_ub", PNL), _priority("point_ub", PRI).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 縦制約：人数制約 or 点数制約のいずれかが成立
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% :- staff_hard_lb(G, S, D, _), not sat_staff_point_hard_lb(G, S, D), not soft_all.
% :- point_hard_lb(G, S, D, _), not sat_staff_point_hard_lb(G, S, D), not soft_all.
% :- staff_hard_ub(G, S, D, _), not sat_staff_point_hard_ub(G, S, D), not soft_all.
% :- point_hard_ub(G, S, D, _), not sat_staff_point_hard_ub(G, S, D), not soft_all.

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 横制約：各看護師の担当するシフト数に関する制約
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % Requires the number of shift assignments to satisfy the hard limit
% :- shifts_hard_lb(N, SG, LB),
%     not LB { assigned(N, D, S) : shift_group(SG,S) }, not soft_all.

% penalty(shifts_soft_lb(N, SS, LB, X), num_shifts(N, SS), PNL * (LB - X) * (LB - X), PRI) :-
%     shifts_soft_lb(N, SS, LB), X = { assigned(N, D, S) : shift_group(SS, S) }, X < LB,
%     _penalty("shift_lb", PNL), _priority("shift_lb", PRI).

% % 各看護師 N，各シフト S の担当回数の上限制約
% :- shifts_hard_ub(N, SS, UB), not { assigned(N, D, S) : shift_group(SS, S) } UB, not soft_all.

% penalty(shifts_soft_ub(N, SS, UB, X), num_shifts(N, SS), PNL * (X - UB) * (X - UB), PRI) :-
%     shifts_soft_ub(N, SS, UB), X = { assigned(N, D, S) : shift_group(SS, S) }, UB < X,
%     _penalty("shift_ub", PNL), _priority("shift_ub", PRI).

% % 各看護師 N，シフト N, J の担当回数の同一に
% :- staff(N), not 0 #sum{ 1, D : assigned(N, D, "N") ; -1, D : assigned(N, D, "J") } 0, not soft_all.

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 連続勤務回数に関する制約
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % フル勤務の期間
% full_work_period(N, BD, ED) :-
%     consecutive_work_ub(UB), base_date(BD), ED=BD+UB-1, base_date(ED),
%     first_date(FD), FD-1 <= ED,  % フル勤務最終日は，前月末以降（前月に違反連続勤務がある場合は無視したい）
%     staff(N), % not ext_assigned(N, BD-1),
%     ext_assigned(N, D) : D = BD..ED.

% % 連続勤務回数を超えてはならない
% :- full_work_period(N, BD, ED), ext_assigned(N, ED+1), not soft_all.

% % フル連続勤務の最終日に翌日勤務があるシフトをいれない
% :- full_work_period(N, BD, ED), ext_assigned(N, ED, S), consecutive_working_shift(S), not soft_all.

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 週末休暇に関する制約
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% reward(weekend_offs(N, X), staff(N), RWD * (PAST_MAX + 4 - X), PRI) :-
%     staff(N),
%     0 < { date(D, "日") : ext_assigned(N, D, S2), ext_assigned(N, D-1, S1), regular_holiday_shift(S1), regular_holiday_shift(S2) },
%     num_past_weekend_offs(N, X),
%     max_past_weekend_offs(PAST_MAX),
%     _reward("weekend_offs", RWD), _priority("weekend_offs", PRI).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 連休に関する制約
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% reward(consecutive_holidays(N, X), staff(N), RWD * (PAST_MAX + 4 - X), PRI) :-
%     staff(N),
%     0 < { ext_assigned(N, D-2) : ext_regular_holiday_off(N, D-1), ext_regular_holiday_off(N, D), date(D) },
%     num_past_consecutive_holidays(N, X),
%     max_past_consecutive_holidays(PAST_MAX),
%     _reward("consecutive_holidays", RWD), _priority("consecutive_holidays", PRI).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 祝日休に関する制約
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% reward(national_holiday_offs(N, X), staff(N), RWD * (PAST_MAX + CURR_MAX - X), PRI) :-
%     staff(N),
%     0 < { national_holiday_off(N, _) },
%     num_past_national_holiday_offs(N, X),
%     max_past_national_holiday_offs(PAST_MAX),
%     num_national_holidays(CURR_MAX),
%     _reward("national_holiday_off", RWD), _priority("national_holiday_off", PRI).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 禁止シフトパターンに関する制約
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % 看護師数 * 日数 * パターン数
% pattern_occured(PID, N, D, D+LEN-1) :-
%     pattern(PID, LEN), staff(N), base_date(D),
%     ext_assigned(N, D + IDX, S) : pattern(PID, IDX, S), not regular_holiday_shift(S) ;
%     ext_regular_holiday_off(N, D + IDX) : pattern(PID, IDX, "○").

% % パターンが希望シフトによるものかどうか
% requested_pattern(PID, N, BD, ED) :-
%     pattern_occured(PID, N, BD, ED),
%     staff_request(N, BD + IDX, S) : pattern(PID, IDX, S), not regular_holiday_shift(S) ;
%     staff_request(N, BD + IDX, ("○";"◎")) : pattern(PID, IDX, "○").

% % 禁止パターンが出現してはならない（希望シフトによるものを除く）
% :- forbidden_pattern(PID), pattern_occured(PID, N, BD, ED), not requested_pattern(PID, N, BD, ED), date((BD;ED)), not soft_all.

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 孤立した勤務日を抑制する
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% isolated_working_day(N, D+1) :-
%     staff(N), date(D+2),
%     ext_valid_holiday_off(N, D+2),
%     ext_assigned(N, D+1),
%     ext_valid_holiday_off(N, D).

% penalty(isolated_working_day(N, FD), table(N, D), PNL, PRI) :-
%     isolated_working_day(N, D), date2fulldate(D, FD), not allow_isolated_working_day,
%     _penalty("isolated_working_day", PNL), _priority("isolated_working_day", PRI).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 前日・翌日可能シフトに関する制約
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % 前日に出現不可なシフト
% prev_base_shift(S) :- prev_shift(_, S).

% :- hard_prev_shift(S), not soft_all,
%     prev_base_shift(S), ext_assigned(N, D, S),
%     first_date(FD), last_date(LD), FD <= D, D <= LD+1,  % 当月頭から翌月頭までが対象
%     not 1 { ext_assigned(N, D-1, PS) : prev_shift(PS, S), not valid_holiday_shift(PS) ;
%             valid_holiday_off(N, D-1) : prev_shift("○", S) } 1.

% penalty(prev_shift(N, DD, S), table(N, D), PNL, PRI) :-
%     not hard_prev_shift(S), prev_base_shift(S), ext_assigned(N, D, S),
%     first_date(FD), last_date(LD), FD <= D, D <= LD+1, date2fulldate(D, DD), % 当月頭から翌月頭までが対象
%     not 1 { ext_assigned(N, D-1, PS) : prev_shift(PS, S), not valid_holiday_shift(PS) ;
%             valid_holiday_off(N, D-1) : prev_shift("○", S) } 1,
%     _penalty("invalid_patterns", PNL), _priority("invalid_patterns", PRI).

% % 翌日に出現不可なシフト
% next_base_shift(S) :- next_shift(S, _).

% :- hard_next_shift(S), not soft_all,
%     next_base_shift(S), ext_assigned(N, D, S),
%     first_date(FD), last_date(LD), FD-1 <= D, D <= LD,  % 前月末から当月末までが対象
%     not 1 { ext_assigned(N, D+1, SS) : next_shift(S, SS), not valid_holiday_shift(SS) ;
%             valid_holiday_off(N, D+1) : next_shift(S, "○") ;
%             not staff_request(N, D+1) : last_date(D) } 1.

% penalty(next_shift(N, DD, S), table(N, D), PNL, PRI) :-
%     not hard_next_shift(S), next_base_shift(S), ext_assigned(N, D, S),
%     first_date(FD), last_date(LD), FD-1 <= D, D <= LD,  date2fulldate(D, DD), % 前月末から当月末までが対象
%     not 1 { ext_assigned(N, D+1, SS) : next_shift(S, SS), not valid_holiday_shift(SS) ;
%             valid_holiday_off(N, D+1) : next_shift(S, "○") ;
%             not staff_request(N, D+1) : last_date(D) } 1,
%     _penalty("invalid_patterns", PNL), _priority("invalid_patterns", PRI).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % パターン割当数の最小・最大値
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% :- patterns_hard_lb(PS, LB), staff(N), not soft_all,
%     not LB { pattern_occured(P, N, BD, ED) : patterns(PS, P), date(ED) }.  % 今月に終わるパターンの頻度を数える

% penalty(patterns_soft_lb(N, PS, LB, X), staff(N), PNL * (LB - X) * (LB - X), PRI) :-
%     patterns_soft_lb(PS, LB), staff(N),
%     X = { pattern_occured(P, N, BD, ED) : patterns(PS, P), date(ED) }, X < LB,  % 今月に終わるパターンの頻度を数える
%     _penalty("patterns_lb", PNL), _priority("patterns_lb", PRI).

% :- patterns_hard_ub(PS, UB), staff(N), not soft_all,
%     not { pattern_occured(P, N, BD, ED) : patterns(PS, P), date(ED) } UB.  % 今月に終わるパターンの頻度を数える

% penalty(patterns_soft_ub(N, PS, UB, X), staff(N), PNL * (X - UB) * (X - UB), PRI) :-
%     patterns_soft_ub(PS, UB), staff(N),
%     X = { pattern_occured(P, N, BD, ED) : patterns(PS, P), date(ED) }, UB < X,  % 今月に終わるパターンの頻度を数える
%     _penalty("patterns_ub", PNL), _priority("patterns_ub", PRI).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % ソフト休暇に関する制約
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % ソフト休暇の出現期間
% requested_holidays_period(N, BD, ED) :-
%     staff(N), date(BD), date(ED), BD <= ED,
%     not staff_request(N, ((BD-1);(ED+1))),
%     %not staff_valid_holiday_request(N, BD-1),
%     %staff_valid_holiday_request(N, D) : D = BD..ED;  % 前処理（探索なし）なので基礎化しても大きく爆発しない
%     %not staff_valid_holiday_request(N, ED+1),
%     %1 { ext_assigned(N, D, S) : D = BD..ED, soft_holiday_shift(S) }.  % 少なくとも１つはソフト休暇（年，健）が含まれること（週休の希望の前後に週休は割り当てない）
%     not staff_soft_holiday_request(N, BD-1),
%     staff_soft_holiday_request(N, D) : D = BD..ED;  % 前処理（探索なし）なので基礎化しても大きく爆発しない
%     not staff_soft_holiday_request(N, ED+1).


% % 希望休暇の前後に週休を割り当てる基準となる連続休暇数（これ未満の連続休暇の前後に週休を割り当てる）
% def_adjacent_holiday_limit(28).
% _adjacent_holiday_limit(X) :- adjacent_holiday_limit(X).
% _adjacent_holiday_limit(X) :- not adjacent_holiday_limit(_), def_adjacent_holiday_limit(X).

% % ソフト休暇の前後のいずれかには週休を入れる
% :- hard_adjacent_holiday(N), not soft_all,
%     requested_holidays_period(N, BD, ED),
%     _adjacent_holiday_limit(LEN),
%     ED - BD + 1 < LEN,
%     ext_assigned(N, BD-1), ext_assigned(N, ED+1).

% penalty(adjacent_holiday(N, FBD, FED), table(N, BD), PNL, PRI) :-
%     requested_holidays_period(N, BD, ED),
%     _adjacent_holiday_limit(LEN),
%     ED - BD + 1 < LEN,
%     date2fulldate(BD, FBD), date2fulldate(ED, FED),
%     ext_assigned(N, BD-1), ext_assigned(N, ED+1),
%     _penalty("adjacent_holiday", PNL), _priority("adjacent_holiday", PRI).

% penalty(adjacent_working_day(N, FBD, FED), table(N, BD), PNL, PRI) :-
%     requested_holidays_period(N, BD, ED),
%     _adjacent_holiday_limit(LEN),
%     ED - BD + 1 >= LEN,
%     date2fulldate(BD, FBD), date2fulldate(ED, FED),
%     1 {regular_holiday_off(N, BD-1) ; regular_holiday_off(N, ED+1)},
%     _penalty("adjacent_holiday", PNL), _priority("adjacent_holiday", PRI).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 推奨ペアに関する制約（ペアには同じ夜勤シフトを割り当てる）
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% penalty(night_pair(N1, N2, X), staffs(N1, N2), PNL * (LB - X), PRI) :-
%     recommended_pair(N1, N2),
%     recommended_pair_lb(LB),
%     X = { date(D) : night_working_shift(S), assigned(N1, D, S), assigned(N2, D, S) },
%     X < LB,
%     _penalty("night_pair", PNL), _priority("night_pair", PRI).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 禁止ペアに関する制約
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % 禁止ペアは同じ夜勤勤務シフトを割り当てない
% :- forbidden_pair(N1, N2), night_working_shift(S),
%     assigned(N1, D, S), assigned(N2, D, S), not soft_all.

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 希望シフトに関する制約
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % ある勤務シフトを希望しているのに，別の勤務シフトが割り当てられていると矛盾
% :- hard_staff_request(N),
%     staff_request(N, D, REQ), ext_assigned(N, D, RES), REQ != RES, not soft_all.

% penalty(staff_request(N, FD, REQ, RES), table(N, D), PNL, PRI) :-
%     staff_request(N, D, REQ), date2fulldate(D, FD), ext_assigned(N, D, RES), REQ != RES,
%     _penalty("staff_request", PNL), _priority("staff_request", PRI).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 看護師ごとの希望シフト・不可シフトに関する制約
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % 希望シフト以外が割り当てられていると矛盾
% pos_request(N, D) :- pos_request(N, D, S).
% :- pos_request(N, D),
%     not 1 { ext_assigned(N, D, S) : pos_request(N, D, S) } 1, not soft_all.

% % 不可シフトが割り当てられていると矛盾
% % しばしば違反することがあるためソフト制約にする
% %:- neg_request(N, D, S), ext_assigned(N, D, S), not soft_all.

% % 不可シフトが割り当てられていると矛盾
% penalty(neg_request(N, FD, S), table(N, D), PNL, PRI) :-
%     neg_request(N, D, S), ext_assigned(N, D, S),
%     date2fulldate(D, FD),
%     _penalty("staff_request", PNL), _priority("staff_request", PRI).

% % ソフト版：シフト希望がない場合にネガティブシフトが割り当てられていると矛盾
% penalty(neg_def_request(N, FD, S), table(N, D), PNL, PRI) :-
%     neg_def_request(N, D, S), not staff_request(N, D), ext_assigned(N, D, S),
%     date2fulldate(D, FD),
%     _penalty("neg_def_request", PNL), _priority("neg_def_request", PRI).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Default penalties and priorities
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% penalty_type("working_dates").
% penalty_type("weekly_holidays").
% penalty_type("hard_holidays").
% penalty_type("business_dates").
% penalty_type("staff_lb";"staff_ub").
% penalty_type("staff_hard_lb";"staff_hard_ub").
% penalty_type("diff_nj_shifts").
% penalty_type("point_lb";"point_ub").
% penalty_type("point_hard_lb";"point_hard_ub").
% penalty_type("shift_lb";"shift_ub").
% penalty_type("shift_hard_lb";"shift_hard_ub").
% penalty_type("over_work_period").
% penalty_type("forbidden_pattern").
% penalty_type("isolated_working_day").
% penalty_type("isolated_weekly_holiday").
% penalty_type("invalid_patterns").
% penalty_type("invalid_hard_patterns").
% penalty_type("patterns_lb";"patterns_ub").
% penalty_type("patterns_hard_lb";"patterns_hard_ub").
% penalty_type("adjacent_holiday").
% penalty_type("night_pair").
% penalty_type("forbidden_night_pair").
% penalty_type("staff_request").
% penalty_type("pos_def_request").
% penalty_type("neg_def_request").

% reward_type("weekend_offs").
% reward_type("national_holiday_off").
% reward_type("consecutive_holidays").

% % UNSAT 原因追及用のため priority を最大に
% dbg_priority(10).
% priority("staff_hard_lb", P) :- dbg_priority(P).
% priority("staff_hard_ub", P) :- dbg_priority(P).
% priority("point_hard_lb", P) :- dbg_priority(P).
% priority("point_hard_ub", P) :- dbg_priority(P).
% priority("shift_hard_lb", P) :- dbg_priority(P).
% priority("shift_hard_ub", P) :- dbg_priority(P).
% priority("working_dates", P) :- dbg_priority(P).
% priority("weekly_holidays", P) :- dbg_priority(P).
% priority("hard_holidays", P) :- dbg_priority(P).
% priority("business_dates", P) :- dbg_priority(P).
% priority("diff_nj_shifts", P) :- dbg_priority(P).
% priority("invalid_hard_patterns", P) :- dbg_priority(P).
% priority("patterns_hard_lb", P) :- dbg_priority(P).
% priority("patterns_hard_ub", P) :- dbg_priority(P).
% priority("forbidden_pattern", P) :- dbg_priority(P).
% priority("forbidden_night_pair", P) :- dbg_priority(P).
% priority("pos_def_request", P) :- dbg_priority(P).

% % Actual penalties, rewards and priorites
% _penalty(T, 1) :- penalty_type(T), not penalty(T, _).
% _penalty(T, X) :- penalty(T, X).
% _reward(T, 1) :- reward_type(T), not reward(T, _).
% _reward(T, X) :- reward(T, X).
% _priority(T, 1) :- penalty_type(T), not priority(T, _).
% _priority(T, 1) :- reward_type(T), not priority(T, _).
% _priority(T, X) :- priority(T, X).

% % Priorites of staff_lb/ub depend on the group and shifts
% _staff_lb_priority(G, SS, 1) :- staff_group(G), shift_group(SS), not staff_lb_priority(G, SS, _).
% _staff_lb_priority(G, SS, P) :- staff_lb_priority(G, SS, P).
% _staff_ub_priority(G, SS, 1) :- staff_group(G), shift_group(SS), not staff_ub_priority(G, SS, _).
% _staff_ub_priority(G, SS, P) :- staff_ub_priority(G, SS, P).

% error(("multiple penaltes are defined for", T)) :- penalty_type(T), 1 < { _penalty(T, X) }.
% error(("multiple rewards are defined for", T)) :- reward_type(T), 1 < { _reward(T, X) }.
% error(("multiple priorities are defined for", T)) :- penalty_type(T), 1 < { _priority(T, X) }.
% error(("undefined penalty type:", T)) :- not penalty_type(T), penalty(T, _).
% error(("undefined reward type:", T)) :- not reward_type(T), reward(T, _).
% error(("undefined priority type:", T)) :- not penalty_type(T), not reward_type(T), priority(T, _).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 目的関数
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % ペナルティの総和を最小化
% #minimize { P@PRIORITY,CAUSE : penalty(CAUSE, LOCATION, P, PRIORITY) }.
% % リワードの総和を最大化
% #maximize { R@PRIORITY,CAUSE : reward(CAUSE, LOCATION, R, PRIORITY) }.

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 出力用
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % シフト表
% out_assigned(N, FD, S) :- ext_assigned(N, D, S), base_date(D, FD, W).
% out_assigned(N, FD) :- staff(N), base_date(_, FD, _), not out_assigned(N, FD, _).
% % 希望シフト・不可シフト
% out_pos_request(N, FD, S) :- staff_request(N, D, S), date2fulldate(D, FD).
% out_pos_request(N, FD, S) :- pos_request(N, D, S), date2fulldate(D, FD).
% out_neg_request(N, FD, S) :- neg_request(N, D, S), date2fulldate(D, FD).
% %out_request(N, FD, S) :- ext_assigned(N, D, S), next_date(D), date2fulldate(D, FD).  % 翌月の希望シフト
% % 日付
% out_date(FD, W)    :- base_date(D, FD, W), not national_holiday(D).
% out_date(FD, "祝") :- base_date(D, FD, W), national_holiday(D).

% % 統計量
% num_curr_weekend_offs(N, X) :-
%     staff(N),
%     X = { date(D, "日") : ext_assigned(N, D, S2), ext_assigned(N, D-1, S1), regular_holiday_shift(S1), regular_holiday_shift(S2) }.

% num_curr_national_holiday_offs(N, X) :-
%     staff(N),
%     X = { national_holiday_off(N, _) }.

% num_curr_consecutive_holidays(N, X) :-
%     staff(N),
%     X = { ext_assigned(N, D-2) : ext_regular_holiday_off(N, D-1), ext_regular_holiday_off(N, D), date(D) }.

% out_stats(num_weekend_offs(N, P, C, P+C)) :- num_past_weekend_offs(N, P), num_curr_weekend_offs(N, C).
% out_stats(num_national_holiday_offs(N, P, C, P+C)) :- num_past_national_holiday_offs(N, P), num_curr_national_holiday_offs(N, C).
% out_stats(num_consecutive_holidays(N, P, C, P+C)) :- num_past_consecutive_holidays(N, P), num_curr_consecutive_holidays(N, C).


% #show.

% % 勤務表生成に必須の情報
% #show out_assigned/3.
% #show out_assigned/2.
% #show out_pos_request/3.
% #show out_neg_request/3.
% #show out_date/2.
% #show out_stats/1.
% #show staff/5.
% #show staff_group/2.
% #show shift/1.
% #show horizontal_constraint_type/1.
% #show vertical_constraint_type/3.
% #show penalty/4.
% #show reward/4.
% #show error/1.
% #show shift_rel/2.
% #show shift_order/2.
*%