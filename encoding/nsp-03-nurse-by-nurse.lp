%----------------------------------------------------------------------
% H7, S3: Constraints on Nurse-by-Nurse Shift Assignments
%----------------------------------------------------------------------

% Assigns LB or more shifts
violation(T, shift_lb(N, SG), LB, X) :-
    shift_lb(T, N, SG, LB),
    X = { assigned(N, D, S) : shift_group(SG, S) },
    X < LB.

% Assigns UB or less shifts
violation(T, shift_ub(N, SG), UB, X) :-
    shift_ub(T, N, SG, UB),
    X = { assigned(N, D, S) : shift_group(SG, S) },
    UB < X.

%----------------------------------------------------------------------
% H4:: Constraints on Average Working Hours
%----------------------------------------------------------------------
% Ensure equal assignment of shift LD, SE
violation(hard, eq_shifts(N)) :-
    staff(N),
    not 0 #sum{  1, D : assigned(N, D, "LD") ;
                -1, D : assigned(N, D, "SE") } 0.

% Definition of cause_type
cause_type(shift_lb(N, SG)) :- shift_lb(_, N, SG, _).
cause_type(shift_ub(N, SG)) :- shift_ub(_, N, SG, _).
cause_type(eq_shifts(N)) :- staff(N).
