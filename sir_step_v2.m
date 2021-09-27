function [s_n, i_n, r_n, verifiedFlow, infected] = sir_step_v2(s, i, r, beta, gamma, alpha, omega)
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
    verifiedSFlow = true;
    verifiedGammaFlow = true;
    verifiedOmegaFlow = true;
    
    % compute new infections and recoveries
    infected = beta * i * s;
    recovered = gamma * i;
    vaccinated = alpha * s;
    reinfected = omega * r;
    
    % Enforce invariants
    
    total = s + i + r;
    infected = min(s, infected);           % Cannot infect more people than current s
    infected = min(total - i, infected);   % Cannot infect more than total
    recovered = min(i, recovered);         % Cannot recover more people than current i
    recovered = min(total - r, recovered); % Cannot recover more than total
    %}
    vaccinated = min(s, vaccinated); % cannot vaccinate more than susceptible
    reinfected = min(r, reinfected); % cannot reinfect more than recovered
    
    % Update state
    
    s_n = s - infected - vaccinated + reinfected;
    i_n = i + infected - recovered;
    r_n = r + recovered + vaccinated - reinfected;
    
    % verfication
    if (vaccinated + infected) > s
        verifiedSFlow = false
    end
    
    if recovered > i 
        verifiedGammaFlow = false
    end
    
    if reinfected > r
        verifiedOmegaFlow = false
    end
    
    verifiedFlow = verifiedSFlow && verifiedGammaFlow && verifiedOmegaFlow;
end