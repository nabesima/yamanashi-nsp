% Staffs ---------------------------------------------------
staff(1, "Emily Fritz", "Chief Nurse", "78802", 2).
staff(2, "Kathleen Smith", "Chief Nurse", "95321", 2).
staff(3, "Alexis Johnston", "Chief Nurse", "30044", 2).
staff(4, "Jo Walker", "Chief Nurse", "19843", 2).
staff(5, "Shelley Davis", "Chief Nurse", "92992", 2).
staff(6, "Daniel Anderson", "Chief Nurse", "93759", 2).
staff(7, "Amber Smith", "Chief Nurse", "77794", 2).
staff(8, "Roy Knapp", "Chief Nurse", "85508", 2).
staff(9, "Brett Short", "Chief Nurse", "57251", 2).
staff(10, "Amanda Nielsen", "Chief Nurse", "69825", 2).
staff(11, "Jon Hunter", "Chief Nurse", "52150", 2).
staff(12, "Michael Ochoa", "Chief Nurse", "87524", 2).
staff(13, "Matthew Conner", "Chief Nurse", "51953", 2).
staff(14, "Brian Lynn", "Chief Nurse", "54547", 2).
staff(15, "Ian Simmons PhD", "Chief Nurse", "05480", 2).
staff(16, "Justin Rodriguez", "Chief Nurse", "12036", 2).
staff(17, "Sharon Davies", "Chief Nurse", "47553", 2).
staff(18, "Robin Thompson", "Chief Nurse", "97268", 2).
staff(19, "Rachel Davis", "Chief Nurse", "47335", 2).
staff(20, "Matthew Hines", "Chief Nurse", "04991", 2).
staff(21, "Johnny Robinson", "Chief Nurse", "90123", 2).
staff(22, "Deborah Rich", "Chief Nurse", "27559", 2).
staff(23, "Tracy Ferguson", "Chief Nurse", "63683", 2).
staff(24, "Helen Bauer", "Chief Nurse", "76547", 2).
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
staff_group("Heads").
staff_group("Seniors").
staff_group("Seniors1").
staff_group("Seniors1", 1).
staff_group("Seniors1", 2).
staff_group("Seniors1", 3).
staff_group("Seniors1", 4).
staff_group("Seniors1", 5).
staff_group("Seniors1", 6).
staff_group("Seniors1", 7).
staff_group("Seniors1", 8).
staff_group("Seniors1", 9).
staff_group("Seniors1", 10).
staff_group("Seniors1", 11).
staff_group("Seniors1", 12).
staff_group("Seniors1", 13).
staff_group("Seniors1", 14).
staff_group("Seniors1", 15).
staff_group("Seniors1", 16).
staff_group("Seniors1", 17).
staff_group("Seniors1", 18).
staff_group("Seniors1", 19).
staff_group("Seniors1", 20).
staff_group("Seniors1", 21).
staff_group("Seniors1", 22).
staff_group("Seniors1", 23).
staff_group("Seniors1", 24).
staff_group("Seniors2").
staff_group("Mid-levels").
staff_group("Newcomers").
staff_group("Newcomers1").
staff_group("Newcomers2").
staff_group("Night").
% Shift constraints ----------------------------------------
% Maximum consecutive working days
consecutive_work_ub(hard, "All", 5).
consecutive_work_ub(hard, "Heads", 5).
consecutive_work_ub(hard, "Seniors", 5).
consecutive_work_ub(hard, "Seniors1", 5).
consecutive_work_ub(hard, "Seniors2", 5).
consecutive_work_ub(hard, "Mid-levels", 5).
consecutive_work_ub(hard, "Newcomers", 5).
consecutive_work_ub(hard, "Newcomers1", 5).
consecutive_work_ub(hard, "Newcomers2", 5).
consecutive_work_ub(hard, "Night", 5).
% Forbidden patterns
forbidden_pattern("LD-LD").
pattern("LD-LD", 2).
pattern("LD-LD", 0, "LD").
pattern("LD-LD", 1, "LD").
forbidden_pattern("LD-D").
pattern("LD-D", 2).
pattern("LD-D", 0, "LD").
pattern("LD-D", 1, "D").
forbidden_pattern("LM-D").
pattern("LM-D", 2).
pattern("LM-D", 0, "LM").
pattern("LM-D", 1, "D").
forbidden_pattern("LM-LD").
pattern("LM-LD", 2).
pattern("LM-LD", 0, "LM").
pattern("LM-LD", 1, "LD").
forbidden_pattern("SE-SN-SE-SN").
pattern("SE-SN-SE-SN", 4).
pattern("SE-SN-SE-SN", 0, "SE").
pattern("SE-SN-SE-SN", 1, "SN").
pattern("SE-SN-SE-SN", 2, "SE").
pattern("SE-SN-SE-SN", 3, "SN").
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
pattern_hard_lb("WR-WR", "Seniors1", 2).
pattern_hard_lb("WR-WR", "Seniors2", 2).
pattern_hard_lb("WR-WR", "Mid-levels", 2).
pattern_hard_lb("WR-WR", "Newcomers", 2).
pattern_hard_lb("WR-WR", "Newcomers1", 2).
pattern_hard_lb("WR-WR", "Newcomers2", 2).
pattern_hard_lb("WR-WR", "Night", 2).
pattern_hard_ub("LD-D", "All", 1).
pattern_hard_ub("LD-D", "Heads", 1).
pattern_hard_ub("LD-D", "Seniors", 1).
pattern_hard_ub("LD-D", "Seniors1", 1).
pattern_hard_ub("LD-D", "Seniors2", 1).
pattern_hard_ub("LD-D", "Mid-levels", 1).
pattern_hard_ub("LD-D", "Newcomers", 1).
pattern_hard_ub("LD-D", "Newcomers1", 1).
pattern_hard_ub("LD-D", "Newcomers2", 1).
pattern_hard_ub("LD-D", "Night", 1).
pattern_hard_ub("LM-D", "All", 0).
pattern_hard_ub("LM-D", "Heads", 0).
pattern_hard_ub("LM-D", "Seniors", 0).
pattern_hard_ub("LM-D", "Seniors1", 0).
pattern_hard_ub("LM-D", "Seniors2", 0).
pattern_hard_ub("LM-D", "Mid-levels", 0).
pattern_hard_ub("LM-D", "Newcomers", 0).
pattern_hard_ub("LM-D", "Newcomers1", 0).
pattern_hard_ub("LM-D", "Newcomers2", 0).
pattern_hard_ub("LM-D", "Night", 0).
pattern_hard_ub("LM-LD", "All", 0).
pattern_hard_ub("LM-LD", "Heads", 0).
pattern_hard_ub("LM-LD", "Seniors", 0).
pattern_hard_ub("LM-LD", "Seniors1", 0).
pattern_hard_ub("LM-LD", "Seniors2", 0).
pattern_hard_ub("LM-LD", "Mid-levels", 0).
pattern_hard_ub("LM-LD", "Newcomers", 0).
pattern_hard_ub("LM-LD", "Newcomers1", 0).
pattern_hard_ub("LM-LD", "Newcomers2", 0).
pattern_hard_ub("LM-LD", "Night", 0).
pattern("LM-LM", 2).
pattern("LM-LM", 0, "LM").
pattern("LM-LM", 1, "LM").
pattern_hard_ub("LM-LM", "All", 0).
pattern_hard_ub("LM-LM", "Heads", 0).
pattern_hard_ub("LM-LM", "Seniors", 0).
pattern_hard_ub("LM-LM", "Seniors1", 0).
pattern_hard_ub("LM-LM", "Seniors2", 0).
pattern_hard_ub("LM-LM", "Mid-levels", 0).
pattern_hard_ub("LM-LM", "Newcomers", 0).
pattern_hard_ub("LM-LM", "Newcomers1", 0).
pattern_hard_ub("LM-LM", "Newcomers2", 0).
pattern_hard_ub("LM-LM", "Night", 0).
% Vertical constraints -------------------------------------
shift_group("D").
shift_group("D", "D").
staff_dweek_soft_lb("All", "D", "Weekday", 1).
staff_dweek_soft_lb("All", "D", "Weekend", 1).
staff_dweek_soft_lb("All", "D", "Holiday", 1).
shift_group("LD").
shift_group("LD", "LD").
staff_dweek_soft_lb("All", "LD", "Weekday", 1).
shift_group("SE").
shift_group("SE", "SE").
staff_dweek_soft_lb("All", "SE", "Weekday", 1).
shift_group("SN").
shift_group("SN", "SN").
staff_dweek_soft_lb("All", "SN", "Weekday", 1).
staff_dweek_soft_lb("All", "LD", "Weekend", 1).
staff_dweek_soft_lb("All", "SE", "Weekend", 1).
staff_dweek_soft_lb("All", "SN", "Weekend", 1).
staff_dweek_soft_lb("All", "LD", "Holiday", 1).
staff_dweek_soft_lb("All", "SE", "Holiday", 1).
staff_dweek_soft_lb("All", "SN", "Holiday", 1).
staff_dweek_soft_ub("All", "LD", "Weekday", 1).
staff_dweek_soft_ub("All", "SE", "Weekday", 1).
staff_dweek_soft_ub("All", "SN", "Weekday", 1).
staff_dweek_soft_ub("All", "LD", "Weekend", 1).
staff_dweek_soft_ub("All", "SE", "Weekend", 1).
staff_dweek_soft_ub("All", "SN", "Weekend", 1).
staff_dweek_soft_ub("All", "LD", "Holiday", 1).
staff_dweek_soft_ub("All", "SE", "Holiday", 1).
staff_dweek_soft_ub("All", "SN", "Holiday", 1).
staff_dweek_soft_lb("Seniors1", "LD", "Weekday", 1).
staff_dweek_soft_lb("Seniors1", "SE", "Weekday", 1).
staff_dweek_soft_lb("Seniors1", "SN", "Weekday", 1).
staff_dweek_soft_lb("Seniors1", "LD", "Weekend", 1).
staff_dweek_soft_lb("Seniors1", "SE", "Weekend", 1).
staff_dweek_soft_lb("Seniors1", "SN", "Weekend", 1).
staff_dweek_soft_lb("Seniors1", "LD", "Holiday", 1).
staff_dweek_soft_lb("Seniors1", "SE", "Holiday", 1).
staff_dweek_soft_lb("Seniors1", "SN", "Holiday", 1).
staff_dweek_soft_ub("Seniors1", "LD", "Weekday", 1).
staff_dweek_soft_ub("Seniors1", "SE", "Weekday", 1).
staff_dweek_soft_ub("Seniors1", "SN", "Weekday", 1).
staff_dweek_soft_ub("Seniors1", "LD", "Weekend", 1).
staff_dweek_soft_ub("Seniors1", "SE", "Weekend", 1).
staff_dweek_soft_ub("Seniors1", "SN", "Weekend", 1).
staff_dweek_soft_ub("Seniors1", "LD", "Holiday", 1).
staff_dweek_soft_ub("Seniors1", "SE", "Holiday", 1).
staff_dweek_soft_ub("Seniors1", "SN", "Holiday", 1).
vertical_constraint_type("All","D","Staffs").
vertical_constraint_type("All","LD","Staffs").
vertical_constraint_type("All","SE","Staffs").
vertical_constraint_type("All","SN","Staffs").
vertical_constraint_type("Seniors1","LD","Staffs").
vertical_constraint_type("Seniors1","SE","Staffs").
vertical_constraint_type("Seniors1","SN","Staffs").
% Horizontal constraints -----------------------------------
% Staff 1:
shifts_soft_lb(1, "LD", 0).
shifts_soft_lb(1, "SE", 0).
shifts_soft_lb(1, "SN", 0).
shifts_soft_ub(1, "LD", 2).
shifts_soft_ub(1, "SE", 2).
shifts_soft_ub(1, "SN", 2).
shift_group("E").
shift_group("E", "E").
shifts_soft_ub(1, "E", 0).
shift_group("N").
shift_group("N", "N").
shifts_soft_ub(1, "N", 0).
shift_group("EM").
shift_group("EM", "EM").
shifts_soft_ub(1, "EM", 0).
shift_group("LM").
shift_group("LM", "LM").
shifts_soft_ub(1, "LM", 0).
shifts_hard_ub(1, "E", 0).
shifts_hard_ub(1, "N", 0).
shifts_hard_ub(1, "EM", 0).
shifts_hard_ub(1, "LM", 0).
% Staff 2:
shifts_soft_lb(2, "LD", 0).
shifts_soft_lb(2, "SE", 0).
shifts_soft_lb(2, "SN", 0).
shifts_soft_ub(2, "LD", 2).
shifts_soft_ub(2, "SE", 2).
shifts_soft_ub(2, "SN", 2).
shifts_soft_ub(2, "E", 0).
shifts_soft_ub(2, "N", 0).
shifts_soft_ub(2, "EM", 0).
shifts_soft_ub(2, "LM", 0).
shifts_hard_ub(2, "E", 0).
shifts_hard_ub(2, "N", 0).
shifts_hard_ub(2, "EM", 0).
shifts_hard_ub(2, "LM", 0).
% Staff 3:
shifts_soft_lb(3, "LD", 0).
shifts_soft_lb(3, "SE", 0).
shifts_soft_lb(3, "SN", 0).
shifts_soft_ub(3, "LD", 2).
shifts_soft_ub(3, "SE", 2).
shifts_soft_ub(3, "SN", 2).
shifts_soft_ub(3, "E", 0).
shifts_soft_ub(3, "N", 0).
shifts_soft_ub(3, "EM", 0).
shifts_soft_ub(3, "LM", 0).
shifts_hard_ub(3, "E", 0).
shifts_hard_ub(3, "N", 0).
shifts_hard_ub(3, "EM", 0).
shifts_hard_ub(3, "LM", 0).
% Staff 4:
shifts_soft_lb(4, "LD", 0).
shifts_soft_lb(4, "SE", 0).
shifts_soft_lb(4, "SN", 0).
shifts_soft_ub(4, "LD", 2).
shifts_soft_ub(4, "SE", 2).
shifts_soft_ub(4, "SN", 2).
shifts_soft_ub(4, "E", 0).
shifts_soft_ub(4, "N", 0).
shifts_soft_ub(4, "EM", 0).
shifts_soft_ub(4, "LM", 0).
shifts_hard_ub(4, "E", 0).
shifts_hard_ub(4, "N", 0).
shifts_hard_ub(4, "EM", 0).
shifts_hard_ub(4, "LM", 0).
% Staff 5:
shifts_soft_lb(5, "LD", 0).
shifts_soft_lb(5, "SE", 0).
shifts_soft_lb(5, "SN", 0).
shifts_soft_ub(5, "LD", 2).
shifts_soft_ub(5, "SE", 2).
shifts_soft_ub(5, "SN", 2).
shifts_soft_ub(5, "E", 0).
shifts_soft_ub(5, "N", 0).
shifts_soft_ub(5, "EM", 0).
shifts_soft_ub(5, "LM", 0).
shifts_hard_ub(5, "E", 0).
shifts_hard_ub(5, "N", 0).
shifts_hard_ub(5, "EM", 0).
shifts_hard_ub(5, "LM", 0).
% Staff 6:
shifts_soft_lb(6, "LD", 0).
shifts_soft_lb(6, "SE", 0).
shifts_soft_lb(6, "SN", 0).
shifts_soft_ub(6, "LD", 2).
shifts_soft_ub(6, "SE", 2).
shifts_soft_ub(6, "SN", 2).
shifts_soft_ub(6, "E", 0).
shifts_soft_ub(6, "N", 0).
shifts_soft_ub(6, "EM", 0).
shifts_soft_ub(6, "LM", 0).
shifts_hard_ub(6, "E", 0).
shifts_hard_ub(6, "N", 0).
shifts_hard_ub(6, "EM", 0).
shifts_hard_ub(6, "LM", 0).
% Staff 7:
shifts_soft_lb(7, "LD", 0).
shifts_soft_lb(7, "SE", 0).
shifts_soft_lb(7, "SN", 0).
shifts_soft_ub(7, "LD", 2).
shifts_soft_ub(7, "SE", 2).
shifts_soft_ub(7, "SN", 2).
shifts_soft_ub(7, "E", 0).
shifts_soft_ub(7, "N", 0).
shifts_soft_ub(7, "EM", 0).
shifts_soft_ub(7, "LM", 0).
shifts_hard_ub(7, "E", 0).
shifts_hard_ub(7, "N", 0).
shifts_hard_ub(7, "EM", 0).
shifts_hard_ub(7, "LM", 0).
% Staff 8:
shifts_soft_lb(8, "LD", 0).
shifts_soft_lb(8, "SE", 0).
shifts_soft_lb(8, "SN", 0).
shifts_soft_ub(8, "LD", 2).
shifts_soft_ub(8, "SE", 2).
shifts_soft_ub(8, "SN", 2).
shifts_soft_ub(8, "E", 0).
shifts_soft_ub(8, "N", 0).
shifts_soft_ub(8, "EM", 0).
shifts_soft_ub(8, "LM", 0).
shifts_hard_ub(8, "E", 0).
shifts_hard_ub(8, "N", 0).
shifts_hard_ub(8, "EM", 0).
shifts_hard_ub(8, "LM", 0).
% Staff 9:
shifts_soft_lb(9, "LD", 0).
shifts_soft_lb(9, "SE", 0).
shifts_soft_lb(9, "SN", 0).
shifts_soft_ub(9, "LD", 2).
shifts_soft_ub(9, "SE", 2).
shifts_soft_ub(9, "SN", 2).
shifts_soft_ub(9, "E", 0).
shifts_soft_ub(9, "N", 0).
shifts_soft_ub(9, "EM", 0).
shifts_soft_ub(9, "LM", 0).
shifts_hard_ub(9, "E", 0).
shifts_hard_ub(9, "N", 0).
shifts_hard_ub(9, "EM", 0).
shifts_hard_ub(9, "LM", 0).
% Staff 10:
shifts_soft_lb(10, "LD", 0).
shifts_soft_lb(10, "SE", 0).
shifts_soft_lb(10, "SN", 0).
shifts_soft_ub(10, "LD", 2).
shifts_soft_ub(10, "SE", 2).
shifts_soft_ub(10, "SN", 2).
shifts_soft_ub(10, "E", 0).
shifts_soft_ub(10, "N", 0).
shifts_soft_ub(10, "EM", 0).
shifts_soft_ub(10, "LM", 0).
shifts_hard_ub(10, "E", 0).
shifts_hard_ub(10, "N", 0).
shifts_hard_ub(10, "EM", 0).
shifts_hard_ub(10, "LM", 0).
% Staff 11:
shifts_soft_lb(11, "LD", 0).
shifts_soft_lb(11, "SE", 0).
shifts_soft_lb(11, "SN", 0).
shifts_soft_ub(11, "LD", 2).
shifts_soft_ub(11, "SE", 2).
shifts_soft_ub(11, "SN", 2).
shifts_soft_ub(11, "E", 0).
shifts_soft_ub(11, "N", 0).
shifts_soft_ub(11, "EM", 0).
shifts_soft_ub(11, "LM", 0).
shifts_hard_ub(11, "E", 0).
shifts_hard_ub(11, "N", 0).
shifts_hard_ub(11, "EM", 0).
shifts_hard_ub(11, "LM", 0).
% Staff 12:
shifts_soft_lb(12, "LD", 0).
shifts_soft_lb(12, "SE", 0).
shifts_soft_lb(12, "SN", 0).
shifts_soft_ub(12, "LD", 2).
shifts_soft_ub(12, "SE", 2).
shifts_soft_ub(12, "SN", 2).
shifts_soft_ub(12, "E", 0).
shifts_soft_ub(12, "N", 0).
shifts_soft_ub(12, "EM", 0).
shifts_soft_ub(12, "LM", 0).
shifts_hard_ub(12, "E", 0).
shifts_hard_ub(12, "N", 0).
shifts_hard_ub(12, "EM", 0).
shifts_hard_ub(12, "LM", 0).
% Staff 13:
shifts_soft_lb(13, "LD", 0).
shifts_soft_lb(13, "SE", 0).
shifts_soft_lb(13, "SN", 0).
shifts_soft_ub(13, "LD", 2).
shifts_soft_ub(13, "SE", 2).
shifts_soft_ub(13, "SN", 2).
shifts_soft_ub(13, "E", 0).
shifts_soft_ub(13, "N", 0).
shifts_soft_ub(13, "EM", 0).
shifts_soft_ub(13, "LM", 0).
shifts_hard_ub(13, "E", 0).
shifts_hard_ub(13, "N", 0).
shifts_hard_ub(13, "EM", 0).
shifts_hard_ub(13, "LM", 0).
% Staff 14:
shifts_soft_lb(14, "LD", 0).
shifts_soft_lb(14, "SE", 0).
shifts_soft_lb(14, "SN", 0).
shifts_soft_ub(14, "LD", 2).
shifts_soft_ub(14, "SE", 2).
shifts_soft_ub(14, "SN", 2).
shifts_soft_ub(14, "E", 0).
shifts_soft_ub(14, "N", 0).
shifts_soft_ub(14, "EM", 0).
shifts_soft_ub(14, "LM", 0).
shifts_hard_ub(14, "E", 0).
shifts_hard_ub(14, "N", 0).
shifts_hard_ub(14, "EM", 0).
shifts_hard_ub(14, "LM", 0).
% Staff 15:
shifts_soft_lb(15, "LD", 0).
shifts_soft_lb(15, "SE", 0).
shifts_soft_lb(15, "SN", 0).
shifts_soft_ub(15, "LD", 2).
shifts_soft_ub(15, "SE", 2).
shifts_soft_ub(15, "SN", 2).
shifts_soft_ub(15, "E", 0).
shifts_soft_ub(15, "N", 0).
shifts_soft_ub(15, "EM", 0).
shifts_soft_ub(15, "LM", 0).
shifts_hard_ub(15, "E", 0).
shifts_hard_ub(15, "N", 0).
shifts_hard_ub(15, "EM", 0).
shifts_hard_ub(15, "LM", 0).
% Staff 16:
shifts_soft_lb(16, "LD", 0).
shifts_soft_lb(16, "SE", 0).
shifts_soft_lb(16, "SN", 0).
shifts_soft_ub(16, "LD", 2).
shifts_soft_ub(16, "SE", 2).
shifts_soft_ub(16, "SN", 2).
shifts_soft_ub(16, "E", 0).
shifts_soft_ub(16, "N", 0).
shifts_soft_ub(16, "EM", 0).
shifts_soft_ub(16, "LM", 0).
shifts_hard_ub(16, "E", 0).
shifts_hard_ub(16, "N", 0).
shifts_hard_ub(16, "EM", 0).
shifts_hard_ub(16, "LM", 0).
% Staff 17:
shifts_soft_lb(17, "LD", 0).
shifts_soft_lb(17, "SE", 0).
shifts_soft_lb(17, "SN", 0).
shifts_soft_ub(17, "LD", 2).
shifts_soft_ub(17, "SE", 2).
shifts_soft_ub(17, "SN", 2).
shifts_soft_ub(17, "E", 0).
shifts_soft_ub(17, "N", 0).
shifts_soft_ub(17, "EM", 0).
shifts_soft_ub(17, "LM", 0).
shifts_hard_ub(17, "E", 0).
shifts_hard_ub(17, "N", 0).
shifts_hard_ub(17, "EM", 0).
shifts_hard_ub(17, "LM", 0).
% Staff 18:
shifts_soft_lb(18, "LD", 0).
shifts_soft_lb(18, "SE", 0).
shifts_soft_lb(18, "SN", 0).
shifts_soft_ub(18, "LD", 2).
shifts_soft_ub(18, "SE", 2).
shifts_soft_ub(18, "SN", 2).
shifts_soft_ub(18, "E", 0).
shifts_soft_ub(18, "N", 0).
shifts_soft_ub(18, "EM", 0).
shifts_soft_ub(18, "LM", 0).
shifts_hard_ub(18, "E", 0).
shifts_hard_ub(18, "N", 0).
shifts_hard_ub(18, "EM", 0).
shifts_hard_ub(18, "LM", 0).
% Staff 19:
shifts_soft_lb(19, "LD", 0).
shifts_soft_lb(19, "SE", 0).
shifts_soft_lb(19, "SN", 0).
shifts_soft_ub(19, "LD", 2).
shifts_soft_ub(19, "SE", 2).
shifts_soft_ub(19, "SN", 2).
shifts_soft_ub(19, "E", 0).
shifts_soft_ub(19, "N", 0).
shifts_soft_ub(19, "EM", 0).
shifts_soft_ub(19, "LM", 0).
shifts_hard_ub(19, "E", 0).
shifts_hard_ub(19, "N", 0).
shifts_hard_ub(19, "EM", 0).
shifts_hard_ub(19, "LM", 0).
% Staff 20:
shifts_soft_lb(20, "LD", 0).
shifts_soft_lb(20, "SE", 0).
shifts_soft_lb(20, "SN", 0).
shifts_soft_ub(20, "LD", 2).
shifts_soft_ub(20, "SE", 2).
shifts_soft_ub(20, "SN", 2).
shifts_soft_ub(20, "E", 0).
shifts_soft_ub(20, "N", 0).
shifts_soft_ub(20, "EM", 0).
shifts_soft_ub(20, "LM", 0).
shifts_hard_ub(20, "E", 0).
shifts_hard_ub(20, "N", 0).
shifts_hard_ub(20, "EM", 0).
shifts_hard_ub(20, "LM", 0).
% Staff 21:
shifts_soft_lb(21, "LD", 0).
shifts_soft_lb(21, "SE", 0).
shifts_soft_lb(21, "SN", 0).
shifts_soft_ub(21, "LD", 2).
shifts_soft_ub(21, "SE", 2).
shifts_soft_ub(21, "SN", 2).
shifts_soft_ub(21, "E", 0).
shifts_soft_ub(21, "N", 0).
shifts_soft_ub(21, "EM", 0).
shifts_soft_ub(21, "LM", 0).
shifts_hard_ub(21, "E", 0).
shifts_hard_ub(21, "N", 0).
shifts_hard_ub(21, "EM", 0).
shifts_hard_ub(21, "LM", 0).
% Staff 22:
shifts_soft_lb(22, "LD", 0).
shifts_soft_lb(22, "SE", 0).
shifts_soft_lb(22, "SN", 0).
shifts_soft_ub(22, "LD", 2).
shifts_soft_ub(22, "SE", 2).
shifts_soft_ub(22, "SN", 2).
shifts_soft_ub(22, "E", 0).
shifts_soft_ub(22, "N", 0).
shifts_soft_ub(22, "EM", 0).
shifts_soft_ub(22, "LM", 0).
shifts_hard_ub(22, "E", 0).
shifts_hard_ub(22, "N", 0).
shifts_hard_ub(22, "EM", 0).
shifts_hard_ub(22, "LM", 0).
% Staff 23:
shifts_soft_lb(23, "LD", 0).
shifts_soft_lb(23, "SE", 0).
shifts_soft_lb(23, "SN", 0).
shifts_soft_ub(23, "LD", 2).
shifts_soft_ub(23, "SE", 2).
shifts_soft_ub(23, "SN", 2).
shifts_soft_ub(23, "E", 0).
shifts_soft_ub(23, "N", 0).
shifts_soft_ub(23, "EM", 0).
shifts_soft_ub(23, "LM", 0).
shifts_hard_ub(23, "E", 0).
shifts_hard_ub(23, "N", 0).
shifts_hard_ub(23, "EM", 0).
shifts_hard_ub(23, "LM", 0).
% Staff 24:
shifts_soft_lb(24, "LD", 3).
shifts_soft_lb(24, "SE", 3).
shifts_soft_lb(24, "SN", 3).
shifts_soft_ub(24, "LD", 4).
shifts_soft_ub(24, "SE", 4).
shifts_soft_ub(24, "SN", 4).
shifts_soft_ub(24, "E", 0).
shifts_soft_ub(24, "N", 0).
shifts_soft_ub(24, "EM", 0).
shifts_soft_ub(24, "LM", 0).
shifts_hard_ub(24, "E", 0).
shifts_hard_ub(24, "N", 0).
shifts_hard_ub(24, "EM", 0).
shifts_hard_ub(24, "LM", 0).
horizontal_constraint_type("D").
horizontal_constraint_type("LD").
horizontal_constraint_type("SE").
horizontal_constraint_type("SN").
horizontal_constraint_type("E").
horizontal_constraint_type("N").
horizontal_constraint_type("EM").
horizontal_constraint_type("LM").
% Positive shifts ------------------------------------------
% Negative shifts ------------------------------------------
