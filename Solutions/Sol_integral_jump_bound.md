# Proof: integral jumps and numerical single-jump atlas bounds

[Statement, hypotheses and audit scopes](../Theorems/Thm_integral_jump_bound.md).
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

For p=5,h=16, the [single-jump certificate](../routes/global/TWO_BRANCH_SINGLE_JUMP_SIGNATURE_CERTIFICATE.py)
finds24 full tuples, all q=5. The nine reduced tuples(j,t0,m,D),
with their largest n over allowed g0, are

    (1,4,7,1):2240   (2,4,3,1):1920   (3,2,1,1):960
    (1,1,2,1):640    (2,1,1,2):320    (1,1,3,4):240
    (6,3,1,8):240    (1,1,7,16):140   (2,1,3,16):120.

All positive j in (3) are allowed; no hidden conductor-primality or
local-realizability filter is used. This proves hypothesis2 completely.

## 3. Integral jumps: finite small-side ranges

Let P=I_1, q=p^a, with upper jumps1≤u_1<⋯<u_r in the numbering
of P. Put0=a_0<a_1<⋯<a_r=a, where [P:P^(u_i+)]=p^a_i.
The positive lower filtration agrees with that of the full inertia.
Herbrand's formula and the different give, without a character hypothesis,

    c+1=∑_i(p^a_i−p^a_(i−1))u_i
       =qu_r−u_1−∑_(i<r)(u_(i+1)−u_i)p^a_i.                (4)

Indeed an upper interval(u_i,u_(i+1)] has lower length
p^a_i(u_(i+1)−u_i) and group size q/p^a_i; its contribution is
(q−p^a_i)(u_(i+1)−u_i), in addition to(q−1)u_1.

For r=1 use Section2. Otherwise q≥p² and the integral distinct jumps
give, with U=u_r,

    c≥(2−1/p)q−2,   c+1≥((p−1)U+1)q/p−1.                  (5)

The last coefficient in (4)'s first sum is at least(q−q/p);
all others have weights≥1, proving both estimates.

If m≥t0, (1) and (5) give q≤p(D+2)/(p−1), handled by Section1.
If m<t0, put w=(m+D)/t0. For w≥2, m<D; for w=1,
(c−q)m=D(q+1). The ratio(q+1)/((p−1)q/p−2) decreases for q≥p²,
so in both cases

    m≤M(D,p)=floor[D(p²+1)/(p(p−1)−2)],
    t0 is a divisor of m+D greater than m.                   (6)

Using t0/m≤1+D/m, (1) and the second inequality in (5) gives

    (p−1)U+1≤p t0/m+p(D+2m)/(mq)
              ≤p(D+1)+(D+2)/p,
    U≤U(D,p)=floor[(p²(D+1)−p+D+2)/(p(p−1))].                (7)

These bound the jumps and small-side variables before the rank.

## 4. A finite carry lemma, including the scaled form

For fixed positive integers m,E,V and1≤v_1≤V, and integer T, consider

    p^a(mv_r−T)=E+m∑_(i<r)(v_(i+1)−v_i)p^a_i,               (8)

with strictly increasing integer v_i≤V and cumulative ranks a_i.
Necessarily p|E. Start at(rank,value,carry)=(1,v_1,E/p).
At a state(n,v,R), termination at a=n requires R=mv−T.
Otherwise choose0≤Δ≤V−v with p|(R+mΔ), and pass to

    (n+1,v+Δ,(R+mΔ)/p).

Positive Δ records a jump change at cumulative rank n; Δ=0 records
no change. Require at least one positive change for the multijump
branch. Successive division of (8) proves completeness both ways.

All carries are positive. Choose B≥E/p and B≥mV, for example E+mV.
Then a transition stays≤B since(R+mΔ)/p≤2B/p≤B.
There are at most V−1 positive changes, while each run of zero changes
has length≤floor(log_p B). Hence

    a≤V(1+floor(log_p B)).                                  (9)

For (4) and (1), use v_i=u_i, V=U(D,p), T=t0 and
E=m(u_1+1)+D; (8) is exactly their rearrangement. One may take
B=2mU(D,p)+D, as in the certificate. Equations(6)–(9) bound q;
Section1 then bounds n, completing hypothesis1.

The scaled version T=Lt0, v_i=Lu_i,
E=m(v_1+L)+LD is recorded for the separately labeled author proof of
[bounded denominators](../routes/global/BOUNDED_WILD_JUMP_DENOMINATORS_BOUND_ATLAS_DEGREES.md).
Its generalization is not needed to establish the audited integral case.

## 5. The complete integral genus-nine specialization

For p=5,h=16, the m≥t0 bound gives q≤22.5<25. On the other side,

    D:       1  2  4   8  16
    M(D,5):  1  2  5  11  23
    U(D,5):  2  3  6  11  21.

The [integral carry certificate](../routes/global/INTEGRAL_WILD_JUMP_CARRY_CERTIFICATE.py)
visits1351 states with no cutoff in rank or jump count. Its sole
multijump tuple(D,m,t0,q; (a_i,u_i); c) is

    (8,1,3,25; ((1,1),(2,4)); 83).

This tuple is locally impossible. Its first lower jump is1 and
|I_1/I_2|=5. In a parameter linearizing the tame generator, the
leading coefficient of γ(z)=z+b_γ z²+⋯ embeds I_1/I_2 as an F_5-line
stable under multiplication by ζ or ζ^(-1). Thus ζ∈F_5^*, so t|4,
contradicting3=t0|t. No multijump tuple remains. Section2 gives q=5
and n≤2240.

For upper/lower numbering, subgroup compatibility and Hasse–Arf see
[Kedlaya, §4.4, especially Remark4.4.13](https://kskedlaya.org/cft/sec_filtration.html).
Hasse–Arf supplies integrality for abelian P, not arbitrary P.
Hermitian wild groups genuinely have fractional jumps1,1+1/Q and
order Q³. Substituting arbitrary rational jumps into (5)–(7) would
invalidate the proof. Neither these finite necessary lists nor the
degree bound treats coreless spans or constructs a common cover.
