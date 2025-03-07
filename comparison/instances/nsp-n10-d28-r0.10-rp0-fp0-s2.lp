% Staffs -----------------------------------------
staff(1, "Theresa Brown", "Nurse", "22004", 7).
staff(2, "Russell Fitzgerald", "Nurse", "57324", 7).
staff(3, "Elizabeth Obrien", "Nurse", "97782", 7).
staff(4, "Lauren Moore", "Nurse", "42975", 5).
staff(5, "James Sharp", "Nurse", "37815", 6).
staff(6, "Tiffany Stephens MD", "Nurse", "14683", 6).
staff(7, "Andrew Johnson", "Nurse", "99292", 6).
staff(8, "Fernando James", "Nurse", "66448", 4).
staff(9, "Kelly Castro", "Nurse", "61581", 3).
staff(10, "Alexander Nguyen", "Nurse", "76724", 3).
% Staff groups -----------------------------------
staff_group("All").
staff_group("All", 1).
staff_group("All", 2).
staff_group("All", 3).
staff_group("All", 4).
staff_group("All", 5).
staff_group("All", 6).
staff_group("All", 7).
staff_group("All", 8).
staff_group("All", 9).
staff_group("All", 10).
staff_group("Expert").
staff_group("Expert", 1).
staff_group("Expert", 2).
staff_group("Expert", 3).
staff_group("Medium").
staff_group("Medium", 4).
staff_group("Medium", 5).
staff_group("Medium", 6).
staff_group("Medium", 7).
staff_group("Medium", 8).
staff_group("Novice").
staff_group("Novice", 9).
staff_group("Novice", 10).
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
base_date(14, 20250922, "Mo").
base_date(15, 20250923, "Tu").
base_date(16, 20250924, "We").
base_date(17, 20250925, "Th").
base_date(18, 20250926, "Fr").
base_date(19, 20250927, "Sa").
base_date(20, 20250928, "Su").
base_date(21, 20250929, "Mo").
base_date(22, 20250930, "Tu").
base_date(23, 20251001, "We").
base_date(24, 20251002, "Th").
base_date(25, 20251003, "Fr").
base_date(26, 20251004, "Sa").
base_date(27, 20251005, "Su").
base_date(28, 20251006, "Mo").
base_date(29, 20251007, "Tu").
base_date(30, 20251008, "We").
base_date(31, 20251009, "Th").
base_date(32, 20251010, "Fr").
base_date(33, 20251011, "Sa").
base_date(34, 20251012, "Su").
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
date(7, "Mo").
date(8, "Tu").
date(9, "We").
date(10, "Th").
date(11, "Fr").
date(12, "Sa").
date(13, "Su").
date(14, "Mo").
date(15, "Tu").
date(16, "We").
date(17, "Th").
date(18, "Fr").
date(19, "Sa").
date(20, "Su").
date(21, "Mo").
date(22, "Tu").
date(23, "We").
date(24, "Th").
date(25, "Fr").
date(26, "Sa").
date(27, "Su").
% Next month
next_date(28, "Mo").
next_date(29, "Tu").
next_date(30, "We").
next_date(31, "Th").
next_date(32, "Fr").
next_date(33, "Sa").
next_date(34, "Su").
% Public holidays
public_holiday(7).
public_holiday(15).
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
shifts_soft_lb(1, "LD", 4).
shifts_soft_ub(1, "LD", 8).
shifts_soft_lb(1, "SE", 4).
shifts_soft_ub(1, "SE", 8).
shifts_soft_lb(1, "SN", 4).
shifts_soft_ub(1, "SN", 8).
shifts_hard_ub(1, "E", 0).
shifts_hard_ub(1, "N", 0).
shifts_hard_ub(1, "EM", 0).
shifts_hard_ub(1, "LM", 1).
shifts_soft_lb(2, "LD", 4).
shifts_soft_ub(2, "LD", 8).
shifts_soft_lb(2, "SE", 4).
shifts_soft_ub(2, "SE", 8).
shifts_soft_lb(2, "SN", 4).
shifts_soft_ub(2, "SN", 8).
shifts_hard_ub(2, "E", 0).
shifts_hard_ub(2, "N", 0).
shifts_hard_ub(2, "EM", 0).
shifts_hard_ub(2, "LM", 1).
shifts_soft_lb(3, "LD", 4).
shifts_soft_ub(3, "LD", 8).
shifts_soft_lb(3, "SE", 4).
shifts_soft_ub(3, "SE", 8).
shifts_soft_lb(3, "SN", 4).
shifts_soft_ub(3, "SN", 8).
shifts_hard_ub(3, "E", 0).
shifts_hard_ub(3, "N", 0).
shifts_hard_ub(3, "EM", 0).
shifts_hard_ub(3, "LM", 1).
shifts_soft_lb(4, "LD", 4).
shifts_soft_ub(4, "LD", 8).
shifts_soft_lb(4, "SE", 4).
shifts_soft_ub(4, "SE", 8).
shifts_soft_lb(4, "SN", 4).
shifts_soft_ub(4, "SN", 8).
shifts_hard_ub(4, "E", 0).
shifts_hard_ub(4, "N", 0).
shifts_hard_ub(4, "EM", 0).
shifts_hard_ub(4, "LM", 1).
shifts_soft_lb(5, "LD", 4).
shifts_soft_ub(5, "LD", 8).
shifts_soft_lb(5, "SE", 4).
shifts_soft_ub(5, "SE", 8).
shifts_soft_lb(5, "SN", 4).
shifts_soft_ub(5, "SN", 8).
shifts_hard_ub(5, "E", 0).
shifts_hard_ub(5, "N", 0).
shifts_hard_ub(5, "EM", 0).
shifts_hard_ub(5, "LM", 1).
shifts_soft_lb(6, "LD", 4).
shifts_soft_ub(6, "LD", 8).
shifts_soft_lb(6, "SE", 4).
shifts_soft_ub(6, "SE", 8).
shifts_soft_lb(6, "SN", 4).
shifts_soft_ub(6, "SN", 8).
shifts_hard_ub(6, "E", 0).
shifts_hard_ub(6, "N", 0).
shifts_hard_ub(6, "EM", 0).
shifts_hard_ub(6, "LM", 1).
shifts_soft_lb(7, "LD", 4).
shifts_soft_ub(7, "LD", 8).
shifts_soft_lb(7, "SE", 4).
shifts_soft_ub(7, "SE", 8).
shifts_soft_lb(7, "SN", 4).
shifts_soft_ub(7, "SN", 8).
shifts_hard_ub(7, "E", 0).
shifts_hard_ub(7, "N", 0).
shifts_hard_ub(7, "EM", 0).
shifts_hard_ub(7, "LM", 1).
shifts_soft_lb(8, "LD", 4).
shifts_soft_ub(8, "LD", 8).
shifts_soft_lb(8, "SE", 4).
shifts_soft_ub(8, "SE", 8).
shifts_soft_lb(8, "SN", 4).
shifts_soft_ub(8, "SN", 8).
shifts_hard_ub(8, "E", 0).
shifts_hard_ub(8, "N", 0).
shifts_hard_ub(8, "EM", 0).
shifts_hard_ub(8, "LM", 1).
shifts_soft_lb(9, "LD", 2).
shifts_soft_ub(9, "LD", 4).
shifts_soft_lb(9, "SE", 2).
shifts_soft_ub(9, "SE", 4).
shifts_soft_lb(9, "SN", 2).
shifts_soft_ub(9, "SN", 4).
shifts_hard_ub(9, "E", 0).
shifts_hard_ub(9, "N", 0).
shifts_hard_ub(9, "EM", 0).
shifts_hard_ub(9, "LM", 1).
shifts_soft_lb(10, "LD", 2).
shifts_soft_ub(10, "LD", 4).
shifts_soft_lb(10, "SE", 2).
shifts_soft_ub(10, "SE", 4).
shifts_soft_lb(10, "SN", 2).
shifts_soft_ub(10, "SN", 4).
shifts_hard_ub(10, "E", 0).
shifts_hard_ub(10, "N", 0).
shifts_hard_ub(10, "EM", 0).
shifts_hard_ub(10, "LM", 1).
horizontal_constraint_type("LD").
horizontal_constraint_type("SE").
horizontal_constraint_type("SN").
horizontal_constraint_type("E").
horizontal_constraint_type("N").
horizontal_constraint_type("EM").
horizontal_constraint_type("LM").
% Vertical constraints ---------------------------
staff_dweek_hard_lb("All", "D", "Weekday", 2).
staff_dweek_soft_lb("All", "D", "Weekday", 2).
staff_dweek_soft_ub("All", "D", "Weekday", 5).
staff_dweek_soft_lb("All", "D", "Weekend", 1).
staff_dweek_soft_ub("All", "D", "Weekend", 2).
staff_dweek_soft_lb("All", "D", "Holiday", 1).
staff_dweek_soft_ub("All", "D", "Holiday", 2).
staff_dweek_hard_lb("All", "LD", "Weekday", 1).
staff_dweek_soft_lb("All", "LD", "Weekday", 2).
staff_dweek_soft_ub("All", "LD", "Weekday", 2).
staff_dweek_hard_lb("All", "LD", "Weekend", 1).
staff_dweek_soft_lb("All", "LD", "Weekend", 2).
staff_dweek_soft_ub("All", "LD", "Weekend", 2).
staff_dweek_hard_lb("All", "LD", "Holiday", 1).
staff_dweek_soft_lb("All", "LD", "Holiday", 2).
staff_dweek_soft_ub("All", "LD", "Holiday", 2).
staff_dweek_hard_lb("All", "SE", "Weekday", 1).
staff_dweek_soft_lb("All", "SE", "Weekday", 2).
staff_dweek_soft_ub("All", "SE", "Weekday", 2).
staff_dweek_hard_lb("All", "SE", "Weekend", 1).
staff_dweek_soft_lb("All", "SE", "Weekend", 2).
staff_dweek_soft_ub("All", "SE", "Weekend", 2).
staff_dweek_hard_lb("All", "SE", "Holiday", 1).
staff_dweek_soft_lb("All", "SE", "Holiday", 2).
staff_dweek_soft_ub("All", "SE", "Holiday", 2).
staff_dweek_hard_lb("All", "SN", "Weekday", 1).
staff_dweek_soft_lb("All", "SN", "Weekday", 2).
staff_dweek_soft_ub("All", "SN", "Weekday", 2).
staff_dweek_hard_lb("All", "SN", "Weekend", 1).
staff_dweek_soft_lb("All", "SN", "Weekend", 2).
staff_dweek_soft_ub("All", "SN", "Weekend", 2).
staff_dweek_hard_lb("All", "SN", "Holiday", 1).
staff_dweek_soft_lb("All", "SN", "Holiday", 2).
staff_dweek_soft_ub("All", "SN", "Holiday", 2).
staff_dweek_hard_lb("All", "LD+LM", "Weekday", 1).
staff_dweek_soft_ub("All", "LD+LM", "Weekday", 2).
staff_dweek_hard_lb("All", "LD+LM", "Weekend", 1).
staff_dweek_soft_ub("All", "LD+LM", "Weekend", 2).
staff_dweek_hard_lb("All", "LD+LM", "Holiday", 1).
staff_dweek_soft_ub("All", "LD+LM", "Holiday", 2).
staff_dweek_soft_lb("Expert", "LD", "Weekday", 1).
staff_dweek_soft_ub("Expert", "LD", "Weekday", 1).
staff_dweek_soft_lb("Expert", "LD", "Weekend", 1).
staff_dweek_soft_ub("Expert", "LD", "Weekend", 1).
staff_dweek_soft_lb("Expert", "LD", "Holiday", 1).
staff_dweek_soft_ub("Expert", "LD", "Holiday", 1).
staff_dweek_soft_lb("Expert", "SE", "Weekday", 1).
staff_dweek_soft_ub("Expert", "SE", "Weekday", 1).
staff_dweek_soft_lb("Expert", "SE", "Weekend", 1).
staff_dweek_soft_ub("Expert", "SE", "Weekend", 1).
staff_dweek_soft_lb("Expert", "SE", "Holiday", 1).
staff_dweek_soft_ub("Expert", "SE", "Holiday", 1).
staff_dweek_soft_lb("Expert", "SN", "Weekday", 1).
staff_dweek_soft_ub("Expert", "SN", "Weekday", 1).
staff_dweek_soft_lb("Expert", "SN", "Weekend", 1).
staff_dweek_soft_ub("Expert", "SN", "Weekend", 1).
staff_dweek_soft_lb("Expert", "SN", "Holiday", 1).
staff_dweek_soft_ub("Expert", "SN", "Holiday", 1).
staff_dweek_soft_ub("Medium", "LD", "Weekday", 1).
staff_dweek_soft_ub("Medium", "LD", "Weekend", 1).
staff_dweek_soft_ub("Medium", "LD", "Holiday", 1).
staff_dweek_soft_ub("Medium", "SE", "Weekday", 1).
staff_dweek_soft_ub("Medium", "SE", "Weekend", 1).
staff_dweek_soft_ub("Medium", "SE", "Holiday", 1).
staff_dweek_soft_ub("Medium", "SN", "Weekday", 1).
staff_dweek_soft_ub("Medium", "SN", "Weekend", 1).
staff_dweek_soft_ub("Medium", "SN", "Holiday", 1).
vertical_constraint_type("All", "D", "Staffs").
vertical_constraint_type("All", "LD", "Staffs").
vertical_constraint_type("All", "SE", "Staffs").
vertical_constraint_type("All", "SN", "Staffs").
vertical_constraint_type("All", "LD+LM", "Staffs").
vertical_constraint_type("Expert", "LD", "Staffs").
vertical_constraint_type("Expert", "SE", "Staffs").
vertical_constraint_type("Expert", "SN", "Staffs").
vertical_constraint_type("Medium", "LD", "Staffs").
vertical_constraint_type("Medium", "SE", "Staffs").
vertical_constraint_type("Medium", "SN", "Staffs").
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
pattern("WR-WR", 2).
pattern("WR-WR", 0, "WR").
pattern("WR-WR", 1, "WR").
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
pattern_hard_lb("WR-WR", "All", 2).
pattern_hard_lb("WR-WR", "Expert", 2).
pattern_hard_lb("WR-WR", "Medium", 2).
pattern_hard_lb("WR-WR", "Novice", 2).
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
staff_pos_request(6, 34, "BL").
staff_pos_request(9, 17, "D").
staff_pos_request(1, 23, "BL").
staff_pos_request(6, 24, "AL").
staff_neg_request(9, 10, "SN").
staff_pos_request(4, 14, "D").
staff_neg_request(3, 20, "SN").
staff_pos_request(3, 32, "TR").
staff_pos_request(9, 11, "BL").
staff_pos_request(7, 33, "TR").
staff_pos_request(10, 22, "TR").
staff_pos_request(8, 10, "AL").
staff_pos_request(8, 33, "WR").
staff_pos_request(8, 17, "BL").
staff_pos_request(9, 32, "TR").
staff_pos_request(8, 29, "TR").
staff_pos_request(10, 29, "BL").
staff_neg_request(4, 20, "SN").
staff_pos_request(10, 17, "BL").
staff_pos_request(5, 19, "AL").
staff_pos_request(5, 13, "BL").
staff_neg_request(9, 23, "SE").
staff_pos_request(6, 0, "WR").
staff_pos_request(2, 3, "D").
staff_neg_request(5, 14, "SE").
staff_pos_request(9, 8, "BT").
staff_pos_request(4, 13, "D").
staff_pos_request(7, 2, "D").
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
shift_data("22004", "Theresa Brown", 20250811, "PH").
shift_data("57324", "Russell Fitzgerald", 20250811, "SN").
shift_data("97782", "Elizabeth Obrien", 20250811, "SE").
shift_data("42975", "Lauren Moore", 20250811, "SN").
shift_data("37815", "James Sharp", 20250811, "LM").
shift_data("14683", "Tiffany Stephens MD", 20250811, "PH").
shift_data("99292", "Andrew Johnson", 20250811, "PH").
shift_data("66448", "Fernando James", 20250811, "D").
shift_data("61581", "Kelly Castro", 20250811, "PH").
shift_data("76724", "Alexander Nguyen", 20250811, "LD").
shift_data("22004", "Theresa Brown", 20250812, "D").
shift_data("57324", "Russell Fitzgerald", 20250812, "WR").
shift_data("97782", "Elizabeth Obrien", 20250812, "SN").
shift_data("42975", "Lauren Moore", 20250812, "WR").
shift_data("37815", "James Sharp", 20250812, "SE").
shift_data("14683", "Tiffany Stephens MD", 20250812, "LD").
shift_data("99292", "Andrew Johnson", 20250812, "D").
shift_data("66448", "Fernando James", 20250812, "LM").
shift_data("61581", "Kelly Castro", 20250812, "WR").
shift_data("76724", "Alexander Nguyen", 20250812, "SE").
shift_data("22004", "Theresa Brown", 20250813, "D").
shift_data("57324", "Russell Fitzgerald", 20250813, "WR").
shift_data("97782", "Elizabeth Obrien", 20250813, "WR").
shift_data("42975", "Lauren Moore", 20250813, "LD").
shift_data("37815", "James Sharp", 20250813, "SN").
shift_data("14683", "Tiffany Stephens MD", 20250813, "WR").
shift_data("99292", "Andrew Johnson", 20250813, "D").
shift_data("66448", "Fernando James", 20250813, "SE").
shift_data("61581", "Kelly Castro", 20250813, "LD").
shift_data("76724", "Alexander Nguyen", 20250813, "SN").
shift_data("22004", "Theresa Brown", 20250814, "D").
shift_data("57324", "Russell Fitzgerald", 20250814, "D").
shift_data("97782", "Elizabeth Obrien", 20250814, "LD").
shift_data("42975", "Lauren Moore", 20250814, "SE").
shift_data("37815", "James Sharp", 20250814, "WR").
shift_data("14683", "Tiffany Stephens MD", 20250814, "LD").
shift_data("99292", "Andrew Johnson", 20250814, "WR").
shift_data("66448", "Fernando James", 20250814, "SN").
shift_data("61581", "Kelly Castro", 20250814, "SE").
shift_data("76724", "Alexander Nguyen", 20250814, "WR").
shift_data("22004", "Theresa Brown", 20250815, "WR").
shift_data("57324", "Russell Fitzgerald", 20250815, "LD").
shift_data("97782", "Elizabeth Obrien", 20250815, "SE").
shift_data("42975", "Lauren Moore", 20250815, "SN").
shift_data("37815", "James Sharp", 20250815, "LD").
shift_data("14683", "Tiffany Stephens MD", 20250815, "SE").
shift_data("99292", "Andrew Johnson", 20250815, "D").
shift_data("66448", "Fernando James", 20250815, "WR").
shift_data("61581", "Kelly Castro", 20250815, "SN").
shift_data("76724", "Alexander Nguyen", 20250815, "D").
shift_data("22004", "Theresa Brown", 20250816, "LD").
shift_data("57324", "Russell Fitzgerald", 20250816, "SE").
shift_data("97782", "Elizabeth Obrien", 20250816, "SN").
shift_data("42975", "Lauren Moore", 20250816, "WR").
shift_data("37815", "James Sharp", 20250816, "SE").
shift_data("14683", "Tiffany Stephens MD", 20250816, "SN").
shift_data("99292", "Andrew Johnson", 20250816, "LD").
shift_data("66448", "Fernando James", 20250816, "D").
shift_data("61581", "Kelly Castro", 20250816, "WR").
shift_data("76724", "Alexander Nguyen", 20250816, "WR").
shift_data("22004", "Theresa Brown", 20250817, "SE").
shift_data("57324", "Russell Fitzgerald", 20250817, "SN").
shift_data("97782", "Elizabeth Obrien", 20250817, "WR").
shift_data("42975", "Lauren Moore", 20250817, "D").
shift_data("37815", "James Sharp", 20250817, "SN").
shift_data("14683", "Tiffany Stephens MD", 20250817, "WR").
shift_data("99292", "Andrew Johnson", 20250817, "SE").
shift_data("66448", "Fernando James", 20250817, "LD").
shift_data("61581", "Kelly Castro", 20250817, "LD").
shift_data("76724", "Alexander Nguyen", 20250817, "WR").
shift_data("22004", "Theresa Brown", 20250818, "SN").
shift_data("57324", "Russell Fitzgerald", 20250818, "WR").
shift_data("97782", "Elizabeth Obrien", 20250818, "LD").
shift_data("42975", "Lauren Moore", 20250818, "D").
shift_data("37815", "James Sharp", 20250818, "WR").
shift_data("14683", "Tiffany Stephens MD", 20250818, "D").
shift_data("99292", "Andrew Johnson", 20250818, "SN").
shift_data("66448", "Fernando James", 20250818, "SE").
shift_data("61581", "Kelly Castro", 20250818, "WR").
shift_data("76724", "Alexander Nguyen", 20250818, "WR").
shift_data("22004", "Theresa Brown", 20250819, "WR").
shift_data("57324", "Russell Fitzgerald", 20250819, "D").
shift_data("97782", "Elizabeth Obrien", 20250819, "SE").
shift_data("42975", "Lauren Moore", 20250819, "LM").
shift_data("37815", "James Sharp", 20250819, "LD").
shift_data("14683", "Tiffany Stephens MD", 20250819, "WR").
shift_data("99292", "Andrew Johnson", 20250819, "WR").
shift_data("66448", "Fernando James", 20250819, "SN").
shift_data("61581", "Kelly Castro", 20250819, "BT").
shift_data("76724", "Alexander Nguyen", 20250819, "D").
shift_data("22004", "Theresa Brown", 20250820, "LD").
shift_data("57324", "Russell Fitzgerald", 20250820, "WR").
shift_data("97782", "Elizabeth Obrien", 20250820, "SN").
shift_data("42975", "Lauren Moore", 20250820, "SE").
shift_data("37815", "James Sharp", 20250820, "WR").
shift_data("14683", "Tiffany Stephens MD", 20250820, "WR").
shift_data("99292", "Andrew Johnson", 20250820, "LD").
shift_data("66448", "Fernando James", 20250820, "WR").
shift_data("61581", "Kelly Castro", 20250820, "D").
shift_data("76724", "Alexander Nguyen", 20250820, "D").
shift_data("22004", "Theresa Brown", 20250821, "SE").
shift_data("57324", "Russell Fitzgerald", 20250821, "D").
shift_data("97782", "Elizabeth Obrien", 20250821, "WR").
shift_data("42975", "Lauren Moore", 20250821, "SN").
shift_data("37815", "James Sharp", 20250821, "LD").
shift_data("14683", "Tiffany Stephens MD", 20250821, "WR").
shift_data("99292", "Andrew Johnson", 20250821, "SE").
shift_data("66448", "Fernando James", 20250821, "AL").
shift_data("61581", "Kelly Castro", 20250821, "D").
shift_data("76724", "Alexander Nguyen", 20250821, "LD").
shift_data("22004", "Theresa Brown", 20250822, "SN").
shift_data("57324", "Russell Fitzgerald", 20250822, "D").
shift_data("97782", "Elizabeth Obrien", 20250822, "LD").
shift_data("42975", "Lauren Moore", 20250822, "WR").
shift_data("37815", "James Sharp", 20250822, "SE").
shift_data("14683", "Tiffany Stephens MD", 20250822, "D").
shift_data("99292", "Andrew Johnson", 20250822, "SN").
shift_data("66448", "Fernando James", 20250822, "LD").
shift_data("61581", "Kelly Castro", 20250822, "BL").
shift_data("76724", "Alexander Nguyen", 20250822, "SE").
shift_data("22004", "Theresa Brown", 20250823, "WR").
shift_data("57324", "Russell Fitzgerald", 20250823, "LD").
shift_data("97782", "Elizabeth Obrien", 20250823, "SE").
shift_data("42975", "Lauren Moore", 20250823, "WR").
shift_data("37815", "James Sharp", 20250823, "SN").
shift_data("14683", "Tiffany Stephens MD", 20250823, "LM").
shift_data("99292", "Andrew Johnson", 20250823, "WR").
shift_data("66448", "Fernando James", 20250823, "SE").
shift_data("61581", "Kelly Castro", 20250823, "WR").
shift_data("76724", "Alexander Nguyen", 20250823, "SN").
shift_data("22004", "Theresa Brown", 20250824, "LD").
shift_data("57324", "Russell Fitzgerald", 20250824, "SE").
shift_data("97782", "Elizabeth Obrien", 20250824, "SN").
shift_data("42975", "Lauren Moore", 20250824, "D").
shift_data("37815", "James Sharp", 20250824, "BL").
shift_data("14683", "Tiffany Stephens MD", 20250824, "SE").
shift_data("99292", "Andrew Johnson", 20250824, "WR").
shift_data("66448", "Fernando James", 20250824, "SN").
shift_data("61581", "Kelly Castro", 20250824, "LM").
shift_data("76724", "Alexander Nguyen", 20250824, "WR").
shift_data("22004", "Theresa Brown", 20250825, "SE").
shift_data("57324", "Russell Fitzgerald", 20250825, "SN").
shift_data("97782", "Elizabeth Obrien", 20250825, "WR").
shift_data("42975", "Lauren Moore", 20250825, "D").
shift_data("37815", "James Sharp", 20250825, "D").
shift_data("14683", "Tiffany Stephens MD", 20250825, "SN").
shift_data("99292", "Andrew Johnson", 20250825, "WR").
shift_data("66448", "Fernando James", 20250825, "WR").
shift_data("61581", "Kelly Castro", 20250825, "SE").
shift_data("76724", "Alexander Nguyen", 20250825, "LD").
shift_data("22004", "Theresa Brown", 20250826, "SN").
shift_data("57324", "Russell Fitzgerald", 20250826, "WR").
shift_data("97782", "Elizabeth Obrien", 20250826, "D").
shift_data("42975", "Lauren Moore", 20250826, "LD").
shift_data("37815", "James Sharp", 20250826, "D").
shift_data("14683", "Tiffany Stephens MD", 20250826, "WR").
shift_data("99292", "Andrew Johnson", 20250826, "WR").
shift_data("66448", "Fernando James", 20250826, "WR").
shift_data("61581", "Kelly Castro", 20250826, "SN").
shift_data("76724", "Alexander Nguyen", 20250826, "SE").
shift_data("22004", "Theresa Brown", 20250827, "WR").
shift_data("57324", "Russell Fitzgerald", 20250827, "D").
shift_data("97782", "Elizabeth Obrien", 20250827, "LD").
shift_data("42975", "Lauren Moore", 20250827, "SE").
shift_data("37815", "James Sharp", 20250827, "WR").
shift_data("14683", "Tiffany Stephens MD", 20250827, "WR").
shift_data("99292", "Andrew Johnson", 20250827, "LD").
shift_data("66448", "Fernando James", 20250827, "D").
shift_data("61581", "Kelly Castro", 20250827, "WR").
shift_data("76724", "Alexander Nguyen", 20250827, "SN").
shift_data("22004", "Theresa Brown", 20250828, "WR").
shift_data("57324", "Russell Fitzgerald", 20250828, "LD").
shift_data("97782", "Elizabeth Obrien", 20250828, "SE").
shift_data("42975", "Lauren Moore", 20250828, "SN").
shift_data("37815", "James Sharp", 20250828, "WR").
shift_data("14683", "Tiffany Stephens MD", 20250828, "D").
shift_data("99292", "Andrew Johnson", 20250828, "SE").
shift_data("66448", "Fernando James", 20250828, "BL").
shift_data("61581", "Kelly Castro", 20250828, "D").
shift_data("76724", "Alexander Nguyen", 20250828, "BL").
shift_data("22004", "Theresa Brown", 20250829, "WR").
shift_data("57324", "Russell Fitzgerald", 20250829, "SE").
shift_data("97782", "Elizabeth Obrien", 20250829, "SN").
shift_data("42975", "Lauren Moore", 20250829, "WR").
shift_data("37815", "James Sharp", 20250829, "WR").
shift_data("14683", "Tiffany Stephens MD", 20250829, "LD").
shift_data("99292", "Andrew Johnson", 20250829, "SN").
shift_data("66448", "Fernando James", 20250829, "D").
shift_data("61581", "Kelly Castro", 20250829, "D").
shift_data("76724", "Alexander Nguyen", 20250829, "LD").
shift_data("22004", "Theresa Brown", 20250830, "WR").
shift_data("57324", "Russell Fitzgerald", 20250830, "SN").
shift_data("97782", "Elizabeth Obrien", 20250830, "WR").
shift_data("42975", "Lauren Moore", 20250830, "D").
shift_data("37815", "James Sharp", 20250830, "AL").
shift_data("14683", "Tiffany Stephens MD", 20250830, "SE").
shift_data("99292", "Andrew Johnson", 20250830, "WR").
shift_data("66448", "Fernando James", 20250830, "LD").
shift_data("61581", "Kelly Castro", 20250830, "LD").
shift_data("76724", "Alexander Nguyen", 20250830, "SE").
shift_data("22004", "Theresa Brown", 20250831, "LD").
shift_data("57324", "Russell Fitzgerald", 20250831, "WR").
shift_data("97782", "Elizabeth Obrien", 20250831, "WR").
shift_data("42975", "Lauren Moore", 20250831, "WR").
shift_data("37815", "James Sharp", 20250831, "LD").
shift_data("14683", "Tiffany Stephens MD", 20250831, "SN").
shift_data("99292", "Andrew Johnson", 20250831, "D").
shift_data("66448", "Fernando James", 20250831, "WR").
shift_data("61581", "Kelly Castro", 20250831, "SE").
shift_data("76724", "Alexander Nguyen", 20250831, "SN").
shift_data("22004", "Theresa Brown", 20250901, "SE").
shift_data("57324", "Russell Fitzgerald", 20250901, "LD").
shift_data("97782", "Elizabeth Obrien", 20250901, "D").
shift_data("42975", "Lauren Moore", 20250901, "WR").
shift_data("37815", "James Sharp", 20250901, "SE").
shift_data("14683", "Tiffany Stephens MD", 20250901, "WR").
shift_data("99292", "Andrew Johnson", 20250901, "LD").
shift_data("66448", "Fernando James", 20250901, "D").
shift_data("61581", "Kelly Castro", 20250901, "SN").
shift_data("76724", "Alexander Nguyen", 20250901, "WR").
shift_data("22004", "Theresa Brown", 20250902, "SN").
shift_data("57324", "Russell Fitzgerald", 20250902, "SE").
shift_data("97782", "Elizabeth Obrien", 20250902, "LD").
shift_data("42975", "Lauren Moore", 20250902, "D").
shift_data("37815", "James Sharp", 20250902, "SN").
shift_data("14683", "Tiffany Stephens MD", 20250902, "D").
shift_data("99292", "Andrew Johnson", 20250902, "SE").
shift_data("66448", "Fernando James", 20250902, "WR").
shift_data("61581", "Kelly Castro", 20250902, "WR").
shift_data("76724", "Alexander Nguyen", 20250902, "TR").
shift_data("22004", "Theresa Brown", 20250903, "BL").
shift_data("57324", "Russell Fitzgerald", 20250903, "SN").
shift_data("97782", "Elizabeth Obrien", 20250903, "SE").
shift_data("42975", "Lauren Moore", 20250903, "LD").
shift_data("37815", "James Sharp", 20250903, "WR").
shift_data("14683", "Tiffany Stephens MD", 20250903, "D").
shift_data("99292", "Andrew Johnson", 20250903, "SN").
shift_data("66448", "Fernando James", 20250903, "WR").
shift_data("61581", "Kelly Castro", 20250903, "WR").
shift_data("76724", "Alexander Nguyen", 20250903, "D").
shift_data("22004", "Theresa Brown", 20250904, "WR").
shift_data("57324", "Russell Fitzgerald", 20250904, "WR").
shift_data("97782", "Elizabeth Obrien", 20250904, "SN").
shift_data("42975", "Lauren Moore", 20250904, "SE").
shift_data("37815", "James Sharp", 20250904, "D").
shift_data("14683", "Tiffany Stephens MD", 20250904, "AL").
shift_data("99292", "Andrew Johnson", 20250904, "WR").
shift_data("66448", "Fernando James", 20250904, "LD").
shift_data("61581", "Kelly Castro", 20250904, "LD").
shift_data("76724", "Alexander Nguyen", 20250904, "D").
shift_data("22004", "Theresa Brown", 20250905, "LD").
shift_data("57324", "Russell Fitzgerald", 20250905, "WR").
shift_data("97782", "Elizabeth Obrien", 20250905, "WR").
shift_data("42975", "Lauren Moore", 20250905, "SN").
shift_data("37815", "James Sharp", 20250905, "WR").
shift_data("14683", "Tiffany Stephens MD", 20250905, "LD").
shift_data("99292", "Andrew Johnson", 20250905, "D").
shift_data("66448", "Fernando James", 20250905, "SE").
shift_data("61581", "Kelly Castro", 20250905, "SE").
shift_data("76724", "Alexander Nguyen", 20250905, "D").
shift_data("22004", "Theresa Brown", 20250906, "SE").
shift_data("57324", "Russell Fitzgerald", 20250906, "LD").
shift_data("97782", "Elizabeth Obrien", 20250906, "WR").
shift_data("42975", "Lauren Moore", 20250906, "WR").
shift_data("37815", "James Sharp", 20250906, "LD").
shift_data("14683", "Tiffany Stephens MD", 20250906, "SE").
shift_data("99292", "Andrew Johnson", 20250906, "D").
shift_data("66448", "Fernando James", 20250906, "SN").
shift_data("61581", "Kelly Castro", 20250906, "SN").
shift_data("76724", "Alexander Nguyen", 20250906, "WR").
shift_data("22004", "Theresa Brown", 20250907, "SN").
shift_data("57324", "Russell Fitzgerald", 20250907, "SE").
shift_data("97782", "Elizabeth Obrien", 20250907, "LD").
shift_data("42975", "Lauren Moore", 20250907, "LD").
shift_data("37815", "James Sharp", 20250907, "SE").
shift_data("14683", "Tiffany Stephens MD", 20250907, "SN").
shift_data("99292", "Andrew Johnson", 20250907, "D").
shift_data("66448", "Fernando James", 20250907, "WR").
shift_data("61581", "Kelly Castro", 20250907, "WR").
shift_data("76724", "Alexander Nguyen", 20250907, "WR").
% Past dates -------------------------------------
past_date(20250811, "Mo").
past_date(20250812, "Tu").
past_date(20250813, "We").
past_date(20250814, "Th").
past_date(20250815, "Fr").
past_date(20250816, "Sa").
past_date(20250817, "Su").
past_date(20250818, "Mo").
past_date(20250819, "Tu").
past_date(20250820, "We").
past_date(20250821, "Th").
past_date(20250822, "Fr").
past_date(20250823, "Sa").
past_date(20250824, "Su").
past_date(20250825, "Mo").
past_date(20250826, "Tu").
past_date(20250827, "We").
past_date(20250828, "Th").
past_date(20250829, "Fr").
past_date(20250830, "Sa").
past_date(20250831, "Su").
past_date(20250901, "Mo").
past_date(20250902, "Tu").
past_date(20250903, "We").
past_date(20250904, "Th").
past_date(20250905, "Fr").
past_date(20250906, "Sa").
past_date(20250907, "Su").
% Past public holidays
past_public_holiday(20250811, "Mo").
