# Proof: three conjugates give a degree bound after inseparability is removed

27 September2026. Work over the algebraic closure of F5 on the fixed
genus-nine curve X:y^3=P(x). The four roots of A are simple and disjoint
from P=0. Let gamma(x,y)=(x,zeta y), where zeta has order three. Its
quotient is the x-line, and the marked set Z consists of four complete
unramified gamma-orbits.

## Minimal witnesses are primitive and not fifth powers

A function regular outside O has unique polynomial coefficients
g=U+Vy+Wy^2. If U=0 and g is nonzero, it vanishes at the finite cubic
branch points y=0, which are outside Z. Thus a supported function
omitting a character and not in k(x) must be
\[
g=U(x)+V(x)y^j,\qquad j\in\{1,2\},\quad U,V\ne0.
\]
Choose one of minimal pole degree among all such functions, allowing
either value of j. Every common polynomial root of U,V must be a root
of A, since it gives a whole zero fibre. Dividing a common linear factor
preserves regularity outside O, the allowed support, the missing-character
property and nonmembership in k(x), while lowering the pole degree by3.
Minimality therefore gives gcd(U,V)=1.

At an occupied marked fibre U(alpha),V(alpha) are both nonzero. The three
values of y^j on it are distinct, so exactly one sheet is occupied.
Consequently the zero divisors of g,gamma^*g,gamma^(2*)g are disjoint.

The minimal witness cannot be a fifth power in k(X). A fifth root, if
it exists, has the same allowed zero support and its pole order is divided
by5. It remains outside k(x). Moreover it still omits a character:
\[
(U_0+U_1y+U_2y^2)^5
 =U_0^5+P^3U_2^5y+P U_1^5y^2.
\]
Vanishing of either nonconstant character on the right forces vanishing
of the corresponding character on the left. The root is regular outside
O by its valuations, so its coefficient representation is polynomial.
This contradicts minimality.

## The ratio of conjugates is separating

Suppose g/gamma^*g were a fifth power. At an occupied fibre the three
conjugate zero divisors are disjoint; comparison of valuations forces
each zero multiplicity of g to be divisible by5. Its pole degree is
therefore divisible by5 as well. The logarithmic differential dlog(g)
is regular on X, since every divisor coefficient of g is zero in k.
The fifth-power ratio also gives gamma^*dlog(g)=dlog(g).

There is no invariant regular differential. This follows from the tame
quotient X/gamma=P1, or directly from the basis
\[
\theta,x\theta,\ldots,x^5\theta,\quad
y\theta,xy\theta,x^2y\theta,\qquad\theta=dx/y^2.
\]
Its two gamma-characters are zeta and zeta^2. Hence dlog(g)=0 and
dg=0. The kernel of d:k(X)->Omega_(k(X)/k) is k(X)^5; for example x
is a separating p-basis coordinate. Thus g was a fifth power, contrary
to the preceding paragraph. The ratio is therefore separating.

## Riemann--Hurwitz at three complete fibres

The three conjugates span just the two present character spaces. They
have a constant linear relation with all three coefficients nonzero:
\[
g+\zeta^j\gamma^*g+\zeta^{2j}\gamma^{2*}g=0.
\]
For j=1 this is immediate by summing the two relevant powers of zeta;
the same holds for j=2. Set phi=-g/(zeta^j gamma^*g). Then
1-phi=-zeta^j gamma^(2*)g/gamma^*g. The ratio is separating and has
degree delta, the pole order of g, since its zero and pole divisors
are disjoint conjugates of that zero divisor. The common poles at O
cancel to units. The three complete fibres over0,1,infinity consist
precisely of the three conjugate zero divisors. None contains O.

Write their multiplicities in the s occupied x-fibres as m_1,...,m_s,
so sum m_i=delta. The different contribution over these three values
is at least3 sum(m_i-1)=3delta-3s. Riemann--Hurwitz for the separable
map phi on the genus-nine curve gives total different16+2delta.
All other contributions are nonnegative. Therefore
delta<=16+3s<=28.

If5 divides m_i, each of its three points is wildly ramified. Its
different exponent is at least m_i, rather than merely m_i-1. Retaining
these extra contributions gives delta<=16+3s-3w. This strengthens the
bound but is not needed for the finite reduction.

## The second character is impossible for a reduced witness

There is a useful further contribution which removes half the finite
test without any interpolation. Suppose j=2. At each of the ten finite
cubic branch points R_b, U(b) is nonzero: otherwise g would have a zero
outside Z. The parameter y has order one there, while x-b has order
three. Consequently the ratio V y^2/U has order
2+3 ord_b(V). The fractional linear transformation defining phi has
nonzero derivative at that value. Its ramification index at R_b is
therefore 2+3 ord_b(V), so its different contribution is at least one.

These ten points are outside the three previously counted fibres:
at them all three conjugates have the same nonzero value U(b), and
phi=-zeta^(-2), which is none of0,1,infinity. Adding their contributions
gives
\[
16+2\delta\ge3\delta-3s+10,\qquad \delta\le6+3s\le18.
\]
But a nonzero V y^2 has pole order at least20, and its pole cannot
cancel against the polynomial U, whose order is divisible by three.
This is impossible. Thus a minimal witness necessarily has j=1.

The pole orders left for the finite test are exactly
10,12,13,15,16,18,19,21,22,24,25,27,28. They arise from the
two characters of U+Vy and are at most28. The six last cases use
only the columns x^i and x^i y; there is no need to test a y^2 column.
The argument excludes j=2 for the reduced, non-fifth-power witness;
it does not by itself exclude a fifth power of a putative j=1 witness.

No map constructed here is substituted for either leg of a common cover.
It is an auxiliary map on the fixed endpoint X, used solely to control
its supported rational functions. The arithmetic exclusion of witnesses
through28 is a separate, explicitly checkable requirement.
