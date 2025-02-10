%----------------------------------------------------------------------
% S9: Constraints for Equal Shift Distribution
%----------------------------------------------------------------------

num_curr_weekend_offs(N, X) :-
    staff(N),
    X = { date(D, "Su") : rest_day(N, D), rest_day(N, D-1) }.
num_weekend_offs(N, P, C, P+C) :-
    num_past_weekend_offs(N, P),
    num_curr_weekend_offs(N, C).

% Reward if weekend rest is assigned to nurses with fewer past weekend rests.
achievement(weekend_offs(N), PAST_MAX - PAST_OWN + 1) :-
    staff(N),
    num_curr_weekend_offs(N, X),
    X > 0,
    num_past_weekend_offs(N, PAST_OWN),
    max_past_weekend_offs(PAST_MAX).

num_curr_public_holiday_offs(N, X) :-
    staff(N),
    X = { ext_assigned(N, D, "PH") : date(D) }.
num_public_holiday_offs(N, P, C, P+C) :-
    num_past_public_holiday_offs(N, P),
    num_curr_public_holiday_offs(N, C).

% Reward if public holiday off is assigned to nurses with fewer past public holiday offs.
achievement(public_holiday_offs(N), PAST_MAX - PAST_OWN + 1) :-
    staff(N),
    num_curr_public_holiday_offs(N, X),
    X > 0,
    num_past_public_holiday_offs(N, PAST_OWN),
    max_past_public_holiday_offs(PAST_MAX).

num_curr_consecutive_rests(N, X) :-
    staff(N),
    X = { work_day(N, D) :
            rest_day(N, D+1),
            rest_day(N, D+2),
            date(D+2) ;
          not ext_assigned(N, D, _) :
            rest_day(N, D+1),
            rest_day(N, D+2),
            date(D+2) }.
num_consecutive_rests(N, P, C, P+C) :-
    num_past_consecutive_rests(N, P),
    num_curr_consecutive_rests(N, C).

% Reward if consecutive rests are assigned to nurses with fewer past consecutive rests
achievement(consecutive_rests(N), PAST_MAX - PAST_OWN + 1) :-
    staff(N),
    num_curr_consecutive_rests(N, X),
    X > 0,
    num_past_consecutive_rests(N, PAST_OWN),
    max_past_consecutive_rests(PAST_MAX).

% Definition of cause_type
cause_type(weekend_offs(N)) :- staff(N).
cause_type(public_holiday_offs(N)) :- staff(N).
cause_type(consecutive_rests(N)) :- staff(N).
