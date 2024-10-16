# Excess chemical potential calculation using multiple stage Free Energy Perturbation (FEP) technique for a Lennard-Jones fluid in NVT ensemble using Monte Carlo simulation

## 1. Introduction to the system

In our system, we have 257 particles in which 256 particles are interacting with each other by the Lennard-Jones potential given by,

$u\left(r\right)=\ 4\epsilon\left(\left(\frac{\sigma}{r}\right)^{12}-\left(\frac{\sigma}{r}\right)^6\right)$ 

Here, $u\left(r\right)$ represents the intermolecular pairwise potential energy between two molecules $r$ distance apart. $\sigma$ and $\epsilon$ represents the Lennard Jones parameters acting between the molecules.

The last 257th particle interacts with the system of these 256 particles by some different potential, which is given by,

$u\left(r\right)=\ 4\lambda\epsilon\left(\frac{1}{\left[\alpha\left(1-\lambda^2\right)+\left(\frac{r}{\sigma}\right)^6\right]^2}-\frac{1}{\alpha\left(1-\lambda^2\right)+\left(\frac{r}{\sigma}\right)^6}\right)$

Our aim is to calculate the free energy change in multiple stages by the “Free Energy Perturbation (FEP)” technique. This is done by varying $\lambda$ between [0,1] and vary number of stages for free energy calculations till the calculated quantity, $μ_{ex}$ becomes constant and hence converges. The formula used for calculation purposes is the Zwanzig’s forward formula.

## 2. Theory of Free Energy Perturbation

Consider a molecular system with $n$ number of molcules in state let's say $(1)$ with the potential energy of the system given as $U_{(1)}$. The partition function in this case, is given by,

$Q_{(1)}=\ C\int{e^{-\beta U_{(1)}}dr^n}$ 

Similarly, another state of the system (2) can be considered. The partition function can be given as,

$Q_{(2)}=\ C\int{e^{-\beta U_{(2)}}dr^n}$

The free energy change can hence be computed as:

$F_2-F_1=-k_BTln\left(\frac{Q_2}{Q_1}\right)$

$\therefore\beta\Delta F=-ln\left(\frac{\int{e^{-\beta U_{\left(2\right)}}dr^n}}{\int{e^{-\beta U_{\left(1\right)}}dr^n}}\right)$

$\therefore\beta\Delta F=-ln\left(\frac{\int{e^{-\beta\left(U_{\left(2\right)}-U_{\left(1\right)}\right)}e^{-\beta U_{\left(1\right)}}dr^n}}{\int{e^{-\beta U_{\left(1\right)}}dr^n}}\right)$

$\therefore\Delta F=-ln(e^{-\beta\left(U_{\left(2\right)}-U_{\left(1\right)}\right)})\$

The formula obtained above is the Zwanzig’s forward formula. For our case, $ΔF=μ_{ex}$. Hence, we have,

$μ_{ex}=-ln(e^{-\beta \Delta U})$

Here, $\Delta U$ represents potential energy difference given by $\Delta U=U_{\left(2\right)}-U_{\left(1\right)}$.

## 3. Finite Difference Time Integration Method:

For any molecular simulation, we require to have a smooth curvature of the potential energy curve, without any discontinuties. A discontinuity in the potential energy curve can lead to numerical errors and erroneous results. To so, in free energy simulations, we employ the use of $\lambda$ and $\alpha$ parameters to get a smooth potential energy curve. 

Consider the same system with now the potential energy being given by:

$U_{\lambda\} $
