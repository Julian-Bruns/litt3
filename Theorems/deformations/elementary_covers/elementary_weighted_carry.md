# Weighted additive carries and projective detectors for elementary $p$-groups

Version3,3 October2026. Let $k$ be perfect of characteristic $p\ge5$,
$r\ge2$, and $G=C_p^r$ with FIXED generators $\sigma_i$.
Put $\Lambda_m=W_m(k)[G]$. In the original normal basis
$e^\alpha$, $e_i=\sigma_i-1$, $0\le\alpha_i<p$, give $p$ weight $p-1$
and each $e_i$ weight one; write $\mathcal W^d$ for the decreasing
weight filtration and put $D=(p-1)r$.

Let $L:\Lambda_m\to\Lambda_m$ be additive and deck-equivariant,
with reduction $f\Phi$, where $\Phi$ is coefficient Frobenius fixing
the original generators. Suppose $f=q+$ terms of augmentation degree
at least $a+1$, where $q$ is homogeneous of degree
$2\le a\le p-2$ and
\[
q(v)\ne0\qquad(0\ne v\in\mathbf F_p^r).
\]
No commutativity of the higher additive coefficient operators is required.
Then
\[
Lx=0\bmod p^m\ \Longrightarrow\
x\in\mathcal W^{(p-1)m-a+1}\quad(2\le m\le r);
\]
at $m=r+1$ the bound is $x\in\mathcal W^D$.
For $\Lambda=\Lambda_{r+1}$ one also has
\[
\mathcal W^{D+a}\subset L(\mathcal W^D).
\]
The reduction of $\mathcal W^D$ is precisely the norm line $kN_G$.

## Integral norm targets

Put $N_G=\sum_{g\in G}g$. At precision $p^r$, for any coefficient
$\eta\in W_r(k)$,
\[
Lx=N_G\eta\ \Longrightarrow\
x\in\mathcal W^{D-a},\qquad\operatorname{aug}(x)=0.
\]
If moreover $\eta\bmod p=0$, then $x\in\mathcal W^{D-a+1}$.
At precision $p^{r+1}$ the equation $Lx=N_G\eta$ is soluble
if and only if $\eta\bmod p=0$. In that case every solution is in
$\mathcal W^D$, and their reductions are exactly $kN_G$, including
every prescribed leading norm coefficient.
Thus the leading reductions at precision $p^r$ lie in
$J^{D-a}=\operatorname{Ann}(J^{a+1})$, and in
$J^{D-a+1}=\operatorname{Ann}(J^a)$ for a divisible norm coefficient.
For $p=5,a=2$, these are $\mathcal F_2$ and $\mathcal F_1$ for EVERY
elementary rank; the full next-precision solution lies on the norm line.
These statements require no formal nodal coordinates or discriminant.

## Exact critical detector

The associated graded algebra of $\Lambda$ is
\[
k[\tau,E_1,\ldots,E_r]/(\tau^{r+1},E_i^p+\tau E_i),
\qquad \deg\tau=p-1,\quad\deg E_i=1.
\]
For a homogeneous target $Z$ of weight $D+a-1$ define
\[
\Theta_i(Z)=\Phi^{-1}\!\left(
(-1)^{r+1}\sum_{[v]\in\mathbf P^{r-1}(\mathbf F_p)}
\frac{v_i Z(-1,v)}{q(v)}\right),\qquad1\le i\le r.
\]
Every summand is independent of its projective representative.
Apply inverse Frobenius to the coefficient AFTER the whole sum.
For every $R\in\mathcal W^{D+a-1}$,
\[
\Theta_i(\operatorname{gr}_{D+a-1}R)=0\ \text{for all }i
\quad\Longleftrightarrow\quad
R\in L(p\Lambda+\mathcal W^D).
\]
The critical source and target each have dimension $(p^r-1)/(p-1)$.
The $r$ detectors extract the coefficients of
$E_i^{p-2}\prod_{j\ne i}E_j^{p-1}$ in the unique graded preimage.

For $p=5,a=2$ this retains the entire older quadratic theorem.
At $r=3$ the kernel thresholds are7,11,12, absorption starts at14,
and the three weight13 detectors have positive sign; the sign is
negative for even $r$.

This is an ADDITIVE theorem. The original-rational-direction hypothesis
and the degree restriction on the principal symbol are essential to
the argument. Equivariance or formal hypersurface type alone supplies
neither them nor a weight bound or detector vanishing for an actual
WHOLE nonlinear Witt residual. No geometric lift or descent follows
without those additional inputs.

[Proof](../../../Proofs/deformations/elementary_covers/elementary_weighted_carry.md).
