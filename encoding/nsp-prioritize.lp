% Prioritize reproducing past assigned/2 and assigned/3 assignments.
#heuristic assigned(N, D) : prioritized(assigned(N, D)). [1, true]
#heuristic assigned(N, D, S) : prioritized(assigned(N, D, S)). [1, true]
#heuristic ext_assigned(N, D) : prioritized(ext_assigned(N, D, S)), not work_shift(S). [1, true]

% Reproduce the assignment if there are fixed shift requests.
:- fixed(ext_assigned(N, D, S1)), ext_assigned(N, D, S2), S1 != S2.

% Suppresses warnings when there are no legacy and fixed data
% legacy(assigned(dummy, dummy, dummy)).
% fixed(ext_assigned(dummy, dummy, dummy)).