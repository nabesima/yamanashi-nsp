#const mp_priority=3.
% #minimize { 1@mp_priority,N,D,S : prioritized(ext_assigned(N, D, S)), not ext_assigned(N, D, S) }.
#minimize { X@mp_priority : changed_shifts(X) }.
