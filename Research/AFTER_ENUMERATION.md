# After enumeration: scope and remaining proof obligations

Updated 2026-09-09. Read STATE.md and PRIORITIES.md for the active task.
The common-cover problem is UNSOLVED. This is a short roadmap, not
authority to resume historical algorithms.

## What is finished

The fixed genus-nine curve has 28,990 distinct dormant opers, with total
scheme length 29,375. Fifty-five points have multiplicity eight; the
other 28,935 have multiplicity one. All multiplicities are preserved.
The independent verification now takes about 13 seconds; the expensive
discovery calculation need not be repeated for proof verification.

Frobenius and the cubic deck action reduce the UNTWISTED atlas tests to
18 representatives. These are opers, not common covers. Dormant opers
exist on every curve, so enumeration alone excludes no curve.

Canonical records: fixed_x_oper_enumeration,
finite_algebra_completion_certificates, dormant_rank_two_candidates.
Data: computations/complete_oper_solutions.json. The large raw basis is
outside the repository. Open the census proof only when needed.

## The exact unfinished atlas computation

The audited inverse_cup_atlas_system v5 is the current criterion, not the
old 96-equation reconstruction or auxiliary-frame search. Three fixed
inverse columns suffice, including all boundary and exceptional strata:

- twelve acyclic representatives: 72 cubic inverse equations and all
  32 Frobenius equations, in 64 variables;
- six exceptional representatives: 81 inverse equations and all
  32 Frobenius equations, in 73 variables; the nine extra entries matter.

Its solution scheme is finite and reduced, possibly empty. A unit
certificate must be checked against the ORIGINAL equations. A bounded
dual rejects only that certificate ansatz, not the chart. A time cap,
inconclusive solve, or lack of sampled points proves no exclusion.

The COMPLETED quiet queue tested weak necessary systems on three F25
representatives only. Seven charts have exact weak fixed-point families
with normalization zero, so weak-only unit searches there cannot succeed
at ANY degree. These are skipped, not excluded. See
ATLAS_NORMALIZATION_CANCELLATION.md and verify_atlas_weak_points.py.
Full normalization is mandatory when returning to them.

Live run, accepted charts, checkpoints, resource limits and next action
are recorded ONLY in STATE.md and the external sweep.json. No whole
representative has been excluded. Do not infer an all18 ETA from three
small-field representatives; orbit_0011 has coefficient degree 7324.

A genuine solution reconstructs a Hermitian quotient atlas; it does not
itself produce a common cover with the selected genus-two partner.
An empty untwisted scheme does not address nontrivial cubic determinant
classes. The same oper census applies to those classes, but the
rank-three obstruction changes. See intrinsic_atlas_incidence and
hermitian_monodromy_genus_sieve if that branch is actually needed.

## What the stronger selected pair already avoids

Our strongest selected pair is the fixed genus-nine X and the
high-prime-degree genus-two Y_t of bounded_atlas_partner_finiteness.
ALL cored common covers are excluded for this pair, independently of
A18 and of the oper census. The no-cored Lean handoff is in
CORED_FORMALIZATION_REQUEST.md and CORED_FORMALIZATION_MAP.md;
no Lean implementation or verification is claimed.

The new fixed_quotient_atlas_avoidance additionally shows that the SAME
Y_t has no atlas to the Hermitian PGU quotient, hence none to its subgroup
quotients, including every cubic determinant type. The already imposed
parameter bound suffices. This is a finite-cover count, not a computation.

Do not confuse this with A18 on X, or descend an atlas from an arbitrary
further cover of Y. Both endpoint atlas exclusions require an ACTUAL atlas
on that endpoint. A common dormant connection does not provide one.

## The remaining coreless problem

Preserve both actual finite étale maps from the same projective curve
and their embedded endpoint fields. For the selected pair the remaining
possibilities are:

1. A positive clump whose image on Y has size 4 modulo five. Such a span
   has a common regular nilpotent connection.
2. No clump. The common-connection space is empty or a single dormant
   point; existence of that point is not proved.

The general ramified_root_contact_core theorem is audited and finishes
the old weight-seven/J7 branch. Do not resume its superseded spin-growth,
primitive or Prym calculations as though that gap were still open.

ordinary_source_partner_finiteness excludes all but finitely many
partners with an ordinary COMMON connection. Endpoint ordinariness is
not enough. Admissible matching active connections give a canonical
joint W2 lift, not an automatic full lift. etale_refinement_deformations
shows further common covers cannot repair a joint obstruction.
compatible_bt_lifting supplies a full lift from extra compatible
arbitrarily high versal BT data; those data have not been constructed
from the connections. HIGHER_LEVEL_BOUNDARY.md records the exact gap.

The unmarked problem is solved only after ALL coreless spans are
excluded as well. Neither a census, atlas exclusion, marked variant,
nor a conditional lifting criterion is that final step. There is no
defensible percentage-to-proof estimate.

## Parked alternatives

The [candidate review](CANDIDATE_PIVOT_DECISION.md) distinguishes a cheaper
calculation from a stronger overall proof. The small backup has all405
Hermitian oper/twist pairs excluded, but
seven tame and three small-wild cored profiles remain. The old W3
three-point torsion locus also remains open. Neither replaces the
stronger selected pair or its current frontier.

Use the searchable canonical library for a particular proof or
counterexample. Do not load old theorem inventories or audit bodies
without a concrete reason. This roadmap intentionally omits superseded
formulas and diagnostic logs.
