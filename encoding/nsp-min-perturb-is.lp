% Prioritize reproducing past assigned/2 and assigned/3 assignments.
#const is_weight=1.
#heuristic ext_assigned(N, D, S) : prioritized(ext_assigned(N, D, S)). [is_weight, init]
#heuristic ext_assigned(N, D, S) : prioritized(ext_assigned(N, D, S)). [1, sign]

#const mp_priority=3.
% #minimize { 1@mp_priority,N,D,S : prioritized(ext_assigned(N, D, S)), not ext_assigned(N, D, S) }.
#minimize { X@mp_priority : changed_shifts(X) }.
