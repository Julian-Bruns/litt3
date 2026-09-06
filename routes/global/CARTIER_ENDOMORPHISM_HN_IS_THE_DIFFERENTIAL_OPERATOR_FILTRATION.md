# The Cartier endomorphism HN filtration is the differential-operator filtration

Author: /root, 2026-09-06. Status: independently audited PASS by
`/root/cartier_endomorphism_hn_major_audit`, 2026-09-06, with no breaking
objection; [audit record](audits/CARTIER_ENDOMORPHISM_HN_AUDIT_2026_09_06.md).
This computes a universal invariant, not a counterexample to Litt3.
It rules out the endomorphism and, in characteristic five, symmetric-square
slope polygons as curve-separating invariants.

Let C be a smooth connected projective curve of genus g>=2 over an
algebraically closed field of odd characteristic p. Write F:C->C1 for
relative Frobenius, B=F_*O_C/O_C1, T=T_C, and s=g-1. The notation
End_0 means trace-zero endomorphisms. All HN slopes below are ordinary
bundle slopes on C1, not slopes after another Frobenius pullback.

## 1. Canonical operator model

Let D_+^{<=m} be the O_C-module of k-linear differential operators on
O_C of order at most m which kill1. For 1<=m<p its order filtration has

    D_+^{<=1}=T,
    D_+^{<=j}/D_+^{<=j-1}=T^j.                         (1)

Indeed, in an etale coordinate t it has basis partial_t,...,partial_t^m.
The usual order symbol is coordinate-independent and identifies the
successive quotient with T^j; j! is invertible in this range.

**Theorem.** Acting on functions modulo pth powers gives a canonical
isomorphism of vector bundles on C1,

    F_*D_+^{<=p-2}  ~=  End_0(B).                     (2)

This is an isomorphism of filtered vector bundles after putting the
order filtration on the left. It is not asserted to preserve order
under composition of operators: that assertion would be false.

### Proof

Operators of order<p are O_C1-linear: locally every positive derivative
kills pth powers. An operator killing1 therefore kills O_C1 and induces
an endomorphism of B. This construction is intrinsic.

First check the trace. Locally put u=t^p. As an O_C1-module, B has basis
t,...,t^(p-1), and F_*D_+^{<=p-2} has basis

    t^a partial_t^j,  0<=a<p, 1<=j<=p-2.

On the indicated B-basis, such an operator can have a diagonal entry
only if a=j: the exponent shift a-j lies strictly between -p and p.
In that case its trace is

    sum_{i=1}^{p-1} i(i-1)...(i-j+1)=0 in k.          (3)

The summand is a polynomial of degree j<p-1 with zero constant term;
the sums of the positive powers of degrees<p-1 over F_p are zero.
Terms whose image is a constant disappear in B and have no diagonal
entry. Thus the image is contained in End_0(B).

The map is fiberwise injective. At a geometric point of C1 choose t
vanishing at its unique preimage. The Frobenius fiber algebra is
R=k[t]/(t^p). If an operator D of order<=p-2 induces zero on R/k, its
image in R consists of constants. Hence partial_t composed with D
acts as zero on R. The operators1,partial_t,...,partial_t^(p-1) are
linearly independent over R as operators on R: successively applying
sum a_j partial_t^j to1,t,...,t^(p-1) proves a_0=...=a_(p-1)=0,
since each j! is invertible. If D has highest nonzero coefficient f_m,
partial_t composed with D has order m+1<=p-1 and leading coefficient
f_m. The asserted zero operator is impossible. Therefore D=0.

Both bundles have rank p(p-2): on the right it is (p-1)^2-1, since
the trace map is surjective (the identity has nonzero trace p-1 in k).
Fiberwise injectivity and equal ranks prove (2). QED.

## 2. The complete HN polygon in every odd characteristic

Finite pushforward is exact, so (1)--(2) give successive rank-p
quotients F_*T^j for j=1,...,p-2. Each is stable by
[Sun, Theorem2.2](https://arxiv.org/pdf/math/0611360), applied to the
line bundle T^j on a curve of genus at least two. Riemann--Roch gives

    mu(F_*T^j)=(p-1-2j)*s/p.                         (4)

These slopes strictly decrease as j increases. Therefore the ORDER
filtration in (2) is exactly the Harder--Narasimhan filtration.
The scalar splitting

    End(B)=O_C1 direct_sum End_0(B)

adds one slope-zero line. Its zero-slope piece joins the rank-p piece
j=(p-1)/2. All normalized ranks and slopes depend only on p.

Everything in (1)--(2) commutes with finite etale base change, as do B,
T, relative Frobenius pushforward, and the order filtration. No use of
a Galois cover, a trace divided by the cover degree, or a simultaneous
lift is involved.

## 3. Exact symmetric-square filtration in characteristic five

Now let p=5, and use the canonical Raynaud pairing

    <a,b>=Cartier(a db): B tensor B -> omega_C1.

It is perfect and alternating; its construction and well-definedness
are recalled in [file22, Proposition2](22_CARTIER_BUNDLE_ETALE_FUNCTORIALITY_AND_LIMITS.md).
The rank-ten symplectic Lie algebra bundle is

    sp(B) ~= Sym^2(B) tensor omega_C1^(-1).            (5)

Derivations give the first piece L=F_*T in (2). They act symplectically.
Indeed, locally for D=f partial_t,

    Cartier((Da) db+a d(Db))
      =Cartier((Da) db-(da)(Db))=0.                  (6)

The omitted term is the exact form d(a Db), killed by Cartier, and
(Da) db=(da)(Db) in one dimension. This proves L subset sp(B) on the
whole curve, not merely on its generic fiber.

The trace form (A,A') -> tr(AA') is perfect on sp4 in characteristic
five. For example, in block form A=[P Q; R -P^t], Q,R symmetric, it
pairs P-blocks by twice matrix trace and the Q,R blocks perfectly;
two is invertible. Thus it identifies sp(B) with its dual.

The restriction of this pairing to L is zero: L is stable of slope
2s/5, and L^dual is stable of slope -2s/5, so Hom(L,L^dual)=0.
The rank-five subbundle L is consequently Lagrangian, giving

    0 -> F_*T -> Sym^2(B) tensor omega_C1^(-1)
      -> (F_*T)^dual -> 0.                           (7)

Both end terms are stable. Since their slopes are respectively
2s/5 and -2s/5, (7) is the full HN filtration. In particular
Sym^2(B) has slopes 12s/5 and 8s/5, each of rank five, on EVERY curve.

## 4. The complementary exterior-square piece

Still in characteristic five, the alternating pairing splits

    Lambda^2(B) tensor omega_C1^(-1)=O_C1 direct_sum P,

where P is its primitive rank-five summand. The splitting uses the
contraction of the inverse symplectic form, which is twice a unit.
Under the adjoint decomposition End(B)=sp(B) direct_sum
(Lambda^2(B) tensor omega_C1^(-1)), the trace-zero part is

    End_0(B)=sp(B) direct_sum P.

The HN polygons already computed show that P is semistable of slope
zero: End_0(B) has rank-five slopes 2s/5,0,-2s/5, while sp(B) accounts
for the positive and negative pieces. More precisely the middle HN
quotient in Section2 identifies P with F_*T^2, so P is actually stable.
Thus all normalized degree-two tensor polygons of B are now fixed.
In particular B tensor B has
slopes12s/5,2s,8s/5 of ranks5,6,5.

## Evidence and scope

An exact local matrix test checked (2)--(3) for p=3,5,7,11,13 and
fiber algebras t^p=0,1,2, obtaining ranks3,15,35,99,143. This was a
sanity check; the fiberwise proof above applies to every odd prime.
No exploratory program is required as a retained dependency.

The operator model is also used in the subsequent
[all-full-tensor theorem](../../Theorems/Thm_all_tensor_cartier_hn.md).
The separate [all-symmetric-power theorem](../../Theorems/Thm_all_symmetric_cartier_hn.md)
covers even degrees divisible by p. Both have passed independent audits.
These entire families of normalized polygons are universal, not just
their degree-two cases. Their exact bundle models remain useful input;
none supplies a curve-separating invariant.
