# Partial exclusion of a reduced linear critical denominator

Version3,1 October2026. Retain an ACTUAL nontrivial admissible
degree-ten source and its annihilator $u$ in
[reconstruction](admissible_line_reconstruction.md). Use the short
frame $W$ and raw polynomial $F$ from the uniform annihilator theorem.
Suppose the critical polynomial
\[
D=\delta_3T^3+\delta_2T^2+\delta_1T+\delta_0,
\qquad \delta_3\ne0,
\]
is squarefree over $K=k(X)$. This is function-field squarefreeness;
finite critical fibers may have repeated roots and the leading
coefficient may vanish. Let $U=uD$ be the trace-dual interpolator,
of degree at most five. Assume
\[
\deg\gcd(D,U)=2.
\]
Equivalently the reduced denominator of the trace-dual rational
representative $U(T)/D(T)$ is linear.
Write $D=\delta_3(T-c)R$, with $R$ monic quadratic.

Put $\rho=m_4\in\langle1,x,x^2\rangle$ and
\[
n_0=\operatorname{Tr}(u^2/\phi)\in L_{10},\qquad
\mu_j=\operatorname{Tr}(u^2W^j/\phi).
\]
The short moments may have finite branch poles. Then
\[
n_0\ne0,\qquad c=\mu_1/n_0,
\qquad \mu_2=c^2n_0+(v/\delta_3)\rho^2,
\]
and consequently
\[
D(c)=0,\qquad
n_0\mu_2-\mu_1^2=(v/\delta_3)\rho^2n_0.
\]
The root $c$ cannot have infinity pole FOUR or any infinity pole
at least SEVEN. The positive pole orders $1,2,3,5,6$ remain
possible before the profile-specific restrictions below.

Let $m$ be the exact infinity pole of $\delta_3$, as in the
nine-profile reduction. In the finite frame $w=W+Z/y$, put
$c_f=c+Z/y$. Then $\delta_3c_f$ is affine regular, including at
zeros of primitive content and at cubic branch points. Consequently:

- The entire $m=3$ and $m=6$ reduced-linear-denominator strata
  are excluded.
- The $m=6$ finite/gap reduction first forces $c$ to have exact
  infinity pole FIVE or SIX, and
  $\delta_3$ and $n_0$ are nonzero multiples of the same fixed
  quadratic $q=([13],[18],[24])$. In particular
  $\delta_3=k n_0$ for a nonzero constant $k$, and
  $n_0\mu_2-\mu_1^2=(v/k)\rho^2$.
- This quadratic is coprime to $A$. Thus before the final $m=6$
  contradiction
  there are NO ordinary-small selected endpoints: $c$ is regular
  at all nine selected endpoints, and $c(P)=0$ forces
  $\delta_1(P)=0$, the concentrated boundary described below.

No affine regularity of $c$ itself is asserted.

There is a further necessary infinity inequality in every
$d=10$ profile. Write $U=R p$, put $k=\deg p\le3$ and
$N=\operatorname{pole}_O n_0\in\{6,9,10\}$. If
$r=\operatorname{pole}_O c>2$, then $N+r\le12$ and
\[
B_* =\max(2r,16-m,18-m-r),
\qquad N-m-10+(8-2k)r+4k-B_*\le0.
\]
Here $k\le2$ exactly when $\rho=0$. In particular $\rho=0$
excludes poles FIVE and SIX in all remaining $d=10$ profiles.
For $m=9$, $\rho=0$ also excludes pole THREE, by the exact
top-coefficient nongap refinement in the proof. This inequality
does not apply to the four one-big-sheet profiles.

The projected selection consists of three complete unramified cubic
fibers over roots of the fixed quartic
$A=(1,21,14,22,13)$. At one of these nine endpoints call the
remaining root ordinary-small when $c$ is regular with $c(P)=0$
and $\delta_1(P)\ne0$. Each such endpoint is a zero of $n_0$.
Write $n_0=p(x)+\gamma y$, with $\deg p\le3$. Then:

- If $\gamma\ne0$, there are at most THREE ordinary-small endpoints.
- If $\gamma=0$, there are at most SIX ordinary-small endpoints.

In particular the remaining root cannot be ordinary-small at all nine
selected endpoints. No unit hypothesis on $\delta_3$ or $v$ at
these endpoints is required. The $\delta_1(P)=0$ concentrated
boundary is retained explicitly; mere $c(P)=0$ there does not force
$n_0(P)=0$. These restrictions do not exclude every reduced linear
denominator, a reduced quadratic or cubic denominator, or the
remaining degree-ten source sector.

The exact fixed-field convention is
$\beta^2=\beta+3$ in $\mathbf F_{25}$, with code
$[a+5b]=a+b\beta$. The new finite itinerary check is a fixed
polynomial Bezout identity, not a source-parameter search.

[Proof and exact evidence](../../Proofs/cartier_and_spin/admissible_linear_critical_denominator.md).
