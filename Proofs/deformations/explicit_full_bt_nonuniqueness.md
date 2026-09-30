# Proof: a global periodic tower produces a non-descending full group

[Statement](../../Theorems/deformations/explicit_full_bt_nonuniqueness.md).
21 September2026. A focused independent
[audit passed](../../Research/audits/FULL_BT_NONUNIQUENESS_AUDIT_2026_09_21.md),
including the pairwise non-isogeny consequence. The old numerical and higher-Witt results are accepted
inputs, not replayed. The new steps are actual integral effectivity and
retention of the first marking and the nonzero second-level difference.

## 1. A supplied global tower has global group effectivity

Start with an actual compatible full periodic filtered tower of weights
$0,1$ on a smooth proper formal lift. Its projective version carries the
specified flat two-torsion periodicity line $\kappa$. Taking its
compatible limit gives a projective filtered crystal $\mathcal P$ and
an ACTUAL projective renormalized-Frobenius comparison
\[
\operatorname{RF}(\mathcal P)\simeq\mathcal P.
\]
At finite precision this uses the next curve digit and the previous
filtered tuple, exactly as in the supplied inverse-Cartier construction.
The full compatible tower supplies those extra digits at every stage;
the retained graded identifications make the comparisons compatible.
Thus no periodicity is inferred from separate nonempty finite lifting
spaces or from the projective special fiber alone.

A determinant-trivial spin lift exists with the specified reduction:
its central kernel is
etale $\mu_2$, so its fixed special-fiber lift extends through every
nilpotent thickening, and the compatible choices extend formally. The
Lie algebra map is an isomorphism, so the connection and its crystalline
comparisons lift along with it. The Hodge line is the lifted Borel
reduction. This is the same central argument used in
[ordinary effectivity](ordinary_oper_bt_effectivity.md); ordinariness
there supplies the global tower, not this effectivity step.

Write $\mathcal E$ for that spin lift. The preceding projective
comparison gives a flat line $\mathcal Q$ with
\[
\operatorname{RF}(\mathcal E)\simeq\mathcal E\otimes\mathcal Q,
\qquad \mathcal Q^2\simeq\mathcal O.
\]
Here the renormalized determinant uses the canonical displayed factor
five in the elementary lattice, as in ordinary effectivity. Reduction
of this comparison is the SUPPLIED first periodic datum, so
$\mathcal Q\bmod5=\kappa$. Prime-to-five torsion lifts uniquely
through the marked nilpotent thickenings. Hence $\mathcal Q$ is the
fixed formal lift of that SAME $\kappa$; no new two-torsion discrepancy
can appear at a later level.

Choose the prescribed flat line $N$ with $N^4=\kappa$, $N^8=\mathcal O$,
and lift it as $\mathcal N$ through the formal tower. The compatible
trivializations lift as well, so $\mathcal N^4=\mathcal Q$ and
$\mathcal N^8=\mathcal O$. Crystalline Frobenius sends this finite
flat line to $\mathcal N^5$. Thus
\[
\operatorname{RF}(\mathcal E\otimes\mathcal N)
\simeq\mathcal E\otimes\mathcal Q\otimes\mathcal N^5
\simeq\mathcal E\otimes\mathcal N.
\]
The horizontal comparison can be chosen to reduce to the fixed first
one; the residual scalar is a constant unit and is chosen compatibly.
This retains the specified first periodic datum and determinant $N^2$, exactly as in
[first-level effectivity](admissible_periodic_bt_effectivity.md).

In a normal decomposition the FULL one-periodic datum now gives
strongly divisible windows
\[
F=U\operatorname{diag}(1,5),\qquad
V=\operatorname{diag}(5,1)U^{-1},\qquad FV=VF=5,
\]
with the actual divided crystalline Taylor comparisons. They are
compatible at every precision because the supplied tower is compatible,
not merely nonempty at each finite height. Integral Dieudonne effectivity
gives full groups locally. On overlaps ALL their crystal levels agree,
so full faithfulness and effective finite-Hopf descent glue ALL finite
truncations and their inclusions. Their compatible union is an actual
full $5$-divisible group on the original characteristic-five curve.

The determinant comparison may be normalized with the fixed finite
character. Equivalently, twist by the unique inverse square root of
its rank-one etale character congruent to one modulo five. This leaves
the first truncation and the projective filtered tower unchanged. The
same normalization is used for the ordinary reference. No global
effectivity is being deduced from a single uncompleted BT1 or BT2.

## 2. Apply this only to the existing actual rank125 tower

The [audited all-height theorem](elementary_covers/rank125_all_heights.md)
provides a compatible GLOBAL formal projective tower over $W(\mathbf
F_{125})$, with the specified first periodic datum pulled back through
the ORIGINAL $q:T\to C$, where $C$ is the genus-three etale double
of the ordinary genus-two curve $Y$. Put $h=\pi q$, of degree250;
$g(T)=251$. Its third source is $T_3(H^\dagger)$ and its
fourth source is the fixed value $\tau=[105]$. The stabilization in
that theorem preserves every lower truncation in the resulting tower.

Use the correction $h^*N_Y$, where $N_Y$ is a permitted fourth root
for the ordinary endpoint. The preceding construction supplies an
actual normalized full group $G_T/T$. Its first truncation realizes
the identical corrected first periodic crystal as $h^*G_Y[5]$.
Full faithfulness between these existing finite flat groups gives the
specified actual BT1 marking. Its Hodge line and Kodaira--Spencer map
are those of that first datum, so versality and the simple supersingular
divisor persist. No claim that the chosen fourth root is already
defined over $\mathbf F_{125}$ is required.

## 3. Its actual BT2 differs from the pulled-back one

The [actual torsor comparison](bt_hodge_obstruction_comparison.md)
is an isomorphism between higher-Hodge solutions retaining this FIRST
periodic datum and normalized marked BT2 extensions. Locally its
difference is the invertible map
\[
2\mathscr D_H^{-1}\overline{\mathfrak b}_r:
F_*T/\mu(T)\xrightarrow{\sim}\mathcal B_H.
\]
It therefore detects differences of actual global solutions, not only
whether their obstruction classes vanish.

The pulled-back $h^*G_Y[25]$ corresponds to the actual canonical
reference third curve $T_3^0$. The second truncation of the just
constructed $G_T$ corresponds to $T_3(H^\dagger)$, because its local
completions are the given global tower itself. They cannot be the same
higher-Hodge solution: the latter admits NO lift of the original map
$q$ to ANY third endpoint above the fixed $C_2$, whereas the former
does. A marked isomorphism between those source curves would transport
the reference lifted map and contradict that audited non-descent.

Thus their actual normalized marked BT2 groups are different. This
uses the object-level torsor map, not merely the identity
$J(e(H))=2\epsilon$: both obstruction classes vanish on $T$.

## 4. No marked descent, including determinant twists

If the normalized marked $G_T[25]$ descended along $q$, its descended
BT2 would correspond to a higher-Hodge solution on $C$, retaining
the specified first datum. Functoriality of the torsor comparison
would identify its pullback with the solution having source
$T_3(H^\dagger)$. That supplies a lift of the ORIGINAL $q$ from
this third curve to the resulting $C_3$, contradicting the audited
non-descent to ANY such $C_3$. This argument needs no indigenous
ordinariness of $C$, which has genus three.

Descent along $h=\pi q$ would imply descent along $q$ and is therefore
also impossible. Alternatively, indigenous ordinariness on $Y$ gives
uniqueness of its normalized BT2, $G_Y[25]$, so Section3 already
excludes marked descent directly to $Y$.

Allow an unnormalized descended BT2 $A_C$ along $q$ instead. Its determinant
differs from the Teichmuller character by an etale rank-one character
$\chi\equiv1\pmod5$. Since $q^*A_C$ has normalized determinant,
$q^*\chi=1$. The allowed scalar twist normalizing $A_C$ is therefore
trivial after pullback. Its normalized pullback is still the SAME
marked $G_T[25]$, again a contradiction. The identical argument rules
out a full descended group, or simply restrict it to BT2 first.

## 5. At least five exotic full extensions

The deck group $D=C_5^3$ acts on marked full extensions of
$H_T=q^*(\pi^*G_Y[5])$ and on their second truncations. The actual difference
map to higher-Hodge source choices is equivariant, since every part
of its construction commutes with the original etale maps.

The old non-descent calculation is stronger than nonzero displacement:
$H^\dagger$ is NOT $D$-invariant. Its degree-five pivots are
$(0,[101],[14],0)$, whereas every invariant in the original regular
module is in the degree-twelve norm line $k\nu_{42}$.
Thus the orbit of this actual BT2, and hence of $G_T$, has size
at least five. The canonical pulled-back extension is deck invariant
and is outside that orbit. This gives at least six distinct full
extensions with identical first truncation and specified determinant.

## 6. The groups are already distinct up to isogeny

Their common BT1 connection has degree zero and a positive Hodge line
$L$, with nonzero second fundamental form. Every horizontal line is
distinct from $L$ and maps nontrivially to its negative-degree quotient.
It has negative degree. Thus the common reduction is stable as a
connection, even though its underlying bundle is unstable.

Suppose two of the displayed full groups were isogenous. Evaluate their
crystals on the same smooth proper formal lift of $T$. Multiply the
rational crystalline isomorphism by a power of five to make it integral
and primitive. Quasi-compactness gives a common denominator and a
largest power dividing an integral map, so its reduction is a nonzero
horizontal map. A rank-one image is impossible: its horizontal kernel
in the degree-zero source has negative degree, making the image positive,
while its saturation in the target is a negative-degree horizontal line.
A rank-two map has a nonzero determinant between degree-zero lines and
therefore no zero. Thus the reduction is an isomorphism. Nakayama then
makes the full integral crystal comparison an isomorphism; full
faithfulness gives an actual full group isomorphism.

Its action on the specified BT1 is a scalar in $\mathbf F_5^\times$,
by the established generic endomorphism theorem for this versal ordinary
BT1. Correct it by its Teichmuller scalar lift. The remaining determinant
is a constant in $1+5\mathbf Z_5$; its inverse square root removes it
without changing the BT1 marking. This gives a normalized marked
isomorphism of the full groups, contradicting the already distinct BT2
classes. They are therefore pairwise non-isogenous.

This is a proper-curve and full-group strengthening of the previous
marked laboratory, but remains a one-map statement. It does not
evaluate the residual comparison when the PRESCRIBED upper full group
comes from the ordinary genus-two endpoint of an arbitrary second map.
