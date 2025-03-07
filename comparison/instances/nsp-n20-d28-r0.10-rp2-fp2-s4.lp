% Staffs -----------------------------------------
staff(1, "Brian Foster", "Nurse", "49753", 7).
staff(2, "Austin Morales", "Nurse", "61912", 7).
staff(3, "Rebecca Hubbard", "Nurse", "30312", 8).
staff(4, "Joshua Hill", "Nurse", "18718", 7).
staff(5, "Brian Lewis", "Nurse", "62637", 7).
staff(6, "Sandra Roman", "Nurse", "47929", 9).
staff(7, "Cheryl Collins", "Nurse", "39088", 4).
staff(8, "Monique Bond", "Nurse", "80343", 6).
staff(9, "Angelica Obrien", "Nurse", "46265", 5).
staff(10, "Katie Thompson", "Nurse", "23917", 4).
staff(11, "Brandon Michael", "Nurse", "38101", 5).
staff(12, "Kimberly Evans", "Nurse", "93976", 4).
staff(13, "Laura Khan", "Nurse", "45618", 5).
staff(14, "Katie Gutierrez", "Nurse", "31603", 4).
staff(15, "Jessica Martin", "Nurse", "47963", 5).
staff(16, "Robert Williams", "Nurse", "58810", 6).
staff(17, "Mark Ramirez", "Nurse", "89410", 1).
staff(18, "Kaitlin Cooper", "Nurse", "98041", 2).
staff(19, "Christina Gutierrez MD", "Nurse", "76316", 2).
staff(20, "Desiree Kelly", "Nurse", "33303", 1).
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
shifts_soft_lb(9, "LD", 4).
shifts_soft_ub(9, "LD", 8).
shifts_soft_lb(9, "SE", 4).
shifts_soft_ub(9, "SE", 8).
shifts_soft_lb(9, "SN", 4).
shifts_soft_ub(9, "SN", 8).
shifts_hard_ub(9, "E", 0).
shifts_hard_ub(9, "N", 0).
shifts_hard_ub(9, "EM", 0).
shifts_hard_ub(9, "LM", 1).
shifts_soft_lb(10, "LD", 4).
shifts_soft_ub(10, "LD", 8).
shifts_soft_lb(10, "SE", 4).
shifts_soft_ub(10, "SE", 8).
shifts_soft_lb(10, "SN", 4).
shifts_soft_ub(10, "SN", 8).
shifts_hard_ub(10, "E", 0).
shifts_hard_ub(10, "N", 0).
shifts_hard_ub(10, "EM", 0).
shifts_hard_ub(10, "LM", 1).
shifts_soft_lb(11, "LD", 4).
shifts_soft_ub(11, "LD", 8).
shifts_soft_lb(11, "SE", 4).
shifts_soft_ub(11, "SE", 8).
shifts_soft_lb(11, "SN", 4).
shifts_soft_ub(11, "SN", 8).
shifts_hard_ub(11, "E", 0).
shifts_hard_ub(11, "N", 0).
shifts_hard_ub(11, "EM", 0).
shifts_hard_ub(11, "LM", 1).
shifts_soft_lb(12, "LD", 4).
shifts_soft_ub(12, "LD", 8).
shifts_soft_lb(12, "SE", 4).
shifts_soft_ub(12, "SE", 8).
shifts_soft_lb(12, "SN", 4).
shifts_soft_ub(12, "SN", 8).
shifts_hard_ub(12, "E", 0).
shifts_hard_ub(12, "N", 0).
shifts_hard_ub(12, "EM", 0).
shifts_hard_ub(12, "LM", 1).
shifts_soft_lb(13, "LD", 4).
shifts_soft_ub(13, "LD", 8).
shifts_soft_lb(13, "SE", 4).
shifts_soft_ub(13, "SE", 8).
shifts_soft_lb(13, "SN", 4).
shifts_soft_ub(13, "SN", 8).
shifts_hard_ub(13, "E", 0).
shifts_hard_ub(13, "N", 0).
shifts_hard_ub(13, "EM", 0).
shifts_hard_ub(13, "LM", 1).
shifts_soft_lb(14, "LD", 4).
shifts_soft_ub(14, "LD", 8).
shifts_soft_lb(14, "SE", 4).
shifts_soft_ub(14, "SE", 8).
shifts_soft_lb(14, "SN", 4).
shifts_soft_ub(14, "SN", 8).
shifts_hard_ub(14, "E", 0).
shifts_hard_ub(14, "N", 0).
shifts_hard_ub(14, "EM", 0).
shifts_hard_ub(14, "LM", 1).
shifts_soft_lb(15, "LD", 4).
shifts_soft_ub(15, "LD", 8).
shifts_soft_lb(15, "SE", 4).
shifts_soft_ub(15, "SE", 8).
shifts_soft_lb(15, "SN", 4).
shifts_soft_ub(15, "SN", 8).
shifts_hard_ub(15, "E", 0).
shifts_hard_ub(15, "N", 0).
shifts_hard_ub(15, "EM", 0).
shifts_hard_ub(15, "LM", 1).
shifts_soft_lb(16, "LD", 4).
shifts_soft_ub(16, "LD", 8).
shifts_soft_lb(16, "SE", 4).
shifts_soft_ub(16, "SE", 8).
shifts_soft_lb(16, "SN", 4).
shifts_soft_ub(16, "SN", 8).
shifts_hard_ub(16, "E", 0).
shifts_hard_ub(16, "N", 0).
shifts_hard_ub(16, "EM", 0).
shifts_hard_ub(16, "LM", 1).
shifts_soft_lb(17, "LD", 2).
shifts_soft_ub(17, "LD", 4).
shifts_soft_lb(17, "SE", 2).
shifts_soft_ub(17, "SE", 4).
shifts_soft_lb(17, "SN", 2).
shifts_soft_ub(17, "SN", 4).
shifts_hard_ub(17, "E", 0).
shifts_hard_ub(17, "N", 0).
shifts_hard_ub(17, "EM", 0).
shifts_hard_ub(17, "LM", 1).
shifts_soft_lb(18, "LD", 2).
shifts_soft_ub(18, "LD", 4).
shifts_soft_lb(18, "SE", 2).
shifts_soft_ub(18, "SE", 4).
shifts_soft_lb(18, "SN", 2).
shifts_soft_ub(18, "SN", 4).
shifts_hard_ub(18, "E", 0).
shifts_hard_ub(18, "N", 0).
shifts_hard_ub(18, "EM", 0).
shifts_hard_ub(18, "LM", 1).
shifts_soft_lb(19, "LD", 2).
shifts_soft_ub(19, "LD", 4).
shifts_soft_lb(19, "SE", 2).
shifts_soft_ub(19, "SE", 4).
shifts_soft_lb(19, "SN", 2).
shifts_soft_ub(19, "SN", 4).
shifts_hard_ub(19, "E", 0).
shifts_hard_ub(19, "N", 0).
shifts_hard_ub(19, "EM", 0).
shifts_hard_ub(19, "LM", 1).
shifts_soft_lb(20, "LD", 2).
shifts_soft_ub(20, "LD", 4).
shifts_soft_lb(20, "SE", 2).
shifts_soft_ub(20, "SE", 4).
shifts_soft_lb(20, "SN", 2).
shifts_soft_ub(20, "SN", 4).
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
staff_pos_request(8, 30, "BT").
staff_pos_request(3, 19, "D").
staff_pos_request(10, 19, "WR").
staff_pos_request(14, 27, "BT").
staff_neg_request(14, 28, "SN").
staff_pos_request(8, 19, "BT").
staff_pos_request(2, 5, "D").
staff_pos_request(15, 17, "BL").
staff_pos_request(11, 9, "WR").
staff_pos_request(3, 26, "WR").
staff_neg_request(15, 17, "SN").
staff_pos_request(12, 27, "TR").
staff_pos_request(18, 12, "TR").
staff_pos_request(4, 3, "WR").
staff_neg_request(9, 15, "SE").
staff_pos_request(11, 11, "BT").
staff_pos_request(15, 1, "D").
staff_pos_request(12, 5, "BT").
staff_pos_request(11, 1, "TR").
staff_neg_request(10, 20, "SN").
staff_pos_request(14, 4, "BT").
staff_pos_request(20, 12, "BL").
staff_pos_request(10, 8, "BT").
staff_pos_request(13, 10, "TR").
staff_pos_request(19, 0, "TR").
staff_neg_request(2, 29, "SN").
staff_pos_request(12, 23, "BT").
staff_pos_request(19, 6, "BL").
staff_pos_request(7, 27, "WR").
staff_pos_request(4, 3, "D").
staff_neg_request(2, 10, "SN").
staff_pos_request(20, 2, "BL").
staff_pos_request(19, 15, "TR").
staff_pos_request(2, 7, "BT").
staff_pos_request(14, 12, "BL").
staff_pos_request(7, 15, "BL").
staff_pos_request(14, 31, "D").
staff_pos_request(8, 26, "BL").
staff_pos_request(8, 27, "WR").
staff_pos_request(16, 12, "D").
staff_pos_request(2, 16, "BT").
staff_pos_request(8, 33, "WR").
staff_pos_request(5, 20, "D").
staff_pos_request(11, 7, "AL").
staff_pos_request(2, 31, "AL").
staff_pos_request(3, 27, "WR").
staff_pos_request(19, 10, "TR").
staff_pos_request(10, 30, "TR").
staff_pos_request(14, 33, "WR").
staff_pos_request(9, 21, "AL").
staff_pos_request(16, 4, "BT").
staff_pos_request(7, 2, "AL").
staff_pos_request(20, 8, "BT").
staff_pos_request(2, 10, "BL").
staff_pos_request(19, 30, "AL").
staff_pos_request(13, 13, "D").
% Pairs ------------------------------------------
recommended_night_pair(7, 18, 4).
recommended_night_pair(1, 19, 4).
forbidden_night_pair(4, 13).
forbidden_night_pair(13, 8).
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
shift_data("49753", "Brian Foster", 20250811, "SE").
shift_data("61912", "Austin Morales", 20250811, "D").
shift_data("30312", "Rebecca Hubbard", 20250811, "PH").
shift_data("18718", "Joshua Hill", 20250811, "PH").
shift_data("62637", "Brian Lewis", 20250811, "LD").
shift_data("47929", "Sandra Roman", 20250811, "SN").
shift_data("39088", "Cheryl Collins", 20250811, "PH").
shift_data("80343", "Monique Bond", 20250811, "PH").
shift_data("46265", "Angelica Obrien", 20250811, "PH").
shift_data("23917", "Katie Thompson", 20250811, "LD").
shift_data("38101", "Brandon Michael", 20250811, "D").
shift_data("93976", "Kimberly Evans", 20250811, "PH").
shift_data("45618", "Laura Khan", 20250811, "SN").
shift_data("31603", "Katie Gutierrez", 20250811, "SE").
shift_data("47963", "Jessica Martin", 20250811, "PH").
shift_data("58810", "Robert Williams", 20250811, "LD").
shift_data("89410", "Mark Ramirez", 20250811, "PH").
shift_data("98041", "Kaitlin Cooper", 20250811, "PH").
shift_data("76316", "Christina Gutierrez MD", 20250811, "TR").
shift_data("33303", "Desiree Kelly", 20250811, "SE").
shift_data("49753", "Brian Foster", 20250812, "SN").
shift_data("61912", "Austin Morales", 20250812, "LD").
shift_data("30312", "Rebecca Hubbard", 20250812, "D").
shift_data("18718", "Joshua Hill", 20250812, "D").
shift_data("62637", "Brian Lewis", 20250812, "SE").
shift_data("47929", "Sandra Roman", 20250812, "WR").
shift_data("39088", "Cheryl Collins", 20250812, "D").
shift_data("80343", "Monique Bond", 20250812, "LD").
shift_data("46265", "Angelica Obrien", 20250812, "WR").
shift_data("23917", "Katie Thompson", 20250812, "SE").
shift_data("38101", "Brandon Michael", 20250812, "TR").
shift_data("93976", "Kimberly Evans", 20250812, "WR").
shift_data("45618", "Laura Khan", 20250812, "WR").
shift_data("31603", "Katie Gutierrez", 20250812, "SN").
shift_data("47963", "Jessica Martin", 20250812, "D").
shift_data("58810", "Robert Williams", 20250812, "SE").
shift_data("89410", "Mark Ramirez", 20250812, "LD").
shift_data("98041", "Kaitlin Cooper", 20250812, "D").
shift_data("76316", "Christina Gutierrez MD", 20250812, "D").
shift_data("33303", "Desiree Kelly", 20250812, "SN").
shift_data("49753", "Brian Foster", 20250813, "WR").
shift_data("61912", "Austin Morales", 20250813, "SE").
shift_data("30312", "Rebecca Hubbard", 20250813, "D").
shift_data("18718", "Joshua Hill", 20250813, "D").
shift_data("62637", "Brian Lewis", 20250813, "SN").
shift_data("47929", "Sandra Roman", 20250813, "LD").
shift_data("39088", "Cheryl Collins", 20250813, "AL").
shift_data("80343", "Monique Bond", 20250813, "SE").
shift_data("46265", "Angelica Obrien", 20250813, "WR").
shift_data("23917", "Katie Thompson", 20250813, "SN").
shift_data("38101", "Brandon Michael", 20250813, "WR").
shift_data("93976", "Kimberly Evans", 20250813, "D").
shift_data("45618", "Laura Khan", 20250813, "WR").
shift_data("31603", "Katie Gutierrez", 20250813, "WR").
shift_data("47963", "Jessica Martin", 20250813, "LD").
shift_data("58810", "Robert Williams", 20250813, "SN").
shift_data("89410", "Mark Ramirez", 20250813, "SE").
shift_data("98041", "Kaitlin Cooper", 20250813, "D").
shift_data("76316", "Christina Gutierrez MD", 20250813, "LM").
shift_data("33303", "Desiree Kelly", 20250813, "BL").
shift_data("49753", "Brian Foster", 20250814, "D").
shift_data("61912", "Austin Morales", 20250814, "SN").
shift_data("30312", "Rebecca Hubbard", 20250814, "LD").
shift_data("18718", "Joshua Hill", 20250814, "D").
shift_data("62637", "Brian Lewis", 20250814, "WR").
shift_data("47929", "Sandra Roman", 20250814, "SE").
shift_data("39088", "Cheryl Collins", 20250814, "D").
shift_data("80343", "Monique Bond", 20250814, "SN").
shift_data("46265", "Angelica Obrien", 20250814, "LD").
shift_data("23917", "Katie Thompson", 20250814, "WR").
shift_data("38101", "Brandon Michael", 20250814, "LM").
shift_data("93976", "Kimberly Evans", 20250814, "D").
shift_data("45618", "Laura Khan", 20250814, "WR").
shift_data("31603", "Katie Gutierrez", 20250814, "LD").
shift_data("47963", "Jessica Martin", 20250814, "SE").
shift_data("58810", "Robert Williams", 20250814, "WR").
shift_data("89410", "Mark Ramirez", 20250814, "SN").
shift_data("98041", "Kaitlin Cooper", 20250814, "D").
shift_data("76316", "Christina Gutierrez MD", 20250814, "SE").
shift_data("33303", "Desiree Kelly", 20250814, "WR").
shift_data("49753", "Brian Foster", 20250815, "LD").
shift_data("61912", "Austin Morales", 20250815, "WR").
shift_data("30312", "Rebecca Hubbard", 20250815, "SE").
shift_data("18718", "Joshua Hill", 20250815, "D").
shift_data("62637", "Brian Lewis", 20250815, "WR").
shift_data("47929", "Sandra Roman", 20250815, "SN").
shift_data("39088", "Cheryl Collins", 20250815, "LD").
shift_data("80343", "Monique Bond", 20250815, "WR").
shift_data("46265", "Angelica Obrien", 20250815, "SE").
shift_data("23917", "Katie Thompson", 20250815, "D").
shift_data("38101", "Brandon Michael", 20250815, "SE").
shift_data("93976", "Kimberly Evans", 20250815, "WR").
shift_data("45618", "Laura Khan", 20250815, "D").
shift_data("31603", "Katie Gutierrez", 20250815, "BT").
shift_data("47963", "Jessica Martin", 20250815, "SN").
shift_data("58810", "Robert Williams", 20250815, "BT").
shift_data("89410", "Mark Ramirez", 20250815, "WR").
shift_data("98041", "Kaitlin Cooper", 20250815, "D").
shift_data("76316", "Christina Gutierrez MD", 20250815, "SN").
shift_data("33303", "Desiree Kelly", 20250815, "LD").
shift_data("49753", "Brian Foster", 20250816, "SE").
shift_data("61912", "Austin Morales", 20250816, "D").
shift_data("30312", "Rebecca Hubbard", 20250816, "SN").
shift_data("18718", "Joshua Hill", 20250816, "WR").
shift_data("62637", "Brian Lewis", 20250816, "LD").
shift_data("47929", "Sandra Roman", 20250816, "WR").
shift_data("39088", "Cheryl Collins", 20250816, "SE").
shift_data("80343", "Monique Bond", 20250816, "WR").
shift_data("46265", "Angelica Obrien", 20250816, "SN").
shift_data("23917", "Katie Thompson", 20250816, "D").
shift_data("38101", "Brandon Michael", 20250816, "SN").
shift_data("93976", "Kimberly Evans", 20250816, "BT").
shift_data("45618", "Laura Khan", 20250816, "LD").
shift_data("31603", "Katie Gutierrez", 20250816, "WR").
shift_data("47963", "Jessica Martin", 20250816, "WR").
shift_data("58810", "Robert Williams", 20250816, "LD").
shift_data("89410", "Mark Ramirez", 20250816, "WR").
shift_data("98041", "Kaitlin Cooper", 20250816, "WR").
shift_data("76316", "Christina Gutierrez MD", 20250816, "WR").
shift_data("33303", "Desiree Kelly", 20250816, "SE").
shift_data("49753", "Brian Foster", 20250817, "SN").
shift_data("61912", "Austin Morales", 20250817, "D").
shift_data("30312", "Rebecca Hubbard", 20250817, "WR").
shift_data("18718", "Joshua Hill", 20250817, "LD").
shift_data("62637", "Brian Lewis", 20250817, "SE").
shift_data("47929", "Sandra Roman", 20250817, "D").
shift_data("39088", "Cheryl Collins", 20250817, "SN").
shift_data("80343", "Monique Bond", 20250817, "WR").
shift_data("46265", "Angelica Obrien", 20250817, "WR").
shift_data("23917", "Katie Thompson", 20250817, "WR").
shift_data("38101", "Brandon Michael", 20250817, "WR").
shift_data("93976", "Kimberly Evans", 20250817, "LD").
shift_data("45618", "Laura Khan", 20250817, "SE").
shift_data("31603", "Katie Gutierrez", 20250817, "WR").
shift_data("47963", "Jessica Martin", 20250817, "WR").
shift_data("58810", "Robert Williams", 20250817, "SE").
shift_data("89410", "Mark Ramirez", 20250817, "D").
shift_data("98041", "Kaitlin Cooper", 20250817, "LD").
shift_data("76316", "Christina Gutierrez MD", 20250817, "BL").
shift_data("33303", "Desiree Kelly", 20250817, "SN").
shift_data("49753", "Brian Foster", 20250818, "WR").
shift_data("61912", "Austin Morales", 20250818, "BT").
shift_data("30312", "Rebecca Hubbard", 20250818, "LD").
shift_data("18718", "Joshua Hill", 20250818, "SE").
shift_data("62637", "Brian Lewis", 20250818, "SN").
shift_data("47929", "Sandra Roman", 20250818, "WR").
shift_data("39088", "Cheryl Collins", 20250818, "WR").
shift_data("80343", "Monique Bond", 20250818, "LD").
shift_data("46265", "Angelica Obrien", 20250818, "LD").
shift_data("23917", "Katie Thompson", 20250818, "WR").
shift_data("38101", "Brandon Michael", 20250818, "AL").
shift_data("93976", "Kimberly Evans", 20250818, "SE").
shift_data("45618", "Laura Khan", 20250818, "SN").
shift_data("31603", "Katie Gutierrez", 20250818, "WR").
shift_data("47963", "Jessica Martin", 20250818, "D").
shift_data("58810", "Robert Williams", 20250818, "SN").
shift_data("89410", "Mark Ramirez", 20250818, "D").
shift_data("98041", "Kaitlin Cooper", 20250818, "SE").
shift_data("76316", "Christina Gutierrez MD", 20250818, "D").
shift_data("33303", "Desiree Kelly", 20250818, "WR").
shift_data("49753", "Brian Foster", 20250819, "LD").
shift_data("61912", "Austin Morales", 20250819, "WR").
shift_data("30312", "Rebecca Hubbard", 20250819, "SE").
shift_data("18718", "Joshua Hill", 20250819, "SN").
shift_data("62637", "Brian Lewis", 20250819, "WR").
shift_data("47929", "Sandra Roman", 20250819, "WR").
shift_data("39088", "Cheryl Collins", 20250819, "LD").
shift_data("80343", "Monique Bond", 20250819, "SE").
shift_data("46265", "Angelica Obrien", 20250819, "SE").
shift_data("23917", "Katie Thompson", 20250819, "BT").
shift_data("38101", "Brandon Michael", 20250819, "D").
shift_data("93976", "Kimberly Evans", 20250819, "SN").
shift_data("45618", "Laura Khan", 20250819, "WR").
shift_data("31603", "Katie Gutierrez", 20250819, "D").
shift_data("47963", "Jessica Martin", 20250819, "D").
shift_data("58810", "Robert Williams", 20250819, "WR").
shift_data("89410", "Mark Ramirez", 20250819, "LD").
shift_data("98041", "Kaitlin Cooper", 20250819, "SN").
shift_data("76316", "Christina Gutierrez MD", 20250819, "D").
shift_data("33303", "Desiree Kelly", 20250819, "BT").
shift_data("49753", "Brian Foster", 20250820, "SE").
shift_data("61912", "Austin Morales", 20250820, "D").
shift_data("30312", "Rebecca Hubbard", 20250820, "SN").
shift_data("18718", "Joshua Hill", 20250820, "WR").
shift_data("62637", "Brian Lewis", 20250820, "LD").
shift_data("47929", "Sandra Roman", 20250820, "D").
shift_data("39088", "Cheryl Collins", 20250820, "SE").
shift_data("80343", "Monique Bond", 20250820, "SN").
shift_data("46265", "Angelica Obrien", 20250820, "SN").
shift_data("23917", "Katie Thompson", 20250820, "LD").
shift_data("38101", "Brandon Michael", 20250820, "WR").
shift_data("93976", "Kimberly Evans", 20250820, "WR").
shift_data("45618", "Laura Khan", 20250820, "D").
shift_data("31603", "Katie Gutierrez", 20250820, "LM").
shift_data("47963", "Jessica Martin", 20250820, "WR").
shift_data("58810", "Robert Williams", 20250820, "D").
shift_data("89410", "Mark Ramirez", 20250820, "SE").
shift_data("98041", "Kaitlin Cooper", 20250820, "WR").
shift_data("76316", "Christina Gutierrez MD", 20250820, "D").
shift_data("33303", "Desiree Kelly", 20250820, "LD").
shift_data("49753", "Brian Foster", 20250821, "SN").
shift_data("61912", "Austin Morales", 20250821, "BL").
shift_data("30312", "Rebecca Hubbard", 20250821, "WR").
shift_data("18718", "Joshua Hill", 20250821, "LD").
shift_data("62637", "Brian Lewis", 20250821, "SE").
shift_data("47929", "Sandra Roman", 20250821, "D").
shift_data("39088", "Cheryl Collins", 20250821, "SN").
shift_data("80343", "Monique Bond", 20250821, "WR").
shift_data("46265", "Angelica Obrien", 20250821, "WR").
shift_data("23917", "Katie Thompson", 20250821, "SE").
shift_data("38101", "Brandon Michael", 20250821, "D").
shift_data("93976", "Kimberly Evans", 20250821, "LD").
shift_data("45618", "Laura Khan", 20250821, "TR").
shift_data("31603", "Katie Gutierrez", 20250821, "SE").
shift_data("47963", "Jessica Martin", 20250821, "LD").
shift_data("58810", "Robert Williams", 20250821, "D").
shift_data("89410", "Mark Ramirez", 20250821, "SN").
shift_data("98041", "Kaitlin Cooper", 20250821, "LD").
shift_data("76316", "Christina Gutierrez MD", 20250821, "TR").
shift_data("33303", "Desiree Kelly", 20250821, "SE").
shift_data("49753", "Brian Foster", 20250822, "WR").
shift_data("61912", "Austin Morales", 20250822, "D").
shift_data("30312", "Rebecca Hubbard", 20250822, "LD").
shift_data("18718", "Joshua Hill", 20250822, "SE").
shift_data("62637", "Brian Lewis", 20250822, "SN").
shift_data("47929", "Sandra Roman", 20250822, "WR").
shift_data("39088", "Cheryl Collins", 20250822, "WR").
shift_data("80343", "Monique Bond", 20250822, "LD").
shift_data("46265", "Angelica Obrien", 20250822, "LD").
shift_data("23917", "Katie Thompson", 20250822, "SN").
shift_data("38101", "Brandon Michael", 20250822, "BT").
shift_data("93976", "Kimberly Evans", 20250822, "SE").
shift_data("45618", "Laura Khan", 20250822, "D").
shift_data("31603", "Katie Gutierrez", 20250822, "SN").
shift_data("47963", "Jessica Martin", 20250822, "SE").
shift_data("58810", "Robert Williams", 20250822, "D").
shift_data("89410", "Mark Ramirez", 20250822, "WR").
shift_data("98041", "Kaitlin Cooper", 20250822, "WR").
shift_data("76316", "Christina Gutierrez MD", 20250822, "D").
shift_data("33303", "Desiree Kelly", 20250822, "SN").
shift_data("49753", "Brian Foster", 20250823, "D").
shift_data("61912", "Austin Morales", 20250823, "LD").
shift_data("30312", "Rebecca Hubbard", 20250823, "SE").
shift_data("18718", "Joshua Hill", 20250823, "SN").
shift_data("62637", "Brian Lewis", 20250823, "WR").
shift_data("47929", "Sandra Roman", 20250823, "WR").
shift_data("39088", "Cheryl Collins", 20250823, "LM").
shift_data("80343", "Monique Bond", 20250823, "SE").
shift_data("46265", "Angelica Obrien", 20250823, "SE").
shift_data("23917", "Katie Thompson", 20250823, "WR").
shift_data("38101", "Brandon Michael", 20250823, "LD").
shift_data("93976", "Kimberly Evans", 20250823, "SN").
shift_data("45618", "Laura Khan", 20250823, "WR").
shift_data("31603", "Katie Gutierrez", 20250823, "BL").
shift_data("47963", "Jessica Martin", 20250823, "SN").
shift_data("58810", "Robert Williams", 20250823, "D").
shift_data("89410", "Mark Ramirez", 20250823, "WR").
shift_data("98041", "Kaitlin Cooper", 20250823, "TR").
shift_data("76316", "Christina Gutierrez MD", 20250823, "WR").
shift_data("33303", "Desiree Kelly", 20250823, "BL").
shift_data("49753", "Brian Foster", 20250824, "D").
shift_data("61912", "Austin Morales", 20250824, "SE").
shift_data("30312", "Rebecca Hubbard", 20250824, "SN").
shift_data("18718", "Joshua Hill", 20250824, "WR").
shift_data("62637", "Brian Lewis", 20250824, "WR").
shift_data("47929", "Sandra Roman", 20250824, "LD").
shift_data("39088", "Cheryl Collins", 20250824, "SE").
shift_data("80343", "Monique Bond", 20250824, "SN").
shift_data("46265", "Angelica Obrien", 20250824, "SN").
shift_data("23917", "Katie Thompson", 20250824, "WR").
shift_data("38101", "Brandon Michael", 20250824, "SE").
shift_data("93976", "Kimberly Evans", 20250824, "WR").
shift_data("45618", "Laura Khan", 20250824, "D").
shift_data("31603", "Katie Gutierrez", 20250824, "LD").
shift_data("47963", "Jessica Martin", 20250824, "WR").
shift_data("58810", "Robert Williams", 20250824, "WR").
shift_data("89410", "Mark Ramirez", 20250824, "WR").
shift_data("98041", "Kaitlin Cooper", 20250824, "LD").
shift_data("76316", "Christina Gutierrez MD", 20250824, "WR").
shift_data("33303", "Desiree Kelly", 20250824, "WR").
shift_data("49753", "Brian Foster", 20250825, "LM").
shift_data("61912", "Austin Morales", 20250825, "SN").
shift_data("30312", "Rebecca Hubbard", 20250825, "WR").
shift_data("18718", "Joshua Hill", 20250825, "LD").
shift_data("62637", "Brian Lewis", 20250825, "WR").
shift_data("47929", "Sandra Roman", 20250825, "SE").
shift_data("39088", "Cheryl Collins", 20250825, "SN").
shift_data("80343", "Monique Bond", 20250825, "WR").
shift_data("46265", "Angelica Obrien", 20250825, "WR").
shift_data("23917", "Katie Thompson", 20250825, "D").
shift_data("38101", "Brandon Michael", 20250825, "SN").
shift_data("93976", "Kimberly Evans", 20250825, "LD").
shift_data("45618", "Laura Khan", 20250825, "D").
shift_data("31603", "Katie Gutierrez", 20250825, "WR").
shift_data("47963", "Jessica Martin", 20250825, "LD").
shift_data("58810", "Robert Williams", 20250825, "WR").
shift_data("89410", "Mark Ramirez", 20250825, "D").
shift_data("98041", "Kaitlin Cooper", 20250825, "SE").
shift_data("76316", "Christina Gutierrez MD", 20250825, "D").
shift_data("33303", "Desiree Kelly", 20250825, "D").
shift_data("49753", "Brian Foster", 20250826, "WR").
shift_data("61912", "Austin Morales", 20250826, "WR").
shift_data("30312", "Rebecca Hubbard", 20250826, "LD").
shift_data("18718", "Joshua Hill", 20250826, "SE").
shift_data("62637", "Brian Lewis", 20250826, "D").
shift_data("47929", "Sandra Roman", 20250826, "SN").
shift_data("39088", "Cheryl Collins", 20250826, "BL").
shift_data("80343", "Monique Bond", 20250826, "D").
shift_data("46265", "Angelica Obrien", 20250826, "WR").
shift_data("23917", "Katie Thompson", 20250826, "LD").
shift_data("38101", "Brandon Michael", 20250826, "WR").
shift_data("93976", "Kimberly Evans", 20250826, "SE").
shift_data("45618", "Laura Khan", 20250826, "LM").
shift_data("31603", "Katie Gutierrez", 20250826, "D").
shift_data("47963", "Jessica Martin", 20250826, "SE").
shift_data("58810", "Robert Williams", 20250826, "D").
shift_data("89410", "Mark Ramirez", 20250826, "LD").
shift_data("98041", "Kaitlin Cooper", 20250826, "SN").
shift_data("76316", "Christina Gutierrez MD", 20250826, "TR").
shift_data("33303", "Desiree Kelly", 20250826, "D").
shift_data("49753", "Brian Foster", 20250827, "WR").
shift_data("61912", "Austin Morales", 20250827, "BT").
shift_data("30312", "Rebecca Hubbard", 20250827, "SE").
shift_data("18718", "Joshua Hill", 20250827, "SN").
shift_data("62637", "Brian Lewis", 20250827, "LD").
shift_data("47929", "Sandra Roman", 20250827, "WR").
shift_data("39088", "Cheryl Collins", 20250827, "LD").
shift_data("80343", "Monique Bond", 20250827, "D").
shift_data("46265", "Angelica Obrien", 20250827, "D").
shift_data("23917", "Katie Thompson", 20250827, "SE").
shift_data("38101", "Brandon Michael", 20250827, "LD").
shift_data("93976", "Kimberly Evans", 20250827, "SN").
shift_data("45618", "Laura Khan", 20250827, "SE").
shift_data("31603", "Katie Gutierrez", 20250827, "D").
shift_data("47963", "Jessica Martin", 20250827, "SN").
shift_data("58810", "Robert Williams", 20250827, "LM").
shift_data("89410", "Mark Ramirez", 20250827, "WR").
shift_data("98041", "Kaitlin Cooper", 20250827, "WR").
shift_data("76316", "Christina Gutierrez MD", 20250827, "D").
shift_data("33303", "Desiree Kelly", 20250827, "D").
shift_data("49753", "Brian Foster", 20250828, "LD").
shift_data("61912", "Austin Morales", 20250828, "WR").
shift_data("30312", "Rebecca Hubbard", 20250828, "SN").
shift_data("18718", "Joshua Hill", 20250828, "WR").
shift_data("62637", "Brian Lewis", 20250828, "SE").
shift_data("47929", "Sandra Roman", 20250828, "D").
shift_data("39088", "Cheryl Collins", 20250828, "SE").
shift_data("80343", "Monique Bond", 20250828, "D").
shift_data("46265", "Angelica Obrien", 20250828, "LD").
shift_data("23917", "Katie Thompson", 20250828, "SN").
shift_data("38101", "Brandon Michael", 20250828, "WR").
shift_data("93976", "Kimberly Evans", 20250828, "WR").
shift_data("45618", "Laura Khan", 20250828, "SN").
shift_data("31603", "Katie Gutierrez", 20250828, "LD").
shift_data("47963", "Jessica Martin", 20250828, "BL").
shift_data("58810", "Robert Williams", 20250828, "SE").
shift_data("89410", "Mark Ramirez", 20250828, "D").
shift_data("98041", "Kaitlin Cooper", 20250828, "D").
shift_data("76316", "Christina Gutierrez MD", 20250828, "D").
shift_data("33303", "Desiree Kelly", 20250828, "WR").
shift_data("49753", "Brian Foster", 20250829, "SE").
shift_data("61912", "Austin Morales", 20250829, "WR").
shift_data("30312", "Rebecca Hubbard", 20250829, "WR").
shift_data("18718", "Joshua Hill", 20250829, "LD").
shift_data("62637", "Brian Lewis", 20250829, "SN").
shift_data("47929", "Sandra Roman", 20250829, "D").
shift_data("39088", "Cheryl Collins", 20250829, "SN").
shift_data("80343", "Monique Bond", 20250829, "D").
shift_data("46265", "Angelica Obrien", 20250829, "SE").
shift_data("23917", "Katie Thompson", 20250829, "WR").
shift_data("38101", "Brandon Michael", 20250829, "WR").
shift_data("93976", "Kimberly Evans", 20250829, "LD").
shift_data("45618", "Laura Khan", 20250829, "WR").
shift_data("31603", "Katie Gutierrez", 20250829, "SE").
shift_data("47963", "Jessica Martin", 20250829, "D").
shift_data("58810", "Robert Williams", 20250829, "SN").
shift_data("89410", "Mark Ramirez", 20250829, "D").
shift_data("98041", "Kaitlin Cooper", 20250829, "LD").
shift_data("76316", "Christina Gutierrez MD", 20250829, "D").
shift_data("33303", "Desiree Kelly", 20250829, "WR").
shift_data("49753", "Brian Foster", 20250830, "SN").
shift_data("61912", "Austin Morales", 20250830, "WR").
shift_data("30312", "Rebecca Hubbard", 20250830, "D").
shift_data("18718", "Joshua Hill", 20250830, "SE").
shift_data("62637", "Brian Lewis", 20250830, "WR").
shift_data("47929", "Sandra Roman", 20250830, "LD").
shift_data("39088", "Cheryl Collins", 20250830, "WR").
shift_data("80343", "Monique Bond", 20250830, "BT").
shift_data("46265", "Angelica Obrien", 20250830, "SN").
shift_data("23917", "Katie Thompson", 20250830, "WR").
shift_data("38101", "Brandon Michael", 20250830, "WR").
shift_data("93976", "Kimberly Evans", 20250830, "SE").
shift_data("45618", "Laura Khan", 20250830, "LD").
shift_data("31603", "Katie Gutierrez", 20250830, "SN").
shift_data("47963", "Jessica Martin", 20250830, "WR").
shift_data("58810", "Robert Williams", 20250830, "WR").
shift_data("89410", "Mark Ramirez", 20250830, "LD").
shift_data("98041", "Kaitlin Cooper", 20250830, "SE").
shift_data("76316", "Christina Gutierrez MD", 20250830, "WR").
shift_data("33303", "Desiree Kelly", 20250830, "D").
shift_data("49753", "Brian Foster", 20250831, "WR").
shift_data("61912", "Austin Morales", 20250831, "LD").
shift_data("30312", "Rebecca Hubbard", 20250831, "D").
shift_data("18718", "Joshua Hill", 20250831, "SN").
shift_data("62637", "Brian Lewis", 20250831, "D").
shift_data("47929", "Sandra Roman", 20250831, "SE").
shift_data("39088", "Cheryl Collins", 20250831, "D").
shift_data("80343", "Monique Bond", 20250831, "WR").
shift_data("46265", "Angelica Obrien", 20250831, "WR").
shift_data("23917", "Katie Thompson", 20250831, "LD").
shift_data("38101", "Brandon Michael", 20250831, "LD").
shift_data("93976", "Kimberly Evans", 20250831, "SN").
shift_data("45618", "Laura Khan", 20250831, "SE").
shift_data("31603", "Katie Gutierrez", 20250831, "WR").
shift_data("47963", "Jessica Martin", 20250831, "WR").
shift_data("58810", "Robert Williams", 20250831, "WR").
shift_data("89410", "Mark Ramirez", 20250831, "SE").
shift_data("98041", "Kaitlin Cooper", 20250831, "SN").
shift_data("76316", "Christina Gutierrez MD", 20250831, "WR").
shift_data("33303", "Desiree Kelly", 20250831, "WR").
shift_data("49753", "Brian Foster", 20250901, "LD").
shift_data("61912", "Austin Morales", 20250901, "SE").
shift_data("30312", "Rebecca Hubbard", 20250901, "WR").
shift_data("18718", "Joshua Hill", 20250901, "WR").
shift_data("62637", "Brian Lewis", 20250901, "D").
shift_data("47929", "Sandra Roman", 20250901, "SN").
shift_data("39088", "Cheryl Collins", 20250901, "D").
shift_data("80343", "Monique Bond", 20250901, "D").
shift_data("46265", "Angelica Obrien", 20250901, "AL").
shift_data("23917", "Katie Thompson", 20250901, "SE").
shift_data("38101", "Brandon Michael", 20250901, "SE").
shift_data("93976", "Kimberly Evans", 20250901, "WR").
shift_data("45618", "Laura Khan", 20250901, "SN").
shift_data("31603", "Katie Gutierrez", 20250901, "LD").
shift_data("47963", "Jessica Martin", 20250901, "D").
shift_data("58810", "Robert Williams", 20250901, "D").
shift_data("89410", "Mark Ramirez", 20250901, "SN").
shift_data("98041", "Kaitlin Cooper", 20250901, "WR").
shift_data("76316", "Christina Gutierrez MD", 20250901, "WR").
shift_data("33303", "Desiree Kelly", 20250901, "LD").
shift_data("49753", "Brian Foster", 20250902, "SE").
shift_data("61912", "Austin Morales", 20250902, "SN").
shift_data("30312", "Rebecca Hubbard", 20250902, "WR").
shift_data("18718", "Joshua Hill", 20250902, "WR").
shift_data("62637", "Brian Lewis", 20250902, "LD").
shift_data("47929", "Sandra Roman", 20250902, "WR").
shift_data("39088", "Cheryl Collins", 20250902, "WR").
shift_data("80343", "Monique Bond", 20250902, "LD").
shift_data("46265", "Angelica Obrien", 20250902, "D").
shift_data("23917", "Katie Thompson", 20250902, "SN").
shift_data("38101", "Brandon Michael", 20250902, "SN").
shift_data("93976", "Kimberly Evans", 20250902, "D").
shift_data("45618", "Laura Khan", 20250902, "WR").
shift_data("31603", "Katie Gutierrez", 20250902, "SE").
shift_data("47963", "Jessica Martin", 20250902, "WR").
shift_data("58810", "Robert Williams", 20250902, "LD").
shift_data("89410", "Mark Ramirez", 20250902, "WR").
shift_data("98041", "Kaitlin Cooper", 20250902, "WR").
shift_data("76316", "Christina Gutierrez MD", 20250902, "D").
shift_data("33303", "Desiree Kelly", 20250902, "WR").
shift_data("49753", "Brian Foster", 20250903, "SN").
shift_data("61912", "Austin Morales", 20250903, "WR").
shift_data("30312", "Rebecca Hubbard", 20250903, "LD").
shift_data("18718", "Joshua Hill", 20250903, "D").
shift_data("62637", "Brian Lewis", 20250903, "SE").
shift_data("47929", "Sandra Roman", 20250903, "D").
shift_data("39088", "Cheryl Collins", 20250903, "LD").
shift_data("80343", "Monique Bond", 20250903, "SE").
shift_data("46265", "Angelica Obrien", 20250903, "D").
shift_data("23917", "Katie Thompson", 20250903, "WR").
shift_data("38101", "Brandon Michael", 20250903, "WR").
shift_data("93976", "Kimberly Evans", 20250903, "BT").
shift_data("45618", "Laura Khan", 20250903, "LD").
shift_data("31603", "Katie Gutierrez", 20250903, "SN").
shift_data("47963", "Jessica Martin", 20250903, "D").
shift_data("58810", "Robert Williams", 20250903, "SE").
shift_data("89410", "Mark Ramirez", 20250903, "D").
shift_data("98041", "Kaitlin Cooper", 20250903, "LM").
shift_data("76316", "Christina Gutierrez MD", 20250903, "WR").
shift_data("33303", "Desiree Kelly", 20250903, "WR").
shift_data("49753", "Brian Foster", 20250904, "WR").
shift_data("61912", "Austin Morales", 20250904, "LD").
shift_data("30312", "Rebecca Hubbard", 20250904, "SE").
shift_data("18718", "Joshua Hill", 20250904, "D").
shift_data("62637", "Brian Lewis", 20250904, "SN").
shift_data("47929", "Sandra Roman", 20250904, "D").
shift_data("39088", "Cheryl Collins", 20250904, "WR").
shift_data("80343", "Monique Bond", 20250904, "SN").
shift_data("46265", "Angelica Obrien", 20250904, "WR").
shift_data("23917", "Katie Thompson", 20250904, "D").
shift_data("38101", "Brandon Michael", 20250904, "D").
shift_data("93976", "Kimberly Evans", 20250904, "WR").
shift_data("45618", "Laura Khan", 20250904, "SE").
shift_data("31603", "Katie Gutierrez", 20250904, "WR").
shift_data("47963", "Jessica Martin", 20250904, "LD").
shift_data("58810", "Robert Williams", 20250904, "SN").
shift_data("89410", "Mark Ramirez", 20250904, "LM").
shift_data("98041", "Kaitlin Cooper", 20250904, "SE").
shift_data("76316", "Christina Gutierrez MD", 20250904, "LD").
shift_data("33303", "Desiree Kelly", 20250904, "D").
shift_data("49753", "Brian Foster", 20250905, "WR").
shift_data("61912", "Austin Morales", 20250905, "SE").
shift_data("30312", "Rebecca Hubbard", 20250905, "SN").
shift_data("18718", "Joshua Hill", 20250905, "D").
shift_data("62637", "Brian Lewis", 20250905, "WR").
shift_data("47929", "Sandra Roman", 20250905, "LD").
shift_data("39088", "Cheryl Collins", 20250905, "WR").
shift_data("80343", "Monique Bond", 20250905, "WR").
shift_data("46265", "Angelica Obrien", 20250905, "D").
shift_data("23917", "Katie Thompson", 20250905, "D").
shift_data("38101", "Brandon Michael", 20250905, "LD").
shift_data("93976", "Kimberly Evans", 20250905, "WR").
shift_data("45618", "Laura Khan", 20250905, "SN").
shift_data("31603", "Katie Gutierrez", 20250905, "D").
shift_data("47963", "Jessica Martin", 20250905, "SE").
shift_data("58810", "Robert Williams", 20250905, "WR").
shift_data("89410", "Mark Ramirez", 20250905, "SE").
shift_data("98041", "Kaitlin Cooper", 20250905, "SN").
shift_data("76316", "Christina Gutierrez MD", 20250905, "WR").
shift_data("33303", "Desiree Kelly", 20250905, "LD").
shift_data("49753", "Brian Foster", 20250906, "D").
shift_data("61912", "Austin Morales", 20250906, "SN").
shift_data("30312", "Rebecca Hubbard", 20250906, "WR").
shift_data("18718", "Joshua Hill", 20250906, "WR").
shift_data("62637", "Brian Lewis", 20250906, "LD").
shift_data("47929", "Sandra Roman", 20250906, "SE").
shift_data("39088", "Cheryl Collins", 20250906, "WR").
shift_data("80343", "Monique Bond", 20250906, "BL").
shift_data("46265", "Angelica Obrien", 20250906, "D").
shift_data("23917", "Katie Thompson", 20250906, "LD").
shift_data("38101", "Brandon Michael", 20250906, "SE").
shift_data("93976", "Kimberly Evans", 20250906, "D").
shift_data("45618", "Laura Khan", 20250906, "WR").
shift_data("31603", "Katie Gutierrez", 20250906, "WR").
shift_data("47963", "Jessica Martin", 20250906, "SN").
shift_data("58810", "Robert Williams", 20250906, "WR").
shift_data("89410", "Mark Ramirez", 20250906, "SN").
shift_data("98041", "Kaitlin Cooper", 20250906, "WR").
shift_data("76316", "Christina Gutierrez MD", 20250906, "LD").
shift_data("33303", "Desiree Kelly", 20250906, "SE").
shift_data("49753", "Brian Foster", 20250907, "LD").
shift_data("61912", "Austin Morales", 20250907, "WR").
shift_data("30312", "Rebecca Hubbard", 20250907, "WR").
shift_data("18718", "Joshua Hill", 20250907, "WR").
shift_data("62637", "Brian Lewis", 20250907, "SE").
shift_data("47929", "Sandra Roman", 20250907, "SN").
shift_data("39088", "Cheryl Collins", 20250907, "WR").
shift_data("80343", "Monique Bond", 20250907, "WR").
shift_data("46265", "Angelica Obrien", 20250907, "D").
shift_data("23917", "Katie Thompson", 20250907, "SE").
shift_data("38101", "Brandon Michael", 20250907, "SN").
shift_data("93976", "Kimberly Evans", 20250907, "TR").
shift_data("45618", "Laura Khan", 20250907, "LD").
shift_data("31603", "Katie Gutierrez", 20250907, "BT").
shift_data("47963", "Jessica Martin", 20250907, "WR").
shift_data("58810", "Robert Williams", 20250907, "LD").
shift_data("89410", "Mark Ramirez", 20250907, "WR").
shift_data("98041", "Kaitlin Cooper", 20250907, "WR").
shift_data("76316", "Christina Gutierrez MD", 20250907, "SE").
shift_data("33303", "Desiree Kelly", 20250907, "SN").
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
