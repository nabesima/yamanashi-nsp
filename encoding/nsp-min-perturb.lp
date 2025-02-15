% Reproduce the assignment if there are fixed shift requests.
:- fixed(ext_assigned(N, D, S1)), ext_assigned(N, D, S2), S1 != S2.

#const mp_priority=2.
#minimize { 1@mp_priority,N,D,S : ext_assigned(N, D, S), not legacy(ext_assigned(N, D, S)) }.
