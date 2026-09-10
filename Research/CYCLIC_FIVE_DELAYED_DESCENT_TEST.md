# Local test behind the next Pro question

2026-09-10. OPEN geometric target. No new common-cover exclusion.

The next proposed lemma is (D5) in
[the prompt](PRO_CYCLIC_FIVE_DELAYED_DESCENT_REQUEST.md): across the
actual cyclic5 cover T→C with defect2, compatibility two Witt levels
up forces the intervening curve to descend along the original map.
This goes beyond trace and beyond the already excluded defect1 branch.

## What has actually been tested

1. scripts/bad_double_cyclic5_defect.sage constructs actual unramified
   Artin--Schreier covers of the original genus2 Y, then computes the
   anti-invariant tangent cohomology on T=C×_Y Y_1. In the frame
   kappa*eta^-1 the affine scalar module is k[u]+(v/(u(u-3)))*k[u],
   and the lattice at infinity is z^4, z=u²/v. Every nonpositive
   Laurent order is removable; the three cohomology classes are z,z²,z³.
   The Psi multiplier is A*(u(u-3))². This realizes the actual pulled
   square-Hasse map before taking cohomology.

   The five AS basis vectors and their triangular gluing give a
   complete15x15 matrix. At the F625 parameter, the first cover has
   defect2; semilinear iterate ranks13,11,10,10,10 and deck-fixed
   kernel dimension1. The invariant15-dimensional block is bijective
   by the five-group vanishing theorem applied to ordinary (Y,r).
   Thus the full V_T has ranks28,26,25,25,..., with g(T)=11.
   Precision160 replay took11.09s, one CPU process. The first run
   stopped before this calculation because Sage integers needed an
   explicit int conversion for JSON; fixed, not a mathematical failure.
   Precision180 replay is also COMPLETE, in12.60s. The two receipts
   agree on every matrix, deck action, gluing shift and rank result,
   not just the final defect. This is a separate truncation check,
   not a geometric audit. Receipts:
   computations/bad_double_cyclic5_defect.json and
   computations/bad_double_cyclic5_defect_precision180.json.

2. scripts/verify_cyclic5_integral_carry.py proves the finite integer
   identities directly, with no Sage dependency. In W[C5],

       e^5=-5e-10e²-10e³-5e^4,
       N=5+10e+10e²+5e³+e^4.

   Dividing the exact first-step residual by5 and reducing modulo e²
   gives -eta*(1+2e)-d^5e, with determinant1 on (eta,d^5).
   All possible 5B(e) scalar perturbations vanish on e²,e³,e^4 in
   that quotient. Hence a genuine compatible geometric identification
   would force both the lower obstruction and the new kernel direction
   to vanish, retaining exactly the old norm direction e^4.

## Boundaries checked before selecting the target

The first carry on ker(e²) has rank1, not rank2: it kills the old
e^4 direction, as required. The norm carry detects the separate lower
obstruction when no compatible next lower reference exists.

For defect4 the direct map ker Psi→coker Psi is nonzero; the analogous
scalar argument does not force descent. For a direct degree25 cover
with constant defect2, one carry is already zero. The prompt therefore
asks about degree FIVE and defect TWO, not all degrees or all defects.

The returned bad-double W4 candidate has an AUDIT GAP precisely in
the Hodge-correction carry; numerical beta is not an input to this
question. The new target explicitly asks for the actual corrected
comparison, not permission to identify a convenient cohomology-matrix
lift with higher inverse Cartier.

At n=2 the canonical-reference involution eliminates even-degree
correction terms. At n>=3 their product valuations suggest they vanish
at the required precision, without an involution on later lower lifts.
This is a proposed proof mechanism, not a completed uniform-level proof.

The prompt is READY for manual submission. It does not use the returned
numerical beta as an established fact, nor equate a chosen integral
matrix lift with the geometric higher obstruction. It asks for that
additional geometric descent mechanism in a remaining two-defect case.

## Inventory check and impact

The audit/prose inputs checked were defect_preserving_etale_descent,
symplectic_p_cover_section_growth, etale_p_witt_obstruction and the
full-tuple definition witt_hodge_obstruction. Ordinary dihedral spin
growth, genus2-double Raynaud restrictions and finite restricted-theta
descent already exist; another question asking only for those would
largely duplicate the library. They do not establish (D5).

Success extends bounded-genus carrier descent through an actual
five-cover, and the existing partner count then handles a new
ordinary-X/source-defect2 factorization stratum. Failure must be an
actual finite-level compatible lift, not a module with the right
dimensions. It would show that the arithmetic/geometric carry is the
remaining barrier rather than prime-to-five trace alone.
