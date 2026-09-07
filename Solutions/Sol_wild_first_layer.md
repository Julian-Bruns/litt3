# Proof: the first wild ramification layer is genus-bounded

[Statement and audit metadata](../Theorems/Thm_wild_first_layer.md).
Use the [integral-bound proof's atlas notation](Sol_integral_jump_bound.md):
cm−qt0=D|h, gcd(m,t0)=1, t0|m+D, P=I_1 and q=|P|.
Let b be the first lower break, N=P_(b+1), |P/N|=p^r and
Q=p^ceil(r/2). No integrality assumption on later upper jumps is made.

## 1. First-break divisibility and the auxiliary genus

The positive different sum ε=c+1 obeys

    b(q−1)≤ε≤(q+1)(1+D/m),   b≤2(h+1).                     (1)

The [first-break Swan lemma](../routes/global/13_PROOF_LOCAL_RAMIFICATION.md),
whose proof is identical with p in place of5, gives
Q|ε−b(q−1). Multiply by m and use the genus equation and Q|q:

    Q | D+(b+1)m.                                           (2)

Realize the local P-action by its HKG curve H, with H/P=P¹ and one
totally ramified point. Hurwitz gives S:=2g(H)=c−q+2.
If S=0 then P_2=1 and the [numerical single-jump bound](Sol_integral_jump_bound.md)
applies. For S>0 call the auxiliary action large when

    S<(p−1)q/p.                                             (3)

H is not an étale refinement of either endpoint.

## 2. Non-large actions

Here c−q≥(p−1)q/p−2. For q=p the first rank is already bounded;
otherwise q≥p². If m≥t0, the genus equation bounds
q≤p(D+2)/(p−1). If m<t0, put w=(m+D)/t0.
For w≥2, m<D; for w=1, (c−q)m=D(q+1).
The decreasing ratio(q+1)/((p−1)q/p−2) for q≥p² gives

    m≤M(D,p)=floor[D(p²+1)/(p(p−1)−2)].

Thus (1)–(2) give Q≤D+(2h+3)M(D,p), bounding r.
This includes every case where b is not one.

## 3. The large-action genus lower bound

Condition(3) forces b=1: if b≥2, S≥q−1≥(p−1)q/p.
Now N=P_2 is nontrivial; put v=|N|≥p and

    A=|P/N|=p^r=Q²/e,  e∈{1,p},  q=vA.

Choose a P-normal subgroup N0⊂N of index p. Indeed, the p-group P
acting on the nonzero dual of N/Φ(N) has a nonzero fixed vector;
its kernel is such an N0. The quotient H/N0 is HKG for P/N0.
Upper-numbering quotient compatibility at jump1 gives
(P/N0)_2=N/N0 of order p, while its first quotient still has rank r.

The [translation-rank theorem](Sol_translation_rank_bound.md) forces
its final lower break B to satisfy B−1≥Q: either p^r|(B−1), or
B−1=p^s with r≤2s. Consequently2g(H/N0)≥(p−1)Q.
The Hurwitz subtraction proved in that theorem gives, for any K⊂P,

    2|K|g(H/K)=∑_(i≥2)(|P_i|−|K∩P_i|)
               ≤∑_(i≥2)(|P_i|−1)=S.

With K=N0 this proves the claimed unrestricted lower bound

    S≥(p−1)vQ/p.                                           (4)

No commutativity of N is used. The first tame graded character and (2)
also give

    t0 | A−1,   Q | D+2m.                                  (5)

## 4. Bounding the first quotient without bounding N

For m≥t0, D≥S−2≥(p−1)Q−2 bounds Q.
For m<t0 and w=(m+D)/t0≥2, m<D and (5) gives Q<3D.
It remains w=1: t0=m+D and (S−2)m=D(q+1).
Using (4), v≥p, and monotonicity in v gives

    m≤D(pA+1)/((p−1)Q−2).

Put k=(D+2m)/Q, a positive integer. Since Q≥p≥3 and A≤Q²,

    k≤D/p+4D(p+1/p²)/(p−1)<7D.                              (6)

Here((p−1)Q−2)≥(p−1)Q/2. Since2t0=kQ+D and t0|A−1,
squaring kQ≡−D modulo t0 gives

    t0 | D²−ek².

If this integer is nonzero, t0≤(1+49p)D² and
Q=(2t0−D)/k≤2(1+49p)D². If it vanishes, e=p is impossible
because p is not a rational square. Thus e=1,k=D and
m=D(Q−1)/2. Coprimality gcd(m,D)=gcd(m,t0)=1 forces D=1.

In this exceptional case m=(Q−1)/2 divides q+1.
Write v=p^a,Q=p^s; since Q≡1 mod m, also m|p^a+1.
Reduce a modulo s, obtaining0≤j<s and

    (p^s−1)/2≤p^j+1≤p^(s−1)+1,
    (p−2)p^(s−1)≤3.

Therefore Q≤9 here as well. This completes the bounds on b and r.

If N contains an abelian subgroup B of index≤J, then
[P:B]=p^r[N:B] is bounded. The explicitly conditional
[bounded-denominator corollary](../routes/global/BOUNDED_WILD_JUMP_DENOMINATORS_BOUND_ATLAS_DEGREES.md)
bounds the atlas degree: irreducible dimensions are at most[P:B],
and each upper-jump denominator divides one of those p-power dimensions.
This does not supply the missing bound on arbitrary N.

## 5. Large actions for p=5,h=16

Here D∈{1,2,4,8,16}. The m≥t0 case would give D≥4Q−2≥18.
If w≥2, then m<D and Q|D+2m<48. For r≥3 one has Q≥25;
D=1 has no m<D, and otherwise D+2m is even and cannot be a positive
multiple of25 below48. Thus r≤2 in this case.

For w=1, ε is divisible by4 because every |P_i|−1 is.
Hence c−q≡q+1≡2 mod4. The equation(c−q)m=D(q+1) and
gcd(m,D)=1 force D=1. Now

    Q|1+2m,   m≤(5A+1)/(4Q−2).

If r is odd, A=Q²/5 and1+2m≤1+2(Q²+1)/(4Q−2)<Q for Q≥5,
impossible. If r is even and r≥4, then Q≥25,A=Q² and1+2m<3Q.
This odd multiple of Q must equal Q. Section4's exceptional case
would then require Q≤5 when p=5, again impossible.
Finally r=1 is excluded for w≥2 by (4): S≥4v contradicts(3), S<4v.
Thus every large case has r=2, so P/P_2≅C_5².

For HKG realization see
[Bleher–Chinburg–Poonen–Symonds, §1.B and Proposition4.8](https://math.mit.edu/~poonen/papers/AutK.pdf).
The first quotient's bounded rank does not bound the order,
noncommutative depth or irreducible dimensions of N. Neither the
unrestricted atlas degree nor the coreless common-cover problem is
settled by this theorem.
