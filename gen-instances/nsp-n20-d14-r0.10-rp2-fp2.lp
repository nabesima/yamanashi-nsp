% Staffs -----------------------------------------
staff(1, "Norma Fisher", "Nurse", "65125", 8).
staff(2, "Jorge Sullivan", "Nurse", "43936", 7).
staff(3, "Elizabeth Woods", "Nurse", "73691", 9).
staff(4, "Susan Wagner", "Nurse", "49755", 8).
staff(5, "Peter Montgomery", "Nurse", "56930", 8).
staff(6, "Theodore Mcgrath", "Nurse", "38631", 9).
staff(7, "Stephanie Collins", "Nurse", "28254", 6).
staff(8, "Stephanie Sutton", "Nurse", "28316", 5).
staff(9, "Brian Hamilton", "Nurse", "91050", 4).
staff(10, "Susan Levy", "Nurse", "79804", 5).
staff(11, "Sean Green", "Nurse", "88892", 6).
staff(12, "Kimberly Smith", "Nurse", "50651", 4).
staff(13, "Jennifer Summers", "Nurse", "19665", 4).
staff(14, "April Snyder", "Nurse", "53279", 6).
staff(15, "Dana Nguyen", "Nurse", "83375", 5).
staff(16, "Cheryl Bradley", "Nurse", "56372", 4).
staff(17, "Walter Pratt", "Nurse", "51444", 2).
staff(18, "Bobby Flores", "Nurse", "93941", 3).
staff(19, "Tasha Rodriguez", "Nurse", "82420", 1).
staff(20, "Michelle Kelley", "Nurse", "68024", 2).
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
staff_group("All", 11).
staff_group("All", 12).
staff_group("All", 13).
staff_group("All", 14).
staff_group("All", 15).
staff_group("All", 16).
staff_group("All", 17).
staff_group("All", 18).
staff_group("All", 19).
staff_group("All", 20).
staff_group("Expert").
staff_group("Expert", 1).
staff_group("Expert", 2).
staff_group("Expert", 3).
staff_group("Expert", 4).
staff_group("Expert", 5).
staff_group("Expert", 6).
staff_group("Medium").
staff_group("Medium", 7).
staff_group("Medium", 8).
staff_group("Medium", 9).
staff_group("Medium", 10).
staff_group("Medium", 11).
staff_group("Medium", 12).
staff_group("Medium", 13).
staff_group("Medium", 14).
staff_group("Medium", 15).
staff_group("Medium", 16).
staff_group("Novice").
staff_group("Novice", 17).
staff_group("Novice", 18).
staff_group("Novice", 19).
staff_group("Novice", 20).
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
% Next month
next_date(14, "Mo").
next_date(15, "Tu").
next_date(16, "We").
next_date(17, "Th").
next_date(18, "Fr").
next_date(19, "Sa").
next_date(20, "Su").
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
shifts_soft_lb(1, "LD", 2).
shifts_soft_ub(1, "LD", 4).
shifts_soft_lb(1, "SE", 2).
shifts_soft_ub(1, "SE", 4).
shifts_soft_lb(1, "SN", 2).
shifts_soft_ub(1, "SN", 4).
shifts_hard_ub(1, "E", 0).
shifts_hard_ub(1, "N", 0).
shifts_hard_ub(1, "EM", 0).
shifts_hard_ub(1, "LM", 1).
shifts_soft_lb(2, "LD", 2).
shifts_soft_ub(2, "LD", 4).
shifts_soft_lb(2, "SE", 2).
shifts_soft_ub(2, "SE", 4).
shifts_soft_lb(2, "SN", 2).
shifts_soft_ub(2, "SN", 4).
shifts_hard_ub(2, "E", 0).
shifts_hard_ub(2, "N", 0).
shifts_hard_ub(2, "EM", 0).
shifts_hard_ub(2, "LM", 1).
shifts_soft_lb(3, "LD", 2).
shifts_soft_ub(3, "LD", 4).
shifts_soft_lb(3, "SE", 2).
shifts_soft_ub(3, "SE", 4).
shifts_soft_lb(3, "SN", 2).
shifts_soft_ub(3, "SN", 4).
shifts_hard_ub(3, "E", 0).
shifts_hard_ub(3, "N", 0).
shifts_hard_ub(3, "EM", 0).
shifts_hard_ub(3, "LM", 1).
shifts_soft_lb(4, "LD", 2).
shifts_soft_ub(4, "LD", 4).
shifts_soft_lb(4, "SE", 2).
shifts_soft_ub(4, "SE", 4).
shifts_soft_lb(4, "SN", 2).
shifts_soft_ub(4, "SN", 4).
shifts_hard_ub(4, "E", 0).
shifts_hard_ub(4, "N", 0).
shifts_hard_ub(4, "EM", 0).
shifts_hard_ub(4, "LM", 1).
shifts_soft_lb(5, "LD", 2).
shifts_soft_ub(5, "LD", 4).
shifts_soft_lb(5, "SE", 2).
shifts_soft_ub(5, "SE", 4).
shifts_soft_lb(5, "SN", 2).
shifts_soft_ub(5, "SN", 4).
shifts_hard_ub(5, "E", 0).
shifts_hard_ub(5, "N", 0).
shifts_hard_ub(5, "EM", 0).
shifts_hard_ub(5, "LM", 1).
shifts_soft_lb(6, "LD", 2).
shifts_soft_ub(6, "LD", 4).
shifts_soft_lb(6, "SE", 2).
shifts_soft_ub(6, "SE", 4).
shifts_soft_lb(6, "SN", 2).
shifts_soft_ub(6, "SN", 4).
shifts_hard_ub(6, "E", 0).
shifts_hard_ub(6, "N", 0).
shifts_hard_ub(6, "EM", 0).
shifts_hard_ub(6, "LM", 1).
shifts_soft_lb(7, "LD", 2).
shifts_soft_ub(7, "LD", 4).
shifts_soft_lb(7, "SE", 2).
shifts_soft_ub(7, "SE", 4).
shifts_soft_lb(7, "SN", 2).
shifts_soft_ub(7, "SN", 4).
shifts_hard_ub(7, "E", 0).
shifts_hard_ub(7, "N", 0).
shifts_hard_ub(7, "EM", 0).
shifts_hard_ub(7, "LM", 1).
shifts_soft_lb(8, "LD", 2).
shifts_soft_ub(8, "LD", 4).
shifts_soft_lb(8, "SE", 2).
shifts_soft_ub(8, "SE", 4).
shifts_soft_lb(8, "SN", 2).
shifts_soft_ub(8, "SN", 4).
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
shifts_soft_lb(11, "LD", 2).
shifts_soft_ub(11, "LD", 4).
shifts_soft_lb(11, "SE", 2).
shifts_soft_ub(11, "SE", 4).
shifts_soft_lb(11, "SN", 2).
shifts_soft_ub(11, "SN", 4).
shifts_hard_ub(11, "E", 0).
shifts_hard_ub(11, "N", 0).
shifts_hard_ub(11, "EM", 0).
shifts_hard_ub(11, "LM", 1).
shifts_soft_lb(12, "LD", 2).
shifts_soft_ub(12, "LD", 4).
shifts_soft_lb(12, "SE", 2).
shifts_soft_ub(12, "SE", 4).
shifts_soft_lb(12, "SN", 2).
shifts_soft_ub(12, "SN", 4).
shifts_hard_ub(12, "E", 0).
shifts_hard_ub(12, "N", 0).
shifts_hard_ub(12, "EM", 0).
shifts_hard_ub(12, "LM", 1).
shifts_soft_lb(13, "LD", 2).
shifts_soft_ub(13, "LD", 4).
shifts_soft_lb(13, "SE", 2).
shifts_soft_ub(13, "SE", 4).
shifts_soft_lb(13, "SN", 2).
shifts_soft_ub(13, "SN", 4).
shifts_hard_ub(13, "E", 0).
shifts_hard_ub(13, "N", 0).
shifts_hard_ub(13, "EM", 0).
shifts_hard_ub(13, "LM", 1).
shifts_soft_lb(14, "LD", 2).
shifts_soft_ub(14, "LD", 4).
shifts_soft_lb(14, "SE", 2).
shifts_soft_ub(14, "SE", 4).
shifts_soft_lb(14, "SN", 2).
shifts_soft_ub(14, "SN", 4).
shifts_hard_ub(14, "E", 0).
shifts_hard_ub(14, "N", 0).
shifts_hard_ub(14, "EM", 0).
shifts_hard_ub(14, "LM", 1).
shifts_soft_lb(15, "LD", 2).
shifts_soft_ub(15, "LD", 4).
shifts_soft_lb(15, "SE", 2).
shifts_soft_ub(15, "SE", 4).
shifts_soft_lb(15, "SN", 2).
shifts_soft_ub(15, "SN", 4).
shifts_hard_ub(15, "E", 0).
shifts_hard_ub(15, "N", 0).
shifts_hard_ub(15, "EM", 0).
shifts_hard_ub(15, "LM", 1).
shifts_soft_lb(16, "LD", 2).
shifts_soft_ub(16, "LD", 4).
shifts_soft_lb(16, "SE", 2).
shifts_soft_ub(16, "SE", 4).
shifts_soft_lb(16, "SN", 2).
shifts_soft_ub(16, "SN", 4).
shifts_hard_ub(16, "E", 0).
shifts_hard_ub(16, "N", 0).
shifts_hard_ub(16, "EM", 0).
shifts_hard_ub(16, "LM", 1).
shifts_soft_lb(17, "LD", 1).
shifts_soft_ub(17, "LD", 2).
shifts_soft_lb(17, "SE", 1).
shifts_soft_ub(17, "SE", 2).
shifts_soft_lb(17, "SN", 1).
shifts_soft_ub(17, "SN", 2).
shifts_hard_ub(17, "E", 0).
shifts_hard_ub(17, "N", 0).
shifts_hard_ub(17, "EM", 0).
shifts_hard_ub(17, "LM", 1).
shifts_soft_lb(18, "LD", 1).
shifts_soft_ub(18, "LD", 2).
shifts_soft_lb(18, "SE", 1).
shifts_soft_ub(18, "SE", 2).
shifts_soft_lb(18, "SN", 1).
shifts_soft_ub(18, "SN", 2).
shifts_hard_ub(18, "E", 0).
shifts_hard_ub(18, "N", 0).
shifts_hard_ub(18, "EM", 0).
shifts_hard_ub(18, "LM", 1).
shifts_soft_lb(19, "LD", 1).
shifts_soft_ub(19, "LD", 2).
shifts_soft_lb(19, "SE", 1).
shifts_soft_ub(19, "SE", 2).
shifts_soft_lb(19, "SN", 1).
shifts_soft_ub(19, "SN", 2).
shifts_hard_ub(19, "E", 0).
shifts_hard_ub(19, "N", 0).
shifts_hard_ub(19, "EM", 0).
shifts_hard_ub(19, "LM", 1).
shifts_soft_lb(20, "LD", 1).
shifts_soft_ub(20, "LD", 2).
shifts_soft_lb(20, "SE", 1).
shifts_soft_ub(20, "SE", 2).
shifts_soft_lb(20, "SN", 1).
shifts_soft_ub(20, "SN", 2).
shifts_hard_ub(20, "E", 0).
shifts_hard_ub(20, "N", 0).
shifts_hard_ub(20, "EM", 0).
shifts_hard_ub(20, "LM", 1).
horizontal_constraint_type("LD").
horizontal_constraint_type("SE").
horizontal_constraint_type("SN").
horizontal_constraint_type("E").
horizontal_constraint_type("N").
horizontal_constraint_type("EM").
horizontal_constraint_type("LM").
% Vertical constraints ---------------------------
staff_dweek_hard_lb("All", "D", "Weekday", 3).
staff_dweek_soft_lb("All", "D", "Weekday", 5).
staff_dweek_soft_ub("All", "D", "Weekday", 10).
staff_dweek_hard_lb("All", "D", "Weekend", 1).
staff_dweek_soft_lb("All", "D", "Weekend", 2).
staff_dweek_soft_ub("All", "D", "Weekend", 3).
staff_dweek_hard_lb("All", "D", "Holiday", 1).
staff_dweek_soft_lb("All", "D", "Holiday", 2).
staff_dweek_soft_ub("All", "D", "Holiday", 3).
staff_dweek_hard_lb("All", "LD", "Weekday", 2).
staff_dweek_soft_lb("All", "LD", "Weekday", 3).
staff_dweek_soft_ub("All", "LD", "Weekday", 3).
staff_dweek_hard_lb("All", "LD", "Weekend", 2).
staff_dweek_soft_lb("All", "LD", "Weekend", 3).
staff_dweek_soft_ub("All", "LD", "Weekend", 3).
staff_dweek_hard_lb("All", "LD", "Holiday", 2).
staff_dweek_soft_lb("All", "LD", "Holiday", 3).
staff_dweek_soft_ub("All", "LD", "Holiday", 3).
staff_dweek_hard_lb("All", "SE", "Weekday", 2).
staff_dweek_soft_lb("All", "SE", "Weekday", 3).
staff_dweek_soft_ub("All", "SE", "Weekday", 3).
staff_dweek_hard_lb("All", "SE", "Weekend", 2).
staff_dweek_soft_lb("All", "SE", "Weekend", 3).
staff_dweek_soft_ub("All", "SE", "Weekend", 3).
staff_dweek_hard_lb("All", "SE", "Holiday", 2).
staff_dweek_soft_lb("All", "SE", "Holiday", 3).
staff_dweek_soft_ub("All", "SE", "Holiday", 3).
staff_dweek_hard_lb("All", "SN", "Weekday", 2).
staff_dweek_soft_lb("All", "SN", "Weekday", 3).
staff_dweek_soft_ub("All", "SN", "Weekday", 3).
staff_dweek_hard_lb("All", "SN", "Weekend", 2).
staff_dweek_soft_lb("All", "SN", "Weekend", 3).
staff_dweek_soft_ub("All", "SN", "Weekend", 3).
staff_dweek_hard_lb("All", "SN", "Holiday", 2).
staff_dweek_soft_lb("All", "SN", "Holiday", 3).
staff_dweek_soft_ub("All", "SN", "Holiday", 3).
staff_dweek_hard_ub("All", "LM", "Weekday", 1).
staff_dweek_hard_ub("All", "LM", "Weekend", 1).
staff_dweek_hard_ub("All", "LM", "Holiday", 1).
staff_dweek_hard_lb("All", "LD+LM", "Weekday", 2).
staff_dweek_soft_ub("All", "LD+LM", "Weekday", 4).
staff_dweek_hard_lb("All", "LD+LM", "Weekend", 2).
staff_dweek_soft_ub("All", "LD+LM", "Weekend", 3).
staff_dweek_hard_lb("All", "LD+LM", "Holiday", 2).
staff_dweek_soft_ub("All", "LD+LM", "Holiday", 3).
staff_dweek_hard_lb("Expert", "LD", "Weekday", 1).
staff_dweek_soft_lb("Expert", "LD", "Weekday", 1).
staff_dweek_soft_ub("Expert", "LD", "Weekday", 2).
staff_dweek_hard_lb("Expert", "LD", "Weekend", 1).
staff_dweek_soft_lb("Expert", "LD", "Weekend", 1).
staff_dweek_soft_ub("Expert", "LD", "Weekend", 2).
staff_dweek_hard_lb("Expert", "LD", "Holiday", 1).
staff_dweek_soft_lb("Expert", "LD", "Holiday", 1).
staff_dweek_soft_ub("Expert", "LD", "Holiday", 2).
staff_dweek_hard_lb("Expert", "SE", "Weekday", 1).
staff_dweek_soft_lb("Expert", "SE", "Weekday", 1).
staff_dweek_soft_ub("Expert", "SE", "Weekday", 2).
staff_dweek_hard_lb("Expert", "SE", "Weekend", 1).
staff_dweek_soft_lb("Expert", "SE", "Weekend", 1).
staff_dweek_soft_ub("Expert", "SE", "Weekend", 2).
staff_dweek_hard_lb("Expert", "SE", "Holiday", 1).
staff_dweek_soft_lb("Expert", "SE", "Holiday", 1).
staff_dweek_soft_ub("Expert", "SE", "Holiday", 2).
staff_dweek_hard_lb("Expert", "SN", "Weekday", 1).
staff_dweek_soft_lb("Expert", "SN", "Weekday", 1).
staff_dweek_soft_ub("Expert", "SN", "Weekday", 2).
staff_dweek_hard_lb("Expert", "SN", "Weekend", 1).
staff_dweek_soft_lb("Expert", "SN", "Weekend", 1).
staff_dweek_soft_ub("Expert", "SN", "Weekend", 2).
staff_dweek_hard_lb("Expert", "SN", "Holiday", 1).
staff_dweek_soft_lb("Expert", "SN", "Holiday", 1).
staff_dweek_soft_ub("Expert", "SN", "Holiday", 2).
staff_dweek_soft_lb("Medium", "LD", "Weekday", 1).
staff_dweek_soft_ub("Medium", "LD", "Weekday", 2).
staff_dweek_soft_lb("Medium", "LD", "Weekend", 1).
staff_dweek_soft_ub("Medium", "LD", "Weekend", 2).
staff_dweek_soft_lb("Medium", "LD", "Holiday", 1).
staff_dweek_soft_ub("Medium", "LD", "Holiday", 2).
staff_dweek_soft_lb("Medium", "SE", "Weekday", 1).
staff_dweek_soft_ub("Medium", "SE", "Weekday", 2).
staff_dweek_soft_lb("Medium", "SE", "Weekend", 1).
staff_dweek_soft_ub("Medium", "SE", "Weekend", 2).
staff_dweek_soft_lb("Medium", "SE", "Holiday", 1).
staff_dweek_soft_ub("Medium", "SE", "Holiday", 2).
staff_dweek_soft_lb("Medium", "SN", "Weekday", 1).
staff_dweek_soft_ub("Medium", "SN", "Weekday", 2).
staff_dweek_soft_lb("Medium", "SN", "Weekend", 1).
staff_dweek_soft_ub("Medium", "SN", "Weekend", 2).
staff_dweek_soft_lb("Medium", "SN", "Holiday", 1).
staff_dweek_soft_ub("Medium", "SN", "Holiday", 2).
staff_dweek_soft_lb("Novice", "LD", "Weekday", 1).
staff_dweek_soft_ub("Novice", "LD", "Weekday", 1).
staff_dweek_hard_ub("Novice", "LD", "Weekday", 1).
staff_dweek_soft_lb("Novice", "LD", "Weekend", 1).
staff_dweek_soft_ub("Novice", "LD", "Weekend", 1).
staff_dweek_hard_ub("Novice", "LD", "Weekend", 1).
staff_dweek_soft_lb("Novice", "LD", "Holiday", 1).
staff_dweek_soft_ub("Novice", "LD", "Holiday", 1).
staff_dweek_hard_ub("Novice", "LD", "Holiday", 1).
staff_dweek_soft_lb("Novice", "SE", "Weekday", 1).
staff_dweek_soft_ub("Novice", "SE", "Weekday", 1).
staff_dweek_hard_ub("Novice", "SE", "Weekday", 1).
staff_dweek_soft_lb("Novice", "SE", "Weekend", 1).
staff_dweek_soft_ub("Novice", "SE", "Weekend", 1).
staff_dweek_hard_ub("Novice", "SE", "Weekend", 1).
staff_dweek_soft_lb("Novice", "SE", "Holiday", 1).
staff_dweek_soft_ub("Novice", "SE", "Holiday", 1).
staff_dweek_hard_ub("Novice", "SE", "Holiday", 1).
staff_dweek_soft_lb("Novice", "SN", "Weekday", 1).
staff_dweek_soft_ub("Novice", "SN", "Weekday", 1).
staff_dweek_hard_ub("Novice", "SN", "Weekday", 1).
staff_dweek_soft_lb("Novice", "SN", "Weekend", 1).
staff_dweek_soft_ub("Novice", "SN", "Weekend", 1).
staff_dweek_hard_ub("Novice", "SN", "Weekend", 1).
staff_dweek_soft_lb("Novice", "SN", "Holiday", 1).
staff_dweek_soft_ub("Novice", "SN", "Holiday", 1).
staff_dweek_hard_ub("Novice", "SN", "Holiday", 1).
vertical_constraint_type("All", "D", "Staffs").
vertical_constraint_type("All", "LD", "Staffs").
vertical_constraint_type("All", "SE", "Staffs").
vertical_constraint_type("All", "SN", "Staffs").
vertical_constraint_type("All", "LM", "Staffs").
vertical_constraint_type("All", "LD+LM", "Staffs").
vertical_constraint_type("Expert", "LD", "Staffs").
vertical_constraint_type("Expert", "SE", "Staffs").
vertical_constraint_type("Expert", "SN", "Staffs").
vertical_constraint_type("Medium", "LD", "Staffs").
vertical_constraint_type("Medium", "SE", "Staffs").
vertical_constraint_type("Medium", "SN", "Staffs").
vertical_constraint_type("Novice", "LD", "Staffs").
vertical_constraint_type("Novice", "SE", "Staffs").
vertical_constraint_type("Novice", "SN", "Staffs").
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
pattern_hard_lb("WR-WR", "All", 1).
pattern_hard_lb("WR-WR", "Expert", 1).
pattern_hard_lb("WR-WR", "Medium", 1).
pattern_hard_lb("WR-WR", "Novice", 1).
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
staff_pos_request(17, 8, "D").
staff_neg_request(18, 0, "SE").
staff_pos_request(13, 20, "D").
staff_pos_request(20, 15, "TR").
staff_neg_request(8, 10, "SE").
staff_pos_request(7, 18, "WR").
staff_pos_request(8, 4, "BL").
staff_pos_request(3, 2, "TR").
staff_neg_request(17, 15, "SE").
staff_pos_request(10, 17, "BT").
staff_pos_request(4, 17, "TR").
staff_pos_request(18, 6, "BT").
staff_pos_request(15, 2, "AL").
staff_pos_request(11, 18, "WR").
staff_pos_request(10, 5, "WR").
staff_pos_request(6, 1, "BT").
staff_neg_request(16, 2, "SE").
staff_pos_request(5, 4, "D").
staff_pos_request(3, 17, "AL").
staff_pos_request(17, 8, "WR").
staff_pos_request(19, 8, "BL").
staff_pos_request(16, 20, "TR").
staff_neg_request(3, 10, "SE").
staff_pos_request(16, 18, "TR").
staff_pos_request(7, 7, "D").
staff_pos_request(9, 3, "WR").
staff_pos_request(12, 5, "TR").
staff_neg_request(14, 1, "SE").
% Pairs ------------------------------------------
recommended_night_pair(5, 18, 2).
recommended_night_pair(2, 17, 2).
forbidden_night_pair(1, 4).
forbidden_night_pair(7, 19).
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
shift_data("65125", "Norma Fisher", 20250825, "D").
shift_data("43936", "Jorge Sullivan", 20250825, "SE").
shift_data("73691", "Elizabeth Woods", 20250825, "SN").
shift_data("49755", "Susan Wagner", 20250825, "SE").
shift_data("56930", "Peter Montgomery", 20250825, "LD").
shift_data("38631", "Theodore Mcgrath", 20250825, "LM").
shift_data("28254", "Stephanie Collins", 20250825, "D").
shift_data("28316", "Stephanie Sutton", 20250825, "WR").
shift_data("91050", "Brian Hamilton", 20250825, "LD").
shift_data("79804", "Susan Levy", 20250825, "WR").
shift_data("88892", "Sean Green", 20250825, "WR").
shift_data("50651", "Kimberly Smith", 20250825, "WR").
shift_data("19665", "Jennifer Summers", 20250825, "D").
shift_data("53279", "April Snyder", 20250825, "D").
shift_data("83375", "Dana Nguyen", 20250825, "SN").
shift_data("56372", "Cheryl Bradley", 20250825, "SN").
shift_data("51444", "Walter Pratt", 20250825, "LD").
shift_data("93941", "Bobby Flores", 20250825, "D").
shift_data("82420", "Tasha Rodriguez", 20250825, "SE").
shift_data("68024", "Michelle Kelley", 20250825, "D").
shift_data("65125", "Norma Fisher", 20250826, "LD").
shift_data("43936", "Jorge Sullivan", 20250826, "SN").
shift_data("73691", "Elizabeth Woods", 20250826, "WR").
shift_data("49755", "Susan Wagner", 20250826, "SN").
shift_data("56930", "Peter Montgomery", 20250826, "SE").
shift_data("38631", "Theodore Mcgrath", 20250826, "BT").
shift_data("28254", "Stephanie Collins", 20250826, "LD").
shift_data("28316", "Stephanie Sutton", 20250826, "WR").
shift_data("91050", "Brian Hamilton", 20250826, "SE").
shift_data("79804", "Susan Levy", 20250826, "D").
shift_data("88892", "Sean Green", 20250826, "D").
shift_data("50651", "Kimberly Smith", 20250826, "D").
shift_data("19665", "Jennifer Summers", 20250826, "D").
shift_data("53279", "April Snyder", 20250826, "WR").
shift_data("83375", "Dana Nguyen", 20250826, "WR").
shift_data("56372", "Cheryl Bradley", 20250826, "WR").
shift_data("51444", "Walter Pratt", 20250826, "SE").
shift_data("93941", "Bobby Flores", 20250826, "D").
shift_data("82420", "Tasha Rodriguez", 20250826, "SN").
shift_data("68024", "Michelle Kelley", 20250826, "LD").
shift_data("65125", "Norma Fisher", 20250827, "SE").
shift_data("43936", "Jorge Sullivan", 20250827, "WR").
shift_data("73691", "Elizabeth Woods", 20250827, "TR").
shift_data("49755", "Susan Wagner", 20250827, "WR").
shift_data("56930", "Peter Montgomery", 20250827, "SN").
shift_data("38631", "Theodore Mcgrath", 20250827, "LD").
shift_data("28254", "Stephanie Collins", 20250827, "SE").
shift_data("28316", "Stephanie Sutton", 20250827, "D").
shift_data("91050", "Brian Hamilton", 20250827, "SN").
shift_data("79804", "Susan Levy", 20250827, "LD").
shift_data("88892", "Sean Green", 20250827, "D").
shift_data("50651", "Kimberly Smith", 20250827, "D").
shift_data("19665", "Jennifer Summers", 20250827, "D").
shift_data("53279", "April Snyder", 20250827, "D").
shift_data("83375", "Dana Nguyen", 20250827, "AL").
shift_data("56372", "Cheryl Bradley", 20250827, "D").
shift_data("51444", "Walter Pratt", 20250827, "SN").
shift_data("93941", "Bobby Flores", 20250827, "LD").
shift_data("82420", "Tasha Rodriguez", 20250827, "WR").
shift_data("68024", "Michelle Kelley", 20250827, "SE").
shift_data("65125", "Norma Fisher", 20250828, "SN").
shift_data("43936", "Jorge Sullivan", 20250828, "LD").
shift_data("73691", "Elizabeth Woods", 20250828, "D").
shift_data("49755", "Susan Wagner", 20250828, "D").
shift_data("56930", "Peter Montgomery", 20250828, "WR").
shift_data("38631", "Theodore Mcgrath", 20250828, "SE").
shift_data("28254", "Stephanie Collins", 20250828, "SN").
shift_data("28316", "Stephanie Sutton", 20250828, "WR").
shift_data("91050", "Brian Hamilton", 20250828, "WR").
shift_data("79804", "Susan Levy", 20250828, "SE").
shift_data("88892", "Sean Green", 20250828, "LM").
shift_data("50651", "Kimberly Smith", 20250828, "D").
shift_data("19665", "Jennifer Summers", 20250828, "D").
shift_data("53279", "April Snyder", 20250828, "LD").
shift_data("83375", "Dana Nguyen", 20250828, "D").
shift_data("56372", "Cheryl Bradley", 20250828, "D").
shift_data("51444", "Walter Pratt", 20250828, "WR").
shift_data("93941", "Bobby Flores", 20250828, "SE").
shift_data("82420", "Tasha Rodriguez", 20250828, "LD").
shift_data("68024", "Michelle Kelley", 20250828, "SN").
shift_data("65125", "Norma Fisher", 20250829, "WR").
shift_data("43936", "Jorge Sullivan", 20250829, "SE").
shift_data("73691", "Elizabeth Woods", 20250829, "D").
shift_data("49755", "Susan Wagner", 20250829, "LD").
shift_data("56930", "Peter Montgomery", 20250829, "D").
shift_data("38631", "Theodore Mcgrath", 20250829, "SN").
shift_data("28254", "Stephanie Collins", 20250829, "WR").
shift_data("28316", "Stephanie Sutton", 20250829, "BL").
shift_data("91050", "Brian Hamilton", 20250829, "LD").
shift_data("79804", "Susan Levy", 20250829, "SN").
shift_data("88892", "Sean Green", 20250829, "SE").
shift_data("50651", "Kimberly Smith", 20250829, "D").
shift_data("19665", "Jennifer Summers", 20250829, "D").
shift_data("53279", "April Snyder", 20250829, "LM").
shift_data("83375", "Dana Nguyen", 20250829, "LD").
shift_data("56372", "Cheryl Bradley", 20250829, "D").
shift_data("51444", "Walter Pratt", 20250829, "WR").
shift_data("93941", "Bobby Flores", 20250829, "SN").
shift_data("82420", "Tasha Rodriguez", 20250829, "SE").
shift_data("68024", "Michelle Kelley", 20250829, "WR").
shift_data("65125", "Norma Fisher", 20250830, "LD").
shift_data("43936", "Jorge Sullivan", 20250830, "SN").
shift_data("73691", "Elizabeth Woods", 20250830, "WR").
shift_data("49755", "Susan Wagner", 20250830, "SE").
shift_data("56930", "Peter Montgomery", 20250830, "WR").
shift_data("38631", "Theodore Mcgrath", 20250830, "WR").
shift_data("28254", "Stephanie Collins", 20250830, "WR").
shift_data("28316", "Stephanie Sutton", 20250830, "D").
shift_data("91050", "Brian Hamilton", 20250830, "SE").
shift_data("79804", "Susan Levy", 20250830, "WR").
shift_data("88892", "Sean Green", 20250830, "SN").
shift_data("50651", "Kimberly Smith", 20250830, "TR").
shift_data("19665", "Jennifer Summers", 20250830, "WR").
shift_data("53279", "April Snyder", 20250830, "SE").
shift_data("83375", "Dana Nguyen", 20250830, "LM").
shift_data("56372", "Cheryl Bradley", 20250830, "WR").
shift_data("51444", "Walter Pratt", 20250830, "LD").
shift_data("93941", "Bobby Flores", 20250830, "WR").
shift_data("82420", "Tasha Rodriguez", 20250830, "SN").
shift_data("68024", "Michelle Kelley", 20250830, "D").
shift_data("65125", "Norma Fisher", 20250831, "SE").
shift_data("43936", "Jorge Sullivan", 20250831, "WR").
shift_data("73691", "Elizabeth Woods", 20250831, "WR").
shift_data("49755", "Susan Wagner", 20250831, "SN").
shift_data("56930", "Peter Montgomery", 20250831, "WR").
shift_data("38631", "Theodore Mcgrath", 20250831, "LD").
shift_data("28254", "Stephanie Collins", 20250831, "D").
shift_data("28316", "Stephanie Sutton", 20250831, "D").
shift_data("91050", "Brian Hamilton", 20250831, "SN").
shift_data("79804", "Susan Levy", 20250831, "WR").
shift_data("88892", "Sean Green", 20250831, "WR").
shift_data("50651", "Kimberly Smith", 20250831, "WR").
shift_data("19665", "Jennifer Summers", 20250831, "LD").
shift_data("53279", "April Snyder", 20250831, "SN").
shift_data("83375", "Dana Nguyen", 20250831, "SE").
shift_data("56372", "Cheryl Bradley", 20250831, "WR").
shift_data("51444", "Walter Pratt", 20250831, "SE").
shift_data("93941", "Bobby Flores", 20250831, "BT").
shift_data("82420", "Tasha Rodriguez", 20250831, "WR").
shift_data("68024", "Michelle Kelley", 20250831, "LD").
shift_data("65125", "Norma Fisher", 20250901, "SN").
shift_data("43936", "Jorge Sullivan", 20250901, "WR").
shift_data("73691", "Elizabeth Woods", 20250901, "D").
shift_data("49755", "Susan Wagner", 20250901, "WR").
shift_data("56930", "Peter Montgomery", 20250901, "LD").
shift_data("38631", "Theodore Mcgrath", 20250901, "SE").
shift_data("28254", "Stephanie Collins", 20250901, "D").
shift_data("28316", "Stephanie Sutton", 20250901, "LD").
shift_data("91050", "Brian Hamilton", 20250901, "WR").
shift_data("79804", "Susan Levy", 20250901, "D").
shift_data("88892", "Sean Green", 20250901, "WR").
shift_data("50651", "Kimberly Smith", 20250901, "D").
shift_data("19665", "Jennifer Summers", 20250901, "LM").
shift_data("53279", "April Snyder", 20250901, "WR").
shift_data("83375", "Dana Nguyen", 20250901, "SN").
shift_data("56372", "Cheryl Bradley", 20250901, "D").
shift_data("51444", "Walter Pratt", 20250901, "SN").
shift_data("93941", "Bobby Flores", 20250901, "LD").
shift_data("82420", "Tasha Rodriguez", 20250901, "WR").
shift_data("68024", "Michelle Kelley", 20250901, "SE").
shift_data("65125", "Norma Fisher", 20250902, "WR").
shift_data("43936", "Jorge Sullivan", 20250902, "LD").
shift_data("73691", "Elizabeth Woods", 20250902, "LM").
shift_data("49755", "Susan Wagner", 20250902, "WR").
shift_data("56930", "Peter Montgomery", 20250902, "SE").
shift_data("38631", "Theodore Mcgrath", 20250902, "SN").
shift_data("28254", "Stephanie Collins", 20250902, "D").
shift_data("28316", "Stephanie Sutton", 20250902, "SE").
shift_data("91050", "Brian Hamilton", 20250902, "WR").
shift_data("79804", "Susan Levy", 20250902, "LD").
shift_data("88892", "Sean Green", 20250902, "LD").
shift_data("50651", "Kimberly Smith", 20250902, "D").
shift_data("19665", "Jennifer Summers", 20250902, "SE").
shift_data("53279", "April Snyder", 20250902, "D").
shift_data("83375", "Dana Nguyen", 20250902, "WR").
shift_data("56372", "Cheryl Bradley", 20250902, "D").
shift_data("51444", "Walter Pratt", 20250902, "WR").
shift_data("93941", "Bobby Flores", 20250902, "SE").
shift_data("82420", "Tasha Rodriguez", 20250902, "BL").
shift_data("68024", "Michelle Kelley", 20250902, "SN").
shift_data("65125", "Norma Fisher", 20250903, "WR").
shift_data("43936", "Jorge Sullivan", 20250903, "LM").
shift_data("73691", "Elizabeth Woods", 20250903, "SE").
shift_data("49755", "Susan Wagner", 20250903, "LD").
shift_data("56930", "Peter Montgomery", 20250903, "SN").
shift_data("38631", "Theodore Mcgrath", 20250903, "WR").
shift_data("28254", "Stephanie Collins", 20250903, "WR").
shift_data("28316", "Stephanie Sutton", 20250903, "SN").
shift_data("91050", "Brian Hamilton", 20250903, "D").
shift_data("79804", "Susan Levy", 20250903, "SE").
shift_data("88892", "Sean Green", 20250903, "SE").
shift_data("50651", "Kimberly Smith", 20250903, "D").
shift_data("19665", "Jennifer Summers", 20250903, "SN").
shift_data("53279", "April Snyder", 20250903, "LD").
shift_data("83375", "Dana Nguyen", 20250903, "LD").
shift_data("56372", "Cheryl Bradley", 20250903, "D").
shift_data("51444", "Walter Pratt", 20250903, "WR").
shift_data("93941", "Bobby Flores", 20250903, "SN").
shift_data("82420", "Tasha Rodriguez", 20250903, "LD").
shift_data("68024", "Michelle Kelley", 20250903, "WR").
shift_data("65125", "Norma Fisher", 20250904, "LD").
shift_data("43936", "Jorge Sullivan", 20250904, "SE").
shift_data("73691", "Elizabeth Woods", 20250904, "SN").
shift_data("49755", "Susan Wagner", 20250904, "LM").
shift_data("56930", "Peter Montgomery", 20250904, "WR").
shift_data("38631", "Theodore Mcgrath", 20250904, "D").
shift_data("28254", "Stephanie Collins", 20250904, "LD").
shift_data("28316", "Stephanie Sutton", 20250904, "WR").
shift_data("91050", "Brian Hamilton", 20250904, "LD").
shift_data("79804", "Susan Levy", 20250904, "SN").
shift_data("88892", "Sean Green", 20250904, "SN").
shift_data("50651", "Kimberly Smith", 20250904, "D").
shift_data("19665", "Jennifer Summers", 20250904, "WR").
shift_data("53279", "April Snyder", 20250904, "SE").
shift_data("83375", "Dana Nguyen", 20250904, "SE").
shift_data("56372", "Cheryl Bradley", 20250904, "D").
shift_data("51444", "Walter Pratt", 20250904, "LD").
shift_data("93941", "Bobby Flores", 20250904, "WR").
shift_data("82420", "Tasha Rodriguez", 20250904, "SE").
shift_data("68024", "Michelle Kelley", 20250904, "D").
shift_data("65125", "Norma Fisher", 20250905, "SE").
shift_data("43936", "Jorge Sullivan", 20250905, "SN").
shift_data("73691", "Elizabeth Woods", 20250905, "WR").
shift_data("49755", "Susan Wagner", 20250905, "WR").
shift_data("56930", "Peter Montgomery", 20250905, "LD").
shift_data("38631", "Theodore Mcgrath", 20250905, "D").
shift_data("28254", "Stephanie Collins", 20250905, "SE").
shift_data("28316", "Stephanie Sutton", 20250905, "LD").
shift_data("91050", "Brian Hamilton", 20250905, "SE").
shift_data("79804", "Susan Levy", 20250905, "WR").
shift_data("88892", "Sean Green", 20250905, "WR").
shift_data("50651", "Kimberly Smith", 20250905, "D").
shift_data("19665", "Jennifer Summers", 20250905, "D").
shift_data("53279", "April Snyder", 20250905, "SN").
shift_data("83375", "Dana Nguyen", 20250905, "SN").
shift_data("56372", "Cheryl Bradley", 20250905, "D").
shift_data("51444", "Walter Pratt", 20250905, "LM").
shift_data("93941", "Bobby Flores", 20250905, "D").
shift_data("82420", "Tasha Rodriguez", 20250905, "SN").
shift_data("68024", "Michelle Kelley", 20250905, "D").
shift_data("65125", "Norma Fisher", 20250906, "SN").
shift_data("43936", "Jorge Sullivan", 20250906, "WR").
shift_data("73691", "Elizabeth Woods", 20250906, "D").
shift_data("49755", "Susan Wagner", 20250906, "LD").
shift_data("56930", "Peter Montgomery", 20250906, "SE").
shift_data("38631", "Theodore Mcgrath", 20250906, "WR").
shift_data("28254", "Stephanie Collins", 20250906, "SN").
shift_data("28316", "Stephanie Sutton", 20250906, "SE").
shift_data("91050", "Brian Hamilton", 20250906, "SN").
shift_data("79804", "Susan Levy", 20250906, "LD").
shift_data("88892", "Sean Green", 20250906, "D").
shift_data("50651", "Kimberly Smith", 20250906, "WR").
shift_data("19665", "Jennifer Summers", 20250906, "WR").
shift_data("53279", "April Snyder", 20250906, "WR").
shift_data("83375", "Dana Nguyen", 20250906, "WR").
shift_data("56372", "Cheryl Bradley", 20250906, "WR").
shift_data("51444", "Walter Pratt", 20250906, "SE").
shift_data("93941", "Bobby Flores", 20250906, "WR").
shift_data("82420", "Tasha Rodriguez", 20250906, "WR").
shift_data("68024", "Michelle Kelley", 20250906, "WR").
shift_data("65125", "Norma Fisher", 20250907, "WR").
shift_data("43936", "Jorge Sullivan", 20250907, "LD").
shift_data("73691", "Elizabeth Woods", 20250907, "LD").
shift_data("49755", "Susan Wagner", 20250907, "SE").
shift_data("56930", "Peter Montgomery", 20250907, "SN").
shift_data("38631", "Theodore Mcgrath", 20250907, "WR").
shift_data("28254", "Stephanie Collins", 20250907, "WR").
shift_data("28316", "Stephanie Sutton", 20250907, "SN").
shift_data("91050", "Brian Hamilton", 20250907, "WR").
shift_data("79804", "Susan Levy", 20250907, "SE").
shift_data("88892", "Sean Green", 20250907, "LD").
shift_data("50651", "Kimberly Smith", 20250907, "WR").
shift_data("19665", "Jennifer Summers", 20250907, "WR").
shift_data("53279", "April Snyder", 20250907, "WR").
shift_data("83375", "Dana Nguyen", 20250907, "WR").
shift_data("56372", "Cheryl Bradley", 20250907, "D").
shift_data("51444", "Walter Pratt", 20250907, "SN").
shift_data("93941", "Bobby Flores", 20250907, "WR").
shift_data("82420", "Tasha Rodriguez", 20250907, "LD").
shift_data("68024", "Michelle Kelley", 20250907, "WR").
% Past dates -------------------------------------
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
