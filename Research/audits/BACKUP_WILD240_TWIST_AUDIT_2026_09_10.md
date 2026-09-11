# Backup wild240 twisted normal-form audit

Date:2026-09-10. Auditor:/root/audit_backup_wild240_twist.

Verdict: **PASS** for the new actual-double/twisted-polynomial dictionary
and its use with the recorded chart computations. No coefficient repair
or additional geometric hypothesis is required. This is a bounded prose
and exact-computation audit, not formal verification.

Scope: Solutions/Sol_backup_wild240_atlas_exclusion.md and
scripts/verify_backup_wild240.sage, extending the already audited
backup_wild120_atlas_exclusion. The local conductor-two
Artin--Schreier calculation from that theorem is an established input;
this audit checks its transfer, parity, section space, pole bounds,
scheme-theoretic equations and implementation.

The root's full one-core run reports29 unit ideals and one nonunit
ideal containing lambda. The latter is just as sufficient here because
the actual local Galois normal form requires lambda!=0. I independently
replayed that exceptional chart and one degree-two-twist generic chart.
No claim that all30 unlocalized ideals are unit should be made.

## 1. The actual double and its completions

For the supposed degree240 atlas, div(f)=6D0-40Dw. At every point of C
this has even valuation, and2 is invertible. Locally extract the even
uniformizer power; adjoining the square root of the remaining unit is
etale. Hence normalization in sqrt(f) is an actual etale double T->C,
not a ramified substitute. This is the local Kummer construction
([Stacks, Kummer theory](https://stacks.math.columbia.edu/tag/03PK)).

At a wild point write L/K for the actual completed Galois extension
of degree40 and different47. The subfield K'=K(sqrt(f)) is its tame
quadratic subfield: sqrt(f) is in L by Hensel extraction of the unit,
and its valuation over K is half-integral. Transitivity of differents
gives

    47 = delta(L/K') +20*1,

so the new extension has degree20 and different27. At0 the tame index
6 becomes3. The two choices of the square root give isomorphic
extensions over a fixed K': a K-automorphism of L interchanges them.
Thus the common completed extension condition is retained.

Equivalently normalize the original orbifold in k(sqrt(f)); locally
this replaces the inertia group by its index-two subgroup. The resulting
orbifold cover is finite etale and its pullback to C is T. This supplies
an actual degree120 atlas on a component if the double is split, so the
established degree120 theorem applies in that case. If connected, T has
genus3 and z=sqrt(f) has degree240 and profile(20,27;3).

## 2. Parity, bounded primitive and all two-torsion sections

The deck involution sends z and Dz to their negatives, hence sends
s0=(Dz)^3/z^2 and b0=(Dz)^20/z^13 to their negatives. The explicit
primitive construction of the degree120 proof therefore gives
anti-invariant S and Bprim with DBprim=S^7. Its common local coefficient
lambda=3/a^4 is nonzero. Changing z to-z changes sqrt(z) by a fourth
root of unity, so a^4 and lambda are unchanged. Consequently

    R=(Bprim-lambda*(DS)^5)/S^5

is invariant. The degree120 argument is local except for its pole
budget, which here holds separately at both unramified points over O.
One has Bprim in L(40*pi^*O), S of pole6 or5, and R in L(15*pi^*O).
Thus R descends to L(15O) on C, with DR=S^2 and the same finite-zero
condition R*(DS)^5=lambda*(D^2S)^5.

The15 nonzero two-torsion classes are represented without repetition
by E consisting of one or two of the five finite branch factors.
For J=F/E, the affine algebra

    k[u,w1,w2]/(w1^2-E,w2^2-J)

is smooth: E,J are coprime squarefree polynomials, so at most one of
w1,w2 can vanish, and the corresponding polynomial derivative is a
unit there. It is therefore the actual normal affine double, with
v=w1*w2. Its anti-invariant part is k[u]w1 plus k[u]w2.

At both points above O the pole orders of w1,w2 are m and5-m,
where m=deg(E). Thus the five functions

    w1, u*w1, u^2*w1, w2, u*w2

times eta^3 are regular anti-invariant cubic sections. They are
independent and h0(omega_C^3 tensor M)=5 for nontrivial degree-zero M,
so this is the complete space. The two summands' pole orders have
opposite parity, preventing an omitted cancellation at infinity.

## 3. Differential equations and pole45 coefficient

Direct differentiation gives Dw1=(E'/2)w2 and Dw2=(J'/2)w1.
For S=w1*A+w2*B and R=P+vQ this yields exactly

    P'=2AB,
    FQ'+(F'/2)Q=EA^2+JB^2.

The stated P includes every derivative-kernel term allowed by degP<=7,
namely r0+r1*u^5. There is no denominator5 in its integration because
deg(2AB)<=3. The rank-six constant matrix for Q and its three remaining
quadratic consistency equations match the code.

For an independent sign check choose the pulled-back uniformizer
t0=u^2/v. Then u~t0^-2, v~t0^-5 and eta~3t0^2 dt0. If the leading
coefficient of a pole-six S is s, then DS~3s*t0^-9 and
R~Q5*t0^-15. Therefore the forbidden pole45 of
Bprim=S^5R+lambda*(DS)^5 has coefficient

    s^5*(Q5+3lambda).

Since Bprim has pole at most40, lambda=3Q5. This holds at both points
above O. For m=1 the generic leading coefficient is B1; for m=2 it is
A2. In the boundary it is respectively A2 or B1, giving pole5 and a
simple zero of the cubic differential at O. If both top coefficients
vanish there is a multiple zero, which an atlas section cannot have.
The two stated charts per E are therefore exhaustive. Scalar
normalization of S is allowed by the explicit primitive construction.

## 4. Scheme-theoretic necessity of both remainder equations

The displayed C1,G1,C2,G2 and L1,L2 follow by applying D and fifth
powers to the above formulas. In particular the code differentiates
the full first derivatives before reducing modulo N; differentiating
an arbitrary remainder instead would be wrong and is not done.

Let L=w1L1+w2L2. At every finite zero of S, the local condition gives
L=0, and S has a simple zero. Hence L/S is regular everywhere on the
affine double. It is invariant and therefore lies in k[u,v]/(v^2-F).
Multiplication by w1A-w2B gives its exact expression

    L/S = (EA L1-JB L2 +v*(A L2-B L1))/(EA^2-JB^2).

Since1,v are a free k[u]-basis of the invariant affine ring and remain
linearly independent over k(u), BOTH numerator coefficients must be
divisible by N=EA^2-JB^2. This proves the full multiplicities, including
common A,B roots and finite Weierstrass support. No squarefreeness
assumption on N or cancellation of a potentially vanishing factor is
being inserted. Omitting the infinity local condition only enlarges
the necessary boundary system.

## 5. Code and executed checks

The script's15 E values, both normalizations, fixed-sign monic N of
degree6 or5, quotient reduction, fifth powers, two numerator equations
and lambda relations agree with the geometric formulas. All coefficient
constraints are imposed in polynomial ideals over F125, not by a
finite-point search. Coefficient extension to bar(F5) cannot create a
point of a unit ideal or of an ideal containing lambda on lambda!=0.

The matrix uses implementation='generic' and its inverse is checked
again after extension to the polynomial ring; the known optimized
finite-extension matrix-backend issue is thereby avoided here.

Independent bounded executions:

    sage scripts/verify_backup_wild240.sage --twist 4 --chart infinity
    sage scripts/verify_backup_wild240.sage --twist 14 --chart generic

The exceptional twist4 infinity chart reproduced in0.120s internally:

    b0^2,
    r0-r1+(alpha+2)*b0,
    a0+alpha,
    a1+(alpha-1),
    a2-1,
    b1,
    lam.

Its whole geometric zero set has lambda=0, contrary to the actual
local Galois input. The independent twist14 generic execution returned
[1] in2.877s internally. The root's remaining28 unit results complete
the30-chart list. The updated script distinguishes 'unit' from
'zero_lambda'; that distinction must be retained in the theorem and
execution receipt. No explicit unit multipliers or independent full
30-chart rerun are claimed by this audit.

Conclusion: with those recorded exact chart outcomes, no actual
degree240(40,47;6) orbifold atlas has the backup source. This is only
the stated cored-profile exclusion; it is not a general rational-map
profile exclusion or a solution of the unmarked common-cover problem.
