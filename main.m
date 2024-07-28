% Simulation parameters
sigma = 1;               % Lennard-Jones length scale
epsilon = 1;             % Lennard-Jones energy scale
N = 257;                 % Number of particles
N_equil = 5000;          % Number of equilibration cycles
N_prod = 3000;           % Number of production cycles
T_star = 0.85;           % Reduced temperature
rho = 0.8;               % Density
alpha = 0.5;             % Exponent parameter
acc_move = 0;            % Accepted moves counter
total_move = 0;          % Total moves counter
f = 10;                  % Number of lambda values
sum = 0;                 % Sum of excess chemical potentials
chem_potent_ex = 0;      % Excess chemical potential
L = (N / rho)^(1/3);     % Box length
V = L^3;                 % Volume
[x0, y0, z0] = configuration(N, L); % Initial configuration
LR = 8 * pi * (N^2 / V / 3) * (epsilon * sigma^3) * ((1/3) * (sigma / 2.5)^9 - (sigma / 2.5)^3); % Long-range correction term
step = (1 - 0) / (f - 1); % Lambda step size
tic;
% Main loop for different lambda values
for iter = 1:f-1
    delta_r = L / 2;    % Initial move size
    S = 0;              % Sum for calculating average
    num = 0;            % Number of samples for average
    lambda = step * (iter - 1); % Current lambda value
    U = total_energy(x0, y0, z0, L, N, sigma, epsilon, alpha, lambda) + LR; % Total potential energy

    % Equilibration cycles
    for i = 1:N_equil
        for k = 1:N
            m = fix(rand() * N) + 1; % Randomly select a particle
            E_0 = interaction_energy(m, x0, y0, z0, L, N, sigma, epsilon, alpha, lambda); % Initial interaction energy of selected particle
            
            % Trial move
            for j = 1:N
                if j == m
                    xn(j) = x0(j) + delta_r * (2 * rand() - 1); % Move particle randomly
                    yn(j) = y0(j) + delta_r * (2 * rand() - 1);
                    zn(j) = z0(j) + delta_r * (2 * rand() - 1);
                    xn(j) = xn(j) - L * round(xn(j) / L); % Apply periodic boundary conditions
                    yn(j) = yn(j) - L * round(yn(j) / L);
                    zn(j) = zn(j) - L * round(zn(j) / L);
                else
                    xn(j) = x0(j);
                    yn(j) = y0(j);
                    zn(j) = z0(j);
                end
            end

            % Final interaction energy after move
            E_N = interaction_energy(m, xn, yn, zn, L, N, sigma, epsilon, alpha, lambda);
            delta_E = E_N - E_0; % Change in energy
            ratio = exp(-delta_E / T_star); % Acceptance probability
            
            % Metropolis criterion
            if ratio > 1 || rand() < ratio
                x0 = xn;
                y0 = yn;
                z0 = zn;
                U = U + delta_E;
                acc_move = acc_move + 1; % Increment accepted moves counter
            end
            total_move = total_move + 1; % Increment total moves counter

            % Adjust move size
            if k == N
                acc_ratio = acc_move / total_move;
                if acc_ratio > 0.5
                    delta_r = delta_r * 1.05; % Increase move size
                else
                    delta_r = delta_r * 0.95; % Decrease move size
                end
                if delta_r > 0.5 * L
                    delta_r = 0.5 * L;
                end
                acc_move = 0; % Reset counters
                total_move = 0;
            end
        end
    end

    % Production cycles
    for i = 1:N_prod
        for k = 1:N
            m = fix(rand() * N) + 1;
            E_0 = interaction_energy(m, x0, y0, z0, L, N, sigma, epsilon, alpha, lambda); % Initial interaction energy of selected particle
            
            % Trial move
            for j = 1:N
                if j == m
                    xn(j) = x0(j) + delta_r * (2 * rand() - 1);
                    yn(j) = y0(j) + delta_r * (2 * rand() - 1);
                    zn(j) = z0(j) + delta_r * (2 * rand() - 1);
                    xn(j) = xn(j) - L * round(xn(j) / L);
                    yn(j) = yn(j) - L * round(yn(j) / L);
                    zn(j) = zn(j) - L * round(zn(j) / L);
                else
                    xn(j) = x0(j);
                    yn(j) = y0(j);
                    zn(j) = z0(j);
                end
            end
            
            % Final interaction energy after move
            E_N = interaction_energy(m, xn, yn, zn, L, N, sigma, epsilon, alpha, lambda);
            delta_E = E_N - E_0; % Change in energy
            ratio = exp(-delta_E / T_star); % Acceptance probability
            
            % Metropolis criterion
            if ratio > 1 || rand() < ratio
                x0 = xn;
                y0 = yn;
                z0 = zn;
                U = U + delta_E;
            end
        end
        
        % Calculate sum for averaging
        if mod(i, 50) == 0
            E_0 = total_energy(x0, y0, z0, L, N, sigma, epsilon, alpha, lambda);
            E_N = total_energy(x0, y0, z0, L, N, sigma, epsilon, alpha, lambda + step);
            delU = E_N - E_0;
            S = S + exp(-delU / T_star);
            num = num + 1;
        end
    end
    
    % Calculate excess chemical potential
    chem_potent_ex = -T_star*log(S / num);
    sum = sum + chem_potent_ex/T_star;
    
    % Display results
    fprintf("The excess chemical potential is %f at lambda = %f and energy per particle is %f \n", chem_potent_ex, lambda, U / N)
end

% Final excess chemical potential and energy per particle
chem_potent_ex = 8 * pi * ((N^2 - (N - 1)^2) / (3 * L^3)) * (1) * ((1/3) * (1/2.5)^9 - (1/2.5)^3);
fprintf("The excess chemical potential is %f at lambda = %f and energy per particle is %f \n", chem_potent_ex, lambda + step, U / N)
sum = sum + chem_potent_ex;
fprintf("The total excess chemical potential is %f and energy per particle is %f \n", sum, U / N)
toc;
