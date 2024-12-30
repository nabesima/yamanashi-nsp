%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Settings specific to ICU
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% In ICU, SE (short evening) should follow LD (long day) or LM (late morning)
prev_shift(soft, "SE", "LD").
prev_shift(soft, "SE", "LM").

% ICU allows six consecutive workdays but prefers a maximum of five.
consecutive_work_ub(soft, NG, 5) :- staff_group(NG).

% New hires are prohibited from working 6 consecutive days
consecutive_work_ub(hard, "New hires", 5).

%---------------------------------------------------------------------
% Equalize the number of night shifts for new hires
%---------------------------------------------------------------------

% Number of night shifts for each new hire N
num_night_shifts(N, X) :-
    staff(N),
    staff_group("New hires", N),
    X = { assigned(N, D, S) : S = ("SE";"SN"), date(D) }.

violation(soft, unequal_night_shifts(N1, N2)) :-
    num_night_shifts(N1, X1),
    num_night_shifts(N2, X2),
    N1 != N2, X1 != X2.

% Cause and priority for the penalty
cause_type(unequal_night_shifts(N1, N2)) :-
    staff(N1), staff_group("New hires", N1),
    staff(N2), staff_group("New hires", N2),
    N1 != N2.
dep_priority(unequal_night_shifts(N1, N2), 3) :-
    staff(N1), staff_group("New hires", N1),
    staff(N2), staff_group("New hires", N2),
    N1 != N2.

%---------------------------------------------------------------------
% New hires are prohibited from having the shift pattern SE-SN-SE-SN.
%---------------------------------------------------------------------

pattern_soft_ub("SE-SN-SE-SN", "New hires", 0).

%---------------------------------------------------------------------
% Restrict long-term leave.
%---------------------------------------------------------------------

% Prohibit 8 consecutive non work days that include weekly rest or public holidays.
violation(soft, non_work_days_ub(N, BD)) :-
    staff(N),
    base_date(BD),
    ED = BD + 7,
    date(((BD-1);(ED+1))), % Either the start or end of the consecutive leave must fall within this month.
    non_work_day(N, D) : D = BD..ED ;
    1 { rest_day(N, D) : D = BD..ED }.

% Cause and priority for the penalty
cause_type(non_work_days_ub(N, D)) :- staff(N), base_date(D).
dep_priority(non_work_days_ub(N, D), 3) :- staff(N), base_date(D).

%---------------------------------------------------------------------
% Maximum consecutive leave days that can have weekly rest days either at the beginning or the end.
%---------------------------------------------------------------------
dep_adjacent_rest_days_lim(3).

%---------------------------------------------------------------------
% Priorities for soft constraints
%---------------------------------------------------------------------

% Nurse pos/neg requests are hard constraints but given high priority for relaxation
dep_priority(pos_request(N, D), 7) :- pos_request(N, D).
dep_priority(neg_request(N, D), 6) :- neg_request(N, D).

% Prioritize the consecutive work days constraint.
dep_priority(consecutive_work_days(N, D), 5) :- staff(N), base_date(D).

% Prioritize the UB constraint on the number of pattern assignments.
dep_priority(pattern_ub(N, PID), 4) :-
    staff(N), staff_group(NG, N), pattern_ub(_, PID, NG, _).

% Prioritize the constraint on the number of staffs for junmiors or above
dep_priority(staff_lb("Juniors+", SG, D), 4) :- staff_lb(_, "Juniors+", SG, D, _).
dep_priority(staff_ub("Juniors+", SG, D), 4) :- staff_ub(_, "Juniors+", SG, D, _).

% Prioritize the constraint on the number of staffs for other groups
dep_priority(staff_lb(NG, SG, D), 3) :-
    staff_lb(_, NG, SG, D, _),
    NG != "Juniors+".

% Prioritize the constraint on the number of shift assignment
dep_priority(shift_lb(N, SG), 2) :- shift_lb(_, N, SG, _).
dep_priority(shift_ub(N, SG), 2) :- shift_ub(_, N, SG, _).
