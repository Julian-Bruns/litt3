# Original canonical degree from genuine curve cohomology

Construct and prove, for the actual original sheaves of a smooth proper
integral curve C over an algebraically closed field k, the Riemann–Roch
identity
dim_k H^0(C,O_C(D)) - dim_k H^1(C,O_C(D)) = deg(D) + 1 - g(C)
for every finite integral divisor D, and deduce
dim_k H^0(C,Omega^1_(C/k)) = g(C) and
deg(div(omega)) = 2g(C)-2 for every nonzero original rational differential.
Here g(C) is dim_k H^1(C,O_C), with H^1 the genuine sheaf cohomology.
Renaming differential H0 as genus or supplying the requested degree
identity as a hypothesis does not establish these conclusions.

Use Lean 4 v4.27.0-rc1 and Mathlib revision
32d24245c7a12ded17325299fd41d412022cd3fe. Return self-contained source
and explicit mathematical input interfaces. Custom imports unavailable
to a fresh instance cannot replace those interfaces. Allowed logical
axioms are Classical.choice, propext and Quot.sound; no sorry, new
research-goal axiom or numerical oracle is allowed.

Let s_C:C -> Spec(k) be the actual structure morphism, smooth of relative
dimension one, proper, with C integral. All characteristics are allowed.
Use the original structure-sheaf ring O_C, its genuine module-sheaf
category and the original generic-stalk function field K.
Closed points are closed points of the original topological space.
Div(C) consists of finite-support integer functions on those points.
For a nonzero original scalar a, ord_x(a) is the normalized original DVR
order, positive on a uniformizer. The original principal divisor is
div(a)=(ord_x(a))_x. Define deg(D)=sum_x D_x; residues are k at closed
points under these hypotheses.

The rational-function sheaf is the actual generic-point skyscraper of K,
with original O_C action. O_C(D) is its genuine subsheaf of sections a
satisfying ord_x(a)+D_x>=0 at every closed x in the chosen open, with zero
allowed and actual restrictions including the empty open. The relative
differential sheaf Omega is the original O_C-module sheafification of
U -> Omega^1_(Gamma(C,U)/k), with original section-ring restrictions and
the coefficient action induced by s_C. Its powers use the genuine
sheafified tensor product, with O_C as power zero.

The following exact results may be reused as established inputs.

1. Every original closed stalk is a DVR, constructed from actual smoothness.
   Principal support is finite. Genuine all-stalk regularity detects
   original structure-sheaf sections, and properness proves
   Gamma(C,O_C)=k with its actual coefficient embedding.
2. Each displayed O_C(D) is a genuine locally free rank-one sheaf, with
   derived actual local principal frames. Literal rational multiplication
   gives O_C(D) tensor O_C(E) isomorphic to O_C(D+E); O_C(0) is the
   original O_C. For every n>=0 the actual tensor power of O_C(D) is
   the whole original O_C(nD). Full monoidal coherence is not supplied.
3. Every actual locally free rank-one O_C-module sheaf has a constructed
   whole-sheaf divisor presentation. The quotient of ALL such sheaves by
   actual global isomorphism is additively isomorphic to
   Div(C)/div(K^*), and addition is the actual sheafified tensor product.
   This is an honest group of line-sheaf classes, not a representing
   Picard scheme and not a degree or cohomology theorem.
4. On every nonempty original open U, a rational differential is an
   original differential-sheaf section iff it belongs to every original
   closed-stalk differential image over U. Its rational realization is
   injective and the inverse uses actual local lifts and sheaf gluing.
   Empty opens have their genuine unique zero section.
5. For every nonzero omega in Omega^1_(K/k), the integer orders computed
   from any ORIGINAL integral differential frame agree. Their support is
   finite, giving the actual divisor div(omega). Multiplication by a
   nonzero original scalar gives div(a omega)=div(a)+div(omega).
   The actual original coefficient map eta -> eta/omega constructs the
   WHOLE module-sheaf isomorphism Omega isomorphic to O_C(div(omega))
   on every open. Consequently each actual tensor power Omega^(tensor n)
   is the whole O_C(n div(omega)), including n=0. These assertions do
   NOT supply deg(div(omega)), Riemann–Roch or a genus/H0 identification.
6. For an actual finite etale surjective morphism h:C -> D between
   such curves, the canonical adjunction map
   h^*O_D(E) -> O_C(h^*E) is a genuine whole-sheaf isomorphism.
   The divisor pullback has coefficient E_(h(x)) at closed x.
   The original universal differential pullback is injective and satisfies
   div(h^*omega)=h^*div(omega). Its ACTUAL categorical adjunction map
   h^*Omega_D -> Omega_C itself is proved an isomorphism, extending the
   whole original universal presheaf map through sheafification.
   No canonical degree theorem is supplied.

Define H^i(C,M) from the ACTUAL original sheaf and derived global section
functor, with its original k action. If using Mathlib's abelian-sheaf
cohomology Sheaf.H, prove the relevant agreement with the module-sheaf
cohomology construction; merely assigning a new vector space to H^1 is
not acceptable. Prove finite dimensionality in degrees zero and one,
and the vanishing above degree one needed by the argument.

Construct the original closed-point short exact sequence
0 -> O_C(D) -> O_C(D+x) -> i_(x)*k -> 0,
including its true quotient map, and derive its cohomological Euler
characteristic identity from the actual long exact sequence. Its final
one-dimensional quotient must follow from the original DVR and residue
field, rather than being an assumed length. Prove the formula for every
integral divisor, including negative coefficients, with the normalization
chi(O_C)=1-g(C).

Construct a functorial nondegenerate Serre pairing for actual original
sheaves that identifies H^1(C,M)^* with
Hom_(O_C)(M,Omega). Derive the two differential-dimension identities
H^0(Omega) of dimension g(C) and H^1(Omega) of dimension one from this
actual pairing and original proper constants. Combine them with the
proved divisor presentation and Euler characteristic formula to obtain
the canonical degree identity. The primary completion is this complete
original-object Riemann–Roch/Serre/canonical-degree bridge.

Standard accepted literature may be used in the first pass through
precisely quantified inputs for GENERAL coherent-cohomology finiteness,
duality and derived-functor exactness on the actual objects. Separate
those conditional interfaces from proofs of their foundations. Do not
use the specialized Riemann–Roch identity, dim H0(Omega)=g(C), canonical
degree formula, or a model declared to have these properties as inputs.
Specify the minimal actual-object foundation still needed if some
general input is not established in the supplied Lean project.

As the map-sensitive consequence, use BOTH actual finite etale maps
X <-f- Z -g-> Y of smooth proper integral curves over the SAME k, with
their structure composites equal. For a genuine common nonzero canonical
tensor of weight n>0, show that its true effective divisor has degree
n(2g(Z)-2) and that each original endpoint tensor divisor has degree
n(2g(X)-2) or n(2g(Y)-2), respectively. Keep each actual divisor pullback;
neither arbitrary separable replacements nor a presumed simultaneous
Galois closure may replace the span. No existence of such a common tensor,
clump, canonical root, or unmarked common cover is asserted.

Supply the exact proved statements, their actual-object dependencies,
standalone Lean source, and the executed verification evidence.

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
