# Proof of m9 critical squarefreeness

Version1,1 October2026.
[Statement](../../Theorems/cartier_and_spin/admissible_degree_ten_m9_critical_squarefreeness.md).
Use the actual coefficient bounds in
[the profile theorem](../../Theorems/cartier_and_spin/admissible_degree_ten_nonzero_profiles.md)
and the fixed translation gaps in
[the reduced-linear proof](admissible_linear_critical_denominator.md).
The tiny cubic-pencil certificate already executed for
[degree-eleven irreducibility](admissible_degree_eleven_critical_irreducibility.md)
is reused solely as a polynomial identity over the fixed field;
no degree-eleven geometric hypothesis is imported.

For any rational root $c$ of $D$, scaling the finite root
equation proves $\delta_3c_f$ affine, where $c_f=c+Z/y$.
The same integrality proves $\delta_3b_f$ affine for the
complementary quadratic
\[
D/\delta_3=(T-c)(T^2+bT+e),\qquad b_f=b-2Z/y.
\]
The cubic root budget excludes pole greater than five. At pole
five, $e=-\delta_0/(\delta_3c)\le4$ and
$b=(e-\delta_1/\delta_3)/c\le2$. Thus $\delta_3b\le11$
and its gap17 and14 forms force $\delta_3\in\langle q,q_3\rangle$.
This kernel's translation remainder has pole at most11. Yet
$\delta_3c$ has exact pole14, requiring an affine leading
pole14, a gap. This excludes pole five. For pole at most four,
$\delta_3c\le13$ directly kills the same two gaps and forces
the pencil. At pole at most one, the third gap11 also vanishes,
leaving $q_3$. Exact pole nine permits normalization to
$\delta_3=\kappa(q_3+\lambda q)$.

A repeated irreducible factor of a cubic in characteristic five
must be linear. A repeated rational root cannot have pole four:
its cubic term in $D(c)$ has pole21 and lower terms at most20;
the quadratic term's possible pole22 is uniquely leading, so
$\delta_2$ must have pole13 and leading term $-\delta_3c$.
Then $D'(c)\sim(3-2)\delta_3c^2$ has pole17, above
$\delta_1\le16$, and cannot vanish. A repeated root therefore
has pole at most three.

At a finite point write $D_f=\delta_3(T-c_f)^2(T-d_f)$.
If $c_f$ has pole $h>0$, nonnegative affine Gauss content gives
\[
\operatorname{ord}\delta_3-2h-\max(\operatorname{pole}d_f,0)\ge0,
\quad \operatorname{pole}c_f\le
\lfloor\operatorname{ord}\delta_3/2\rfloor.
\]
This also covers a triple root. A cubic polynomial $\delta_3$
admits a clearing polynomial $J(x)$ of degree at most two,
apart from one configuration. At an unramified zero of multiplicity
1,2,3 the needed exponent of $x-r$ is0,1,1. At a cubic branch
zero the local orders of $\delta_3$ are3,6,9 and the needed
exponents are1,1,2, because $x-r$ has order3. Multiplicity
patterns two plus one and three require total degree at most two.
For three distinct simple roots, only three branch roots would
require degree three. That exception means $\delta_3\mid P$.

No member $q_3+\lambda q$ divides $P$. Let $r_0,r_1$ be the
first two coefficients of its monic $x$-division remainder.
In ascending powers of $\lambda$, the reused certificate is
\[
r_0=(17,19,6,9,14,3,13,16,14),\quad
r_1=(22,7,14,22,11,23,24,13,22),
\]
\[
B_0=(14,21,2,11,15,24,19,14),\quad
B_1=(21,2,10,12,2,16,14,18),\quad B_0r_0+B_1r_1=1.
\]
Here $\beta^2=\beta+3$ and $[a+5b]=a+b\beta$.
This identity excludes the exception at every geometric $\lambda$.

Thus $Jc_f$ is affine for a nonzero $J$ of degree at most two,
while $Jc$ has short infinity pole at most $6+3=9$.
Removing the fixed affine part of $(Z/y)J$, the successive
gaps17,14,11 must all vanish. The fixed matrix on polynomials
of degree at most two has determinant[23] in its retained row
order, forcing $J=0$, a contradiction. Therefore $D$ is squarefree.

The arithmetic is reproduced by
[the existing fixed script](../../scripts/oct01_annihilator_transfer/fixed_linear_denominator_itinerary.py)
and retained in
[its exact certificate](../../../litt3-computation-data/oct01_local_continuation/annihilator_transfer/fixed_linear_denominator_itinerary.json).
No new numerical run or parameter search is needed.
