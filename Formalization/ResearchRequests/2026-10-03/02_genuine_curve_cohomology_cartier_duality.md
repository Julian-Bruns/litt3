# Genuine curve cohomology and original differential H0

Construct the actual cohomological bridge between the genuine global
differential sheaf and the genus/Frobenius invariants of a smooth proper
curve. The requested result is a formal Serre-duality and Cartier/Frobenius
comparison for ORIGINAL sheaves and maps, at every finite height. An
abstract pairing of supplied vector spaces does not complete this task.

Use Lean4 v4.27.0-rc1 and Mathlib revision
32d24245c7a12ded17325299fd41d412022cd3fe. Give self-contained source and
exact input interfaces, without unavailable local imports. Classical
choice, propositional extensionality and quotient soundness are allowed;
no sorry, research-goal axiom or computation oracle is allowed.

Let k be algebraically closed, and let s_C:C→Spec(k) be a genuine smooth
proper geometrically connected curve. Use its original structure sheaf
O_C, actual generic-stalk function field K_C, and actual associated
relative differential SHEAF Ω^1_(C/k). One concrete definition of the
last sheaf is the sheafification, in original O_C-modules, of the
presheaf U↦Ω^1_(Γ(C,U)/k), with restriction maps induced by the original
ring maps and coefficient action from s_C. H0Ω means its ORIGINAL
global sections, with the original k action. H^1(C,O_C) must be actual
sheaf cohomology of O_C, not an unrelated type assumed to have the
desired dimension. Define genus as the conventional
g(C)=dim_k H^1(C,O_C), and identify it with any independently used
geometric genus convention rather than declaring genus to be dim H0Ω.

The following exact inputs are available:

1. On ANY integral smooth scheme of ANY relative dimension over ANY
   field, genuine differential H0 has a proved k-linear equivalence to
   the intersection of the original closed-stalk differential images
   inside Ω^1_(K/k). Its original rational realization is injective.
   The inverse uses genuine local lifts and sheaf gluing. No properness,
   finite H0, characteristic or genus premise is used in this input.
2. In prime characteristic p, intrinsic rational Cartier on the actual
   one-variable function field is constructed from its full p-basis,
   preserves every original regular differential stalk, and therefore
   induces an actual additive operator C on genuine H0Ω. It satisfies
   C(a^pω)=aC(ω) for ORIGINAL coefficients a∈k. Its kernel consists
   exactly of forms whose original rational realization is df for an
   actual f∈K_C; that primitive may have poles.
3. For every n≥0, actual C^n on genuine H0 satisfies
   C^n(a^(p^n)ω)=aC^n(ω). Its rational realization is the actual rational
   iterate. Actual finite étale H0 pullbacks commute with every C^n
   and are injective, with the original sheaves and function fields.
4. Every nonzero rational differential on a genuine proper smooth
   curve with rank_k(H0Ω)≥2 has an original closed-point zero, proved
   by actual stalk ratios and original proper constants. No canonical
   degree or genus identification was used. This input does NOT itself
   provide the genus-to-H0 bridge requested here.

Construct actual cohomology, prove finite dimensionality of H^1(O_C)
and H0Ω, and construct the nondegenerate k-bilinear Serre pairing
B_C:H^1(C,O_C)×H0Ω→k. Prove dim_k H0Ω=g(C), and hence g(C)≥2 implies
rank_k H0Ω≥2 for the actual original module.

In characteristic p>0, derive Frobenius on H^1(O_C) from the ACTUAL
relative Frobenius sheaf map, keeping scalar twists. With a consistent
perfect-field semilinear convention, prove
B_C(F^n a,ω)=B_C(a,C^nω)^(p^n) for every n≥0. State explicitly which
relative-Frobenius twist is identified by the perfect-field coefficient
automorphism. The differential of a group-scheme Frobenius must not be
silently substituted for this cohomological Frobenius.

For an actual finite étale surjective h:C→D of such curves, derive
the genuine differential trace and prove the duality of actual H^1
pullback with that trace. The rational trace must be the ORIGINAL finite
separable field trace on full universal differentials, not an independent
map chosen to make the pairing work. Prove trace/Cartier compatibility
and all-height consequences from these actual maps.

For the original sheaf
B_(n,C)=coker(O_(C^(n))→F^n_(C/k)*O_C), prove the corresponding H0
description from the actual long exact sequence and Frobenius kernel.
All sheaves, maps, scalar twists and exactness conditions must be stated.
In a span X←f−Z−g→Y, retain BOTH actual finite étale maps from the SAME
Z throughout the resulting cohomological difference map; no arbitrary
separable replacement or simultaneous Galois closure is allowed.

The primary completion is this genuine cohomology/Serre/Cartier bridge,
including naturality and finite heights. Standard accepted literature
may be used in a first pass only as precise typed actual-object inputs,
with the conditional scope explicit. Supply the minimal dependency
frontier and then widen it toward formal foundations; do not assume the
very H0/genus identification or Frobenius compatibility being requested.
If foundational Mathlib cohomology is missing, return the exact proved
implementation frontier and the remaining actual-object theorem.

At substantive milestones, save source, essential results and a concise
`RESUME.md` (proved results, verification status, next step), publishing a
checkpoint link when possible.

Return a brief chat overview, preferably at most 200 words, and a link
to exactly one final ZIP. State whether the requested result is complete,
partial or unresolved, its precise achieved scope, and the remaining
gap. Put detailed mathematics and computation in the ZIP; give no
speculative completion percentage or separate final attachments.

The ZIP must be self-contained and include:

- `README.md`: objective, status, file map, software requirements and
  versions, and exact verification commands.
- `REPORT.md`: statements, hypotheses, conventions, complete proofs,
  dependencies, useful partial results, failed approaches and open steps.
- The latest `RESUME.md`.
- A claim-to-evidence index, such as `claims.json`, linking each claim
  to its evidence and distinguishing proved, conditional,
  computationally checked and open claims.
- Minimal reproducible evidence: source, exact inputs and essential
  witnesses/certificates. Replace bulky regenerable intermediates and
  repetitive output with regeneration commands; process large artifacts
  in compressed, restartable chunks and stream archive creation.
- Concise executed-check summaries (commands, versions, outcomes),
  evidence-bearing log excerpts and a SHA-256 file manifest; full logs
  only when necessary for verification.

Explicitly label bounded searches, unexecuted code and unverified claims.
For a theoretical proof, state that no computational certificates are
needed. Preserve reusable partial results and the exact remaining
problem. Include necessary evidence without relying on conversation
history or files outside the ZIP.
