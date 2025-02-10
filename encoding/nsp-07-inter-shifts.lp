%----------------------------------------------------------------------
% H9, S5: Constraints on Inter-Shift Relationships
%----------------------------------------------------------------------

% Assuming that next_shift(hard, S, _) and next_shift(soft, S, _) are mutually exclusive
% and cannot both be defined for the same shift S
violation(T, next_shift(N, D, S)) :-
    ext_assigned(N, D, S),
    next_shift(T, S, _),
    first_date(FD),
    last_date(LD),
    FD - 1 <= D, D <= LD,
    not 1 { ext_assigned(N, D+1, NS) : next_shift(T, S, NS), not non_work_shift(NS) ;
            ext_assigned(N, D+1, NS) : next_shift(T, S, "WR"), non_work_shift(NS);
            not ext_assigned(N, D+1, _) : last_date(D) } 1.  % If nurse N has no assignment on D+1, any next shift can be assigned.

% Assuming that prev_shift(hard, S, _) and prev_shift(soft, S, _) are mutually exclusive
% and cannot both be defined for the same shift S
violation(T, prev_shift(N, D, S)) :-
    ext_assigned(N, D, S),
    prev_shift(T, S, _),
    first_date(FD),
    last_date(LD),
    FD <= D, D <= LD + 1,
    not 1 { ext_assigned(N, D-1, PS) : prev_shift(T, S, PS), not non_work_shift(PS) ;
            ext_assigned(N, D-1, PS) : prev_shift(T, S, "WR"), non_work_shift(PS) ;
            not ext_assigned(N, D-1, _) : first_date(D) } 1.  % If nurse N has no assignment on D-1, any previous shift can be assigned.

% Definition of cause_type
cause_type(next_shift(N, D, S)) :- staff(N), base_date(D), next_shift(_, S, _).
cause_type(prev_shift(N, D, S)) :- staff(N), base_date(D), prev_shift(_, S, _).
