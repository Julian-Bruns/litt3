# Descend an atlas frame by the cubic grading, without extracting a cube root

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
not the atlas obstruction. H is invertible at orbit0011; no claim that
it is invertible at every other oper is made.

Status: author proof,2026-09-07; no independent audit claimed. The grading
of a32-square Q minor is checked exactly against the saved first-oper
matrix. The orbit11 minor and universal constant elimination are verified
exactly; see the proof and orbit11 structure note for the bounded tests.
[Proof](../Solutions/Sol_oper_deck_graded_atlas.md).
