# A prime-order second ramification group cannot give unbounded atlas degree

Author: /root, 2026-09-06. Status: author proof and exact certificate;
not independently audited. No local or global realization is claimed
for the surviving numerical signatures.

## Theorem

In the two-branch atlas setting of the
[integral-jump theorem](../../Theorems/Thm_integral_jump_bound.md),
assume instead that the second LOWER ramification group has order p,
strictly less than q=|I_1|. Then the atlas degree n is bounded by an
effectively computable function of h=2g(X)-2 and p>=3. Fractional upper
jumps and arbitrarily large prospective wild group orders are allowed
at the outset.

For h=16,p=5 the finite necessary sieve gives q=125 and n<=336000.
Hence a jointly minimal cored fixed-pair candidate with M>336000
has |I_2|>=25, in addition to the already checked requirement of a
fractional upper jump. This says nothing about coreless candidates.

## 1. Local data and the reused divisibility theorem

Since |I_2|=p<q, the lower jumps are 1 and B>1, with
I_2=...=I_B of order p. Write

    q=p^(r+1),  b=B-1,
    c=q+(p-1)b-2,
    c m0-q t0=D, D|h,
    t0|(m0+D), gcd(m0,t0)=1.                          (1)

All m0,t0 and the common factor g0 are prime to p, as before.
The tame graded-character rule in
[file 13](13_PROOF_LOCAL_RAMIFICATION.md) gives

    t=g0 t0 | T := gcd(p^r-1,(p-1)(b+1)).             (2)

The first-break Swan-divisibility theorem in that same file gives

    p^ceil(r/2) | b.                                  (3)

Indeed the positive Swan sum is c+1, and its excess over q-1 is
(p-1)b. In particular b>=p. This uses integrality of Swan conductors
of representations, not integrality of the upper jumps themselves.

Once q is bounded, all remaining variables are bounded by Section 2
of the integral-jump theorem, which uses only (1) and t|c+1 at that
point. It therefore remains to bound q.

## 2. Outside the large-action range

First suppose b>=p^r=q/p. Then

    c-q >= (p-1)q/p-2.                               (4)

If m0>=t0, (1) gives q<=p(D+2)/(p-1). Otherwise the same elementary
argument as in Section 2 of the integral-jump theorem gives

    m0<=M(D,p):=floor[D(p^2+1)/(p(p-1)-2)],
    t0 is a divisor of m0+D larger than m0.            (5)

Equation (1), rewritten as

    (p-1)b m0=q(t0-m0)+D+2m0,

and (3) imply

    p^ceil(r/2) | D+2m0 <= D+2M(D,p).                 (6)

Thus r is bounded. This proves the desired bound in the entire case
b>=p^r, without a classification of the local group.

## 3. The large-action range and its literature input

Now suppose b<p^r. The Harbater--Katz--Gabber curve H for the local
wild P-action has

    g(H)=(p-1)b/2 >= p(p-1)/2 >=3.

This follows from its one-point different formula. Therefore

    |P|/g(H)>2p/(p-1).

The hypotheses of Matignon--Rocher Proposition 2.5 are exactly met:
this is a large p-group action and P_2 has order p. Their theorem
supplies b=p^s with s>=1 and r<=2s. The assumed strict inequality
b<p^r gives s<r. Put

    Q=p^s, R=p^(r-s), so p<=R<=Q,
    q=p Q R, c=q+(p-1)Q-2.                            (7)

Only these numerical consequences of the classification are used.
The HKG curve is an auxiliary LOCAL realization: it is not identified
with the common etale Galois refinement and need not have its p-rank.

If m0>=t0, then (1) implies D>=c-q=(p-1)Q-2. Thus Q, R, q are bounded.
Assume m0<t0 and put l=t0-m0>=1. Equation (2) implies

    t0<=T<= (p-1)(R+1).                              (8)

To check the second inequality, T divides both QR-1 and (p-1)(Q+1),
so it divides their linear combination (p-1)(R+1).
Equation (1) now becomes

    Q K=D+2m0,  K=(p-1)m0-pR l>=1.                   (9)

Since Q>=R>=p and m0<t0<=(p-1)(R+1),

    K<=Kmax(D,p):=floor[(D+2(p^2-1))/p].              (10)

Multiplying (9) by p-1 and substituting m0 from the definition of K gives

    (p-1)QK=(p-1)D+2pR l+2K.

Because R divides Q, this proves

    R | (p-1)D+2K,
    R <= (p-1)D+2Kmax(D,p).                           (11)

Finally (9) gives Q<=D+2(p-1)(R+1). Thus Q and q are bounded. Together
with Section 2 this proves the general theorem.

## 4. Complete characteristic-five, genus-nine sieve

For h=16,p=5, m0>=t0 is impossible in both cases: outside the large-action
range it gives q<=22.5 although q>=25; inside it gives Q<=4.5 although
Q>=5. Equations (5)--(6) enumerate all possibilities in the first case;
(7), (10)--(11) enumerate all possibilities in the second.

The [standard-library certificate](ORDER_P_SECOND_RAMIFICATION_SIGNATURE_CERTIFICATE.py)
finds these five full necessary tuples, written as
(D,q,B,t0,m0,g0,n):

    (1,125, 6,8,7,1,112000),
    (1,125, 6,8,7,3,336000),
    (8,125,66,3,1,2,  1500),
    (8,125,66,3,1,4,  3000),
    (8,125,66,3,1,8,  6000).

Further group-theoretic restrictions may remove entries; the stated
upper bound needs no assertion that any entry is realizable. In
particular the first local pattern is familiar from Hermitian curves,
but its occurrence here is not a construction of a genus-nine atlas.

## Primary references

The external large-action input is
[Matignon--Rocher, Smooth curves having a large automorphism p-group,
Proposition 2.5](https://www.math.u-bordeaux.fr/~mmatigno/JANT-Ma-Ro.pdf),
which records Lehr--Matignon's classification and its translation-space
dimension bound. The HKG realization is stated in
[Bleher--Chinburg--Poonen--Symonds, Automorphisms of HKG curves,
Section 1.B and Proposition 4.8](https://math.mit.edu/~poonen/papers/AutK.pdf).
The new arithmetic argument retains the atlas divisibility conditions;
it does not deduce a bound from a merely similar local example.
