function null = plot_intervention(beta, gamma, alpha, omega, I_total_baseline, simulation_name)
    % fcn_plot_intervention plot the intervention
    %
    % Usage
    %   null = fcn_plot_intervention(beta, gamma, alpha, omega, I_total_baseline, simulation_name)
    %
    % Arguments
    %   beta = infection rate parameter
    %   gamma = recovery rate paramter
    %   alpha = vaccination rate parameter
    %   omega = resusceptible rate parameter
    %   I_total_baseline = total number of infections in baseline case
    %   simulation_name = name of the simulation

    global num_steps i_0 s_0 r_0;

    % run sir_vaccine with parameters and obtain data
    [S, I, R, W, V, I_total_tweaked, V_total, verifiedIntervention] = sir_vaccine(s_0, i_0, r_0, beta, gamma, alpha, omega, num_steps);
    
    % Plot graph of number of infections
    plot(W, I);
    title(simulation_name)
    legend({'Baseline', 'Tweaked'}) % Baseline needs to go first!
    text(105,15,"Tweaked: " + round(I_total_tweaked))
    text(105,13.5,"Reduction: " + round(I_total_baseline - I_total_tweaked))
    t = text(105, 9, "Intervention");
    t.Color = 'green';
    if verifiedIntervention == false
        t.Color = 'red';
    end
    text(94, 7.5, "Tot. Vaccinations: " + round(V_total));
end