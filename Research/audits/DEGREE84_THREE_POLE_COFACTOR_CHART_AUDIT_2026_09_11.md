# Degree84 three-pole cofactor chart: normalization and actual-map necessity

Verdict: PASS, scoped as below. Auditor: /root/audit_degree84_cofactor_chart.
Date: 2026-09-11. No blocking mathematical objection.

Audited the new chart in
`degree84-three-pole-cofactor-v2-20260911/source.json`, produced by
`scripts/prepare_degree84_three_pole_cofactor.py`, using the recursive-linear,
all63-quadratic-subideal, and tracked-degree4-full-rref sources of the same
date under `/Users/julian/Documents/litt3-computation-data`.
Chart SHA256:
`57e089f21a55e8434597a215625d5466a8e9d5fe504ff10585c9cc8206c157c0`.

Independent exact replay:

    sage -python scripts/audit_degree84_cofactor_normalization.py

This replay passed. Its scope is stronger than the producer's selected
high-coefficient check: the saved alpha and beta reconstruct ALL115 original
native equations in their original order in the recursive source. This
includes every horizontal, first derivative, second derivative, passport,
and localization equation. Thus the chosen F and P match the original
normalization coefficientwise; no different dormant member or alpha embedding
was silently substituted. The three additional original rows are the already
localized derivative consequences.

The replay independently checks all seven recursive and thirteen later affine
pivots by membership in the constant row spaces of the corresponding linear
equations at each stage. It also checks both complete exported equation lists
against substitution into their original equations, including order and
deduplication. The imported nonlinear consequence certificates underlying the
later source remain inherited inputs; they are not re-audited here.

The c0 and c1 formulas depend only on c2,c3,c5; the earlier c4 formula also
depends only on these variables. Their combination introduces no variable
denominator or case split. They are consequences, so every point of the
inherited necessary system has this substitution. In particular the c4
formula does not require a hidden choice of c0 or c1 chart.

The independent replay constructs the horizontal basis from the full ODE,
checks its dimension two, gcd1, and Wronskian a nonzero constant times F.
It constructs all signed maximal minors using matrix determinants, separately
from the producer's permutation expansion, and obtains exactly the saved
Araw after the combined affine substitutions. It checks degree18, the saved
leading coefficient L, the full polynomial ODE for Araw*C, the zero
coefficients4,9,14, and the a17 normalization.

The canonical audited `triangle237_cofactor_necessary_system` is an inherited
geometric input: on EVERY actual map, L is nonzero and A=Araw/L. Restricting
its polynomial identity to the affine relations cannot create an actual
L=0 boundary. Therefore assigning lead_inv=1/L and substituting all surviving
A coefficients loses no actual map. The previous eliminated A coefficients
are consistent with this normalization. The inherited nonzero guards remain
equations under transport; adding lead_inv*L-1 is justified everywhere on
the actual locus.

This audit does NOT certify the tracked partial-basis provenance, final
250-row transport, or any unit identity. Those are separate root replay
tasks. In particular a native UNIT report alone is not an exclusion.
The conclusion here is only necessity and full normalization compatibility
of this seven-variable chart for the remaining actual degree84 maps.
It makes no original unmarked common-cover claim and registers no theorem.
