# Proof of the large-inertia restriction

Use F25=F5(beta), beta^2=beta+3, code[a+5b]=a+b beta, and ascending rows
\[
P=(11,22,18,5,19,20,15,16,9,22,1),\quad A=(1,21,14,22,13).
\]
Write q(t)=epsilon^4 t^-13 and lambda(t)=epsilon^-17 t^48.
We prove the statement with the exact endpoint hypotheses in
[the theorem](../../Theorems/cartier_and_spin/parameter_large_inertia.md).

## Finite inputs and their exhaustive coverage

Put H=P^2 A'^3/A^3, J=(A/A')H'/H, K=(A/A')J', and R=H^13/A^48.
P,A,A' are squarefree and pairwise coprime; A has three distinct
nonzero critical values. The following verified inputs concern ALL
geometric points, not only points of the coefficient field.

The ordinary ordered pairs a!=b, with APA'(a)APA'(b)!=0 and
J(a)=J(b), K(a)=K(b), form a reduced finite scheme of312 points.
The map (a,b)->R(b)/R(a) is injective, and none of its values is1.
Indeed the divided-difference resultant has monic factorization
\[
\widehat {\operatorname{Res}}=\widehat A^9 P^{39}\widehat {A'}^{64}N,
\quad \deg N=312,
\]
with N squarefree and coprime to APA'. In F25[X]/N the stored Bezout
identity Sf+Tg=Y-phi(X) gives the unique partner. The identities
phi(phi(X))=X and psi(R(phi(X))/R(X))=X, together with unit tests,
prove the asserted coverage and separation.

At roots of P the ten values of
\[
B_P=AP''/(P'A')+2AA''/A'^2-3
\]
are distinct. At roots of A' the three values of
\[
C_A=A(PA'''+2P'A'')^2/(P^2 A''^3)
\]
are distinct and nonzero. Let G=A'^3 P^2, D_A=(1/A')d/dx and
g_i=D_A^iG/(i!G). At the four roots of A, g1 is nonzero and the
four values of Z_A=g3/g1^3 are distinct. These statements are exact
minimal-polynomial and unit certificates in finite etale algebras.
The report's second-order A invariant is constant, so the third-order
test must not be omitted.

The [returned report](../../../litt3-computation-data/structural_slices_replies_20260925/extracted/quartic/galois_quartic_result/REPORT.md)
contains the finite-algebra identities, their sizes and local jet
derivations. Its complete verifier, including separate inverse-series
checks, passed in the [local replay](../../../litt3-computation-data/structural_slices_replies_20260925/local_checks/quartic.log).
The source is retained under
[pro_structural_slices_20260925/quartic](../../scripts/arithmetic/pro_structural_slices_20260925/quartic/).
The stronger scalar-subfield certificate is not needed here.

## One possible large-inertia value

Take a point with t=c+O(s^e), c!=0,infinity and e=4 or e>=7.
The endpoint fibers exclude c=0,infinity. Always ord_s(dt)>=e-1;
equality is used only when e=4. Thus the argument also covers wild e.
We show that either q(c)=lambda(c)=1, or the endpoint values are one
of the ordinary pairs above. In the latter case that pair determines c.

First suppose an endpoint is infinite. The A identity makes both
endpoints poles of the same order a in{1,3}. Write u=s^-a and
v=ell u+C+O(s^a)+O(s^(e-a)). This expansion through its constant
term follows from A(v)=q(c)A(u)(1+O(s^e)); the inverse branch of A
at infinity is tame. In particular
\[
v'/u'=\ell+O(s^{\min(2a,e)}),\quad
P(v)/P(u)=\ell^{10}\left(1+[22](\ell^{-1}-1)s^a
 +O(s^{a+1})\right).
\]
The term involving the constant C disappears because10=0 in k.
The differential identity has no relative term of order a on its
left, while lambda(t)=lambda(c)(1+O(s^e)) and e>a. Since[22]!=0,
comparison forces ell=1. The leading terms give q(c)=lambda(c)=1.
This replaces the degree-four common-pole table; no bound on deg(t)
was used.

At finite endpoints the cube ratio and ramification assumptions leave
four cases: two unramified P-roots, two index-three P-roots, one
index-three P-root and one non-P-root, or two non-P-roots. A mixed
index-one/index-three P-pair is impossible modulo3.

When one index-three P-branch is paired with a non-P value, the two
terms in d log A(v)-d log A(u) have orders2 and either0 or1. The
latter alternatives follow from the simple critical points of A.
Hence ord(dt)<=1, contrary to e>=4.

For two unramified P-roots alpha,beta, set w=A(u)/A(alpha)-1.
If x_alpha(w),x_beta(w) are their inverse A-branches, then
\[
v=x_\beta(w)+O(w^e),\quad
H(x_\alpha(w))=h_\alpha w^2(1+B_P(\alpha)w+O(w^2)).
\]
Here and below the beta branch is normalized with its own A-value.
Differentiating the A identity and using the endpoint differential
identity gives the Laurent identity
\[
H(v)/H(u)=\epsilon^{17}t^{-48}
\left(1-13\frac{dt/du}{t(A'(u)/A(u))}\right)^3.\tag{1}
\]
The relative correction to the left from O(w^e) begins in degree e-1,
and the right is constant through degree e-2. Since e>=4, the linear
coefficient gives B_P(alpha)=B_P(beta), hence alpha=beta.
The leading derivative and P ratios are now1, giving q(c)=lambda(c)=1.

For two index-three P-branches, choose u=alpha+s^3. If e=4, write
v=beta+b3 s^3+b4 s^4+O(s^5). The relative linear terms of
(v'/u')^3 and (P(v)/P(u))^2 are4b4/b3 and2b4/b3. Thus b4=0.
The A ratio then cannot first change in degree4, a contradiction.
If e>=7, put w=A(u)/A(alpha)-1, of order3. The actual v differs
from x_beta(w) by O(s^e); its relative H correction starts in order
e-3. Also ord(dt/du)>=e-3. Equation(1) therefore makes the ratio
constant modulo s^(e-3). Because e-3>3, the coefficient of w forces
B_P(alpha)=B_P(beta). Again alpha=beta and q(c)=lambda(c)=1.
This order comparison is why indices5 and6 have not been included.

For roots alpha,beta of A, both endpoint maps are unramified. With
w=A(u) and q0=q(c),
\[
v=x_\beta(q_0w)+O(w^{e+1}).
\]
In(1), A'/A has a simple pole, so the correction begins in order e.
The first three G-series coefficients give
g_i(beta)q0^i=g_i(alpha), i=1,2,3. Distinct Z_A values force
alpha=beta, and nonzero g1 then forces q0=1. The leading ratio gives
lambda(c)=1.

At a non-P, non-A critical point of A, exactly one critical endpoint
would make dt a unit. If both are critical, compare the quadratic and
cubic coefficients of A in coordinates for dx/P^(2/3). Only integration
through degree3 is used. Their scale-invariant quotient is a fixed
nonzero constant times C_A. Since t is constant through degree3,
C_A(alpha)=C_A(beta); thus alpha=beta. The nonzero quadratic and
cubic coefficients force the coordinate scale to be1. Hence q(c)=1
and the leading differential identity gives lambda(c)=1. We do not
need to decide whether higher-order ramification can actually occur
at that same point.

The remaining endpoints are ordinary. If their values coincide,
A'!=0 and the A identity give v-u=O(s^e). The leading ratios again
give q(c)=lambda(c)=1. If the values a,b differ, equation(1) and the
A identity are constant through orders2 and3 respectively. Their
first two logarithmic A-derivatives give J(a)=J(b), K(a)=K(b), and
\[
R(b)/R(a)=\epsilon^{29}.
\]
For fixed epsilon the finite certificate permits at most one such
ordered pair. It determines at most one c, since
\[
c^{13}=\epsilon^4/(A(b)/A(a)),\quad
c^{48}=\epsilon^{17}/(H(b)/H(a)),\quad \gcd(13,48)=1.
\]
Every boundary alternative has q(c)=lambda(c)=1, equivalently
epsilon^29=1 and c=epsilon^7. Ordinary off-diagonal scalar values
are never1, so these two alternatives cannot coexist. This proves
the single-value assertion.

## Consequence for every Galois abelian quotient

Suppose a cyclic prime-power quotient of k(S)/k(t) has order
m prime to5. It is Kummer, z^m=f(t). If every valuation of f were
divisible by the underlying prime ell, then the degree-zero divisor
div(f)/ell on P1 would be principal and f would be an ell-th power,
contradicting degree m. There are at least two valuations not divisible
by ell, since their sum is0 modulo ell. Both parameter values have
full inertia m in this quotient, so upstairs indices are multiples of m.

For m=4, m=9, or m a prime at least7, all these multiples lie in
{4} union[e>=7]. The single-value theorem contradicts the two values.
Every finite abelian prime-to-five group of exponent not dividing6
has one of these cyclic quotients. The asserted exponent restriction
follows. No simultaneous Galois closure of arbitrary endpoint maps
has been assumed: Galoisness is a hypothesis on this parameter field.

## Actual value-field generation in arbitrary parameter degree

The curve (A(X)-A(Y))/(X-Y)=0 is a smooth plane cubic. Off-diagonal
singularities would give equal critical values of A. Diagonal
singularities are excluded by A''!=0 at critical points. Its three
points at infinity are simple because the three nonidentity fourth
roots are distinct. A smooth plane cubic is geometrically irreducible.

Its first projection has ramification index2 at (d,c), where c is an
A-critical point and d is one of the other simple roots of
A(X)=A(c). If A(w)=A(u) and w!=u in k(S), the map S->P1_u factors
through this cubic. Surjectivity supplies a point over (d,c); the
ramification index of u there is even, contradicting the endpoint
indices1 or3. Hence no such w exists.

If k(S)/k(t) is Galois and generated by t,u, the stabilizer of A(u)
is consequently trivial; thus k(S)=k(t,A(u)). The same holds for v.
Put F0=k(A(u),A(v)). The ratio identity gives t^13 in F0, so
k(S)=F0(t) has degree1 or13. In degree13, each of u,v satisfies a
quartic polynomial over F0 and hence belongs to F0, contradicting
k(S)=k(u,v). Thus k(S)=F0. This removes the original degree-four
restriction from the value-field result as well.

The new large-index proof received a focused author audit of wild
indices, the two index-three branches, common poles and the cyclic
quotient step. No separate audit agent or new numerical certificate
is claimed for this theoretical extension. It does not close V4,
D4, S4, or the unmarked common-cover question.
