# Proof of the seven-point norm obstruction

24 September 2026. The complete incoming
[report](../../../litt3-computation-data/degree55_rank_support_replies_20260924/originals/support/seven_point_support/REPORT.md)
and all original evidence are preserved externally.

## The scalar calculation

Use W=H0(X,omega(R_X)), with basis
\(x^iy^j\theta/A\), where the respective i bounds for j=0,1,2 are
9,6,3. The dimension is21. At each missed finite point, imposing a
double zero of the differential is equivalent to vanishing of the first
three jets of its numerator. At infinity the three excluded coefficients
are those of x^9, x^6y and x^3y^2. Six missed points give an18x21 matrix J.

For \(K(H)=\sum H_{5i+4}^{1/5}x^i\), the Cartier matrix M is specified by
\[
C(x^i\theta/A)=yK(x^iA^4P)\theta/A,\quad
C(x^iy\theta/A)=K(x^iA^4P^3)\theta/A,
\]
\[
C(x^iy^2\theta/A)=y^2K(x^iA^4)\theta/A.
\]
Thus C(v)=M v^{[1/5]} and the intersection in the theorem is the kernel of
\(\binom{J}{(JM)^{[5]}}\). Every such matrix has rank21. The independent
portable implementation checks nonzero minors for146 arithmetic orbits,
covering all1716 subsets; the accelerated implementation also checked
every subset directly. Both replays passed. The kernel dimensions before
Cartier are3 in1710 cases and5 for the six unions of two cubic fibers.

## Trace, norm and primitive quotient

Put Delta=h*R_X-E. The exact divisor calculation gives
\[
\operatorname{div}(dq/q)=2\Delta-E+5G.
\]
Hence the logarithmic norm differential
\(d\log\operatorname{Nm}(q)=\operatorname{Tr}(dq/q)\)
has at worst simple poles over the seven support points and double zeros
at every missed point. This remains valid in five-divisible degree:
local etale trace is a sum of completed regular germs, with no division
by the degree. The logarithmic differential is Cartier-fixed, so the
scalar theorem forces it to vanish. The norm is therefore a fifth power.
Its divisor
\(3h_*E-5h_*G-10nO\) proves that every occupancy h_*E is divisible by5.

E and G descend to the etale primitive quotient k(X)(q): their coefficients
are determined fiberwise by q and H, since an equality
3(e-e')=5(g-g') with e,e' in{0,1} forces equality of both pairs.
On its degree-m cover the seven positive occupancies are5r_P with
\(1\le r_P\le\lfloor m/5\rfloor\) and \(\sum r_P=m\).
Thus \(7\le m\le7\lfloor m/5\rfloor\), equivalent to m=7 or m>=10.

Write h_*E=5D_E and D_G=h_*G. Taking the fifth root of the norm shows
\(3D_E-D_G-2nO\sim0\). For T=E-G-4H with5T~0,
\[
h_*T\sim2(D_E-nO).
\]
The left class is killed by5; the right has prime-to-five order by the
established support arithmetic. Both vanish. This gives all asserted
norm and two-torsion relations. It does not make T itself trivial.

## Degree seven and a retained polynomial reduction

At actual degree seven each nonzero occupancy is5, so D_E is a reduced
seven-subset B with2B~14O. Since
\(L(14O)=\langle1,x,x^2,x^3,x^4,y,xy\rangle\)
has no function with sole pole of order14, B contains O. A function
with divisor2B-14O has form a(x)+by, deg a<=4. Six finite zeros in four
cubic fibers force two in one fiber; their different y values force b=0.
Its zeros are two complete fibers, each doubled. Thus B is O plus two
fibers, and already B~7O. All six choices survive only this necessary test.

For such a choice write b_2=(x-r_i)(x-r_j). The same norm relation gives
D_G~7O, so D_G=div(v)+7O for a polynomial v of degree at most two.
The trace identity df Tr(q^-1)=0 and its derivatives give
Tr(q^-j)=0 for j=1,...,5. Therefore the irreducible degree-seven
minimal polynomial is
\[
T^7+(-2f+s^5)T^6+(f^2-s^5f+t^5)T^5+
(\kappa b_2^3/v)^5,
\quad s,t\in k(X),\quad\kappa\ne0.
\]
This follows by differentiating its conjugate roots, all of which have
derivative df. Irreducibility, everywhere etaleness, prime-to-five normal
closure, and the nontrivial order-five class are still required. Arbitrary
parameters in this expression are not geometric witnesses.

Logs of the independent
[portable check](../../../litt3-computation-data/degree55_rank_support_replies_20260924/logs/support_portable_replay.log)
and the
[all-subset check](../../../litt3-computation-data/degree55_rank_support_replies_20260924/logs/support_all_subsets_replay.log)
record successful executions. Norm-zero alone leaves a genuine gap.
