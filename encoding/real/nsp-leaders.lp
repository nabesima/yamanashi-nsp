%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Settings specific to nurse leaders
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --------------------------------------------------------------------
% Distribute LD and SE shifts evenly on Tuesdays throughout the year
% --------------------------------------------------------------------

% Number of past Tuesday LD and SE shift assignments
num_past_tue_shifts(N, X) :-
    staff(N),
    X = { shift_data(N, D, S) : past_date(D, _, "Tu"), S = ("LD";"SE") }.
% Max number of past Tuesday LD and SE shift assignments
max_past_tue_shifts(X) :-
    X = #max { Y : num_past_tue_shifts(N, Y), staff(N) }.

% Number of Tuesday LD and SE shift assignments in the current month
num_curr_tue_shifts(N, X) :-
    staff(N),
    X = { assigned(N, D, S) : date(D, "Tu"), S = ("LD";"SE")  }.

% Total for past and current month
num_tue_shifts(N, P, C, P+C) :-
    num_past_tue_shifts(N, P),
    num_curr_tue_shifts(N, C).

% Reward if Tuesday LD and SE shifts are assigned to nurses with fewer past consecutive rests
achievement(tue_shifts(N), PAST_MAX - PAST_OWN + 1) :-
    staff(N),
    num_curr_tue_shifts(N, X),
    X > 0,
    num_past_tue_shifts(N, PAST_OWN),
    max_past_tue_shifts(PAST_MAX).

% Cause and priority for the reward
cause_type(tue_shifts(N)) :- staff(N).
dep_priority(tue_shifts(N), 3) :- staff(N).

% --------------------------------------------------------------------
% LD and SE shifts on Tuesdays limited to at most one
% --------------------------------------------------------------------
violation(soft, tue_shifts_ub(N), 1, X) :-
    staff(N), num_curr_tue_shifts(N, X), X > 1.

% Cause and priority for the penalty
cause_type(tue_shifts_ub(N)) :- staff(N).
dep_priority(tue_shifts_ub(N), 3) :- staff(N).

% --------------------------------------------------------------------
% Weekend overlaps for each pair of nurse leaders limited to at most two
% --------------------------------------------------------------------
num_weekend_shifts(N1, N2, X) :-
    staff(N1),
    staff(N2),
    N1 < N2,
    X > 0,
    X = { assigned(N1, D, S1) :
            assigned(N2, D, S2),
            S1 = ("LD";"SE";"SN"),
            S2 = ("LD";"SE";"SN"),
            date(D, ("Sa";"Su")) }.

violation(soft, weekend_pair_ub(N1, N2), 2, X) :-
    num_weekend_shifts(N1, N2, X),
    X > 2.

% Cause and priority for the penalty
cause_type(weekend_pair_ub(N1, N2)) :- staff(N1), staff(N2), N1 < N2.
dep_priority(weekend_pair_ub(N1, N2), 3) :- staff(N1), staff(N2), N1 < N2.

% --------------------------------------------------------------------
% Ensure at least 13 days between LD-SE-SN shift assignments
% --------------------------------------------------------------------

% Number of SE assignments from day D to day D+12
se_shifts_within_period(N, D, X) :-
    staff(N),
    base_date(D),
    ext_assigned(N, D, "SE"),
    X = { ext_assigned(N, DD, "SE") :  D <= DD, DD <= D + 12 }.

violation(soft, se_short_interval(N, D)) :-
    se_shifts_within_period(N, D, X),
    X > 1.

% Cause and priority for the penalty
cause_type(se_short_interval(N, D)) :- staff(N), base_date(D).
dep_priority(se_short_interval(N, D), 3) :- staff(N), base_date(D).

%---------------------------------------------------------------------
% Priorities for soft constraints
%---------------------------------------------------------------------

% Nurse pos/neg requests are hard constraints but given high priority for relaxation
dep_priority(pos_request(N, D), 5) :- pos_request(N, D).
dep_priority(neg_request(N, D), 5) :- neg_request(N, D).

% Prioritize UB and LB for LD, SE, and SN shifts in all groups
dep_priority(staff_lb(NG, SG, D), 3) :-
    staff_lb(_, NG, SG, D, _),
    staff_group(NG),
    SG = ("LD";"SE";"SN").
dep_priority(staff_ub(NG, SG, D), 3) :-
    staff_ub(_, NG, SG, D, _),
    staff_group(NG),
    SG = ("LD";"SE";"SN").

    % Prioritize horizontal constraints
dep_priority(shift_lb(N, SG), 3) :-
    shift_lb(_, N, SG, _).
dep_priority(shift_ub(N, SG), 3) :-
    shift_ub(_, N, SG, _).

% Prioritize next/prev shift rules
dep_priority(next_shift(N, D, S), 2) :-
    staff(N), base_date(D), next_shift(_, S, _).
dep_priority(prev_shift(N, D, S), 2) :-
    staff(N), base_date(D), prev_shift(_, S, _).
