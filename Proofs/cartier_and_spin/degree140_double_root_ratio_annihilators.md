# Proof: adjugate identities eliminate the scale without dividing a minor

27 September2026. This integrates Sections24--34 of the received
[report](../../../litt3-computation-data/double_root_square_endpoints_reply_20260927/extracted/REPORT.md).
Retain the source and normalization of
[the endpoint theorem](degree140_double_root_endpoint_exclusion.md).
Write Astar(T,nu)=T^140 Rstar(nu,T^-1)=sum A_(n,a)T^n nu^a.
For B(T)=sum_(j=0)^70 B_jT^j set
\[
D_m(B)=[T^{m-1}](2Astar B'-Astar'B)
 =\sum_{j=0}^{70}(3j-m)A_{m-j}(\nu)B_j,\quad1\le m\le209.
\]
The coefficient with m=210 vanishes identically. Coefficients outside
the stated T- and scale-degrees140,6 are zero.

## The universal scale-independent identity

Seek polynomial multipliers of degree at most three in nu. Matching
coefficients of B_j nu^t gives a710x836 matrix
\[
M_{10j+t,\,4(m-1)+\ell}=(3j-m)A_{m-j,t-\ell},
\quad0\le j\le70,\ 0\le t\le9,\ 0\le\ell\le3.
\]
For any710 distinct columns J, let C=M[:,J] and D=det C. Multiplying
the coordinate vector at(j,t)=(0,0) by adj(C) gives polynomial multipliers
c_m(nu) satisfying sum c_m D_m(B)=D B_0. No minor or parameter is
inverted. The identity is valid over every commutative characteristic-five
coefficient ring, including nonreduced rings.

In normalized square-root coordinates put E=Lstar B^2-Astar and B_0=1.
The exact identity
\[
2Astar B'-Astar'B=B E'-2B'E
\]
puts each D_m in the full square ideal. The adjugate identity therefore
puts D in that ideal as well. Unit-triangular elimination of B_1,...,B_70
gives membership in the original seventy-equation presentation. This is
not merely generic pointwise vanishing.

## Specified nonzero determinants and their weights

The three ordered column lists and integer degree potentials are in
[the exact determinant evidence](../../../litt3-computation-data/double_root_square_endpoints_reply_20260927/extracted/evidence/ratio_eliminant.json.gz).
They are reconstructed by
[the source](../../scripts/arithmetic/pro_double_root_endpoints_20260927/ratio_eliminant.py).
Nonzero evaluations in the original K coding are
(u,q,D1)=(25,338890,22149),
(u,q,D2)=(27,127734,134498), and
(u,q,D3)=(25,338890,16126).
These are checks of polynomial nonvanishing, not assumed square points.
Separate determinant routines and multiplication against all710 scalar
coefficients verify the point certificates. Full actual-source norms at
both u-values are independently compared to the normalized global array.

Give q weight1 and u weight2. The relation g is monic of q-degree9 and
its reduction does not increase weight. The entrywise row/column potentials
bound the three determinant weights by132943,133128,132959, respectively.
Every potential inequality and its sum are checked directly; these are
bounds rather than claims about expanded coefficients or exact degrees.

## Finiteness with all exceptional ratios retained

The polynomial g=b u^2+2c u+3e is primitive in k[q][u], since gcd(b,c)=1,
and has discriminant4(c^2-3be), a nonconstant squarefree polynomial.
It is irreducible over k(q), hence defines a geometrically integral curve.
Its q-leading coefficient is a nonzero constant, so A is free of rank nine
over K[u]. Multiplication by the nonzero element D1 is injective on A.
Its determinant N1(u) is nonzero, and its adjugate puts N1 in(D1).

Smith normal form over the PID K[u] gives
dim_K A/(D1)=deg N1. If an element of A has weight at most W, its
multiplication matrix in1,q,...,q^8 has entry(i,j) of u-degree at most
floor((W+j-i)/2). The index sums cancel in determinant terms, so
deg N1<=floor(9*132943/2)=598243. Further quotienting by D2,D3 and
localizing cannot increase this length.

The finite presentation and this length bound do not compute the
exceptional algebra. In particular no determinant-zero fibre is silently
removed. All seventy square equations and the free scale remain required.
The verification of these exact circuits is included in the51-command
[endpoint continuation replay](../../../litt3-computation-data/double_root_square_endpoints_reply_20260927/execution/logs/endpoint_continuation_checks.json).
