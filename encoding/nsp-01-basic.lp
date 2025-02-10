%----------------------------------------------------------------------
% H1: Constraints on Workable Days
%----------------------------------------------------------------------

% A nurse can work on a workable day
{ assigned(N, D) : workable_date(N, D) } :- staff(N).

%----------------------------------------------------------------------
% H1: Constraints on Work Days and Shift Assignments
%----------------------------------------------------------------------

% A nurse must work at least LB days
violation(hard, work_days_lb(N), LB, X) :-
    staff(N), work_days_bounds(N, LB, UB),
    X = { assigned(N, D) },
    X < LB.
% A nurse must work at most UB days
violation(hard, work_days_ub(N), UB, X) :-
    staff(N), work_days_bounds(N, LB, UB),
    X = { assigned(N, D) },
    UB < X.

% assigned/2 has exactly one work shift
1 { assigned(N, D, S) : work_shift(S) } 1 :- assigned(N, D).

% Definition of cause_type
cause_type(work_days_lb(N)) :- staff(N).
cause_type(work_days_ub(N)) :- staff(N).

%----------------------------------------------------------------------
% H2: Constraints on Weekly Rest Assignments
%----------------------------------------------------------------------

% Do not assigns shifts within the weekly rest days (Required because work days
% + weekly rest days != width when there are public holidays or requested
% leaves)
violation(hard, weekly_rest_lb(N), LB, X) :-
    weekly_rest_bounds(N, LB, UB),
    X = { not assigned(N, D) : weekly_rest_available_date(N, D) },
    X < LB.
violation(hard, weekly_rest_ub(N), UB, X) :-
    weekly_rest_bounds(N, LB, UB),
    X = { not assigned(N, D) : weekly_rest_available_date(N, D) },
    UB < X.

% Definition of cause_type
cause_type(weekly_rest_lb(N)) :- staff(N).
cause_type(weekly_rest_ub(N)) :- staff(N).

%----------------------------------------------------------------------
% Auxiliary predicates
%----------------------------------------------------------------------

% Extends 'assigned/3' to 'ext_assigned/3'
% - assigned/3 is defined only for work shifts.
% - ext_assigned/3 applies to all shifts.
ext_assigned(N, D, S) :- assigned(N, D, S).
ext_assigned(N, D, "WR") :- not assigned(N, D), weekly_rest_available_date(N, D).
ext_assigned(N, D, "PH") :- not assigned(N, D), public_holiday_available_date(N, D).
1 { ext_assigned(N, D, S) : manual_request(N, D, S) } 1 :- not assigned(N, D), manual_request(N, D).

% work_day/2 represents working days
work_day(N, D) :- ext_assigned(N, D, S), work_shift(S).
work_day(N, D) :- ext_assigned(N, D, S), business_shift(S).
% rest_day/2 represents rest days
rest_day(N, D) :- ext_assigned(N, D, S), rest_shift(S).
% leave_day/2 represents leave days
leave_day(N, D) :- ext_assigned(N, D, S), leave_shift(S).
% non_work_day/2 represents rest or leave days
non_work_day(N, D) :- rest_day(N, D).
non_work_day(N, D) :- leave_day(N, D).

%----------------------------------------------------------------------
% Hard constraints
%----------------------------------------------------------------------
:- violation(hard, _, _, _), not soften_hard.
:- violation(hard, _), not soften_hard.

% soften_hard is controlled by the nspsolver.
{ soften_hard }.

% Suppresses warnings when there are no violation constraints
violation(dummy, dummy).

%----------------------------------------------------------------------
% Penalty
%----------------------------------------------------------------------
penalty(TYPE, CAUSE, LIM, VAL, W, P) :-
    violation(TYPE, CAUSE, LIM, VAL),
    W = (LIM - VAL) * (LIM - VAL),
    priority(TYPE, CAUSE, P).
penalty(TYPE, CAUSE, 0, 0, 1, P) :-
    violation(TYPE, CAUSE),
    priority(TYPE, CAUSE, P).

% for obj function
penalty(TYPE, CAUSE, W, P) :- penalty(TYPE, CAUSE, _, _, W, P).

%----------------------------------------------------------------------
% Reward
%----------------------------------------------------------------------
reward(CAUSE, W, P) :-
    achievement(CAUSE, W),
    priority(CAUSE, P).

% Suppresses warnings when there are no achievement constraints
achievement(dummy, dummy).

%----------------------------------------------------------------------
% Priority of penalty and reward
%----------------------------------------------------------------------
% if there is no department-specific priority, use the defualt priority
%% for violations
priority(soft, C, 1) :- cause_type(C), not dep_priority(C, _).
priority(soft, C, P) :- dep_priority(C, P).
priority(hard, C, 10) :- cause_type(C), not dep_priority(C, _).
% Assign priorities to relaxed hard constraints based on soft constraint priorities
priority(hard, C, P) :- cause_type(C), dep_priority(C, Q), P = 10 + Q - 1.
%% for achivements
priority(C, 1) :- cause_type(C), not dep_priority(C, _).
priority(C, P) :- dep_priority(C, P).

%----------------------------------------------------------------------
% Objective functions
%----------------------------------------------------------------------
% Minimize the total penalty in lexicographic order
#minimize { WEGIHT@PRIORITY,TYPE,CAUSE : penalty(TYPE, CAUSE, WEGIHT, PRIORITY) }.
% Maxmize the total reward in lexicographic order
#maximize { WEGIHT@PRIORITY,CAUSE : reward(CAUSE, WEGIHT, PRIORITY) }.

%----------------------------------------------------------------------
% Output related
%----------------------------------------------------------------------
% Date
out_date(D, FD, W)    :- base_date(D, FD, W), not public_holiday(D).
out_date(D, FD, "PH") :- base_date(D, FD, W), public_holiday(D).
