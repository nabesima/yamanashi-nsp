%----------------------------------------------------------------------
% H8, S4: Constraints on Shift Patterns
%----------------------------------------------------------------------

pattern_occured(PID, N, D, D+LEN-1) :-
    pattern(PID, LEN), staff(N), base_date(D),
    ext_assigned(N, D + IDX, S) : pattern(PID, IDX, S), not rest_shift(S) ;
    ext_assigned(N, D + IDX, ("WR";"PH")) : pattern(PID, IDX, "WR").

% Pattern assigned by the staff's request
requested_pattern(PID, N, BD, ED) :-
    pattern_occured(PID, N, BD, ED),
    pos_request(N, BD + IDX, S) : pattern(PID, IDX, S), not rest_shift(S) ;
    pos_request(N, BD + IDX, ("WR";"PH")) : pattern(PID, IDX, "WR").

% Violates the lower bound (LB) for pattern PID if occurrences (X) are less than LB.
violation(T, pattern_lb(N, PID), LB, X) :-
    pattern_lb(T, PID, NG, LB),
    staff(N),
    staff_group(NG, N),
    X = { pattern_occured(PID, N, BD, ED) : date(ED) },  % The last shift in the pattern must occur within this month.
    X < LB.

% Violates the upper bound (UB) for pattern PID if occurrences (X) exceed UB.
violation(T, pattern_ub(N, PID), UB, X) :-
    pattern_ub(T, PID, NG, UB),
    staff(N),
    staff_group(NG),
    X = { pattern_occured(PID, N, BD, ED) : date(ED) },   % The last shift in the pattern must occur within this month.
    UB < X.

% Forbidden shift patterns are allowed only if they are requested.
violation(hard, forbidden_pattern(N, BD, PID)) :-
    forbidden_pattern(PID),
    pattern_occured(PID, N, BD, ED),
    not requested_pattern(PID, N, BD, ED),
    date((BD;ED)).

% Definition of cause_type
cause_type(pattern_lb(N, PID)) :- staff(N), staff_group(NG, N), pattern_lb(_, PID, NG, _).
cause_type(pattern_ub(N, PID)) :- staff(N), staff_group(NG, N), pattern_ub(_, PID, NG, _).
cause_type(forbidden_pattern(N, D, PID)) :- staff(N), base_date(D), forbidden_pattern(PID).
