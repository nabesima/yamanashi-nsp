%----------------------------------------------------------------------
% Constraints on Day-by-Day Shift Assignments
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
violation(hard, staff_lb(NG, SG, D), LB, X) :-
    violation(hard_sp, staff_lb(NG, SG, D), LB, X),
    violation(hard_sp, point_lb(NG, SG, D), _, _).
violation(hard, point_lb(NG, SG, D), LB, X) :-
    violation(hard_sp, staff_lb(NG, SG, D), _, _),
    violation(hard_sp, point_lb(NG, SG, D), LB, X).

violation(hard, staff_ub(NG, SG, D), UB, X) :-
    violation(hard_sp, staff_ub(NG, SG, D), UB, X),
    violation(hard_sp, point_ub(NG, SG, D), _, _).
violation(hard, point_ub(NG, SG, D), UB, X) :-
    violation(hard_sp, staff_ub(NG, SG, D), _, _),
    violation(hard_sp, point_ub(NG, SG, D), UB, X).

% Definition of cause_type
cause_type(staff_lb(NG, SG, D)) :- staff_lb(_, NG, SG, D, _).
cause_type(staff_ub(NG, SG, D)) :- staff_ub(_, NG, SG, D, _).
cause_type(point_lb(NG, SG, D)) :- point_lb(_, NG, SG, D, _).
cause_type(point_ub(NG, SG, D)) :- point_ub(_, NG, SG, D, _).
