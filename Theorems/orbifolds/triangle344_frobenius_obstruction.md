# A Frobenius-orbit obstruction to uniform (3,4,4) covers

Version2, 2026-09-09. Replaces the rational-projector argument by an
actual elliptic quotient, strengthening the conclusion and shortening
its certificate. Author proof; not independently audited or Lean-verified.

Let C/bar(F5) be a smooth projective genus-two curve whose geometric
isomorphism class has fifth-power Frobenius orbit length at least three.

Every actual finite separable tame map C -> P1 whose only branch fibers
have uniform indices (3,4,4) factors through an ACTUAL degree-two map
C -> E to a smooth genus-one curve. In particular C is bielliptic,
J(C) is not geometrically simple, and Aut(C) has order at least four.
The original map has degree12 and profile (3^4,4^3,4^3), where exponents
count distinct points. No Galois assumption on that map is made.

Consequently such a map does not exist if either J(C) is geometrically
simple OR Aut(C) consists only of the hyperelliptic involution and identity.

In particular this excludes the (12;3,4,4) tame atlas row for the
explicit [backup C_alpha](../../Definitions/Def_backup_genus_two_curve.md).
Its moduli Frobenius orbit is three and Aut(C_alpha)=C2, both by an
elementary branch-set argument. No Weil-polynomial computation is
needed for this application.

The reusable mechanism partitions a complete finite cover census by a
Frobenius-stable monodromy invariant. Each nonempty part must accommodate
a full Frobenius orbit of the source curve. Here the only part of size
at least three has a preserved partition into pairs whose actual quotient
has genus one. A standalone C++ replay of the COMPLETE census and all
three pair-block certificates takes about0.05 seconds after compilation;
neither GAP nor character tables are needed for independent verification.

This removes one backup cored profile, not all backup profiles or any
arbitrary coreless common span. The currently selected main pair is
unchanged. One-cover tame lifting is used, not a simultaneous lift of
two arbitrary finite etale maps.

[Proof and complete elementary enumeration](../../Solutions/orbifolds/triangle344_frobenius_obstruction.md).
