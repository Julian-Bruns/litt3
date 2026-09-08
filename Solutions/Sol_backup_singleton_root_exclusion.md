# Proof: three complete norm charts, with exact unit certificates

[Statement](../Theorems/Thm_backup_singleton_root_exclusion.md).
Root2026-09-08. The geometric reduction below passed a fresh medium
audit. The auditor did not execute computations; root replayed all
three corrected unit identities. No solver's empty output is relied on.

## 1. A degree-twelve function captures every geometric class

Suppose P=(b,c) is nonbranch and M meets the two displayed conditions.
Let m=Fr_J^(-1)(M), using relative Frobenius on geometric points.
Riemann--Roch supplies an effective degree-two D with m=[D-2O]. Since
V Fr_J=[5], there is a rational h with

    div(h)=5D-2P-8O.

In the rational frame of M=O(D^(1)-2O^(1)), its Frobenius pullback
has frame divisor5D-10O. Thus eta/h, eta=du/v, represents the section
of omega_C tensor F_C^*M with zero divisor2P. This section is unique
up to scalar: h0(O(2P))=1 for a non-Weierstrass genus-two point.
Theta membership therefore forces Cartier(eta/h)=0. In this rational
frame this is ordinary rational Cartier; no untwisted substitution
for the line bundle or prime-to5 assumption on M has been made.

Set n=h(u-b)^2=A+vB. Its divisor is

    div(n)=5D+2iota(P)-12O.                       (1)

If D avoids O, its pole has exact order12, so deg A=6,deg B<=3;
scale A6=1. If D=Q+O with Q!=O, its pole has exact order7, so
deg A<=3,deg B=1; scale B1=1. These statements follow from the
pole semigroup<2,5>; even and odd pole orders cannot cancel.
D=2O would give2P~2O, impossible for nonbranch P.

Taking norms in(1) gives A^2-FB^2=(u-b)^2 R^5, where deg R is2
or1 respectively and a nonzero scalar is absorbed in R. It follows that

    eta/h=(A/v-B)du/R^5.

Because B has degree<=3, its term is Cartier-zero. Since A/v=AF^2/v^5,
the exactness condition is precisely the THREE linear equations

    [u4](AF^2)=[u9](AF^2)=[u14](AF^2)=0.          (2)

In smaller degrees the last equation is identically zero. Every
unknown coefficient ranges over bar(F5), not a sampled finite field.

## 2. Exhaustive charts

Write N_j for coefficients of N=A^2-FB^2.

OPEN: D avoids O and P. Equation(1) makes n(P)!=0 and n(iota P)=0,
so A(b)!=0. All A with A6=1 satisfying(2) form an explicitly checked
three-dimensional affine space; B has four free coefficients. The
necessary norm equations are

    N3=N4=N8=N9=0,
    N_(j+1)=-2b N_(j+2), N_j=b^2 N_(j+2), j=0,5,10.

Add z A(b)=1. This is the first certificate's9-variable11-equation system.

O-BOUNDARY: D=Q+O. One cannot have Q=P: by(1), both A and B would
be divisible by(u-b)^2, contradicting deg B=1. Thus A(b)!=0 again.
Use B=u+B0 and the full two-dimensional linear space of A of degree
<=3 satisfying(2). Impose N3=N4=0 and the same two coefficient
relations for j=0,5, plus z A(b)=1: five variables, seven equations.

P-BOUNDARY: D=P+Q avoids O; Q=P is allowed. At the two distinct
points P,iota(P), equation(1) forces vanishing of n to orders at
least5 and2. Hence(u-b)^2 divides BOTH A and B. Write

    A=(u-b)^2 A0, B=(u-b)^2 B0,
    deg A0=4 monic, deg B0<=1.

For N0=A0^2-FB0^2 the necessary identity is
N0=(u-b)^3(u-x(Q))^5. Its coefficient equations, now denoted n_j, are

    n4=0,n7=-3b,n6=3b^2,n5=-b^3,
    n2=-3b n3,n1=3b^2 n3,n0=-b^3 n3.

Keep(2) on the ORIGINAL A=(u-b)^2 A0, and add z F(b)=1.
This is the eight-variable11-equation third system. No spurious norm
sheet choices need be removed: enlarging a necessary locus is safe
for its exclusion. D containing iota(P), a branch point, or a repeated
point was never omitted by the three-chart partition.

## 3. Exact certificates, not Groebner verdicts

The source [backup_singleton_root_exclusion.sage](../scripts/backup_singleton_root_exclusion.sage)
reconstructs F, all original equations and the COMPLETE linear spaces
in(2). It explicitly multiplies every kernel basis by its original
matrix and checks its full dimension and the pole-six normalization.
For each chart it then decodes the saved polynomial multipliers and
checks the identity sum multiplier_i*equation_i=1 coefficientwise.
A damaged-multiplier negative control is included. Replay performs
no Groebner basis, ideal membership or root search.

Saved certificates in Research/computations:

| Chart | Unit multiplier terms | Corrected generation | Replay |
| --- | ---: | ---: | --- |
| singleton_norm_open.json | 71998 | 13.599s | PASS |
| singleton_norm_contains_O.json | 66 | 0.065s | PASS |
| singleton_norm_contains_P.json | 1666 | 0.133s | PASS |

All three replayed in0.535s total on ONE CPU core:

    OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1 MKL_NUM_THREADS=1 VECLIB_MAXIMUM_THREADS=1 sage scripts/backup_singleton_root_exclusion.sage

The corrected source uses generic finite-field matrix arithmetic.
During pre-promotion checking, the default dense backend over the
specified non-Conway F125 returned a kernel failing C*K^T=0. Its
earlier open/O outputs were invalid parametrizations and have been
REPLACED. The present checks guard exactly against that failure.
The direct P-boundary system did not use a kernel parametrization.

These exact identities are impossible at any geometric solution of
the necessary systems. Section2 covers every D, proving the stronger
nonbranch exclusion for M of all orders.

For prime-to5 root data the nonbranch equivalence and the Weierstrass
exclusion are those of singleton_cartier_theta_bound. Thus no point
P, and no prime-to5 root weight, works. The same theorem identifies
the forced theta points and degree16 residual; since the nonbranch
support is now empty, its residual multiplicity stays at the forced
points. This completes the claimed endpoint result, not the original
two-endpoint problem.
