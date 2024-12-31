#include "./encoding/nsp-prepro.lp".
#include "./encoding/nsp-prepro-helper.lp". % includes python code
#include "./encoding/nsp-encoding.lp".
#include "./encoding/nsp-restart.lp".

% By default, hard constraints are enabled.
% If you specify -c soften_hard_on=1 in Clingo's command line arguments,
% the hard constraints will be relaxed into soft constraints.
#const soften_hard_on = 0.
soften_hard :- soften_hard_on == 1.
