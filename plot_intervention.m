function null = plot_intervention(beta, gamma, alpha, omega, I_total_baseline, simulation_name)
    global num_steps i_0 s_0 r_0;
    [S, I, R, W, I_total_tweaked, verifiedIntervention] = sir_vaccine(s_0, i_0, r_0, beta, gamma, alpha, omega, num_steps);

    % Plot graph
    plot(W, I);
    title(simulation_name)
    legend({'Baseline', 'Tweaked'}) % Baseline needs to go first!
    text(105,15,"Tweaked: " + round(I_total_tweaked))
    text(105,13.5,"Reduction: " + round(I_total_baseline - I_total_tweaked))
    t = text(105, 9.5, "Verified Intervention: " + verifiedIntervention);
    t.Color = 'green';
    if verifiedIntervention == false
        t.Color = 'red';
    end

end