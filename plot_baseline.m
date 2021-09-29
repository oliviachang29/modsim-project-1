function I_total_baseline = plot_baseline()
    global num_steps i_0 s_0 r_0;
    % Setup
    axis_tick_interval = 5; 

    % Define flow parameters
    beta = 1 / 90; % Infection rate (New / Susceptible / Infected / day)
    gamma = 1 / 2; % Recovery rate (1 / week)
    alpha = 0; % assume 0% of people are getting vaccinated in a given week
    omega = 1 / 52; % assume 10% of people become susceptible after recovering
    % omega should be 1 / time to lose immunity
    % in training data: approx 52 weeks (can assume this is a year)
    
    [S, I, R, W, V, I_total_baseline, V_total, verifiedBaseline] = sir_vaccine(s_0, i_0, r_0, beta, gamma, alpha, omega, num_steps);
    % Plot graph
    figure(1); clf; hold on;
    xticks(0:axis_tick_interval:num_steps); % add axis ticks
    plot(W, I);

    xlabel("Week")
    ylabel("Infected Persons")
    total_cases_text = text(95,18,"Total Cases:");
    total_cases_text.FontWeight = 'bold';
    text(105,16.5,"Baseline: " + round(I_total_baseline));
    verified_text= text(95, 12, "Verified:");
    verified_text.FontWeight = 'bold';
    t = text(105, 10.5, "Baseline");
    t.Color = 'green';
    if verifiedBaseline == false
        t.Color = 'red';
    end
end