# Task 02: exclude all entry-one high-point coincidences

## Status

Open, including the lower-degree strata created by additional high-point
coincidences. The divisor and high-point reductions below are proved in file
`162`. The displayed bidegree normal form is not derived in any retained
active file; a proof using it closes the theorem only after its extraction
and exhaustiveness have been re-established from the profile data.

Work over \(k=\overline{\mathbb F}_5\).  Let \((C,x,r)\) be a profile-4 pair
as follows.

The curve \(C/k\) is smooth, proper, connected.  The functions \(x,r\in k(C)\)
are separable and generate \(k(C)\).  Their divisors over \(0,1,\infty\) are
\[
\begin{aligned}
 \operatorname{div}(x)     &=31P_0+E_0-31P_\infty-E_\infty,\\
 \operatorname{div}(x-1)   &=31P_1+E_1-31P_\infty-E_\infty,\\
 \operatorname{div}(r)     &=31Q_0+F_0-31Q_\infty-F_\infty,\\
 \operatorname{div}(r-1)   &=31Q_1+F_1-31Q_\infty-F_\infty.
\end{aligned}
\]
The divisors \(E_0,E_1,E_\infty\) are reduced of degree \(4\) and pairwise
disjoint; likewise \(F_0,F_1,F_\infty\).  The common reduced unramified
boundary divisor is
\[
  U=E_0+E_1+E_\infty=F_0+F_1+F_\infty.
\]
The incidence matrix \(M_{ij}=\deg(E_i\cap F_j)\) is
\[
  M=
  \begin{pmatrix}
  0&1&3\\
  1&2&1\\
  3&1&0
  \end{pmatrix}.
\]
Riemann-Hurwitz gives \(g(C)=11\).

For one profile map \(h\), define logarithmic forms
\[
  \Omega_0(h)=\frac{dh}{h-1},\qquad
  \Omega_1(h)=\frac{dh}{h},\qquad
  \Omega_\infty(h)=\frac{dh}{h(h-1)}.
\]
Their divisors are
\[
  \operatorname{div}\Omega_c(h)
  =30P_c(h)-P_a(h)-P_b(h)-E_a(h)-E_b(h),
  \qquad \{a,b,c\}=\{0,1,\infty\}.
\]
At an unramified boundary point with boundary label \(\ell\), the residues
are
\[
\begin{array}{c|ccc}
       & \ell=0 & \ell=1 & \ell=\infty\\ \hline
c=0    & 0&1&-1\\
c=1    & 1&0&-1\\
c=\infty&-1&1&0 .
\end{array}
\]

A high-point coincidence is an equality \(Q_j=P_i\).  Its entry is
\(M_{ij}\).  An entry-one coincidence means \(M_{ij}=1\).  The entry-one
coincidences are, up to the symmetries of the matrix and interchanging
\(x,r\), represented by
\[
  Q_1=P_0.
\]

In this representative define
\[
  z=\frac{\Omega_1(r)}{\Omega_0(x)}
   =\frac{dr/r}{dx/(x-1)}.
\]
In the no-further-highpoint subcase,
\[
  \operatorname{div}(z)=P_1+P_\infty+D+G-Q_0-Q_\infty-B,
\]
where the nonempty incidence atoms are
\[
\begin{array}{lll}
 A=U_{0,1}, & B=U_{0,\infty}, & C=U_{1,0},\\
 D=U_{1,1}, & E=U_{1,\infty}, & F=U_{\infty,0},\\
 G=U_{\infty,1},
\end{array}
\]
with degrees
\[
  \deg A=\deg C=\deg E=\deg G=1,\quad
  \deg D=2,\quad
  \deg B=\deg F=3.
\]
Thus \(\deg z=5\).  Boundary residues force
\[
  z=1\text{ on }C,\qquad z=-1\text{ on }E+F.
\]
Let
\[
  \alpha=z(P_0)=z(Q_1),\qquad u=z(A),\qquad
  c=x(Q_0),\qquad d=x(Q_\infty).
\]
Here \(c,d\in k\setminus\{0,1\}\) are finite; their distinctness is not
assumed. File `162` proves that \(k(C)=k(x,z)\), so \(C\) is the
normalization of an integral bidegree-\((5,35)\) curve \(f(x,z)=0\) in
\(\mathbb P^1_x\times\mathbb P^1_z\).

The differential relation for an actual function \(r\) is
\[
  d\log r=z\,d\log(x-1).
\]
With
\[
  \partial=(x-1)\frac{d}{dx},
\]
the Cartier condition gives
\[
  \partial^4 z=z-z^5.
\]
By Cartier's logarithmic-differential criterion this equation does produce
some rational logarithmic primitive. It does not ensure that a primitive has
the prescribed divisor of \(r\), nor does it impose the prescribed divisor
of \(r-1\). File `175` gives the precise lifting divisor and its class
\[
 R=31Q_0+C+F-31Q_\infty-B-E,
 \qquad
 L_R=\frac{R-\operatorname{div}(r_0)}5,
 \qquad [L_R]\in\operatorname{Pic}^0(C)
\]
for \(\omega=z\,dx/(x-1)=d\log(r_0)\). Bare principality of \(R\) implies
only \(5[L_R]=0\), not \([L_R]=0\).

The retained candidate normal form for the no-further-highpoint stratum is
the following. Here \(\alpha,u\in k^\times\). Put
\[
  s=c+d,\qquad p=cd,\qquad N=(1-c)(1-d),
\]
with \(N\ne0\), and
\[
  \Phi(z)=(z-\alpha)^{31}(z-u),\quad
  \Psi(z)=z^{33}(z-1)(z+1),\quad
  \Gamma(z)=z^{32}(z+1)^3.
\]
Normalize
\[
  [z^{35}]f=x^3(x-c)(x-d),\qquad [x^5]f=z^{32}(z+1)^3.
\]
Then
\[
  f(x,z)=(1-x)K\Phi(z)+xN\Psi(z)+x(x-1)H(x,z),
\]
with \(K\in k^\times\), where
\[
  H=h_0(z)+xh_1(z)+x^2h_2(z)+x^3\Gamma(z),
  \qquad h_i\in k[z],\quad \deg h_i\le35.
\]
The leading \(z^{35}\)-coefficients are
\[
  [z^{35}]h_0=N,\qquad [z^{35}]h_1=N,\qquad
  [z^{35}]h_2=1-s.
\]
At the corner \((x,z)=(0,\infty)\), with \(w=1/z\), the tangent contribution
of the three points of \(B=U_{0,\infty}\) is proportional to \((w-x)^3\).  If
\[
  w^{35}h_0(1/w)=N+aw+bw^2+O(w^3),\qquad
  w^{35}h_1(1/w)=N+ew+O(w^2),
\]
then the corner comparison gives
\[
  a=0,\qquad p=-K,\qquad e=-3K,\qquad b=3K-N.
\]

Prove the following theorem.

**Theorem.**  No profile-4 pair \((C,x,r)\) with the incidence matrix \(M\)
above has an entry-one high-point coincidence.  The proof must include the
representative \(Q_1=P_0\), the no-further-highpoint case above, and all
lower-degree boundary strata obtained from this representative by imposing
additional high-point coincidences compatible with the divisor/residue table.

For this representative the only possible additional coincidences are

\[
Q_0=P_1,\qquad Q_\infty=P_1,\qquad Q_\infty=P_\infty.
\]

Each alone lowers \(\deg z\) from \(5\) to \(4\). The only compatible pair
among them is \(Q_0=P_1,\ Q_\infty=P_\infty\), which lowers the degree to
\(3\). None of these strata is presently excluded.

Do not prove only a generic case, and do not stop after deriving the normal
form. The displayed divisor and residue facts may be used from file `162`.
The normal-form formulas may be used to prove a clearly labelled conditional
subtheorem, but closing this task also requires a self-contained derivation
that every relevant pair enters that model. A formal or local solution of the
Cartier equation is not a profile pair until the two divisor conditions for
\(r\) and \(r-1\) are verified.

A constructed profile pair satisfying all global divisor, integrality,
normalization, and separability conditions would refute the proposed
exclusion and is a valid outcome; a formal jet or plane equation without
those checks is not.
