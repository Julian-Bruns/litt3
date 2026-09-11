# Degree84 final unit and exclusion assembly audit

Verdict: PASS for the new final certificate, its immediate provenance,
and the geometric assembly using the inherited inputs below.
Auditor: /root/audit_degree84_final_assembly. Date: 2026-09-11.
No objection to these steps. This is a scoped prose/computational audit,
not Lean verification or a new census enumeration.

All data directories below are relative to
`/Users/julian/Documents/litt3-computation-data`.

The fresh independent replay of
`degree84-three-pole-dag-snapshot-20260911/dag.json` against
`degree84-three-pole-final15-20260911/source.json` checked all190 nodes,
806607 polynomial products, and the final constant1 in4.583seconds.
Source SHA256:
`882058ddcfb3e4fe56b23b11f8dfea2269136a2830a9d67b90fcf105eb2d891a`.
Certificate SHA256:
`d208d17e45f88e533ce5636f9b3cb3faecf824e8562778c5dffa1e3d7171aca8`.
The verifier permits only polynomial multipliers and earlier DAG rows;
it checks every equality by exact coefficient arithmetic. An in-memory
single-coefficient mutation was rejected at node0, leaving originals intact.

I checked the final15 equations are exactly all14 equations of
`degree84-three-pole-low6-tracked-20260911/basis.json` followed by original
zero-based row213 of `degree84-three-pole-cofactor-v2-20260911/source.json`.
Both recorded source hashes and all ring metadata match. I freshly replayed
all14 tracked identities:56814 products,0.295seconds. Basis SHA256:
`cdbcb6a11258ca8a0f64723a2098112c276d9fa43f068ed6e626508801d3ddae`.
Their source is `degree84-three-pole-low6-20260911/source.json`, SHA256
`534836b6456caf35bef4b5045b66c7412c4ff507690d5d5a6c2310d0e49a8ec3`.
I checked it is exactly the63 degree-at-most-six rows of the251-row
cofactor chart, including every recorded original index and the previous
source hash. Dropping the other equations only enlarges the solution set;
the verified unit in this consequence subsystem therefore suffices.

I also freshly replayed the entire cofactor transport:251 rows,
860745 products,6.329seconds. Input is
`degree84-tracked-degree4-full-rref-20260911/source.json`, SHA256
`34851d73115d0c3ccf74c2ab2c92e5416197eae87c0628d2ae64372a91981994`;
output chart SHA256 is
`57e089f21a55e8434597a215625d5466a8e9d5fe504ff10585c9cc8206c157c0`.
The replay checks the full substitution, deduplication and added inverse
guard. Each replay receipt is named `fresh_final_audit_replay.json` in
its corresponding output directory.

The actual-map implication uses the canonical audited
`triangle237_cofactor_necessary_system`, together with the fresh
[chart audit](DEGREE84_THREE_POLE_COFACTOR_CHART_AUDIT_2026_09_11.md).
These establish the full original normalization, affine substitutions,
correct horizontal basis and cofactors, and L!=0 on every actual map.
There is no additional actual L=0 chart: the cofactor proof uses
squarefreeness of the actual numerator and its primitive coefficient vector
to prove Araw=L*A with L a nonzero constant. The inverse variable can
therefore always be assigned. The chosen beta represents all five dormant
potentials by coefficient Frobenius over the fixed F125 source.

The identity1=0 holds over the coefficient ring in seven indeterminates,
hence after any extension to the algebraic closure. The final certificate
imposes no finite-field point equations on the seven unknowns. It neither
requires nor uses the separate finite-etale rank-at-most-two theorem.

The inherited `triangle237_dormant_orbit_obstruction` removes all three
primitive survivors46,55,90 and forces every remaining actual map through
the hyperelliptic quotient. All42 hyperelliptic survivors obey the same
necessary system; they are therefore removed simultaneously by this unit,
without an individual source comparison or an assumption of simultaneous
Galois closure. Thus the assembly removes all45 previously surviving
classes, using the established geometric inputs and the closed algebraic
provenance assembled below.

Follow-up audit: the root supplied
`degree84-final-provenance-v3-20260911/manifest.json`, SHA256
`fa1c6f5e8bdf02c0155ebb3fb958390d70b3dfbde0dcad1c7ca30d2b2003d5fb`.
I inspected every edge branch in `scripts/assemble_degree84_provenance.py`
and its35-node manifest, then independently checked all287 artifact hashes.
All parent nodes are present. Every consequence append in these artifacts
uses the immediate predecessor as its certificate source; there is no
unjustified comparison of points from unrelated affine charts. All35 source
equation encodings have nonnegative exponents and consistent arities, and
all4802 recorded Macaulay multipliers are ordinary polynomial monomials.
The primitive field-consequence verifier likewise accumulates polynomial
identities; it does not reduce unknowns modulo finite-field point equations.

The assembler closes to the exact118 original rows:115 native equations,
plus a4,a9,a14 justified by loc*s=1 and the existing s*a_i equations.
The separate chart audit identifies all115 native rows with the actual-map
dictionary. At the C(0) open, C(0)!=0 follows from the actual passport's
disjoint divisors, so adjoining pole0_inv is legitimate. The assembler checks
each canceled consequence as f=c0*g and retains the inverse equation.
It checks seven recursive and thirteen later affine pivots in the current
linear row spans, as well as complete equation substitution. Exact subsets
only weaken equations. Each partial-basis import has a matching source and
certificate hash and an independent PASS receipt. The three full-system
transport edges reinsert the entire original equation list after the proven
affine substitution; the final cofactor, subset and merge edges were also
freshly replayed above. Thus no unrecorded nonlinear source edge remains.

This manifest accepts earlier independently replayed identities by matching
hashes: `identity_replays_executed_now` is false. It lists127 identity-replay
commands and freshly replays the final unit. The separate root invocation
with `--replay`, writing `degree84-final-provenance-full-replay-20260911`,
is pending at this amendment; I have not represented it as completed or
duplicated its long expansions. The already supplied replay evidence and
closed edge audit suffice to remove the earlier missing-provenance gap.

Inherited limitations: I have not re-enumerated the155-class census or
re-audited its earlier110 exclusions or the primitive obstruction. The
nonlinear identities before the final chart rely on their hash-matched
independent replay receipts rather than new duplicate expansions by this
auditor. The chart audit independently supplies geometric normalization
and pivot coverage. With those
inputs the claimed outcome is solely absence of an actual tame degree84
map of complete uniform profile(2,3,7) on the specified backup curve.
It does not solve the original unmarked common-cover problem, strengthen
the main pair, or replace either of its two actual finite etale maps.
