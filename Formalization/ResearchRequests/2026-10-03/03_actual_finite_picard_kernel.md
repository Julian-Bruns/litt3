# The actual finite Picard kernel and its Frobenius types

Give a faithful formal construction and proof of the finite group-scheme
Picard-kernel bridge for an ORIGINAL two-map étale span. The target is
the WHOLE scheme-theoretic kernel, including infinitesimal structure and
all Frobenius heights. An identification of rational torsion points alone
does not complete it.

Use Lean4 v4.27.0-rc1 and Mathlib revision
32d24245c7a12ded17325299fd41d412022cd3fe. Supply self-contained source
and mathematical interfaces. No unavailable custom imports, sorry,
opaque goal axioms, numerical point counts, or presumed simultaneous
Galois closure may be used. Standard literature is allowed as precise
actual-object hypotheses in a clearly identified first pass; distinguish
that conditional proof from formally establishing the hypotheses.

Let k be algebraically closed of characteristic p>0. Let
X←f−Z−g→Y be ACTUAL finite étale surjective maps of smooth proper
connected curves of genus at least two. Preserve BOTH maps from the
SAME Z. Their structure morphisms over k agree after composition. In
E=k(Z), let F and G be the literal images of k(X),k(Y), and assume
F∩G=k. No joint minimality is imposed.

Let J(C)=Pic^0_(C/k) be the genuine Jacobian/Picard group scheme, with
its usual principal polarization, for each ORIGINAL curve C. Define
u=f^*−g^*:J(X)×J(Y)→J(Z) from the actual line-sheaf pullback maps.
Let T_scheme=ker(u) be its genuine scheme-theoretic kernel. Let
V=f^*H0(X,Ω^1_(X/k))∩g^*H0(Y,Ω^1_(Y/k)) be the LITERAL intersection
of both genuine H0 images in the SAME original H0(Z,Ω^1_(Z/k)).
Let C be its inherited intrinsic Cartier operator. Let
K=ker(H^1(X,O_X)⊕H^1(Y,O_Y)→H^1(Z,O_Z)), with the actual difference
pullback and the actual cohomological Frobenius, including scalar twists.

The following are explicit inputs:

1. Genuine differential H0 is linearly equivalent to the intersection
   of the original closed-stalk images in original rational universal
   differentials, with original scalar action, actual injection and
   genuine sheaf-gluing inverse.
2. Actual finite étale H0 pullbacks are injective, realize the original
   rational universal differential maps, and commute with intrinsic
   Cartier and all its finite iterates. Cartier on literal V is therefore
   an actual additive inverse-p semilinear restriction.
3. F∩G=k forces the ACTUAL shared rational space to be finite dimensional
   of dimension at most one. The true V consequently is finite dimensional
   of dimension at most one, without a supplied finite-total-H0 premise.
4. Under the additional literal condition that any two nonempty finite
   clumps have equal endpoint support, genuine H0 rank at least two on
   one endpoint forces all shared rational differentials regular, and
   thus identifies them with literal V. Here a clump is a pair of finite
   nonempty closed-point sets S_X,S_Y whose FULL original inverse images
   in Z are equal. This input is conditional; the general clump-count
   theorem must be proved or precisely supplied, not inferred from F∩G=k
   without justification.
5. With that regularity supplied, the ACTUAL multiplicative quotient
   Q=E^*/(F^*G^*) has a canonical F_p-linear identification
   Q[p]≅V^(C=1). Each Q[p^n] is finite cyclic with at most p^n elements.
   Its ENTIRE p-primary subgroup is zero iff C|V=0. This does NOT prove
   that the entire nonzero primary subgroup is finite.
6. The original closed-point divisor quotient
   Div(Z)/(f^*Div(X)+g^*Div(Y)) is torsion-free, so the actual principal
   relation kernel in Q is saturated. All divisor maps are literal.
7. Independently form Pic_line(C) from ALL actual original invertible
   module sheaves modulo genuine whole-sheaf isomorphism. Every such
   sheaf has an actual original finite divisor presentation, giving
   Div(C)/div(k(C)^*) isomorphic to Pic_line(C). Addition is the genuine
   sheafified tensor product. Actual categorical module-sheaf pullback
   defines Pic_line(h); its canonical O(D) comparison is a whole-sheaf
   isomorphism, and this divisor-class equivalence is natural for BOTH
   actual maps. Consequently the ENTIRE joint original divisor-class
   kernel and the original rational/divisor gluing quotient are
   isomorphic to ker(Pic_line(f)-Pic_line(g)). Under an additional actual
   no-clump hypothesis, the original principal relation subgroup in Q
   is this entire kernel. This supplies honest abstract line-class
   groups and actual maps; it supplies NO representing Picard scheme,
   degree-zero restriction, kernel finiteness or infinitesimal structure.

Construct J(C), its actual pullback u and T_scheme with sufficient
formal foundations or precise accepted-literature interfaces. Prove that
T_scheme is finite under the stated ORIGINAL field-intersection hypothesis.
Identify K with its actual Lie algebra and prove
dim Lie(T_scheme^D)=dim V≤1 and
dim ker(F|K)=dim ker(C|V), with all duality and scalar twists explicit.
Here D is finite-group-scheme Cartier duality. These identifications
must be derived from the ORIGINAL maps; they may not be definitions of
T_scheme, K, or V.

Then prove the following COMPLETE three-row classification of its
characteristic-primary group scheme:

- V=0 iff T_scheme is of multiplicative type; cohomological Frobenius
  on K is bijective. Nonreduced multiplicative p-primary structure is
  allowed even though T_scheme(k) has no p-torsion.
- If V is a line and C|V≠0, the p-primary group scheme is a product
  of a multiplicative group scheme and ONE nontrivial cyclic constant
  p-group. Frobenius on K is bijective.
- If V is a line and C|V=0, the p-primary group scheme is connected
  and has a nonzero local-local part. The nilpotent Frobenius part of K
  is ONE Jordan block of some length ell≥1. For every a≥1,
  dim ker(F^a|K)=min(a,ell), and that nilpotent block injects into the
  nilpotent Frobenius part of EACH endpoint H^1(O).

Explain every use of Dieudonné theory, Cartier duality and Picard
representability with exact hypotheses and actual-map interfaces. Prove
all-height consequences using semilinear twists rather than treating F
as an ordinary k-linear operator without justification. Relate them to
the genuine B_(a,C)=coker(O_(C^(a))→F^a_(C/k)*O_C) cohomological maps.
No Frobenius-lift or canonical-root existence conclusion is requested.

The mathematical completion is the finite actual kernel and this full
type/height bridge, not a selected case or a finite point computation.
Report a precise first-pass literature frontier and formalize its
foundations as far as achieved. Keep unproved representability,
finiteness, duality and cohomology bridges explicit rather than replacing
them by the final assertions as assumptions.

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
