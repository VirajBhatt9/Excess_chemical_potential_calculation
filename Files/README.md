The program is written in MATLAB. `main.m` is the main program file. `configuration.m`, `interaction_energy.m` and `total_energy.m` are the necessary subordinate file. 

### 1. Details for `configuration.m`:
The cutoff radius for the overlap between two molecules is set as $r_{cut} = 0.8$. Then we randomly generate the position of the first molecule $(x_1, y_1, z_1)$ anywhere inside the box volume $V$. Then, like this we form a loop to randomly generate the positions of all particles $(x_i, y_i, z_i)$ where $i=[2,N]$ at every iteration. Then, we find the distance of the generated position with all the present molecular positions that have been selected and if this distance is greater than rcut, then we select that particular position for a molecule. This process is repeated until all particles have valid non-overlapping positions. The output from this file is the generated coordinates $(x, y, z)$ for all the particles.


### 2. Details for `interaction_energy.m`:
The cutoff radius for this stage is set as $r_{cut}=2.5σ$. We also set the initialize short-range energy, $SR=0$. Then we have following two cases:

•	If the randomly selected particle $i$ is not the $m^{th}$ and the last particle, $N$, then we calculate the distance $r$ between molecules $i^{th}$ and $m^{th}$ considering periodic boundary conditions. If the distance $r$, is such that $r < r_{cut}$, then we calculate the Lennard-Jones potential contribution using the 12-6 Lennard-Jones potential. If $r > r_{cut}$, then we calculate the modified Lennard-Jones potential contribution with a scaling factor $λ$.

•	If the randomly selected particle $(m)$ is the last particle in the system, then we loop over all particles $(i)$ except the last particle and calculate the distance $(r)$ between particles $i^{th}$ and $m^{th}$ considering periodic boundary conditions. If the distance $r$, is such that $r < r_{cut}$, then we calculate the modified Lennard-Jones potential contribution with a scaling factor $λ$.
