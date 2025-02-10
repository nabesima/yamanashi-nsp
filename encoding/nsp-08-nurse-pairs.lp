%----------------------------------------------------------------------
% H10, S6: Constraints on Nurse Pairs
%----------------------------------------------------------------------

% Recommended night shift pairs must be assigned the same night shift at least the specified number of times.
violation(soft, recommended_night_pair(N1, N2), LB, X) :-
    staff(N1), staff(N2),
    recommended_night_pair(N1, N2, LB),
    X = { date(D) : night_work_shift(S), assigned(N1, D, S), assigned(N2, D, S) },
    X < LB.

% Forbidden night shift pairs must not share night shifts.
violation(hard, forbidden_night_pair(N1, N2, D)) :-
    staff(N1), staff(N2),
    forbidden_night_pair(N1, N2),
    night_work_shift(S),
    assigned(N1, D, S),
    assigned(N2, D, S).

% Suppresses warnings when there are no night pairs
recommended_night_pair(dummy, dummy, dummy).
forbidden_night_pair(dummy, dummy).

% Definition of cause_type
cause_type(recommended_night_pair(N1, N2)) :- recommended_night_pair(N1, N2, _).
cause_type(forbidden_night_pair(N1, N2, D)) :- forbidden_night_pair(N1, N2), date(D).
