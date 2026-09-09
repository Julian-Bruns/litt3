# Compatible BT truncations bound the joint lifting obstruction

Use the [BT conventions](../Definitions/Def_versal_bt_data.md) and
[marked deformation conventions](../Definitions/Def_marked_curve_deformations.md).
Let X <-f- Z -g-> Y be an ACTUAL finite bi-etale span of smooth proper
connected curves of genus at least two over k, with p>2.

1. Compatible everywhere-versal full height-two, dimension-one BT
   groups give a simultaneous smooth proper W(k)-lift with both maps
   finite etale. Compatibility may be witnessed after an arbitrary
   connected finite etale refinement of Z.

2. More conservatively, compatible everywhere-versal BT_N groups,
   possibly only after refinement, give such a marked span over W_m
   whenever N>=m+2. This safe bound deliberately makes no sharp claim
   about the indexing in Xia's truncated lifting theorem.

3. If compatible data exists for arbitrarily large N, then the original
   span has a simultaneous mixed-characteristic lift over a DVR finite
   over W(k). Neither the groups nor their refinements nor their curve
   lifts at different N need have been chosen compatibly.

Equivalently, if the original span is intrinsically nonliftable and its
marked joint deformation ring satisfies p^e=0, then it admits NO such
compatible BT_N data for N>=e+3, even after ANY etale refinement.
The exponent e depends on the actual span; no uniform bound is given.

No ordinariness, Galois, prime-to-p degree, or core assumption is needed.
This is a lifting criterion with explicit EXTRA group data, not a proof
that a matched admissible connection has that data. In particular it
does not iterate the canonical W2 connection construction. Finite-level
one-leg lifts alone do not give simultaneous full lifts.

Version1,2026-09-09. Author synthesis of Xia's full and truncated
lifting proofs, Krishnamoorthy's full-BT correspondence argument,
and etale_refinement_deformations v2. No independent audit or Lean
verification. [Proof](../Solutions/Sol_compatible_bt_lifting.md).
