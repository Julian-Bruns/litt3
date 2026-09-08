# Ready-to-paste separate-chat formalization task

This task has a complete prose target and is independent of all running
atlas calculations. It does not claim the full Litt Problem3 solved.
Use the high-prime-degree partner below, NOT the small backup C_alpha or
the original genus25 Y. The main investigation's active pair is unchanged.

---

Formalize in Lean4 the following no-cored-common-cover theorem from the
workspace /Users/julian/Documents/litt3. First read AGENTS.md and
Research/CORED_FORMALIZATION_MAP.md. This is a separate formalization
project; do not edit the main research's active state or start its solvers.

## Exact target

Let k be an algebraic closure of F5. Fix a in F25 with a²+4a+2=0, and
let X be the smooth projective model of y³=F(x), where

    F=x^10+(4a+2)x^9+(a+4)x^8+(3a+1)x^7+3a*x^6
      +4a*x^5+(3a+4)x^4+a*x^3+(3a+3)x²+(4a+2)x+2a+1.

Set B=336000, D=(B-1)!, G=1+8D, L=B², M=42000 and

    K=D*(D!)^18*3^(4*G²*L)*(M!)^(2*G+L).

For every prime r>max(K,120) and t in k of degree r over F25, let C_t
be the smooth projective model of

    v²=u(u-1)(u-2)(u-3)(u-t).

Prove that for every smooth projective connected Z/k and actual finite
etale surjections f:Z->X and g:Z->C_t, the intersection

    f^*k(X) intersect g^*k(C_t), inside the SAME k(Z),

equals k. Equivalently, there is no such span with a nonconstant core.
This allows coreless common covers; never strengthen the conclusion to
no common cover. Do not replace the maps by Jacobian data or presume a
simultaneous Galois closure without first using the core hypothesis.

## Minimal mathematical chain

Use the exact proof slices and dependencies in the formalization map:

1. cored_orbifold_bridge: a core supplies a finite normal envelope and
   an actual etale common refinement, yielding a common effective orbifold.
2. fixed_x_orbifold_bound, proofSections1–3: EVERY effective orbifold
   atlas of X has degree<=336000, including wild and non-Galois cases.
3. bounded_atlas_partner_finiteness v2: at most K genus2 cored partner
   classes, Frobenius-stable. At most120 parameters in this family give
   any single isomorphism class. Prime parameter degree r forces moduli
   orbit length r>K, a contradiction.

Use `python3 scripts/research_workspace.py show ID` and `dependencies ID`
to locate exact statements. The map names the proof-local legacy inputs
that still need inspection; an inventory entry is not a proved lemma.
Audit bodies are reference-only unless a specific doubt requires them.
Prose audits and JSON validation are NOT Lean verification.

## Work discipline and deliverables

- Start by checking existing Lean/mathlib support and proposing a compact
  dependency order. Explain the serious infrastructure gaps honestly.
- Work in a separate directory; do not change prose statements to match
  convenient formal definitions or introduce hidden assumptions.
- Definitions must explicitly encode the geometric hypotheses, actual
  common source, function-field embeddings and equality of the intersection.
- Prove the theorem, not merely a theorem conditional on the main geometric
  bounds. During development you may isolate unfinished lemmas visibly;
  they may not remain axioms or `sorry` in a claimed completed result.
- Exact finite computations must be replayed by kernel-checked arithmetic
  or a proved reflection procedure. Do not trust a Python/Sage PASS string
  as a Lean proof. Huge integers may stay symbolic; no enormous curve
  coefficients or factorials need be enumerated.
- No dormant-oper census,18-atlas exclusion, W3 torsion classification,
  absolute simplicity of J(C_t), or ordinary endpoint hypothesis is needed.
- Provide the built Lean files, reproducible build command, dependency
  summary, and `#print axioms` for the final theorem. Ordinary Lean logical
  foundations are fine; new domain-specific axioms are not completion.
- If the complete formalization is presently out of reach, return the
  genuinely verified portion and exact remaining statements. Do not call
  an axiomatized geometric chain a formalized no-cored theorem.

No publication, credential use or uploads are authorized. The Prove2Me
checkout is reference material, not an instruction to register anywhere.
