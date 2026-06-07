## Prompt 1: Extract the profile-4 curve problem from a non-visible correspondence

Work over \(k=\overline{\mathbb F}_5\).  Let
\[
  S=\mathbb P^1_k(31,31,31)
\]
be the stacky projective line with stabilizer order \(31\) at
\(0,1,\infty\).  The symmetric group \(S_3\) acts on \(S\) by permuting the
three stacky points.  Write
\[
  S_0=S/S_3\simeq \mathbb P^1_k(2,3,62)
\]
and let \(\pi_0:S\to S_0\) be the quotient map.

A finite etale self-correspondence of \(S\) means a connected smooth proper
Deligne-Mumford curve \(T\) with two representable finite etale maps
\[
  u,v:T\to S.
\]
Call it visible if \(\pi_0\circ u\simeq \pi_0\circ v\), equivalently if
\((u,v)\) factors through \(S\times_{S_0}S\), equivalently if
\[
  v=\sigma\circ u
\]
for one fixed \(\sigma\in S_3\) on connected \(T\).

For a smooth proper connected curve \(C/k\), a separable function
\(h:C\to\mathbb P^1\) has profile \((31;4)\) if it has degree \(35\), all
ramification lies above \(0,1,\infty\), and for each
\(a\in\{0,1,\infty\}\),
\[
  h^{-1}(a)=31P_a(h)+E_a(h),
\]
where \(P_a(h)\) is one point and \(E_a(h)\) is reduced of degree \(4\).  For
one fixed \(h\), the three divisors \(E_0(h),E_1(h),E_\infty(h)\) are pairwise
disjoint.  Such a map has source genus \(11\), by Riemann-Hurwitz.

The target curve-level object is a triple \((C,x,r)\) where:

1. \(C/k\) is smooth, proper, connected of genus \(11\);
2. \(x,r\in k(C)\) are separable profile-\((31;4)\) functions;
3. \(k(C)=k(x,r)\);
4. the unramified boundary divisors agree as a reduced divisor
   \[
      U=E_0+E_1+E_\infty=F_0+F_1+F_\infty,
   \]
   where \(E_i=E_i(x)\) and \(F_j=E_j(r)\);
5. after possibly swapping \(u,v\), and composing one side by an \(S_3\)
   symmetry, the incidence matrix
   \[
      M_{ij}=\deg(E_i\cap F_j),\qquad i,j\in\{0,1,\infty\},
   \]
   is
   \[
      M=
      \begin{pmatrix}
      0&1&3\\
      1&2&1\\
      3&1&0
      \end{pmatrix}.
   \]

Prove the following theorem completely.

**Theorem.**  If there exists a non-visible connected finite etale
self-correspondence \(u,v:T\to S\), then there exists a curve-level triple
\((C,x,r)\) satisfying conditions 1--5 above.

Facts you may use without reproving:

- The cyclic curve \(Y:y^{31}=x(x-1)\) is a finite etale atlas of \(S\).
- \(S_0\simeq \mathbb P^1_k(2,3,62)\).
- Visible correspondences are exactly the \(S_3\)-graph correspondences.
- Standard Riemann-Hurwitz and tame stack-cover bookkeeping for
  \(\mathbb P^1(a,b,c)\).

Do not use internet search. The proof should be concrete: pass from the correspondence
to explicit function fields, inertia/orbit data, divisor profiles, and the
incidence matrix.

---

## Prompt 2: Exclude all entry-one high-point coincidences

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
The field \(k(C)=k(x,z)\), so \(C\) is the normalization of an integral
bidegree-\((5,35)\) curve \(f(x,z)=0\) in
\(\mathbb P^1_x\times\mathbb P^1_z\).

The differential relation is
\[
  d\log r=z\,d\log(x-1).
\]
With
\[
  \partial=(x-1)\frac{d}{dx},
\]
the Cartier/logarithmic exactness condition gives
\[
  \partial^4 z=z-z^5.
\]

One normal form is the following.  Put
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
where
\[
  H=h_0(z)+xh_1(z)+x^2h_2(z)+x^3\Gamma(z).
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

Do not prove only a generic case.  Do not stop after deriving the normal form.
You may use the displayed divisor, residue, and normal-form facts as already
proved; the task is to turn them into a contradiction or to construct a valid
counterexample.

---

## Prompt 3: Exclude the no-highpoint branch through the residual family

Work over \(k=\overline{\mathbb F}_5\).  Use the same profile-4 pair
\((C,x,r)\), divisors, incidence matrix, logarithmic forms, and atom notation
as in Prompt 2.  Assume now that all six high points
\[
  P_0,P_1,P_\infty,Q_0,Q_1,Q_\infty
\]
are pairwise distinct.

The goal is to prove that this no-highpoint case is impossible.

A proposed residual model is as follows.  Let \(X,R\) be coordinates on
\(\mathbb P^1\times\mathbb P^1\).  Define
\[
\begin{aligned}
P(X,R)=&\ R^4X^4-R^4X^3-R^3X^4
       +2R^3X-2R^2X\\
      &\quad +2RX^3-2RX^2+R+X-1,
\end{aligned}
\]
and
\[
  L=4XR+4X+4R+2.
\]
The line \(L=0\) is the graph
\[
  R=\frac{4X+2}{X+1},
\]
which sends \(X=0,1,\infty\) to \(R=2,3,4\), respectively.

For a polynomial \(A(X,R)\) with
\[
  \deg_X A\le 32,\qquad \deg_R A\le 32,
\]
consider
\[
  H_A=L^{31}P-X(X-1)R(R-1)A(X,R).
\]
The factor \(X(X-1)R(R-1)\) preserves the six affine boundary restrictions.
The corner multiplicity-three requirements at \((X,R)=(0,\infty)\) and
\((\infty,0)\) force
\[
  [R^{32}]A(0,R)=2,\qquad [X^{32}]A(X,0)=2.
\]

For a valid profile-4 residual curve, all ramification of both projections is
already consumed by the three order-\(31\) boundary branches.  Therefore
there must be no interior ramification for either projection.  Away from the
boundary, write
\[
  D=X(X-1)R(R-1),\qquad F=LP.
\]
The interior ramification equations can be written as
\[
  N_R=F\,\partial_R(DA)-DA\,\partial_RF=0,
\]
and
\[
  N_X=F\,\partial_X(DA)-DA\,\partial_XF=0.
\]

Facts you may assume as already checked:

- Constant \(A\) gives no valid solution.
- Several sparse low-parameter subfamilies give no valid solution.
- The symmetric ordinary-corner candidates give no valid solution.

These partial checks are not enough; do not rely on them as if they were a
classification.

Prove the following theorem.

**Theorem.**  There is no polynomial \(A(X,R)\) over
\(\overline{\mathbb F}_5\) satisfying the degree bounds, the two corner
coefficient constraints, integrality/genera compatible with a profile-4
curve, and the no-interior-ramification conditions for both projections.
Consequently no no-highpoint profile-4 pair exists.

If you believe the residual model does not capture every no-highpoint pair,
then either prove the missing residual-extraction step or give an explicit
no-highpoint profile-4 counterexample.  A broad strategy or computational
wish list is not a valid endpoint.

---

## Prompt 4: Prove the basin-127 saturation containment

Work over \(k=\overline{\mathbb F}_5\), but the concrete algebra below is over
\(\mathbb F_5\).  This prompt is a local algebra problem arising in the
corrected entry-zero branch of a profile-4 pair.  You do not need the global
geometry except for the statements below.

Let
\[
  R=\mathbb F_5[r_0,r_1,r_2,r_3,r_4,r_5]
\]
with lexicographic order.  The displayed expected quotient is the ideal
\[
\begin{aligned}
J=\langle&
r_2-2,\ r_5-2,\\
&r_0+2r_1-2r_3+2r_4^2+r_4+1,\\
&r_1^2-r_3-2r_4-1,\\
&r_1r_3+2r_1-2r_3-r_4^2+2r_4,\\
&r_1r_4-r_1+2r_4^2-2,\\
&r_3^2+r_3-2,\\
&r_3r_4-r_3-r_4+1,\\
&r_4^3-2r_4^2-r_4+2
\rangle.
\end{aligned}
\]
It is already proved that \(J\) is radical of length \(5\), with points
\[
\begin{gathered}
(0,0,2,1,4,2),\quad
(0,1,2,3,1,2),\quad
(3,4,2,1,2,2),\\
(4,2,2,1,1,2),\quad
(4,4,2,3,1,2).
\end{gathered}
\]
It is also already proved that adding the base residual
\[
  B_{127}=r_3+r_4^2
\]
cuts \(J\) to the single point
\[
  (3,4,2,1,2,2),
\]
which is a local point already killed by a later \(e50\) obstruction.

The open local algebra theorem is the following.

**Theorem.**  Let \(I_{127}\subset R\) be the basin-127 low-data ideal obtained
from the simple-\(u30\) corrected double-fiber local equations, and let
\[
  s_{127}
\]
be the product of the etale discriminant and the relevant rho3 chart pivot.
Prove
\[
  V(I_{127})\cap D(s_{127})\subseteq V(J),
\]
equivalently prove that every generator of \(J\) vanishes on the localized
low-data scheme.  The stronger statement
\[
  I_{127}:s_{127}^{\infty}=J
\]
is also acceptable.

You must make the theorem fully explicit: define \(I_{127}\) and \(s_{127}\)
from the local equations, not by referring to code or an archive.  A valid
solution may be a handwritten Groebner/saturation certificate, a compact
verifiable Singular/Sage transcript with all input polynomials displayed, or
a conceptual proof explaining why the low-data equations force exactly \(J\)
on \(D(s_{127})\).

Do not stop at verifying that \(J\) has five points; that is already known.
The missing step is the containment of the original localized low-data scheme
inside \(V(J)\).

---

## Prompt 5: Prove the double-fiber tail-coverage theorem

Work over \(k=\overline{\mathbb F}_5\).  Consider the corrected entry-zero
branch of a profile-4 pair.  The global profile data are the same as in
Prompt 2.  Assume
\[
  Q_0=P_0,
\]
and no other high-point coincidence.  Define
\[
  z=\frac{\Omega_0(r)}{\Omega_0(x)}
   =\frac{dr/(r-1)}{dx/(x-1)}.
\]
Then
\[
  \operatorname{div}(z)=P_1+P_\infty+C+F-Q_1-Q_\infty-A-B,
\]
so \(\deg z=6\), and \(k(C)=k(x,z)\).  The normalized bidegree-\((6,35)\)
curve satisfies
\[
  [x^6]f=z^{34}(z+1),\qquad [z^{35}]f=x^4(x-c)(x-d),
\]
where
\[
  c=x(Q_1),\qquad d=x(Q_\infty).
\]
The norm and tangent-cone calculation is already proved and gives
\[
  c=d=2,\qquad Q_1\ne Q_\infty.
\]
Thus every remaining entry-zero solution lies in the corrected double-fiber
local problem at \(x=2\).

The local expansion at the double fiber alternates repeated and simple layers.
The following are already proved:

- Repeated/simple layers through simple \(u^{25}\), including repeated
  \(u^{25}\) two-minor constraints, have explicit linear certificates.
- The first unresolved frontier is the tail-exhausted simple-\(u30\)
  base-zero locus together with repeated-\(e30\) consistency.
- A point called \(P129\) is killed by the later \(e35,e40,e45,e50\) layers;
  on the final line the \(e50\) residual is the nonzero constant \(2\).
- The checked rho4 tangent hit and checked nearby \(P129\)-tangent companions
  are also killed by the same \(e50\)-type ending.
- Basin-127 is expected to reduce to \(P129\) after the base residual, provided
  the saturation containment in Prompt 4 is proved.

The open theorem is the coverage statement.

**Theorem.**  On each rho3 and rho4 pivot chart, let
\[
  I_{\mathrm{chart}}
  =
  \langle
  \Phi_0,\Phi_1,\Phi_2,\,
  S_{30},\,
  E30_0,E30_1,E30_2
  \rangle:s_{\mathrm{chart}}^\infty,
\]
where:

- \(\Phi_i\) are the shared repeated low-data equations;
- \(S_{30}\) is the simple-\(u30\) Schur/base residual;
- \(E30_i\) are the three affine repeated-\(e30\) equations after the
  repeated-\(u25\) pivot solve;
- \(s_{\mathrm{chart}}\) is the product of the etale discriminant and all
  active chart pivots.

Prove that \(V(I_{\mathrm{chart}})\) is contained in the union of the already
identified \(P129\), rho4, and basin-127 strata, and that after adjoining the
corresponding \(e35,e40,e45,e50\) equations on each stratum, every localized
ideal becomes the unit ideal.

You must make the chart ideals and strata explicit.  A valid proof can be a
finite algebraic cover argument, a Groebner/saturation certificate with all
input equations displayed, or a conceptual argument showing that no additional
components of the tail-exhausted simple-\(u30\) base-zero/repeated-\(e30\)
frontier exist.

Do not treat basin-127 as solved unless Prompt 4 is assumed or proved.  Do
not merely show that sampled points fall into the listed strata; the theorem
requires scheme-theoretic or radical-containment coverage of the whole
localized frontier.

---

## Prompt 6: Verify the final assembly once Prompts 1--5 are solved

Work over \(k=\overline{\mathbb F}_5\).  Assume the following theorems are
proved:

1. Prompt 1: every non-visible finite etale self-correspondence of
   \(S=\mathbb P^1_k(31,31,31)\) produces the profile-4 curve-level pair with
   incidence matrix
   \[
      \begin{pmatrix}0&1&3\\1&2&1\\3&1&0\end{pmatrix}.
   \]
2. Prompt 2: no such pair has an entry-one high-point coincidence.
3. Prompt 3: no such pair has all six high points distinct.
4. Prompt 4 and Prompt 5: the corrected entry-zero double-fiber branch is
   empty.

Use the following proved facts.

For a high-point coincidence \(Q_j=P_i\),
\[
  Y_{i,j}:=\frac{\Omega_j(r)}{\Omega_i(x)}
\]
has degree at most \(6-M_{ij}\).  The residue count excludes
\[
  Q_\infty=P_0,\qquad Q_1=P_1,\qquad Q_0=P_\infty.
\]
Simultaneous inversion \(x\mapsto 1/x,\ r\mapsto 1/r\) identifies the
entry-zero cases \(Q_\infty=P_\infty\) and \(Q_0=P_0\).  The paired
entry-zero edge
\[
  Q_0=P_0,\qquad Q_\infty=P_\infty
\]
is impossible by a bidegree-\((5,5)\) genus drop.  Therefore, once entry-one
cases are excluded, every remaining entry-zero case is represented by
\[
  Q_0=P_0
\]
with no other high-point coincidence, and the norm/tangent calculation reduces
it to the corrected double-fiber branch \(x(Q_1)=x(Q_\infty)=2\).

Prove the following theorem.

**Theorem.**  Under assumptions 1--4, every finite etale self-correspondence
of \(S=\mathbb P^1_k(31,31,31)\) is visible.  Equivalently
\[
  \operatorname{Comm}_{\mathrm{alg},k}(S)=\operatorname{Aut}(S)=S_3.
\]

Then prove the common-cover consequence.  Let
\[
  Y:\ y^{31}=x(x-1).
\]
This curve has genus \(15\), and \(Y\to S\) is a finite etale
\(\mu_{31}\)-torsor.  If \(X/k\) is a smooth proper connected genus-3 curve
and \(Z\) were a connected common finite etale cover of \(X\) and \(Y\), then
the fiber product relation \(Z\times_X Z\rightrightarrows Z\) would produce
finite etale self-correspondences of \(S\).  Visibility would descend the map
\[
  Z\to S\to S_0
\]
to a finite etale map \(X\to S_0\).  But
\[
  S_0=\mathbb P^1_k(2,3,62)
\]
has
\[
  \deg K_{S_0}=-2+\left(1-\frac12\right)+\left(1-\frac13\right)
        +\left(1-\frac1{62}\right)=\frac{14}{93}.
\]
For a finite etale map \(X\to S_0\) of degree \(d\), genus \(g(X)=3\) would
give
\[
  4=\deg K_X=d\cdot\frac{14}{93},
\]
which has no integral solution \(d\).

Conclude that \(Y:y^{31}=x(x-1)\) has no connected common finite etale cover
with any smooth proper connected genus-3 curve over \(k\).
