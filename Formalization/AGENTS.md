# Litt3 formalization

Use the prove2me module layout: `Definitions/`, `Theorems/`, `Solutions/`.
This is a local project, not an authorization to register, upload, publish,
or post to prove2me.

`Definitions` contains mathematical definitions. `Theorems` contains
propositions describing exact targets. `Solutions` contains checked proofs.
Statement propositions are definitions rather than `sorry` declarations;
an unresolved target must not enter the trusted proof environment.

Never claim a canonical theorem is formalized because a numerical consequence,
logical wrapper, assumed conclusion, or opaque proposition has been proved.
Coverage distinguishes full results, mathematical components, and untouched
targets. Record every gap between a component and the original statement.
Only precise accepted literature inputs may be exposed as first-pass
hypotheses; project results are not literature axioms. The final widening
pass removes those inputs by connecting them to actual foundations.

Use maximum justified generality: prefer arbitrary characteristic, rings,
fields, finite sets, modules, and groups when the argument permits them.
Retain actual morphisms and their common source in every geometric bridge.
Avoid exhaustive computations when algebraic proofs or short exact
certificates suffice. Generated artifacts go outside the parent workspace.

Ownership: `CartierAndSpin` belongs to cartier_spin; `Deformations` to
deformations; `Jacobians`, `QuotientGeometry`, `CurveArithmetic`, `Examples`
to jacobians_geometry. Root owns `SharedTensors`, `Atlases`,
`ProjectiveConnections`, shared foundations, inventory, and integration.
Coordinate cross-family changes with root before editing another owner.

All handwritten source edits use `apply_patch`. Run `lake build` and audit
the actual Lean axiom dependencies. No `sorry`, `admit`, new axioms, unsafe
proof escapes, or `native_decide` in checked solution modules. Do not import
the target to prove itself. Record source hashes to detect scope changes.
