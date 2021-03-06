function [s_n, i_n, r_n, verifiedFlow, infected, vaccinated] = sir_step_v2(s, i, r, beta, gamma, alpha, omega)
    % fcn_step Advance an SIR model one timestep
    %
    % Usage
    %   [s_n, i_n, r_n, verifiedFlow, infected, vaccinated] = fcn_step(s, i, r, beta, gamma, alpha, omega)
    % 
    % Arguments
    %   s = current number of susceptible individuals
    %   i = current number of infected individuals
    %   r = current number of recovered individuals
    %   
    %   beta = infection rate parameter
    %   gamma = recovery rate paramter
    %   alpha = vaccination rate parameter
    %   omega = resusceptible rate parameter
    % 
    % Returns
    %   s_n = next number of susceptible individuals
    %   i_n = next number of infected individuals
    %   r_n = next number of recovered individuals
    %   verifiedFlow = whether the flows are verified
    %   inefected = the number of people infected
    %   vaccinated = the number of people vaccinated

    % the various flows start out as verified
    verifiedSFlow = true;   % the flow from susceptible to infected and susceptible to recovered
    verifiedGammaFlow = true;   % the flow from infected to recovered
    verifiedOmegaFlow = true;   % the flow from recovered to susceptible
    
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

    % the number of infected and vaccinated people cannot exceed the number
    % of susceptible people
    if (vaccinated + infected) > s
        verifiedSFlow = false
    end
    
    % the number of recovered people cannot exceed the number of infected
    if recovered > i 
        verifiedGammaFlow = false
    end
    
    % the number of reinfected people cannot exceed the number of recovered
    if reinfected > r
        verifiedOmegaFlow = false
    end
    
    % verified flow if all flows are verified as true
    verifiedFlow = verifiedSFlow && verifiedGammaFlow && verifiedOmegaFlow;
end