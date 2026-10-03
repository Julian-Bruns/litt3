# Exclusion of the two minimal index-one spin comparisons

## 0. Result and status

**Theorem.** Under the actual-source hypotheses and the supplied index-one
reductions recorded in the [canonical source statement](../../Theorems/cartier_and_spin/canonical_ten_degree_six_index_one_tensor_exclusion.md), neither **c = 0** nor **c = 1** can occur.
The decision is complete for precisely these two configurations, for every
integer s ≥ 1 and over the entire algebraic closure of F₅.

This is a theoretical proof. **No computational certificates are needed.**
The small executable checks in this archive audit arithmetic used in the
proof; they are not a replacement for the arguments below. No parameter
search, bounded-field search, computational group classification, or
unexecuted elimination is used.

The two exclusions are different:

* For c = 0, the actual ten-sheet component forces an unordered-pair
  resolvent of degree 66 inside Γ. Étaleness forces its genus to be at least
  475, contradicting the genus and degree of Γ.
* For c = 1, descent of the **actual common zero divisor** through the full
  connected fibre product forces t to have ramification index 10 at a common
  infinity. A local calculation on the specified curve forbids this index.

There is no remaining gap in the requested two-case decision. This report
does not assert nonexistence of unrelated sources or comparisons outside
these hypotheses. The previously discarded cubic-root-index-three case is
not used or reworked.

## 1. Conventions and the precise inputs used

All curves are smooth, projective, and geometrically connected over
k = algebraic closure of F₅. Function-field composita and intersections
are embedded composita and intersections. A field is also used to denote
its smooth projective curve when its genus or a morphism is discussed.
Every extension below is separable. Indeed t separates k(Γ), and T/Γ is
separable, so all the intermediate extensions over k(t) are separable.

To avoid confusing the original group G with a monodromy group, write

    F = k(t), A = k(Γ), E = k(B′), K = k(T).

The relevant supplied data are

    K = AE,  [K:A] = 10,  Gal(normal closure of K/A) = S₁₀

in the natural ten-sheet action, and the map π:T→B′ is everywhere étale.
Also g(B′)=97, g(Γ)=24s+1, and [K:E]=5s. The branch data of T→Γ
are not required in the c=0 argument.

For c=0, [E:F]=12 and [A:F]=6s. The base change of E/F to A has
an actual component K of degree 10 and complementary components of total
degree 2. These complementary components are retained throughout §2.

For c=1, [E:F]=10 and [A:F]=5s. Here E⊗_F A is the field K:
T is the normalization of the **whole** fibre product B′×_{P¹_t}Γ.

There are everywhere-étale maps B′→X_i of degree 12. Put

    I_i = (B′→X_i)*O,    S_i = div_Γ(s_i).

The I_i are reduced effective divisors of degree 12. The original section
identities u_i=φ*s_i and div_T(u_i)=h_i*O imply equality of actual divisors

    π*I_i = φ*S_i.                                      (1.1)

The involution ι of B′/C₀ is fixed-point-free, fixes both X-fields, and sends
t to −t. When c=1, the common divisor J=min(I₁,I₂) consists of the two
points above the unique common point on C₀:

    J = p + ι(p).                                       (1.2)

Moreover div_{B′}(t)=I₁−I₂, with the common part cancelled. Thus t is a
unit at p and ι(p). The equation z³=q(x₂)/q(x₁), with z=t², gives

    q(x₂) = t⁶q(x₁).                                   (1.3)

Proportionality of the actual pulled-back tensors τ=q⁸θ³ gives, on B′,

    θ₁ = κ t¹⁶ θ₂   for some κ∈k*.                     (1.4)

To justify the constant carefully, cubing θ₁/(t¹⁶θ₂) gives a nonzero
constant by (1.3) and the tensor proportionality. Since k is algebraically
closed, this ratio itself is constant. We **do not** assume κ=1; the local
proof keeps κ arbitrary. Equality first on T descends to E, since the
pullback on rational differentials is injective for a separable map.

The complete original source packet, including hypotheses not needed
once these reductions are available, is recorded in the [canonical source statement](../../Theorems/cartier_and_spin/canonical_ten_degree_six_index_one_tensor_exclusion.md).

## 2. Exclusion of c=0: the residual pair gives a high-genus subfield

### 2.1. Monodromy of the twelve-sheet bridge

Let L/F be the normal closure of E/F and let

    M = Gal(L/F) ≤ S₁₂.

This action on the twelve F-embeddings of E is faithful and transitive.
Inside a common separable closure containing K and L, put

    H = Gal(LA/A) ≤ M,

using restriction to L. In particular L^H=L∩A. The factors of E⊗_F A
are the H-orbits on the twelve sheets. Let Ω₁₀ be the orbit belonging to
the actual component K, and let Q be its two-element complement.
Full S₁₀ monodromy of K/A means that the image of H on Ω₁₀ is S₁₀.
The action on Q may be transitive or may fix both elements; nothing here
assumes either possibility. In either case

    H ≤ S(Ω₁₀)×S(Q),   H→S(Ω₁₀) is onto.

Since S(Q) is abelian, the commutator subgroup satisfies

    [H,H] = A(Ω₁₀)×{1}.                                (2.1)

Indeed commutators lie in A(Ω₁₀)×{1}, and their projection is
[S₁₀,S₁₀]=A₁₀, proving equality.

**Elementary support lemma.** A transitive subgroup of S₁₂ containing the
alternating group on ten letters, fixing the other two, contains A₁₂.

**Proof.** Conjugate this A₁₀ by elements of the transitive group. Its
conjugate supports have size ten; any two intersect in at least eight
letters. Their union is all twelve letters, since it is a nonempty
invariant subset. Alternating groups on sets S and S′ with at least two
common letters and |S|≥4 generate the alternating group on S∪S′: if a,b
are common and u∈S′\S, the 3-cycle (a b u), together with A(S), supplies
all 3-cycles involving u and two letters of S by 2-transitivity of A(S).
These and A(S) generate A(S∪{u}); repeat for each new letter. Applying
this to the conjugate supports proves the assertion. ∎

Consequently

    M=A₁₂ or M=S₁₂.                                    (2.2)

This argument is independent of any classification of finite groups.

### 2.2. The unordered-pair field lies in the actual Γ

Let J_Q be the setwise stabilizer of Q in M, and define

    R = L^{J_Q}.

Because H preserves Q, H⊂J_Q. Therefore

    R ⊂ L^H = L∩A ⊂ A.                                (2.3)

Both A₁₂ and S₁₂ act transitively on the 66 unordered pairs, so

    [R:F] = binom(12,2) = 66.                          (2.4)

Choose the distinguished sheet corresponding to the actual embedded E;
it lies in Ω₁₀, not in Q. Let V be its stabilizer in M, so E=L^V.
Then V is A₁₁ or S₁₁ on the remaining eleven letters. The compositum ER
is L^{V∩J_Q}; its degree over E is 55. The associated action of V is its
action on the unordered pairs of the remaining eleven letters.

This action is faithful. A permutation fixing every unordered pair fixes
each letter a, by intersecting the fixed sets {a,b} and {a,c} for distinct
b,c. Thus the core of V∩J_Q in V is trivial. Equivalently,

    the normal closure of ER/E is L/E.                 (2.5)

Since E⊂ER⊂K and K/E is everywhere étale, ER/E is everywhere étale.
The normal closure of a finite étale cover is finite étale: it can be
constructed in the category of finite étale covers by taking products and
connected components, or as a quotient of a dominating finite étale
Galois cover [S2]. Hence

    L/E is everywhere étale.                          (2.6)

Only the normal closure of the **single t-map** E/F was introduced.
No simultaneous Galois completion over the two X-projections has been
assumed or constructed.

### 2.3. Étaleness makes the t-inertia semiregular and tame

Let I≤M be an inertia group of L/F at any place. Because k is algebraically
closed, inertia is also the decomposition group. From (2.6), its
intersection with every conjugate of V is trivial. Thus I acts freely on
the twelve sheets. All its orbits have size |I|, and

    |I| divides 12.

In characteristic five this implies tameness. Tame inertia is cyclic
[S3]. At a branch value write e=|I|. Then

    e∈{2,3,4,6,12},

and an inertia generator is a product of 12/e disjoint e-cycles. On E,
the contribution of this branch value to the different is

    d_E(e)=12−12/e.                                    (2.7)

Riemann–Hurwitz [S1] gives

    deg Diff(E/F) = (2·97−2)+2·12 = 216.                (2.8)

### 2.4. Ramification in the pair action

Consider the same cyclic inertia on the 66 unordered pairs. If e is odd,
no nonidentity element can fix a pair: it cannot fix an individual
letter, and a nontrivial permutation of a pair has order two. Therefore
there are 66/e pair orbits.

If e is even, the unique involution in I exchanges six disjoint pairs of
letters. Exactly these six unordered pairs have stabilizer of order two;
the other sixty have trivial stabilizer. Thus the number of pair orbits
is 6/(e/2)+60/e=72/e. Accordingly the different contribution on R is

    d_R(e) = 66−66/e       if e is odd,
             66−72/e       if e is even.              (2.9)

For every allowed e,

    d_R(e) ≥ 5 d_E(e).                                 (2.10)

For odd e the difference is 6(1−1/e); for even e it is 6−12/e≥0.
The exact table, also checked directly by the executable pair action, is

| e | Point cycles | Pair cycles | d_E(e) | d_R(e) |
|---|---:|---:|---:|---:|
| 2 | 6 | 36 | 6 | 30 |
| 3 | 4 | 22 | 8 | 44 |
| 4 | 3 | 18 | 9 | 48 |
| 6 | 2 | 12 | 10 | 54 |
| 12 | 1 | 6 | 11 | 60 |

Summing (2.10) and applying Riemann–Hurwitz to R/F,

    2g(R)−2 = −132+deg Diff(R/F)
              ≥ −132+5·216 = 948.

Therefore

    g(R) ≥ 475.                                       (2.11)

### 2.5. Contradiction with the actual Γ

Since R⊂A, [A:F]=6s, and [R:F]=66, necessarily 11 divides s and
[A:R]=s/11. Riemann–Hurwitz for the separable map Γ→R, allowing arbitrary
wild ramification in this map, gives

    48s = 2g(Γ)−2 ≥ (s/11)(2g(R)−2) ≥ 948s/11.

This is impossible for s>0, since 48·11=528<948.
Thus **c=0 is excluded**.

Equivalently, the actual Γ has genus-to-degree ratio
(2g(Γ)−2)/[A:F]=8, whereas any Γ containing this R must have ratio at
least 948/66=158/11>8.

## 3. Exclusion of c=1: common zeros force forbidden local ramification

### 3.1. A divisor-support lemma for a whole fibre product

**Lemma (fibre saturation).** Let E₀→P¹ and A₀→P¹ be finite separable
maps of smooth curves, whose fibre product has a single function field.
Let W be its normalization, with projections π₀:W→E₀ and ψ₀:W→A₀.
If effective divisors J₀ on E₀ and C₀ on A₀ satisfy

    π₀*J₀ = ψ₀*C₀,

then supp(J₀) is a union of complete set-theoretic fibres of E₀→P¹.

**Proof.** For every pair (p,γ) over the same point of P¹ there is a point
of W over that pair: normalization is finite and surjective onto the
whole fibre product. Fix p∈supp(J₀), and choose any γ over its base value.
A point over (p,γ) belongs to supp(π₀*J₀), so γ∈supp(C₀). For any other
p′ over the same base value, a point over (p′,γ) then belongs to
supp(ψ₀*C₀), forcing p′∈supp(J₀). ∎

This lemma is **not** applied in c=0, where the actual source is only one
component of the twelve-sheet base change.

### 3.2. Applying the actual original section divisors

For c=1, the supplied connected full-degree base change identifies T with
the normalization of B′×_{P¹_t}Γ. Taking coefficientwise minima in (1.1)
is legitimate: a pullback multiplies both divisor coefficients at a given
point by the same ramification index. Thus

    π*J = φ*C,  J=min(I₁,I₂), C=min(S₁,S₂).            (3.1)

By (1.2), J=p+ι(p). Put a=t(p). Because the common part was cancelled
from div(t), a is finite and nonzero. Since ι(t)=−t,

    t(ι(p))=−a ≠ a.

The fibre-saturation lemma says that the entire fibre of t:B′→P¹ over a
is supported on p alone. The degree of this map is ten. Residue fields
are k, so the fibre divisor is 10p; in particular

    ord_p(t−a)=10.                                     (3.2)

Both B′→X_i are étale at p and send p to O. Consequently, in the completed
local field k((r)) at p,

    ord(x₁)=ord(x₂)=−3,
    ord(y₁)=ord(y₂)=−10,
    ord(dx₁/dr)=ord(dx₂/dr)=−4.                       (3.3)

Equations (1.3) and (1.4) hold there. The following local lemma contradicts
(3.2).

### 3.3. The local infinity obstruction, with the scalar retained

**Local lemma.** Suppose x,y and x̃,ỹ in k((r)) satisfy

    y³=P(x),  ỹ³=P(x̃),
    ord(x)=ord(x̃)=−3,  ord(y)=ord(ỹ)=−10,

and t is a unit with

    q(x̃)=t⁶q(x),
    dx/y² = κ t¹⁶ d x̃/ỹ²    for some κ∈k*.

Then ord(t−t(0)) cannot equal ten.

**Proof.** Write a=t(0)∈k*, δ=t−a, and assume ord(δ)=10. Write
O(r^j) for an element of valuation at least j. Set

    ξ=x+1,  ξ̃=x̃+1,  Δ=[23],  q(x)=ξ²+Δ.

Let λ be the nonzero leading residue of ξ̃/ξ. The quadratic identity
implies λ²=a⁶. The exact identity

    (ξ̃−λξ)(ξ̃+λξ)
       = (t⁶−a⁶)ξ² + Δ(t⁶−1)                        (3.4)

has right side of valuation at least zero and second factor on the left
of valuation −3. Hence

    ξ̃=λξ+O(r³),   dξ̃/dξ=λ+O(r⁶).                    (3.5)

For the derivative assertion, ord(dξ/dr)=−4; differentiating a series of
valuation at least 3 gives valuation at least 2.

Let Q(U)=P(U−1). Its two leading coefficients are

    Q(U)=U¹⁰+p₉U⁹+terms of degree ≤8,
    p₉=[22]=2+4β ≠0.                                 (3.6)

The coefficient of U⁹ contributed by (U−1)¹⁰ is −10=0 in characteristic
five, so p₉ is exactly the stated x⁹ coefficient of P. Expanding (3.5),

    P(x̃)/P(x)
      = λ¹⁰(1+p₉(λ⁻¹−1)ξ⁻¹+O(r⁶)).                  (3.7)

If μ is the leading residue of ỹ/y, then μ³=λ¹⁰. Since 3 is invertible,
(3.7) gives

    (ỹ/y)²
      = μ²(1+(2/3)p₉(λ⁻¹−1)ξ⁻¹+O(r⁶)).               (3.8)

The differential relation can be written

    dξ̃/dξ = κ⁻¹t⁻¹⁶(ỹ/y)².                         (3.9)

Its constant term is λ=κ⁻¹a⁻¹⁶μ². Since t⁻¹⁶=a⁻¹⁶+O(r¹⁰), comparing
(3.5) with (3.8) in (3.9) forces the coefficient at valuation three to
vanish. Because p₉≠0 and 2/3≠0, this proves

    λ=1,   a⁶=1.                                     (3.10)

This step is why an arbitrary proportionality scalar κ cannot evade the
obstruction. We never normalized κ to one.

Put ε=x̃−x=ξ̃−ξ. Using a⁶=1 in (3.4),

    ε(2ξ+ε)=(t⁶−1)(ξ²+Δ).

In characteristic five,

    t⁶−1=a⁻¹δ+O(r⁵⁰).

It follows first that ord(ε)=7, and then, by division by 2ξ+ε, that

    ε = δξ/(2a)+O(r¹³).                              (3.11)

For clarity, the first correction from Δ/ξ² has valuation six, hence
raises the leading valuation seven to thirteen; the denominator correction
ε/(2ξ) has valuation ten and is higher still.

The crucial characteristic-five point is that ord(δ)=10 implies
ord(dδ/dr)≥10: the derivative of its leading r¹⁰ term is zero. Thus

    ord(dδ/dξ)≥14.

Differentiate (3.11) and use ord(ξ)=−3. This gives

    dξ̃/dξ = 1+δ/(2a)+O(r¹¹).                         (3.12)

On the other hand, ord(ε)=7 yields

    P(x̃)/P(x)=1+O(r¹³).                              (3.13)

Here is a direct check of this precision. The degree-ten term satisfies
(x+ε)¹⁰−x¹⁰=2x⁵ε⁵+ε¹⁰, of valuation at least 20. For each j≤9, every
term of (x+ε)^j−x^j has valuation at least 10−3j≥−17. Division by
P(x), whose valuation is −30, gives (3.13). Taking the cube root with
leading coefficient μ and then squaring gives

    (ỹ/y)²=μ²(1+O(r¹³)).

The constant term in (3.9), now λ=1, is μ²=κa¹⁶. Consequently (3.9)
also gives

    dξ̃/dξ = (t/a)⁻¹⁶(1+O(r¹³))
            = 1−δ/a+O(r¹³),                          (3.14)

because 16=1 in characteristic five. Equations (3.12) and (3.14) imply

    (3/(2a))δ ∈ O(r¹¹).

The coefficient 3/(2a) is nonzero in characteristic five, while
ord(δ)=10. This is the required contradiction. ∎

Applying the local lemma at the common point p contradicts (3.2).
Therefore **c=1 is excluded**.

## 4. Dependency audit and scope

The proof for c=0 uses only: the genus-97 bridge E, its degree-twelve
separating t-map, the actual ten-sheet base-change component with full
S₁₀ monodromy, K/E étale, and the degree/genus data for Γ. It does not
use an assumed descent of an X-map or Y-map to a new quotient.

The proof for c=1 uses: the full connected degree-ten base change; the
original sections, so that (1.1) is equality of actual divisors rather
than merely linear equivalence; the nonsplit involution and the unique
common infinity; the étaleness of B′→X_i; and the exact tensor and q
identities. It does **not** require S₁₀ monodromy beyond what was already
used to supply the packet's reductions.

The original G-action, its inertia, ordinarity of Y, all same-field
primitivity statements, and the remaining spin identities are retained
as hypotheses in the [canonical source statement](../../Theorems/cartier_and_spin/canonical_ten_degree_six_index_one_tensor_exclusion.md). Their additional constraints can only
shrink the configurations excluded here. They are not replaced by a
model satisfying merely necessary equations.

The reductions supplied with the question are accepted hypotheses, not
new claims independently established by this archive. Every new step in
the decision is proved above. In particular, the original index-one
embedded-field equalities are never silently replaced by a ramification
condition or by a simultaneous y-deck quotient.

## 5. Reusable results

**Residual-pair obstruction.** In characteristic five, let E/F=k(B)/k(t)
be a separable degree-twelve function-field extension, and suppose a
finite separable function-field extension A/F has a degree-ten component K of E⊗_F A with full S₁₀
monodromy. If K/E is étale, then A contains a degree-66 unordered-pair
resolvent R/F, the normal closure L/E is étale, all inertia of L/F is
semiregular cyclic of order dividing twelve, and

    2g(R)−2 ≥ 10(g(B)−1)−12.

The proof is exactly §2, with 216 replaced by 2g(B)−2+24. Thus any such
A satisfies (2g(A)−2)/[A:F] ≥ [10(g(B)−1)−12]/66. The genus-97 packet
violates this necessary bound.

**Fibre saturation of actual divisors.** Section 3.1 applies to any full
connected normalized fibre product, independently of monodromy and
ramification. The equality of effective pullbacks, not equality of their
line-bundle classes, is essential.

**Local obstruction.** Section 3.3 only requires a monic degree-ten P
with nonzero x⁹ coefficient, the pole orders −3 and −10, characteristic
five, and q=(x+1)²+Δ. No other coefficient of the given P is needed.
The stated lemma is specifically the exclusion of local index ten;
no broader local classification is claimed.

## 6. Approaches not used and remaining problems

Ordinary Castelnuovo–Severi bounds for B′→X and B′→P¹ do not give the
needed contradiction: at degrees 12 and 10 or 12 the bounds exceed 97.
No inference from such an insufficient bound is included in the proof.
Likewise, a group-theoretic model alone or a norm-square identity would
not construct the required source, and is not used as a witness.

For c=0, treating the entire degree-twelve base change as connected would
be invalid. The actual complement of two sheets is instead the reason
the degree-66 resolvent lies in Γ. For c=1, ignoring the original common
section divisor would lose the forced total ramification. Finally,
ignoring the derivative cancellation of r¹⁰ in characteristic five would
invalidate the local calculation; (3.12) explicitly includes it.

No search was run over s, finite coefficient fields, covers, or branch
partitions. The five-item inertia table is an exhaustive symbolic
consequence of the proved divisibility e|12, not a bounded search for
configurations. No unexecuted code or unverified intermediate assertion
is needed for either exclusion. There is no open step within the stated
two-case problem. Other joint degrees, a split quadratic class, or
comparisons outside the supplied actual-source packet are outside scope.

## 7. Verification and literature dependencies

Read §§2–3 for the proof. Run `python3 src/verify.py` for the independent
small arithmetic audit, and `python3 src/verify_manifest.py` for archive
integrity. Exact commands, environment versions, and executed results
are in `README.md`, `CHECKS.md`, and `evidence/verification.log`.

The group-action and local-infinity lemmas used for the exclusions are
proved in full here. Standard background is referenced as follows;
these sources are not being credited with the new exclusions.

* **[S1]** The Stacks Project, Tag **0C1B**, “Riemann–Hurwitz,” especially
  the formula with the effective different and the tame contribution
  e−1. https://stacks.math.columbia.edu/tag/0C1B
* **[S2]** The Stacks Project, Tag **03SF**, “Galois covers of connected
  schemes,” existence of a finite étale Galois cover dominating a given
  connected finite étale cover. https://stacks.math.columbia.edu/tag/03SF
* **[S3]** The Stacks Project, Tag **09E3**, “Galois extensions and
  ramification,” the wild/tame inertia exact sequence and cyclicity of
  prime-to-characteristic inertia.
  https://stacks.math.columbia.edu/tag/09E3

These primary references were consulted on 2026-10-03. Stable tag
identifiers, rather than mutable section numbering, identify the cited
material. All facts needed beyond this standard background are proved
in this report, so verification does not depend on downloading a paper
or recovering any earlier conversation or archive.

## Local provenance

Original reply preserved at ../litt3-computation-data/pro_replies/canonical_identity_frontier_2026_10_03/spin_index_one_complete/. Independent whole PASS: Research/audits/PRO_SPIN_INDEX_ONE_COMPLETE_AUDIT_2026_10_03.md. No settled numeric replay.
