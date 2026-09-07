# What remains after the dormant-oper enumeration

Last updated2026-09-07. The original unmarked common-cover problem is
UNSOLVED. This is a roadmap, not a chain of already-proved exclusions.
Read STATE.md first for the current computation and user instruction.

## What the enumeration actually gives

The number29375 is the scheme length of the rank-two dormant-oper candidates
on the fixed genus-nine X, including multiplicities. The complete census
has28990 distinct opers, not that many curves or covers. These rank-two
objects exist on every curve; their existence is not an obstruction.

The55 known geometric points have full local length8, accounting for440.
The remaining length28935 is an etale cubic reconstruction of the normalized
F25 algebra of length9645. The current F5 encoding has dimension19290.
References: `fixed_x_dormant_equations`, `fixed_x_oper_cubic_quotient`,
`dormant_rank_two_candidates`.

## 1. Certification and full export — COMPLETED

Read normalized_oper_run.json and the durable log; an exit0 or a nonempty
file is not itself a mathematical certificate. Use

    sage scripts/export_oper_basis.sage --normalized

to reproduce the completed small certificate and export, without importing
the4.5GB raw basis. All original equations, separator and known length
certify a squarefree polynomial algebra; an independent43-input check passed.
All28990 distinct points are exported with multiplicities in
computations/complete_oper_solutions.json. Its README defines the exact
root and Frobenius-orbit conventions. The55 earlier points have multiplicity8;
the other28935 points have multiplicity1. Total29375 is verified.
Reference: `fixed_x_oper_enumeration` and its fresh major-chunk audit.

Frobenius and the actual cubic deck symmetry reduce the next UNTWISTED
test to18 representatives:12 new closed points and6 invariant ones.
Each still retains every possible quotient direction. The normalized
algebra's12 F25 residue degrees sum to9645; the three cubic branches
are distinct and all have multiplicity1.

## 2. Solve the actual rank-three atlas obstruction

For EACH geometric oper r, `scalar_hermitian_reconstruction` gives an exact
test for an atlas X->[H/PSU_3(5)], where H is the genus-ten Hermitian curve.
It is necessary to prove nonexistence for ALL allowed quotient maps p,
not just sample a few p or compute their generic rank.

The implemented `direct_wronskian_atlas` theorem replaces auxiliary frames
by polynomial horizontal solutions U in S_U (dimension32) and T in S_T
(dimension66), with Wronskian1 and pole U111/112. Its audited Cartier
normalization gives eta and lambda=-rho32(delta eta), with sharper pole197.
The subsequent `wronskian_matrix_pencil` theorem removes T altogether:

    T=-aff(U eta^5),  eta in P48 (dimension56),
    N_U eta^[5]=0,  Wronskian(U,T)=1,  R_U eta^[5]=eta.

N_U is136x56, R_U is56x56, and BOTH are linear in U. For every admissible
U, N_U has rank55. Some scale of a projective direction works precisely
when [N_U;N_U^[1/5]R_U] still has rank55 and R_U does not kill its kernel.
This is an exact structural test; all quotient directions remain.

Two subsequent uniform reductions are now available. The cup-product
theorem `rank_two_extension_pencil` replaces136 rows by64 and gives a
primitive degree46 kernel vector. The audited `dormant_differential_projection`
puts every possible eta in J_r=Ann ker(Q_r:L64->S_U), dimension32, for
EVERY oper. Here Q_r=delta^3+Pdelta+3(delta P) and the bounded global Q_r
is onto. The first complete-oper tensor test stabilizes at exactly J_r.
This is a necessary linear restriction, not an exclusion.

The audited `resultant_gradient_atlas` identifies the remaining output
with minus the gradient of the reduced degree48 resultant. The audited
`compact_etale_atlas_system` now gives an exact97-equation system in64
variables:64 N equations,32 R equations, and U.beta=2. It automatically
retains all valid quotients and removes invalid ones, including at infinity.
Its solution scheme is finite and reduced, possibly empty. Full tensors for
the first new oper are exported; no entire candidate is excluded yet.
The audited `cohomological_bezout` replaces expansion of the degree48
resultant by24x24 quadratic matrices for acyclic V=W(8O), or27x27 mixed
matrices for the55 exceptional opers. It proves exact rank loss on all
zero strata. The author `inverse_cup_atlas_system` gives a structured
all-chart matrix-inverse/gradient system and explains a large invalid
boundary family in the weaker N equations. Do not invert its polar
matrix H without retaining singular charts: an exact test disproves
that shortcut even when the cup matrix is invertible.

Do not restore Pro's96-equation system or repeat the discarded auxiliary
frame search. Exact matrix/direct sample tests agree, but samples do NOT
exclude whole families. One whole projective line HAS been excluded by
exact polynomial-kernel/Bezout identities, retaining its exceptional values
and infinity. The next task is the full nonlinear incidence inside the
reduced U32/eta32 spaces. A degree-one Wronskian syzygy and a fixed bilinear
symmetry shortcut failed exact tests; witnesses are recorded in STATE.md.
Excluding one line alone is not a global exclusion.

The small actual genus-two atlas test is now completely solved and audited:
`genus_two_atlas_dynamics` gives33 reduced normalized solutions via a
degree-eleven fixed-point equation and exact original-ideal reductions.
Its constant-annihilator shortcut cannot transfer to large genus:
`cartier_jet_tensor_surjectivity` proves full tensor rank for EVERY intrinsic
oper when g−1>=p. Moreover, `acyclic_atlas_towers` gives actual atlas curves
in unbounded genus with both full tensor rank and H0(V)=0. These are robust
limitations, not additional exclusions. The genus-nine next test uses
nonlinear identities: all576 inverse-cup matrix equations now have explicit
coefficient-verified original-ideal certificates. See
INVERSE_CUP_SEED_CERTIFICATE.md and STATE.md for the bounded next calculation.

Success condition for exclusion: a certified empty solution set over the
algebraic closure for every r and both scalar charts, including nongeneric
quotient strata. Alternatively a structural theorem may exclude all these
tests simultaneously. A solution instead reconstructs a genuine atlas;
it defeats this particular non-atlas obstruction. It does not by itself
prove that the fixed genus25 Y shares a cover with X.

## 3. The other large Hermitian case is not yet covered by that computation

The other large case is X->[H/PGU_3(5)]. The full criterion includes
tau in Pic(X)[3], with3^18 geometric torsion-line classes. The scalar
coefficient file implemented above treats tau=O only.

The independently audited `intrinsic_atlas_incidence` now gives a complete
uniform97-equation criterion in64 variables for EVERY tau and oper:
I alpha=p*D(alpha), ell(p,alpha)=1, with alpha in Ext1(V,O),
p in Hom(V,M). Its specified cohomological maps use actual dual Frobenius.
The extension-morphism proof includes nonsingularity, all bad quotient
strata, and finite/reducedness. This closes the earlier formulation gap
without globalizing the cumbersome scalar R formula. It has NOT proved
emptiness or computed coefficient tensors for all tau.

The author-proved `theta_open_atlas_projection` further handles every
acyclic V by an exact projective elimination: on the24x24 cup-determinant
open in P31, the full96x32 pullback matrix is everywhere injective and
recovers p uniquely. The remaining zero scheme is a section of a rank64
quotient bundle. This is not a proof of emptiness, a single square-pivot
chart, or a reduction for nonacyclic V.

The author-proved `twisted_bol_complex` now supplies the intrinsic
order-two/order-three exact complex and the32-dimensional dual space
for EVERY torsion class. The general small Bezout matrix also applies,
though it need not be symmetric. The intrinsic criterion above now
supplies actual compatibility independently. A twisted gradient formula
or scalar basis comparison is optional further structure, not a missing
condition silently assumed in that theorem.

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

New audited boundary tests (2026-09-07):
`bolza_prime_to_five_coreless_neighborhood` constructs coreless common
covers throughout the prime-to-five commensurability class of the
superspecial genus-two seed, including H. `cubic_genus_two_common_covers`
adds an ordinary genus-two endpoint to that class. Both closures can
still have prime-to-five order. Separately `picard_simple_common_cover`
gives two absolutely simple Hom-zero genus-three Jacobians with an
actual cored cubic etale common cover (both endpoints nonordinary).
The strengthened `ordinary_simple_common_cover` gives BOTH absolutely
simple genus-four Jacobians with p-ranks2/4, geometric Hom-zero and
actual two Galois etale cubic legs. Even adding an ordinary endpoint
therefore does not rescue a general Jacobian-only exclusion.
`hermitian_oper_noninvariance` disproves shared natural Hermitian-oper
compatibility even for cored spans with both legs Galois. These examples
do not settle the fixed pair; use their exact scopes when testing any
proposed additional hypothesis.

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
