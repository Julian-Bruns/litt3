# Proof of the degree-seven trace obstruction and degree-nine reduction

24 September 2026. This is a local continuation beyond the three incoming
replies. It uses [norm constraints](seven_point_norm_cartier.md),
[the finite missed-point theorem](finite_missed_point_cartier.md), and the
established seven-point lower bound. It retains an actual finite etale cover
h:S->X and primitive q=f+b^5 with all divisor and order-five conditions.

## The trace obstruction at actual degree seven

The underlying trace regularity statement is not restricted to seven.
For any actual witness of degree n for which D_G=h_*G~nO, choose
v with div(v)=D_G-nO and put s=-Tr(b). With d=B_0/y as below,
\[
v(s-nd)\text{ is regular away from }O,\qquad
yvs\in L((n+12)O),\qquad yvs\equiv nB_0v\pmod{(y)}.
\]
Here v is an arbitrary member of L(nO), not necessarily a polynomial
in x. The integer n is read in characteristic five. These assertions
follow from b+d having finite poles bounded by G and pole order at most
2+mult(G) at infinity. Trace needs no division by n. They provide linear
constraints in every degree where the displayed divisor equivalence is
known; they need not have trivial kernel, and may weaken when5 divides n.
The calculations below are the exact n=7 and n=9 specializations.

The norm theorem reduces degree seven with seven projected support points
to B=O plus two complete cubic fibers. Already B~7O, so h_*G~7O.
Consequently h_*G=div(v)+7O for some nonzero polynomial v of degree at
most two. Zeros of v may repeat, meet branch values, or coincide downstairs
with E-support; none of those possibilities is discarded.

Let Z be the ten finite cubic branch points, so div(y)=Z-10O. Define
\[
B_0=(8,14,19,2,10,19,3,24,18,16),\quad d=B_0(x)/y.
\]
Exact arithmetic gives \(Q-B_0^5\in(P^2)\), so f-d^5 is regular away
from O. Therefore b+d has poles away from h*O bounded by G: its fifth
power is q-(f-d^5), and q has pole divisor at most5G away from infinity.

Set s=-Tr(b). Since the degree is seven, which equals2 in k,
\(s-2d=-\operatorname{Tr}(b+d)\). Etaleness shows that its finite poles
are bounded by h_*G, with all multiplicities retained. Thus v(s-2d) is
regular away from O.

At a point over O in E, q and f both have order-7; because q-f=b^5,
b has pole order at most one. At the other points over O, q has order
-10-5g, where g is the G-multiplicity, and b has pole order exactly2+g.
It follows that s has pole order at most2+(h_*G)(O). Since
(h_*G)(O)=7-3 deg(v), the function yvs has pole order at most19 at O.
It is regular elsewhere. Write
\[
yvs=S_0(x)+yS_1(x),\qquad\deg S_0\le6,\quad\deg S_1\le3.
\]
Regularity of v(s-2d) at each cubic branch point requires
\(S_0-2B_0v\equiv0\pmod P\). In particular the coefficients of x^7,x^8,x^9
in B_0v modP vanish. Their matrix on (v_0,v_1,v_2) is
\[
\begin{pmatrix}[24]&[0]&[13]\\[18]&[16]&[2]\\[16]&[5]&[14]\end{pmatrix},
\qquad\det=[23]\ne0.
\]
Thus v=0, a contradiction. The argument never assumes prime-to-five
normal closure; it works at actual degree seven with any monodromy.

## All smaller degrees when a finite point is missed

The single-point theorem makes every positive occupancy divisible by5.
For actual degree n<10 a positive occupancy is therefore exactly5, so
the number of projected points is n. The established lower bound leaves
only n=7,8,9. Degree seven has just been excluded.

For degree eight, the norm theorem gives a reduced eight-subset B of R_X
with2B~16O. No such subset exists. Indeed a function witnessing this
equivalence belongs to L(16O), hence has form U(x)+V(x)y with deg U<=5,
deg V<=2. It has double zeros at the at least seven finite points of B.
At a fiber containing two zeros, U and V vanish at its x-coordinate,
so all three points are zeros. Requiring all three to be double also
forces U' and V' to vanish there. If V is nonzero, at most one fiber can
contribute three points and each other fiber contributes at most one:
at most six finite points. If V=0 the finite support is a union of complete
fibers, whereas seven or eight is not divisible by three. Both cases
contradict the required support.

## The four degree-nine supports and the polynomial pencil

At degree nine, again B is the reduced projected support and2B~18O.
Now L(18O) has U degree at most6, V degree at most2, and no y^2 term.
The same double-zero argument forces V=0. Thus O is not in B and B is
three complete fibers. Already B~9O. This gives four choices and
h_*G=div(v)+9O with deg v<=3.

The preceding trace argument now uses s=-Tr(b) and
s-4d=-Tr(b+d). It gives yvs in L(21O). Write it as
S_0+yS_1+y^2S_2 with degrees at most7,3,0 respectively. Regularity
requires S_0-4B_0v divisible by P. The coefficients of x^8,x^9 give
\[
\begin{pmatrix}[18]&[16]&[2]&[16]\\[16]&[5]&[14]&[10]\end{pmatrix}
\begin{pmatrix}v_0\\v_1\\v_2\\v_3\end{pmatrix}=0.
\]
This matrix has rank two and kernel basis
\((1,0,18,20)\), \((0,1,15,11)\), proving the pencil in the statement.
The norm divisor is3B-h_*G-18O, the divisor of b_3^3/v.
On the primitive quotient the nine supported occupancies require degree
at least nine; since that degree divides nine, q generates the cover.

For completeness the remaining degree-nine coefficient problem has a
finite-pole formulation. Since dq=df and Norm(q) is a fifth power, the
monic polynomial of q is
\[
Z^5\big((Z-f)^4+a_1^5(Z-f)^3+a_2^5(Z-f)^2+a_3^5(Z-f)+a_4^5\big)
+(\kappa b_3^3/v)^5.
\]
Indeed differentiation first forces its Z^1,...,Z^4 coefficients to
vanish. Translating the remaining quartic by f then makes its coefficients
Frobenius constants. Substituting q=f+b^5 and taking the unique fifth root
gives the irreducible degree-nine polynomial for b:
\[
(B^5+f)(B^4+a_1B^3+a_2B^2+a_3B+a_4)+\kappa b_3^3/v.
\]
The a_j are the first four elementary coefficients of b. At a finite
cubic branch point their pole order is at most j+D_G(P); at other finite
points at most D_G(P); at O at most2j+D_G(O). Thus
\(y^jv a_j\in L((9+12j)O)\), for j=1,...,4. These necessary equations
do not replace etaleness, irreducibility or the nontrivial order-five class.

## Verification

The dependency-free
[coefficient verifier](../../scripts/arithmetic/degree_seven_trace_obstruction.py)
checks Q'=PA^2, computes B_0 as the inverse fifth power of Q modulo P,
checks divisibility by P^2, and reconstructs both matrices and kernels.
A separate
[Sage audit](../../scripts/arithmetic/audit_degree_seven_trace.sage)
uses independent polynomial arithmetic and checks the same identities.
The exact certificate and logs are under
[local evidence](../../../litt3-computation-data/degree55_rank_support_replies_20260924/local/degree_seven_trace.json).
Neither implementation searches for covers or treats a necessary polynomial
as an actual etale realization.
