# The repeated-\(u^5\) scalar before the double-fiber specialization

## Status and scope

This note is **proved-text** on the clean repeated-tangent locus of the
entry-zero normal form in file 79.  It removes the unsupported specialization
\(c=d=2\) from the first repeated-layer rank calculation.

Write

\[
 \sigma=c+d,\qquad \pi=cd,
\]

where \(c,d\notin\{0,1\}\) are the two finite boundary values in file 79.
For the corrected repeated-\(u^5\) column \(U_I=I/p\), the result is

\[
 \boxed{
 [s^2]U_I
   =2\frac{\sigma^2-\pi}{\pi^2}
   =2\frac{c^2+cd+d^2}{c^2d^2}. }
\tag{188.1}
\]

Consequently, the two determinant charts of file 83 cover the clean locus
whenever

\[
 c^2+cd+d^2\ne0.                         \tag{188.2}
\]

Thus the only parameter locus not covered by this argument is
\(c/d\in\mu_3\setminus\{1\}\).  This note neither excludes that exceptional
locus nor proves the remaining global profile-\(4\) assertions.

## Local equation and its boundary coefficients

Let \(k\) be a field of characteristic \(5\).  Use the reciprocal equation
\(\Phi(u,w)=\bar f(u,w)\) of file 79 and put \(w=uq\):

\[
 \Phi(u,uq)=u^4G(u,q),\qquad
 G=G_0+uG_1+u^2G_2+O(u^3).                \tag{188.3}
\]

The tangent cone in file 79 says

\[
 G_0=a(q-1)^3(q+1),\qquad a=-\pi\ne0.    \tag{188.4}
\]

The coefficient of \(z^{35}\) in the original equation gives the exact
boundary identity

\[
 \Phi(u,0)=u^4(u-c)(u-d).
\]

Therefore

\[
 G_1(0)=-\sigma,\qquad G_2(0)=1.          \tag{188.5}
\]

Suppose the triple tangent at \(q=1\) separates after the second blow-up.
Thus its three branches have

\[
 q_i(u)=1+s_i u+O(u^2),\qquad i=1,2,3,
\]

with the \(s_i\) distinct.  The fourth finite branch is the Hensel lift
\(q_-(u)=-1+O(u)\).

Exactly as in file 186, substitution of \(q=1+uy\) in (188.3) shows

\[
 (q-1)^2\mid G_1,\qquad (q-1)\mid G_2.   \tag{188.6}
\]

Indeed, the coefficients of \(u\) and \(u^2\) vanish at all three distinct
values \(s_i\); they are respectively constant and affine in \(s_i\).
Homogeneous-degree bookkeeping in \(\Phi\) also gives

\[
 \deg G_1\le5,\qquad \deg G_2\le6.       \tag{188.7}
\]

## The four-branch residue with its tangent scalar retained

Set

\[
 S(u)=\sum_{q\in\{q_1,q_2,q_3,q_-\}}
       \frac{q^9}{G_q(u,q)}.              \tag{188.8}
\]

### Lemma 1

Under (188.3)--(188.7),

\[
 \boxed{
 [u^2]S(u)=\frac{\sigma^2-\pi}{-\pi^3}. }
\tag{188.9}
\]

### Proof

Expand first in the \(u\)-adic field \(k(q)((u))\).  The relative residue
of the Weierstrass quartic supported on the four finite branches commutes
with extraction of the \(u^2\)-coefficient.  The residue theorem on the
\(q\)-line then gives

\[
 [u^2]S
 =[q^{-1}]q^9
 \left(\frac{G_1^2}{G_0^3}-\frac{G_2}{G_0^2}\right).          \tag{188.10}
\]

By (188.6), write

\[
 G_1=(q-1)^2A(q),\qquad G_2=(q-1)B(q).
\]

The bounds (188.7) give \(\deg A\le3\) and \(\deg B\le5\).  Using
\(G_0=a(q-1)^3(q+1)\), the rational function in (188.10) is

\[
 \frac{q^9C(q)}{a^3(q-1)^5(q+1)^3},
 \qquad C=A^2-a(q+1)B,\qquad \deg C\le6. \tag{188.11}
\]

At infinity, with \(r=q^{-1}\), characteristic \(5\) gives

\[
 \frac1{(1-r)^5(1+r)^3}
 =\frac{(1+r)^2}{1-r^{10}}
 =1+2r+r^2+O(r^{10}).                     \tag{188.12}
\]

For a monomial \(c_jq^j\) of \(C\), the coefficient of \(q^{-1}=r\)
uses the coefficient of \(r^{j+2}\) in (188.12).  It is therefore \(c_0\)
for \(j=0\) and zero for \(1\le j\le6\).  Hence (188.10) equals
\(C(0)/a^3\).  Since

\[
 A(0)=G_1(0),\qquad B(0)=-G_2(0),
\]

equations (188.5) and (188.11) yield

\[
 \frac{C(0)}{a^3}
 =\frac{G_1(0)^2+aG_2(0)}{a^3}
 =\frac{\sigma^2-\pi}{-\pi^3},
\]

because \(a=-\pi\).  This proves the lemma. \(\square\)

## Interpolation and the corrected column

After the second blow-up write

\[
 \Phi(u,u+u^2y)=u^7P(u,y),
 \qquad P_0(y)=2a\prod_{i=1}^3(y-s_i).
\tag{188.13}
\]

Let

\[
 A_3=k[s]/(P_0(s)),\qquad
 \lambda:A_3\longrightarrow k
\]

denote extraction of the coefficient of \(s^2\) in the basis
\(1,s,s^2\).  Put \(\ell=P_0'(s)\) and
\(T=P_y(u,y_s(u))/\ell\), as in files 81 and 184.

Lagrange interpolation, together with
\(G_q(u,1+uy)=u^2P_y(u,y)\), gives

\[
 \lambda(U_A)
 =2a[u^2]\sum_{i=1}^3\frac{q_i^9}{G_q(u,q_i)},
 \qquad U_A=[u^4]Q^9T^{-1}.               \tag{188.14}
\]

The scalar identity of file 184 is unchanged if the whole local equation is
divided by \(a\): the branches \(Q\) and the quotient
\(T=P_y/P_0'(s)\) do not change.  It therefore gives

\[
 \lambda(U_C)=1,
 \qquad U_C=[u^2]Q^{11}T^{-1}.            \tag{188.15}
\]

At the simple branch, the raw \(i00\) response is

\[
 [u^2]\frac{q_-^9}{G_q(u,q_-)},
\]

while the simple pivot response is \(2a^{-1}\), by file 185.  The negative
of their quotient is the Schur multiplier

\[
 L_i=2a[u^2]\frac{q_-^9}{G_q(u,q_-)}      \tag{188.16}
\]

in characteristic \(5\).  The corrected column is
\(U_I=U_A+L_iU_C\).  Combining (188.14)--(188.16) gives

\[
 \lambda(U_I)=2a[u^2]S(u).                \tag{188.17}
\]

Lemma 1 and \(a=-\pi\) now imply

\[
 \lambda(U_I)
 =2(-\pi)\frac{\sigma^2-\pi}{-\pi^3}
 =2\frac{\sigma^2-\pi}{\pi^2},
\]

which proves (188.1).

## The resulting two-chart atlas

Retain the response columns \(I,L,M,p\in A_3\) of files 81--83.  File 182
proves

\[
 U_M-U_L=s,\qquad U_L=L/p,\qquad U_M=M/p,
\tag{188.18}
\]

and \(p\) is a unit.  If (188.2) holds, (188.1) says that the
\(s^2\)-coefficient of \(U_I\) is nonzero.  Hence \(1,U_I\) are linearly
independent and

\[
 s\notin\operatorname{span}_k(1,U_I).
\]

If both determinants

\[
 [I,L,p],\qquad [I,M,p]
\]

vanished, then both \(U_L\) and \(U_M\) would lie in
\(\operatorname{span}_k(1,U_I)\).  Their difference would put \(s\) in the
same span, contradicting the preceding display.  Thus the two determinant
opens cover the clean locus satisfying (188.2).

Finally,

\[
 \sigma^2-\pi=c^2+cd+d^2.
\]

Since \(c,d\ne0\), its vanishing is equivalent to
\((c/d)^2+(c/d)+1=0\), i.e. to \(c/d\) being a nontrivial cube root of
unity.  This identifies the exact exceptional divisor left by the argument.
