function [s_n, i_n, r_n] = sir_step_v2(s, i, r, beta, gamma, alpha)
% fcn_step Advance an SIR model one timestep
%
% Usage
%   [s_n, i_n, r_n] = fcn_step(s, i, r, beta, gamma)
% 
% Arguments
%   s = current number of susceptible individuals
%   i = current number of infected individuals
%   r = current number of recovered individuals
%   
%   beta = infection rate parameter
%   gamma = recovery rate paramter
% 
% Returns
%   s_n = next number of susceptible individuals
%   i_n = next number of infected individuals
%   r_n = next number of recovered individuals

% compute new infections and recoveries
infected = beta * i * s;
recovered = gamma * i;
vaccinated = alpha * s;

% Enforce invariants

total = s + i + r;
infected = min(s, infected);           % Cannot infect more people than current s
infected = min(total - i, infected);   % Cannot infect more than total
recovered = min(i, recovered);         % Cannot recover more people than current i
recovered = min(total - r, recovered); % Cannot recover more than total
%}

% Update state
s_n = s - infected - vaccinated;
i_n = i + infected - recovered;
r_n = r + recovered + vaccinated;

    
end