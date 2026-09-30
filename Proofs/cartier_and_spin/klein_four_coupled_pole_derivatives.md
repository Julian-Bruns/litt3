# Proof of the coupled triple-pole identities

Use the actual characters, functions and polynomial coordinates in
[the statement](../../Theorems/cartier_and_spin/klein_four_coupled_pole_derivatives.md).
All projections use the given V4 action on S, not an action on its
cubic reconstruction. Characteristic is five.

## A base-field approximation through four orders

At t=c in mu29, let lambda^4=epsilon^4*t^-13 and
lambda(c)=epsilon*c^4. Since
\[
\frac{(\epsilon t^{33})^4}{\epsilon^4t^{-13}}
=t^{145}=1+(t^{29}-1)^5,
\]
the unique local fourth root gives lambda-epsilon*t^33=O((t-c)^5).
The accepted quartic expansion is
v=lambda*u+[22](lambda-1)/(4[13])+O(u^-1).
After subtracting [22](epsilon*t^33-1)/(4[13]), a rational
function of t, the function r=v-epsilon*t^33*u vanishes to order at least three
at every triple common-pole point. The subtracted function contributes
only to the trivial character. Its nontrivial components are exactly
\[
r_i=\frac{B_i z_i}{t^3 C_i},\qquad
B_i=\frac{V_i-\epsilon t^{36}U_i}{E}
=(1-t^{29})T_i+t^7F_i.
\]
The earlier Hermite divisibility says C_i divides B_i. Equivalently
r_i=n_i z_i/t^3 with the polynomial n_i=B_i/C_i.

## A fiber with one triple pole

Let its inertia be sigma_i, with the other character indices j,k.
Take t-c=s^2 and sigma_i(s)=-s at the pole. The companion point
in that t-fiber is regular for u and w=v-epsilon*t^4*u. Character
projection consequently gives equal, nonzero s^-1 leading
coefficients for w_j,w_k at the pole. This is the same actual
companion cancellation used in the accepted minor-divisibility proof.
In particular T_j(c),T_k(c) are units.

Set R_a=B_a/T_a, so r_a=R_a*w_a for a=j,k. Both R_a vanish at c.
The odd part of r at the pole is r_j+r_k, and has order at least
three by the preceding expansion. Its coefficient of s must vanish.
Since the leading coefficients of w_j,w_k agree and are nonzero,
R_j'(c)+R_k'(c)=0. Using F_j(c)=F_k(c)=0 gives precisely
\[
F_j'(c)/T_j(c)+F_k'(c)/T_k(c)=3c^{21}.
\]
This also proves the stated double divisibility after clearing the
two unit denominators. Neither the leading coefficient of T_i nor
its value at c is presumed nonzero.

## A fiber with two triple poles

Now the shifted function r vanishes to order at least three at BOTH
points. Projection over V4 preserves this assertion. For j,k odd
under inertia, z_j,z_k have order one and r_a=n_a z_a/t^3. Thus
n_j,n_k each vanish at c. Their C_j,C_k already contain t-c, so
B_j,B_k are divisible by (t-c)^2. For the even character i, r_i
has even order and hence order at least four. Its z_i,C_i are units
at c, so B_i is divisible by (t-c)^2 as well. This argument does
not require nonzero T_a(c) in a double-pole fiber.

## One global polynomial retains all these conditions

A direct identity, before any reduction or specialization, is
\[
t^7G=B_1B_2T_3+B_1B_3T_2+B_2B_3T_1
       +2(t^{29}-1)^2T_1T_2T_3. \tag{1}
\]
Indeed B_i=(t^29+1)T_i+t^7f_i; the t^58 and constant terms
cancel in characteristic five, leaving exactly the displayed G.

At a single-triple-pole value of inertia i, B_j and B_k vanish
once, and B_jT_k+B_kT_j vanishes twice by the derivative identity.
Grouping the first three terms in (1) as
B_i(B_jT_k+B_kT_j)+B_jB_kT_i proves order at least two even if
T_i(c)=0. At a double-triple-pole value every B_a vanishes twice,
and (1) again has order at least two. Since t is a unit at these
values and J is squarefree, J^2 divides G. The degree bounds give
deg L<=15+D, deg Q<=30+D, deg T<=D, so deg G<=44+D.
If G is nonzero, 2j<=44+D=71+2j-g, proving g<=71.

## The identically-zero alternative

Here is the precise endpoint input used to retain this boundary.
For the three normalized first-character jets r_i,s_i, if all three
leading denominators are nonzero then
\[
\sum_i r_i=\sum_i s_i=0
\]
never holds. The complete exact endpoint enumeration, described
below, proves this for all repeated labels as well. Its zero-value
sum cases are exactly those with all four A-root labels equal;
their derivative sum is always nonzero.

At zero, the first two coefficients of G are those of2L, since the
other terms start in degree seven. When all T_i(0) are nonzero,
G=0 would force the value and derivative sums of F_i/T_i to vanish.
They are the normalized r_i,s_i up to common nonzero factors, and
the endpoint input excludes this. The same reasoning holds at
infinity: the first two coefficients relative to the degree bound
44+D are twice the top two coefficients of L. The opposite jets are
those of t^-15*f_i/T_i in the inverse parameter. This follows also
from V_i/U_i=epsilon*(T_i+t^7f_i)/(t^22 T_i+f_i), whose correction
to epsilon*t^-15*f_i/T_i begins seven orders later.

Therefore G=0 forces a vanishing leading character denominator at
both endpoints. The accepted paired-label result says that one
such vanishing forces at least two: the two positive leading labels
are the same multiset as the negative labels, giving two repeated
pairs or four equal labels. The actual first jets then make both
corresponding T_i vanish through order one. At each endpoint the
total denominator order is at least four. A degree-d_i polynomial
cannot have orders at zero and infinity exceeding d_i when infinity
is measured in its prescribed O(d_i) frame. Summing gives D>=8.
Hence g<=19+2j in this alternative.

The current interval exclusion n>=88 and n=12+a+3j1+6j2 give
j<=25 for every remaining actual comparison. Consequently G=0
has g<=69, and G nonzero has g<=71. If e<=12, the earlier
g<=27+2j<=51 already suffices. This is a uniform bound, not a
claim that the g=71 or smaller numerical profiles are realizable.

## Exact endpoint evidence and verification scope

The source
[coupled_endpoint_sums.cpp](../../scripts/arithmetic/klein_four_coupled_endpoint_sums.cpp)
uses the accepted exact normalized endpoint data and retains all35
root multisets and all29^3 common-phase-normalized tuples. It checks
853615 tuples. There are514 tuples with a vanishing leading
denominator, which are separated from this test. Of the other tuples,
97216 have zero value sum,24304 for each of the four fully coalesced
root labels. None has zero derivative sum.

The implementation tests the value sum after multiplying by the
product of the three denominators. Only when this numerator is
zero does it test its derivative; that derivative vanishes exactly
when the derivative sum vanishes. There are no field inversions or
denominator exclusions hidden in this step. Rotation and common
phase normalization preserve both zero tests, as does coefficient
Frobenius. The raw complete log is `coupled_endpoint_sums.log` in
[the evidence directory](../../../litt3-computation-data/overnight_three_replies_20260926/).
The incoming endpoint data and field arithmetic are unchanged.
The independent checker
[check_klein_four_coupled_poles.py](../../scripts/arithmetic/check_klein_four_coupled_poles.py)
uses the reversed field tower and direct differentiation on280 specified
samples across all35 root multisets. It verifies the separated zero
denominators, coalesced zero-value sums and nonzero derivative sums.
It also expands(1) and the fifth-power approximation as exact
multivariate identities over F5. All checks pass; the sample is explicitly
an implementation check, not a replacement for the complete enumeration.
Run it with `--output` pointing outside the source workspace. Its retained
result is `coupled_poles_independent.json` in the same evidence directory.
This is focused local author verification, not an independent-agent
audit or an actual-curve enumeration.
