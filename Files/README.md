The program files are written in MATLAB programming language. `main.m` is the main program file. `configuration.m`, `interaction_energy.m` and `total_energy.m` are the necessary subordinate file. 

### 1. Details for `main.m`:
#### 1.1. Parameter and variable declaration: 
The following table contains all the parameters used for the NVT ensemble Monte Carlo simulation.
| Parameter name | Parameter symbol | Value |
| --- | --- | --- |
LJ length scale parameter	| $σ$ |	1
LJ energy scale parameter |	$ε$ |	1
Number of particles |	$N$ |	257
Equilibration steps |	$N_{equil}$ |	5000
Production steps |	$N_{prod}$ |	3000
Temperature	| $T^{*}$ |	0.85
Density	| $ρ^*$ |	0.8
Parameter for multistage free energy calculations |	$α$ |	0.5
Number of stages for free energy calculations |	$f$ |	10

#### 1.2. Variable Declaration:
The following table contains all the variables used for the NVT ensemble Monte Carlo simulation.
| Variable name | Variable symbol | Value |
| --- | --- | --- |
Length of the cubic simulation box |	$L=\left(\frac{N}{\rho^\ast}\right)^{1/3}$ | 6.84879
Volume of the cubic simulation box |	$V=L^3$ |	321.2500
Accepted moves during the simulation (Initialized) |	acc_move |	0
Total moves during the simulation (Initialized)	| total_move |	0
Excess chemical potential (Initialized)	| chem_potent_ex $(μ_{ex})$ |	0
Total μex of entire simulation (Initialized) |	sum |	0
Maximum move size (Initialized)	| $Δr$ |	$0.5L$


#### 1.3. Initialization:
After declaration of our parameters and variables, we use the function `configuration.m` to generate the initial configuration. Then we start the loop of our NVT ensemble Monte Carlo simulation for starting value of the multistage FEP as $\lambda_{min}=\frac{1}{f-1}$. The maximum value of stages during the simulation $\lambda_{max}=1$.

#### 1.4. Equilibration:
In this stage, we first equilibrate the system. The total cycles ran during this stage are $N_{equil}$. During this stage, we randomly select any particle and calculate the internal energy $E_0$ of that particular selected particle. The interaction energy of the system is calculated using the function `internal_energy.m`.  Then, there is a attempt to move the selected particle. The acceptance criteria of a particular move is based on the Metropolis criterion. If the move is accepted, then we find the interaction energy of the new configuration $E_N$ again using the function `interaction_energy.m`. During this stage, we also optimize $Δr$ such that the acceptance rate of any translational move is 50%.

#### 1.5. Production:
During this stage, we perform total of $N_{prod}$ of production cycles to sample configurations and calculate properties. In this stage, like equilibration stage, we do same process of translation of a randomly selected particle and calculating acceptance rate, except adjustment of  $Δr$. After every 50 production cycles, we calculate the total energy $E_0$ at the current $λ$ and $E_N$ at the $(λ+Δλ)$ for the same configuration of the system using function `total_energy.m`.  We also calculate the excess chemical potential using $e^{-βΔU}$ value and average the quantity over the total production cycles $N_{prod}$.

#### 1.6. Output:
All the above processes are repeated till $(f–1)$ number of stages. After $(f–1)$ stages, $λ=1$. When $λ=1$, the energy difference would be simply be the LJ long range interactions difference for 257 and 256 particles, i.e. the change in long range interactions on addition of a single particle. At the end, the final summation of all calculated chemical potential at different $λ$ values varying from 0 to 1 will give total sum and $(μ_{ex}/T^*)$ for the given temperature and density.

### 2. Details for `configuration.m`:
The cutoff radius for the overlap between two molecules is set as $r_{cut} = 0.8$. Then we randomly generate the position of the first molecule $(x_1, y_1, z_1)$ anywhere inside the box volume $V$. Then, like this we form a loop to randomly generate the positions of all particles $(x_i, y_i, z_i)$ where $i=[2,N]$ at every iteration. Then, we find the distance of the generated position with all the present molecular positions that have been selected and if this distance is greater than rcut, then we select that particular position for a molecule. This process is repeated until all particles have valid non-overlapping positions. The output from this file is the generated coordinates $(x, y, z)$ for all the particles.


### 3. Details for `interaction_energy.m`:
The cutoff radius for this stage is set as $r_{cut}=2.5σ$. We also set the initialize short-range energy, $SR=0$. Then we have following two cases:

•	If the randomly selected particle $i$ is not the $m^{th}$ and the last particle, $N$, then we calculate the distance $r$ between molecules $i^{th}$ and $m^{th}$ considering periodic boundary conditions. If the distance $r$, is such that $r < r_{cut}$, then we calculate the Lennard-Jones potential contribution using the 12-6 Lennard-Jones potential. If $r > r_{cut}$, then we calculate the modified Lennard-Jones potential contribution with a scaling factor $λ$.

•	If the randomly selected particle $(m)$ is the last particle in the system, then we loop over all particles $(i)$ except the last particle and calculate the distance $(r)$ between particles $i^{th}$ and $m^{th}$ considering periodic boundary conditions. If the distance $r$, is such that $r < r_{cut}$, then we calculate the modified Lennard-Jones potential contribution with a scaling factor $λ$.

The output generated from this file is the total interaction energy $(SR)$ of the randomly selected particle $(m)$ with all other particles in the system.

### 4. Details for `total_energy.m`:
The cutoff radius for this stage is set as $r_{cut}=2.5σ$. We also set the initialize short-range energy, $SR=0$. In this function, we loop over all pairs of particles $(i, j)$ in the system. For each pair, we calculate the distance $(r)$ between particles $i^{th}$ and $j^{th}$ considering periodic boundary conditions. If the distance $r$, is such that $r < r_{cut}$, and if particle $j$ is not the last particle, then we calculate the Lennard-Jones potential contribution using the 12-6 Lennard-Jones potential. If particle $j$ is the last particle we calculate the modified Lennard-Jones potential contribution with a scaling factor \lambda. The output of this function is the total short-range energy $(SR)$ of the system.
