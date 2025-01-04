%----------------------------------------------------------------------
% Constraints on Isolated Work Days
%----------------------------------------------------------------------
isolated_work_day(N, D+1) :-
    staff(N),
    date(D+2),
    rest_day(N, D+2),
    work_day(N, D+1),
    rest_day(N, D+0).

% Penalty for isolated workdays
violation(soft, isolated_work_day(N, D)) :-
    isolated_work_day(N, D).

% Definition of cause_type
cause_type(isolated_work_day(N, D)) :- staff(N), date(D).
