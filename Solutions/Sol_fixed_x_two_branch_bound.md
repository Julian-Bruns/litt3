# Proof record: Two-branch low-different atlases of the fixed curve

Canonical statement: [`fixed_x_two_branch_bound`](../Theorems/Thm_fixed_x_two_branch_bound.md).
Migrated 2026-09-06; hypotheses restated below are proof context.
The canonical statement and registry control promoted scope and evidence.

---

# Two-branch low-different atlases of the fixed genus-nine curve are bounded

Author: /root, 2026-09-06. Status: independently audited PASS, including
both exact certificates, by `/root/integral_jump_degree_bound_audit`.
[Audit record](../routes/global/audits/CORED_FIXED_PAIR_BOUNDED_MINIMAL_DEGREE_AUDIT_2026_09_06.md).
The widened one-endpoint scope was also checked in the
[all-quotients audit](../routes/global/audits/GENUS9_ALL_EFFECTIVE_ORBIFOLD_QUOTIENTS_AUDIT_2026_09_06.md).
The former fixed-pair statement is superseded by the
[stronger all-orbifold-quotients theorem](Sol_fixed_x_orbifold_bound.md).
This file retains the local calculation that theorem needs, not a
duplicate proof of its special case.

## Theorem

Let X be the fixed genus-nine curve in file76 and X -> S an effective
orbifold atlas with coarse P1 and exactly two branch points: one wild,
with 1<delta/e<2, and one tame. Its degree satisfies

    n<=2240, or n=112000, or n=336000.

No second endpoint, commutativity, solvability, upper-jump integrality,
or denominator bound is imposed. In the latter cases the signature is

    q=125, c=143, t=8 or24, other tame order=7 or21,
    lower breaks 1,6; |I_1/I_2|=25, |I_2|=5.

## 1. Retained reductions and small wild orders

Use the local atlas notation of the
[checked signature reduction](../routes/global/CORED_ZERO_ONE_FORM_INTERSECTION_AND_WILD_SIGNATURE_REDUCTION.md),
with reduced tame order m:

    c m-q t0=D, D|16, gcd(m,t0)=1, t0|(m+D),
    t=g0 t0, n=(16/D)q g0 t0 m, 0<c<qt.

Every positive lower group is a 5-group, so c=3 modulo4. If q<=25,
the wild group is abelian, hence has integral upper jumps. The checked
[integral-jump theorem](Sol_integral_jump_bound.md)
then gives q=5 and n<=2240. Henceforth q>=125.

Set S=c-q+2=2g(H) for the auxiliary HKG wild curve. Split into large
(S<4q/5) and non-large cases. This does not impose ordinarity on H.

## 2. The non-large case has just one possible first-layer pattern

Here c-q>=4q/5-2. The m>=t0 case would force q<=5(D+2)/4<=22.5,
impossible. As proved in the integral-jump theorem,

    m<t0, m<=floor(26D/18), t0|(m+D).

If b is the first lower break and |P/P_(b+1)|=5^r, the positive different
sum and q>=125 give

    b<=floor[(125t0+D+m)/(124m)],
    5^ceil(r/2) | E:=D+(b+1)m,
    t0 | b(5^r-1), 5 does not divide b.

The b bound follows from b(q-1)<=c+1=(qt0+D+m)/m and monotonicity
in q. These are FINITE ranges for every variable in this display; the
total exponent in q is not bounded or truncated.

The [complete standard-library certificate](../routes/global/GENUS9_FIRST_LAYER_SIGNATURE_CERTIFICATE.py)
returns exactly these rows (D,m,t0,b,r,E):

    (2,1,3,2,2,5), (8,1,3,1,2,10),
    (8,1,9,6,2,15), (16,2,3,1,2,20).

The first and third would give respectively c=3q+2 and c=9q+8,
both 1 modulo4, contrary to c=3 modulo4. The fourth would require
2c=3q+16, an odd integer. Thus only

    D=8, m=1, t0=3, b=1, r=2, c=3q+8              (1)

remains. The first tame graded-character rule gives t|24, so g0|8.
The strict inequality c<qt excludes g0=1. Therefore g0 is2,4,or8.

## 3. The endpoint curve excludes (1), in ALL degrees

Put d=g0. The coarse map X->P1 has degree n=6dq, with two distinct
points P,Q over the wild branch, each of ramification index3dq.
The other branch has index d at every point. Put the wild branch at
infinity and the tame branch at zero, with coordinate z.

Pull back the rational weight-d differential

    beta=(dz)^d/z^(d-1).

Its orders on P1 are -(d+1) at infinity and -(d-1) at zero. At a point
of local index e and different delta, the pullback order of a weight-d
tensor of order a is ea+d delta. Thus the pullback is nonzero and regular,
has no zero over the tame branch or elsewhere, and has order

    -(3dq)(d+1)+d(3dq+c)=d(c-3q)=8d

at EACH of P,Q. Consequently it has divisor 8d(P+Q).

The [two-primary W3 theorem](Sol_two_primary_w3.md) excludes this divisor
directly. Since div(theta)=16O, it gives 8d[P+Q-2O]=0. Applying W3 to
P+Q+O shows [P+Q-2O]=0. A nonconstant function with divisor P+Q-2O
would be a degree-two pencil, impossible on X; hence P+Q=2O, contrary
to distinctness. This holds for every power-of-two d.
This contradiction eliminates the whole non-large case, including
arbitrarily large and nonabelian deeper ramification subgroups.

## 4. The large case is bounded without controlling the deeper group

The [checked first-layer theorem](Sol_wild_first_layer.md)
gives b=1, r=2, t|24, and

    S>=4q/25.

It also excludes m>=t0. Thus 1<=m<t0, t0|24, t0|(m+D), and
5|(D+2m). The strict inequality S<4q/5 and the genus equation imply
t0/m<9/5. The same certificate lists exactly

    (D,m,t0)=(1,2,3),(1,7,8),(16,2,3).

The last has 2c=3q+16 odd, impossible. In the first, c=3 modulo4 and
q=1 modulo4 would imply 2c=6 modulo8, whereas 3q+1 is either4 or0
modulo8 (q is a power of5). Thus only (1,7,8) remains.

Now c=(8q+1)/7, so S=(q+15)/7. Its lower bound gives

    (q+15)/7>=4q/25, hence q<=125.

Therefore q=125 and c=143. Since |P/P2|=25, P2 has order5, and its
last lower break B satisfies S=4(B-1)=20, giving B=6. Finally
t=8g0 divides24, so g0=1 or3 and

    n=896g0 q=112000 or336000.

Combining the small-wild-order, non-large, and large cases proves the
atlas-degree assertion.

## What remains

The stronger all-quotients theorem handles every other coarse signature
and all second endpoints. Bounded cored existence and coreless spans
remain open. The retained mechanism uses the actual genus-nine endpoint
through its low-degree maps and Frobenius polynomial; its torsion
criterion is parameterized and can be used for other suitable endpoints.
