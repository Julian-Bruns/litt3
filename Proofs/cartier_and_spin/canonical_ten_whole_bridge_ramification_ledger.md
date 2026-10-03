# Proof: an étale whole base change cannot hide multiple folded sheets

Version1, 3 October2026. [Independent whole review PASS](../../Research/audits/OCT03_WHOLE_BRIDGE_RAMIFICATION_AUDIT_2026_10_03.md). See the [statement](../../Theorems/cartier_and_spin/canonical_ten_whole_bridge_ramification_ledger.md).

All curves are over an algebraically closed field k of characteristic FIVE. Completions at a geometric point have residue field k, so a connected finite unramified extension of a completed local field is trivial. At v∈R let K=k((r_v)), let A_i/K run through the completed fields of A, and let B_j/K run through those of B. Put a_i=[A_i:K] and b_j=[B_j:K]. The normalization of the whole fiber product supplies ALL factors of A_i⊗_K B_j for EVERY pair i,j.

## Étaleness supplies every local embedding

Since T→B is étale, every field factor of A_i⊗_K B_j is unramified over B_j, hence equals B_j. Thus every K-embedding of A_i into an algebraic closure lands in B_j. Equivalently, the minimal polynomial of a primitive generator of A_i splits over B_j. In particular a_i divides b_j. There are exactly a_i field factors for this pair, each equal to B_j. As a field over A_i, each has degree b_j/a_i. Its ramification index is that degree, since the residue fields are k.

The original φ hypothesis therefore gives b_j/a_i∈{ONE,TWO} for every pair. If b_j/a_i=TWO, each of the a_i factors contributes a point of the φ-fiber with index TWO. The at-most-one-fold hypothesis forces a_i=ONE.

## A fold forces the whole downstairs single-fold profile

Suppose φ has a fold over some A_i. The preceding argument gives A_i=K. In that fiber the number of folds is exactly the number of j with b_j=TWO, and all b_j are ONE or TWO. There is exactly ONE such j. Since Σ_j b_j=TEN, the B/R profile is (TWO,ONE⁸).

Choose one of the EIGHT B_j=K. Étaleness of T→B applied to every A_l⊗_K K forces every A_l=K. Thus A/R is entirely unramified above v, and every A-point has the same single-fold φ-profile. The quadratic extension is tame because TWO is prime to FIVE.

## Absence of folds forces the common Galois local field

If there is no fold over any A-point above v, then every φ-factor is unramified over A_i as well. Its field is B_j by étaleness over B, so B_j equals the embedded A_i for EVERY pair. All the local fields are consequently K-isomorphic to one finite separable field K′/K of common degree e. The earlier splitting property applied to A_i and B_j now says the defining separable polynomial of K′ splits over K′ itself. Hence K′/K is Galois.

There are TEN/e points of B above v, so e divides TEN. Each A-point has this same Galois local completion. In the single normal closure Z of A/R, its local splitting field is therefore K′ itself, and Z→A has no ramification. This holds at every v, proving that Z→A is étale. It is the closure of this ONE carrier leg, not a simultaneous closure of endpoint maps.

## Verify the actual canonical fold hypothesis

The accepted [fixed endpoint theorem](canonical_ten_fixed_backup_endpoint_normal_form.md) puts the image of P₀ at a third quotient value, distinct from both the weak-C₅ and tame-C₂ branch values of Γ→Γ/G. The divisor q*P₀ is ONE free G-orbit of size N on T. Its image under the G-equivariant φ is one orbit above that ordinary quotient value, also of size N on Γ. The map between these transitive G-sets is therefore a bijection. Each point of q*P₀ has index TWO and different exponent ONE; there is no other ramification. Thus every φ-fiber contains at most ONE folded point. This step uses the exact existing quotient square and third-value classification, not mere reducedness of a different divisor.

## The exact global ledgers

Let S⊂R be the finite set of single-fold values. A/R is unramified there, so each v∈S has m A-points, each with one simple fold upstairs. Consequently
\[
\deg\operatorname{Diff}_\phi=m|S|.
\]
For the actual source, the left side is N. This gives |S|=EIGHTY in the split case and ONE HUNDRED SIXTY in the nonsplit case.

At a uniform point v with common local field K′ of degree e and different exponent δ, its contribution to the B/R different is (TEN/e)δ, whereas its contribution to A/R is (m/e)δ. Thus the uniform different of B is TEN/m times the whole different of A. The single-fold contribution of B is exactly |S|.

For split B of genus EIGHTY ONE over P¹, Hurwitz gives degDiff(B/R)=ONE HUNDRED EIGHTY; subtracting EIGHTY leaves ONE HUNDRED. Hurwitz for g(A)=FOUR m+ONE gives degDiff(A/R)=TEN m, consistently.

For nonsplit g(B)=ONE HUNDRED SIXTY ONE and g(R)=g, Hurwitz gives
\[
\deg\operatorname{Diff}(B/R)=340-20g.
\]
Subtracting ONE HUNDRED SIXTY leaves TWENTY(9−g). Hurwitz for g(A)=EIGHT m+ONE gives degDiff(A/R)=TWO m(9−g).

## The genus-eight boundary has no wild uniform inertia

When g=NINE, the uniform different is ZERO and A/R is étale.

When g=EIGHT, the uniform different of B/R is TWENTY. A nontrivial uniform tame field has degree TWO (the only prime-to-FIVE divisor of TEN), and contributes FIVE to this total. A uniform wild field of degree FIVE is cyclic C₅, with lower break b≥ONE and different exponent FOUR(b+ONE). Its TWO B-points contribute EIGHT(b+ONE); the only such contribution not exceeding TWENTY is SIXTEEN. A uniform wild field of degree TEN has inertia of order TEN with wild subgroup C₅ and different exponent NINE+FOUR b, b≥ONE. Its sole B-point contributes THIRTEEN orSEVENTEEN if its contribution is at most TWENTY; all larger breaks exceed TWENTY.

Two wild values contribute at least TWENTY SIX, exceeding the budget. ONE wild value leaves FOUR,SEVEN orTHREE, none divisible by FIVE and hence none fillable by tame contributions. There is therefore no wild uniform value. Exactly FOUR tame uniform values remain, each with profile TWO⁵. This uses the elementary lower-ramification different sum, with no finite-field search or assertion that every numerical break occurs.

Both original finite étale maps stay on the same T throughout. The result restricts the actual whole bridge and leaves its global existence and tensor compatibility open.
