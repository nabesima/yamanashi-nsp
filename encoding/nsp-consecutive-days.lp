%----------------------------------------------------------------------
% Constraints on Consecutive Working Days
%----------------------------------------------------------------------

% Enumerate full consecutive work periods for each nurse
% The last day of the consecutive work period must be after the previous month's end.
% (this is to avoid consecutive work violations in the manual shift table for the previous month).
full_work_period(N, BD, ED) :-
    consecutive_work_ub(_, NG, UB),
    staff(N),
    staff_group(NG, N),
    base_date(BD), ED=BD+UB-1, base_date(ED), -1 <= ED,
    work_day(N, D) : D = BD..ED.

% Each nurse must not exceed the full consecutive working days.
violation(T, consecutive_work_days(N, BD), UB, UB+1) :-
    consecutive_work_ub(T, NG, UB),
    staff_group(NG, N),
    full_work_period(N, BD, ED),
    work_day(N, ED+1).

% A shift requiring next-day work is not assigned on the last day of a full consecutive period.
violation(T, consecutive_work_days(N, BD), UB, UB+1) :-
    consecutive_work_ub(T, NG, UB),
    staff_group(NG, N),
    full_work_period(N, BD, ED),
    ext_assigned(N, ED, S),
    has_next_work_day(S).

has_next_work_day(S) :-
    next_shift(hard, S, _),
    work_shift(NS) : next_shift(hard, S, NS).

% Definition of cause_type
cause_type(consecutive_work_days(N, D)) :- staff(N), base_date(D).
