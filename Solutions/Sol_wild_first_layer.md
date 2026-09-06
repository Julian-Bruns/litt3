# Proof record: Genus bounds for the first wild ramification layer

Canonical statement: [`wild_first_layer`](../Theorems/Thm_wild_first_layer.md).
Migrated 2026-09-06; hypotheses restated below are proof context.
The canonical statement and registry control promoted scope and evidence.

---

# The first wild ramification layer is bounded by the atlas genus

Author: /root, 2026-09-06. Status: independently audited PASS by
`/root/contact_bound_to_core_audit`, 2026-09-06;
[audit record](../routes/global/audits/FIRST_WILD_RAMIFICATION_LAYER_GENUS_BOUND_AUDIT_2026_09_06.md).
This bounds a quotient, not the full wild group. It does not address
coreless correspondences or establish a counterexample to Litt's problem.

## Theorem

Fix p>=3 and h>0. Use the two-branch atlas setting and notation of the
[checked integral-jump theorem](Sol_integral_jump_bound.md):

    P=I_1, q=|P|, c=delta-|I|,
    c m-q t0=D, D|h, gcd(m,t0)=1, t0|(m+D).

Let b be the first positive lower break, N=P_(b+1), and |P/N|=p^r.
Then b and r are effectively bounded in terms of p,h, WITHOUT any
assumption on P, on N, or on upper-jump denominators.

Consequently, if N has an abelian subgroup of index at most J, the
atlas degree is bounded in terms of p,h,J. In particular this applies
whenever the first deeper ramification subgroup N is abelian, however
large its order. For b=1 this subgroup is I_2.

For h=16,p=5 there is a sharper conclusion in the large-action case
defined below: necessarily b=1 and P/P_2 is C_5^2.

## 1. Basic estimates and conventions

Put epsilon=c+1=sum_(i>=1)(|P_i|-1). Since t0<=m+D,

    b(q-1)<=c+1<=(q+1)(1+D/m),
    b<=2(h+1).                                      (1)

The first-break Swan divisibility in
[file 13](../routes/global/13_PROOF_LOCAL_RAMIFICATION.md), whose proof works with any
prime p in place of 5, gives, on writing Q=p^ceil(r/2),

    Q | epsilon-b(q-1), hence Q | D+(b+1)m.           (2)

Realize the local P-action by its HKG curve H. Its P-quotient is P1,
with just one totally ramified point, and

    S:=2g(H)=c-q+2.

The case S=0 has P_2=1 and a single jump, so is already degree-bounded
by the checked single-jump theorem. For S>0, call the action large if

    S<(p-1)q/p.                                      (3)

These names concern only the auxiliary local HKG curve, not a common
etale refinement of the original curves.

## 2. The non-large case

Here c-q>=((p-1)/p)q-2. If q=p it is already bounded; assume q>=p^2.
If m>=t0, the genus equation gives q<=p(D+2)/(p-1). Otherwise the same
elementary argument as in the integral-jump theorem gives

    m<=M(D,p):=floor[D(p^2+1)/(p(p-1)-2)].

For clarity, set w=(m+D)/t0. If w>=2 then m<D; if w=1 use
(c-q)m=D(q+1) and the decreasing ratio
(q+1)/((p-1)q/p-2) for q>=p^2. Combining this bound with (1)--(2) gives

    Q<=D+(2(h+1)+1)M(D,p).

Thus r is bounded, including all cases where the first break is not one.

## 3. A lower bound for the local genus in the large case

Condition (3) forces b=1: if b>=2, then S>=q-1>=(p-1)q/p.
Let N=P_2 be nontrivial, v=|N|, and A=|P/N|=p^r. Write

    Q=p^ceil(r/2), A=Q^2/e, e in {1,p}, q=vA.

Choose a P-normal subgroup N0 of N of index p. Such a subgroup exists:
the p-group P acts on the nonzero dual of N/Phi(N), which has a nonzero
fixed vector, and its kernel is P-stable. The quotient H/N0 is an HKG
curve for P/N0. Upper-numbering quotient compatibility at the first
jump 1 gives (P/N0)_2=N/N0, of order p; its first quotient still has
rank r.

The checked [translation-rank theorem](Sol_translation_rank_bound.md)
then says that its last lower break B satisfies B-1>=Q. Indeed either
p^r divides B-1, or B-1=p^s with r<=2s. Thus

    2g(H/N0)=(p-1)(B-1)>=(p-1)Q.

For any subgroup K of P, subtraction of the two Hurwitz formulas gives

    2|K|g(H/K)=sum_(i>=2)(|P_i|-|K intersect P_i|)
                <=sum_(i>=2)(|P_i|-1)=2g(H).

Apply this to K=N0. We obtain the general lower bound

    S>=(p-1)vQ/p.                                    (4)

No commutativity or centrality assumption on N was used. The other
two inputs now available are the first tame graded-character rule
and (2):

    t0 | A-1,   Q | D+2m.                            (5)

## 4. Arithmetic bounds the first quotient, even when N is unrestricted

If m>=t0, then D>=c-q=S-2>=(p-1)Q-2, bounding Q.
Assume m<t0 and again set w=(m+D)/t0. If w>=2, then m<D, and (5)
gives Q<=D+2m<3D. It remains that w=1, so t0=m+D and

    (S-2)m=D(q+1).

By (4), v>=p, and monotonicity in v,

    m<=D(pA+1)/((p-1)Q-2).

Set k=(D+2m)/Q, a positive integer. Since Q>=p>=3 and A<=Q^2,

    k<=D/p+4D(p+1/p^2)/(p-1)<7D.                     (6)

Here we used ((p-1)Q-2)>=(p-1)Q/2. Also 2t0=kQ+D.
Combining this identity with t0|(A-1) and A=Q^2/e gives

    t0 | D^2-e k^2.                                  (7)

If the integer on the right is nonzero, then

    t0<=D^2+p k^2<=(1+49p)D^2,
    Q=(2t0-D)/k<=2(1+49p)D^2.

If it is zero, e=p is impossible because p is not a rational square.
Thus e=1, k=D, m=D(Q-1)/2. Since gcd(m,D)=gcd(m,t0)=1, we get D=1.
Now m=(Q-1)/2 and m|(q+1). Writing v=p^a, Q=p^s, reduction modulo m
gives m|(p^a+1). Reduce a modulo s, obtaining 0<=j<s and

    (p^s-1)/2<=p^j+1<=p^(s-1)+1,
    (p-2)p^(s-1)<=3.

Thus Q<=9 in this exceptional case as well. This completes the uniform
bound for r, and the theorem's first assertion.

If N contains an abelian subgroup B of index <=J, then
[P:B]=p^r[N:B] is bounded. The representation-theoretic corollary of
the [bounded-denominator theorem](../routes/global/BOUNDED_WILD_JUMP_DENOMINATORS_BOUND_ATLAS_DEGREES.md)
therefore bounds the atlas degree. This implication is conditional only
on the explicitly stated bounded-abelian-index hypothesis on N.

## 5. Sharpening for h=16,p=5 in the large case

Here D is one of 1,2,4,8,16. If m>=t0, (4) gives D>=4Q-2>=18,
impossible. In the w>=2 case m<D and Q|D+2m<48. If r>=3 then Q>=25.
D=1 cannot have m<D, and for the remaining D the positive integer
D+2m is even, so cannot be a positive multiple of 25 below 48.
Thus r<=2 in this case.

For w=1, epsilon is divisible by 4, since each |P_i|-1 is. Hence
c-q=2 mod 4, and q+1=2 mod 4. The equation
(c-q)m=D(q+1), together with gcd(m,D)=1, forces D=1. Now

    Q | 1+2m,    m<=(5A+1)/(4Q-2).

If r is odd, A=Q^2/5 and

    1+2m<=1+2(Q^2+1)/(4Q-2)<Q  (Q>=5),

which is impossible. If r is even and r>=4, then Q>=25, A=Q^2, and
1+2m<3Q. As 1+2m is odd, it must equal Q. This is exactly the
exceptional case of Section 4, which for p=5 requires Q<=5, again a
contradiction. Thus r=2 in the w=1 case.

Finally r=1 is also impossible when w>=2: (4) would say
S>=4v, whereas (3) with q=5v says S<4v. Therefore every large case
has r=2, as claimed.

## Boundary

Bounding the number of generators of a p-group does not bound its
order, its noncommutative depth, or the degrees of its irreducible
representations. We have NOT yet bounded N in general. This is the
precise gap left by the theorem, rather than a tacit finiteness claim.
HKG realization is the only external geometric construction in the
proof; see [Bleher--Chinburg--Poonen--Symonds, Section 1.B and Proposition 4.8](https://math.mit.edu/~poonen/papers/AutK.pdf).
