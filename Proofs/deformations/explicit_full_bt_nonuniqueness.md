# Proof: a global periodic tower produces a non-descending full group

[Statement](../../Theorems/deformations/explicit_full_bt_nonuniqueness.md).
21 September2026. A focused independent
[audit passed](../../Research/audits/FULL_BT_NONUNIQUENESS_AUDIT_2026_09_21.md),
including the pairwise non-isogeny consequence. The old numerical and higher-Witt results are accepted
inputs, not replayed. The new steps are actual integral effectivity and
retention of the first marking and the nonzero second-level difference.

## 1. Use the effectivity of a supplied global tower

The [periodic effectivity theorem](admissible_periodic_bt_effectivity.md)
now includes the general full-tower construction. It applies to an
ACTUAL compatible global projective filtered tower, retaining the
first periodic datum and lifting the chosen fourth-root correction.
Its integral lattice construction uses no indigenous ordinariness.
It gives actual normalized full groups on the original curve; it
does not infer a full tower from unrelated nonempty finite fibers.

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

The [actual torsor comparison](all_height_bt_hodge_dictionary.md)
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

The common BT1 evaluation is a degree-zero rank-two oper.
The [crystalline lattice-rigidity lemma](crystalline_oper_lifting.md#rigidity-of-the-integral-lattice)
therefore rescales any supplied rational comparison of two displayed
groups to an integral crystal isomorphism. Multiplication by a power
of five preserves its $F,V$ identities, and full faithfulness gives
an actual full group isomorphism.

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
