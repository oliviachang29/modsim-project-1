function [valid] = verify(beta, gamma, alpha, omega)
    global num_steps i_0 s_0 r_0;
    validPop = true;

    % Run simulation
    [S, I, R, W, I_total] = sir_vaccine(s_0, i_0, r_0, beta, gamma, alpha , omega, num_steps);

    % Plot the fitted simulation
    figure(1); clf; hold on;
    T = S + I + R

    plot(W, T, 'k-'); label2 = "Total number of people"; % plot total number of people
    
    xlabel("Week")
    ylabel("Total number of people")
    legend(label2)
    ylim([50 150])
    title("Simulated Model Predictions")

   for i = 1:num_steps
        if T(i) ~= 100
            validPop = false;
        end
   end

end