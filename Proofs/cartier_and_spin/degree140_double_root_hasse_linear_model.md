# Proof: a leading-unit identity closes the characteristic-five carry

27 September2026. This integrates Sections51--57 of the final
[received report](../../../litt3-computation-data/double_root_square_linear_model_reply_20260927/extracted/REPORT.md),
whose complete scope is partial. The earlier endpoint exclusions and
finite determinant algebra remain valid inputs; neither is reinterpreted
as a decision of the remaining locus.

## A scheme-theoretic linear square criterion

Let S be any characteristic-five commutative ring. Suppose alpha(T) has
degree at most140, alpha(0)=1, and its coefficients alpha16,...,alpha23
generate the unit ideal. For B=1+sum_(j=1)^70 B_j T^j define V=B/alpha^63
as a formal series. Then the147 linear equations
\[
[T^n]V=0,\qquad 1\le n\le148,\quad n\ne125
\tag{1}
\]
define precisely B^2=alpha, over S and every S-algebra.

Necessity follows from V=B^-125 when B^2=alpha. For sufficiency work
in the quotient by(1), so V=1+v T^125 modulo T^149. Frobenius gives
\[
B^2/\alpha=\alpha^{125}V^2
 =1+\gamma T^{125}\pmod{T^{149}}.
\]
Since B^2-alpha has degree at most140, it equals T^125 Q with deg Q<=15.
Consequently Q=gamma alpha modulo T^24. The coefficients16--23 give
gamma alpha_i=0. The unit-ideal hypothesis forces gamma=0, then Q=0.
This quotient-ring argument preserves nilpotents. Without the hypothesis,
alpha=1+T^125,B=1 is a counterexample even over a field.

## The actual-family unit identities

Use A=K[u,q]/g_monic, free of rank nine over K[u], and retain the scale
nu as a polynomial variable. Literal coefficient multiplication proves
\[
\sum_{i=16}^{23}\sum_{j=0}^{8}c_{ij}(u)q^j[x^i]Rstar=1,
\qquad
\sum_{i=117}^{124}\sum_{j=0}^{8}h_{ij}(u)q^j[x^i]Rstar=L.
\tag{2}
\]
The first certificate has64 nonzero rows and maximum u-degree5009;
the second has64 rows and maximum u-degree4215. These are exact products
in the entire ring, not interpolation at selected ratios. The independent
verifier uses monic-q reduction and retains all scale coefficients.

The second identity makes the coefficients16--23 of Astar/L generate1
after inverting only the already required L. The first also excludes a
factor(x-a)^125: Frobenius would make every coefficient16--124 of a
degree140 such product zero, contradicting(2). This holds after arbitrary
nonzero base change, including nonreduced rings.

The literal witnesses and independent multiplication outputs are
[lacunary_global.json.gz](../../../litt3-computation-data/double_root_square_linear_model_reply_20260927/extracted/evidence/lacunary_global.json.gz)
and [late_linear_global.json.gz](../../../litt3-computation-data/double_root_square_linear_model_reply_20260927/extracted/evidence/late_linear_global.json.gz).

## Polynomial Hasse rows and the unit pivot

Write D^(r) for the Hasse derivative and r(n)=5^v5(n). On the row set
in(1), r(n) belongs to{1,5,25}. There is a polynomial H_r such that
\[
D^{(r)}(Astar^{63})=Astar^{63-r}H_r(Astar).
\]
Indeed every term differentiates at most r of the63 factors. Explicitly,
\[
H_1=3Astar',\quad
H_5=Astar^2 D^{(5)}(Astar^3)+2(Astar')^5,
\]
\[
H_{25}=Astar^{12}\sum_{i=0}^5
D^{(25-5i)}(Astar^3)(D^{(i)}(Astar^2))^5+2(Astar')^{25}.
\]
Use the polynomial matrix
\[
M_{n,j}=\binom{j}{r(n)}[T^{n-j}]Astar^{r(n)}
 -[T^{n-r(n)-j}]H_{r(n)}(Astar),\quad0\le j\le70.
\tag{3}
\]
The equations sum M_(n,j)B_j=0 are an invertible triangular transformation
of(1). The coefficient of V_n is binom(n,r(n)), a nonzero prime-field
element. The omitted V125 never contributes because D^(j)T^125=0 for
1<=j<=25. Normalizing or unnormalizing Astar multiplies rows by units.

The first70 equations are triangular on B1,...,B70. Their determinant
is3 L^166, since there are56,12,2 rows of respective orders1,5,25.
Their unique solution is B=(Astar/L)^63 modulo T^71. Therefore the77
bordered71x71 determinants define the same whole square ideal. Put
\[
C_j=[T^j]Astar^{63},\qquad G_n=\sum_{j=0}^{70}M_{n,j}C_j.
\]
For each late row the bordered determinant is exactly3 L^103 G_n.
Proving this first in the universal polynomial ring localized at L,
then using injectivity of that localization, shows the polynomial
identity survives every base change. No determinant-zero point is removed.

## Degree bounds and what has actually been checked

Every source coefficient satisfies4 deg_nu([T^i]Astar)<=3i and deg_nu<=6.
The r-row bound is min(6r,floor(3n/4)); after eliminating the root it is
min(6r+52,floor(3n/4)). Their maxima are75 and82. In the already established
polynomial normalization Asharp, assign wt(u)=2,wt(q)=1. Monic-q
reduction does not increase weight, and wt([T^i]Asharp)<=21+18i. Thus
\[
\operatorname{wt}(Gsharp_n)\le21(63+r(n))+18n\le4038.
\]
This gives u-degree<=2019 and q-degree<9.2020 distinct complete
K[q]/g(q,u0) evaluations, keeping the entire scale polynomial, would
suffice for exact interpolation. Choosing one root in each fibre would
not suffice. The77 global generator expansions remain uncomputed.

The universal proofs above were reviewed locally. All eight focused
commands passed: source-data verification, both literal products, the
global Hasse support audit, arbitrary-field/dual-number model tests,
complete length-nine algebras at u=1,132, and six small determinant checks.
See [the execution record](../../../litt3-computation-data/double_root_square_linear_model_reply_20260927/focused_verification.json).
The finite model tests are implementation checks; they do not prove
global emptiness. The global statements instead follow from(2) and the
ring identities. The existing1375 historical prefix evaluations were
not unnecessarily repeated during this integration.

New source is retained beside the inherited implementation, including
[hasse_linear.py](../../scripts/arithmetic/pro_double_root_endpoints_20260927/hasse_linear.py)
and its independent checks. The unmodified original ZIP, extracted
source tree, exact inputs and generated verification logs remain in
[the external evidence directory](../../../litt3-computation-data/double_root_square_linear_model_reply_20260927/).
