# Bounded wild-jump denominators bound two-branch atlas degrees

Author proof, 2026-09-06; NOT independently audited. The
[audited integral-jump theorem](../../Theorems/Thm_integral_jump_bound.md)
and its sharper genus-nine certificate retain their independent scope.

## 1. Statement and shared arithmetic

In the two-branch atlas setting of that theorem, fix p≥3,h>0,L≥1.
If every positive upper jump of the wild-subgroup extension belongs
to(1/L)Z, the atlas degree n is effectively bounded in terms of p,h,L.

Use reduced tame order m and the canonical proof's notation:

    q=|P|=p^a, P=I_1, e=qt, c=δ−e, 0<c<e,
    cm−qt0=D, D|h, gcd(m,t0)=1, p∤g0t0m,
    t0|c+1, t0|m+D, g0|(c+1)/t0, n=(h/D)qg0t0m.             (1)

Section1 of that proof shows that bounded q bounds everything:

    m≤q+(q+D)/(q−2),   c≤q+(q+1)D.                           (2)

A single upper jump is integral and already covered. Otherwise q≥p².
With jumps u_1<⋯<u_r and cumulative rank exponents a_i, its Herbrand
identity remains valid without integrality:

    c+1=∑_i(p^a_i−p^a_(i−1))u_i.

Since u_1≥1 and u_r≥1+1/L, the last coefficient≥(p−1)q/p gives

    c−q≥(p−1)q/(pL)−2,
    c+1≥((p−1)U+1)q/p−1,   U=u_r.                           (3)

## 2. Finite small-side ranges

The region q≤max(p²,4pL/(p−1)) is finite by (2).
Beyond it, m≥t0 gives q≤pL(D+2)/(p−1), again finite.
For m<t0 put w=(m+D)/t0. If w≥2, m<D. If w=1, (1) becomes
(c−q)m=D(q+1), and (3) gives c−q≥(p−1)q/(2pL).
Since q≥9, both cases satisfy

    m≤M=ceil[3pLD/(p−1)],   m<t0|m+D.                       (4)

Substituting t0/m≤1+D/m and q≥p² in the second inequality of (3),
exactly as in the canonical proof's Section3, bounds the jump itself:

    U≤[p²(D+1)−p+D+2]/[p(p−1)].

Thus v_i=Lu_i are increasing positive integers at most

    V=floor[L(p²(D+1)−p+D+2)/(p(p−1))].                     (5)

The first v_1 is a multiple of L, since the first jump is integral.

## 3. The scaled carry proof

Fix the finite parameters D,m,t0,v_1. Equations(1)–(3) rearrange to

    p^a(mv_r−Lt0)=E+m∑_(i<r)(v_(i+1)−v_i)p^a_i,
    E=m(v_1+L)+LD.

Apply the finite carry lemma in
[the canonical proof, Section4](../../Solutions/Sol_integral_jump_bound.md)
with terminal offset Lt0. Its complete tree terminates without a
rank cutoff, and with B=E+mV gives a≤V(1+floor(log_p B)).
This bounds q; (2) then bounds n. No local realizability assumption
is inserted into this necessary sieve.

## 4. Representation-theoretic consequences

Every irreducible complex representation ρ of a finite p-group has
p-power dimension. Its fixed spaces under the normal upper ramification
groups are either zero or the whole representation, so it has one
upper break u(ρ), with integral Swan conductor

    Sw(ρ)=u(ρ) dimρ.

Every group jump occurs as some irreducible's break, since the regular
representation distinguishes the successive groups. Hence each jump
denominator divides an irreducible dimension, and all denominators
divide the largest such dimension (the dimensions are nested p-powers).

If A⊂P is abelian of index≤J, choose a character χ in ρ|_A.
Frobenius reciprocity embeds ρ as a constituent of Ind_A^Pχ, so
dimρ≤[P:A]≤J. Normality of A is unnecessary. Thus a bound on either
the largest irreducible dimension or the minimum abelian-subgroup
index bounds n in terms of p,h and that bound. Swan integrality is the
same input used in [the local ramification foundation](13_PROOF_LOCAL_RAMIFICATION.md).

Accordingly an unbounded sequence in this atlas class requires
unbounded jump denominators, irreducible dimensions and abelian indices.
The two actual étale legs currently supply none of these bounds.

## 5. Complete genus-nine sieve for denominators dividing five

For h=16,p=L=5, groups of order5 or25 are abelian, so the audited
integral theorem leaves only q=5,n≤2240. Assume q≥125.
Then c−q≥4q/25−2; m≥t0 would force q≤25(D+2)/4≤112.5.
On the small side,(q+1)/(4q/25−2)≤7 gives m≤7D.
For D=1,2,4,8,16 the scaled limits are V=12,18,31,57,109.

The [complete carry certificate](DENOMINATOR_FIVE_LOCAL_SIGNATURE_CERTIFICATE.py)
merges equal states while recording all path lengths as bit masks,
then reconstructs every path; no rank is truncated. Its six reduced
tuples(D,m,t0,q,c) are

    (1,1,2,125,251), (1,3,4,125,167), (1,7,8,125,143),
    (8,1,3,125,383), (8,1,3,625,1883), (8,1,3,3125,9383).

Retain all three necessary local filters. For lower breaks b_i and
cumulative exponents a_i:

- b_1=u_1 and b_(i+1)−b_i=(u_(i+1)−u_i)p^a_i must be integral.
- All b_i have the same nonzero residue modulo p as the last break.
  An order-p element in the final group has prime-to-p break; a different
  residue would, by the exact leading-commutator lemma, produce a break
  beyond the last one. The maximal-break argument is essential.
- Apply first-break Swan divisibility to EVERY subgroup P_(b_i):
  for e_i=a_i−a_(i−1), its first-interval excess is divisible by
  p^ceil(e_i/2). Also t|b_i(p^e_i−1).

These leave q=125 with lower indices/breaks((2,1),(3,6)) or
((2,1),(3,66)), and t|24. Restoring g0 gives the five necessary tuples
in the [order-p-second-group bound](ORDER_P_SECOND_RAMIFICATION_GROUP_FORCES_A_DEGREE_BOUND.md),
so n≤336000, without a big-action classification.
The [translation-rank theorem](../../Theorems/Thm_translation_rank_bound.md)
subsequently removes B=66, leaving B=6 and degrees112000 or336000.
No surviving tuple is asserted realizable.

Together with the [cored signature reduction](CORED_ZERO_ONE_FORM_INTERSECTION_AND_WILD_SIGNATURE_REDUCTION.md),
M>336000 for the fixed pair therefore requires an upper-jump denominator
at least25; an unbounded cored sequence requires the unbounded local
complexity above. Coreless spans remain outside this argument.
This specialization, like the general denominator extension, remains
author prose, not independently audited.
