% Staffs ---------------------------------------------------
staff(1, "Brandon Mcintosh", "Deputy Chief Nurse", "07012", 0).
staff(2, "John Smith", "Deputy Chief Nurse", "74102", 0).
staff(3, "John Price", "Deputy Chief Nurse", "76205", 0).
staff(4, "Joseph Flores", "Nurse", "45275", 0).
staff(5, "Wendy Bryant", "Chief Nurse", "06502", 0).
staff(6, "Logan Torres", "Deputy Chief Nurse", "33615", 0).
staff(7, "Travis Bates", "Nurse", "34181", 0).
staff(8, "Katherine Young", "Chief Nurse", "09549", 0).
staff(9, "Ian Moore", "Deputy Chief Nurse", "74243", 0).
staff(10, "Jeffrey Adams", "Nurse", "01022", 0).
staff(11, "Lisa Haney DVM", "Chief Nurse", "06690", 0).
staff(12, "Tara Randall", "Deputy Chief Nurse", "01409", 0).
staff(13, "Shaun Frye", "Nurse", "79663", 0).
staff(14, "Nicolas Ross", "Chief Nurse", "21165", 0).
staff(15, "Andrew Bowman", "Deputy Chief Nurse", "97576", 0).
staff(16, "Johnny Gonzalez", "Nurse", "72055", 0).
staff(17, "Barry Barton", "Chief Nurse", "09047", 0).
staff(18, "Isaac Yoder", "Deputy Chief Nurse", "25490", 0).
staff(19, "Joseph Aguilar DDS", "Nurse", "59706", 0).
staff(20, "Tracey Morgan", "Chief Nurse", "42687", 0).
staff(21, "Chad Gutierrez", "Deputy Chief Nurse", "31053", 0).
staff(22, "Gregory Gibson", "Nurse", "03367", 0).
staff(23, "Kyle Flores", "Chief Nurse", "35864", 0).
staff(24, "Karen Harvey", "Deputy Chief Nurse", "07414", 0).
staff(25, "Alyssa Walters", "Nurse", "23759", 0).
staff(26, "Jeff Brown", "Chief Nurse", "91934", 0).
staff(27, "Diane Heath", "Deputy Chief Nurse", "94466", 0).
staff(28, "Lauren Jones", "Nurse", "29959", 0).
staff(29, "Shannon Olson", "Chief Nurse", "93046", 0).
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
staff_group("All", 22).
staff_group("All", 23).
staff_group("All", 24).
staff_group("All", 25).
staff_group("All", 26).
staff_group("All", 27).
staff_group("All", 28).
staff_group("All", 29).
staff_group("Heads").
staff_group("Seniors").
staff_group("Seniors", 1).
staff_group("Seniors", 2).
staff_group("Seniors", 3).
staff_group("Seniors", 4).
staff_group("Seniors", 5).
staff_group("Seniors", 6).
staff_group("Mid-levels").
staff_group("Mid-levels", 7).
staff_group("Mid-levels", 8).
staff_group("Mid-levels", 9).
staff_group("Mid-levels", 10).
staff_group("Mid-levels", 11).
staff_group("Mid-levels", 12).
staff_group("Mid-levels", 13).
staff_group("Mid-levels", 14).
staff_group("Mid-levels", 15).
staff_group("Mid-levels", 16).
staff_group("Mid-levels", 17).
staff_group("Mid-levels", 18).
staff_group("Mid-levels", 19).
staff_group("Mid-levels", 20).
staff_group("Mid-levels", 21).
staff_group("Mid-levels", 22).
staff_group("Mid-levels", 23).
staff_group("Mid-levels", 24).
staff_group("Mid-levels", 25).
staff_group("Mid-levels", 26).
staff_group("Newcomers").
staff_group("Newcomers", 27).
staff_group("Newcomers", 28).
staff_group("Newcomers", 29).
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
staff_group("Night", 22).
staff_group("Night", 23).
staff_group("Night", 24).
staff_group("Night", 25).
staff_group("Night", 26).
staff_group("Night", 27).
staff_group("Night", 28).
staff_group("Night", 29).
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
staff_dweek_hard_lb("All", "LD", "Weekday", 3).
shift_group("SE").
shift_group("SE", "SE").
staff_dweek_hard_lb("All", "SE", "Weekday", 3).
shift_group("SN").
shift_group("SN", "SN").
staff_dweek_hard_lb("All", "SN", "Weekday", 3).
staff_dweek_hard_lb("All", "LD", "Weekend", 3).
staff_dweek_hard_lb("All", "SE", "Weekend", 3).
staff_dweek_hard_lb("All", "SN", "Weekend", 3).
staff_dweek_hard_lb("All", "LD", "Holiday", 3).
staff_dweek_hard_lb("All", "SE", "Holiday", 3).
staff_dweek_hard_lb("All", "SN", "Holiday", 3).
staff_dweek_soft_lb("All", "LD", "Weekday", 4).
staff_dweek_soft_lb("All", "SE", "Weekday", 4).
staff_dweek_soft_lb("All", "SN", "Weekday", 4).
staff_dweek_soft_lb("All", "LD", "Weekend", 4).
staff_dweek_soft_lb("All", "SE", "Weekend", 4).
staff_dweek_soft_lb("All", "SN", "Weekend", 4).
staff_dweek_soft_lb("All", "LD", "Holiday", 4).
staff_dweek_soft_lb("All", "SE", "Holiday", 4).
staff_dweek_soft_lb("All", "SN", "Holiday", 4).
staff_dweek_soft_ub("All", "LD", "Weekday", 5).
staff_dweek_soft_ub("All", "SE", "Weekday", 5).
staff_dweek_soft_ub("All", "SN", "Weekday", 5).
staff_dweek_soft_ub("All", "LD", "Weekend", 5).
staff_dweek_soft_ub("All", "SE", "Weekend", 5).
staff_dweek_soft_ub("All", "SN", "Weekend", 5).
staff_dweek_soft_ub("All", "LD", "Holiday", 5).
staff_dweek_soft_ub("All", "SE", "Holiday", 5).
staff_dweek_soft_ub("All", "SN", "Holiday", 5).
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
staff_dweek_soft_lb("Seniors", "LD", "Weekday", 1).
staff_dweek_soft_lb("Seniors", "SE", "Weekday", 1).
staff_dweek_soft_lb("Seniors", "SN", "Weekday", 1).
staff_dweek_soft_lb("Seniors", "LD", "Weekend", 1).
staff_dweek_soft_lb("Seniors", "SE", "Weekend", 1).
staff_dweek_soft_lb("Seniors", "SN", "Weekend", 1).
staff_dweek_soft_lb("Seniors", "LD", "Holiday", 1).
staff_dweek_soft_lb("Seniors", "SE", "Holiday", 1).
staff_dweek_soft_lb("Seniors", "SN", "Holiday", 1).
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
shifts_soft_ub(1, "LD", 4).
shifts_soft_ub(1, "SE", 4).
shifts_soft_ub(1, "SN", 4).
shifts_hard_ub(1, "E", 0).
shifts_hard_ub(1, "N", 0).
shifts_soft_lb(1, "LM", 0).
shift_group("EM").
shift_group("EM", "EM").
shifts_hard_ub(1, "EM", 0).
% Staff 2:
shifts_soft_lb(2, "LD", 3).
shifts_soft_lb(2, "SE", 3).
shifts_soft_lb(2, "SN", 3).
shifts_soft_ub(2, "LD", 3).
shifts_soft_ub(2, "SE", 3).
shifts_soft_ub(2, "SN", 3).
shifts_hard_ub(2, "E", 0).
shifts_hard_ub(2, "N", 0).
shifts_soft_lb(2, "LM", 0).
shifts_hard_ub(2, "EM", 0).
% Staff 3:
shifts_soft_lb(3, "LD", 3).
shifts_soft_lb(3, "SE", 3).
shifts_soft_lb(3, "SN", 3).
shifts_soft_ub(3, "LD", 3).
shifts_soft_ub(3, "SE", 3).
shifts_soft_ub(3, "SN", 3).
shifts_hard_ub(3, "E", 0).
shifts_hard_ub(3, "N", 0).
shifts_soft_lb(3, "LM", 0).
shifts_hard_ub(3, "EM", 0).
% Staff 4:
shifts_soft_lb(4, "LD", 4).
shifts_soft_lb(4, "SE", 4).
shifts_soft_lb(4, "SN", 4).
shifts_soft_ub(4, "LD", 4).
shifts_soft_ub(4, "SE", 4).
shifts_soft_ub(4, "SN", 4).
shifts_hard_ub(4, "E", 0).
shifts_hard_ub(4, "N", 0).
shifts_soft_lb(4, "LM", 0).
shifts_hard_ub(4, "EM", 0).
% Staff 5:
shifts_soft_lb(5, "LD", 5).
shifts_soft_lb(5, "SE", 5).
shifts_soft_lb(5, "SN", 5).
shifts_soft_ub(5, "LD", 5).
shifts_soft_ub(5, "SE", 5).
shifts_soft_ub(5, "SN", 5).
shifts_hard_ub(5, "E", 0).
shifts_hard_ub(5, "N", 0).
shifts_soft_lb(5, "LM", 0).
shifts_hard_ub(5, "EM", 0).
% Staff 6:
shifts_soft_lb(6, "LD", 6).
shifts_soft_lb(6, "SE", 6).
shifts_soft_lb(6, "SN", 6).
shifts_soft_ub(6, "LD", 6).
shifts_soft_ub(6, "SE", 6).
shifts_soft_ub(6, "SN", 6).
shifts_hard_ub(6, "E", 0).
shifts_hard_ub(6, "N", 0).
shifts_soft_lb(6, "LM", 0).
shifts_hard_ub(6, "EM", 0).
% Staff 7:
shifts_soft_lb(7, "LD", 3).
shifts_soft_lb(7, "SE", 3).
shifts_soft_lb(7, "SN", 3).
shifts_soft_ub(7, "LD", 3).
shifts_soft_ub(7, "SE", 3).
shifts_soft_ub(7, "SN", 3).
shifts_hard_ub(7, "E", 0).
shifts_hard_ub(7, "N", 0).
shifts_soft_lb(7, "LM", 0).
shifts_hard_ub(7, "EM", 0).
% Staff 8:
shifts_soft_lb(8, "LD", 7).
shifts_soft_lb(8, "SE", 7).
shifts_soft_lb(8, "SN", 7).
shifts_soft_ub(8, "LD", 7).
shifts_soft_ub(8, "SE", 7).
shifts_soft_ub(8, "SN", 7).
shifts_hard_ub(8, "E", 0).
shifts_hard_ub(8, "N", 0).
shifts_soft_lb(8, "LM", 0).
shifts_hard_ub(8, "EM", 0).
% Staff 9:
shifts_soft_lb(9, "LD", 5).
shifts_soft_lb(9, "SE", 5).
shifts_soft_lb(9, "SN", 5).
shifts_soft_ub(9, "LD", 5).
shifts_soft_ub(9, "SE", 5).
shifts_soft_ub(9, "SN", 5).
shifts_hard_ub(9, "E", 0).
shifts_hard_ub(9, "N", 0).
shifts_soft_lb(9, "LM", 0).
shifts_hard_ub(9, "EM", 0).
% Staff 10:
shifts_soft_lb(10, "LD", 6).
shifts_soft_lb(10, "SE", 6).
shifts_soft_lb(10, "SN", 6).
shifts_soft_ub(10, "LD", 6).
shifts_soft_ub(10, "SE", 6).
shifts_soft_ub(10, "SN", 6).
shifts_hard_ub(10, "E", 0).
shifts_hard_ub(10, "N", 0).
shifts_soft_lb(10, "LM", 0).
shifts_hard_ub(10, "EM", 0).
% Staff 11:
shifts_soft_lb(11, "LD", 5).
shifts_soft_lb(11, "SE", 5).
shifts_soft_lb(11, "SN", 5).
shifts_soft_ub(11, "LD", 5).
shifts_soft_ub(11, "SE", 5).
shifts_soft_ub(11, "SN", 5).
shifts_hard_ub(11, "E", 0).
shifts_hard_ub(11, "N", 0).
shifts_soft_lb(11, "LM", 0).
shifts_hard_ub(11, "EM", 0).
% Staff 12:
shifts_soft_lb(12, "LD", 4).
shifts_soft_lb(12, "SE", 4).
shifts_soft_lb(12, "SN", 4).
shifts_soft_ub(12, "LD", 4).
shifts_soft_ub(12, "SE", 4).
shifts_soft_ub(12, "SN", 4).
shifts_hard_ub(12, "E", 0).
shifts_hard_ub(12, "N", 0).
shifts_soft_lb(12, "LM", 0).
shifts_hard_ub(12, "EM", 0).
% Staff 13:
shifts_soft_lb(13, "LD", 5).
shifts_soft_lb(13, "SE", 5).
shifts_soft_lb(13, "SN", 5).
shifts_soft_ub(13, "LD", 5).
shifts_soft_ub(13, "SE", 5).
shifts_soft_ub(13, "SN", 5).
shifts_hard_ub(13, "E", 0).
shifts_hard_ub(13, "N", 0).
shifts_soft_lb(13, "LM", 0).
shifts_hard_ub(13, "EM", 0).
% Staff 14:
shifts_soft_lb(14, "LD", 6).
shifts_soft_lb(14, "SE", 6).
shifts_soft_lb(14, "SN", 6).
shifts_soft_ub(14, "LD", 6).
shifts_soft_ub(14, "SE", 6).
shifts_soft_ub(14, "SN", 6).
shifts_hard_ub(14, "E", 0).
shifts_hard_ub(14, "N", 0).
shifts_soft_lb(14, "LM", 0).
shifts_hard_ub(14, "EM", 0).
% Staff 15:
shifts_soft_lb(15, "LD", 3).
shifts_soft_lb(15, "SE", 3).
shifts_soft_lb(15, "SN", 3).
shifts_soft_ub(15, "LD", 3).
shifts_soft_ub(15, "SE", 3).
shifts_soft_ub(15, "SN", 3).
shifts_hard_ub(15, "E", 0).
shifts_hard_ub(15, "N", 0).
shifts_soft_lb(15, "LM", 0).
shifts_hard_ub(15, "EM", 0).
% Staff 16:
shifts_soft_lb(16, "LD", 6).
shifts_soft_lb(16, "SE", 6).
shifts_soft_lb(16, "SN", 6).
shifts_soft_ub(16, "LD", 6).
shifts_soft_ub(16, "SE", 6).
shifts_soft_ub(16, "SN", 6).
shifts_hard_ub(16, "E", 0).
shifts_hard_ub(16, "N", 0).
shifts_soft_lb(16, "LM", 0).
shifts_hard_ub(16, "EM", 0).
% Staff 17:
shifts_soft_lb(17, "LD", 4).
shifts_soft_lb(17, "SE", 4).
shifts_soft_lb(17, "SN", 4).
shifts_soft_ub(17, "LD", 4).
shifts_soft_ub(17, "SE", 4).
shifts_soft_ub(17, "SN", 4).
shifts_hard_ub(17, "E", 0).
shifts_hard_ub(17, "N", 0).
shifts_soft_lb(17, "LM", 0).
shifts_hard_ub(17, "EM", 0).
% Staff 18:
shifts_soft_lb(18, "LD", 1).
shifts_soft_lb(18, "SE", 1).
shifts_soft_lb(18, "SN", 1).
shifts_soft_ub(18, "LD", 1).
shifts_soft_ub(18, "SE", 1).
shifts_soft_ub(18, "SN", 1).
shifts_hard_ub(18, "E", 3).
shifts_hard_ub(18, "N", 3).
shifts_soft_lb(18, "LM", 0).
shifts_hard_ub(18, "EM", 0).
% Staff 19:
shifts_soft_lb(19, "LD", 5).
shifts_soft_lb(19, "SE", 5).
shifts_soft_lb(19, "SN", 5).
shifts_soft_ub(19, "LD", 5).
shifts_soft_ub(19, "SE", 5).
shifts_soft_ub(19, "SN", 5).
shifts_hard_ub(19, "E", 0).
shifts_hard_ub(19, "N", 0).
shifts_soft_lb(19, "LM", 0).
shifts_hard_ub(19, "EM", 0).
% Staff 20:
shifts_soft_lb(20, "LD", 6).
shifts_soft_lb(20, "SE", 6).
shifts_soft_lb(20, "SN", 6).
shifts_soft_ub(20, "LD", 6).
shifts_soft_ub(20, "SE", 6).
shifts_soft_ub(20, "SN", 6).
shifts_hard_ub(20, "E", 0).
shifts_hard_ub(20, "N", 0).
shifts_soft_lb(20, "LM", 0).
shifts_hard_ub(20, "EM", 0).
% Staff 21:
shifts_soft_lb(21, "LD", 7).
shifts_soft_lb(21, "SE", 7).
shifts_soft_lb(21, "SN", 7).
shifts_soft_ub(21, "LD", 7).
shifts_soft_ub(21, "SE", 7).
shifts_soft_ub(21, "SN", 7).
shifts_hard_ub(21, "E", 0).
shifts_hard_ub(21, "N", 0).
shifts_soft_lb(21, "LM", 0).
shifts_hard_ub(21, "EM", 0).
% Staff 22:
shifts_soft_lb(22, "LD", 4).
shifts_soft_lb(22, "SE", 4).
shifts_soft_lb(22, "SN", 4).
shifts_soft_ub(22, "LD", 4).
shifts_soft_ub(22, "SE", 4).
shifts_soft_ub(22, "SN", 4).
shifts_hard_ub(22, "E", 0).
shifts_hard_ub(22, "N", 0).
shifts_soft_lb(22, "LM", 0).
shifts_hard_ub(22, "EM", 0).
% Staff 23:
shifts_soft_lb(23, "LD", 4).
shifts_soft_lb(23, "SE", 4).
shifts_soft_lb(23, "SN", 4).
shifts_soft_ub(23, "LD", 4).
shifts_soft_ub(23, "SE", 4).
shifts_soft_ub(23, "SN", 4).
shifts_hard_ub(23, "E", 0).
shifts_hard_ub(23, "N", 0).
shifts_soft_lb(23, "LM", 0).
shifts_hard_ub(23, "EM", 0).
% Staff 24:
shifts_soft_lb(24, "LD", 5).
shifts_soft_lb(24, "SE", 5).
shifts_soft_lb(24, "SN", 5).
shifts_soft_ub(24, "LD", 5).
shifts_soft_ub(24, "SE", 5).
shifts_soft_ub(24, "SN", 5).
shifts_hard_ub(24, "E", 0).
shifts_hard_ub(24, "N", 0).
shifts_soft_lb(24, "LM", 0).
shifts_hard_ub(24, "EM", 0).
% Staff 25:
shifts_soft_lb(25, "LD", 5).
shifts_soft_lb(25, "SE", 5).
shifts_soft_lb(25, "SN", 5).
shifts_soft_ub(25, "LD", 5).
shifts_soft_ub(25, "SE", 5).
shifts_soft_ub(25, "SN", 5).
shifts_hard_ub(25, "E", 0).
shifts_hard_ub(25, "N", 0).
shifts_soft_lb(25, "LM", 0).
shifts_hard_ub(25, "EM", 0).
% Staff 26:
shifts_soft_lb(26, "LD", 6).
shifts_soft_lb(26, "SE", 6).
shifts_soft_lb(26, "SN", 6).
shifts_soft_ub(26, "LD", 6).
shifts_soft_ub(26, "SE", 6).
shifts_soft_ub(26, "SN", 6).
shifts_hard_ub(26, "E", 0).
shifts_hard_ub(26, "N", 0).
shifts_soft_lb(26, "LM", 0).
shifts_hard_ub(26, "EM", 0).
% Staff 27:
shifts_soft_lb(27, "LD", 1).
shifts_soft_lb(27, "SE", 1).
shifts_soft_lb(27, "SN", 1).
shifts_soft_ub(27, "LD", 1).
shifts_soft_ub(27, "SE", 1).
shifts_soft_ub(27, "SN", 1).
shifts_hard_ub(27, "E", 0).
shifts_hard_ub(27, "N", 0).
shifts_soft_lb(27, "LM", 0).
shifts_hard_ub(27, "EM", 0).
% Staff 28:
shifts_soft_lb(28, "LD", 1).
shifts_soft_lb(28, "SE", 1).
shifts_soft_lb(28, "SN", 1).
shifts_soft_ub(28, "LD", 1).
shifts_soft_ub(28, "SE", 1).
shifts_soft_ub(28, "SN", 1).
shifts_hard_ub(28, "E", 0).
shifts_hard_ub(28, "N", 0).
shifts_soft_lb(28, "LM", 0).
shifts_hard_ub(28, "EM", 0).
% Staff 29:
shifts_soft_lb(29, "LD", 1).
shifts_soft_lb(29, "SE", 1).
shifts_soft_lb(29, "SN", 1).
shifts_soft_ub(29, "LD", 1).
shifts_soft_ub(29, "SE", 1).
shifts_soft_ub(29, "SN", 1).
shifts_hard_ub(29, "E", 0).
shifts_hard_ub(29, "N", 0).
shifts_soft_lb(29, "LM", 0).
shifts_hard_ub(29, "EM", 0).
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
