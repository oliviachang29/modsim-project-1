function [S, I, R, W, V, I_total, V_total, verifiedSimulation] = sir_vaccine(s_0, i_0, r_0, beta, gamma, alpha, omega, num_steps)
% fcn_simulate Simulate a SIR model
%
% Usage
%   [S, I, R, W, V, I_total, V_total, verifiedSimulation] = fcn_simulate(s_0, i_0, r_0, beta, gamma, alpha, omega, num_steps)
%
% Arguments
%   s_0 = initial number of susceptible individuals
%   i_0 = initial number of infected individuals
%   r_0 = initial number of recovered individuals
%
%   beta = infection rate parameter
%   gamma = recovery rate paramter
%   alpha = vaccination rate parameter
%   omega = resusceptible rate parameter
%
%   num_steps = number of simulation steps to simulate
%
% Returns
%   S = simulation history of susceptible individuals; vector
%   I = simulation history of infected individuals; vector
%   R = simulation history of recovered individuals; vector
%   W = simulation week; vector
%   V = simulation history of vaccinated individuals; vector
%   I_total = total number of infected individuals
%   V_total = total number of vaccinated individuals

% Setup
S = zeros(1, num_steps);
I = zeros(1, num_steps);
R = zeros(1, num_steps);
W = 1 : num_steps;
V = zeros(1, num_steps);
verifiedSimulation = true;

s = s_0;
i = i_0;
r = r_0;

% Store initial values
S(1) = s;
I(1) = i;
R(1) = r;
V(1) = 0;
I_total = 0;
V_total = 0;

% Run simulation
for step = 2 : num_steps
    [s, i, r, verifiedFlow, infected, vaccinated] = sir_step_v2(s, i, r, beta, gamma, alpha, omega);
    S(step) = s;
    I(step) = i;
    R(step) = r;
    V(step) = vaccinated;
    I_total = I_total + infected;
    V_total = V_total + vaccinated;

    % if the flow for one week is not veriffied, then the simulation is not
    % verified
    if verifiedFlow == false
        verifiedSimulation = false;
    end
end

end