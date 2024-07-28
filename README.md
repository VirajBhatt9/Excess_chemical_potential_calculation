# Excess chemical potential calculation using multiple stage Free Energy Perturbation technique
## 1. Introduction to the system
In our system, we have 257 particles in which 256 particles are interacting with each other by the Lennard-Jones potential given by,

$u\left(r\right)=\ 4\epsilon\left(\left(\frac{\sigma}{r}\right)^{12}-\left(\frac{\sigma}{r}\right)^6\right)$

The last 257th particle interacts with the system of these 256 particles by some different potential, which is given by,


## 2. FEP Mathematics:
Consider a molecular system with $n$ number of molcules in state let's say $(1)$ with the potential energy of the system given as $U_{(1)}$. The partition function in this case, is given by,

$Q_{(1)}=\ C\int{e^{-\beta U_{(1)}}dr^n}$ 

Similarly, another state of the system (2) can be considered. The partition function can be given as,

$Q_{(2)}=\ C\int{e^{-\beta U_{(2)}}dr^n}$

The free energy change can hence be computed as:

$F_2-F_1=\ -k_BTln\left(\frac{Q_2}{Q_1}\right)$

$\therefore\beta\Delta F=-ln\left(\frac{\int{e^{-\beta U_{\left(2\right)}}dr^n}}{\int{e^{-\beta U_{\left(1\right)}}dr^n}}\right)$

$\therefore\beta\Delta F=-ln\left(\frac{\int{e^{-\beta\left(U_{\left(1\right)}-U_{\left(0\right)}\right)}e^{-\beta U_{\left(0\right)}}dr^n}}{\int{e^{-\beta U_{\left(0\right)}}dr^n}}\right)$

$\therefore\Delta F=-ln(e^{-\beta\left(U_{\left(1\right)}-U_{\left(0\right)}\right)})\$

The formula obtained above is the Zwanzig’s forward formula. For our case, $ΔF=μ_{ex}$. Hence, we have,

$μ_{ex}=-ln(e^{-\beta\left(U_{\left(1\right)}-U_{\left(0\right)}\right)})\$

