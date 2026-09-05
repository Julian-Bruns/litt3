# The true \(z=0\) boundary at repeated \(u^{25}\)

## Status and scope

This note is **proved-text** under the clean repeated-branch hypotheses and
the local coefficient convention of files 182, 185, and 190.  It imposes the
exact profile identity

\[
 f(x,0)=K(x-1)^2,
\tag{192.1}
\]

which removes the ambient coefficient direction denoted \(u0_0\).  It proves
that this removal does not create an obstruction at repeated \(u^{25}\): the
column \(u1_1\) is an exact replacement for \(u0_0\), the repeated response
still has rank three, and its solution has fifteen, rather than sixteen, free
coefficient variables.

The calculation is valid for general boundary values \(c,d\), with
\(cd(1-c)(1-d)\ne0\).  It also identifies precisely what happens on the
exceptional divisor \(c^2+cd+d^2=0\) at the earlier repeated-\(u^5\) layer.
There the complete first-layer response has rank two and leaves one scalar
compatibility equation.  The affine base term of that equation is not
retained in the repository, so this note does not assert that the exceptional
divisor is empty.

Everything remains conditional on an incoming solution having reached the
relevant layer.  In particular, the hard locus \(c+d=cd=1\) must first pass
the repeated-\(u^5\) compatibility equation before the \(u^{25}\) conclusion
can be used.

## Removing the spurious constant-coefficient direction

Write

\[
 f(x,z)=\sum_{j=0}^{35}a_j(x)z^j.
\]

The ambient parameterization in file 190 chooses a boundary-compatible base
and writes the remaining part of \(a_0\) as

\[
 x(x-1)u0_0.
\]

If the base is chosen to have \(a_0=K(x-1)^2\), the exact identity (192.1)
is simply

\[
 \boxed{u0_0=0.}
\tag{192.2}
\]

The parameter \(K\) is older boundary data and is not removed by (192.2).
The simple \(u^{25}\) equation still has the unit pivot \(u2_0\), by files
101 and 185.  Thus, after imposing (192.2) and solving the simple equation,
there are eighteen new variables on which the repeated equation can depend.

## The complete Schur-corrected response matrix

Work in the clean etale cubic algebra

\[
 A=R[s]/(h(s))
\]

over the older-coordinate ring, with basis \(1,s,s^2\).  On the repeated
branch and the simple branch respectively, write

\[
 w_+=uQ(u),\qquad \Phi_w(u,w_+)=u^5\ell T(u),\qquad p=\ell^{-1},
\]

\[
 w_-=uq_-(u),\qquad q_-(0)=-1,
 \qquad G_q(u,q_-)=2aT_-(u),
\]

where \(Q(0)=T(0)=T_-(0)=1\) and \(a=-cd\) is a unit.  Put

\[
 R_{n,r}=[u^r]Q^nT^{-1},\qquad
 S_{n,r}=[u^r]q_-^nT_-^{-1},\qquad
 W=R_{31,2}.
\tag{192.3}
\]

Coefficients with a negative second index are zero.  For a band variable
\(u j_A\), set \(B=35-j\) and \(d=j-A\).  Formula 182.4 at \(m=5\) gives
the raw normalized repeated response

\[
 \frac{\operatorname{Raw}(u j_A)}p
   =R_{33-j,d}.
\tag{192.4}
\]

Indeed, the lower coefficient in formula 182.4 has degree
\(30-A-B=d-5<0\), while the upper coefficient has degree
\(35-A-B=d\).

The simple pivot \(u2_0\) has \((A,B)=(0,33)\).  Formula 185.4 gives its
simple response and repeated response as

\[
 c_{\rm piv}=-(2a)^{-1}=2a^{-1},\qquad
 \frac{\operatorname{Raw}(u2_0)}p=W.
\tag{192.5}
\]

For \(u j_A\), the lower term in the simple response again vanishes, and
the upper coefficient has degree

\[
 33-A-B=d-2.
\]

Consequently the coefficient of \(u j_A\) in the solved value of the simple
pivot is

\[
 -\frac{(2a)^{-1}S_{33-j,d-2}}{-(2a)^{-1}}
 =S_{33-j,d-2}.
\]

Substitution in the repeated residual therefore gives the uniform exact
formula

\[
 \boxed{
 \frac{C_{j,A}}p
 =R_{33-j,d}+S_{33-j,d-2}W,
 \qquad d=j-A.}
\tag{192.6}
\]

The order estimates in file 190 show that no product of two new variables
can enter the truncation, so (192.6) is an affine response formula, not only
a tangent-space formula.

After removing \(u0_0\) and the simple pivot \(u2_0\), formula (192.6)
gives all eighteen columns as follows.

| variable | \(d\) | corrected normalized column \(C_{j,A}/p\) |
| --- | ---: | --- |
| \(u1_0\) | 1 | \(R_{32,1}=U_L+s\) |
| \(u3_0\) | 3 | \(R_{30,3}+S_{30,1}W\) |
| \(u4_0\) | 4 | \(R_{29,4}+S_{29,2}W\) |
| \(u1_1\) | 0 | \(1\) |
| \(u2_1\) | 1 | \(R_{31,1}=U_L\) |
| \(u3_1\) | 2 | \(R_{30,2}+W\) |
| \(u4_1\) | 3 | \(R_{29,3}+S_{29,1}W\) |
| \(u5_1\) | 4 | \(R_{28,4}+S_{28,2}W\) |
| \(u2_2\) | 0 | \(1\) |
| \(u3_2\) | 1 | \(R_{30,1}=U_L+4s\) |
| \(u4_2\) | 2 | \(R_{29,2}+4W\) |
| \(u5_2\) | 3 | \(R_{28,3}+S_{28,1}W\) |
| \(u6_2\) | 4 | \(R_{27,4}+S_{27,2}W\) |
| \(u3_3\) | 0 | \(1\) |
| \(u4_3\) | 1 | \(R_{29,1}=U_L+3s\) |
| \(u5_3\) | 2 | \(R_{28,2}+W=H\) |
| \(u6_3\) | 3 | \(R_{27,3}+S_{27,1}W\) |
| \(u7_3\) | 4 | \(R_{26,4}+S_{26,2}W\) |

Here

\[
 U_L=[u]Q^{11}T^{-1},\qquad
 H=[u^2](Q^{28}+Q^{31})T^{-1}.
\tag{192.7}
\]

The degree-one simplifications in the table use
\(Q^5\equiv1\pmod {u^5}\).  The constants in the three \(d=2\) rows are
\(S_{30,0}=1,\ S_{29,0}=4,\ S_{28,0}=1\), because \(q_-(0)=-1\).

## Rank three after imposing the true boundary

Let \(\lambda:A\to R\) extract the \(s^2\)-coefficient.  Scaling the whole
local equation by the tangent unit \(a\) changes neither \(Q\) nor \(T\),
so the scalar calculations in files 182 and 184 apply for general \(c,d\):

\[
 \lambda(U_L)=0,\qquad \lambda(H)=4.
\tag{192.8}
\]

Write

\[
 U_L=\alpha+\delta s
\tag{192.9}
\]

and let \(\nu=N_{A/R}(p)\), a unit on the clean locus.  The table contains
the constant column \(u1_1/p=1\), despite the removal of \(u0_0\).  Direct
coordinates in the basis \(1,s,s^2\) give

\[
 \boxed{
 [C_{5,3},C_{1,1},C_{2,1}]=4\nu\delta,}
\tag{192.10}
\]

and

\[
 \boxed{
 [C_{5,3},C_{1,0},C_{1,1}]=\nu(\delta+1).}
\tag{192.11}
\]

These are exactly the replacements for the minors in file 104.  To compare
them with its original chart functions, put

\[
 h=\lambda(U_I)
 \quad\text{and}\quad
 \rho_3=[I,L,p],\qquad \rho_4=[I,M,p].
\]

Since \(U_I\) has \(s^2\)-coefficient \(h\), direct coordinates also give

\[
 \rho_3=-h\nu\delta,\qquad
 \rho_4=-h\nu(\delta+1).
\tag{192.11a}
\]

Thus, whenever \(h\ne0\), (192.10) is a unit on the old chart
\(D(\rho_3)\), and (192.11) is a unit on
\(V(\rho_3)\cap D(\rho_4)\).  When \(h=0\), both old chart functions vanish,
but the endpoint minors (192.10)--(192.11) still give the independent clean
cover \(D(\delta)\cup D(\delta+1)\).

The two right sides cannot vanish simultaneously.  Thus the repeated
\(u^{25}\) response has rank exactly three at every clean point, independent
of \(c,d\).  On \(D(\delta)\), one may solve for

\[
 u5_3,\quad u1_1,\quad u2_1,
\]

while on the priority fallback \(V(\delta)\), equation (192.11) solves for

\[
 u5_3,\quad u1_0,\quad u1_1.
\]

The fifteen free variables on the first chart may be ordered as

\[
\begin{gathered}
u7_3,u6_2,u6_3,u5_1,u5_2,u4_0,u4_1,u4_2,u4_3,\\
u3_0,u3_1,u3_2,u3_3,u2_2,u1_0,
\end{gathered}
\tag{192.12}
\]

and those on the fallback chart as

\[
\begin{gathered}
u7_3,u6_2,u6_3,u5_1,u5_2,u4_0,u4_1,u4_2,u4_3,\\
u3_0,u3_1,u3_2,u3_3,u2_2,u2_1.
\end{gathered}
\tag{192.13}
\]

Therefore the exact boundary introduces no repeated-\(u^{25}\) residual
equation.  It reduces the outgoing affine dimension from sixteen to fifteen.
The sixteen-variable terminal matrices in file 148 cannot be applied
unchanged: they were recorded after using \(u0_0\) as a pivot and retaining
\(u1_1\) as a free variable.

## The genuinely exceptional rank occurs at repeated \(u^5\)

For completeness, the first-layer rank can also be determined exactly on
the divisor left open by file 188.  Retain the normalized effective columns

\[
 U_I=I/p,\quad U_J=J/p,\quad U_L=L/p,\quad
 U_M=M/p,\quad 1.
\]

File 188 proves

\[
 \lambda(U_I)=
 h:=2\frac{c^2+cd+d^2}{c^2d^2},
\tag{192.14}
\]

and files 182 and 184 give

\[
 \lambda(U_L)=0,\qquad U_M-U_L=s.
\tag{192.15}
\]

The remaining effective column also has zero \(s^2\)-coefficient:

\[
 \boxed{\lambda(U_J)=0.}
\tag{192.16}
\]

To prove (192.16), use the notation

\[
 G(u,q)=G_0(q)+uG_1(q)+O(u^2),\qquad
 G_0=a(q-1)^3(q+1)
\]

from file 188.  Clean separation gives

\[
 G_1=(q-1)^2A(q),\qquad \deg A\le3.
\tag{192.17}
\]

The response and simple Schur formulas give

\[
 U_J=[u^3]Q^{10}T^{-1}
 +S_{10,1}[u^2]Q^{11}T^{-1}.
\tag{192.18}
\]

Lagrange interpolation over the three repeated branches, together with
\(\lambda([u^2]Q^{11}T^{-1})=1\), combines the two terms in (192.18) into
the four-finite-branch residue

\[
 \lambda(U_J)
 =2a[u]\sum_{q\ {\rm finite\ branch}}
       \frac{q^{10}}{G_q(u,q)}.
\tag{192.19}
\]

Extracting the \(u\)-coefficient before taking residues, as in files 186
and 188, turns (192.19) into \(2a\) times

\[
 [q^{-1}]\frac{-q^{10}G_1}{G_0^2}
 = [q^{-1}]\frac{-q^{10}A(q)}
 {a^2(q-1)^4(q+1)^2}.
\tag{192.20}
\]

Put \(r=q^{-1}\).  In characteristic five,

\[
 \frac1{(1-r)^4(1+r)^2}
 =\frac{(1-r)(1+r)^3}{1-r^{10}}.
\tag{192.21}
\]

The right side has zero coefficients in degrees \(5,6,7,8,9\).  A monomial
\(q^j\), \(0\le j\le3\), of \(A\) would use the coefficient of
\(r^{5+j}\) in (192.21) to contribute to \(q^{-1}\).  All these coefficients
vanish, proving (192.16).

It follows that the complete repeated-\(u^5\) response has rank

\[
 \boxed{
 \operatorname{rank}M_5=
 \begin{cases}
 3,&c^2+cd+d^2\ne0,\\
 2,&c^2+cd+d^2=0.
 \end{cases}}
\tag{192.22}
\]

Indeed, when \(h\ne0\), the columns \(1,s,U_I\) span \(A\).  When \(h=0\),
all five effective columns lie in \(\operatorname{span}(1,s)\), while
\(1\) and \(s=U_M-U_L\) show that the rank is exactly two.

Let \(b_5\in A\) be the affine repeated-\(u^5\) base residual after the
simple solve.  On the exceptional divisor, solvability is therefore
equivalent to the single scalar equation

\[
 \boxed{\lambda(p^{-1}b_5)=0.}
\tag{192.23}
\]

The hard locus \(c+d=cd=1\) lies on this divisor, since then
\(c^2+cd+d^2=(c+d)^2-cd=0\).  Thus it carries the earlier necessary
condition (192.23).  The retained response formulas determine its cokernel
but not the affine base \(b_5\), so they do not decide whether (192.23) is a
contradiction.  Conditional on passing it and reaching \(u^{25}\), equations
(192.10)--(192.13) show that no further obstruction is created there by the
true boundary.
