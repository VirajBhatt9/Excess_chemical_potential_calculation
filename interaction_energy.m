% Function to calculate interaction energy of a particle
function [SR] = interaction_energy(m, x, y, z, L, n, sigma, epsilon, alpha, lambda)
    SR = 0;
    r_cut = 2.5 * sigma;
    if m ~= n
        for i = 1:n
            if i ~= m
                if i ~= n
                    dx = x(i) - x(m);
                    dy = y(i) - y(m);
                    dz = z(i) - z(m);
                    dx = dx - L * round(dx / L);
                    dy = dy - L * round(dy / L);
                    dz = dz - L * round(dz / L);
                    r = sqrt(dx * dx + dy * dy + dz * dz);
                    if r < r_cut
                        SR = SR + 4 * epsilon * ((sigma / r)^12 - (sigma / r)^6);                
                    end
                else
                    dx = x(i) - x(m);
                    dy = y(i) - y(m);
                    dz = z(i) - z(m);
                    dx = dx - L * round(dx / L);
                    dy = dy - L * round(dy / L);
                    dz = dz - L * round(dz / L);
                    r = sqrt(dx * dx + dy * dy + dz * dz);
                    if r < r_cut
                        term = alpha * (1 - lambda^2) + (r / sigma)^6;
                        SR = SR + lambda * 4 * epsilon * (1 / term^2 - 1 / term);                
                    end
                end
            end
        end
    else
        for i = 1:n-1
            dx = x(i) - x(m);
            dy = y(i) - y(m);
            dz = z(i) - z(m);
            dx = dx - L * round(dx / L);
            dy = dy - L * round(dy / L);
            dz = dz - L * round(dz / L);
            r = sqrt(dx * dx + dy * dy + dz * dz);
            if r < r_cut
                term = alpha * (1 - lambda^2) + (r / sigma)^6;
                SR = SR + lambda * 4 * epsilon * (1 / term^2 - 1 / term);                
            end
        end
    end
end