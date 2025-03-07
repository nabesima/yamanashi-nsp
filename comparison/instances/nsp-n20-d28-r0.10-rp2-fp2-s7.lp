% Staffs -----------------------------------------
staff(1, "Chris Curtis", "Nurse", "29772", 8).
staff(2, "Joshua Diaz", "Nurse", "95319", 8).
staff(3, "Jordan Johnson", "Nurse", "19494", 7).
staff(4, "Benjamin Davis", "Nurse", "22337", 9).
staff(5, "Ronald Martinez", "Nurse", "86387", 8).
staff(6, "Mark Meza", "Nurse", "76510", 7).
staff(7, "Jennifer Cherry", "Nurse", "14914", 4).
staff(8, "Scott Roberts", "Nurse", "66838", 4).
staff(9, "Bruce Parker", "Nurse", "19156", 5).
staff(10, "Catherine Perkins", "Nurse", "21889", 4).
staff(11, "Jacqueline Kelley", "Nurse", "65642", 6).
staff(12, "Anthony Harris", "Nurse", "84115", 4).
staff(13, "Jessica Edwards", "Nurse", "39260", 4).
staff(14, "Jody Evans", "Nurse", "92238", 6).
staff(15, "Melissa Sanchez", "Nurse", "18108", 6).
staff(16, "Kelly Golden", "Nurse", "86748", 6).
staff(17, "Donna Baird", "Nurse", "16499", 2).
staff(18, "Jason Sherman", "Nurse", "16105", 1).
staff(19, "John Williams", "Nurse", "27455", 3).
staff(20, "Pamela Berry", "Nurse", "64937", 2).
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
staff_neg_request(5, 34, "SE").
staff_neg_request(19, 19, "SN").
staff_pos_request(4, 12, "TR").
staff_pos_request(4, 4, "D").
staff_pos_request(20, 13, "BL").
staff_pos_request(18, 27, "TR").
staff_pos_request(15, 29, "TR").
staff_neg_request(10, 15, "SN").
staff_pos_request(8, 5, "BT").
staff_pos_request(17, 31, "TR").
staff_neg_request(15, 18, "SE").
staff_pos_request(4, 32, "AL").
staff_neg_request(6, 21, "SN").
staff_pos_request(16, 26, "D").
staff_pos_request(3, 20, "TR").
staff_pos_request(12, 31, "BL").
staff_pos_request(3, 5, "BT").
staff_pos_request(16, 4, "D").
staff_pos_request(10, 28, "BT").
staff_pos_request(13, 22, "D").
staff_neg_request(15, 22, "SN").
staff_pos_request(20, 7, "BL").
staff_pos_request(2, 13, "BT").
staff_pos_request(5, 15, "AL").
staff_neg_request(13, 31, "SE").
staff_pos_request(6, 28, "AL").
staff_neg_request(18, 17, "SN").
staff_pos_request(14, 17, "AL").
staff_pos_request(12, 24, "WR").
staff_neg_request(5, 5, "SN").
staff_pos_request(5, 14, "WR").
staff_neg_request(1, 31, "SN").
staff_pos_request(9, 18, "D").
staff_pos_request(5, 26, "TR").
staff_neg_request(20, 20, "SN").
staff_pos_request(17, 3, "BL").
staff_pos_request(18, 25, "AL").
staff_neg_request(13, 25, "SE").
staff_pos_request(16, 25, "D").
staff_pos_request(7, 4, "WR").
staff_neg_request(15, 10, "SE").
staff_neg_request(11, 3, "SE").
staff_neg_request(1, 9, "SE").
staff_neg_request(12, 1, "SE").
staff_neg_request(7, 24, "SN").
staff_pos_request(9, 22, "TR").
staff_neg_request(16, 7, "SE").
staff_pos_request(16, 29, "BL").
staff_neg_request(16, 19, "SE").
staff_pos_request(5, 6, "TR").
staff_neg_request(9, 30, "SN").
staff_pos_request(17, 1, "WR").
staff_neg_request(17, 23, "SN").
staff_pos_request(18, 1, "BT").
staff_pos_request(3, 16, "TR").
staff_pos_request(6, 22, "WR").
% Pairs ------------------------------------------
recommended_night_pair(11, 18, 4).
recommended_night_pair(7, 18, 4).
forbidden_night_pair(13, 8).
forbidden_night_pair(7, 17).
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
shift_data("29772", "Chris Curtis", 20250811, "PH").
shift_data("95319", "Joshua Diaz", 20250811, "LD").
shift_data("19494", "Jordan Johnson", 20250811, "SE").
shift_data("22337", "Benjamin Davis", 20250811, "D").
shift_data("86387", "Ronald Martinez", 20250811, "SN").
shift_data("76510", "Mark Meza", 20250811, "PH").
shift_data("14914", "Jennifer Cherry", 20250811, "PH").
shift_data("66838", "Scott Roberts", 20250811, "PH").
shift_data("19156", "Bruce Parker", 20250811, "PH").
shift_data("21889", "Catherine Perkins", 20250811, "PH").
shift_data("65642", "Jacqueline Kelley", 20250811, "SN").
shift_data("84115", "Anthony Harris", 20250811, "SN").
shift_data("39260", "Jessica Edwards", 20250811, "LD").
shift_data("92238", "Jody Evans", 20250811, "SE").
shift_data("18108", "Melissa Sanchez", 20250811, "SE").
shift_data("86748", "Kelly Golden", 20250811, "PH").
shift_data("16499", "Donna Baird", 20250811, "PH").
shift_data("16105", "Jason Sherman", 20250811, "PH").
shift_data("27455", "John Williams", 20250811, "LD").
shift_data("64937", "Pamela Berry", 20250811, "D").
shift_data("29772", "Chris Curtis", 20250812, "D").
shift_data("95319", "Joshua Diaz", 20250812, "SE").
shift_data("19494", "Jordan Johnson", 20250812, "SN").
shift_data("22337", "Benjamin Davis", 20250812, "D").
shift_data("86387", "Ronald Martinez", 20250812, "WR").
shift_data("76510", "Mark Meza", 20250812, "LD").
shift_data("14914", "Jennifer Cherry", 20250812, "LM").
shift_data("66838", "Scott Roberts", 20250812, "LD").
shift_data("19156", "Bruce Parker", 20250812, "D").
shift_data("21889", "Catherine Perkins", 20250812, "D").
shift_data("65642", "Jacqueline Kelley", 20250812, "WR").
shift_data("84115", "Anthony Harris", 20250812, "WR").
shift_data("39260", "Jessica Edwards", 20250812, "SE").
shift_data("92238", "Jody Evans", 20250812, "SN").
shift_data("18108", "Melissa Sanchez", 20250812, "SN").
shift_data("86748", "Kelly Golden", 20250812, "D").
shift_data("16499", "Donna Baird", 20250812, "WR").
shift_data("16105", "Jason Sherman", 20250812, "BT").
shift_data("27455", "John Williams", 20250812, "SE").
shift_data("64937", "Pamela Berry", 20250812, "LD").
shift_data("29772", "Chris Curtis", 20250813, "D").
shift_data("95319", "Joshua Diaz", 20250813, "SN").
shift_data("19494", "Jordan Johnson", 20250813, "WR").
shift_data("22337", "Benjamin Davis", 20250813, "WR").
shift_data("86387", "Ronald Martinez", 20250813, "LD").
shift_data("76510", "Mark Meza", 20250813, "SE").
shift_data("14914", "Jennifer Cherry", 20250813, "SE").
shift_data("66838", "Scott Roberts", 20250813, "SE").
shift_data("19156", "Bruce Parker", 20250813, "LD").
shift_data("21889", "Catherine Perkins", 20250813, "LD").
shift_data("65642", "Jacqueline Kelley", 20250813, "D").
shift_data("84115", "Anthony Harris", 20250813, "WR").
shift_data("39260", "Jessica Edwards", 20250813, "SN").
shift_data("92238", "Jody Evans", 20250813, "WR").
shift_data("18108", "Melissa Sanchez", 20250813, "WR").
shift_data("86748", "Kelly Golden", 20250813, "D").
shift_data("16499", "Donna Baird", 20250813, "D").
shift_data("16105", "Jason Sherman", 20250813, "D").
shift_data("27455", "John Williams", 20250813, "SN").
shift_data("64937", "Pamela Berry", 20250813, "WR").
shift_data("29772", "Chris Curtis", 20250814, "LD").
shift_data("95319", "Joshua Diaz", 20250814, "WR").
shift_data("19494", "Jordan Johnson", 20250814, "D").
shift_data("22337", "Benjamin Davis", 20250814, "D").
shift_data("86387", "Ronald Martinez", 20250814, "SE").
shift_data("76510", "Mark Meza", 20250814, "SN").
shift_data("14914", "Jennifer Cherry", 20250814, "SN").
shift_data("66838", "Scott Roberts", 20250814, "SN").
shift_data("19156", "Bruce Parker", 20250814, "SE").
shift_data("21889", "Catherine Perkins", 20250814, "SE").
shift_data("65642", "Jacqueline Kelley", 20250814, "LD").
shift_data("84115", "Anthony Harris", 20250814, "D").
shift_data("39260", "Jessica Edwards", 20250814, "WR").
shift_data("92238", "Jody Evans", 20250814, "D").
shift_data("18108", "Melissa Sanchez", 20250814, "LD").
shift_data("86748", "Kelly Golden", 20250814, "WR").
shift_data("16499", "Donna Baird", 20250814, "BL").
shift_data("16105", "Jason Sherman", 20250814, "D").
shift_data("27455", "John Williams", 20250814, "WR").
shift_data("64937", "Pamela Berry", 20250814, "WR").
shift_data("29772", "Chris Curtis", 20250815, "SE").
shift_data("95319", "Joshua Diaz", 20250815, "LD").
shift_data("19494", "Jordan Johnson", 20250815, "WR").
shift_data("22337", "Benjamin Davis", 20250815, "D").
shift_data("86387", "Ronald Martinez", 20250815, "SN").
shift_data("76510", "Mark Meza", 20250815, "WR").
shift_data("14914", "Jennifer Cherry", 20250815, "WR").
shift_data("66838", "Scott Roberts", 20250815, "WR").
shift_data("19156", "Bruce Parker", 20250815, "SN").
shift_data("21889", "Catherine Perkins", 20250815, "SN").
shift_data("65642", "Jacqueline Kelley", 20250815, "SE").
shift_data("84115", "Anthony Harris", 20250815, "D").
shift_data("39260", "Jessica Edwards", 20250815, "D").
shift_data("92238", "Jody Evans", 20250815, "LD").
shift_data("18108", "Melissa Sanchez", 20250815, "SE").
shift_data("86748", "Kelly Golden", 20250815, "D").
shift_data("16499", "Donna Baird", 20250815, "D").
shift_data("16105", "Jason Sherman", 20250815, "D").
shift_data("27455", "John Williams", 20250815, "WR").
shift_data("64937", "Pamela Berry", 20250815, "LD").
shift_data("29772", "Chris Curtis", 20250816, "SN").
shift_data("95319", "Joshua Diaz", 20250816, "SE").
shift_data("19494", "Jordan Johnson", 20250816, "BT").
shift_data("22337", "Benjamin Davis", 20250816, "WR").
shift_data("86387", "Ronald Martinez", 20250816, "WR").
shift_data("76510", "Mark Meza", 20250816, "LD").
shift_data("14914", "Jennifer Cherry", 20250816, "WR").
shift_data("66838", "Scott Roberts", 20250816, "BT").
shift_data("19156", "Bruce Parker", 20250816, "WR").
shift_data("21889", "Catherine Perkins", 20250816, "WR").
shift_data("65642", "Jacqueline Kelley", 20250816, "SN").
shift_data("84115", "Anthony Harris", 20250816, "WR").
shift_data("39260", "Jessica Edwards", 20250816, "D").
shift_data("92238", "Jody Evans", 20250816, "SE").
shift_data("18108", "Melissa Sanchez", 20250816, "SN").
shift_data("86748", "Kelly Golden", 20250816, "LD").
shift_data("16499", "Donna Baird", 20250816, "LD").
shift_data("16105", "Jason Sherman", 20250816, "WR").
shift_data("27455", "John Williams", 20250816, "D").
shift_data("64937", "Pamela Berry", 20250816, "SE").
shift_data("29772", "Chris Curtis", 20250817, "WR").
shift_data("95319", "Joshua Diaz", 20250817, "SN").
shift_data("19494", "Jordan Johnson", 20250817, "LD").
shift_data("22337", "Benjamin Davis", 20250817, "WR").
shift_data("86387", "Ronald Martinez", 20250817, "TR").
shift_data("76510", "Mark Meza", 20250817, "SE").
shift_data("14914", "Jennifer Cherry", 20250817, "WR").
shift_data("66838", "Scott Roberts", 20250817, "D").
shift_data("19156", "Bruce Parker", 20250817, "WR").
shift_data("21889", "Catherine Perkins", 20250817, "LD").
shift_data("65642", "Jacqueline Kelley", 20250817, "WR").
shift_data("84115", "Anthony Harris", 20250817, "WR").
shift_data("39260", "Jessica Edwards", 20250817, "WR").
shift_data("92238", "Jody Evans", 20250817, "SN").
shift_data("18108", "Melissa Sanchez", 20250817, "WR").
shift_data("86748", "Kelly Golden", 20250817, "SE").
shift_data("16499", "Donna Baird", 20250817, "SE").
shift_data("16105", "Jason Sherman", 20250817, "LD").
shift_data("27455", "John Williams", 20250817, "D").
shift_data("64937", "Pamela Berry", 20250817, "SN").
shift_data("29772", "Chris Curtis", 20250818, "LD").
shift_data("95319", "Joshua Diaz", 20250818, "WR").
shift_data("19494", "Jordan Johnson", 20250818, "SE").
shift_data("22337", "Benjamin Davis", 20250818, "WR").
shift_data("86387", "Ronald Martinez", 20250818, "WR").
shift_data("76510", "Mark Meza", 20250818, "SN").
shift_data("14914", "Jennifer Cherry", 20250818, "D").
shift_data("66838", "Scott Roberts", 20250818, "D").
shift_data("19156", "Bruce Parker", 20250818, "LD").
shift_data("21889", "Catherine Perkins", 20250818, "SE").
shift_data("65642", "Jacqueline Kelley", 20250818, "D").
shift_data("84115", "Anthony Harris", 20250818, "D").
shift_data("39260", "Jessica Edwards", 20250818, "D").
shift_data("92238", "Jody Evans", 20250818, "WR").
shift_data("18108", "Melissa Sanchez", 20250818, "WR").
shift_data("86748", "Kelly Golden", 20250818, "SN").
shift_data("16499", "Donna Baird", 20250818, "SN").
shift_data("16105", "Jason Sherman", 20250818, "SE").
shift_data("27455", "John Williams", 20250818, "LD").
shift_data("64937", "Pamela Berry", 20250818, "BL").
shift_data("29772", "Chris Curtis", 20250819, "SE").
shift_data("95319", "Joshua Diaz", 20250819, "WR").
shift_data("19494", "Jordan Johnson", 20250819, "SN").
shift_data("22337", "Benjamin Davis", 20250819, "LD").
shift_data("86387", "Ronald Martinez", 20250819, "WR").
shift_data("76510", "Mark Meza", 20250819, "WR").
shift_data("14914", "Jennifer Cherry", 20250819, "D").
shift_data("66838", "Scott Roberts", 20250819, "D").
shift_data("19156", "Bruce Parker", 20250819, "SE").
shift_data("21889", "Catherine Perkins", 20250819, "SN").
shift_data("65642", "Jacqueline Kelley", 20250819, "D").
shift_data("84115", "Anthony Harris", 20250819, "LD").
shift_data("39260", "Jessica Edwards", 20250819, "LD").
shift_data("92238", "Jody Evans", 20250819, "D").
shift_data("18108", "Melissa Sanchez", 20250819, "D").
shift_data("86748", "Kelly Golden", 20250819, "WR").
shift_data("16499", "Donna Baird", 20250819, "WR").
shift_data("16105", "Jason Sherman", 20250819, "SN").
shift_data("27455", "John Williams", 20250819, "SE").
shift_data("64937", "Pamela Berry", 20250819, "WR").
shift_data("29772", "Chris Curtis", 20250820, "SN").
shift_data("95319", "Joshua Diaz", 20250820, "LD").
shift_data("19494", "Jordan Johnson", 20250820, "WR").
shift_data("22337", "Benjamin Davis", 20250820, "SE").
shift_data("86387", "Ronald Martinez", 20250820, "D").
shift_data("76510", "Mark Meza", 20250820, "D").
shift_data("14914", "Jennifer Cherry", 20250820, "D").
shift_data("66838", "Scott Roberts", 20250820, "WR").
shift_data("19156", "Bruce Parker", 20250820, "SN").
shift_data("21889", "Catherine Perkins", 20250820, "WR").
shift_data("65642", "Jacqueline Kelley", 20250820, "WR").
shift_data("84115", "Anthony Harris", 20250820, "SE").
shift_data("39260", "Jessica Edwards", 20250820, "SE").
shift_data("92238", "Jody Evans", 20250820, "D").
shift_data("18108", "Melissa Sanchez", 20250820, "LD").
shift_data("86748", "Kelly Golden", 20250820, "LM").
shift_data("16499", "Donna Baird", 20250820, "D").
shift_data("16105", "Jason Sherman", 20250820, "WR").
shift_data("27455", "John Williams", 20250820, "SN").
shift_data("64937", "Pamela Berry", 20250820, "LD").
shift_data("29772", "Chris Curtis", 20250821, "WR").
shift_data("95319", "Joshua Diaz", 20250821, "SE").
shift_data("19494", "Jordan Johnson", 20250821, "D").
shift_data("22337", "Benjamin Davis", 20250821, "SN").
shift_data("86387", "Ronald Martinez", 20250821, "LD").
shift_data("76510", "Mark Meza", 20250821, "D").
shift_data("14914", "Jennifer Cherry", 20250821, "D").
shift_data("66838", "Scott Roberts", 20250821, "WR").
shift_data("19156", "Bruce Parker", 20250821, "WR").
shift_data("21889", "Catherine Perkins", 20250821, "D").
shift_data("65642", "Jacqueline Kelley", 20250821, "D").
shift_data("84115", "Anthony Harris", 20250821, "SN").
shift_data("39260", "Jessica Edwards", 20250821, "SN").
shift_data("92238", "Jody Evans", 20250821, "LD").
shift_data("18108", "Melissa Sanchez", 20250821, "WR").
shift_data("86748", "Kelly Golden", 20250821, "SE").
shift_data("16499", "Donna Baird", 20250821, "WR").
shift_data("16105", "Jason Sherman", 20250821, "LD").
shift_data("27455", "John Williams", 20250821, "WR").
shift_data("64937", "Pamela Berry", 20250821, "SE").
shift_data("29772", "Chris Curtis", 20250822, "WR").
shift_data("95319", "Joshua Diaz", 20250822, "SN").
shift_data("19494", "Jordan Johnson", 20250822, "LD").
shift_data("22337", "Benjamin Davis", 20250822, "WR").
shift_data("86387", "Ronald Martinez", 20250822, "SE").
shift_data("76510", "Mark Meza", 20250822, "D").
shift_data("14914", "Jennifer Cherry", 20250822, "LD").
shift_data("66838", "Scott Roberts", 20250822, "D").
shift_data("19156", "Bruce Parker", 20250822, "D").
shift_data("21889", "Catherine Perkins", 20250822, "D").
shift_data("65642", "Jacqueline Kelley", 20250822, "LM").
shift_data("84115", "Anthony Harris", 20250822, "WR").
shift_data("39260", "Jessica Edwards", 20250822, "WR").
shift_data("92238", "Jody Evans", 20250822, "SE").
shift_data("18108", "Melissa Sanchez", 20250822, "D").
shift_data("86748", "Kelly Golden", 20250822, "SN").
shift_data("16499", "Donna Baird", 20250822, "WR").
shift_data("16105", "Jason Sherman", 20250822, "SE").
shift_data("27455", "John Williams", 20250822, "LD").
shift_data("64937", "Pamela Berry", 20250822, "SN").
shift_data("29772", "Chris Curtis", 20250823, "LD").
shift_data("95319", "Joshua Diaz", 20250823, "WR").
shift_data("19494", "Jordan Johnson", 20250823, "SE").
shift_data("22337", "Benjamin Davis", 20250823, "TR").
shift_data("86387", "Ronald Martinez", 20250823, "SN").
shift_data("76510", "Mark Meza", 20250823, "WR").
shift_data("14914", "Jennifer Cherry", 20250823, "WR").
shift_data("66838", "Scott Roberts", 20250823, "LD").
shift_data("19156", "Bruce Parker", 20250823, "D").
shift_data("21889", "Catherine Perkins", 20250823, "WR").
shift_data("65642", "Jacqueline Kelley", 20250823, "SE").
shift_data("84115", "Anthony Harris", 20250823, "LD").
shift_data("39260", "Jessica Edwards", 20250823, "WR").
shift_data("92238", "Jody Evans", 20250823, "SN").
shift_data("18108", "Melissa Sanchez", 20250823, "D").
shift_data("86748", "Kelly Golden", 20250823, "WR").
shift_data("16499", "Donna Baird", 20250823, "D").
shift_data("16105", "Jason Sherman", 20250823, "SN").
shift_data("27455", "John Williams", 20250823, "SE").
shift_data("64937", "Pamela Berry", 20250823, "WR").
shift_data("29772", "Chris Curtis", 20250824, "SE").
shift_data("95319", "Joshua Diaz", 20250824, "BT").
shift_data("19494", "Jordan Johnson", 20250824, "SN").
shift_data("22337", "Benjamin Davis", 20250824, "LD").
shift_data("86387", "Ronald Martinez", 20250824, "WR").
shift_data("76510", "Mark Meza", 20250824, "WR").
shift_data("14914", "Jennifer Cherry", 20250824, "WR").
shift_data("66838", "Scott Roberts", 20250824, "SE").
shift_data("19156", "Bruce Parker", 20250824, "WR").
shift_data("21889", "Catherine Perkins", 20250824, "D").
shift_data("65642", "Jacqueline Kelley", 20250824, "SN").
shift_data("84115", "Anthony Harris", 20250824, "SE").
shift_data("39260", "Jessica Edwards", 20250824, "D").
shift_data("92238", "Jody Evans", 20250824, "WR").
shift_data("18108", "Melissa Sanchez", 20250824, "WR").
shift_data("86748", "Kelly Golden", 20250824, "LD").
shift_data("16499", "Donna Baird", 20250824, "LD").
shift_data("16105", "Jason Sherman", 20250824, "WR").
shift_data("27455", "John Williams", 20250824, "SN").
shift_data("64937", "Pamela Berry", 20250824, "BL").
shift_data("29772", "Chris Curtis", 20250825, "SN").
shift_data("95319", "Joshua Diaz", 20250825, "D").
shift_data("19494", "Jordan Johnson", 20250825, "WR").
shift_data("22337", "Benjamin Davis", 20250825, "SE").
shift_data("86387", "Ronald Martinez", 20250825, "WR").
shift_data("76510", "Mark Meza", 20250825, "LD").
shift_data("14914", "Jennifer Cherry", 20250825, "D").
shift_data("66838", "Scott Roberts", 20250825, "SN").
shift_data("19156", "Bruce Parker", 20250825, "LD").
shift_data("21889", "Catherine Perkins", 20250825, "D").
shift_data("65642", "Jacqueline Kelley", 20250825, "WR").
shift_data("84115", "Anthony Harris", 20250825, "SN").
shift_data("39260", "Jessica Edwards", 20250825, "LD").
shift_data("92238", "Jody Evans", 20250825, "D").
shift_data("18108", "Melissa Sanchez", 20250825, "D").
shift_data("86748", "Kelly Golden", 20250825, "SE").
shift_data("16499", "Donna Baird", 20250825, "SE").
shift_data("16105", "Jason Sherman", 20250825, "WR").
shift_data("27455", "John Williams", 20250825, "WR").
shift_data("64937", "Pamela Berry", 20250825, "WR").
shift_data("29772", "Chris Curtis", 20250826, "WR").
shift_data("95319", "Joshua Diaz", 20250826, "LD").
shift_data("19494", "Jordan Johnson", 20250826, "D").
shift_data("22337", "Benjamin Davis", 20250826, "SN").
shift_data("86387", "Ronald Martinez", 20250826, "AL").
shift_data("76510", "Mark Meza", 20250826, "SE").
shift_data("14914", "Jennifer Cherry", 20250826, "LD").
shift_data("66838", "Scott Roberts", 20250826, "WR").
shift_data("19156", "Bruce Parker", 20250826, "SE").
shift_data("21889", "Catherine Perkins", 20250826, "LD").
shift_data("65642", "Jacqueline Kelley", 20250826, "D").
shift_data("84115", "Anthony Harris", 20250826, "WR").
shift_data("39260", "Jessica Edwards", 20250826, "SE").
shift_data("92238", "Jody Evans", 20250826, "D").
shift_data("18108", "Melissa Sanchez", 20250826, "D").
shift_data("86748", "Kelly Golden", 20250826, "SN").
shift_data("16499", "Donna Baird", 20250826, "SN").
shift_data("16105", "Jason Sherman", 20250826, "WR").
shift_data("27455", "John Williams", 20250826, "LM").
shift_data("64937", "Pamela Berry", 20250826, "D").
shift_data("29772", "Chris Curtis", 20250827, "D").
shift_data("95319", "Joshua Diaz", 20250827, "SE").
shift_data("19494", "Jordan Johnson", 20250827, "TR").
shift_data("22337", "Benjamin Davis", 20250827, "WR").
shift_data("86387", "Ronald Martinez", 20250827, "LD").
shift_data("76510", "Mark Meza", 20250827, "SN").
shift_data("14914", "Jennifer Cherry", 20250827, "SE").
shift_data("66838", "Scott Roberts", 20250827, "WR").
shift_data("19156", "Bruce Parker", 20250827, "SN").
shift_data("21889", "Catherine Perkins", 20250827, "WR").
shift_data("65642", "Jacqueline Kelley", 20250827, "LD").
shift_data("84115", "Anthony Harris", 20250827, "D").
shift_data("39260", "Jessica Edwards", 20250827, "SN").
shift_data("92238", "Jody Evans", 20250827, "D").
shift_data("18108", "Melissa Sanchez", 20250827, "D").
shift_data("86748", "Kelly Golden", 20250827, "WR").
shift_data("16499", "Donna Baird", 20250827, "WR").
shift_data("16105", "Jason Sherman", 20250827, "LD").
shift_data("27455", "John Williams", 20250827, "SE").
shift_data("64937", "Pamela Berry", 20250827, "D").
shift_data("29772", "Chris Curtis", 20250828, "D").
shift_data("95319", "Joshua Diaz", 20250828, "SN").
shift_data("19494", "Jordan Johnson", 20250828, "D").
shift_data("22337", "Benjamin Davis", 20250828, "LD").
shift_data("86387", "Ronald Martinez", 20250828, "SE").
shift_data("76510", "Mark Meza", 20250828, "WR").
shift_data("14914", "Jennifer Cherry", 20250828, "SN").
shift_data("66838", "Scott Roberts", 20250828, "D").
shift_data("19156", "Bruce Parker", 20250828, "WR").
shift_data("21889", "Catherine Perkins", 20250828, "WR").
shift_data("65642", "Jacqueline Kelley", 20250828, "SE").
shift_data("84115", "Anthony Harris", 20250828, "D").
shift_data("39260", "Jessica Edwards", 20250828, "WR").
shift_data("92238", "Jody Evans", 20250828, "AL").
shift_data("18108", "Melissa Sanchez", 20250828, "D").
shift_data("86748", "Kelly Golden", 20250828, "LD").
shift_data("16499", "Donna Baird", 20250828, "LD").
shift_data("16105", "Jason Sherman", 20250828, "SE").
shift_data("27455", "John Williams", 20250828, "SN").
shift_data("64937", "Pamela Berry", 20250828, "LM").
shift_data("29772", "Chris Curtis", 20250829, "WR").
shift_data("95319", "Joshua Diaz", 20250829, "WR").
shift_data("19494", "Jordan Johnson", 20250829, "WR").
shift_data("22337", "Benjamin Davis", 20250829, "SE").
shift_data("86387", "Ronald Martinez", 20250829, "SN").
shift_data("76510", "Mark Meza", 20250829, "LD").
shift_data("14914", "Jennifer Cherry", 20250829, "WR").
shift_data("66838", "Scott Roberts", 20250829, "D").
shift_data("19156", "Bruce Parker", 20250829, "D").
shift_data("21889", "Catherine Perkins", 20250829, "D").
shift_data("65642", "Jacqueline Kelley", 20250829, "SN").
shift_data("84115", "Anthony Harris", 20250829, "D").
shift_data("39260", "Jessica Edwards", 20250829, "LD").
shift_data("92238", "Jody Evans", 20250829, "LD").
shift_data("18108", "Melissa Sanchez", 20250829, "D").
shift_data("86748", "Kelly Golden", 20250829, "SE").
shift_data("16499", "Donna Baird", 20250829, "LM").
shift_data("16105", "Jason Sherman", 20250829, "SN").
shift_data("27455", "John Williams", 20250829, "WR").
shift_data("64937", "Pamela Berry", 20250829, "SE").
shift_data("29772", "Chris Curtis", 20250830, "WR").
shift_data("95319", "Joshua Diaz", 20250830, "LD").
shift_data("19494", "Jordan Johnson", 20250830, "WR").
shift_data("22337", "Benjamin Davis", 20250830, "SN").
shift_data("86387", "Ronald Martinez", 20250830, "WR").
shift_data("76510", "Mark Meza", 20250830, "SE").
shift_data("14914", "Jennifer Cherry", 20250830, "LD").
shift_data("66838", "Scott Roberts", 20250830, "WR").
shift_data("19156", "Bruce Parker", 20250830, "D").
shift_data("21889", "Catherine Perkins", 20250830, "LD").
shift_data("65642", "Jacqueline Kelley", 20250830, "WR").
shift_data("84115", "Anthony Harris", 20250830, "WR").
shift_data("39260", "Jessica Edwards", 20250830, "SE").
shift_data("92238", "Jody Evans", 20250830, "WR").
shift_data("18108", "Melissa Sanchez", 20250830, "WR").
shift_data("86748", "Kelly Golden", 20250830, "SN").
shift_data("16499", "Donna Baird", 20250830, "SE").
shift_data("16105", "Jason Sherman", 20250830, "WR").
shift_data("27455", "John Williams", 20250830, "D").
shift_data("64937", "Pamela Berry", 20250830, "SN").
shift_data("29772", "Chris Curtis", 20250831, "WR").
shift_data("95319", "Joshua Diaz", 20250831, "SE").
shift_data("19494", "Jordan Johnson", 20250831, "TR").
shift_data("22337", "Benjamin Davis", 20250831, "WR").
shift_data("86387", "Ronald Martinez", 20250831, "LD").
shift_data("76510", "Mark Meza", 20250831, "SN").
shift_data("14914", "Jennifer Cherry", 20250831, "SE").
shift_data("66838", "Scott Roberts", 20250831, "LD").
shift_data("19156", "Bruce Parker", 20250831, "WR").
shift_data("21889", "Catherine Perkins", 20250831, "SE").
shift_data("65642", "Jacqueline Kelley", 20250831, "WR").
shift_data("84115", "Anthony Harris", 20250831, "D").
shift_data("39260", "Jessica Edwards", 20250831, "SN").
shift_data("92238", "Jody Evans", 20250831, "WR").
shift_data("18108", "Melissa Sanchez", 20250831, "WR").
shift_data("86748", "Kelly Golden", 20250831, "WR").
shift_data("16499", "Donna Baird", 20250831, "SN").
shift_data("16105", "Jason Sherman", 20250831, "LD").
shift_data("27455", "John Williams", 20250831, "D").
shift_data("64937", "Pamela Berry", 20250831, "WR").
shift_data("29772", "Chris Curtis", 20250901, "D").
shift_data("95319", "Joshua Diaz", 20250901, "SN").
shift_data("19494", "Jordan Johnson", 20250901, "D").
shift_data("22337", "Benjamin Davis", 20250901, "LD").
shift_data("86387", "Ronald Martinez", 20250901, "SE").
shift_data("76510", "Mark Meza", 20250901, "WR").
shift_data("14914", "Jennifer Cherry", 20250901, "SN").
shift_data("66838", "Scott Roberts", 20250901, "SE").
shift_data("19156", "Bruce Parker", 20250901, "D").
shift_data("21889", "Catherine Perkins", 20250901, "SN").
shift_data("65642", "Jacqueline Kelley", 20250901, "WR").
shift_data("84115", "Anthony Harris", 20250901, "LD").
shift_data("39260", "Jessica Edwards", 20250901, "WR").
shift_data("92238", "Jody Evans", 20250901, "D").
shift_data("18108", "Melissa Sanchez", 20250901, "LD").
shift_data("86748", "Kelly Golden", 20250901, "WR").
shift_data("16499", "Donna Baird", 20250901, "WR").
shift_data("16105", "Jason Sherman", 20250901, "SE").
shift_data("27455", "John Williams", 20250901, "D").
shift_data("64937", "Pamela Berry", 20250901, "WR").
shift_data("29772", "Chris Curtis", 20250902, "LD").
shift_data("95319", "Joshua Diaz", 20250902, "WR").
shift_data("19494", "Jordan Johnson", 20250902, "LD").
shift_data("22337", "Benjamin Davis", 20250902, "SE").
shift_data("86387", "Ronald Martinez", 20250902, "SN").
shift_data("76510", "Mark Meza", 20250902, "WR").
shift_data("14914", "Jennifer Cherry", 20250902, "WR").
shift_data("66838", "Scott Roberts", 20250902, "SN").
shift_data("19156", "Bruce Parker", 20250902, "TR").
shift_data("21889", "Catherine Perkins", 20250902, "WR").
shift_data("65642", "Jacqueline Kelley", 20250902, "D").
shift_data("84115", "Anthony Harris", 20250902, "SE").
shift_data("39260", "Jessica Edwards", 20250902, "D").
shift_data("92238", "Jody Evans", 20250902, "LD").
shift_data("18108", "Melissa Sanchez", 20250902, "SE").
shift_data("86748", "Kelly Golden", 20250902, "D").
shift_data("16499", "Donna Baird", 20250902, "WR").
shift_data("16105", "Jason Sherman", 20250902, "SN").
shift_data("27455", "John Williams", 20250902, "D").
shift_data("64937", "Pamela Berry", 20250902, "D").
shift_data("29772", "Chris Curtis", 20250903, "SE").
shift_data("95319", "Joshua Diaz", 20250903, "LD").
shift_data("19494", "Jordan Johnson", 20250903, "SE").
shift_data("22337", "Benjamin Davis", 20250903, "SN").
shift_data("86387", "Ronald Martinez", 20250903, "WR").
shift_data("76510", "Mark Meza", 20250903, "D").
shift_data("14914", "Jennifer Cherry", 20250903, "D").
shift_data("66838", "Scott Roberts", 20250903, "WR").
shift_data("19156", "Bruce Parker", 20250903, "LD").
shift_data("21889", "Catherine Perkins", 20250903, "LM").
shift_data("65642", "Jacqueline Kelley", 20250903, "LD").
shift_data("84115", "Anthony Harris", 20250903, "SN").
shift_data("39260", "Jessica Edwards", 20250903, "D").
shift_data("92238", "Jody Evans", 20250903, "SE").
shift_data("18108", "Melissa Sanchez", 20250903, "SN").
shift_data("86748", "Kelly Golden", 20250903, "WR").
shift_data("16499", "Donna Baird", 20250903, "WR").
shift_data("16105", "Jason Sherman", 20250903, "WR").
shift_data("27455", "John Williams", 20250903, "D").
shift_data("64937", "Pamela Berry", 20250903, "D").
shift_data("29772", "Chris Curtis", 20250904, "SN").
shift_data("95319", "Joshua Diaz", 20250904, "SE").
shift_data("19494", "Jordan Johnson", 20250904, "SN").
shift_data("22337", "Benjamin Davis", 20250904, "WR").
shift_data("86387", "Ronald Martinez", 20250904, "D").
shift_data("76510", "Mark Meza", 20250904, "LD").
shift_data("14914", "Jennifer Cherry", 20250904, "LD").
shift_data("66838", "Scott Roberts", 20250904, "LD").
shift_data("19156", "Bruce Parker", 20250904, "SE").
shift_data("21889", "Catherine Perkins", 20250904, "SE").
shift_data("65642", "Jacqueline Kelley", 20250904, "WR").
shift_data("84115", "Anthony Harris", 20250904, "WR").
shift_data("39260", "Jessica Edwards", 20250904, "D").
shift_data("92238", "Jody Evans", 20250904, "SN").
shift_data("18108", "Melissa Sanchez", 20250904, "WR").
shift_data("86748", "Kelly Golden", 20250904, "WR").
shift_data("16499", "Donna Baird", 20250904, "D").
shift_data("16105", "Jason Sherman", 20250904, "D").
shift_data("27455", "John Williams", 20250904, "WR").
shift_data("64937", "Pamela Berry", 20250904, "D").
shift_data("29772", "Chris Curtis", 20250905, "WR").
shift_data("95319", "Joshua Diaz", 20250905, "SN").
shift_data("19494", "Jordan Johnson", 20250905, "WR").
shift_data("22337", "Benjamin Davis", 20250905, "LD").
shift_data("86387", "Ronald Martinez", 20250905, "D").
shift_data("76510", "Mark Meza", 20250905, "SE").
shift_data("14914", "Jennifer Cherry", 20250905, "SE").
shift_data("66838", "Scott Roberts", 20250905, "SE").
shift_data("19156", "Bruce Parker", 20250905, "SN").
shift_data("21889", "Catherine Perkins", 20250905, "SN").
shift_data("65642", "Jacqueline Kelley", 20250905, "D").
shift_data("84115", "Anthony Harris", 20250905, "D").
shift_data("39260", "Jessica Edwards", 20250905, "D").
shift_data("92238", "Jody Evans", 20250905, "WR").
shift_data("18108", "Melissa Sanchez", 20250905, "LD").
shift_data("86748", "Kelly Golden", 20250905, "D").
shift_data("16499", "Donna Baird", 20250905, "LD").
shift_data("16105", "Jason Sherman", 20250905, "AL").
shift_data("27455", "John Williams", 20250905, "WR").
shift_data("64937", "Pamela Berry", 20250905, "WR").
shift_data("29772", "Chris Curtis", 20250906, "LD").
shift_data("95319", "Joshua Diaz", 20250906, "WR").
shift_data("19494", "Jordan Johnson", 20250906, "WR").
shift_data("22337", "Benjamin Davis", 20250906, "SE").
shift_data("86387", "Ronald Martinez", 20250906, "TR").
shift_data("76510", "Mark Meza", 20250906, "SN").
shift_data("14914", "Jennifer Cherry", 20250906, "SN").
shift_data("66838", "Scott Roberts", 20250906, "SN").
shift_data("19156", "Bruce Parker", 20250906, "WR").
shift_data("21889", "Catherine Perkins", 20250906, "WR").
shift_data("65642", "Jacqueline Kelley", 20250906, "D").
shift_data("84115", "Anthony Harris", 20250906, "LD").
shift_data("39260", "Jessica Edwards", 20250906, "WR").
shift_data("92238", "Jody Evans", 20250906, "WR").
shift_data("18108", "Melissa Sanchez", 20250906, "SE").
shift_data("86748", "Kelly Golden", 20250906, "D").
shift_data("16499", "Donna Baird", 20250906, "SE").
shift_data("16105", "Jason Sherman", 20250906, "WR").
shift_data("27455", "John Williams", 20250906, "WR").
shift_data("64937", "Pamela Berry", 20250906, "LD").
shift_data("29772", "Chris Curtis", 20250907, "SE").
shift_data("95319", "Joshua Diaz", 20250907, "WR").
shift_data("19494", "Jordan Johnson", 20250907, "LD").
shift_data("22337", "Benjamin Davis", 20250907, "SN").
shift_data("86387", "Ronald Martinez", 20250907, "D").
shift_data("76510", "Mark Meza", 20250907, "WR").
shift_data("14914", "Jennifer Cherry", 20250907, "WR").
shift_data("66838", "Scott Roberts", 20250907, "WR").
shift_data("19156", "Bruce Parker", 20250907, "WR").
shift_data("21889", "Catherine Perkins", 20250907, "WR").
shift_data("65642", "Jacqueline Kelley", 20250907, "D").
shift_data("84115", "Anthony Harris", 20250907, "SE").
shift_data("39260", "Jessica Edwards", 20250907, "WR").
shift_data("92238", "Jody Evans", 20250907, "WR").
shift_data("18108", "Melissa Sanchez", 20250907, "SN").
shift_data("86748", "Kelly Golden", 20250907, "LD").
shift_data("16499", "Donna Baird", 20250907, "SN").
shift_data("16105", "Jason Sherman", 20250907, "TR").
shift_data("27455", "John Williams", 20250907, "LD").
shift_data("64937", "Pamela Berry", 20250907, "SE").
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
