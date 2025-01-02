% Staffs ---------------------------------------------------
staff(1, "Steven Bauer", "Nurse", "53563", 0).
staff(2, "Rebecca Moore", "Nurse", "97039", 0).
staff(3, "Michelle Fischer", "Nurse", "06614", 0).
staff(4, "Albert Welch", "Nurse", "84079", 0).
staff(5, "Isaac Fox", "Nurse", "29194", 0).
staff(6, "Jessica Hansen", "Nurse", "99626", 0).
staff(7, "Nicholas Hodges", "Nurse", "86906", 0).
staff(8, "Debbie Smith", "Nurse", "79039", 0).
staff(9, "Carmen Dunn", "Nurse", "67911", 0).
staff(10, "Cassandra Griffin", "Nurse", "38685", 0).
staff(11, "John Lee DVM", "Nurse", "04777", 0).
staff(12, "Patrick Todd", "Nurse", "71958", 0).
staff(13, "Andrew Jackson", "Nurse", "59179", 0).
staff(14, "Susan Lowery", "Nurse", "49544", 0).
staff(15, "David Hayes", "Nurse", "35525", 0).
staff(16, "Mrs. Sherri Brown", "Nurse", "60706", 0).
staff(17, "Crystal Taylor", "Nurse", "61641", 0).
staff(18, "Sean Jackson", "Nurse", "22338", 0).
staff(19, "Joseph Bush", "Nurse", "11345", 0).
staff(20, "Andrew Roberts", "Nurse", "67569", 0).
staff(21, "Jessica Jackson", "Nurse", "61898", 0).
% Groups ---------------------------------------------------
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
staff_group("All", 21).
staff_group("Heads").
staff_group("Seniors").
staff_group("Seniors", 2).
staff_group("Seniors", 3).
staff_group("Seniors", 5).
staff_group("Seniors", 7).
staff_group("Seniors", 8).
staff_group("Seniors", 9).
staff_group("Seniors", 11).
staff_group("Seniors", 15).
staff_group("Seniors", 16).
staff_group("Seniors", 17).
staff_group("Seniors", 18).
staff_group("Mid-levels").
staff_group("Mid-levels", 1).
staff_group("Mid-levels", 4).
staff_group("Mid-levels", 10).
staff_group("Mid-levels", 12).
staff_group("Mid-levels", 13).
staff_group("Newcomers").
staff_group("Newcomers", 6).
staff_group("Newcomers", 14).
staff_group("Newcomers", 19).
staff_group("Newcomers", 20).
staff_group("Newcomers", 21).
staff_group("Night").
staff_group("Night", 1).
staff_group("Night", 2).
staff_group("Night", 3).
staff_group("Night", 4).
staff_group("Night", 5).
staff_group("Night", 6).
staff_group("Night", 7).
staff_group("Night", 8).
staff_group("Night", 9).
staff_group("Night", 10).
staff_group("Night", 11).
staff_group("Night", 12).
staff_group("Night", 13).
staff_group("Night", 14).
staff_group("Night", 15).
staff_group("Night", 16).
staff_group("Night", 17).
staff_group("Night", 18).
staff_group("Night", 19).
staff_group("Night", 20).
staff_group("Night", 21).
% Shift constraints ----------------------------------------
% Maximum consecutive working days
consecutive_work_ub(hard, "All", 6).
consecutive_work_ub(hard, "Heads", 6).
consecutive_work_ub(hard, "Seniors", 6).
consecutive_work_ub(hard, "Mid-levels", 6).
consecutive_work_ub(hard, "Newcomers", 6).
consecutive_work_ub(hard, "Night", 6).
% Forbidden patterns
forbidden_pattern("LD-LD").
pattern("LD-LD", 2).
pattern("LD-LD", 0, "LD").
pattern("LD-LD", 1, "LD").
forbidden_pattern("SE-SN-SE-SN").
pattern("SE-SN-SE-SN", 4).
pattern("SE-SN-SE-SN", 0, "SE").
pattern("SE-SN-SE-SN", 1, "SN").
pattern("SE-SN-SE-SN", 2, "SE").
pattern("SE-SN-SE-SN", 3, "SN").
forbidden_pattern("LD-D").
pattern("LD-D", 2).
pattern("LD-D", 0, "LD").
pattern("LD-D", 1, "D").
forbidden_pattern("LM-LD").
pattern("LM-LD", 2).
pattern("LM-LD", 0, "LM").
pattern("LM-LD", 1, "LD").
forbidden_pattern("LM-D").
pattern("LM-D", 2).
pattern("LM-D", 0, "LM").
pattern("LM-D", 1, "D").
forbidden_pattern("D-D-D-D-D-LD").
pattern("D-D-D-D-D-LD", 6).
pattern("D-D-D-D-D-LD", 0, "D").
pattern("D-D-D-D-D-LD", 1, "D").
pattern("D-D-D-D-D-LD", 2, "D").
pattern("D-D-D-D-D-LD", 3, "D").
pattern("D-D-D-D-D-LD", 4, "D").
pattern("D-D-D-D-D-LD", 5, "LD").
forbidden_pattern("D-D-D-D-LD-LM").
pattern("D-D-D-D-LD-LM", 6).
pattern("D-D-D-D-LD-LM", 0, "D").
pattern("D-D-D-D-LD-LM", 1, "D").
pattern("D-D-D-D-LD-LM", 2, "D").
pattern("D-D-D-D-LD-LM", 3, "D").
pattern("D-D-D-D-LD-LM", 4, "LD").
pattern("D-D-D-D-LD-LM", 5, "LM").
forbidden_pattern("D-D-D-D-LD-SE").
pattern("D-D-D-D-LD-SE", 6).
pattern("D-D-D-D-LD-SE", 0, "D").
pattern("D-D-D-D-LD-SE", 1, "D").
pattern("D-D-D-D-LD-SE", 2, "D").
pattern("D-D-D-D-LD-SE", 3, "D").
pattern("D-D-D-D-LD-SE", 4, "LD").
pattern("D-D-D-D-LD-SE", 5, "SE").
forbidden_pattern("D-D-LD-SE-SN-SE-SN").
pattern("D-D-LD-SE-SN-SE-SN", 7).
pattern("D-D-LD-SE-SN-SE-SN", 0, "D").
pattern("D-D-LD-SE-SN-SE-SN", 1, "D").
pattern("D-D-LD-SE-SN-SE-SN", 2, "LD").
pattern("D-D-LD-SE-SN-SE-SN", 3, "SE").
pattern("D-D-LD-SE-SN-SE-SN", 4, "SN").
pattern("D-D-LD-SE-SN-SE-SN", 5, "SE").
pattern("D-D-LD-SE-SN-SE-SN", 6, "SN").
forbidden_pattern("D-D-D-D-D-D").
pattern("D-D-D-D-D-D", 6).
pattern("D-D-D-D-D-D", 0, "D").
pattern("D-D-D-D-D-D", 1, "D").
pattern("D-D-D-D-D-D", 2, "D").
pattern("D-D-D-D-D-D", 3, "D").
pattern("D-D-D-D-D-D", 4, "D").
pattern("D-D-D-D-D-D", 5, "D").
% Assignable previous/next shifts
prev_shift(hard, "SN", "SE").
next_shift(hard, "SN", "SE").
next_shift(hard, "SN", "WR").
next_shift(hard, "SN", "PH").
next_shift(hard, "SE", "SN").
next_shift(hard, "E", "N").
prev_shift(hard, "N", "E").
next_shift(hard, "N", "WR").
next_shift(hard, "N", "PH").
% Pattern occurrences
pattern("WR-WR", 2).
pattern("WR-WR", 0, "WR").
pattern("WR-WR", 1, "WR").
pattern_hard_lb("WR-WR", "All", 2).
pattern_hard_lb("WR-WR", "Heads", 2).
pattern_hard_lb("WR-WR", "Seniors", 2).
pattern_hard_lb("WR-WR", "Mid-levels", 2).
pattern_hard_lb("WR-WR", "Newcomers", 2).
pattern_hard_lb("WR-WR", "Night", 2).
pattern_soft_ub("LD-D", "All", 1).
pattern_soft_ub("LD-D", "Heads", 1).
pattern_soft_ub("LD-D", "Seniors", 1).
pattern_soft_ub("LD-D", "Mid-levels", 1).
pattern_soft_ub("LD-D", "Newcomers", 1).
pattern_soft_ub("LD-D", "Night", 1).
pattern_soft_ub("LM-D", "All", 0).
pattern_soft_ub("LM-D", "Heads", 0).
pattern_soft_ub("LM-D", "Seniors", 0).
pattern_soft_ub("LM-D", "Mid-levels", 0).
pattern_soft_ub("LM-D", "Newcomers", 0).
pattern_soft_ub("LM-D", "Night", 0).
pattern_soft_ub("LM-LD", "All", 0).
pattern_soft_ub("LM-LD", "Heads", 0).
pattern_soft_ub("LM-LD", "Seniors", 0).
pattern_soft_ub("LM-LD", "Mid-levels", 0).
pattern_soft_ub("LM-LD", "Newcomers", 0).
pattern_soft_ub("LM-LD", "Night", 0).
pattern("LM-LM", 2).
pattern("LM-LM", 0, "LM").
pattern("LM-LM", 1, "LM").
pattern_soft_ub("LM-LM", "All", 0).
pattern_soft_ub("LM-LM", "Heads", 0).
pattern_soft_ub("LM-LM", "Seniors", 0).
pattern_soft_ub("LM-LM", "Mid-levels", 0).
pattern_soft_ub("LM-LM", "Newcomers", 0).
pattern_soft_ub("LM-LM", "Night", 0).
% Vertical constraints -------------------------------------
shift_group("D").
shift_group("D", "D").
staff_dweek_hard_lb("All", "D", "Weekday", 4).
staff_dweek_hard_lb("All", "D", "Weekend", 1).
staff_dweek_hard_lb("All", "D", "Holiday", 1).
staff_dweek_soft_lb("All", "D", "Weekday", 6).
staff_dweek_soft_lb("All", "D", "Weekend", 2).
staff_dweek_soft_lb("All", "D", "Holiday", 2).
staff_dweek_soft_ub("All", "D", "Weekday", 13).
staff_dweek_soft_ub("All", "D", "Weekend", 3).
staff_dweek_soft_ub("All", "D", "Holiday", 3).
shift_group("LD").
shift_group("LD", "LD").
staff_dweek_soft_lb("All", "LD", "Weekday", 3).
shift_group("SE").
shift_group("SE", "SE").
staff_dweek_soft_lb("All", "SE", "Weekday", 3).
shift_group("SN").
shift_group("SN", "SN").
staff_dweek_soft_lb("All", "SN", "Weekday", 3).
staff_dweek_soft_lb("All", "LD", "Weekend", 3).
staff_dweek_soft_lb("All", "SE", "Weekend", 3).
staff_dweek_soft_lb("All", "SN", "Weekend", 3).
staff_dweek_soft_lb("All", "LD", "Holiday", 3).
staff_dweek_soft_lb("All", "SE", "Holiday", 3).
staff_dweek_soft_lb("All", "SN", "Holiday", 3).
staff_dweek_soft_ub("All", "LD", "Weekday", 3).
staff_dweek_soft_ub("All", "SE", "Weekday", 3).
staff_dweek_soft_ub("All", "SN", "Weekday", 3).
staff_dweek_soft_ub("All", "LD", "Weekend", 3).
staff_dweek_soft_ub("All", "SE", "Weekend", 3).
staff_dweek_soft_ub("All", "SN", "Weekend", 3).
staff_dweek_soft_ub("All", "LD", "Holiday", 3).
staff_dweek_soft_ub("All", "SE", "Holiday", 3).
staff_dweek_soft_ub("All", "SN", "Holiday", 3).
staff_dweek_hard_ub("All", "LD", "Weekday", 3).
staff_dweek_hard_ub("All", "SE", "Weekday", 3).
staff_dweek_hard_ub("All", "SN", "Weekday", 3).
staff_dweek_hard_ub("All", "LD", "Weekend", 3).
staff_dweek_hard_ub("All", "SE", "Weekend", 3).
staff_dweek_hard_ub("All", "SN", "Weekend", 3).
staff_dweek_hard_ub("All", "LD", "Holiday", 3).
staff_dweek_hard_ub("All", "SE", "Holiday", 3).
staff_dweek_hard_ub("All", "SN", "Holiday", 3).
shift_group("E").
shift_group("E", "E").
staff_dweek_soft_ub("All", "E", "Weekday", 0).
shift_group("N").
shift_group("N", "N").
staff_dweek_soft_ub("All", "N", "Weekday", 0).
staff_dweek_soft_ub("All", "E", "Weekend", 0).
staff_dweek_soft_ub("All", "N", "Weekend", 0).
staff_dweek_soft_ub("All", "E", "Holiday", 0).
staff_dweek_soft_ub("All", "N", "Holiday", 0).
shift_group("LM").
shift_group("LM", "LM").
staff_dweek_hard_ub("All", "LM", "Weekday", 1).
staff_dweek_hard_ub("All", "LM", "Weekend", 0).
staff_dweek_hard_ub("All", "LM", "Holiday", 0).
shift_group("LD+LM+E").
shift_group("LD+LM+E", "LD").
shift_group("LD+LM+E", "LM").
shift_group("LD+LM+E", "E").
staff_dweek_hard_lb("All", "LD+LM+E", "Weekday", 3).
staff_dweek_hard_lb("All", "LD+LM+E", "Weekend", 3).
staff_dweek_hard_lb("All", "LD+LM+E", "Holiday", 3).
staff_dweek_soft_ub("All", "LD+LM+E", "Weekday", 5).
staff_dweek_soft_ub("All", "LD+LM+E", "Weekend", 4).
staff_dweek_soft_ub("All", "LD+LM+E", "Holiday", 4).
staff_dweek_soft_lb("Heads", "D", "Weekday", 1).
staff_dweek_soft_lb("Heads", "D", "Weekend", 0).
staff_dweek_soft_lb("Heads", "D", "Holiday", 0).
staff_dweek_soft_ub("Heads", "D", "Weekday", 1).
staff_dweek_soft_ub("Heads", "D", "Weekend", 0).
staff_dweek_soft_ub("Heads", "D", "Holiday", 0).
staff_dweek_hard_lb("Seniors", "LD", "Weekday", 1).
staff_dweek_hard_lb("Seniors", "SE", "Weekday", 1).
staff_dweek_hard_lb("Seniors", "SN", "Weekday", 1).
staff_dweek_hard_lb("Seniors", "LD", "Weekend", 1).
staff_dweek_hard_lb("Seniors", "SE", "Weekend", 1).
staff_dweek_hard_lb("Seniors", "SN", "Weekend", 1).
staff_dweek_hard_lb("Seniors", "LD", "Holiday", 1).
staff_dweek_hard_lb("Seniors", "SE", "Holiday", 1).
staff_dweek_hard_lb("Seniors", "SN", "Holiday", 1).
staff_dweek_soft_lb("Seniors", "LD", "Weekday", 2).
staff_dweek_soft_lb("Seniors", "SE", "Weekday", 2).
staff_dweek_soft_lb("Seniors", "SN", "Weekday", 2).
staff_dweek_soft_lb("Seniors", "LD", "Weekend", 2).
staff_dweek_soft_lb("Seniors", "SE", "Weekend", 2).
staff_dweek_soft_lb("Seniors", "SN", "Weekend", 2).
staff_dweek_soft_lb("Seniors", "LD", "Holiday", 2).
staff_dweek_soft_lb("Seniors", "SE", "Holiday", 2).
staff_dweek_soft_lb("Seniors", "SN", "Holiday", 2).
staff_dweek_soft_ub("Seniors", "LD", "Weekday", 4).
staff_dweek_soft_ub("Seniors", "SE", "Weekday", 4).
staff_dweek_soft_ub("Seniors", "SN", "Weekday", 4).
staff_dweek_soft_ub("Seniors", "LD", "Weekend", 4).
staff_dweek_soft_ub("Seniors", "SE", "Weekend", 4).
staff_dweek_soft_ub("Seniors", "SN", "Weekend", 4).
staff_dweek_soft_ub("Seniors", "LD", "Holiday", 4).
staff_dweek_soft_ub("Seniors", "SE", "Holiday", 4).
staff_dweek_soft_ub("Seniors", "SN", "Holiday", 4).
staff_dweek_hard_lb("Mid-levels", "LD", "Weekday", 1).
staff_dweek_hard_lb("Mid-levels", "SE", "Weekday", 1).
staff_dweek_hard_lb("Mid-levels", "SN", "Weekday", 1).
staff_dweek_hard_lb("Mid-levels", "LD", "Weekend", 1).
staff_dweek_hard_lb("Mid-levels", "SE", "Weekend", 1).
staff_dweek_hard_lb("Mid-levels", "SN", "Weekend", 1).
staff_dweek_hard_lb("Mid-levels", "LD", "Holiday", 1).
staff_dweek_hard_lb("Mid-levels", "SE", "Holiday", 1).
staff_dweek_hard_lb("Mid-levels", "SN", "Holiday", 1).
staff_dweek_soft_lb("Mid-levels", "LD", "Weekday", 2).
staff_dweek_soft_lb("Mid-levels", "SE", "Weekday", 2).
staff_dweek_soft_lb("Mid-levels", "SN", "Weekday", 2).
staff_dweek_soft_lb("Mid-levels", "LD", "Weekend", 2).
staff_dweek_soft_lb("Mid-levels", "SE", "Weekend", 2).
staff_dweek_soft_lb("Mid-levels", "SN", "Weekend", 2).
staff_dweek_soft_lb("Mid-levels", "LD", "Holiday", 2).
staff_dweek_soft_lb("Mid-levels", "SE", "Holiday", 2).
staff_dweek_soft_lb("Mid-levels", "SN", "Holiday", 2).
staff_dweek_soft_ub("Mid-levels", "LD", "Weekday", 4).
staff_dweek_soft_ub("Mid-levels", "SE", "Weekday", 4).
staff_dweek_soft_ub("Mid-levels", "SN", "Weekday", 4).
staff_dweek_soft_ub("Mid-levels", "LD", "Weekend", 4).
staff_dweek_soft_ub("Mid-levels", "SE", "Weekend", 4).
staff_dweek_soft_ub("Mid-levels", "SN", "Weekend", 4).
staff_dweek_soft_ub("Mid-levels", "LD", "Holiday", 4).
staff_dweek_soft_ub("Mid-levels", "SE", "Holiday", 4).
staff_dweek_soft_ub("Mid-levels", "SN", "Holiday", 4).
staff_dweek_hard_lb("Newcomers", "SE", "Weekday", 0).
staff_dweek_hard_lb("Newcomers", "SN", "Weekday", 0).
staff_dweek_hard_lb("Newcomers", "SE", "Weekend", 0).
staff_dweek_hard_lb("Newcomers", "SN", "Weekend", 0).
staff_dweek_hard_lb("Newcomers", "SE", "Holiday", 0).
staff_dweek_hard_lb("Newcomers", "SN", "Holiday", 0).
staff_dweek_soft_lb("Newcomers", "SE", "Weekday", 1).
staff_dweek_soft_lb("Newcomers", "SN", "Weekday", 1).
staff_dweek_soft_lb("Newcomers", "SE", "Weekend", 1).
staff_dweek_soft_lb("Newcomers", "SN", "Weekend", 1).
staff_dweek_soft_lb("Newcomers", "SE", "Holiday", 1).
staff_dweek_soft_lb("Newcomers", "SN", "Holiday", 1).
staff_dweek_soft_ub("Newcomers", "SE", "Weekday", 1).
staff_dweek_soft_ub("Newcomers", "SN", "Weekday", 1).
staff_dweek_soft_ub("Newcomers", "SE", "Weekend", 1).
staff_dweek_soft_ub("Newcomers", "SN", "Weekend", 1).
staff_dweek_soft_ub("Newcomers", "SE", "Holiday", 1).
staff_dweek_soft_ub("Newcomers", "SN", "Holiday", 1).
staff_dweek_hard_ub("Newcomers", "SE", "Weekday", 1).
staff_dweek_hard_ub("Newcomers", "SN", "Weekday", 1).
staff_dweek_hard_ub("Newcomers", "SE", "Weekend", 1).
staff_dweek_hard_ub("Newcomers", "SN", "Weekend", 1).
staff_dweek_hard_ub("Newcomers", "SE", "Holiday", 1).
staff_dweek_hard_ub("Newcomers", "SN", "Holiday", 1).
vertical_constraint_type("All","D","Staffs").
vertical_constraint_type("All","LD","Staffs").
vertical_constraint_type("All","SE","Staffs").
vertical_constraint_type("All","SN","Staffs").
vertical_constraint_type("All","E","Staffs").
vertical_constraint_type("All","N","Staffs").
vertical_constraint_type("All","LM","Staffs").
vertical_constraint_type("All","LD+LM+E","Staffs").
vertical_constraint_type("Heads","D","Staffs").
vertical_constraint_type("Seniors","LD","Staffs").
vertical_constraint_type("Seniors","SE","Staffs").
vertical_constraint_type("Seniors","SN","Staffs").
vertical_constraint_type("Mid-levels","LD","Staffs").
vertical_constraint_type("Mid-levels","SE","Staffs").
vertical_constraint_type("Mid-levels","SN","Staffs").
vertical_constraint_type("Newcomers","SE","Staffs").
vertical_constraint_type("Newcomers","SN","Staffs").
% Horizontal constraints -----------------------------------
% Staff 1:
shifts_soft_lb(1, "LD", 4).
shifts_soft_lb(1, "SE", 4).
shifts_soft_lb(1, "SN", 4).
shifts_hard_ub(1, "E", 0).
shifts_hard_ub(1, "N", 0).
shifts_soft_lb(1, "LM", 0).
shift_group("EM").
shift_group("EM", "EM").
shifts_hard_ub(1, "EM", 0).
% Staff 2:
shifts_soft_lb(2, "LD", 6).
shifts_soft_lb(2, "SE", 6).
shifts_soft_lb(2, "SN", 6).
shifts_hard_ub(2, "E", 0).
shifts_hard_ub(2, "N", 0).
shifts_soft_lb(2, "LM", 0).
shifts_hard_ub(2, "EM", 0).
% Staff 3:
shifts_soft_lb(3, "LD", 5).
shifts_soft_lb(3, "SE", 5).
shifts_soft_lb(3, "SN", 5).
shifts_hard_ub(3, "E", 0).
shifts_hard_ub(3, "N", 0).
shifts_soft_lb(3, "LM", 0).
shifts_hard_ub(3, "EM", 0).
% Staff 4:
shifts_soft_lb(4, "LD", 4).
shifts_soft_lb(4, "SE", 4).
shifts_soft_lb(4, "SN", 4).
shifts_hard_ub(4, "E", 0).
shifts_hard_ub(4, "N", 0).
shifts_soft_lb(4, "LM", 0).
shifts_hard_ub(4, "EM", 0).
% Staff 5:
shifts_soft_lb(5, "LD", 5).
shifts_soft_lb(5, "SE", 5).
shifts_soft_lb(5, "SN", 5).
shifts_hard_ub(5, "E", 0).
shifts_hard_ub(5, "N", 0).
shifts_soft_lb(5, "LM", 0).
shifts_hard_ub(5, "EM", 0).
% Staff 6:
shifts_soft_lb(6, "LD", 2).
shifts_soft_lb(6, "SE", 2).
shifts_soft_lb(6, "SN", 2).
shifts_hard_ub(6, "E", 0).
shifts_hard_ub(6, "N", 0).
shifts_soft_lb(6, "LM", 0).
shifts_hard_ub(6, "EM", 0).
% Staff 7:
shifts_soft_lb(7, "LD", 6).
shifts_soft_lb(7, "SE", 6).
shifts_soft_lb(7, "SN", 6).
shifts_hard_ub(7, "E", 0).
shifts_hard_ub(7, "N", 0).
shifts_soft_lb(7, "LM", 0).
shifts_hard_ub(7, "EM", 0).
% Staff 8:
shifts_soft_lb(8, "LD", 6).
shifts_soft_lb(8, "SE", 6).
shifts_soft_lb(8, "SN", 6).
shifts_hard_ub(8, "E", 0).
shifts_hard_ub(8, "N", 0).
shifts_soft_lb(8, "LM", 0).
shifts_hard_ub(8, "EM", 0).
% Staff 9:
shifts_soft_lb(9, "LD", 6).
shifts_soft_lb(9, "SE", 6).
shifts_soft_lb(9, "SN", 6).
shifts_hard_ub(9, "E", 0).
shifts_hard_ub(9, "N", 0).
shifts_soft_lb(9, "LM", 0).
shifts_hard_ub(9, "EM", 0).
% Staff 10:
shifts_soft_lb(10, "LD", 4).
shifts_soft_lb(10, "SE", 4).
shifts_soft_lb(10, "SN", 4).
shifts_hard_ub(10, "E", 0).
shifts_hard_ub(10, "N", 0).
shifts_soft_lb(10, "LM", 0).
shifts_hard_ub(10, "EM", 0).
% Staff 11:
shifts_soft_lb(11, "LD", 5).
shifts_soft_lb(11, "SE", 5).
shifts_soft_lb(11, "SN", 5).
shifts_hard_ub(11, "E", 0).
shifts_hard_ub(11, "N", 0).
shifts_soft_lb(11, "LM", 0).
shifts_hard_ub(11, "EM", 0).
% Staff 12:
shifts_soft_lb(12, "LD", 4).
shifts_soft_lb(12, "SE", 4).
shifts_soft_lb(12, "SN", 4).
shifts_hard_ub(12, "E", 0).
shifts_hard_ub(12, "N", 0).
shifts_soft_lb(12, "LM", 0).
shifts_hard_ub(12, "EM", 0).
% Staff 13:
shifts_soft_lb(13, "LD", 4).
shifts_soft_lb(13, "SE", 4).
shifts_soft_lb(13, "SN", 4).
shifts_hard_ub(13, "E", 0).
shifts_hard_ub(13, "N", 0).
shifts_soft_lb(13, "LM", 0).
shifts_hard_ub(13, "EM", 0).
% Staff 14:
shifts_soft_lb(14, "LD", 1).
shifts_soft_lb(14, "SE", 1).
shifts_soft_lb(14, "SN", 1).
shifts_hard_ub(14, "E", 0).
shifts_hard_ub(14, "N", 0).
shifts_soft_lb(14, "LM", 0).
shifts_hard_ub(14, "EM", 0).
% Staff 15:
shifts_soft_lb(15, "LD", 6).
shifts_soft_lb(15, "SE", 6).
shifts_soft_lb(15, "SN", 6).
shifts_hard_ub(15, "E", 0).
shifts_hard_ub(15, "N", 0).
shifts_soft_lb(15, "LM", 0).
shifts_hard_ub(15, "EM", 0).
% Staff 16:
shifts_soft_lb(16, "LD", 6).
shifts_soft_lb(16, "SE", 6).
shifts_soft_lb(16, "SN", 6).
shifts_hard_ub(16, "E", 0).
shifts_hard_ub(16, "N", 0).
shifts_soft_lb(16, "LM", 0).
shifts_hard_ub(16, "EM", 0).
% Staff 17:
shifts_soft_lb(17, "LD", 5).
shifts_soft_lb(17, "SE", 5).
shifts_soft_lb(17, "SN", 5).
shifts_hard_ub(17, "E", 3).
shifts_hard_ub(17, "N", 3).
shifts_soft_lb(17, "LM", 0).
shifts_hard_ub(17, "EM", 0).
% Staff 18:
shifts_soft_lb(18, "LD", 5).
shifts_soft_lb(18, "SE", 5).
shifts_soft_lb(18, "SN", 5).
shifts_hard_ub(18, "E", 0).
shifts_hard_ub(18, "N", 0).
shifts_soft_lb(18, "LM", 0).
shifts_hard_ub(18, "EM", 0).
% Staff 19:
shifts_soft_lb(19, "LD", 2).
shifts_soft_lb(19, "SE", 2).
shifts_soft_lb(19, "SN", 2).
shifts_hard_ub(19, "LD", 3).
shifts_hard_ub(19, "SE", 3).
shifts_hard_ub(19, "SN", 3).
shifts_hard_ub(19, "E", 0).
shifts_hard_ub(19, "N", 0).
shifts_soft_lb(19, "LM", 0).
shifts_hard_ub(19, "EM", 0).
% Staff 20:
shifts_soft_lb(20, "LD", 2).
shifts_soft_lb(20, "SE", 2).
shifts_soft_lb(20, "SN", 2).
shifts_hard_ub(20, "LD", 3).
shifts_hard_ub(20, "SE", 3).
shifts_hard_ub(20, "SN", 3).
shifts_hard_ub(20, "E", 0).
shifts_hard_ub(20, "N", 0).
shifts_soft_lb(20, "LM", 0).
shifts_hard_ub(20, "EM", 0).
% Staff 21:
shifts_soft_lb(21, "LD", 2).
shifts_soft_lb(21, "SE", 2).
shifts_soft_lb(21, "SN", 2).
shifts_hard_ub(21, "LD", 3).
shifts_hard_ub(21, "SE", 3).
shifts_hard_ub(21, "SN", 3).
shifts_hard_ub(21, "E", 0).
shifts_hard_ub(21, "N", 0).
shifts_soft_lb(21, "LM", 0).
shifts_hard_ub(21, "EM", 0).
horizontal_constraint_type("D").
horizontal_constraint_type("LD").
horizontal_constraint_type("SE").
horizontal_constraint_type("SN").
horizontal_constraint_type("E").
horizontal_constraint_type("N").
horizontal_constraint_type("LM").
horizontal_constraint_type("EM").
% Positive shifts ------------------------------------------
% Negative shifts ------------------------------------------
