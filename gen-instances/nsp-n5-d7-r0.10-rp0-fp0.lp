% Staffs -----------------------------------------
staff(1, "Norma Fisher", "Nurse", "65125", 8).
staff(2, "Jorge Sullivan", "Nurse", "43936", 7).
staff(3, "Elizabeth Woods", "Nurse", "73691", 6).
staff(4, "Susan Wagner", "Nurse", "49755", 5).
staff(5, "Peter Montgomery", "Nurse", "56930", 2).
% Staff groups -----------------------------------
staff_group("All").
staff_group("All", 1).
staff_group("All", 2).
staff_group("All", 3).
staff_group("All", 4).
staff_group("All", 5).
staff_group("Expert").
staff_group("Expert", 1).
staff_group("Expert", 2).
staff_group("Medium").
staff_group("Medium", 3).
staff_group("Medium", 4).
staff_group("Novice").
staff_group("Novice", 5).
% Dates ------------------------------------------
base_date(-7, 20250901, "Mo").
base_date(-6, 20250902, "Tu").
base_date(-5, 20250903, "We").
base_date(-4, 20250904, "Th").
base_date(-3, 20250905, "Fr").
base_date(-2, 20250906, "Sa").
base_date(-1, 20250907, "Su").
base_date(0, 20250908, "Mo").
base_date(1, 20250909, "Tu").
base_date(2, 20250910, "We").
base_date(3, 20250911, "Th").
base_date(4, 20250912, "Fr").
base_date(5, 20250913, "Sa").
base_date(6, 20250914, "Su").
base_date(7, 20250915, "Mo").
base_date(8, 20250916, "Tu").
base_date(9, 20250917, "We").
base_date(10, 20250918, "Th").
base_date(11, 20250919, "Fr").
base_date(12, 20250920, "Sa").
base_date(13, 20250921, "Su").
% Previous month
prev_date(-7, "Mo").
prev_date(-6, "Tu").
prev_date(-5, "We").
prev_date(-4, "Th").
prev_date(-3, "Fr").
prev_date(-2, "Sa").
prev_date(-1, "Su").
% This month
date(0, "Mo").
date(1, "Tu").
date(2, "We").
date(3, "Th").
date(4, "Fr").
date(5, "Sa").
date(6, "Su").
% Next month
next_date(7, "Mo").
next_date(8, "Tu").
next_date(9, "We").
next_date(10, "Th").
next_date(11, "Fr").
next_date(12, "Sa").
next_date(13, "Su").
% Public holidays
public_holiday(7).
% Shift groups -----------------------------------
shift_group("LD").
shift_group("LD", "LD").
shift_group("SE").
shift_group("SE", "SE").
shift_group("SN").
shift_group("SN", "SN").
shift_group("E").
shift_group("E", "E").
shift_group("N").
shift_group("N", "N").
shift_group("EM").
shift_group("EM", "EM").
shift_group("LM").
shift_group("LM", "LM").
shift_group("D").
shift_group("D", "D").
shift_group("LD+LM").
shift_group("LD+LM", "LD").
shift_group("LD+LM", "LM").
% Horizontal constraints -------------------------
shifts_soft_lb(1, "LD", 1).
shifts_soft_ub(1, "LD", 2).
shifts_soft_lb(1, "SE", 1).
shifts_soft_ub(1, "SE", 2).
shifts_soft_lb(1, "SN", 1).
shifts_soft_ub(1, "SN", 2).
shifts_hard_ub(1, "E", 0).
shifts_hard_ub(1, "N", 0).
shifts_hard_ub(1, "EM", 0).
shifts_hard_ub(1, "LM", 1).
shifts_soft_lb(2, "LD", 1).
shifts_soft_ub(2, "LD", 2).
shifts_soft_lb(2, "SE", 1).
shifts_soft_ub(2, "SE", 2).
shifts_soft_lb(2, "SN", 1).
shifts_soft_ub(2, "SN", 2).
shifts_hard_ub(2, "E", 0).
shifts_hard_ub(2, "N", 0).
shifts_hard_ub(2, "EM", 0).
shifts_hard_ub(2, "LM", 1).
shifts_soft_lb(3, "LD", 1).
shifts_soft_ub(3, "LD", 2).
shifts_soft_lb(3, "SE", 1).
shifts_soft_ub(3, "SE", 2).
shifts_soft_lb(3, "SN", 1).
shifts_soft_ub(3, "SN", 2).
shifts_hard_ub(3, "E", 0).
shifts_hard_ub(3, "N", 0).
shifts_hard_ub(3, "EM", 0).
shifts_hard_ub(3, "LM", 1).
shifts_soft_lb(4, "LD", 1).
shifts_soft_ub(4, "LD", 2).
shifts_soft_lb(4, "SE", 1).
shifts_soft_ub(4, "SE", 2).
shifts_soft_lb(4, "SN", 1).
shifts_soft_ub(4, "SN", 2).
shifts_hard_ub(4, "E", 0).
shifts_hard_ub(4, "N", 0).
shifts_hard_ub(4, "EM", 0).
shifts_hard_ub(4, "LM", 1).
shifts_soft_lb(5, "LD", 0).
shifts_soft_ub(5, "LD", 1).
shifts_soft_lb(5, "SE", 0).
shifts_soft_ub(5, "SE", 1).
shifts_soft_lb(5, "SN", 0).
shifts_soft_ub(5, "SN", 1).
shifts_hard_ub(5, "E", 0).
shifts_hard_ub(5, "N", 0).
shifts_hard_ub(5, "EM", 0).
shifts_hard_ub(5, "LM", 1).
horizontal_constraint_type("LD").
horizontal_constraint_type("SE").
horizontal_constraint_type("SN").
horizontal_constraint_type("E").
horizontal_constraint_type("N").
horizontal_constraint_type("EM").
horizontal_constraint_type("LM").
% Vertical constraints ---------------------------
staff_dweek_hard_lb("All", "D", "Weekday", 1).
staff_dweek_soft_lb("All", "D", "Weekday", 1).
staff_dweek_soft_ub("All", "D", "Weekday", 2).
staff_dweek_soft_ub("All", "D", "Weekend", 1).
staff_dweek_soft_ub("All", "D", "Holiday", 1).
staff_dweek_soft_lb("All", "LD", "Weekday", 1).
staff_dweek_soft_ub("All", "LD", "Weekday", 1).
staff_dweek_soft_lb("All", "LD", "Weekend", 1).
staff_dweek_soft_ub("All", "LD", "Weekend", 1).
staff_dweek_soft_lb("All", "LD", "Holiday", 1).
staff_dweek_soft_ub("All", "LD", "Holiday", 1).
staff_dweek_soft_lb("All", "SE", "Weekday", 1).
staff_dweek_soft_ub("All", "SE", "Weekday", 1).
staff_dweek_soft_lb("All", "SE", "Weekend", 1).
staff_dweek_soft_ub("All", "SE", "Weekend", 1).
staff_dweek_soft_lb("All", "SE", "Holiday", 1).
staff_dweek_soft_ub("All", "SE", "Holiday", 1).
staff_dweek_soft_lb("All", "SN", "Weekday", 1).
staff_dweek_soft_ub("All", "SN", "Weekday", 1).
staff_dweek_soft_lb("All", "SN", "Weekend", 1).
staff_dweek_soft_ub("All", "SN", "Weekend", 1).
staff_dweek_soft_lb("All", "SN", "Holiday", 1).
staff_dweek_soft_ub("All", "SN", "Holiday", 1).
staff_dweek_soft_ub("All", "LD+LM", "Weekday", 1).
staff_dweek_soft_ub("All", "LD+LM", "Weekend", 1).
staff_dweek_soft_ub("All", "LD+LM", "Holiday", 1).
staff_dweek_soft_ub("Expert", "LD", "Weekday", 1).
staff_dweek_soft_ub("Expert", "LD", "Weekend", 1).
staff_dweek_soft_ub("Expert", "LD", "Holiday", 1).
staff_dweek_soft_ub("Expert", "SE", "Weekday", 1).
staff_dweek_soft_ub("Expert", "SE", "Weekend", 1).
staff_dweek_soft_ub("Expert", "SE", "Holiday", 1).
staff_dweek_soft_ub("Expert", "SN", "Weekday", 1).
staff_dweek_soft_ub("Expert", "SN", "Weekend", 1).
staff_dweek_soft_ub("Expert", "SN", "Holiday", 1).
vertical_constraint_type("All", "D", "Staffs").
vertical_constraint_type("All", "LD", "Staffs").
vertical_constraint_type("All", "SE", "Staffs").
vertical_constraint_type("All", "SN", "Staffs").
vertical_constraint_type("All", "LD+LM", "Staffs").
vertical_constraint_type("Expert", "LD", "Staffs").
vertical_constraint_type("Expert", "SE", "Staffs").
vertical_constraint_type("Expert", "SN", "Staffs").
% Shift related constraints ----------------------
% Maximum consecutive working days
consecutive_work_ub(hard, "All", 5).
consecutive_work_ub(hard, "Expert", 5).
consecutive_work_ub(hard, "Medium", 5).
consecutive_work_ub(hard, "Novice", 5).
% Previous shifts
prev_shift(hard, "SN", "SE").
prev_shift(hard, "SE", "LD").
prev_shift(hard, "SE", "LM").
prev_shift(hard, "N", "E").
% Next shifts
next_shift(hard, "SN", "SE").
next_shift(hard, "SN", "WR").
next_shift(hard, "SE", "SN").
next_shift(hard, "E", "N").
next_shift(hard, "N", "WR").
% Shift patterns
pattern("LD-D", 2).
pattern("LD-D", 0, "LD").
pattern("LD-D", 1, "D").
pattern("LM-D", 2).
pattern("LM-D", 0, "LM").
pattern("LM-D", 1, "D").
pattern("LM-LD", 2).
pattern("LM-LD", 0, "LM").
pattern("LM-LD", 1, "LD").
pattern("LM-LM", 2).
pattern("LM-LM", 0, "LM").
pattern("LM-LM", 1, "LM").
pattern("LD-LD", 2).
pattern("LD-LD", 0, "LD").
pattern("LD-LD", 1, "LD").
pattern("SE-SN-SE-SN", 4).
pattern("SE-SN-SE-SN", 0, "SE").
pattern("SE-SN-SE-SN", 1, "SN").
pattern("SE-SN-SE-SN", 2, "SE").
pattern("SE-SN-SE-SN", 3, "SN").
% Pattern bounds
pattern_soft_ub("LD-D", "All", 1).
pattern_soft_ub("LD-D", "Expert", 1).
pattern_soft_ub("LD-D", "Medium", 1).
pattern_soft_ub("LD-D", "Novice", 1).
pattern_soft_ub("LM-D", "All", 0).
pattern_soft_ub("LM-D", "Expert", 0).
pattern_soft_ub("LM-D", "Medium", 0).
pattern_soft_ub("LM-D", "Novice", 0).
pattern_soft_ub("LM-LD", "All", 0).
pattern_soft_ub("LM-LD", "Expert", 0).
pattern_soft_ub("LM-LD", "Medium", 0).
pattern_soft_ub("LM-LD", "Novice", 0).
pattern_soft_ub("LM-LM", "All", 0).
pattern_soft_ub("LM-LM", "Expert", 0).
pattern_soft_ub("LM-LM", "Medium", 0).
pattern_soft_ub("LM-LM", "Novice", 0).
% Forbidden patterns
forbidden_pattern("LD-LD").
forbidden_pattern("SE-SN-SE-SN").
forbidden_pattern("LD-D").
forbidden_pattern("LM-LD").
forbidden_pattern("LM-D").
% Staff requests ---------------------------------
staff_neg_request(5, 3, "SN").
staff_neg_request(3, 2, "SE").
staff_pos_request(5, 12, "BT").
staff_neg_request(5, 11, "SN").
% Pairs ------------------------------------------
% Priorities -------------------------------------

% Nurse pos/neg requests are hard constraints but given high priority for relaxation
dep_priority(pos_request(N, D), 5) :- pos_request(N, D).
dep_priority(neg_request(N, D), 5) :- neg_request(N, D).

% Prioritize next/prev shift rules
dep_priority(next_shift(N, D, S), 4) :-
    staff(N), base_date(D), next_shift(_, S, _).
dep_priority(prev_shift(N, D, S), 4) :-
    staff(N), base_date(D), prev_shift(_, S, _).
% Prioritize UB and LB for shift patterns
dep_priority(pattern_lb(N, PID), 4) :-
    staff(N), staff_group(NG, N), pattern_lb(_, PID, NG, _).
dep_priority(pattern_ub(N, PID), 4) :-
    staff(N), staff_group(NG, N), pattern_ub(_, PID, NG, _).

% Prioritize vertical and horizontal constraints
dep_priority(staff_lb(NG, SG, D), 2) :-
    staff_lb(_, NG, SG, D, _).
dep_priority(staff_ub(NG, SG, D), 2) :-
    staff_ub(_, NG, SG, D, _).
dep_priority(shift_lb(N, SG), 2) :-
    shift_lb(_, N, SG, _).
dep_priority(shift_ub(N, SG), 2) :-
    shift_ub(_, N, SG, _).

% Past shift assignments -------------------------
shift_data("65125", "Norma Fisher", 20250901, "WR").
shift_data("43936", "Jorge Sullivan", 20250901, "LD").
shift_data("73691", "Elizabeth Woods", 20250901, "SN").
shift_data("49755", "Susan Wagner", 20250901, "D").
shift_data("56930", "Peter Montgomery", 20250901, "SE").
shift_data("65125", "Norma Fisher", 20250902, "D").
shift_data("43936", "Jorge Sullivan", 20250902, "SE").
shift_data("73691", "Elizabeth Woods", 20250902, "WR").
shift_data("49755", "Susan Wagner", 20250902, "LD").
shift_data("56930", "Peter Montgomery", 20250902, "SN").
shift_data("65125", "Norma Fisher", 20250903, "D").
shift_data("43936", "Jorge Sullivan", 20250903, "SN").
shift_data("73691", "Elizabeth Woods", 20250903, "WR").
shift_data("49755", "Susan Wagner", 20250903, "LM").
shift_data("56930", "Peter Montgomery", 20250903, "WR").
shift_data("65125", "Norma Fisher", 20250904, "LD").
shift_data("43936", "Jorge Sullivan", 20250904, "WR").
shift_data("73691", "Elizabeth Woods", 20250904, "D").
shift_data("49755", "Susan Wagner", 20250904, "SE").
shift_data("56930", "Peter Montgomery", 20250904, "WR").
shift_data("65125", "Norma Fisher", 20250905, "SE").
shift_data("43936", "Jorge Sullivan", 20250905, "WR").
shift_data("73691", "Elizabeth Woods", 20250905, "LD").
shift_data("49755", "Susan Wagner", 20250905, "SN").
shift_data("56930", "Peter Montgomery", 20250905, "D").
shift_data("65125", "Norma Fisher", 20250906, "SN").
shift_data("43936", "Jorge Sullivan", 20250906, "LD").
shift_data("73691", "Elizabeth Woods", 20250906, "SE").
shift_data("49755", "Susan Wagner", 20250906, "WR").
shift_data("56930", "Peter Montgomery", 20250906, "D").
shift_data("65125", "Norma Fisher", 20250907, "WR").
shift_data("43936", "Jorge Sullivan", 20250907, "SE").
shift_data("73691", "Elizabeth Woods", 20250907, "SN").
shift_data("49755", "Susan Wagner", 20250907, "WR").
shift_data("56930", "Peter Montgomery", 20250907, "LD").
% Past dates -------------------------------------
past_date(20250901, "Mo").
past_date(20250902, "Tu").
past_date(20250903, "We").
past_date(20250904, "Th").
past_date(20250905, "Fr").
past_date(20250906, "Sa").
past_date(20250907, "Su").
% Past public holidays
