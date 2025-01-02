% Staffs ---------------------------------------------------
staff(1, "Debra Davies", "Chief Nurse", "06087", 0).
staff(2, "Ronald Thomas", "Deputy Chief Nurse", "86833", 5).
staff(3, "David Barrett", "Deputy Chief Nurse", "61228", 5).
staff(4, "Monique Smith", "Nurse", "51404", 5).
staff(5, "Mr. James Mack", "Nurse", "13618", 5).
staff(6, "Dr. Crystal Fuller", "Nurse", "67083", 5).
staff(7, "Lisa Spencer", "Nurse", "50354", 2).
staff(8, "Laurie Jones", "Nurse", "67096", 2).
staff(9, "Thomas Hart", "Nurse", "14009", 5).
staff(10, "Elizabeth Crawford", "Nurse", "53598", 2).
staff(11, "Vanessa Jackson", "Nurse", "30297", 3).
staff(12, "Mary Hamilton", "Nurse", "69025", 0).
staff(13, "Carrie Brown", "Nurse", "24774", 3).
staff(14, "Maria Cummings", "Nurse", "51802", 3).
staff(15, "Elizabeth Dawson", "Nurse", "98772", 3).
staff(16, "Ruben Cortez", "Nurse", "74379", 3).
staff(17, "Nicholas Lee", "Nurse", "23085", 3).
staff(18, "Ryan Marsh", "Nurse", "02893", 2).
% Groups ---------------------------------------------------
staff_group("All").
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
staff_group("All", 13).
staff_group("All", 14).
staff_group("All", 15).
staff_group("All", 16).
staff_group("All", 17).
staff_group("All", 18).
staff_group("Heads").
staff_group("Heads", 1).
staff_group("Seniors").
staff_group("Seniors", 2).
staff_group("Seniors", 3).
staff_group("Seniors", 4).
staff_group("Seniors", 5).
staff_group("Seniors", 6).
staff_group("Seniors", 7).
staff_group("Seniors", 10).
staff_group("Mid-levels").
staff_group("Mid-levels", 11).
staff_group("Mid-levels", 13).
staff_group("Mid-levels", 14).
staff_group("Mid-levels", 15).
staff_group("Newcomers").
staff_group("Newcomers", 9).
staff_group("Newcomers", 16).
staff_group("Newcomers", 17).
staff_group("Newcomers", 18).
staff_group("Night").
staff_group("Night", 2).
staff_group("Night", 3).
staff_group("Night", 4).
staff_group("Night", 5).
staff_group("Night", 6).
staff_group("Night", 7).
staff_group("Night", 9).
staff_group("Night", 10).
staff_group("Night", 11).
staff_group("Night", 13).
staff_group("Night", 14).
staff_group("Night", 15).
staff_group("Night", 16).
staff_group("Night", 17).
staff_group("Night", 18).
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
prev_shift(hard, "SE", "LD").
prev_shift(hard, "SE", "LM").
prev_shift(hard, "SE", "D").
prev_shift(hard, "SE", "WR").
prev_shift(hard, "SE", "PH").
next_shift(hard, "SE", "SN").
prev_shift(hard, "E", "LD").
prev_shift(hard, "E", "LM").
prev_shift(hard, "E", "D").
prev_shift(hard, "E", "WR").
prev_shift(hard, "E", "PH").
next_shift(hard, "E", "N").
prev_shift(hard, "N", "E").
next_shift(hard, "N", "WR").
next_shift(hard, "N", "PH").
prev_shift(hard, "D", "D").
prev_shift(hard, "D", "WR").
prev_shift(hard, "D", "PH").
next_shift(hard, "D", "LD").
next_shift(hard, "D", "LM").
next_shift(hard, "D", "D").
next_shift(hard, "D", "WR").
next_shift(hard, "D", "PH").
next_shift(hard, "D", "SE").
next_shift(hard, "D", "E").
prev_shift(hard, "LD", "D").
prev_shift(hard, "LD", "WR").
prev_shift(hard, "LD", "PH").
next_shift(hard, "LD", "LM").
next_shift(hard, "LD", "WR").
next_shift(hard, "LD", "PH").
next_shift(hard, "LD", "SE").
next_shift(hard, "LD", "E").
prev_shift(hard, "LM", "LD").
prev_shift(hard, "LM", "D").
prev_shift(hard, "LM", "WR").
prev_shift(hard, "LM", "PH").
next_shift(hard, "LM", "WR").
next_shift(hard, "LM", "PH").
next_shift(hard, "LM", "SE").
next_shift(hard, "LM", "E").
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
pattern_soft_ub("LD-D", "All", 0).
pattern_soft_ub("LD-D", "Heads", 0).
pattern_soft_ub("LD-D", "Seniors", 0).
pattern_soft_ub("LD-D", "Mid-levels", 0).
pattern_soft_ub("LD-D", "Newcomers", 0).
pattern_soft_ub("LD-D", "Night", 0).
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
staff_dweek_hard_lb("All", "D", "Weekday", 0).
staff_dweek_hard_lb("All", "D", "Weekend", 0).
staff_dweek_hard_lb("All", "D", "Holiday", 0).
staff_dweek_soft_lb("All", "D", "Weekday", 3).
staff_dweek_soft_lb("All", "D", "Weekend", 0).
staff_dweek_soft_lb("All", "D", "Holiday", 0).
staff_dweek_soft_ub("All", "D", "Weekday", 7).
staff_dweek_soft_ub("All", "D", "Weekend", 0).
staff_dweek_soft_ub("All", "D", "Holiday", 0).
staff_dweek_hard_ub("All", "D", "Weekday", 7).
staff_dweek_hard_ub("All", "D", "Weekend", 0).
staff_dweek_hard_ub("All", "D", "Holiday", 0).
shift_group("LD").
shift_group("LD", "LD").
staff_dweek_hard_lb("All", "LD", "Weekday", 2).
shift_group("SE").
shift_group("SE", "SE").
staff_dweek_hard_lb("All", "SE", "Weekday", 2).
shift_group("SN").
shift_group("SN", "SN").
staff_dweek_hard_lb("All", "SN", "Weekday", 2).
staff_dweek_hard_lb("All", "LD", "Weekend", 2).
staff_dweek_hard_lb("All", "SE", "Weekend", 2).
staff_dweek_hard_lb("All", "SN", "Weekend", 2).
staff_dweek_hard_lb("All", "LD", "Holiday", 2).
staff_dweek_hard_lb("All", "SE", "Holiday", 2).
staff_dweek_hard_lb("All", "SN", "Holiday", 2).
staff_dweek_soft_lb("All", "LD", "Weekday", 2).
staff_dweek_soft_lb("All", "SE", "Weekday", 2).
staff_dweek_soft_lb("All", "SN", "Weekday", 2).
staff_dweek_soft_lb("All", "LD", "Weekend", 2).
staff_dweek_soft_lb("All", "SE", "Weekend", 2).
staff_dweek_soft_lb("All", "SN", "Weekend", 2).
staff_dweek_soft_lb("All", "LD", "Holiday", 2).
staff_dweek_soft_lb("All", "SE", "Holiday", 2).
staff_dweek_soft_lb("All", "SN", "Holiday", 2).
staff_dweek_soft_ub("All", "LD", "Weekday", 2).
staff_dweek_soft_ub("All", "SE", "Weekday", 2).
staff_dweek_soft_ub("All", "SN", "Weekday", 2).
staff_dweek_soft_ub("All", "LD", "Weekend", 2).
staff_dweek_soft_ub("All", "SE", "Weekend", 2).
staff_dweek_soft_ub("All", "SN", "Weekend", 2).
staff_dweek_soft_ub("All", "LD", "Holiday", 2).
staff_dweek_soft_ub("All", "SE", "Holiday", 2).
staff_dweek_soft_ub("All", "SN", "Holiday", 2).
staff_dweek_hard_ub("All", "LD", "Weekday", 3).
staff_dweek_hard_ub("All", "SE", "Weekday", 3).
staff_dweek_hard_ub("All", "SN", "Weekday", 3).
staff_dweek_hard_ub("All", "LD", "Weekend", 2).
staff_dweek_hard_ub("All", "SE", "Weekend", 2).
staff_dweek_hard_ub("All", "SN", "Weekend", 2).
staff_dweek_hard_ub("All", "LD", "Holiday", 2).
staff_dweek_hard_ub("All", "SE", "Holiday", 2).
staff_dweek_hard_ub("All", "SN", "Holiday", 2).
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
staff_dweek_hard_ub("All", "LM", "Weekday", 0).
staff_dweek_hard_ub("All", "LM", "Weekend", 0).
staff_dweek_hard_ub("All", "LM", "Holiday", 0).
shift_group("LD+LM+E").
shift_group("LD+LM+E", "LD").
shift_group("LD+LM+E", "LM").
shift_group("LD+LM+E", "E").
staff_dweek_soft_lb("All", "LD+LM+E", "Weekday", 2).
staff_dweek_soft_lb("All", "LD+LM+E", "Weekend", 2).
staff_dweek_soft_lb("All", "LD+LM+E", "Holiday", 2).
staff_dweek_hard_lb("Seniors", "LD", "Weekday", 0).
staff_dweek_hard_lb("Seniors", "SE", "Weekday", 0).
staff_dweek_hard_lb("Seniors", "SN", "Weekday", 0).
staff_dweek_hard_lb("Seniors", "LD", "Weekend", 0).
staff_dweek_hard_lb("Seniors", "SE", "Weekend", 0).
staff_dweek_hard_lb("Seniors", "SN", "Weekend", 0).
staff_dweek_hard_lb("Seniors", "LD", "Holiday", 0).
staff_dweek_hard_lb("Seniors", "SE", "Holiday", 0).
staff_dweek_hard_lb("Seniors", "SN", "Holiday", 0).
staff_dweek_soft_lb("Seniors", "LD", "Weekday", 1).
staff_dweek_soft_lb("Seniors", "SE", "Weekday", 1).
staff_dweek_soft_lb("Seniors", "SN", "Weekday", 1).
staff_dweek_soft_lb("Seniors", "LD", "Weekend", 1).
staff_dweek_soft_lb("Seniors", "SE", "Weekend", 1).
staff_dweek_soft_lb("Seniors", "SN", "Weekend", 1).
staff_dweek_soft_lb("Seniors", "LD", "Holiday", 1).
staff_dweek_soft_lb("Seniors", "SE", "Holiday", 1).
staff_dweek_soft_lb("Seniors", "SN", "Holiday", 1).
staff_dweek_soft_ub("Seniors", "LD", "Weekday", 2).
staff_dweek_soft_ub("Seniors", "SE", "Weekday", 2).
staff_dweek_soft_ub("Seniors", "SN", "Weekday", 2).
staff_dweek_soft_ub("Seniors", "LD", "Weekend", 2).
staff_dweek_soft_ub("Seniors", "SE", "Weekend", 2).
staff_dweek_soft_ub("Seniors", "SN", "Weekend", 2).
staff_dweek_soft_ub("Seniors", "LD", "Holiday", 2).
staff_dweek_soft_ub("Seniors", "SE", "Holiday", 2).
staff_dweek_soft_ub("Seniors", "SN", "Holiday", 2).
staff_dweek_hard_ub("Seniors", "LD", "Weekday", 3).
staff_dweek_hard_ub("Seniors", "SE", "Weekday", 3).
staff_dweek_hard_ub("Seniors", "SN", "Weekday", 3).
staff_dweek_hard_ub("Seniors", "LD", "Weekend", 3).
staff_dweek_hard_ub("Seniors", "SE", "Weekend", 3).
staff_dweek_hard_ub("Seniors", "SN", "Weekend", 3).
staff_dweek_hard_ub("Seniors", "LD", "Holiday", 3).
staff_dweek_hard_ub("Seniors", "SE", "Holiday", 3).
staff_dweek_hard_ub("Seniors", "SN", "Holiday", 3).
staff_dweek_soft_lb("Heads", "D", "Weekday", 1).
staff_dweek_soft_lb("Heads", "D", "Weekend", 0).
staff_dweek_soft_lb("Heads", "D", "Holiday", 0).
staff_dweek_soft_ub("Heads", "D", "Weekday", 1).
staff_dweek_soft_ub("Heads", "D", "Weekend", 0).
staff_dweek_soft_ub("Heads", "D", "Holiday", 0).
staff_dweek_hard_lb("Mid-levels", "LD", "Weekday", 0).
staff_dweek_hard_lb("Mid-levels", "SE", "Weekday", 0).
staff_dweek_hard_lb("Mid-levels", "SN", "Weekday", 0).
staff_dweek_hard_lb("Mid-levels", "LD", "Weekend", 0).
staff_dweek_hard_lb("Mid-levels", "SE", "Weekend", 0).
staff_dweek_hard_lb("Mid-levels", "SN", "Weekend", 0).
staff_dweek_hard_lb("Mid-levels", "LD", "Holiday", 0).
staff_dweek_hard_lb("Mid-levels", "SE", "Holiday", 0).
staff_dweek_hard_lb("Mid-levels", "SN", "Holiday", 0).
staff_dweek_soft_lb("Mid-levels", "LD", "Weekday", 1).
staff_dweek_soft_lb("Mid-levels", "SE", "Weekday", 1).
staff_dweek_soft_lb("Mid-levels", "SN", "Weekday", 1).
staff_dweek_soft_lb("Mid-levels", "LD", "Weekend", 1).
staff_dweek_soft_lb("Mid-levels", "SE", "Weekend", 1).
staff_dweek_soft_lb("Mid-levels", "SN", "Weekend", 1).
staff_dweek_soft_lb("Mid-levels", "LD", "Holiday", 1).
staff_dweek_soft_lb("Mid-levels", "SE", "Holiday", 1).
staff_dweek_soft_lb("Mid-levels", "SN", "Holiday", 1).
staff_dweek_soft_ub("Mid-levels", "LD", "Weekday", 1).
staff_dweek_soft_ub("Mid-levels", "SE", "Weekday", 1).
staff_dweek_soft_ub("Mid-levels", "SN", "Weekday", 1).
staff_dweek_soft_ub("Mid-levels", "LD", "Weekend", 1).
staff_dweek_soft_ub("Mid-levels", "SE", "Weekend", 1).
staff_dweek_soft_ub("Mid-levels", "SN", "Weekend", 1).
staff_dweek_soft_ub("Mid-levels", "LD", "Holiday", 1).
staff_dweek_soft_ub("Mid-levels", "SE", "Holiday", 1).
staff_dweek_soft_ub("Mid-levels", "SN", "Holiday", 1).
staff_dweek_hard_ub("Mid-levels", "LD", "Weekday", 1).
staff_dweek_hard_ub("Mid-levels", "SE", "Weekday", 1).
staff_dweek_hard_ub("Mid-levels", "SN", "Weekday", 1).
staff_dweek_hard_ub("Mid-levels", "LD", "Weekend", 1).
staff_dweek_hard_ub("Mid-levels", "SE", "Weekend", 1).
staff_dweek_hard_ub("Mid-levels", "SN", "Weekend", 1).
staff_dweek_hard_ub("Mid-levels", "LD", "Holiday", 1).
staff_dweek_hard_ub("Mid-levels", "SE", "Holiday", 1).
staff_dweek_hard_ub("Mid-levels", "SN", "Holiday", 1).
staff_dweek_hard_lb("Newcomers", "SE", "Weekday", 0).
staff_dweek_hard_lb("Newcomers", "SN", "Weekday", 0).
staff_dweek_hard_lb("Newcomers", "SE", "Weekend", 0).
staff_dweek_hard_lb("Newcomers", "SN", "Weekend", 0).
staff_dweek_hard_lb("Newcomers", "SE", "Holiday", 0).
staff_dweek_hard_lb("Newcomers", "SN", "Holiday", 0).
staff_dweek_soft_lb("Newcomers", "SE", "Weekday", 0).
staff_dweek_soft_lb("Newcomers", "SN", "Weekday", 0).
staff_dweek_soft_lb("Newcomers", "SE", "Weekend", 0).
staff_dweek_soft_lb("Newcomers", "SN", "Weekend", 0).
staff_dweek_soft_lb("Newcomers", "SE", "Holiday", 0).
staff_dweek_soft_lb("Newcomers", "SN", "Holiday", 0).
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
vertical_constraint_type("Seniors","LD","Staffs").
vertical_constraint_type("Seniors","SE","Staffs").
vertical_constraint_type("Seniors","SN","Staffs").
vertical_constraint_type("Heads","D","Staffs").
vertical_constraint_type("Mid-levels","LD","Staffs").
vertical_constraint_type("Mid-levels","SE","Staffs").
vertical_constraint_type("Mid-levels","SN","Staffs").
vertical_constraint_type("Newcomers","SE","Staffs").
vertical_constraint_type("Newcomers","SN","Staffs").
% Horizontal constraints -----------------------------------
% Staff 1:
shifts_soft_lb(1, "LD", 0).
shifts_soft_lb(1, "SE", 0).
shifts_soft_lb(1, "SN", 0).
shifts_soft_ub(1, "LD", 0).
shifts_soft_ub(1, "SE", 0).
shifts_soft_ub(1, "SN", 0).
shifts_hard_ub(1, "LD", 0).
shifts_hard_ub(1, "SE", 0).
shifts_hard_ub(1, "SN", 0).
shifts_hard_lb(1, "E", 0).
shifts_hard_lb(1, "N", 0).
shifts_soft_lb(1, "E", 0).
shifts_soft_lb(1, "N", 0).
shifts_soft_ub(1, "E", 0).
shifts_soft_ub(1, "N", 0).
shifts_hard_ub(1, "E", 0).
shifts_hard_ub(1, "N", 0).
shifts_hard_lb(1, "LM", 0).
shifts_soft_lb(1, "LM", 0).
shifts_soft_ub(1, "LM", 0).
shifts_hard_ub(1, "LM", 0).
shift_group("EM").
shift_group("EM", "EM").
shifts_hard_ub(1, "EM", 0).
% Staff 2:
shifts_soft_lb(2, "LD", 2).
shifts_soft_lb(2, "SE", 2).
shifts_soft_lb(2, "SN", 2).
shifts_soft_ub(2, "LD", 2).
shifts_soft_ub(2, "SE", 2).
shifts_soft_ub(2, "SN", 2).
shifts_hard_lb(2, "E", 0).
shifts_hard_lb(2, "N", 0).
shifts_soft_lb(2, "E", 0).
shifts_soft_lb(2, "N", 0).
shifts_soft_ub(2, "E", 0).
shifts_soft_ub(2, "N", 0).
shifts_hard_ub(2, "E", 0).
shifts_hard_ub(2, "N", 0).
shifts_hard_lb(2, "LM", 0).
shifts_soft_lb(2, "LM", 0).
shifts_soft_ub(2, "LM", 0).
shifts_hard_ub(2, "LM", 0).
shifts_hard_ub(2, "EM", 0).
% Staff 3:
shifts_soft_lb(3, "LD", 2).
shifts_soft_lb(3, "SE", 2).
shifts_soft_lb(3, "SN", 2).
shifts_soft_ub(3, "LD", 2).
shifts_soft_ub(3, "SE", 2).
shifts_soft_ub(3, "SN", 2).
shifts_hard_lb(3, "E", 0).
shifts_hard_lb(3, "N", 0).
shifts_soft_lb(3, "E", 0).
shifts_soft_lb(3, "N", 0).
shifts_soft_ub(3, "E", 0).
shifts_soft_ub(3, "N", 0).
shifts_hard_ub(3, "E", 0).
shifts_hard_ub(3, "N", 0).
shifts_hard_lb(3, "LM", 0).
shifts_soft_lb(3, "LM", 0).
shifts_soft_ub(3, "LM", 0).
shifts_hard_ub(3, "LM", 0).
shifts_hard_ub(3, "EM", 0).
% Staff 4:
shifts_soft_lb(4, "LD", 2).
shifts_soft_lb(4, "SE", 2).
shifts_soft_lb(4, "SN", 2).
shifts_soft_ub(4, "LD", 4).
shifts_soft_ub(4, "SE", 4).
shifts_soft_ub(4, "SN", 4).
shifts_hard_lb(4, "E", 0).
shifts_hard_lb(4, "N", 0).
shifts_soft_lb(4, "E", 0).
shifts_soft_lb(4, "N", 0).
shifts_soft_ub(4, "E", 0).
shifts_soft_ub(4, "N", 0).
shifts_hard_ub(4, "E", 0).
shifts_hard_ub(4, "N", 0).
shifts_hard_lb(4, "LM", 0).
shifts_soft_lb(4, "LM", 0).
shifts_soft_ub(4, "LM", 0).
shifts_hard_ub(4, "LM", 0).
shifts_hard_ub(4, "EM", 0).
% Staff 5:
shifts_soft_lb(5, "LD", 0).
shifts_soft_lb(5, "SE", 0).
shifts_soft_lb(5, "SN", 0).
shifts_soft_ub(5, "LD", 0).
shifts_soft_ub(5, "SE", 0).
shifts_soft_ub(5, "SN", 0).
shifts_hard_lb(5, "E", 0).
shifts_hard_lb(5, "N", 0).
shifts_soft_lb(5, "E", 0).
shifts_soft_lb(5, "N", 0).
shifts_soft_ub(5, "E", 0).
shifts_soft_ub(5, "N", 0).
shifts_hard_ub(5, "E", 0).
shifts_hard_ub(5, "N", 0).
shifts_hard_lb(5, "LM", 0).
shifts_soft_lb(5, "LM", 0).
shifts_soft_ub(5, "LM", 0).
shifts_hard_ub(5, "LM", 0).
shifts_hard_ub(5, "EM", 0).
% Staff 6:
shifts_soft_lb(6, "LD", 2).
shifts_soft_lb(6, "SE", 2).
shifts_soft_lb(6, "SN", 2).
shifts_soft_ub(6, "LD", 4).
shifts_soft_ub(6, "SE", 4).
shifts_soft_ub(6, "SN", 4).
shifts_hard_lb(6, "E", 0).
shifts_hard_lb(6, "N", 0).
shifts_soft_lb(6, "E", 0).
shifts_soft_lb(6, "N", 0).
shifts_soft_ub(6, "E", 0).
shifts_soft_ub(6, "N", 0).
shifts_hard_ub(6, "E", 0).
shifts_hard_ub(6, "N", 0).
shifts_hard_lb(6, "LM", 0).
shifts_soft_lb(6, "LM", 0).
shifts_soft_ub(6, "LM", 0).
shifts_hard_ub(6, "LM", 0).
shifts_hard_ub(6, "EM", 0).
% Staff 7:
shifts_soft_lb(7, "LD", 2).
shifts_soft_lb(7, "SE", 2).
shifts_soft_lb(7, "SN", 2).
shifts_soft_ub(7, "LD", 4).
shifts_soft_ub(7, "SE", 4).
shifts_soft_ub(7, "SN", 4).
shifts_hard_lb(7, "E", 0).
shifts_hard_lb(7, "N", 0).
shifts_soft_lb(7, "E", 0).
shifts_soft_lb(7, "N", 0).
shifts_soft_ub(7, "E", 0).
shifts_soft_ub(7, "N", 0).
shifts_hard_ub(7, "E", 0).
shifts_hard_ub(7, "N", 0).
shifts_hard_lb(7, "LM", 0).
shifts_soft_lb(7, "LM", 0).
shifts_soft_ub(7, "LM", 0).
shifts_hard_ub(7, "LM", 0).
shifts_hard_ub(7, "EM", 0).
% Staff 8:
shifts_soft_lb(8, "LD", 0).
shifts_soft_lb(8, "SE", 0).
shifts_soft_lb(8, "SN", 0).
shifts_soft_ub(8, "LD", 0).
shifts_soft_ub(8, "SE", 0).
shifts_soft_ub(8, "SN", 0).
shifts_hard_lb(8, "E", 0).
shifts_hard_lb(8, "N", 0).
shifts_soft_lb(8, "E", 0).
shifts_soft_lb(8, "N", 0).
shifts_soft_ub(8, "E", 0).
shifts_soft_ub(8, "N", 0).
shifts_hard_ub(8, "E", 0).
shifts_hard_ub(8, "N", 0).
shifts_hard_lb(8, "LM", 0).
shifts_soft_lb(8, "LM", 0).
shifts_soft_ub(8, "LM", 0).
shifts_hard_ub(8, "LM", 0).
shifts_hard_ub(8, "EM", 0).
% Staff 9:
shifts_soft_lb(9, "LD", 2).
shifts_soft_lb(9, "SE", 2).
shifts_soft_lb(9, "SN", 2).
shifts_soft_ub(9, "LD", 4).
shifts_soft_ub(9, "SE", 4).
shifts_soft_ub(9, "SN", 4).
shifts_hard_lb(9, "E", 0).
shifts_hard_lb(9, "N", 0).
shifts_soft_lb(9, "E", 0).
shifts_soft_lb(9, "N", 0).
shifts_soft_ub(9, "E", 0).
shifts_soft_ub(9, "N", 0).
shifts_hard_ub(9, "E", 0).
shifts_hard_ub(9, "N", 0).
shifts_hard_lb(9, "LM", 0).
shifts_soft_lb(9, "LM", 0).
shifts_soft_ub(9, "LM", 0).
shifts_hard_ub(9, "LM", 0).
shifts_hard_ub(9, "EM", 0).
% Staff 10:
shifts_soft_lb(10, "LD", 2).
shifts_soft_lb(10, "SE", 2).
shifts_soft_lb(10, "SN", 2).
shifts_soft_ub(10, "LD", 4).
shifts_soft_ub(10, "SE", 4).
shifts_soft_ub(10, "SN", 4).
shifts_hard_lb(10, "E", 0).
shifts_hard_lb(10, "N", 0).
shifts_soft_lb(10, "E", 0).
shifts_soft_lb(10, "N", 0).
shifts_soft_ub(10, "E", 0).
shifts_soft_ub(10, "N", 0).
shifts_hard_ub(10, "E", 0).
shifts_hard_ub(10, "N", 0).
shifts_hard_lb(10, "LM", 0).
shifts_soft_lb(10, "LM", 0).
shifts_soft_ub(10, "LM", 0).
shifts_hard_ub(10, "LM", 0).
shifts_hard_ub(10, "EM", 0).
% Staff 11:
shifts_soft_lb(11, "LD", 2).
shifts_soft_lb(11, "SE", 2).
shifts_soft_lb(11, "SN", 2).
shifts_soft_ub(11, "LD", 4).
shifts_soft_ub(11, "SE", 4).
shifts_soft_ub(11, "SN", 4).
shifts_hard_lb(11, "E", 0).
shifts_hard_lb(11, "N", 0).
shifts_soft_lb(11, "E", 0).
shifts_soft_lb(11, "N", 0).
shifts_soft_ub(11, "E", 0).
shifts_soft_ub(11, "N", 0).
shifts_hard_ub(11, "E", 0).
shifts_hard_ub(11, "N", 0).
shifts_hard_lb(11, "LM", 0).
shifts_soft_lb(11, "LM", 0).
shifts_soft_ub(11, "LM", 0).
shifts_hard_ub(11, "LM", 0).
shifts_hard_ub(11, "EM", 0).
% Staff 12:
shifts_soft_lb(12, "LD", 0).
shifts_soft_lb(12, "SE", 0).
shifts_soft_lb(12, "SN", 0).
shifts_soft_ub(12, "LD", 0).
shifts_soft_ub(12, "SE", 0).
shifts_soft_ub(12, "SN", 0).
shifts_hard_lb(12, "E", 0).
shifts_hard_lb(12, "N", 0).
shifts_soft_lb(12, "E", 0).
shifts_soft_lb(12, "N", 0).
shifts_soft_ub(12, "E", 0).
shifts_soft_ub(12, "N", 0).
shifts_hard_ub(12, "E", 0).
shifts_hard_ub(12, "N", 0).
shifts_hard_lb(12, "LM", 0).
shifts_soft_lb(12, "LM", 0).
shifts_soft_ub(12, "LM", 0).
shifts_hard_ub(12, "LM", 0).
shifts_hard_ub(12, "EM", 0).
% Staff 13:
shifts_soft_lb(13, "LD", 2).
shifts_soft_lb(13, "SE", 2).
shifts_soft_lb(13, "SN", 2).
shifts_soft_ub(13, "LD", 4).
shifts_soft_ub(13, "SE", 4).
shifts_soft_ub(13, "SN", 4).
shifts_hard_lb(13, "E", 0).
shifts_hard_lb(13, "N", 0).
shifts_soft_lb(13, "E", 0).
shifts_soft_lb(13, "N", 0).
shifts_soft_ub(13, "E", 0).
shifts_soft_ub(13, "N", 0).
shifts_hard_ub(13, "E", 0).
shifts_hard_ub(13, "N", 0).
shifts_hard_lb(13, "LM", 0).
shifts_soft_lb(13, "LM", 0).
shifts_soft_ub(13, "LM", 0).
shifts_hard_ub(13, "LM", 0).
shifts_hard_ub(13, "EM", 0).
% Staff 14:
shifts_soft_lb(14, "LD", 2).
shifts_soft_lb(14, "SE", 2).
shifts_soft_lb(14, "SN", 2).
shifts_soft_ub(14, "LD", 4).
shifts_soft_ub(14, "SE", 4).
shifts_soft_ub(14, "SN", 4).
shifts_hard_lb(14, "E", 0).
shifts_hard_lb(14, "N", 0).
shifts_soft_lb(14, "E", 0).
shifts_soft_lb(14, "N", 0).
shifts_soft_ub(14, "E", 0).
shifts_soft_ub(14, "N", 0).
shifts_hard_ub(14, "E", 0).
shifts_hard_ub(14, "N", 0).
shifts_hard_lb(14, "LM", 0).
shifts_soft_lb(14, "LM", 0).
shifts_soft_ub(14, "LM", 0).
shifts_hard_ub(14, "LM", 0).
shifts_hard_ub(14, "EM", 0).
% Staff 15:
shifts_soft_lb(15, "LD", 2).
shifts_soft_lb(15, "SE", 2).
shifts_soft_lb(15, "SN", 2).
shifts_soft_ub(15, "LD", 4).
shifts_soft_ub(15, "SE", 4).
shifts_soft_ub(15, "SN", 4).
shifts_hard_lb(15, "E", 0).
shifts_hard_lb(15, "N", 0).
shifts_soft_lb(15, "E", 0).
shifts_soft_lb(15, "N", 0).
shifts_soft_ub(15, "E", 0).
shifts_soft_ub(15, "N", 0).
shifts_hard_ub(15, "E", 0).
shifts_hard_ub(15, "N", 0).
shifts_hard_lb(15, "LM", 0).
shifts_soft_lb(15, "LM", 0).
shifts_soft_ub(15, "LM", 0).
shifts_hard_ub(15, "LM", 0).
shifts_hard_ub(15, "EM", 0).
% Staff 16:
shifts_soft_lb(16, "LD", 2).
shifts_soft_lb(16, "SE", 2).
shifts_soft_lb(16, "SN", 2).
shifts_soft_ub(16, "LD", 3).
shifts_soft_ub(16, "SE", 3).
shifts_soft_ub(16, "SN", 3).
shifts_hard_lb(16, "E", 0).
shifts_hard_lb(16, "N", 0).
shifts_soft_lb(16, "E", 0).
shifts_soft_lb(16, "N", 0).
shifts_soft_ub(16, "E", 0).
shifts_soft_ub(16, "N", 0).
shifts_hard_ub(16, "E", 0).
shifts_hard_ub(16, "N", 0).
shifts_hard_lb(16, "LM", 0).
shifts_soft_lb(16, "LM", 0).
shifts_soft_ub(16, "LM", 0).
shifts_hard_ub(16, "LM", 0).
shifts_hard_ub(16, "EM", 0).
% Staff 17:
shifts_soft_lb(17, "LD", 2).
shifts_soft_lb(17, "SE", 2).
shifts_soft_lb(17, "SN", 2).
shifts_soft_ub(17, "LD", 3).
shifts_soft_ub(17, "SE", 3).
shifts_soft_ub(17, "SN", 3).
shifts_hard_lb(17, "E", 0).
shifts_hard_lb(17, "N", 0).
shifts_soft_lb(17, "E", 0).
shifts_soft_lb(17, "N", 0).
shifts_soft_ub(17, "E", 0).
shifts_soft_ub(17, "N", 0).
shifts_hard_ub(17, "E", 0).
shifts_hard_ub(17, "N", 0).
shifts_hard_lb(17, "LM", 0).
shifts_soft_lb(17, "LM", 0).
shifts_soft_ub(17, "LM", 0).
shifts_hard_ub(17, "LM", 0).
shifts_hard_ub(17, "EM", 0).
% Staff 18:
shifts_soft_lb(18, "LD", 2).
shifts_soft_lb(18, "SE", 2).
shifts_soft_lb(18, "SN", 2).
shifts_soft_ub(18, "LD", 3).
shifts_soft_ub(18, "SE", 3).
shifts_soft_ub(18, "SN", 3).
shifts_hard_lb(18, "E", 0).
shifts_hard_lb(18, "N", 0).
shifts_soft_lb(18, "E", 0).
shifts_soft_lb(18, "N", 0).
shifts_soft_ub(18, "E", 0).
shifts_soft_ub(18, "N", 0).
shifts_hard_ub(18, "E", 0).
shifts_hard_ub(18, "N", 0).
shifts_hard_lb(18, "LM", 0).
shifts_soft_lb(18, "LM", 0).
shifts_soft_ub(18, "LM", 0).
shifts_hard_ub(18, "LM", 0).
shifts_hard_ub(18, "EM", 0).
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
