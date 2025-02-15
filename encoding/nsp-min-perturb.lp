% Reproduce the assignment if there are fixed shift requests.
:- fixed(ext_assigned(N, D, S1)), ext_assigned(N, D, S2), S1 != S2.

#minimize { 1@1,N,D,S : ext_assigned(N, D, S), not legacy(ext_assigned(N, D, S)) }.
