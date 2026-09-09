# A18: exact input, useful algorithms, and hard boundaries

Updated 2026-09-09 04:16 CEST. Resource policy and LIVE process are in STATE.
Zero whole atlas representatives excluded. The oper census is COMPLETE.

## What remains to be computed

Use inverse_cup_atlas_system v5 (selected-column argument audited).
For D=[B q;a 0], in coefficient-rooted coordinates:

    Dtilde(v) [Gammatilde(b) Q; Z] = [Q;0],
    b_i = s_i(v,b)^5, i=0,...,31.

Q selects columns4,21,23, the sections y,x^10,x^4y² of L32.
Their products with L32 span L64: a fixed exact rank56 certificate.
These columns force the FULL inverse, including every bad-quotient boundary.
Acyclic cases:72 cubics plus32 Frobenius equations in64 variables.
Six exceptional cases:81 cubics plus32 Frobenius equations in73 variables;
all nine auxiliary Z entries and all projected-R terms are essential.
Do not substitute only a cup-rank condition, or discard normal-corank strata.

The equivalent compact system has64 N equations,32 R fixed-point equations,
and U.beta=2. All variables range over the ALGEBRAIC CLOSURE.
After projective chart scaling the normalization is a NONZERO condition;
one cannot also set b_j=s_j=1 while demanding an unchanged numerical scale.

## Exact limits of the weaker search

A unit certificate from any necessary subset excludes a chart. A dual only
disproves its particular bounded multiplier ansatz; a timeout proves neither.

There are exact positive points of the weak systems on orbit_0000
charts0,1,4 and invariant_0/invariant_1 charts0,2, independently replayable by:

    python3 scripts/verify_atlas_weak_points.py

All seven witnesses satisfy ALL N/R, but U.beta=0. None is an atlas.
NO weak-only unit certificate can exist on these charts in ANY degree.
Controller status weak_subsystem_has_point means skip this insufficient
search, NOT chart excluded. Retain normalization/full inverse for these.
The five additional skips were loaded into the quiet controller at06:45,
with the active chart3 resumed from its27168-step checkpoint; no blind
retry of previously capped/inconclusive jobs. Sparse one/two-coordinate
positive search took0.36s total on three representatives. Its failed trials
are not exclusions over k; only the seven exact witnesses are retained.

More generally, the unsaturated N incidence has a24-dimensional family of
invalid quotients for EVERY oper. The full normalization removes this family.
The strong cubic incidence is either empty or every component has dimension
at least8: it is the inverse graph over the inverse image of a32-plane in a
56-space, cut by24 functions on an open32-fold. Thus cubic-first solving
does not itself give a finite candidate list.

## Current fast certificate engine

Native C++ Lanczos accepts only exactly replayed primal/dual certificates.
F25 arithmetic uses repeated coefficient tables and small bounded exact
integer sums in Accelerate SGEMMs; no numerical-rank conclusion is accepted.
Every successful exclusion is replayed against the ORIGINAL tensor equations.
Support-component pruning keeps only the target component, with fallback to
the full operator if it is connected. Column congruence reduces some radical
breakdowns; it is not guaranteed to fix every one. Versioned checkpoints
retain the chosen coordinates. Performance receipts: ATLAS_PLAYGROUND.md.

The quiet overnight queue searches67 adaptive tests on ONLY orbit_0000,
invariant_0,invariant_1, using four workers. It is NOT an all18 run.
Coefficient fields remain a separate obstacle: native arithmetic is F25 only;
invariant_2 needs F625 and orbit11 has relative degree7324.
Do not infer an all18 ETA from the three small-field representatives.
No second sustained diagnostic during the user's quiet period.

## Compact constructions worth retaining

For the twelve acyclic cases, pi_*V=O(-1)^6 for the trigonal map pi.
Six horizontal sections supply an alternating constant J and3x6 polynomial
P(z), linear in32 quotient coefficients, row degrees11,8,5. The Bezout matrix
comes from -4P(z)J^-1P(w)^T/(z-w). First-oper replay of ALL528 quadratic
matrices takes1.56s:192+15 Wronskians replace12672+768 constructions.
The uniform Q frame passes on all12 census algebras in4.55s.

The32 quotient coordinates can be put in two chains of length6 and four of
length5; the horizontal shift is x^5. Apply both the coefficient-rooted basis
change and its dual to B,Gamma,R. Source atlas_chain_coordinates.py.
A six-convolution graph lift gives230 graph quadratics,72 inverse quadratics,
32 pure fifth-power equations (294 variables). Exact export/replay passed;
no successful solve or speed advantage has been established.

## Failed tests: do not repeat unchanged

Ten cubic variable orders and ten weak-module elimination orders timed out
in their first useful batches. Two signature runs also timed out.
Low-degree pair combinations yielded no lower-degree consequences and grew
denser. Whole-checkpoint tail reduction has trillions of predicted updates;
caching is not free. Detailed evidence and timings stay in ATLAS_PLAYGROUND
and external receipts, not duplicated here.

Generic inverse-chart elimination produced degrees161/2544; full576-row
RREF made input denser. Necessary rank shortcuts fail on actual data.
The old LinBox wrapper assumed nonsingularity and is not a safe substitute.
Do not assume Gram squaring preserves rank in characteristic5, impose
finite-field equations, or truncate an inhomogeneous ideal by a homogeneous
degree rule. Sparse fifth powers scale exponents; never expand them naively.

## Census and wider proof

verify_oper_census.sage independently checks completeness and multiplicities
in13.08s, without rediscovering the large basis. There are28935 noninvariant
points and55 invariant points of multiplicity8: total28990 points, length29375.
The proof uses exact parametrization/local lower bounds and the independent
global length theorem. It is not Lean verification.

Audited no-cored avoidance for the high-degree selected partner is independent
of A18. J7 is already solved by ramified_root_contact_core. Even complete A18
emptiness would NOT alone settle the remaining coreless connection branches.
