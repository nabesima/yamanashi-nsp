%----------------------------------------------------------------------
% Shifts
%----------------------------------------------------------------------
% work shifts
shift(work,     day              , "D" ).
shift(work,     long_day         , "LD").
shift(work,     early_morning    , "EM").
shift(work,     late_morning     , "LM").
shift(work,     evening          , "E" ).
shift(work,     short_evening    , "SE").
shift(work,     night            , "N" ).
shift(work,     short_night      , "SN").

% Rest days and holidays
shift(rest,     weekly_rest      , "WR").
shift(rest,     public_holiday   , "PH").

% Business activities
shift(business, business_trip    , "BT").
shift(business, training         , "TR").
shift(business, health_check     , "HC").

% Leave types
shift(leave,    annual_Leave     , "AL").
shift(leave,    bereavement_leave, "BL").
shift(leave,    health_leave     , "HL").
shift(leave,    maternity_leave  , "ML").
shift(leave,    nursing_leave    , "NL").
shift(leave,    parental_leave   , "PL").
shift(leave,    sick_leave       , "SL").
shift(leave,    special_leave    , "SP").
shift(leave,    volunteer_leave  , "VL").
shift(leave,    wedding_leave    , "WL").

% Absences and unavailability
shift(na,       absence          , "AB").
shift(na,       leave_of_absence , "LA").
shift(na,       not_available    , "NA").

%----------------------------------------------------------------------
% Short shift names
%----------------------------------------------------------------------
work_shift(SIGN) :- shift(work, NAME, SIGN).
rest_shift(SIGN) :- shift(rest, NAME, SIGN).
business_shift(SIGN) :- shift(business, NAME, SIGN).
leave_shift(SIGN) :- shift(leave, NAME, SIGN).
na_shift(SIGN) :- shift(na, NAME, SIGN).

non_work_shift(SIGN) :- rest_shift(SIGN).
non_work_shift(SIGN) :- leave_shift(SIGN).

shift(SIGN) :- shift(_, _, SIGN).
