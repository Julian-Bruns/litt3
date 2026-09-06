# What remains after the dormant-oper enumeration

Last updated2026-09-06. The original unmarked common-cover problem is
UNSOLVED. This is a roadmap, not a chain of already-proved exclusions.
Read STATE.md first for the current computation and user instruction.

## What the enumeration actually gives

The number29375 is the scheme length of the rank-two dormant-oper candidates
on the fixed genus-nine X, including multiplicities. It is not a count of
distinct curves, covers, or even necessarily distinct opers. These rank-two
objects exist on every curve; their existence is not an obstruction.

The55 known geometric points have full local length8, accounting for440.
The remaining length28935 is an etale cubic reconstruction of the normalized
F25 algebra of length9645. The current F5 encoding has dimension19290.
References: `fixed_x_dormant_equations`, `fixed_x_oper_cubic_quotient`,
`dormant_rank_two_candidates`.

## 1. Certify and export what the solver found

Read normalized_oper_run.json and the durable log; an exit0 or a nonempty
file is not itself a mathematical certificate. Use

    sage scripts/export_oper_basis.sage --normalized

to convert the coefficient field, check the original equations and exact
length9645, and checkpoint the basis. Then implement the still-missing
closed-point extraction and full local multiplicities. Reconstruct all
three roots t^3=Lambda, C=t*Chat, A=t^2*Ahat, with the recovered B. Preserve
all55 earlier points and verify total multiplicity29375. Use closed-point
orbits and explicit residue fields; do not repeatedly expand conjugates
into unrelated giant fields. Distinct reduced points, not nilpotent copies,
are the candidates for the next existence test.

`finite_algebra_completion_certificates` now supplies precise completeness
and postprocessing criteria. Three25-power Frobenius iterations suffice to
isolate the reduced subalgebra; equality of consecutive ranks can stop
earlier. Retain the full algebra to recover multiplicities. Neither the
Frobenius matrices nor the current leading-monomial stopping certificate
have been implemented/extracted for the ongoing solve.

## 2. Solve the actual rank-three atlas obstruction

For EACH geometric oper r, `scalar_hermitian_reconstruction` gives an exact
test for an atlas X->[H/PSU_3(5)], where H is the genus-ten Hermitian curve.
It is necessary to prove nonexistence for ALL allowed quotient maps p,
not just sample a few p or compute their generic rank.

The still-needed implementation is: construct the verified horizontal
frame H and local frame G, then Pi, Sigma, eta and T0. Impose the global
surjectivity certificates ps=1 and the nonzero local component on one of
the two charts at O. Set lambda_*=-rho32(delta eta), and solve/exclude the
remaining56 equations. There are32 genuine quotient-map coordinates;
the66 s-coordinates certify a splitting, not a list of discrete candidates.
There are no40 extension variables or ten identification variables left.

Use `semilinear_hermitian_lift` and the scalar theorem rather than restoring
Pro's older96-equation system. Existing scalar_residual_rank.sage tests
the rank/retraction identities; its16 samples are NOT atlas solutions and
do NOT exclude the remaining equations. Reuse cubic symmetries and finite-
field conjugacy, but justify any further grouping or shared elimination.

Success condition for exclusion: a certified empty solution set over the
algebraic closure for every r and both scalar charts, including nongeneric
quotient strata. Alternatively a structural theorem may exclude all these
tests simultaneously. A solution instead reconstructs a genuine atlas;
it defeats this particular non-atlas obstruction. It does not by itself
prove that the fixed genus25 Y shares a cover with X.

## 3. The other large Hermitian case is not yet covered by that computation

The other large case is X->[H/PGU_3(5)]. The full criterion includes
tau in Pic(X)[3], with3^18 geometric torsion-line classes. The scalar test
implemented above treats tau=O only. The general differential retraction
works for nontrivial tau, but its explicit scalar reconstruction has not
been completed for those twists.

The SAME rank-two oper list can be reused: for fixed theta,
V=W tensor(theta tensor tau^2). New torsion choices are not new independent
rank-two enumerations. They do change the remaining rank-three obstruction.
Seek a structural treatment or justified orbit reduction rather than
assuming every torsion class needs an unrelated brute-force run.
References: `hermitian_atlas_extension_criterion`,
`dormant_rank_two_candidates`, `semilinear_hermitian_lift`.

Even excluding BOTH large stacks only closes the large cored branch.
Do not conclude that every H-commensurable curve is an atlas of these stacks.

## 4. The smaller cored cases remain

A cored span has the actual effective common orbifold supplied by
`cored_orbifold_bridge`. For the fixed X, the complete signature proof in
`fixed_x_orbifold_bound` gives either deg(X/S)<=2240 or the two large
degrees112000 and336000. No theorem here excludes all small cases.

These must still be ruled out for the selected endpoints, using actual
atlas/correspondence conditions, or treated by a stronger theorem covering
them together. Boundedness is not nonexistence. One may use the genus25 Y
and its proved arithmetic properties, but must establish their connection
to both actual etale maps. A different endpoint could be chosen if justified;
that is a new target choice, not an automatic consequence of the enumeration.

## 5. The coreless branch is a separate major gap

An arbitrary common cover need not have a core or a simultaneous Galois
refinement. The oper enumeration does not cover this branch.
The proved shared-one-form intersection is zero for a coreless span with X.
Its full shared canonical ring is either k or k[s]; nonconstant s is NOT
known to exist. Conditional constraints on such an s do not exclude the
k case. References: `fixed_x_orbifold_bound`, `canonical_intersection`,
`cartier_generator` and the parameterized tensor statements they reference.

Needed: an independent obstruction preserving both etale maps from the
SAME source, or a valid theorem forcing this putative span into a branch
already excluded. Do not resurrect universal Tango-preservation implies
core, arbitrary simultaneous lifting/Galois closure, or ordinarity as a
commensurability obstruction; actual counterexamples defeated those routes.

## Final stopping condition

A counterexample is proved only when every possible actual finite etale
span between a specified pair has been excluded: BOTH all cored possibilities
and all coreless ones. Completing29375 multiplicities, or even excluding
all untwisted Hermitian atlases, is a meaningful intermediate achievement,
not that final conclusion. There is no defensible percentage-to-proof.

## Recent mathematical tools worth preserving

- `finite_algebra_completion_certificates`: audited exact stopping,
  Frobenius radical extraction, and local/global completeness criteria.
- `dormant_first_integral_charts`: explicit field-level solution of
  r''=3r^2 and a uniform partial-fraction proof that D^4r!=0 throughout
  the degree-ten trigonal potential family. The fixed-X first-integral
  map has affine rank17. Translating the field chart into a smaller
  scheme-equivalent GLOBAL search is still open; do not lose multiplicities.
- A12-variable triangular-coordinate probe succeeded algebraically but
  expanded to42 equations of maximum degree22 and242362 terms, versus
  current14 variables/maxdegree16/39368 terms. No speed advantage was
  established, and it was NOT substituted for the active solver. See
  TRIANGULAR_COORDINATE_PROBE.md only if revisiting representation choices.

Do not reopen audit bodies absent a concrete doubt. For the reproduced Sage
rational-function zero-test bug, use numerator-based tests; the prior
polynomial/Laurent certificates were not found affected.
