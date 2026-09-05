# The order-three quotient on the hard exceptional locus

## Status and scope

This note is **proved-text** under the following hypotheses:

- \((C,x,r)\) is the minimal profile-\(4\) pair, so
  \(k(C)=k(x,r)\);
- \(P_0=Q_0\) is its only high-point coincidence; and
- the residual equations left by the four clean first-layer orientations in
  file 189 hold:

\[
 c+d=cd=e+f=ef=1,                                    \tag{191.1}
\]

where

\[
 c=x(Q_1),\quad d=x(Q_\infty),\quad
 e=r(P_1),\quad f=r(P_\infty).
\]

The two order-three quotient functions constructed below are distinct and
generate \(k(C)\).  In particular, the hard exceptional locus does not
produce a common cubic quotient of \(C\), nor does it make the two maps to
\(\mathbf P^1(3,3,31)\) equal.  The note does not exclude (191.1): after
the cubic possibility is removed, the quotient functions give a birational
bidegree-\((105,105)\) model, and the original Cartier equation remains to
be used there or in the degree-six model of file 79.

## The two invariant functions

The polynomial

\[
 q(T)=T^2-T+1
\]

has distinct roots in characteristic \(5\), since its discriminant is
\(-3=2\ne0\).  Equation (191.1) says that \(\{c,d\}\) and \(\{e,f\}\)
are both its root set.  Define

\[
 h_x=\frac{x-c}{x-d},\qquad
 h_r=\frac{r-e}{r-f},qquad
 X=h_x^3,\qquad R=h_r^3.                              \tag{191.2}
\]

Since \(c+d=cd=1\), one has \(c^3=d^3=-1\).  Direct expansion gives

\[
 \boxed{
 X-1=2(c-d)\frac{x(x-1)}{(x-d)^3},\qquad
 R-1=2(e-f)\frac{r(r-1)}{(r-f)^3}.}                   \tag{191.3}
\]

Indeed,

\[
 (T-c)^3-(T-d)^3=2(c-d)T(T-1),
\]

and the second identity is identical.

Let

\[
 \gamma(T)=\frac1{1-T}.
\]

This order-three transformation cycles \(0,1,\infty\), and its fixed
points are precisely the roots of \(q\).  If
\(\omega_x=c/d\), then \(\omega_x\) is a nontrivial cube root of unity and

\[
 h_x\circ\gamma=\omega_x h_x.                         \tag{191.4}
\]

Thus \(X=h_x^3\) is the degree-three quotient of the target by
\(\langle\gamma\rangle\).  The same statement holds for \(R\).

More explicitly, \(X:C\to\mathbf P^1\) has degree \(105\) and the
following fibres and ramification indices:

\[
\begin{array}{c|c}
\text{target value}&\text{points above it}\ \\ \hline
0&x^{-1}(c),\quad e=3\text{ at all }35\text{ points},\\
\infty&x^{-1}(d),\quad e=3\text{ at all }35\text{ points},\\
1&P_0,P_1,P_\infty\text{ with }e=31,
   \text{ and the }12\text{ boundary points with }e=1.
\end{array}                                            \tag{191.5}
\]

The analogous statement holds for \(R\), with the \(P\)-triple replaced
by the \(Q\)-triple.  Hence, after putting stabilizer \(3\) at
\(0,\infty\), stabilizer \(31\) at \(1\), and stabilizer \(31\) at the
common boundary points of the source, (191.5) is exactly a representable
finite etale map

\[
 \mathcal C\longrightarrow\mathbf P^1(3,3,31).        \tag{191.6}
\]

This identifies the construction with the \(C_3\)-intermediate
over-orbifold in file 19.

## Exact cross-values and divisors

Both quotient functions take the value \(1\) at \(P_0=Q_0\) and at all
12 common boundary points.  At the other four high points they have the
values

\[
\begin{array}{c|cc}
 &X&R\\ \hline
P_1&1&0\\
P_\infty&1&\infty\\
Q_1&0&1\\
Q_\infty&\infty&1.
\end{array}                                            \tag{191.7}
\]

In particular, the two maps in (191.6) are not equal.  They do not become
equal after the only nontrivial automorphism of
\(\mathbf P^1(3,3,31)\), which interchanges \(0\) and \(\infty\) and
fixes \(1\): the row at \(P_1\) already rules this out.

Let \(D_{x,a}\) denote the reduced degree-\(35\) fibre of \(x\) over an
ordinary value \(a\), and define \(D_{r,a}\) similarly.  Let \(U\) be the
reduced common boundary divisor of degree \(12\).  Formula (191.3) gives

\[
\begin{aligned}
 \operatorname{div}(X)
   &=3D_{x,c}-3D_{x,d},\\
 \operatorname{div}(X-1)
   &=31(P_0+P_1+P_\infty)+U-3D_{x,d},\\
 \operatorname{div}(R)
   &=3D_{r,e}-3D_{r,f},\\
 \operatorname{div}(R-1)
   &=31(Q_0+Q_1+Q_\infty)+U-3D_{r,f}.
                                                               \tag{191.8}
\end{aligned}
\]

Consequently

\[
 \boxed{
 \operatorname{div}\frac{X-1}{R-1}
 =31(P_1+P_\infty-Q_1-Q_\infty)
  +3(D_{r,f}-D_{x,d}).}                                \tag{191.9}
\]

The common high point and the whole boundary cancel, but the two unknown
ordinary fibres remain.  Thus (191.9) does not produce a low-degree divisor
supported only on the profile points.

## The only possible common quotient is cubic

Put

\[
 L=k(C)=k(x,r)=k(h_x,h_r),\qquad K=k(X,R).
\]

Since \(h_x^3=X\) and \(h_r^3=R\),

\[
 [L:K]\mid9.
\]

On the other hand, \(K\supset k(X)\), and

\[
 [L:k(X)]=\deg(X)=105.
\]

The tower law therefore gives

\[
 \boxed{[L:K]\in\{1,3\}.}                             \tag{191.10}
\]

The cubic alternative is impossible.  Suppose \([L:K]=3\).  Neither
\(h_x\) nor \(h_r\) belongs to \(K\): if, for example, \(h_x\in K\),
then \(x\in K\), so the degree-three map from \(C\) to the smooth curve
with function field \(K\) would factor \(x\).  This would make
\(3\mid\deg(x)=35\), a contradiction.  The same argument applies to
\(r\).

Because \(k\) contains the cube roots of unity, the extension \(L/K\) is
then a cyclic Kummer extension.  A generator \(\delta\) of its deck group
satisfies

\[
 \delta(h_x)=\zeta^a h_x,qquad
 \delta(h_r)=\zeta^b h_r,qquad a,b\in\{1,2\}.          \tag{191.11}
\]

By (191.4), \(\delta\) therefore induces a nontrivial order-three target
transformation on each of \(x\) and \(r\).  It cyclically permutes
\(P_0,P_1,P_\infty\), and it cyclically permutes
\(Q_0,Q_1,Q_\infty\).  Since \(P_0=Q_0\), the single point
\(\delta(P_0)=\delta(Q_0)\) would be both some
\(P_i\), \(i\ne0\), and some \(Q_j\), \(j\ne0\).  That is an additional
high-point coincidence, contrary to the standing hypothesis.  Hence

\[
 \boxed{k(C)=k(X,R).}                                  \tag{191.12}
\]

It follows that the integral image of \((X,R)\) has normalization \(C\)
and bidegree \((105,105)\).  In particular there is no fractional-linear
relation between \(X\) and \(R\), and the order-three quotient does not
reduce the profile problem to a smaller curve.

## Differential identity and the remaining obstruction

The quotient construction is compatible with the original logarithmic
differential relation.  Differentiating (191.2) and using

\[
 \frac{dr}{dx}=z\frac{r-1}{x-1}
\]

gives the exact identity

\[
 \boxed{
 \frac{dR/R}{dX/X}
 =\frac{e-f}{c-d}\,
   z\frac{(x-c)(x-d)}{(r-e)(r-f)}\frac{r-1}{x-1}.}      \tag{191.13}
\]

The right side still contains both cubic Kummer coordinates \(h_x,h_r\),
and (191.12) shows that they do not disappear through a common cubic
quotient.  Equations (191.8)--(191.9) likewise retain the two ordinary
degree-\(35\) fibres.  Therefore the precise unresolved task on (191.1) is
to combine the Cartier equation

\[
 ((x-1)d/dx)^4z-z+z^5=0
\]

with the degree-six equation of file 79 (or equivalently with the
bidegree-\((105,105)\) relation between \(X\) and \(R\)).  The order-three
over-orbifold alone supplies no further descent or equality.  \(\square\)

