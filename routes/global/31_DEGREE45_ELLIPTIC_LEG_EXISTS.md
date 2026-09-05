# A degree-45 elliptic generalized-profile leg exists

## Status and scope

**Status: proved by an explicit exact certificate.**

This note shows that the endpoint \(m=14\), unlike the rational endpoint
\(m=15\), cannot be eliminated by proving that a single leg does not exist.
It does **not** construct a self-correspondence: no second map with the same
set of forty-two simple boundary points is produced here.

## The example

Let

\[
 k_0=\mathbf F_{25}=\mathbf F_5(z),\qquad z^2+4z+2=0,
\]

and let

\[
 E/k_0:\quad v^2=u^3+1.
\]

Write \(O\) for the point at infinity and put

\[
 P_0=(0,1),\qquad P_1=(z,z+4),\qquad P_\infty=O.
\]

Define

\[
\begin{aligned}
 f_0={}&v+2u^3+4,\\
 f_1={}&((4z+3)u+2z+2)v+(2z+4)u^3+zu^2\\
      &\hspace{34mm} +(2z+1)u+4z+2,
\end{aligned}
\]

and

\[
\begin{aligned}
 a={}&((2z+2)u^6+(z+4)u^3+3z+2)v\\
    &+2u^7+(2z+1)u^5+2u^4+4u+2z+3,\\
 b={}&(4zu^6+(4z+4)u^3+(z+1)u+2z+2)v\\
    &+(z+2)u^7+(3z+4)u^5+(z+2)u^4+(2z+4)u+4z,\\
 c={}&(4zu^3+(z+3)u+2z)v\\
    &+(z+3)u^7+2u^5+(z+3)u^4+(2z+1)u+z+3.
\end{aligned}
\]

Set

\[
                  A=f_0^5a,\qquad B=f_1^5b,\qquad C=c.
\]

Direct reduction using \(v^2=u^3+1\) and \(z^2+4z+2=0\) gives

\[
                         A+B+C=0.                       \tag{31.1}
\]

The desired function is

\[
                         h=-\frac{A}{C}.                \tag{31.2}
\]

The accompanying Sage certificate performs every calculation in the exact
function field \(k_0(E)\); it uses no numerical approximation.

## Verification

**Theorem 31.1.** The function \(h\) defines a separable morphism

\[
                         h:E\longrightarrow\mathbf P^1
\]

of degree \(45\), unramified outside \(0,1,\infty\), such that each of those
three fibers has the form

\[
                         31P_i+D_i,                     \tag{31.3}
\]

where \(D_i\) is geometrically reduced of degree \(14\).

### Proof

First, exact divisor calculation gives

\[
 \operatorname{div}(f_0)=6P_0-6O,\qquad
 \operatorname{div}(f_1)=6P_1-6O.                      \tag{31.4}
\]

Regard \(A,B,C\) as sections of
\(\mathcal O_E(45O)\).  Exact factorization of their divisors gives

\[
 \operatorname{div}_{\mathcal O(45O)}(A)=31P_0+D_0,
 \quad
 \operatorname{div}_{\mathcal O(45O)}(B)=31P_1+D_1,
 \quad
 \operatorname{div}_{\mathcal O(45O)}(C)=31O+D_\infty. \tag{31.5}
\]

All coefficients of every \(D_i\) are one and each \(D_i\) has degree
\(14\).  More specifically, their closed-point degree patterns over
\(k_0\) are

\[
 (1,1,3,9),\qquad (1,1,3,9),\qquad (1,1,3,9),          \tag{31.6}
\]

respectively.  The certificate prints these residual patterns directly and
obtains degree \(14\) in all three cases.  Since finite fields are perfect,
coefficient one at each closed point implies geometric reducedness.  The
supports of the three section divisors are pairwise disjoint, so (31.2) has
no cancellation.  Equation (31.1) gives

\[
                         h-1=\frac{B}{C};
\]

hence (31.5) proves the three asserted fiber descriptions and
\(\deg h=45\).

The exact derivation in \(k_0(E)\) is nonzero on \(h\), so \(h\) is
separable.  One may also verify all ramification at once.  If \(dh\) is
viewed as a rational differential, the certificate obtains

\[
 \operatorname{div}(dh)
  =30P_0+30P_1-32O-2D_\infty.                           \tag{31.7}
\]

Thus the only zeros of \(dh\) are the two finite index-\(31\) points; the
third index-\(31\) point is the pole \(O\).  Alternatively, the three tame
indices already contribute \(3(31-1)=90\) to the different, while
Riemann--Hurwitz for a separable degree-\(45\) map from a genus-one curve
gives total different degree \(90\).  There can therefore be no further
ramification.  This proves the theorem. \(\square\)

Finally, \(E\) is supersingular: it is the \(j=0\) curve in characteristic
\(5\), and the certificate also checks this directly.  Base change from
\(k_0\) to \(\overline{\mathbf F}_5\) gives the generalized-profile leg
needed in the original setting.

## Consequence for the degree search

The characteristic-five collapse in degree \(46\) is special to the
rational-source endpoint.  In degree \(45\), Frobenius does create many
spurious kernel relations, but it does not force every Riemann--Roch kernel
relation to be inseparable.  Any exclusion of a degree-\(45\) non-visible
self-correspondence must use the common source boundary of the two legs (or
another genuinely two-leg condition), not one-leg existence.
