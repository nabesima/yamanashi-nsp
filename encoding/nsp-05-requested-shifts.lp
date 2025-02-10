%----------------------------------------------------------------------
% H3: Constraints on Requested Shifts
%----------------------------------------------------------------------

% positive requested shifts must be assigned
violation(hard, pos_request(N, D)) :-
    pos_request(N, D), date(D),
    not 1 { ext_assigned(N, D, S) : pos_request(N, D, S) } 1.

% negative requested shifts must not be assigned
violation(hard, neg_request(N, D)) :-
    neg_request(N, D), date(
        D),
    1 { ext_assigned(N, D, S) : neg_request(N, D, S) }.

% for next month, positive requested shifts must be assigned
1 { ext_assigned(N, D, S) : pos_request(N, D, S) } 1 :-
     pos_request(N, D), next_date(D).

% Definition of cause_type
cause_type(pos_request(N, D)) :- pos_request(N, D).
cause_type(neg_request(N, D)) :- neg_request(N, D).
