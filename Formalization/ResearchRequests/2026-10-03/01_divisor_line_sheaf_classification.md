# Coherent divisor-sheaf comparison and actual two-map gluing triples

Complete the whole-sheaf coherent tensor and pullback comparison for
genuine divisor sheaves, and use it to identify the group of ACTUAL
two-map line-sheaf gluing triples with its original rational-divisor
presentation. ALL-line classification, the honest Picard group, canonical
categorical divisor pullback and its class naturality are established
inputs below. The missing bridge is coherence on actual sheaves and the
quotient of triples carrying a genuine comparison isomorphism.

Work in Lean4 v4.27.0-rc1 with Mathlib revision
32d24245c7a12ded17325299fd41d412022cd3fe. Supply a standalone project or a
precise extension using the mathematical input interfaces stated below.
Do not rely on unavailable local files, unspecified custom imports, or
an existing scheme Picard group whose definition has not been supplied.

Let k be algebraically closed, in arbitrary characteristic. Let
s_X:X→Spec(k) be an actual quasi-compact smooth morphism of relative
dimension one, with X integral. Properness and projectivity are not
required. Use the original Scheme structure sheaf O_X, its genuine
module-sheaf category, original generic point η, and K_X=O_(X,η).
Closed points mean points whose singleton is closed in the ORIGINAL
topological space. Div(X) is the free abelian group of finite-support
integer functions on those points. Each original closed stalk is a DVR.
Write ord_x for its normalized discrete valuation on K_X, positive on
a uniformizer; ord_x(0)=+∞ is only an informal convention for bounds.

Define the rational-function sheaf as the actual generic-point skyscraper
of K_X, with O_X action induced by the original generic germs. Define
O_X(D)(U) as its actual sections whose values satisfy
ord_x(a)+D_x≥0 for all original closed x in U. Use actual restriction
maps, including the empty open. An invertible sheaf means an ACTUAL
O_X-module SHEAF locally isomorphic to O_X on the entire original open
site below each chosen neighborhood. It must not be an arbitrary vector
space labelled a line bundle. Tensor products of sheaves must use genuine
sheafification when needed; pointwise tensor products of proper global
section modules need not be sheaves.

The following are proved inputs that may be reused with exact scopes:

1. The displayed O_X(D) section submodules define an actual sheaf.
   O_X(0) is genuinely isomorphic to the original O_X on EVERY open.
2. Literal multiplication by a nonzero original rational function f gives
   O_X(D)≅O_X(D−div(f)), natural on every original open. This fixes the
   sign convention. Principal divisors have genuine finite support.
3. Each O_X(D) has actual local rank-one frames at every original point,
   constructed from true DVR uniformizers and the finite support
   complement of D−div(f). No frames or coordinates are given as inputs.
4. For every nonempty original affine U, its coordinate ring is a
   non-field Dedekind domain with original fraction field K_X. Original
   closed points in U are genuinely equivalent to height-one prime ideals;
   their normalized valuations agree on the ENTIRE K_X. The genuine
   O_X(D)(U) is linearly equivalent, with unchanged rational value and
   original scalar action, to the fractional ideal having exponents −D.
5. For any commutative ring R and finite projective R-module M, actual
   associated-sheaf sections on EVERY open U⊆Spec(R) are genuinely
   O(U)-linearly equivalent to O(U)⊗_R M. Original tensor sections prove
   naturality, and for finite projective M,N the resulting tensor
   presheaf is a genuine sheaf isomorphic to the associated sheaf of
   M⊗_R N. Original invertible-module dual contraction gives actual
   unit/inverse tensor sheaf isomorphisms.
6. A genuine global trivialization of the ACTUAL O_X(D) yields ONE
   nonzero ORIGINAL rational function whose orders are -D at EVERY
   original closed point. Therefore O_X(D) is genuinely trivial iff
   D is the principal divisor of an original rational function. The
   original divisor-class zero and integer-torsion conditions are
   equivalent to genuine triviality of O_X(D) and O_X(ND).
7. The actual original rational-function multiplication map gives the
   genuine GLOBAL sheaf isomorphism O_X(D)⊗O_X(E)≅O_X(D+E), using actual
   module sheafification, and O_X(-D) is an actual tensor inverse. The
   entire affine multiplication map is bijective by the original
   invertible fractional ideals; affine-basis local bijectivity and the
   actual sheafification adjunction prove the global isomorphism. This
   input needs no properness or supplied tensor comparison. It does not
   supply a full coherent monoidal structure.
8. EVERY actual original invertible module sheaf M has a constructed
   original rational embedding and finite-support divisor D_M, with an
   actual whole-sheaf isomorphism M≅O_X(D_M). The local orders are derived
   from genuine integral rank-one frames and are frame-independent;
   compactness gives finite support. No divisor, generic frame, order or
   support is an additional input. This holds at the stated quasi-compact
   smooth integral curve scope, in every characteristic, without properness.
9. Independently define Pic(X) as the quotient of ALL actual original
   invertible module sheaves by actual GLOBAL sheaf isomorphism. The map
   D↦[O_X(D)] induces a proved bijection Div(X)/div(K_X^*)≃Pic(X).
   Transferring the group structure along this proved bijection gives an
   abelian group, and its addition is proved to be the class of the actual
   sheafified tensor for EVERY arbitrary pair M,N. Zero is the class of
   the original O_X. A genuine tensor inverse is O_X(-D_M); every actual
   iterated tensor power has class n[M], including n=0. Thus n[M]=0 iff
   that entire original tensor-power sheaf is trivial. This proves the
   honest Picard GROUP comparison, but does not supply a representing
   scheme or coherent monoidal category structure.
10. For every actual finite etale surjective h:Z->X over k, the original
    categorical module-sheaf pullback of O_X(D) is isomorphic to
    O_Z(h^*D). Its forward map is the CANONICAL adjunction map of the
    original rational-function pullback, not an arbitrary chosen
    isomorphism. At closed z the actual divisor coefficient is D_(h(z)).
    The actual closed DVRs give unramified order preservation; true local
    generators, tensor sections and sheafification prove the whole map
    is an isomorphism, including every original open.
11. Pulling back an arbitrary actual original invertible sheaf by that
    categorical functor induces the independently defined additive map
    Pic(X)->Pic(Z). The proved divisor-class/Picard equivalence commutes
    with it on ALL classes. For TWO actual finite etale maps f:Z->X and
    g:Z->Y over k from the SAME smooth integral Z, the entire joint
    divisor-class kernel is additively isomorphic to
    ker(f^*-g^*:Pic(X) x Pic(Y)->Pic(Z)). With proper endpoints, original
    rational/divisor gluing classes are also this entire kernel. This is
    a statement about classes and the original divisor gluing quotient;
    it does NOT construct a quotient of actual line-sheaf triples with
    their specified comparison isomorphism, or a representing scheme.

Construct the associator, symmetry and unit comparisons for the genuine
sheafified module tensor, and prove the pentagon, triangle and hexagon
identities. Prove that the supplied literal rational-multiplication
comparisons for O_X(D), its unit and inverse respect these structures,
including every associativity and symmetry diagram. Reuse the supplied
ALL-line classification and honest Picard GROUP comparison; do not spend
the result reconstructing those already-proved bridges. Quotient-level
associativity alone does not establish the requested whole-sheaf coherence.

For an actual finite étale surjective h:Z→X, use the supplied canonical
categorical divisor comparison to prove its identity and composition
coherence and its compatibility with the actual tensor, associator,
symmetry and units. The supplied Picard GROUP naturality may be reused;
it does not establish these whole-sheaf diagrams. In a span
X←f−Z−g→Y, this must work for BOTH actual maps from
the SAME Z; no separable replacement maps or simultaneous Galois closure
may be substituted.

As the precise endpoint of naturality, identify the group of actual
line-bundle triples (L_X,L_Y,φ:f^*L_X≅g^*L_Y), modulo genuine endpoint
isomorphisms, with the corresponding divisor presentation: triples
(D_X,D_Y,c) with div(c)=f^*D_X−g^*D_Y, modulo endpoint principal gauges.
Here assume both endpoints proper, so the original global units are
k^*, and retain the same source and both maps. State every sign and
gauge convention. This last presentation must follow from the proved
classification and naturality; it may not be introduced as a definition
of the line-bundle group.

Use structural algebra and sheaf gluing. Introduce no sorry, goal axiom,
opaque conclusion predicate, or numerical oracle. If a standard
literature result is indispensable in a first pass, state its actual-object
quantifiers as an explicit parameter and distinguish that conditional
interface from the subsequent proof of the parameter. Report any missing
Mathlib foundation honestly; a component build is not the whole bridge.

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
