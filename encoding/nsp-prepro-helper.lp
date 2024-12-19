%----------------------------------------------------------------------
% utilities
%----------------------------------------------------------------------
#script (python)
import clingo
import math

N = clingo.Number

def num_weekly_holidays(width, na, dwr):
    width = width.number
    na    = na.number
    dwr   = dwr.number
    return N(round(float(width - na) / float(width) * dwr))

def weekly_holidays_lb(width, na, dwr):
    width = width.number
    na    = na.number
    dwr   = dwr.number
    return N(math.floor(float(width - na) / float(width) * dwr))

def weekly_holidays_ub(width, na, dwr):
    width = width.number
    na    = na.number
    dwr   = dwr.number
    return N(math.ceil(float(width - na) / float(width) * dwr))

def max(n, m):
    n = n.number
    m = m.number
    return N(n if n > m else m)

#end. 
