# Prime-power deck rigidity, with and without branch rigidity

Original statements87.5--87.12,90.1--90.7,92.1--92.4 retain their
independently audited PASS status,2026-09-04, with their separate
[branch-rigidity](audits/ODD_PRIME_DECK_NORMALITY_UNDER_RIGID_BRANCH_AUDIT.md),
[higher-cyclic](audits/90_HIGHER_CYCLIC_PRIME_POWER_DECK_RIGIDITY_AUDIT.md),
and [abelian-prime-power](audits/92_BRANCH_RIGID_ABELIAN_PRIME_POWER_COVERS_AUDIT.md)
audit records. Consolidated exposition2026-09-07, not a new audit.
The shared proof step below is an author formulation of the repeated
normal-complement argument; no extra audit of that formulation is claimed.

All curves are smooth projective connected over algebraically closed k,
and g(X)>=2. Simplicity is geometric. Characteristic restrictions are
stated separately for each result. Use the normalizer injection,
simple-quotient lemma and hyperelliptic lifting lemma in
[the shared deck toolkit](91_ARBITRARY_ABELIAN_DECK_RIGIDITY.md#1-three-common-lemmas).

## 1. The shared geometric normal-complement step

Let a finite A<=Aut(D) contain the free p-group deck group H of D->X,
with JX simple. Suppose A has a normal p-complement R, with Sylow P,
and H is normal in P. Then H is normal in A.

**Proof.** Let G be the normal closure of H in A and R0=G intersect R.
Projection A->P sends G onto H, since H is normal in P. Thus G/R0=H,
and H is Sylow in G. Every Sylow p-subgroup of G is a conjugate of the
free group H, so every point stabilizer has p-prime order. Its image in
G/R0 is trivial. If G>H, simplicity makes D/G=P1, and D/R0->D/G would
be a nontrivial connected finite etale cover of P1. Hence G=H. QED.

This is an inertia argument, not an assertion that ramification is tame.

## 2. Higher cyclic covers: no branch-rigidity assumption

### Lemma90.1 and Theorem90.2

Let p be odd and n>=2. If Q has cyclic normal subgroup
H=<h>=C_(p^n), quotient C_p, and an element b outside H of order p,
then the elements killed by p form a proper characteristic subgroup

    T=<h^(p^(n-1)),b>=C_p^2.

Consequently, for EVERY connected finite etale cyclic p^n-cover D->X
with JX simple, H is Sylow in Aut(D). This includes p=char(k) and
does not assume Aut(X)=1.

**Proof of the group statement.** Write bhb^(-1)=h^u. Then
u=1+c p^(n-1) modulo p^n and, for every j,

    sum_(i=0)^(p-1) u^(ij)=p mod p^n,
    (h^a b^j)^p=h^(pa).

The linear correction is divisible by p^n because p is odd, and
higher corrections have valuation at least2n-2>=n. Thus g^p=1
holds exactly on the displayed subgroup T, which is characteristic.

**Proof of the Sylow statement.** If a Sylow P properly contains H,
strict normalization gives an intermediate Q with H normal in Q and
[Q:H]=p. The quotient Q/H acts faithfully on X, so simplicity gives
D/Q=P1. Its stabilizers inject into Q/H since H is free; they have
orders1 or p. Some stabilizer is nontrivial, else D->P1 is etale.
Its generator supplies b as above. All stabilizers now lie in T, so
D/T->D/Q is a nontrivial finite etale cover of P1, contradiction. QED.

### Proposition90.3 and Corollary90.4

If H is a nontrivial abelian p-group, Sylow in A=Aut(D), and
H is contained in Z(N_A(H)), then

    A=H x R,  p does not divide |R|,  R embeds in Aut(X).

Indeed Burnside's normal-complement theorem supplies R; section1 makes
H normal, and the two normal subgroups R,H commute and intersect trivially.
The normalizer injection gives the embedding.

In particular this applies to every cyclic p^n-cover, p odd,n>=2, when

    gcd(|Aut(X)|,p-1)=1.

The Sylow assertion is Theorem90.2. Conjugation on H factors through
N_A(H)/H, whose order is prime to p and divides |Aut(X)|; its image in
Aut(C_(p^n)) has order dividing p-1, so is trivial.

### Theorem90.5

If char(k)!=2, X is nonhyperelliptic and JX simple, then every cyclic
2^n-cover(n>=1) or cyclic3^n-cover(n>=2) satisfies

    Aut(D)=H x R,  |R| odd.

In particular D has no nontrivial involution with a fixed point and
cannot also be an etale abelian Galois cover of a hyperelliptic curve.

**Proof.** Aut(X) has odd order: an involution would have rational
quotient by simplicity, making X hyperelliptic. For p=3 the coprimality
criterion applies. For p=2 the normalizer injection and strict-normalizer
property make H Sylow, while the2-group Aut(C_(2^n)) has trivial image
from the odd group N_A(H)/H. Apply Proposition90.3. If p=3, Aut(D) is
odd; if p=2, every involution lies in the free deck group. The second
cover is excluded by the hyperelliptic lifting lemma. QED.

## 3. A branch-rigid cyclic base

Assume for a prime ell (INCLUDING ell=2 or char(k))

    JX simple, Aut(X)=C_ell, X/C_ell=P1,

and that the reduced branch set Bcal of X->P1 has TRIVIAL full
PGL2(k)-stabilizer.

### Theorem87.5 and Corollary87.6

For every connected etale cyclic degree-ell cover D->X, its deck
group H is normal and Aut(D)/H embeds in C_ell. Thus Aut(D) is
abelian of order ell or ell^2.

**Proof.** Choose a Sylow P containing H. If P=H, then N_A(P)/P,
both ell-prime and a subgroup of C_ell, is trivial. If P>H, put
Q=N_P(H). Strict normalization and Q/H<=Aut(X) give[Q:H]=ell.
The quotient D/Q=P1 has reduced branch set exactly Bcal. If Q<P,
the nontrivial N_P(Q)/Q would preserve Bcal, contradiction. Thus P=Q;
the same branch argument makes N_A(P)=P.

In either case |P| is ell or ell^2, so P is abelian. Burnside supplies
a normal ell-complement; section1 makes H normal in A. Finally A/H
embeds in C_ell, proving the assertion. QED.

Full branch rigidity is used TWICE: first within the Sylow subgroup,
then to kill the entire normalizer quotient, including its prime-to-ell
part. Merely ruling out order-ell projective symmetries is insufficient.

## 4. Arbitrary-rank abelian p-groups over that base

Now assume p is ODD and retain the branch-rigid hypotheses of section3
with ell=p. The prime p may equal char(k).

The external input is the Glauberman--Thompson theorem: for Sylow P,
A has a normal p-complement if N_A(Z(J_o(P))) does, where J_o(P) is
generated by abelian subgroups of largest ORDER. The exact source is
Glauberman, *A characteristic subgroup of a p-stable group*,
Canad. J. Math.20(1968),1101--1135,
[Theorem D,p.1105](https://doi.org/10.4153/CJM-1968-107-2).
The definition is on p.1104 and proof in section8,p.1128. The original
source check recorded that Theorem D needs neither p-stability nor
exclusion of Qd(p); the adjacent theorems must not be substituted for it.

### Theorem92.1

For every connected finite etale Galois D->X with finite abelian
p-group H,

    H is normal in A=Aut(D),  A/H embeds in C_p.

Thus A has order |H| or p|H| and has no involutions.

**Proof.** H=1 is immediate. For H!=1 choose Sylow P containing H.
The normalizer and branch argument in section3 uses only abelianness
of H to reach

    P=H OR [P:H]=p with H normal in P,
    N_A(P)=P; if P>H, also N_A(H)=P.

It does NOT assert that P is abelian. If P is abelian, Z(J_o(P))=P.
If P is nonabelian and H is its unique abelian subgroup of maximal
order, then J_o(P)=H=Z(J_o(P)), with normalizer P.

Otherwise let H' be another abelian subgroup of order |H|. Both are
normal maximal subgroups of P and generate it. Their intersection
centralizes both, and a central element outside either would make P
abelian. Hence

    Z=Z(P)=H intersect H', [P:Z]=p^2, J_o(P)=P.

The group Z is free since it lies in H. The cover D/Z->X is etale
cyclic of degree p, so section3 makes Aut(D/Z) a p-group.
The injection N_A(Z)/Z->Aut(D/Z) makes N_A(Z) a p-group.
Thus in ALL cases N_A(Z(J_o(P))) is a p-group and has trivial normal
p-complement. Glauberman--Thompson gives a normal p-complement of A.
Section1 makes H normal in A; the normalizer injection finishes. QED.

### Lemma92.2: compression of the second Galois presentation

If H is abelian normal in a finite A, [A:H]=p, and B<=A is not
contained in H, then for N=H intersect B,

    A=HB, N is normal in A, B/N=C_p.

Indeed B surjects onto A/H, and both B and the abelian H normalize N.
If H and B act freely on D, their quotient actions on D/N remain free:
these are intermediate etale Galois quotients.

### Theorem92.3

Assume additionally char(k)!=2. No curve D has ACTUAL finite etale
Galois maps to X and to a hyperelliptic Y of genus>=2 if its deck
group H over X is an abelian p-group. The second deck group is arbitrary.

**Proof.** Theorem92.1 makes A=Aut(D) odd and [A:H]<=p. Let B be the
second deck group. If B<=H it is abelian, and the hyperelliptic lifting
lemma contradicts oddness of A. Otherwise Lemma92.2 gives D0=D/(H
intersect B), still an etale abelian p-group cover of X, but now an
etale C_p-cover of Y. Theorem92.1 makes Aut(D0) odd, while the lifting
lemma supplies an involution. Contradiction. QED.

## 5. The fixed genus-nine curve

### Proposition87.10: exact automorphisms and branch rigidity

For the [fixed X](../../Definitions/Def_fixed_pair.md), Aut(X)=C3,
and its cubic quotient has a reduced eleven-point branch set with
trivial projective stabilizer.

**Proof.** The [arithmetic record](../../Theorems/Thm_fixed_pair_arithmetic.md)
gives the degree18 field K=Q(pi), Q(pi^n)=K for all n>=1, and the
discriminant restriction leaving roots of unity of orders1,2,3,6 only.
Honda--Tate applied over every finite extension therefore gives
End^0_k(JX)=K. The cubic deck transformation supplies mu3, so mu(K)=mu6.
A Torelli automorphism acts as a polarization-preserving integral unit
in this CM field. Rosati is conjugation; all conjugates of that unit
have absolute value one, so Kronecker makes it a root of unity.
Aut(X) is C3 or C6. The latter would contain an automorphism acting
as[-1], forcing hyperellipticity; X is nonhyperelliptic. Thus Aut(X)=C3.

The [exact branch certificate](87_BRANCH_STABILIZER_CERTIFICATE.sage)
factors the degree10 polynomial into two linear and two quartic factors
over F25, splits it over F_(5^8), and checks the11*10*9 images of one
fixed ordered triple. These exhaust possible projective transformations
over k: each is determined by that triple and has coefficients in the
splitting field. Only identity preserves the branch set. QED.

### Fixed-curve consequences:87.11--87.12,90.6--90.7,92.4

- Every cyclic cubic etale D->X has normal deck group and
  |Aut(D)| in{3,9}; section3 proves this.
- Every cyclic3^n etale D->X with n>=2 has Aut(D)=C_(3^n).
  By Theorem90.5 its prime-to3 complement embeds in Aut(X)=C3,
  and is therefore trivial.
- In the latter case, any other etale Galois map D->Y with g(Y)>=2
  and JY simple has the SAME deck group, hence Y is isomorphic to X:
  its group is a subgroup of Aut(D), and Y->X would otherwise be a
  proper positive-genus quotient of a simple-Jacobian curve.
- More generally, for EVERY abelian3-group deck group over X, there
  is no second etale Galois map to a hyperelliptic Y of genus>=2.
  This is Theorem92.3, and includes every cyclic3^n,n>=1, as well as
  the earlier consequence assuming an abelian second deck group.

## Scope

The higher-cyclic Sylow theorem needs no branch rigidity or trivial
Aut(X); the branch theorems do. Theorem90.5 requires an ABELIAN Galois
second leg unless its group is made abelian separately. Theorem92.3
allows any second Galois group, but still requires the first to be an
abelian p-group. Both maps must be actual Galois covers of the SAME
source. Arbitrary common covers cannot presently be replaced by these
presentations, and the common-cover problem remains unsolved.
