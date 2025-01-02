%----------------------------------------------------------------------
% Constraints for Leave Days With Weekly Rest
%----------------------------------------------------------------------

requested_leave_days(N, BD, ED) :-
    staff(N),
    BD <= ED,
    base_date(BD),
    base_date(ED),
    date(((BD-1);(ED+1))), % Either the start or end of the consecutive leave must fall within this month.
    not pos_request(N, BD-1),
    leave_request(N, D) : D = BD..ED ;
    not pos_request(N, ED+1).

% Max consecutive leave days that can have weekly rest assigned either at the beginning or the end.
adjacent_rest_days_lim(N) :- dep_adjacent_rest_days_lim(N), N != dummy.
adjacent_rest_days_lim(7) :- 0 { dep_adjacent_rest_days_lim(N) : date(N) } 0.
% Suppresses warnings when there are no dep_adjacent_rest_days_lim/1
dep_adjacent_rest_days_lim(dummy).

% Penalty if weekly rest is not assigned before or after consecutive leave
violation(soft, adjacent_rest_days(N, BD)) :-
    requested_leave_days(N, BD, ED),
    adjacent_rest_days_lim(LIM),
    ED - BD + 1 <= LIM,
    work_day(N, BD-1),
    work_day(N, ED+1).

% Definition of cause_type
cause_type(adjacent_rest_days(N, D)) :- staff(N), date(D).
