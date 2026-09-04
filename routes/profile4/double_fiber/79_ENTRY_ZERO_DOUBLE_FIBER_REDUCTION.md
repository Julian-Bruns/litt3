# Entry-zero norm-normalization audit

## Status

**proved-text from the stated boundary data** for the corrected norm
constants and tangent-cone compatibility below. The formerly claimed
specialization

\[
x(Q_1)=x(Q_\infty)=2
\]

is **not established by these calculations**: the old argument compared
each norm with the same divisor normalized to constant \(1\), thereby
assuming the conclusions it claimed to prove. The reduction from the
entry-zero branch to the double-fiber specialization is open. This audit
does not assert that arbitrary triples \((\alpha,c,d)\) occur; any genuine
restriction must come from additional profile or differential equations.

## Setup

Work over \(k=\overline{\mathbb F}_5\). Let \(C\) be a profile-\(4\)
two-map pair in the entry-zero case \(Q_0=P_0\), with no other high-point
coincidence, and put

\[
z=\frac{dr/(r-1)}{dx/(x-1)}.
\]

The profile divisor calculation gives

\[
\operatorname{div}(z)
=P_1+P_\infty+C+F-Q_1-Q_\infty-A-B,
\tag{79.1}
\]

where \(A,B,C,F\) on the right denote the profile's atom divisors (the
symbol \(C\) there is not the curve itself). Thus \(\deg z=6\). Since
\(\deg x=35\) and \(\gcd(35,6)=1\), the intermediate degree
\([k(C):k(x,z)]\) divides both \(35\) and \(6\); hence
\(k(C)=k(x,z)\).

Let

\[
\alpha=z(P_0),\qquad c=x(Q_1),\qquad d=x(Q_\infty),
\]

and set

\[
\sigma=c+d,\qquad \pi=cd,\qquad
\mathcal N=(1-c)(1-d)=1-\sigma+\pi.
\]

The no-other-high-point condition gives
\(\alpha\ne0\) and \(c,d\notin\{0,1\}\), so
\(\pi\mathcal N\ne0\). Put \(\eta=\alpha^{-1}\).

The integral image of \((x,z)\) has bidegree \((6,35)\), and its
normalization is \(C\). Normalize its irreducible affine equation
\(f(x,z)=0\) by making the coefficient of \(x^6z^{35}\) equal to \(1\).
Then

\[
[x^6]f=z^{34}(z+1),\qquad
[z^{35}]f=x^4(x-c)(x-d),
\tag{79.2}
\]

and boundary fibers

\[
\begin{aligned}
f(x,0)&=K(x-1)^2,\\
f(0,z)&=K(1-\eta z)^{31},\\
f(1,z)&=\mathcal N z^{32}(z-1)^2(z+1),
\end{aligned}
\tag{79.3}
\]

for \(K\in k^\times\).

Indeed, the pole divisor of \(x\) is
\(31P_\infty+F+G\). At these branches, \(z\) has values \(0,0,-1\),
with total multiplicities \(31,3,1\), respectively. Thus the coefficient
of \(x^6\) is proportional to \(z^{34}(z+1)\). Similarly, the pole divisor
of \(z\) is \(Q_1+Q_\infty+A+B\), whose \(x\)-values are \(c,d,0,0\)
with total multiplicities \(1,1,1,3\). The shared corner normalization
therefore gives both identities in (79.2).

The zero fiber of \(z\) consists of \(P_1,P_\infty,C,F\); its finite
\(x\)-values give \(f(x,0)=K(x-1)^2\). The fiber \(x=0\) consists of
\(31P_0+A+B\), with \(z(P_0)=\alpha\) and the other four branches at
\(z=\infty\). Since both restrictions take the value \(K=f(0,0)\) at
the affine corner, this gives the first two identities in (79.3). Finally,
the fiber \(x=1\) consists of \(31P_1+C+D+E\), on which \(z\) has values
\(0,0,1,-1\) with total multiplicities \(31,1,2,1\). Its leading
coefficient is

\[
[z^{35}]f(1,z)=(1-c)(1-d)=\mathcal N,
\]

which proves the last identity in (79.3).

### Tangent cone from the boundary residues

Put \(w=1/z\). At the point \(A=U_{0,1}\), take \(t=x\) as local
parameter. Since both boundary maps are unramified there, write
\(r-1=bt+O(t^2)\) with \(b\ne0\). Then

\[
\frac{dr}{r-1}=\frac{dt}{t}+O(1)dt,
\qquad
\frac{dx}{x-1}=-dt+O(t)dt,
\]

so \(z=-t^{-1}+O(1)\) and \(w=-x+O(x^2)\).

At each of the three points of \(B=U_{0,\infty}\), again take \(t=x\)
and write \(r^{-1}=bt+O(t^2)\). Now

\[
\frac{dr}{r-1}=-\frac{dt}{t}+O(1)dt,
\]

so \(z=t^{-1}+O(1)\) and \(w=x+O(x^2)\). These are all the branches
over \((x,w)=(0,0)\), by (79.1). Hence the degree-four tangent cone of

\[
\bar f(x,w)=w^{35}f(x,1/w)
\]

is a nonzero multiple of

\[
(w+x)(w-x)^3.
\tag{79.4}
\]

## Corrected norm proposition

Under (79.2)--(79.4),

\[
K=\pi\alpha^{31}.
\tag{79.5}
\]

The exact norms compatible with this normalization are

\[
\begin{aligned}
\operatorname{Nm}_{k(C)/k(x)}(z)
 &=-\pi\alpha^{31}
   \frac{(x-1)^2}{x^4(x-c)(x-d)},\\
\operatorname{Nm}_{k(C)/k(z)}(x)
 &=-\pi
   \frac{(z-\alpha)^{31}}{z^{34}(z+1)},\\
\operatorname{Nm}_{k(C)/k(z)}(x-1)
 &=\mathcal N\frac{(z-1)^2}{z^2}.
\end{aligned}
\tag{79.6}
\]

In particular, comparing (79.3) with (79.6) gives identities. It does not
prove \(\alpha^{31}=1\), \(\mathcal N=1\), or \(\pi=-1\).

### Proof

The coefficient of \(w^4\) in the degree-four part of \(\bar f\) is

\[
\kappa=K(-\eta)^{31}=-K\alpha^{-31},
\]

whereas its coefficient of \(x^4\) is \(\pi\). The corresponding
coefficients in \((w+x)(w-x)^3\) are \(1\) and \(-1\). Hence

\[
\pi=-\kappa=K\alpha^{-31},
\]

which is (79.5).

Regard \(f\) as a degree-\(35\) polynomial in \(z\). Since that degree is
odd, the product of its roots is

\[
\operatorname{Nm}_{k(C)/k(x)}(z)
=-\frac{f(x,0)}{[z^{35}]f}
=-K\frac{(x-1)^2}{x^4(x-c)(x-d)}.
\]

Substitution of (79.5) gives the first formula in (79.6). Regard \(f\)
next as a degree-\(6\) polynomial in \(x\). Since that degree is even,

\[
\begin{aligned}
\operatorname{Nm}_{k(C)/k(z)}(x)
 &=\frac{f(0,z)}{[x^6]f}
 =K(-\eta)^{31}
   \frac{(z-\alpha)^{31}}{z^{34}(z+1)},\\
\operatorname{Nm}_{k(C)/k(z)}(x-1)
 &=\frac{f(1,z)}{[x^6]f}
 =\mathcal N\frac{(z-1)^2}{z^2}.
\end{aligned}
\]

Now \(K(-\eta)^{31}=-\pi\) by (79.5), proving the remaining formulas.

## Local check on the constants

The constants in (79.6) can also be seen directly at \(z=\infty\). The
six branches there are \(Q_1,Q_\infty,A,B\). On the four branches in
\(A+B\), the tangent data give one expansion \(x=-w+O(w^2)\) and three
expansions \(x=w+O(w^2)\), where \(w=z^{-1}\). The other two \(x\)-values
tend to \(c,d\). Therefore

\[
\operatorname{Nm}_{k(C)/k(z)}(x)
=-\pi z^{-4}+O(z^{-5}),
\]

while

\[
\operatorname{Nm}_{k(C)/k(z)}(x-1)
\longrightarrow(c-1)(d-1)(-1)^4=\mathcal N.
\]

Thus replacing either constant by \(1\) would already assume
\(\pi=-1\) or \(\mathcal N=1\), respectively.

## Tangent leading form retained for the local calculation

Put \(u=x\) and \(w=uq\). Since the multiplier of the tangent cone in
(79.4) is

\[
\kappa=K(-\eta)^{31}=-\pi\in k^\times,
\]

the normalized equation has

\[
\bar f(u,uq)=u^4G(u,q),\qquad
G(0,q)=-\pi(q-1)^3(q+1).
\tag{79.7}
\]

This order-four statement remains valid and is enough for a generalized
simple-branch response lemma. The scalar is \(1\) only after separately
proving \(\pi=-1\); the norm comparison above does not do so.

## Open specialization

To enter the retained double-fiber tower, one still needs an independent
argument proving

\[
\mathcal N=1,\qquad \pi=-1,
\]

or directly proving \(c=d=2\). Indeed, those two displayed equations would
give \(\sigma=-1\), after which \(c,d\) would be the roots of

\[
T^2+T-1=(T-2)^2
\]

in characteristic \(5\). No such independent argument is retained here.

Even the specialization \(c=d=2\) would give only
\(\pi=-1\), \(\mathcal N=1\), and

\[
K=-\alpha^{31}.
\]

It would not imply \(\alpha^{31}=1\) or \(K=-1\). Any downstream normal
form that uses either further equality needs an additional proof, or a
justified coordinate normalization compatible with the definition of
\(z\) and its differential equation.
