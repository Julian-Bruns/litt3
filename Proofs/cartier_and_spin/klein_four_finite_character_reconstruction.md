# Proof of complete character reconstruction

Use [quotient-jet rigidity](klein_four_quotient_jet_rigidity.md), with
F_i=2t^22 T_i+f_i, deg T_i<=d_i and deg f_i<=15+d_i. The latter pair
is regarded as sections of O(d_i) and O(15+d_i) on the parameter P1;
this retains leading-coefficient zeros as zeros at infinity.
The entire parameter curve and its character polynomials are fixed.
Their branch points need not belong to the common-pole subset of mu29.
This extra datum matters for the absolute, rather than quotient, jets.

## Full endpoint labels prescribe four absolute jets

Write the actual character components as
\[
u_i=\frac{U_i z_i}{EC_i},\qquad
v_i=\frac{V_i z_i}{t^3EC_i},\qquad
V_i-\epsilon t^7U_i=ET_i.
\]
The identities defining F_i and f_i give
\[
T_i=\frac{C_i}{z_i}(t^3v_i-\epsilon t^7u_i),\qquad
f_i=\frac{C_i}{z_i}(\epsilon u_i-t^{25}v_i).
\tag{1}
\]
At0 the factors C_i,z_i are units. The first two regular coefficients
of u_i and t^3v_i therefore determine the first two coefficients of
both T_i and f_i. These are the Fourier sums of the specified labeled
endpoint data, not ratios alone.

At infinity let s=1/t, put h_i=deg z_i and c_i=deg C_i, and use
d_i=10+c_i-h_i. The regular normalized factors are
Cbar_i=t^-c_i C_i and zbar_i=t^-h_i z_i. Then
\[
t^{-d_i}T_i=\frac{\overline C_i}{\overline z_i}
 (t^{-7}v_i-\epsilon t^{-3}u_i),\qquad
t^{-(15+d_i)}f_i=\frac{\overline C_i}{\overline z_i}
 (\epsilon t^{-25}u_i-v_i).
\tag{2}
\]
The first two coefficients are fixed by the specified regular v_i and
t^-3u_i jets. All frame factors in(1)-(2) are fixed. Thus two candidates
with the same labeled data agree to order two in both components at
both ends, even when their leading coefficients vanish.

## A different common factor would violate the sparse zero bound

Fix an index and suppose two lifts (f,T),(hat f,hat T) of the same
rational quotient differ. Subtracting 2t^22 from F/T, their quotients
f/T agree. Remove the common zero divisor of the homogeneous pair
(f,T) on P1. There is a uniquely normalized reduced pair (f0,T0),
with no common zero, of degrees15+r,r. Both lifts have the form
\[
(f,T)=h(f_0,T_0),\qquad
(\widehat f,\widehat T)=\widehat h(f_0,T_0),
\quad h,\widehat h\in H^0(\mathbf P^1,\mathcal O(b)),
\quad r=d-b\ge0.
\tag{3}
\]
Equality of the four absolute jets in(1)-(2), and the fact that at
least one reduced component is a unit at each endpoint, imply
\[
h-\widehat h\in
H^0(\mathbf P^1,\mathcal O(b)(-2[0]-2[\infty])).
\]
If the lifts differ, b>=4, so r<=d-4. This already proves uniqueness
when d<=3.

At every single-triple value belonging to C_i, T_i is a unit and F_i
vanishes. Cancelling h is legitimate there and gives a zero of the
nonzero sparse polynomial
\[
2t^{22}T_0+f_0\in
S_r=\langle1,t,\ldots,t^{15+r},t^{22},\ldots,t^{22+r}\rangle.
\tag{4}
\]
For r<=6 the two exponent intervals are disjoint, so this polynomial
is nonzero since T0 is nonzero. The accepted Fourier-minor bound in
[Hermite pole matching](klein_four_hermite_genus_bound.md) says a nonzero
word in S_r has at most16+2r zeros among the29 distinct cyclotomic
nodes. There are c_i-j2 single-triple nodes in C_i. Therefore two
different lifts, with d_i<=10, would require
\[
c_i-j_2\le16+2r\le2d_i+8.
\]
The hypothesis contradicts this. Double-triple nodes were deliberately
not counted; no unit assertion at those nodes is needed. Formula(3)
also retains every common zero and every infinity degree drop.

The fixed pairs(T_i,f_i) recover U_i,V_i through the original polynomial
identities. Any coefficient conjugation fixing all specified data sends
an actual candidate to another such candidate. Uniqueness fixes the
polynomial pairs, so their coefficients lie in M0.

## Reduced-pair endpoint bounds and mixed denominator comparisons

The sparse word in(4) has the same rational quotient and hence the same
normalized endpoint jets as the original pair at any endpoint where
T_i is nonzero. The common factor is a unit at such an endpoint.
Thus the already established endpoint tests apply to the reduced pair,
with degree r rather than d_i. The complete minimum-word test gives
at most15 zeros when r=0 and one endpoint is available. The complete
one-endpoint pencil test gives at most14+2r for1<=r<=6. When r=0 and
both endpoints are available, the two-endpoint constant-word theorem
gives at most13. These are reuses of their polynomial and endpoint
statements; the reduced word need not itself define an actual map.

It remains to certify which endpoints are available without assuming
extra labels. If T_i has zero leading value at an endpoint, the
paired-label rule forces a second T_j to have zero leading value there.
Both polynomials then vanish to order at least two in their respective
endpoint frames. If this happened to T_i at both ends, the other two
polynomials would have at least four zeros between them, counted with
multiplicity. Hence sum_(j!=i) d_j<=3 guarantees at least one nonzero
endpoint for T_i. If max_(j!=i) d_j<=1, neither endpoint can vanish,
because no other character could supply the required double zero.
For a possible different lift, take the largest applicable zero bound
over0<=r<=d_i-4. A number c_i-j2 above this bound excludes that lift.

In a mixed comparison, for every already fixed denominator put
H_i=f_i-hat f_i and S_i=T_i. For every other index put
H_i=f_i*hat T_i-hat f_i*T_i and S_i=T_i*hat T_i as before.
Then r_i-hat r_i=H_i/S_i and
\[
t^2U\mid H_i,\qquad\deg H_i\le13+\delta_i,\qquad
\deg S_i\le\delta_i.
\]
The same unit, doubled-node and endpoint arguments prove the individual
and axis tests c_i+u>=12+delta_i and2c_i+u>=12+delta_i. After writing
H_i=t^2U*v_i, the quadratic polynomial Q_S has degree at most
22+sum delta_i-2u and is divisible by J^2*J2^2. This proves the mixed
quadratic criterion in the statement.

If one quotient is fixed and the quadratic criterion holds, each
nonzero difference is supported on one of the remaining coordinate
axes. A coordinate whose own axis inequality holds must therefore
vanish in every comparison, even if the other axis is not yet excluded.
Two fixed quotients allow the earlier single-coordinate argument without
needing the quadratic criterion. Once a quotient is fixed, the improved
common-factor criterion can fix its denominator. Iterate; each successful
step fixes another one of the six quotients or denominators, so the
procedure terminates. No quotient or denominator is presumed fixed
merely because a chosen candidate or a finite sample has been found.

## A coupled bootstrap covers the remaining fourteen degree86 cases

For d_i<=3, the four absolute jets of T_i alone already determine T_i,
without first knowing F_i/T_i. In each of the fourteen allocations not
covered by the direct quotient criterion, at least one quotient is fixed
by its individual inequality. All d_i are at most three except in the
single allocation(d_i)=(0,0,4),(c_i)=(11,11,22). In that allocation
the degree-four quotient is one of the individually fixed ones, and the
lifting argument above determines its T_i as well. Consequently all
three T_i are fixed in each of these fourteen cases.

Let h_i=hat f_i-f_i be the differences of two candidate completions with
those fixed denominators. The homogeneous quadratic relation in
[fixed-denominator rigidity](klein_four_fixed_denominator_rigidity.md)
applies: after removing the common unused-node factor, their differences
satisfy Q_T(h)=0. Here all fourteen cases have e=29,j2=0 and g=66 or67,
so the required inequality g>57-2(29-e)-2j2 holds. The at least one
already fixed quotient supplies a zero coordinate h_i. Since every T_i
is nonzero, the quadratic relation now makes the product of the other
two coordinates zero. A nonzero difference would therefore be supported
on a single coordinate. The axis exclusion2c_i+(29-e)>15+d_i holds
in every one of the fourteen cases and rules this out. Hence all h_i
vanish. This uses the homogeneous quadratic identity, not the stronger
conic degree criterion that failed for these boundary allocations.

## The two traces satisfy a finite algebra of length at most nine

Write
\[
u=a+U,\quad v=b+V,\qquad
U=\sum_i r_i z_i,\quad V=\sum_i s_i z_i,
\quad r_i,s_i\in M_0(t).
\]
The three-character vectors r,s are not proportional. Otherwise all
six secants(v_l-v_m)/(u_l-u_m) would be the same rational function,
contrary to [quartic secant recognition](quartic_comparison_secant_fields.md).
Choose indices i,j for which r_i s_j-r_j s_i is nonzero.

Project A(b+V)-c(t)A(a+U)=0, where c(t)=epsilon^4 t^-13, onto these
two characters and divide by their fixed z_i,z_j. These two equations
in a,b have total degree at most three. Since the leading coefficient
of A is [13]!=0, their homogeneous cubic parts are
\[
4[13](s_i b^3-c(t)r_i a^3),\qquad
4[13](s_j b^3-c(t)r_j a^3).
\]
The coefficient matrix is invertible. Linear combinations therefore
give equations a^3+(terms of total degree at most two)=0 and
b^3+(terms of total degree at most two)=0. Repeatedly reducing total
degree shows that their quotient algebra is spanned by
\[
a^i b^j,\qquad0\le i,j\le2.
\]
It has dimension at most nine over M0(t). The remaining character,
scalar, differential and actual-etaleness conditions can only reduce
its solution set. In particular no assertion of nonemptiness is made.

For an actual pair a,b in k(t), their finitely many coefficients
generate a finite extension of M0. Each distinct constant-field
conjugate gives a distinct solution pair of this finite algebra. Its
degree is consequently at most nine. This also proves that all
comparison functions are defined over that same constant extension.
It is a coefficient bound for u,v, not a claim that arbitrary solutions
of the two cubic equations satisfy either required endpoint map.

In the normalized setup the common-pole coordinates and their partition
are in M=F_(25^7), and the endpoint roots and their distinguished29th
roots are in F_(25^4). However, the other branch points of the parameter
curve are not known to lie in M. Suppose its three monic character
polynomials have coefficients in F_(25^b). Their square-root frames at0
then need at most F_(25^(2b)); the monic infinity frames add no further
extension. Thus M0=F_(25^lcm(2b,28)) suffices. The theorem gives a relative
field bound after this curve is fixed, not a new bound on its defining
field or on the entire family of possible parameter curves.

## Exact numerical application

The retained complete necessary-profile list has109 allocations at87
and729 at86. The quotient-jet checker gives uniqueness in109 and715
respectively. The
[extended integer checker](../../scripts/arithmetic/check_klein_four_quotient_jets.py)
also verifies, for every one of these824 direct allocations, the condition
d_i<=3 or(d_i<=10 and c_i-j2>2d_i+8) for each character.
It also checks the coupled bootstrap for each of the fourteen remaining
allocations, so complete character reconstruction holds for838/838 in
the two degrees. At87 the maximum-degree histogram is{1:10,2:56,3:28,4:15}; at86 all
d_i are at most five. The receipt `quotient_jet_profiles.json` retains
each outcome and the input hash in
[the evidence directory](../../../litt3-computation-data/overnight_three_replies_20260926/).

The lifting and nine-dimensional trace arguments are algebraic; the
integer check only identifies their exact scope within the previously
retained necessary profiles. Both original unmarked common-cover
problems remain unresolved.

The further
[mixed-jet checker](../../scripts/arithmetic/check_klein_four_mixed_jet_reconstruction.py)
starts only with d_i<=3 denominators fixed by their four absolute jets.
It records every mixed comparison, endpoint availability bound and
lifting step. On the same complete profile lists it gives109/109
complete characters at87,729/729 at86, and4536/4616 at85. At85 it fixes
the quotients in4588/4616 cases; this count uses the fixed curve's
absolute jets and must not replace the earlier curve-independent count.
The receipt is `mixed_jet_profiles.json` in the same evidence directory.
