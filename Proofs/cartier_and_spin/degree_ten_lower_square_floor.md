# Proof and evidence for the lower square degree floor

All notation and exact linear equations are those of
[the two surviving profiles](../../Theorems/cartier_and_spin/admissible_degree_ten_two_profiles.md)
and [their leading boundary](../../Theorems/cartier_and_spin/degree_ten_square_boundaries.md).
No condition is inferred from a generic point alone.

Write C_d=[3]+[10]alpha+[1]alpha^2+[14]alpha^3 and
C_a=[18]+[14]alpha+[10]alpha^2+[19]alpha^3. On the seven-dimensional
linear direction space the top-coordinate map has rank5 and sole relation
c=C_d d for constant v, or c=C_a a+C_d d for linear v.
The coordinates(kappa,a,d,e,f) are independent and have a two-dimensional
kernel. The equations U=V=0 solve globally for
\[
z=2d/(\epsilon\kappa),\quad
e=-cz-\eta\kappa/([24]z),\quad
f=-d^2/(\epsilon\kappa)-([8]/[24])\kappa z^5.
\]
The nonzero eta forces d!=0. Thus the full lower boundary is
G_m^3 times A^2. Normalize a=kappa h,d=kappa w, with h,w nonzero.
The two free kernel coordinates can similarly be divided by kappa.
One has N_i=kappa H_i for i=2,3,4 and N5=vQ+kappa H5.

Choose the formal parameter xi with x=xi^-3, y=xi^-10 Y(xi), Y(0)=1.
Let m=32 for constant v and33 for linear v, and put
\[
AA=3\xi^{35}H_2,\quad BB=2\xi^{46}H_3,\quad CC=\xi^{57}H_4.
\]
The small critical root is Z_s=xi^-11 rho, where
AA rho^2+BB rho+CC=0 and rho(0)=2w/epsilon. This formal solution is
unique because BB(0)=2epsilon is a unit. Define
\[
T=\xi^{57}Q+\xi^2\rho^5,\quad
H=\xi^{70}H_5+\xi^2(AA\rho^3+2BB\rho^2),\quad
F=T H+\xi^{127}t^3y^{10}=\sum F_j\xi^j.
\]
The omitted contribution to xi^127 times the critical value starts
in degree10 or13, so it does not affect F4,...,F8. Universally
F0=F1=F2=F3=0. The large critical root has a fixed leading order.
Combining its contribution, that of Z_s and the explicit norm divisor
shows that if j in{4,...,8} is the first nonzero coefficient, then
\[
\deg R_0=146-j.
\]

It remains essential to prove that F4,...,F8 never vanish together.
For constant v, F4,F5 eliminate the two kernel coordinates with
unit determinant a nonzero constant times w^2. The next coefficient
is A1(w)h+B1(w); the exact Bezout relation gcd(A1,B1)=1 prevents a
lost pivot. After substitution, the numerators N7,N8 of F7,F8 obey
C7 N7+C8 N8=w^4. This proves the assertion on the full open torus.

For each linear v, the first elimination has determinant w^2 D(w^3)
with D linear. On D!=0, put S=w^3 and lambda=h/w. Exact resultant
and subresultant identities reduce F6=F7=0 to a squarefree degree49
polynomial g(S), with lambda uniquely recovered. The product of all
open-condition factors is a unit modulo g; F8 is also a unit there.
At the omitted D=0 point, a separate literal identity1 in F4,...,F7
rules out simultaneous vanishing. This exceptional-pivot check is
used only at this deeper boundary; it does not discard that chart
from degrees140 or142.

The same elimination describes degree138 exactly. Constant v gives
a squarefree degree12 polynomial in S=w^3, with h recovered and
three cube-root choices of w; kappa remains free. Linear v gives
degree49 in S with the same three cube-root choices. Hence36 and147
geometric G_m components respectively. All ten linear choices are
included, and coefficient Frobenius covers the four support choices.

For squarehood on these components, normalize y=wY and T0=1/(kappa w).
The normalized resultant norm differs by the square (kappa^18 S^6)^2.
Its degree138 leading coefficient is a unit and independent of T0.
The monic square-root recursion through degree69 is therefore valid
over the finite coefficient algebras. Two subsequent errors E68,E67
satisfy the exact polynomial identity A E68+B E67=1. This excludes
every value of the still arbitrary geometric parameter T0, including
the stronger closure with T0=0. There is one constant-v certificate
and41 irreducible-factor certificates covering all ten linear families.
Their degrees and factorizations are certified; no field bound on
unknown points is being assumed.

All42 square certificates were regenerated and verified in the
[complete local replay](../../../litt3-computation-data/structural_slices_replies_20260925/local_checks/boundary.log).
The same entry point checks the full linear parameter spaces, critical
series, generic and exceptional elimination, degree floor and normalized
resultant identities. The
[returned report](../../../litt3-computation-data/structural_slices_replies_20260925/extracted/boundary/lower_degree_square_locus/REPORT.md)
contains complete coefficient recipes and the theoretical factorization
obstruction. Its sources are retained under
[pro_structural_slices_20260925/boundary](../../scripts/arithmetic/pro_structural_slices_20260925/boundary/).

For that separate obstruction, the hypothetical factorization F/v=G gamma(G)
forces successively g4=0, pole(g3)=32 or30, and pole(g1)=64 or60.
The Z^4 coefficient then has an uncancellable pole96 or90, larger than
the possible competing pole92 or86. Cubic-character coefficients
ensure the leading term is nonzero. This excludes only that particular
factorization mechanism; it is not a classification of square norms.

The new results cover the entire lower boundary below degree140 and
all degree138 components. They do not decide degrees140,142,144,
the separate cubic-derivative sector, or the original common-cover problem.
