# Proof: bounded denominators and finite carry sequences

[Statement, hypotheses and audit scopes](../../../Theorems/quotient_geometry/local_actions/wild_jump_atlas_bounds.md).
Write d for the other, tame inertia order, g0=gcd(t,d),
t=g0 t0 and d=g0 m. Thus gcd(t0,m)=1 and p∤g0 t0 m.

## 1. Shared atlas arithmetic

Uniform ramification gives qt|n and d|n. Hurwitz reads
h=n(c/(qt)−1/d), so, writing n=N lcm(qt,d),

    D=h/N=cm−qt0>0,   D|h,
    n=(h/D)qg0t0m.                                          (1)

The local congruence t|δ+1, equivalently t|c+1, follows by linearizing
a tame complement as z↦ζz. An invariant base differential has leading
term a z^δ dz, whose character is ζ^(δ+1). Linearization averages a
uniformizer with its desired character; it divides only by t, not by
an atlas degree. Consequently t0|m+D and g0|(c+1)/t0.
This does not assert t|q−1.

For any fixed q, all remaining variables are bounded. Since c≥q−2
and t0≤c+1, (1) gives

    m≤q+(q+D)/(q−2).

Put v=(c+1)/t0. Then c=(q+vD)/(vm−q), with vm>q. This decreases in v;
its smallest allowed integer v is at most q+1. Thus

    c≤q+(q+1)D,

and t0,g0 range over the bounded divisors above. We can therefore
concentrate on bounding q.

## 2. The numerical single-jump criterion

Assume c=j(q−1)−1 for an integer j≥1 and put ℓ=jm−t0. Equation(1)
gives qℓ=(j+1)m+D, so ℓ>0. Since t0|j(q−1), multiplying by ℓ gives
t0|ℓ+jD. Write R=(ℓ+jD)/t0≥1; substitution yields

    j(Rm−D)=ℓ(R+1),   j/ℓ=(R+1)/(Rm−D)≤D+2.

For R≤D+1 use denominator≥1; for R≥D+1 use denominator≥R−D.
Also t0≤ℓ+jD gives m≤D+2ℓ/j. Therefore

    q=((j+1)m+D)/ℓ
      ≤D(j/ℓ)+2D/ℓ+2+2/j≤(D+2)²≤(h+2)².                    (2)

Section1 now proves finiteness. An explicit j-range for the retained
certificate follows by putting v=j(q−1)/t0 in (1):

    j(q−1)(vm−q)=v(m+D),
    j≤(m+D)(q+1)/(q−1).                                    (3)

Here v/(vm−q) decreases for vm>q, and its largest integer-argument
value is at v=floor(q/m)+1 and is at most q+1.
Enumerate q,D,m,j within these bounds; t0 divides c+1, (1) fixes m,
and g0 divides (c+1)/t0 with p∤g0, c<qg0t0 and d≥2.

For p=5,h=16, the [signature script](../../../scripts/orbifolds/wild_inertia_signatures.py),
run with `single`, finds24 full tuples, all q=5. The nine reduced tuples(j,t0,m,D),
with their largest n over allowed g0, are

    (1,4,7,1):2240   (2,4,3,1):1920   (3,2,1,1):960
    (1,1,2,1):640    (2,1,1,2):320    (1,1,3,4):240
    (6,3,1,8):240    (1,1,7,16):140   (2,1,3,16):120.

All positive j in (3) are allowed; no hidden conductor-primality or
local-realizability filter is used. This proves hypothesis2 completely.

## 3. Bounded denominators give finite small-side ranges

Write P=I_1, q=p^a, with positive upper jumps u_1<...<u_r and
cumulative exponents 0=a_0<a_1<...<a_r=a. Herbrand's formula gives

    c+1=sum_i(p^a_i−p^a_(i−1))u_i.                       (4)

An upper interval(u_i,u_(i+1)] has lower length
p^a_i(u_(i+1)−u_i) and group size q/p^a_i; this also verifies(4)
directly from the different.

A single jump is integral and belongs to Section2. Otherwise q>=p².
If all jumps belong to (1/L)Z, then u_1>=1 and u_r>=1+1/L.
The last weight in(4) is at least(p−1)q/p, so with U=u_r,

    c−q >= (p−1)q/(pL)−2,
    c+1 >= ((p−1)U+1)q/p−1.                             (5)

The range q<=max(p²,4pL/(p−1)) is finite by Section1. Beyond it,
m>=t0 gives q<=pL(D+2)/(p−1), also finite. Suppose m<t0 and put
w=(m+D)/t0. If w>=2 then m<D. If w=1 then
(c−q)m=D(q+1), while(5) gives c−q>=(p−1)q/(2pL). Thus in both cases

    m<=M=ceil[3pLD/(p−1)],     m<t0|m+D.                 (6)

Using t0/m<=1+D/m, q>=p² and the second inequality in(5),

    (p−1)U+1 <= p t0/m+p(D+2m)/(mq)
               <=p(D+1)+(D+2)/p.

Consequently the integers v_i=Lu_i are strictly increasing and bounded by

    V=floor[L(p²(D+1)−p+D+2)/(p(p−1))].                 (7)

The first v_1 is a multiple of L because the first jump is integral.
For L=1 the sharper decreasing-ratio estimate, valid for q>=p², is

    m<=floor[D(p²+1)/(p(p−1)−2)].                        (8)

This is the range used in the integral replay.

## 4. One carry argument bounds the wild rank

Fix positive m,E,V, an integer T and integers 1<=v_1<...<v_r<=V.
Consider

    p^a(mv_r−T)=E+m sum_(i<r)(v_(i+1)−v_i)p^a_i.        (9)

Successive division by p gives a complete carry process. Necessarily
p divides E. Start at (rank,value,carry)=(1,v_1,E/p).
At (a,v,R), termination means R=mv−T. Otherwise choose
0<=Delta<=V−v with p dividing R+mDelta and pass to

    (a+1,v+Delta,(R+mDelta)/p).

Positive Delta records a jump change at cumulative rank a; zero Delta
records none. Require a positive change in the multijump branch.

Every carry stays positive. If B>=E/p and B>=mV, it also stays at most
B, since (R+mDelta)/p<=2B/p<=B. There are at most V−1 positive changes;
each intervening run of zero changes has length at most floor(log_p B).
Hence every path ends with

    a<=V(1+floor(log_p B)).                              (10)

For(4) and the atlas equation use

    T=Lt0,    E=m(v_1+L)+LD,    B=E+mV.

Their rearrangement is exactly(9). The finite parameters in(6)–(7)
and(10) bound q; Section1 then bounds n. For L=1 one may use the
smaller B=2mV+D as in the original integral calculation.

For the representation corollary, an irreducible characteristic-zero
representation rho of P has one upper break u(rho): its fixed space
under each normal ramification group is either zero or the whole
representation. Swan integrality gives
Sw(rho)=u(rho) dim(rho). Every group jump occurs among these breaks,
as seen in the regular representation. Its denominator therefore
divides an irreducible degree. All such degrees are p-powers, so the
largest is a common denominator. If A⊂P is abelian, Frobenius
reciprocity makes rho a constituent of Ind_A^P chi for some character
chi, giving dim(rho)<=[P:A]. Normality of A is unnecessary.

## 5. The integral genus-nine specialization

For p=5,h=16, the m>=t0 bound gives q<=22.5<25. Equations(7)–(8) give

    D:       1  2  4   8  16
    M:       1  2  5  11  23
    V:       2  3  6  11  21.

The [signature script](../../../scripts/orbifolds/wild_inertia_signatures.py),
with command `integral`, finds exactly one multijump tuple
(D,m,t0,q; (a_i,u_i); c):

    (8,1,3,25; ((1,1),(2,4)); 83).

It is locally impossible. Its first lower jump is1 and |I_1/I_2|=5.
In a parameter linearizing the tame generator z->zeta z, the leading
coefficients of gamma(z)=z+b_gamma z²+... form an F5-line stable
under multiplication by zeta or zeta^-1. Thus t divides4, contradicting
3=t0|t. Section2 now gives q=5,n<=2240.

For upper/lower numbering and Swan/Hasse–Arf integrality see
[Kedlaya, §4.4, especially Remark4.4.13](https://kskedlaya.org/cft/sec_filtration.html).
Integrality is invoked for the wild subgroup or its representation
conductors, according to the stated hypotheses.

## 6. Denominators dividing five

For p=L=5,h=16, q=5 or25 is abelian and belongs to Section5.
Assume q>=125. Then c−q>=4q/25−2. If m>=t0, q<=25(D+2)/4<=112.5,
a contradiction. Otherwise the decreasing ratio
(q+1)/(4q/25−2)<=7 gives m<=7D. The scaled bounds V from(7) are
12,18,31,57,109 for D=1,2,4,8,16.

The [signature script](../../../scripts/orbifolds/wild_inertia_signatures.py),
with command `denominator-five`,
merges equal carry states while retaining all possible path lengths,
then reconstructs every terminal filtration. Its six reduced tuples
(D,m,t0,q,c) are

    (1,1,2,125,251), (1,3,4,125,167), (1,7,8,125,143),
    (8,1,3,125,383), (8,1,3,625,1883), (8,1,3,3125,9383).

Apply the [local ramification constraints](ramification_constraints.md)
to each filtration:

- Lower breaks satisfy b_1=u_1 and
  b_(i+1)−b_i=(u_(i+1)−u_i)p^a_i in Z.
- All b_i have the same nonzero residue modulo p.
- For e_i=a_i−a_(i−1), first-break Swan divisibility in P_(b_i)
  requires its first-interval excess to be divisible by p^ceil(e_i/2).
  Tame characters also require t|b_i(p^e_i−1).

The replay leaves q=125 and lower filtrations ((2,1),(3,6)) or
((2,1),(3,66)), with t|24. The
[translation theorem](translation_rank_bound.md) excludes the second:
it would require25 translations at conductor66, where only5 are possible.
For conductor6, c=143 and 143m−125t0=D|16 with t0|24.
Put k=t0−m. Since D<=16, one has1<=k<=3 and

    18t0=143k+D.

Reducing modulo18 gives D=k. Thus k=1 or2 and t0=8k; t0|24 forces
k=1. Therefore (D,m,t0)=(1,7,8), and t=g0t0|24 gives g0=1 or3.
The atlas formula yields the two stated full signatures.
