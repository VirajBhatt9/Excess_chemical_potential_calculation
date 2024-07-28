% Function to generate initial configuration
function [x, y, z] = configuration(N, L)
    r_cut = 0.8;
    x(1) = rand() * L - 0.5 * L;
    y(1) = rand() * L - 0.5 * L;
    z(1) = rand() * L - 0.5 * L;
    i = 2;
    while i <= N
        x(i) = rand() * L - 0.5 * L;
        y(i) = rand() * L - 0.5 * L;
        z(i) = rand() * L - 0.5 * L;
        c = 0;
        for j = 1:i-1
            dx = x(i) - x(j);
            dy = y(i) - y(j);
            dz = z(i) - z(j);
            dx = dx - L * round(dx / L);
            dy = dy - L * round(dy / L);
            dz = dz - L * round(dz / L);
            rsq = dx * dx + dy * dy + dz * dz;
            if rsq > (r_cut * r_cut)
                c = c + 1;
            end
            if c == i - 1
                i = i + 1;
            end
        end    
    end    
end