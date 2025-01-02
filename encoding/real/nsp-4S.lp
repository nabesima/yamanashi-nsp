%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Settings specific to 4S
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 4S allows six consecutive workdays but prefers a maximum of five.
consecutive_work_ub(soft, NG, 5) :- staff_group(NG).

% In 4S, SE (short evening) should follow LD (long day) or LM (late morning)
prev_shift(soft, "SE", "LD").
prev_shift(soft, "SE", "LM").

%---------------------------------------------------------------------
% Priorities for soft constraints
%---------------------------------------------------------------------

% Nurse pos/neg requests are hard constraints but given high priority for relaxation
dep_priority(pos_request(N, D), 5) :- pos_request(N, D).
dep_priority(neg_request(N, D), 5) :- neg_request(N, D).

% Prioritize UB and LB for LD, SE, and SN shifts in the All group
dep_priority(staff_lb(NG, SG, D), 4) :-
    staff_lb(_, NG, SG, D, _),
    NG = "All",
    SG = ("LD";"SE";"SN").
dep_priority(staff_ub(NG, SG, D), 4) :-
    staff_ub(_, NG, SG, D, _),
    NG = "All",
    SG = ("LD";"SE";"SN").

% Prioritize five consecutive workdays
dep_priority(consecutive_work_days(N, D), 3) :- staff(N), base_date(D).
% Prioritize next/prev shift rules
dep_priority(next_shift(N, D, S), 3) :-
    staff(N), base_date(D), next_shift(_, S, _).
dep_priority(prev_shift(N, D, S), 3) :-
    staff(N), base_date(D), prev_shift(_, S, _).
% Prioritize UB and LB for shift patterns
dep_priority(pattern_lb(N, PID), 3) :-
    staff(N), staff_group(NG, N), pattern_lb(_, PID, NG, _).
dep_priority(pattern_ub(N, PID), 3) :-
    staff(N), staff_group(NG, N), pattern_ub(_, PID, NG, _).

% Prioritize vertical and horizontal constraints
dep_priority(staff_lb(NG, SG, D), 2) :-
    staff_lb(_, NG, SG, D, _).
dep_priority(staff_ub(NG, SG, D), 2) :-
    staff_ub(_, NG, SG, D, _).
dep_priority(shift_lb(N, SG), 2) :-
    shift_lb(_, N, SG, _).
dep_priority(shift_ub(N, SG), 2) :-
    shift_ub(_, N, SG, _).
