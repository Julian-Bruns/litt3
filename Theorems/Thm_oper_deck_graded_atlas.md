# Descend an atlas frame by the cubic grading, without extracting a cube root

Version2,2026-09-09: the same fixed frame is now certified on ALL twelve
noninvariant representatives of the completed census, not only orbit0011.
No atlas exclusion or treatment of the six exceptional representatives is
asserted by this extension. Verification remains author proof plus exact
computational certificates, not an independent prose audit or Lean proof.

Work on the fixed curve y^3=F(x) over F25. On the noninvariant oper locus
write c4=t, t^3=lambda, A=t^2 Ahat, C=t Chat, as in
`fixed_x_oper_cubic_quotient`. Here t is an OPER coefficient, not the local
uniformizer. Let zeta be a primitive cube root of unity and let
sigma(x,y)=(x,zeta*y). Then the following is an exact action on normalized
scalar atlas data:

    t -> zeta*t,      U -> sigma(U),      eta -> zeta*sigma(eta).       (1)

It preserves the original N and R equations, the Wronskian1, and the
compact normalization. This includes the fixed local extension data;
it is not obtained by reusing monic-curve formulas on a different curve.

Let M(t) be Q:L64->L112 in the original monomial bases. If the y exponents
of its input and output monomials are j_i and k_r, respectively, then

    M(t)=diag(t^k_r) Mhat diag(t^-j_i),                    (2)

where Mhat is defined over the normalized field K=F25(Ahat,Chat,B,lambda).
Its entries are polynomial in these coordinates, with no lambda inverse.
In particular any32-square minor satisfies

    det M(t)[J,I] = t^(sum k_J-sum j_I) det Mhat[J,I].       (3)

Thus testing this minor over K selects a valid Q frame simultaneously for
all three cubic branches. No root of lambda is needed for the test.

For a frame with nonzero minor, use v,b as in `acyclic_alternating_atlas`.
The substitutions

    v_i=t^j_i vhat_i,             b_l=t^-k_l bhat_l         (4)

descend the whole atlas system to K. For an acyclic oper its97 equations
can be computed by the ORIGINAL fixed-curve residue operators over F25:
substitute (4), reduce coefficient powers using t^3=lambda, and remove
the one common power of t in each equation. The normalization becomes

    bhat^T Ghat vhat=2.

The descended scheme becomes the original chosen-oper scheme after
adjoining a root of lambda. It has the same geometric atlas solutions
under this explicit coordinate identification. No new quotient direction,
boundary stratum, or Frobenius condition is discarded.

This descent does NOT imply a smaller normalized residue degree. For
orbit_0011 that degree is7324 over F25 and lambda is already a cube.
It removes the need to COMPUTE a cube root and to repeat field-dependent
kernel constructions; it does not exclude the orbit or make its field
degree smaller.

For orbit0011 the chosen frame is now CONCRETE: an exact32-square minor
has determinant norm1 over F25. Universally over the23 normalized
coordinates Ahat,Chat,B,lambda, that same minor has26 constant pivots
and determinant -det H for an explicit6-square polynomial matrix H.
The entries of H have degree at most9. This is a frame-selection test,
not the atlas obstruction.

The SAME minor is invertible on the entire completed noninvariant census,
hence for all twelve representatives and all their Frobenius and cubic-
deck conjugates. In monomial ordering by pole order, its zero-indexed
column list is

    I=(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,16,17,18,
       21,22,26,27,31,32,36,37,41,42,46,47,51,52).

The row list J is the high-pole list in descending order from112 to36,
retaining precisely orders congruent to1 or2 modulo5.
An exact polynomial identity d(T)e(T)+P(T)f(T)=1 certifies invertibility,
where P is the19290-degree F5 census polynomial and d is this normalized
minor's determinant modulo P. The coefficient lists are in the
[compact certificate](../Research/computations/uniform_q_frame_certificate.json).
This removes representative-by-representative frame selection in the
inverse-free construction for the twelve noninvariant representatives.
It does not bound later elimination complexity.

Status: author proof,extended2026-09-09; no independent audit claimed. The grading
of a32-square Q minor is checked exactly against the saved first-oper
matrix. The orbit11 minor and universal constant elimination are verified
exactly. The whole-census determinant was computed by two distinct exact
algorithms and its polynomial Bezout identity replayed. See the proof.
[Proof](../Solutions/Sol_oper_deck_graded_atlas.md).
