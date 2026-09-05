# The last repeated-\(u^5\) scalar by a four-branch residue

## Status and scope

This note is **proved-text** under the displayed local double-fiber normal
form.  It proves the residue identity (185.19), and hence

\[
 [s^2](I/p)=4.
\]

Together with files 182, 184, and 185, this supplies the last scalar premise
in the repeated-\(u^5\) atlas of file 83.  The argument is independent of the
missing symbolic programs and, in fact, does not require the individual
old-normal-form parameters \(c_2,d_1,d_2,e_1\).

This remains a local theorem.  It does not prove the upstream specialization
\(c=d=2\), nor any of the later global coverage assertions.

## Local hypotheses forced by the normalized base equation

Work over a field \(k\) of characteristic \(5\).  At \(x=0\), put \(u=x\)
and write the reciprocal local equation as

\[
 \Phi(u,uq)=u^4G(u,q),\qquad
 G=G_0+uG_1+u^2G_2+O(u^3),                 \tag{186.1}
\]

where each \(G_j\in k[q]\).  On the proposed normalized double-fiber
specialization, the tangent cone and the \(w=0\) boundary are

\[
 G_0=(q-1)^3(q+1),\qquad
 \Phi(u,0)=u^4(u-2)^2.                     \tag{186.2}
\]

Consequently

\[
 G_1(0)=G_2(0)=1.                          \tag{186.3}
\]

The three repeated branches have

\[
 q_i(u)=1+s_i u+O(u^2),\qquad i=1,2,3.     \tag{186.4}
\]

On the clean second-blowup open, the \(s_i\) are distinct.  The fourth finite
branch is the Hensel lift \(q_-(u)=-1+O(u)\).

Two elementary consequences of (186.1)--(186.4) are all that the proof will
use.  First, expand \(G(u,1+uy)\) through order two.  Its coefficient of
\(u\) is the constant \(G_1(1)\), and its coefficient of \(u^2\) is the
affine polynomial

\[
 yG_1'(1)+G_2(1).
\]

Both coefficients vanish at the three distinct lifts \(y=s_i+O(u)\).
The constant and the affine polynomial must therefore vanish identically.
Equivalently, \(G(u,1+uy)\) is divisible by \(u^3\) through these orders, and

\[
 (q-1)^2\mid G_1,\qquad (q-1)\mid G_2.     \tag{186.5}
\]

Indeed, \(G_0(1+uy)\) starts in degree three; the coefficients of \(u\) and
\(u^2\) then say \(G_1(1)=G_1'(1)=G_2(1)=0\).  Second, the coefficient
\(G_j\) comes from the homogeneous part of total degree \(4+j\) of \(\Phi\),
so

\[
 \deg G_1\leq5,\qquad \deg G_2\leq6.       \tag{186.6}
\]

## A coefficientwise cluster-residue lemma

Let \(q_1,q_2,q_3,q_-\) denote the four roots of \(G\) which remain finite as
\(u\to0\), after passing to a splitting extension if necessary, and set

\[
 S(u)=\sum_{q\in\{q_1,q_2,q_3,q_-\}}
       \frac{q^9}{G_q(u,q)}.               \tag{186.7}
\]

Here and below, a residue at infinity is computed **after first expanding in
\(u\)**.  This order matters because the full polynomial can also have roots
which escape to infinity as \(u\to0\).

### Lemma

Under (186.1)--(186.6),

\[
 \boxed{[u^2]S(u)=2.}                       \tag{186.8}
\]

### Proof

The summands in (186.7) are the residues of the one-form
\(q^9G(u,q)^{-1}\,dq\) at the four finite branches.  To justify taking
coefficients across the three coalescing roots, apply Weierstrass preparation
in the completion along \((u,G_0)\).  There \(G\) is a unit times a monic
quartic whose roots are exactly these four branches.  Its relative residue is
the sum in (186.7), and it commutes with coefficient extraction in \(u\).

Equivalently, expand first in the \(u\)-adic field \(k(q)((u))\), then sum
the residues at the roots of \(G_0\).  Since

\[
 \frac1G=\frac1{G_0}-u\frac{G_1}{G_0^2}
 +u^2\left(\frac{G_1^2}{G_0^3}-\frac{G_2}{G_0^2}\right)+O(u^3),
\]

the residue theorem on the \(q\)-line gives

\[
 [u^2]S
 =[q^{-1}]\,q^9
 \left(\frac{G_1^2}{G_0^3}-\frac{G_2}{G_0^2}\right).            \tag{186.9}
\]

This is also a direct algebraic proof of the coefficientwise-residue step:
at each order in \(u\), the rational coefficient has poles only at the roots
of \(G_0\); the sum of their residues is the coefficient of \(q^{-1}\) at
infinity.

By (186.5), write

\[
 G_1=(q-1)^2A(q),\qquad G_2=(q-1)B(q).      \tag{186.10}
\]

The degree bounds give

\[
 \deg A\leq3,qquad \deg B\leq5.
\]

Using \(G_0=(q-1)^3(q+1)\), the rational function in (186.9) becomes

\[
 \frac{q^9C(q)}{(q-1)^5(q+1)^3},\qquad
 C=A^2-(q+1)B,                              \tag{186.11}
\]

and \(\deg C\leq6\).

Put \(r=q^{-1}\).  In characteristic \(5\),

\[
\begin{aligned}
 \frac1{(1-r)^5(1+r)^3}
 &=\frac{(1+r)^2}{(1-r)^5(1+r)^5}\\
 &=\frac{(1+r)^2}{1-r^{10}}
 =1+2r+r^2+O(r^{10}).                       \tag{186.12}
\end{aligned}
\]

If \(C=\sum_{j=0}^6c_jq^j\), the contribution of \(c_jq^j\) in
(186.11) is

\[
 c_jr^{-1-j}\frac1{(1-r)^5(1+r)^3}.
\]

For \(j=0\), its \(r^1=q^{-1}\) coefficient is \(c_0\).  For
\(1\leq j\leq6\), that coefficient would use one of the coefficients of
\(r^3,\ldots,r^8\) in (186.12), all of which vanish.  Therefore

\[
 [q^{-1}]\frac{q^9C(q)}{(q-1)^5(q+1)^3}=C(0).                 \tag{186.13}
\]

More generally, (186.10) gives

\[
 C(0)=G_1(0)^2+G_2(0).                     \tag{186.14}
\]

Indeed, \(A(0)=G_1(0)\) and \(-B(0)=G_2(0)\).  In the normalized case,
(186.3) therefore gives

\[
 A(0)=G_1(0)=1,qquad -B(0)=G_2(0)=1.
\]

Thus \(B(0)=4\), and

\[
 C(0)=A(0)^2-B(0)=1-4=2.
\]

Equations (186.9), (186.13), and (186.14) prove (186.8). \(\square\)

## Closure of the repeated-\(u^5\) scalar

Use the notation of files 182, 184, and 185.  On the three repeated branches,
Lagrange interpolation in the clean cubic algebra gives

\[
 [s^2]U_A
 =2[u^2]\sum_{i=1}^3\frac{q_i^9}{G_q(u,q_i)},
 \qquad U_A=[u^4]Q^9T^{-1}.                 \tag{186.15}
\]

The simple-branch Schur solve gives

\[
 L_i=2[u^2]\frac{q_-^9}{G_q(u,q_-)}.        \tag{186.16}
\]

For completeness, the factor \(2\) in (186.16) is
\(-1/2\) in characteristic \(5\): the raw \(i00\) response is
\([u^2]q_-^9/G_q\), the pivot response is \(2\), and the pivot multiple is
the negative quotient of those responses.

File 184 proves \([s^2]U_C=1\), while the corrected column is

\[
 U_I=U_A+L_iU_C.
\]

Combining (186.15)--(186.16) with the lemma therefore gives

\[
\begin{aligned}
 [s^2]U_I
 &=2[u^2]\sum_{q\in\{q_1,q_2,q_3,q_-\}}
       \frac{q^9}{G_q(u,q)}\\
 &=2\cdot2=4.
\end{aligned}                                                    \tag{186.17}
\]

Since the common column is \(p=\ell^{-1}\), equation (186.17) is exactly

\[
 \boxed{[s^2](I/p)=4.}
\]

This proves the previously missing premise of file 83.  In particular,
\(I\) and \(p\) are linearly independent on the clean repeated branch, and
the two-minor argument in that file is now unconditional under the local
double-fiber hypotheses stated above.

## Independent finite-algebra check

As a sign check only, the coefficient calculation in (186.9) was also
expanded with generic coefficients satisfying (186.3), (186.5), and
(186.6).  It gives

\[
 [q^{-1}]q^9G_1^2/G_0^3=1,
 \qquad
 [q^{-1}]q^9G_2/G_0^2=4,
\]

so their difference is \(2\), in agreement with the proof.  No computational
check is used in the argument.
