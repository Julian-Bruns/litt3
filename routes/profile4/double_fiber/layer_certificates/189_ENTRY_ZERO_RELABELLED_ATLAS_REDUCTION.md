# Relabelling the exceptional repeated-\(u^5\) scalar

## Status and scope

This note is **proved-text** for the clean repeated-tangent locus in the
entry-zero case of file 79.  It applies the scalar theorem of file 188 in a
second target coordinate and then, conditionally on cleanliness in that
orientation too, after interchanging the two profile maps.  The involution
used on the first map preserves the original clean second blow-up; cleanliness
after interchanging the maps is a separate hypothesis.

For the original orientation put

\[
 c=x(Q_1),\qquad d=x(Q_\infty),\qquad
 A(c,d)=c^2+cd+d^2.
\]

The original and relabelled first-layer atlases cover every point unless

\[
 \boxed{c+d=cd=1.}                                      \tag{189.1}
\]

If the repeated tangent is also clean after interchanging \(x\) and \(r\),
so that the same construction is available there, and

\[
 e=r(P_1),\qquad f=r(P_\infty),
\]

then all four available atlases can fail only on

\[
 \boxed{c+d=cd=e+f=ef=1.}                              \tag{189.2}
\]

Equivalently, in each clean orientation the two cross-values are exactly the
two roots of \(T^2-T+1\).  This note does not exclude (189.2), and it does not
address either non-clean second-blowup locus or the later formal layers.

## The coordinate involution

Let

\[
 \tau(t)=\frac{t}{t-1}.
\]

It fixes \(0\) and interchanges \(1\) and \(\infty\).  Replace only the
first profile map by

\[
 x'=\tau(x),\qquad r'=r.
\]

The common high point remains \(Q_0=P_0\), up to the evident relabelling of
the \(x\)-fibres.  If

\[
 \Omega_0(h)=\frac{dh}{h-1},\qquad
 z=\frac{\Omega_0(r)}{\Omega_0(x)},
\]

then a direct calculation gives

\[
 \Omega_0(\tau(x))=-\Omega_0(x),\qquad z'=-z.           \tag{189.3}
\]

For

\[
 D=(x-1)\frac d{dx},\qquad
 D'=(x'-1)\frac d{dx'},
\]

one likewise has \(D'=-D\).  Hence

\[
 D^4z-z+z^5=0
 \quad\Longleftrightarrow\quad
 (D')^4z'-z'+(z')^5=0.                                 \tag{189.4}
\]

Thus the logarithmic differential equation and its first-layer response
calculation are preserved, including all signs.

Put \(u=x\), \(w=z^{-1}\), and similarly \(u'=x'\),
\(w'=(z')^{-1}\).  Near \(x=0\),

\[
 u'=-u+O(u^2),\qquad w'=-w.
\]

The one branch with \(w=-u+O(u^2)\) therefore has
\(w'=-u'+O((u')^2)\), while the three branches with
\(w=u+O(u^2)\) have \(w'=u'+O((u')^2)\).  The normalized tangent form is
again the one-simple, three-repeated form used in files 184 and 188.
More precisely, a repeated branch
\(w=u+s u^2+O(u^3)\) becomes
\(w'=u'+(1-s)(u')^2+O((u')^3)\).  Thus distinct second-order slopes remain
distinct.

The two finite pole values in the new \(x'\)-coordinate are

\[
 c'=\tau(c)=\frac c{c-1},\qquad
 d'=\tau(d)=\frac d{d-1}.                              \tag{189.5}
\]

The normalization needed for file 188 is also preserved, with the expected
new parameter.  Let \(f(x,z)\) be the normalized equation of file 79 and
put

\[
 f'(X,Z)=-\mathcal N^{-1}(X-1)^6 f(\tau(X),-Z),
 \qquad \mathcal N=(1-c)(1-d).
\]

A direct substitution gives

\[
 [Z^{35}]f'=X^4(X-c')(X-d').
\]

If
\(\Phi(x,w)=w^{35}f(x,w^{-1})\) and
\(\Phi'(X,W)=W^{35}f'(X,W^{-1})\), then

\[
 \Phi'(X,W)=\mathcal N^{-1}(X-1)^6\Phi(\tau(X),-W).
\]

The transformed tangent scalar is consequently

\[
 a'=\frac{-cd}{\mathcal N}=-c'd',
\]

exactly the scalar required by the general calculation in file 188.

The coefficient directions used by the repeated-\(u^5\) calculation are
also unchanged.  Indeed, after the boundary values at \(x'=0,1\) and the
degree-six leading coefficient are fixed, the free part of every relevant
coefficient polynomial is

\[
 x'(x'-1)U(x'),\qquad \deg U\le3,
\]

exactly as in the original bidegree-\((6,35)\) normal form.  Consequently
file 188 applies in the primed coordinate, with exceptional scalar
\(A(c',d')\).

## Intersection of the two exceptional divisors

Write

\[
 \sigma=c+d,\qquad \pi=cd,\qquad
 \mathcal N=(1-c)(1-d)=1-\sigma+\pi.
\]

The entry-zero assumptions give \(\pi\mathcal N\ne0\).  Clearing the
denominator in (189.5) gives

\[
 A(c',d')
 =\frac{\sigma^2+3\pi^2-3\pi\sigma-\pi}
        {\mathcal N^2}
 =\frac{A(c,d)+3\pi(\pi-\sigma)}{\mathcal N^2}.         \tag{189.6}
\]

Suppose both first-layer scalars vanish.  Then \(A(c,d)=0\), so
\(\sigma^2=\pi\), and (189.6) gives \(\pi=\sigma\).  Since
\(\pi\ne0\), the equations \(\sigma^2=\sigma\) and \(\pi=\sigma\)
force

\[
 \sigma=\pi=1.
\]

Conversely these two equalities make both scalar numerators zero.  This
proves (189.1).

On this residual locus, \(c,d\) are the roots of

\[
 T^2-T+1.
\]

Its discriminant is \(-3=2\ne0\) in characteristic \(5\), so the two
values are distinct.  Moreover \(\tau\) interchanges them, since
\(t^2=t-1\) implies

\[
 \tau(t)=\frac{t}{t-1}=t^{-1}.
\]

Thus (189.1) is a genuine residual orbit, rather than a collision of the two
points \(Q_1,Q_\infty\).

## Interchanging the two maps

The profile matrix is symmetric.  Interchanging \(x\) and \(r\) therefore
gives another entry-zero presentation of the same pair.  Its logarithmic
quotient is \(z^{-1}\), and its two finite pole values are

\[
 e=r(P_1),\qquad f=r(P_\infty).
\]

The no-other-high-point assumption, together with disjointness of the
reduced boundary from all high points, implies
\(e,f\notin\{0,1\}\).  If the repeated second blow-up in this presentation
is clean, the preceding calculation applies verbatim.
It supplies the two further scalar numerators

\[
 A(e,f),\qquad A(\tau(e),\tau(f)).
\]

They vanish simultaneously exactly when \(e+f=ef=1\).  Combining this with
(189.1) proves (189.2).  \(\square\)
