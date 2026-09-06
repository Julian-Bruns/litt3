# Characteristic-five destruction: bounded literature comparison

Date: 2026-09-05. Author: `/root/char5_indigenous_destruction_literature_boundary`.
Scope: source comparison for the proved fixed-curve theorem; no global
priority claim and no proposed lifting strategy.

The [fixed-curve result](FINITE_ETALE_COVER_DESTROYS_ALL_ORDINARY_INDIGENOUS_DATA_ON_ONE_CURVE.md)
is an explicit characteristic-five example: one finite étale Galois
2-group cover destroys ordinariness of the pullbacks of all seventy
ordinary nilpotent unmarked indigenous projective bundles on
`X: y²=x⁵−x`. Ordinariness means the induced Frobenius on tangent
cohomology, not ordinary dormant opers.

## Closest checked theorem and the exact proof boundary

Hoshi, [*Nilpotent Admissible Indigenous Bundles via Cartier Operators in
Characteristic Three*](https://www.kurims.kyoto-u.ac.jp/~yuichiro/rims1811revised.pdf),
Corollary 5.4 / Theorem C, already proves individual destruction for
every smooth proper curve of genus at least two in characteristic three.
Its proof trivializes the 2-torsion Hasse defect and dominates a cover
with nonordinary Jacobian. The finite-family fiber-product argument then
gives simultaneous destruction for any finite list: that formal step is
not specific new content of the characteristic-five construction.

The later [*On Indigenous Bundles in Characteristic Three*](https://www.kurims.kyoto-u.ac.jp/~yuichiro/rims1918revised.pdf),
February 2022 version, Theorem 2.4 and Corollary 2.6, extends the
comparison to pointed curves and tame coverings, still in characteristic
three. The proof was checked, especially Claim 2.4.A, pp.9–10:
the kernel quadratic must vanish on the supersingular divisor;
division by the Hasse invariant converts the problem to twisted
one-form Cartier. Theorem 2.4 identifies ordinariness with that of
the Hasse defect; a trivial defect means ordinary Jacobian.

Here is a concrete obstruction to transporting that proof to five
(our deduction). Locally its decisive implication uses
`d²(phi² delta psi)/dt²=0` and a simple zero of `phi` to force
`psi(0)=0`. The corresponding fourth-derivative implication is false:
take `phi=t`, `delta=psi=1`, so `d⁴(t²)/dt⁴=0` despite `psi(0)=1`.
Also the Hasse invariant has weight `(p−1)/2`: weight one at three,
weight two at five. Dividing a quadratic by it no longer gives a
one-form at five. This diagnoses failure of the proof mechanism;
it does not disprove some other general destruction theorem.

The present example gives a stronger concrete boundary to the same
comparison (our computation). Its ten square quartics have trivial
Hasse defect and ordinary indigenous bundles. Yet the curve's
Cartier matrix on ordinary differentials is zero: the relevant
coefficients of `(x⁵−x)²=x¹⁰+3x⁶+x²` at exponents `4,3,9,8` all
vanish. Thus its Jacobian is nonordinary. The trivial-defect
equivalence used in Hoshi's proof is actually false at five.

Raynaud's [*Revêtements des courbes en caractéristique p>0 et
ordinarité*](https://doi.org/10.1023/A:1001840726893), Theorem 2,
supplies a nonordinary-Jacobian finite étale Galois cover of every
genus-at-least-two curve, with solvable prime-to-p group. This theorem
holds at five, but the missing indigenous/Jacobian equivalence prevents
it alone from supplying the desired characteristic-five destruction.

## Structural comparison for preserving covers

Hoshi's characteristic-three criterion supplies actual structural
control through the Jacobian or the Prym attached to the Hasse defect.
This does not transfer verbatim to the present characteristic-five
operator.

There is a nearby representation-theoretic precedent: Borne,
[*A Relative Shafarevich Theorem*](https://arxiv.org/pdf/math/0204088),
§2.5, Definition 2.10 and Lemmas 2.11–2.12 (p.7), decomposes ordinary
Jacobian behavior into tests indexed by simple representations and
compares those tests across normal p-group extensions. The proof of
Lemma 2.11 uses the Galois-module decomposition of regular one-forms;
Lemma 2.12 uses Proposition 2.4. This is a precedent for using simple
monodromy factors, not a theorem about the fixed indigenous quartic.

The repository's [twisted quadratic Cartier criterion](TWISTED_CARTIER_ETALE_COVERS_AND_SIMPLE_MONODROMY_FACTORS.md)
has its own direct proof via exactness of quadratic sections with finite
Frobenius coefficients. It already gives structural control beyond
p-group closures: which simple factors of the sheet permutation module
occur, and which pass the fixed-A test. Its Serre closure does not give
tensor closure or fiber-product closure. The
[D8 example](D8_NONLINEAR_CARTIER_FAILURE_INVISIBLE_ON_QUADRATIC_SUBCOVERS.md)
therefore concerns precisely information that quadratic-character
tests can miss. None of the checked cited theorems makes a conflicting
closure assertion for ordinary indigenous pullbacks.

## Verdict suitable for use

Describe the result as an explicit characteristic-five analogue and
refinement, on one specified curve and with 2-group monodromy, of the
known characteristic-three destruction phenomenon. The substantive
input is the complete seventy-object classification and the explicit
degree-two/degree-four witnesses. Simultaneous destruction follows
formally once these individual witnesses exist.

The checked results do not subsume this characteristic-five statement;
the closest proof has the concrete characteristic-three obstruction
above. A bounded search of Hoshi's relevant papers and the cited
Raynaud/Borne results is not a proof of publication priority or of the
absence of a more general theorem. No claim about all indigenous
bundles upstairs, nonliftability, or existence of a common étale source
follows from this comparison.
