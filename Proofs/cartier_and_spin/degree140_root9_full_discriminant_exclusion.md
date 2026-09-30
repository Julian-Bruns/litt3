# Proof: the simple companion and the full discriminant

The exact ratio atlas and localizations are those in
[the statement](../../Theorems/cartier_and_spin/degree140_root9_full_discriminant_exclusion.md).
The [companion model](degree140_root9_companion_discriminant.md) retains
both sheets of xi^2=C(q), with C=c^2-3be and
u=e(c+3xi)/(c^2-4be). Its previously proved boundary exclusions
license b,e,C,c^2-4be on J=0, with no loss of nilpotents.

## The actual residual and all additional boundaries

The received companion calculation reconstructs the original204-by156
linear system, its rank150 affine solution, the exact Cramer graph,
the actual fixed-(10,2) critical resultant and its cubic source norm.
No squareness transfer from the repeated-root model is used.
The first three normalized square tails C71,C72,C73 are actual
members of I and have scale degrees53,54,54 on this companion.

The leading coefficient of C72 can vanish at six values of
s=F6/h^3. Each value gives a squarefree degree24 q-polynomial.
Six finite-algebra certificates exclude its selected companion sheet;
six more exclude the opposite sheet above the same q-values. A
thirteenth excludes the originally allowed sheet above the norm-of-s
boundary. These are312 allowed ratios over168 whole q-fibres, with
arbitrary scale, not finite-field scale tests. Four additional identities
exclude both sheets above q=1 and q=2. Every identity is a polynomial
linear combination of actual tails equal to1.

Consequently the extra q-polynomials used in the computation are
units modulo I on J=0. In particular, inverting s alone would not
justify clearing its quadratic norm; the opposite sheet was checked.

## Global ideal membership and the unit witness

Form the fixed-degree Sylvester resultants in the scale variable
\[
R_{12}=\operatorname{Res}_{(53,54)}(C71,C72),\qquad
R_{13}=\operatorname{Res}_{(53,54)}(C71,C73).
\]
Their adjugate identities place them in I even when a leading
coefficient drops. Multiplication by the quadratic conjugate places
each full norm in I as well; this does not require the two sheet
residuals to agree.

Exact coefficient valuations and44 integer assignment duals bound
their poles and infinity order. Clear only the proved-unit poles.
The resulting polynomials P12,P13 in K[q] have degrees1153010 and
1167742. Complete order-three Hermite reconstruction at all390624
nonzero elements of K determines these global polynomials. At eight
pole or branch nodes, multiplication by E0^3, deg E0=8, supplies
three zero jets. The proved bounds put the augmented polynomials
below degree3*390624, so the reconstruction is an identity over K[q],
not a restriction of unknown parameters to K.

The retained complete coefficient rows satisfy
\[
U(P12/D12)+V(P13/D13)=1.
\]
Here D12,D13 are products of separately licensed factors, of degrees
522 and362. The reduced polynomials have degrees1152488 and1167380;
U,V have degrees1167379 and1152487. Every division is exact. A direct
full polynomial multiplication checks the displayed identity without
relying on the half-gcd constructor. Its right side has no residual
factor needing a further boundary test.

All newly inverted factors are already units in the original square
quotient. Thus the unit identity in the enhanced localization proves
that the original companion square quotient is zero. This argument
retains nilpotents and every geometric residue field.

## Consequence for the whole cubic

On f(u)=0, with u invertible, put g=bu^2+2cu+3e. The exact identity
\[
\operatorname{Disc}_U f=g^2J/u^6
\]
holds also when the affine leading coefficient vanishes: it is the
discriminant of the homogeneous degree-three form. The selected-root
theorem makes g a unit modulo the unrestricted square ideal; the
companion decision makes J a unit there. Their product is a unit,
proving the assertion. Neither argument asserts that all three roots
yield the same residual, or that any square supplies an actual cover.

## Reproducibility

The original received proof,135-file manifest, binary witness, exact
data and execution evidence are preserved in
[the external archive directory](../../../litt3-computation-data/companion140_reply_20260928/companion140/).
The43 source files are preserved byte for byte in
[the source directory](../../scripts/arithmetic/pro_companion140_20260928/src/).
[The integration audit](../../Research/audits/COMPANION140_2026_09_28.md)
distinguishes the received full computation from the local checks and
records the source, boundary, tail, bound and coefficient-identity replays.
