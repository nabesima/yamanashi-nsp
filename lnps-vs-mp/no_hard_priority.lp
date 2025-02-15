no_hard_priority.

% All priorities have been uniformly set to 2.
dep_priority(C, 2) :- cause_type(C).
