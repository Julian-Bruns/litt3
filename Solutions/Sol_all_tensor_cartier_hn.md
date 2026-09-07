# Proof: Cartier operator model and all full tensor HN polygons

[Statement and audit metadata](../Theorems/Thm_all_tensor_cartier_hn.md).
Use its notation. The [Cartier foundation, Proposition2](../routes/global/22_CARTIER_BUNDLE_ETALE_FUNCTORIALITY_AND_LIMITS.md)
supplies stability of B, its perfect alternating Raynaud pairing into
ω1, and the diagonal-ideal filtration of I=F^*B.

## 1. Operators give the actual endomorphism filtration

In an étale coordinate t, D_+^(≤m) has basis ∂_t,…,∂_t^m for m<p.
The intrinsic order symbol identifies its jth quotient with T^j,
since j! is invertible. These operators are O_C1-linear; killing1
therefore makes their action descend to B.

For m=p−2 this action has trace zero. With u=t^p, bases over O_C1 are
t,…,t^(p−1) for B and t^a∂_t^j for the source, where
0≤a<p and1≤j≤p−2. A diagonal entry requires a=j, because the exponent
shift a−j lies strictly between −p and p. Its trace is then

    ∑_(i=1)^(p−1) i(i−1)⋯(i−j+1)=0.

The summand has degree j<p−1 and zero constant term, and each relevant
power sum over F_p vanishes. Constant images disappear in B.

At a geometric Frobenius fiber take R=k[t]/(t^p). If D acts trivially
on R/k, its image consists of constants, so ∂_t∘D acts as zero on R.
The operators1,∂_t,…,∂_t^(p−1) are R-linearly independent: test
successively on1,t,…,t^(p−1), using the invertible factorials.
But a nonzero D of top order m≤p−2 gives ∂_t∘D top coefficient
equal to that of D at order m+1≤p−1, a contradiction. Thus the map is
fiberwise injective. Both bundles have rank p(p−2)=(p−1)²−1;
trace is surjective because tr(id)=p−1≠0. This proves

    End(B)=O_C1⊕F_*Q,   Q=D_+^(≤p−2).

Exact pushforward of the order filtration has quotients F_*T^j.
They are stable by [Sun, Theorem2.2](https://arxiv.org/pdf/math/0611360),
and Riemann–Roch gives slope (p−1−2j)s/p. Strict descent in j makes
this exactly the HN filtration of End_0(B). Its middle rank-p quotient
j=(p−1)/2 joins the scalar line in End(B). Nothing here asserts that
order is preserved under composition of the represented operators.

## 2. A direct-sum recursion, not tensoring an HN filtration

Give Q its order weights −j and I its diagonal-ideal weights i:

    gr(Q)=⊕_(j=1)^(p−2) ω_C^(-j),
    gr(I)=⊕_(i=1)^(p−1) ω_C^i.

Higher weights are subbundles. More explicitly, evaluation splits
the unit in F^*F_*O_C and identifies its quotient F^*B with the ideal
I=(α) in O_C[α]/(α^p); I^i/I^(i+1)=ω_C^i.

The Raynaud pairing gives B⊗B≅ω1⊗End(B). Hence the projection formula
gives, for n≥2, an actual direct sum

    B^(⊗n) ≅ (ω1⊗B^(⊗(n−2)))
              ⊕ (ω1⊗F_*(I^(⊗(n−2))⊗Q)).             (1)

The total-weight filtration on the second pushforward has one copy
of ω_C^k before pushforward for each tuple

    1≤i_1,…,i_(n−2)≤p−1,  1≤j≤p−2,
    k=i_1+⋯+i_(n−2)−j.                              (2)

These are genuine vector-bundle subquotients: local module splittings
identify the associated graded of the tensor filtration. No global
splitting of I or Q, and no deletion of extension data, is assumed.
After exact F_* and the ω1 twist, the weight-k quotient is a sum of
stable bundles ω1⊗F_*ω_C^k of slope

    (3p−1+2k)s/p.                                    (3)

Strict ordering in k identifies this filtration with the HN filtration
of the second summand in (1). Merge its slopes with those of the first
summand, starting with H_0=1 and the stable B. Counting (2) yields exactly
the statement's recursion p z^(3p−1)A(z)^(n−2)D(z).

The extreme weights in (2) are (n−2)(p−1)−1 and n−p. Substitution
in (3) and induction in (1) prove the claimed extreme slopes.
For p=3 a first-summand extreme may tie, but never exceed, these.
For example p=5,n=3 gives ranks5,10,15,4,15,10,5 at normalized
slopes2,12/5,14/5,3,16/5,18/5,4, summing to64.
Finally B^∨≅B⊗ω1^(-1) reduces all mixed powers to a line twist.

## 3. The two distinct characteristic-five bundle models

Assume p=5. The Raynaud pairing is ⟨a,b⟩=Cartier(a db), and identifies
the rank-ten symplectic Lie algebra bundle with Sym²(B)⊗ω1^(-1).
The derivation subbundle L=F_*T in Section1 lies in sp(B): for D=f∂_t,

    Cartier((Da)db+a d(Db))
      =Cartier((Da)db−(da)(Db))=0.

Cartier kills the discarded exact form d(a Db), and
(Da)db=(da)(Db) in one dimension. This is a global subbundle assertion.

The trace pairing on sp4 is perfect in characteristic five. In block
form [P Q; R −P^t], with Q,R symmetric, it pairs P-blocks by twice
matrix trace and pairs Q,R perfectly. Its restriction to L is zero:
L and L^∨ are stable of slopes2s/5 and−2s/5, so Hom(L,L^∨)=0.
Thus L is a rank-five Lagrangian and gives

    0 → L → Sym²(B)⊗ω1^(-1) → L^∨ → 0.              (4)

Its stable end terms have decreasing slopes, so (4) is the full HN
sequence, giving the two asserted symmetric-square slopes.

Contraction with the inverse alternating form splits
Λ²(B)⊗ω1^(-1)=O_C1⊕P; its contraction factor2 is invertible.
The adjoint decomposition then gives End_0(B)=sp(B)⊕P.
Section1 gives ranks5,5,5 and slopes2s/5,0,−2s/5 for End_0(B);
(4) accounts for the nonzero slopes. Consequently P is semistable of
slope0, and its projection to the unique middle HN quotient identifies
it with F_*T². Sun's theorem makes it stable. Adding the scalar line
and twisting by ω1 gives the asserted B⊗B polygon.

## 4. Functoriality, evidence, and limits

B, I, Q, their filtrations, relative Frobenius pushforward and the
Raynaud pairing commute with finite étale base change. No Galois
hypothesis, division by a covering degree, or simultaneous lift is used.
The two existing audits cover respectively Sections1/3 and Section2;
the theorem records their separate dates and scopes. Exact local matrix
tests at p=3,5,7,11,13 and t^p=0,1,2 gave ranks3,15,35,99,143;
they are sanity checks, not the all-prime proof.

The [all-symmetric-power theorem](Sol_all_symmetric_cartier_hn.md)
needs its independent derivation/saturation argument. For n≥p,
Sym^n(B) need not split off B^(⊗n), and a quotient's maximum slope may
exceed its source's. Indeed, pth powers inject F_abs^*B into Sym^p(B),
yielding a line of degree2(p−1)s, greater than μ_max(B^(⊗p)).
Thus tensor polygons do not determine arbitrary subquotients.
These universal normalized polygons supply no common-cover exclusion
and do not imply finiteness of coreless correspondences.
