% Prioritize reproducing past assigned/2 and assigned/3 assignments.
#heuristic assigned(N, D, S) : legacy(assigned(N, D, S)), staff(N). [1, true]
#heuristic assigned(N, D) : legacy(assigned(N, D)), staff(N). [1, true]

% Reproduce the assignment if there are fixed shift requests.
:- fixed(assigned(N, D, S)), staff(N), work_shift(S), not assigned(N, D).
:- fixed(assigned(N, D, S1)), staff(N), ext_assigned(N, D, S2), S1 != S2.

% Suppresses warnings when there are no legacy and fixed data
legacy(assigned(dummy, dummy, dummy)).
fixed(assigned(dummy, dummy, dummy)).