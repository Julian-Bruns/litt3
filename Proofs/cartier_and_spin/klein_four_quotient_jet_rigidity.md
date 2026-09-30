# Proof of quotient rigidity from two endpoint jets

Use the actual notation of
[coupled pole derivatives](klein_four_coupled_pole_derivatives.md), and
write U=(t^29-1)/E, of degree u. Each system has
F_i=2t^22 T_i+f_i, with deg T_i<=d_i and deg f_i<=15+d_i.
Use hats for a second system with the same pole partition and endpoint
labels. Form
\[
H_i=F_i\widehat T_i-\widehat F_iT_i
   =f_i\widehat T_i-\widehat f_iT_i.
\]
The fixed degree22 terms cancel, so deg H_i<=15+2d_i.

Both F_i and hat F_i vanish on C_i, giving C_i|H_i. At every unused
node the polynomial construction gives F_i=t^22 T_i and the analogous
hatted equality, so U|H_i. These arguments do not divide by a
denominator at an unused node. C_i and U are coprime and disjoint
from0 and infinity.

At0 with nonzero leading character denominator, the two prescribed
jets of F_i/T_i agree. Hence t^2 divides H_i. If the character
denominator is zero, the accepted paired-label rule makes both F_i
and T_i vanish twice, separately in each actual system. Then H_i
even vanishes four times. In either case t^2|H_i.

At infinity the comparison uses t^-15 f_i/T_i. When its leading
denominator is nonzero, agreement of the two jets removes the two
highest coefficients of H_i. When it is zero, both leading numerator
and denominator coefficients vanish twice in each system by the same
actual paired-label rule. Again the bound is at least as strong. Thus
\[
t^2\mid H_i,\qquad \deg H_i\le13+2d_i.
\]
If c_i+u>=12+2d_i, the divisor t^2UC_i has degree exceeding this
bound. Hence H_i=0 and F_i/T_i=hat F_i/hat T_i. No common factor
of F_i,T_i is discarded in the argument.

## Coupling determines the remaining quotient

Suppose the quotients for j and k are already equal. At a single
triple value of type j, the odd characters i,k have nonzero
denominators and F_i=F_k=0. The coupled derivative equation is
\[
(F_i/T_i)' +(F_k/T_k)'=3t^{21}
\]
at that value, with the same right side for both systems. The second
summand is already the same, so the i-th derivatives agree. The same
argument at type k covers every single-triple value in C_i. Therefore
the simple C_i factors in H_i become double there.

At a double-triple value, the polynomial B_i=(1-t^29)T_i+t^7F_i
is divisible by the square of the local equation in each system.
The identity
\[
\widehat T_i B_i-T_i\widehat B_i=t^7H_i
\]
gives a double factor in H_i there too, without division by T_i.
Consequently C_i^2 divides H_i. If 2c_i+u>=12+2d_i, the divisor
t^2UC_i^2 again has larger degree than H_i, proving H_i=0.

## A quadratic identity allows only one initially fixed quotient

Put S_i=T_i*hat T_i and write H_i=t^2 U v_i. The preceding endpoint
and unused-node conditions give
\[
\deg v_i\le11+2d_i-u,\qquad \deg S_i\le2d_i.
\]
At a single-triple value of inertia kernel i, the two odd denominators
in each candidate are units. Subtracting their coupled derivative
identities gives
\[
(H_j/S_j)' +(H_k/S_k)'=0
\]
at that value. Both numerators vanish there, so the polynomial
v_j S_k+v_k S_j has a double zero. At a double-triple value every H_i,
and hence every v_i, has a double zero by the B_i identity already used.

Consequently the same grouping as in the fixed-denominator argument
gives
\[
J^2 J2^2\mid Q_S(v):=v_1v_2S_3+v_1v_3S_2+v_2v_3S_1,
\qquad \deg Q_S(v)\le22+2D-2u.
\]
Here J2 is the reduced product of the double-triple values. No
denominator was divided out at an even character or double-triple
point. The numerical identity D=27+2j-g shows that
\[
2j+2j2>22+2D-2u
\quad\Longleftrightarrow\quad g>38+j-u-j2.
\]
Under this strict inequality Q_S(v)=0. If one H_i is already zero,
then v_j*v_k*S_i=0. Since S_i is a nonzero polynomial, at least one
other cross difference vanishes. The two-known-quotient argument now
applies to the remaining coordinate. This proves the new criterion.

## An affine function-field line contains every quotient triple

Although the polynomial form Q_S changes with the pair, division by
S_1*S_2*S_3 recovers a fixed form on rational quotient differences.
Put r_i=F_i/T_i and hat r_i=hat F_i/hat T_i. The exact identity is
\[
q(r-\widehat r)
=\frac{t^4U^2}{S_1S_2S_3}Q_S(v)=0,
\qquad q(x)=x_1x_2+x_1x_3+x_2x_3.
\]
Thus the same fixed quadratic form vanishes on every pairwise
difference of actual triples. Fix one triple r0. For any two actual
triples r,r', write v=r-r0 and w=r'-r0. The three identities
q(v)=q(w)=q(v-w)=0 show that their polar pairing is zero. Therefore
the k(t)-linear span of ALL such differences is totally isotropic.

The polar matrix has zero diagonal and unit off-diagonal entries;
its determinant is2 in characteristic five. It is nondegenerate of
rank three, so a totally isotropic subspace has dimension at most one.
This proves the affine-line statement, without requiring that sums
of actual solutions remain actual. If a nonzero isotropic direction
has one zero coordinate, its other two coordinates have zero product,
so it is a coordinate axis. The preceding doubled-node argument
excludes such an actual difference when the second inequality holds
for that index.

The fixed form is on rational quotient differences, not on the
polynomial cross differences H_i. Their denominators do depend on
the pair. The statement also leaves a rational-function scalar free;
it is not a finite-dimensionality or existence assertion over k.

## Scope and coefficient field

The exact retained profile enumeration gives109 allocations at87
and729 at86, and the same enumeration with degree85 retained gives4616.
The
[integer checker](../../scripts/arithmetic/check_klein_four_quotient_jets.py)
checks the two inequalities and the new quadratic criterion for every
allocation. The former two-index test covers109 at87 and715 at86;
the new one-index test raises the latter count to729. At85 the union
of the criteria covers4559 of4616 allocations. The other57 are left
unresolved by this theorem. It records each input hash and every
allocation's outcome in `quotient_jet_profiles.json` in
[the evidence directory](../../../litt3-computation-data/overnight_three_replies_20260926/).

Let M0 be the compositum of M with the field of the actual labeled
endpoint data, including chosen square-root frames. Coefficient
conjugation fixing M0 preserves every specified datum and sends an
actual candidate to another one. Quotient uniqueness makes each
F_i/T_i fixed by all those conjugations. Its rational-function
coefficients therefore belong to M0. This bounds these quotients only:
the common polynomial factors of F_i,T_i can still vary, and neither
the actual maps nor a common cover has been recovered.
