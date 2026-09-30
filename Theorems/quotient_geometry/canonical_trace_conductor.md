# The conductor determines the canonical trace annihilator

Version2, 16 September 2026. Independently audited, including the
finite-exception statement and moving-multiplier extension.

Let \(X\xleftarrow f Z\xrightarrow gY\) be an actual jointly minimal
finite bi-étale span of smooth projective connected curves of genus
at least two over an algebraically closed field. Assume the actual
cross norm \(g_*f^*:J(X)\to J(Y)\) is zero. Put
\(n=\deg f\), \(m=\deg g\), and \(\mathcal A=f_*\mathcal O_Z\).
Its integral joint image \(\Gamma\subset X\times Y\) has
\(\mathcal O(\Gamma)=M\boxtimes Q\), with
\(\deg M=m\), \(\deg Q=n\). Let \(\Delta\) be its conductor
divisor on the normalization Z.

Fix \(r\ge2\), and put
\[
T=\omega_Y^{1-r}Q,\qquad H=H^0(Y,T),\qquad J=M\omega_X^r.
\]
Let \(\mathcal K_r\subset\mathcal A\) be the saturated kernel of
the actual canonical weighted-trace map with coefficient bundle
\(\mathcal O_X\). Then there is a natural isomorphism
\[
\mathcal K_r\simeq J\otimes
\ker\left(H\otimes\mathcal O_X
 \longrightarrow f_*(g^*T|_\Delta)\right).
\tag{1}
\]
The map inside the kernel is restriction of actual pulled-back
sections. Formula (1) identifies the whole sheaf, including at
collisions of points in a fiber; its rank is \(h^0(T)\).
It comes from division by the actual Y-conormal derivative of the
equation of \(\Gamma\), whose divisor on Z is exactly \(\Delta\).

Suppose \(h^0(T)=1\), and write E for the zero divisor of its
nonzero section. For \(z\in Z\), put
\(c_z=\operatorname{mult}_z\Delta\) and
\(e_z=\operatorname{mult}_z(g^*E)\). Define the integral divisor
\[
D=\sum_{x\in X}\max_{f(z)=x}(c_z-e_z)\,x,
\qquad R=f^*D+g^*E-\Delta.
\tag{2}
\]
Then R is effective, has a zero coefficient at some point in
every f-fiber, and
\[
\mathcal K_r=J(-D),\qquad
\deg R=-n\deg\mathcal K_r,\qquad \deg\mathcal K_r\le0.
\tag{3}
\]
The divisor D is effective, and the inclusion
\(f^*\mathcal K_r\to\mathcal O_Z\) has zero divisor R. These
assertions impose no Galois or degree-prime-to-p condition.

## Raynaud consequences

In characteristic \(p>0\), apply the preceding construction to
the Frobenius-twisted actual span. Let \(G=g(X)\).
If a nonzero \(\eta\in H^0(Z^{(1)},B_Z)\) is annihilated by
all the degree-r canonical traces and \(h^0(T)=1\), then
\[
-\left\lfloor\frac{2G-2}{p}\right\rfloor
 \le\deg\mathcal K_r\le0,
\qquad
\deg R\le n\left\lfloor\frac{2G-2}{p}\right\rfloor.
\tag{4}
\]
If the coefficients of \(\eta\) belong to a stable degree-zero
summand of \(\mathcal A\) of rank greater than one, the upper
bound on \(\deg\mathcal K_r\) is strictly negative.

More precisely, write \(\deg\mathcal K_r=-j\). The ordinary
Cartier-exact differential represented by \(\eta\) has divisor
\[
\operatorname{div}(\eta)=f^*E_X+F_Z^*R,
\qquad \deg E_X=2G-2-pj,
\tag{5}
\]
for an effective divisor E_X on X. In (5), R is on \(Z^{(1)}\);
its Frobenius pullback has multiplicities p times as large.

For the current genus-nine, characteristic-five orthogonal
exception, failure of the lower canonical cutoff therefore forces
\(j\in\{1,2,3\}\) and \(\deg R=jn\).
For even n the special class is \(Q=\omega_Y^{n/2}\), so E=0:
the conductor differs from the largest fiberwise constant divisor
above it by only n, 2n or 3n. For odd n, the same statement has
the correction \(g^*y\), for the single point y in the special
class \(Q=\omega_Y^{(n-1)/2}(y)\).

There is no residual exception for a generic first-Jacobian twist.
Whenever \(h^0(T)\le1\), the degree-r trace map is injective on
\[
H^0(Z^{(1)},B_Z\otimes f^{(1)*}L)
\quad\text{for generic }L\in J(X^{(1)}).
\tag{6}
\]
The same assertion holds at every finite Frobenius height, with
\(B_Z\) replaced by \(B_{e,Z}\) and all curves twisted e times.
In particular, for a genus-two target and n at least two,
\(r=\lfloor n/2\rfloor+1\) always suffices for generic twists,
including the special divisor classes in the preceding theorem.

## Moving the multiplier with the second parameter

Let \(h=g(Y)\), \(N\in J(Y)\), and use multipliers
\(q\in H^0(Y,\omega_Y^rN^{-1})\). Actual multiplication and
trace define, for every coefficient bundle V on X,
\[
V\otimes f_*g^*N\longrightarrow
V\otimes\omega_X^r\otimes H^0(Y,\omega_Y^rN^{-1})^\vee.
\tag{7}
\]
Its generic kernel dimension over X is exactly
\(\operatorname{rk}(V)h^0(Y,\omega_Y^{1-r}QN)\).
For generic N this is
\[
\operatorname{rk}(V)\max\{0,n-(2r-1)(h-1)\}.
\tag{8}
\]
Thus the smallest degree r at least two giving generic injectivity
is \(\max\{2,\lceil(n+h-1)/(2h-2)\rceil\}\). This cutoff is
optimal by the dimension of the multiplier space.

For genus two it is again \(r=\lfloor n/2\rfloor+1\).
At that degree, failure of sheaf injectivity occurs exactly at one
second parameter if n is even, and on a translate of the Abel
curve inside J(Y) if n is odd. Outside that locus, (7) detects every
section, without a genericity assumption on the first parameter L.

There is an explicit normalization presentation at any generically
injective degree. Put \(\mathcal L_N=\omega_Y^rN^{-1}\),
\(a=(2r-1)(h-1)-n\), and \(p_X:\Gamma\to X\). For generic N,
\[
0\longrightarrow M^{-1}\otimes H^0(Y,\mathcal L_NQ^{-1})
\longrightarrow H^0(Y,\mathcal L_N)\otimes\mathcal O_X
\longrightarrow (p_X)_*(\mathcal L_N|_\Gamma)
\longrightarrow0,
\tag{9}
\]
where the first vector space has dimension a. Normalization gives
\[
0\longrightarrow (p_X)_*(\mathcal L_N|_\Gamma)
\longrightarrow \omega_X^r\otimes f_*g^*N^{-1}
\longrightarrow\mathcal T_N\longrightarrow0,
\tag{10}
\]
with \(\mathcal T_N\) of length \(p_a(\Gamma)-g(Z)\).
For genus-two Y at the optimal degree, a is zero for odd n and
one for even n. In particular the unnormalized term in (10) is
trivial of rank n in the odd case. These sequences retain the
actual normalization inclusion and its singularity quotient.

## Only finitely many second parameters can hide a Raynaud section

Suppose p is odd and \(g(Y)=2\). Apply all the geometric notation
to the first Frobenius-twisted span, and let
\[
s=g(X)-1,\quad b=\left\lfloor2s/p\right\rfloor,
\quad D_0=\sum_x\max_{f(z)=x}(c_z)\,x,
\quad \kappa=\deg D_0-2s(n+1)\ge0.
\tag{11}
\]
Assume n at least two and use \(r=\lfloor n/2\rfloor+1\).
There is a finite set \(\mathcal E\subset J(Y^{(1)})\) such
that for every N outside \(\mathcal E\), and EVERY
\(L\in J(X^{(1)})\), the degree-r moving traces detect all of
\(H^0(B_Z\otimes f^{(1)*}L\otimes g^{(1)*}N)\).

If n is even, \(\mathcal E\) is empty when \(\kappa>b\).
Otherwise it can be taken to be the single parameter
\(N=\omega_Y^{r-1}Q^{-1}\).

If n is odd, define the finite, pairwise disjoint sets
\[
S_y=\{x:\text{every branch of maximal conductor in the f-fiber}
             \text{ has Y-image }y\}.
\tag{12}
\]
Only points in the projection of the conductor can have nonempty
S_y. The exceptional set can be taken to consist precisely of the
parameters \(N_y=\omega_Y^{r-1}Q^{-1}(y)\) satisfying
\[
|S_y|\ge s+\kappa-b.
\tag{13}
\]
Indeed their possible trace-kernel lines have degree
\(-s-\kappa+|S_y|\). In particular
\[
|\mathcal E|\le
\left\lfloor\frac{2s(n+1)+\kappa}{s+\kappa-b}\right\rfloor
\le
\left\lfloor\frac{2s(n+1)}{s-b}\right\rfloor.
\tag{14}
\]
For the fixed genus-nine curve in characteristic five this gives
\(|\mathcal E|\le\lfloor16(n+1)/5\rfloor\) in odd first degree,
uniformly for all first parameters. The listed exceptional set is
a necessary locus for failure, not an assertion that failure occurs
at every listed point. The statement is at first Frobenius height;
no such finite-exception assertion is made at higher height.

These results detect actual canonical traces and constrain a
possible failure at the origin. They do not identify a trace with
a mixed Frobenius obstruction, and do not prove mixed vanishing
or exclude an actual common cover.

[Proof](../../Proofs/quotient_geometry/canonical_trace_conductor.md).
