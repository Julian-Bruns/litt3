# Proof: the unmarked lift family and the original net's two-point condition

Version1, 3 October2026. Fresh bounded independent
[audit PASS](../../Research/notes/oct03_ten_hour/unmarked_net_cohomology_audit.md).
See the [statement](../../Theorems/cartier_and_spin/canonical_ten_unmarked_saturated_net_annihilator_incidence.md)
for the exact original-source and saturation hypotheses. Both original
étale maps remain on the same source. The theoretical proof requires
no computational certificate. The proof uses no bound on or specified
value of the original coefficient-module dimension.

## Liftability is controlled by inverse effectivity

Put $A=Q^{-1}$, of degree one. Projection formula identifies
$F_*\mathcal O_Y\otimes A=F_*(F^*A)$. Since $\deg F^*A=5$ on a
genus-two curve, $h^0(F^*A)=4$ and $h^1(F^*A)=0$.
The tensored Frobenius sequence therefore gives
\[
0\to H^0(A)\to H^0(F^*A)\to\operatorname{Hom}(Q,B)
\xrightarrow{\beta}H^1(A)\to0.
\]
Riemann--Roch in degree one gives $h^0(A)=h^1(A)$, equal to zero or
one. If there is a section, its effective divisor is a single point
$S$, so $A=\mathcal O(S)$. Two independent sections of a degree-one
line would yield a degree-one map to the projective line, impossible
in genus two. Thus $\operatorname{Hom}(Q,B)$ always has dimension
four, with the exact liftable dimensions in the statement.

In particular the nonlifting locus lies over the degree-one Abel
curve. Outside it every map has a unique twisted global primitive;
there is no assertion of a rational primitive bounded at $P_0$.
For clarity, the family of maps itself is a rank-four vector bundle
over $\operatorname{Pic}^{-1}(Y_1)$ after a normalized Poincaré choice:
$\chi(B\otimes A)=4$ and the above calculation gives $h^0=4$, hence
$h^1=0$ for every fiber. Saturated embeddings form an open locus in
its projectivization. This keeps the actual line class explicit.

## The net section and the nonzero quotient support

The alternating Cartier form gives
$B/K=\omega_{Y_1}Q^{-1}$. The integral quotient $J/K=\mathcal O_{Y_1}$
maps injectively into this line, giving a nonzero section $\sigma$.
Its preimage is exactly $J$: both $J$ and that preimage have the same
generic subspace and identical quotient by $K$.
Locally this preimage has a basis consisting of a basis of $K$ and
a final quotient vector multiplied by the local coefficient of
$\sigma$. Hence the determinant defect is
$D_J=\operatorname{div}\sigma$, of degree three.

Ordinarity gives $H^0(B)=H^1(B)=0$, so the ambient exact sequence
makes its boundary an isomorphism
$H^0(\omega_{Y_1}Q^{-1})\simeq H^1(K)$. The left side has dimension
two by Riemann--Roch in degree three. Thus $e_J=\partial\sigma\ne0$.
An original global net direction with nonzero constant quotient
splits the pulled extension on the actual $q^{(1)}$ source; it imposes
$q^{(1)*}e_J=0$, not $\beta=0$.

In the actual $\ell(q_1)\ne0$ branch retain precisely the infinity
support ledger of
[the nonzero-quotient saturation theorem](canonical_ten_rank_three_nonzero_quotient_saturation.md).
It gives $R_+^{(1)}+R_-^{(1)}\le D_J$. Since that hyperelliptic pair
is canonical and $\deg D_J=3$, there is a point $S$ with
$D_J=R_+^{(1)}+R_-^{(1)}+S$.
Consequently
$\omega_{Y_1}Q^{-1}=\mathcal O(D_J)=\omega_{Y_1}\mathcal O(S)$.
Cancelling $\omega_{Y_1}$ proves $Q^{-1}=\mathcal O(S)$.
The residual point can coincide with a wild point. No equation
$S=P_0^{(1)}$ is obtained.

## The actual zero-q1 plane has at most one exceptional branch

In the other branch the original constant quotient has kernel
$W=\langle q_0,q_1\rangle$ and $\ell(q_2)\ne0$.
Its actual raw image is contained in $q^{(1)*}K$.
At infinity on the fixed $X$, the primitive orders of these first
two columns are $11$ and $8$. Dividing by their appropriate powers
of the Frobenius-target parameter gains two and one units,
respectively. Their saturated fiber directions are independent,
with orders one and three. Thus the saturation of $W$ gains exactly
three at infinity.

Every finite cubic branch where its raw fiber rank is at most one
adds at least one determinant unit. The accepted degree-four bound
for all geometric constant planes therefore permits at most one
such branch on $X$. These facts are the exact fixed-net results in
[the first-section plane proof](first_section_contact_strictness.md).
They are not estimates for an arbitrary two-dimensional presentation.

## Nonexceptional branches lie in both actual target divisors

At a nonexceptional finite cubic branch, the original raw three-form
net has rank two and primitive orders $(1,4,7)$. Its image contains
the intrinsic order-four line $F_4$, as established in
[the branch-fiber proof](branch_fiber_uniform_contact_gap.md).
The raw $W$ image already has rank two, so it equals that net image.
It lies in the actual $q^{(1)*}K$ fiber image.

To relate this intrinsic line to the adjunction, choose an étale
local source parameter $s$, with Frobenius-target parameter $s^5$.
Write a local $Q$ generator in primitive classes
$a=\sum_{i=1}^4a_i(s^5)[s^i]$.
The canonical alternating form pairs primitive orders adding to
five. In particular
$\langle[s^4],a\rangle=a_1(0)d(s^5)$ in the target fiber, whereas
the adjunction evaluates to $a_1(0)ds$.
Thus $F_4\subset K$ in this fiber exactly when the adjunction of
$Q$ vanishes at the corresponding point of $Y$.
Saturation makes $K$ a genuine fiber hyperplane, so the equivalence
applies without a lattice-loss correction. The target lies in $R_Q$.

At the same source point the $q_2$ image in $B_T$ is a linear
combination of the two $W$ images. Subtract this combination from
the actual $q_2$ vector in $q^{(1)*}J$. The resulting fiber vector maps
to zero in $B_T$, but has nonzero value $\ell(q_2)$ in the actual
$q^{(1)*}(J/K)$ fiber. It is therefore nonzero in $q^{(1)*}J$ and witnesses
a determinant defect. The corresponding point of $Y_1$ lies in
$D_J$. No original section has been replaced by a generic endpoint
section in this step.

The inverse image of the ten reduced finite branch points under
the actual étale $h:T\to X$ is a reduced divisor of degree $10d$.
At most $d$ of its points lie over the one possible exception.
At least $9d$ distinct points therefore lie over the stated
intersection. A fiber of the actual étale $q$ has exactly $8d$
points, so this intersection must contain at least two distinct
target points. Relative Frobenius identifies underlying supports;
$D_J$ remains a divisor on $Y_1$, and $R_Q$ remains the adjunction
divisor on $Y$.

Finally, if the degree-three pencil $|\omega_{Y_1}Q^{-1}|$ had a base
point $S$, removing it would leave a degree-two line with two
sections. On a genus-two curve that line is $\omega_{Y_1}$.
It would follow that $Q^{-1}=\mathcal O(S)$, contrary to
ineffectivity. Thus in that case the pencil is base-point-free,
and two zeros of the same $\sigma$ are exactly two points in one
fiber of its degree-three map.

## Exact relative comparison and the two-branch conditional exclusion

If $\sigma_0,\sigma_1$ are a basis of the descended pencil, its map
is $[\sigma_0:\sigma_1]:Y_1\to\mathbf P^1$. The pulled ratio defines
the composite with $F_Y$. Relative Frobenius is a universal
homeomorphism and is bijective on the geometric points here.
Consequently equality or inequality of the two projective pencil
values at underlying adjunction points is preserved by pullback.
This comparison uses the **actual horizontal pullback of this
line and these sections**. A different degree-three pencil, or a
comparison inferred from degree, would not suffice.

Suppose the actual inverse $Q^{-1}$ is ineffective and the images of
all distinct points in the support of $R_Q$ under that pencil are
pairwise distinct. The nonzero-$q_1$ branch is impossible by the
support-derived effectivity. In the zero-$q_1$ branch, the original
net supplies $\sigma$ and two distinct adjunction points lying in
its divisor, hence having the same pencil image. This contradicts
the distinct-image assumption. Thus both branches are excluded for
that actual embedded annihilator under the retained antecedents.

No claim is made that the distinct-image condition holds for all
annihilators, that an ineffective inverse is forced, or that $K$
is saturated in the zero-$q_1$ branch. Candidate computations and
their source interpretation belong to their separate producer
record; none is used to prove this generalized theorem.
