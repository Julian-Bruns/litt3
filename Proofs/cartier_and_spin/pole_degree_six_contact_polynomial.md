# A common-pole polynomial for the entire comparison-degree-six branch

24 September 2026. Keep the two actual maps and the minimal denominator
of [the genus-bound proof](new_line_degree_six_genus_bound.md).
Normalize z=Lambda*s as in the degree-six boundary proof. All finite
common-pole values are in mu29, and epsilon=delta*Lambda^3 is nonzero.
Write
\[
x_1=(a+bw)/D,\qquad z^3x_2=(c+dw)/D,\qquad w^2=B(z).
\]
Here r=deg D, t is the number of its distinct roots, u=r-t is the
number of roots of multiplicity two, g=g(S), and
\[
0\ne b,d\in k[z],\qquad \deg b,\deg d\le m:=r+2-g.
\]
The earlier proof gives r<=58 and n-6>=t+2u>=3u.

## Divisibility at every common-pole value

Let xi be a root of D. At a common pole Q over xi the actual tensor
comparison gives
\[
x_2/x_1\longrightarrow\varepsilon\xi^4.
\]
This is the same comparison of the weights4 and17 at O used in
the degree-seven proof; it is independent of the covering degree.
Thus the leading coefficient of z^3x_2-epsilon*z^7x_1 cancels.
We claim that
\[
d(\xi)=\varepsilon\xi^7b(\xi). \tag{1}
\]

If the quadratic map is unramified over xi, all common poles there
have order one and D has a simple root. At a sheet with a common
pole, leading cancellation says
c(xi)-epsilon*xi^7*a(xi)+w(Q)[d(xi)-epsilon*xi^7*b(xi)]=0.
At the other sheet either the same cancellation holds at its common
pole, or both original numerators vanish because both functions are
regular. Therefore the same equation holds for both opposite,
nonzero values of w, proving (1).

If the quadratic map is ramified, take a local parameter t_Q with
z-xi a unit times t_Q^2 and w a unit times t_Q. When D has a simple
root, the odd part of x_1 has possible pole order one. The even
part cannot have a pole of order two, since the actual pole order
is one. Leading cancellation therefore compares precisely b(xi)
and d(xi), proving (1). When D has a double root, the common pole
order is three. The even part cannot have order four; the order-three
term is again the odd part, and the same comparison proves (1).
These are all cases in the minimal-denominator classification.

Consequently, with D_red the product of the distinct linear factors,
\[
D_{\rm red}(z)\mid d(z)-\varepsilon z^7b(z). \tag{2}
\]
No common divisor is asserted to descend through an X-map. This is
a polynomial identity on the actual quadratic quotient, proved by
checking every sheet where a pole or its cancellation occurs.

## The nonzero-polynomial branch

If the right-hand side of (2) is not identically zero, its degree is
at most m+7. Hence
\[
t\le m+7=r+9-g,\qquad
g\le u+9\le 9+\left\lfloor\frac{n-6}{3}\right\rfloor\le38. \tag{3}
\]
In particular, when all minimal common-pole denominators are simple,
this branch has genus at most nine, regardless of the covering degree.

## The identically-zero polynomial is impossible

Suppose d=epsilon*z^7*b. The quadratic branch differences then give
an actual function R(z) in k(z) such that
\[
x_2=\varepsilon z^4x_1+R(z).
\]
At both points of S above z=0, x_1 is regular and x_2 has a pole
of order three. Hence R has a pole of exactly order three at zero,
and the leading coefficients of z^3*x_2 at the two points are equal.

The certified boundary identity says that the twenty-ninth power
of that leading coefficient is a fixed nonzero scalar times
H(x_1(0)), where H=A'^3*P^2 modulo A. The values of H at the four
roots of A are pairwise distinct. Consequently x_1 takes the SAME
root alpha of A at both points over zero.

This is incompatible with the full quartic identity. Under the
normalization used here it is
\[
z^{13}A(\varepsilon z^4x_1+R(z))-\varepsilon^4A(x_1)=0. \tag{4}
\]
Regard its left side as a polynomial G(z,X) in X. Every coefficient
lies in k[[z]]: R has pole order three, so even its fourth power,
after multiplication by z^13, vanishes at zero. All coefficients
of the first summand vanish there. Thus
\[
G(0,X)=-\varepsilon^4 A(X).
\]
The roots of A are simple. There is therefore a UNIQUE power-series
root of G through X=alpha. The map z:S->P1 is unramified at zero,
so the two points give embeddings of k(S) into k((z)), and their
x_1 images are precisely such roots. They must agree. Since
k(S)=k(z,x_1), the two embeddings would be equal, contradicting the
distinctness of the two points. This excludes d=epsilon*z^7*b.

This argument does not assume that agreement of finitely many jets
recognizes a field. It uses the full quartic equation and a simple
formal root, which determines every coefficient. Nor does it require
any upper bound on the covering degree beyond the pole-degree-six
reconstruction that supplies the actual quadratic quotient.

## Clearing the entire simple-denominator contribution

If D is squarefree, the same sheet comparison proves
\[
D\mid c-\varepsilon z^7a.
\]
At an unramified fiber, add the two leading-cancellation equations
from the proof of (1); a regular sheet also satisfies the equation
because both original numerators vanish there. At a ramified fiber
with a simple root of D, the possible even pole has order two,
whereas both actual poles have order one. Thus a and c both vanish
at that root, which proves the required even-part divisibility.
These arguments include every allowed simple-denominator fiber.

Define
\[
p_0=(c-\varepsilon z^7a)/D,\qquad
p_1=(d-\varepsilon z^7b)/D.
\]
They are polynomials and
\[
z^3x_2-\varepsilon z^7x_1=p_0+p_1w,\qquad
\deg p_0\le10,\quad\deg p_1\le9-g.
\]
The preceding exact-ratio exclusion gives p_1 nonzero. This is a
uniform residual pole bound, not an assertion that either original
map descends through the quadratic map.

There are at most two common-pole points over each simple denominator
root, each of pole order one. The exact pole count therefore gives
n-6<=2deg D<=58, hence n<=64 in this subcase.

## Scope

The polynomial in (2) is always nonzero. Therefore (3) holds throughout
this entire branch:
\[
g\le\min\left(r,u+9,9+\left\lfloor\frac{n-6}{3}\right\rfloor\right)
\le38.
\]
In particular all-simple minimal denominators force g<=9. This
uniform improvement is independent of the degree-seven finite
certificate. The higher-cover models with these smaller genera remain
open; no actual common cover or shared-object extraction is supplied.
