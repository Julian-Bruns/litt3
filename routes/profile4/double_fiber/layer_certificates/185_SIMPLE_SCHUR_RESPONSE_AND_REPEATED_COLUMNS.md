# Simple-branch response and the repeated-layer Schur columns

## Status and scope

The response and Schur-complement formulas below are **proved-text** under
the displayed local normal form. Together with file 182 they prove the
selected corrected-column expressions formerly retained only from missing
programs at repeated \(u^{10}\), \(u^{15}\), and \(u^{25}\). They also
reconstruct the proposed repeated-\(u^{20}\) expressions.

This does not close Task 00: the checkout still lacks the ambient
repeated-\(u^{20}\) coefficient list needed to prove that the proposed
columns are genuinely new variables and exhaust the three residual rows.
It also does not prove the upstream specialization \(c=d=2\).

## Local setup at the simple branch

Let \(k\) have characteristic \(5\). Suppose

\[
 \Phi(u,uq)=u^4G(u,q),\qquad
 G(0,q)=a(q-1)^3(q+1),\qquad a\in k^\times,
\tag{185.1}
\]

and let \(q_-(u)=-1+O(u)\) be the simple branch. Put

\[
 w=uq_-,\qquad z=w^{-1},\qquad
 D=(u-1)\frac d{du},\qquad
 \mathcal E=D^4z-z+z^5.
\]

Along the branch, write

\[
 G_q(u,q_-)=2a\,T_-(u),\qquad T_-(0)=1.
\tag{185.2}
\]

For \(m\geq1\), let \(E_m=[u^{5m}]\mathcal E\). Perturb \(\Phi\) by

\[
 \epsilon\,u(u-1)u^A w^B,\qquad \epsilon^2=0,
\tag{185.3}
\]

and denote the induced derivative of \(E_m\) by
\(\operatorname{SCol}_m(A,B)\).

## Simple response theorem

Under (185.1)--(185.3),

\[
 \boxed{
 \operatorname{SCol}_m(A,B)
 =(2a)^{-1}
 \left([u^{5m+8-A-B}]-[u^{5m+3-A-B}]\right)
 q_-^{B-2}T_-^{-1}.}
\tag{185.4}
\]

As usual, coefficients of negative degree are zero.

### Proof

Since \(\Phi_w=u^3G_q\), implicit differentiation gives

\[
\begin{aligned}
 \delta w
 &=-\frac{u(u-1)u^Aw^B}{u^3(2a)T_-}\\
 &=(2a)^{-1}u^{A+B-2}(1-u)q_-^BT_-^{-1},
\end{aligned}
\]

and hence

\[
 \delta z
 =-(2a)^{-1}u^{A+B-4}(1-u)q_-^{B-2}T_-^{-1}.
\tag{185.5}
\]

File 182 proves, directly from \(D^4-1\), that

\[
 E_m=Z_m^5-\sum_{j=0}^4Z_{5m+j}
\]

when \(z=\sum Z_nu^n\). The Frobenius term has zero differential.
Substitution of (185.5) and telescoping the five remaining coefficients
gives exactly (185.4).

## The parity rule for a simple-layer pivot

Suppose \(A+B=5m+8\). Formula (185.4) becomes

\[
 \operatorname{SCol}_m(A,B)
 =(2a)^{-1}(-1)^{B-2}.
\tag{185.6}
\]

In particular, the simple-layer pivot

\[
 v_m=U_{27-5m}(0),
\]

which enters the curve equation as \(u(u-1)w^{5m+8}v_m\), has response

\[
 c_m=(2a)^{-1}(-1)^m
 =
 \begin{cases}
 3a^{-1},&m\ \text{even},\\
 2a^{-1},&m\ \text{odd}.
 \end{cases}
\tag{185.7}
\]

This recovers the four coefficients in file 85.

For any other new variable on the same diagonal \(A+B=5m+8\), eliminating
the simple residual by the pivot replaces its repeated-branch column by

\[
 \operatorname{Col}^{\mathrm{corr}}_m(A,B)
 =
 \operatorname{Col}_m(A,B)
 +\lambda(A,B)\operatorname{Col}_m(0,5m+8),
\tag{185.8}
\]

where

\[
 \boxed{\lambda(A,B)=-(-1)^{B-(5m+8)}.}
\tag{185.9}
\]

Indeed, (185.9) is \(-\operatorname{SCol}_m(A,B)/c_m\).
Variables with \(A+B>5m+8\) have zero simple response at this layer and
need no correction.

## Application to the retained coefficient convention

Write \(u j_A=[u^A]U_j(u)\). In the retained bidegree-\((6,35)\) normal
form this variable occurs as

\[
 u(u-1)u^Aw^{35-j}.
\tag{185.10}
\]

On a repeated branch, use the notation of file 182:

\[
 w=uQ,\qquad
 \Phi_w=u^5\ell T,\qquad p=\ell^{-1}.
\]

For all variables below, the lower-boundary term in (182.4) vanishes.
Combining (182.4) with the correction rule (185.9) gives the following
normalized columns without any computer calculation.

### Repeated \(u^{10}\)

Here \(m=2\), and the pivot is \(U_{17}(0)\). One obtains

\[
\begin{aligned}
 u18_3/p&=1,\\
 u17_1/p&=[u]Q^{16}T^{-1}=U_L,\\
 u19_3/p&=[u]Q^{14}T^{-1}=G,\\
 u19_2/p&=[u^2](Q^{14}+4Q^{16})T^{-1}=F.
\end{aligned}
\tag{185.11}
\]

The coefficient \(4\) in the last line is forced by (185.9), because the
\(w\)-exponents of \(u19_2\) and the pivot are \(16\) and \(18\).
The equalities with \(U_L=[u]Q^{11}T^{-1}\) use
\(Q^5\equiv1\pmod{u^5}\).

### Repeated \(u^{15}\)

Here \(m=3\), and the pivot is \(U_{12}(0)\). The corrected columns are

\[
\begin{aligned}
 u13_3/p&=1,\\
 u12_1/p&=U_L,\\
 u14_3/p&=U_L+3s,\\
 u15_3/p&=[u^2](Q^{18}+Q^{21})T^{-1}.
\end{aligned}
\tag{185.12}
\]

The last correction coefficient is \(1\), because the two \(w\)-exponents
are \(20\) and \(23\).

### Repeated \(u^{20}\)

Here \(m=4\), and the pivot is \(U_7(0)\). The same calculation gives the
proposed columns

\[
\begin{aligned}
 u8_3/p&=1,\\
 u7_1/p&=U_L,\\
 u9_3/p&=U_L+3s,\\
 u10_3/p&=[u^2](Q^{23}+Q^{26})T^{-1}.
\end{aligned}
\tag{185.13}
\]

The correction coefficient in the last line is again \(1\). Formula
(185.13) proves the response calculation itself, but the missing variable
list described in the status paragraph is still needed for a full layer
theorem.

### Repeated \(u^{25}\)

Here \(m=5\), and the pivot is \(U_2(0)\). One obtains

\[
\begin{aligned}
 u0_0/p&=1,\\
 u2_1/p&=U_L,\\
 u1_0/p&=U_L+s,\\
 u5_3/p&=[u^2](Q^{28}+Q^{31})T^{-1}.
\end{aligned}
\tag{185.14}
\]

Again the last correction coefficient is \(1\). This proves the corrected
response expressions used in file 104, independently of its missing
program.

## Reduction of the last repeated-\(u^5\) scalar

The same theorem makes the remaining premise in file 83 especially
explicit. At \(m=1\), the simple pivot is \(U_{22}(0)\), whose
\(w\)-exponent is \(13\). Let \(i00\) denote the coefficient whose raw
perturbation has \(w\)-exponent \(11\), and let \(L_i\) be the multiple of
the pivot used to preserve the simple \(u^5\) equation.

Formula (185.4) gives

\[
 \operatorname{SCol}_1(i00)
 =[u^2]\frac{q_-^9}{G_q(u,q_-)},
 \qquad
 \operatorname{SCol}_1(U_{22}(0))=2a^{-1}.
\tag{185.15}
\]

Consequently, in the normalized case \(a=1\),

\[
 L_i=2[u^2]\frac{q_-^9}{G_q(u,q_-)}.
\tag{185.16}
\]

On the three repeated branches \(q_1,q_2,q_3\), Lagrange interpolation as
in file 184 gives

\[
 [s^2]U_A
 =2[u^2]\sum_{i=1}^3\frac{q_i^9}{G_q(u,q_i)},
\qquad
 U_A=[u^4]Q^9T^{-1}.
\tag{185.17}
\]

File 184 proves \([s^2]U_C=1\), and
\(U_I=U_A+L_iU_C\). Therefore

\[
 \boxed{
 [s^2]U_I
 =2[u^2]\sum_{q\in\{q_1,q_2,q_3,q_-\}}
       \frac{q^9}{G_q(u,q)}.}
\tag{185.18}
\]

Thus the only scalar input still missing from the repeated-\(u^5\) atlas is
the local residue identity

\[
 [u^2]\sum_{q\in\{q_1,q_2,q_3,q_-\}}
       \frac{q^9}{G_q(u,q)}=2.
\tag{185.19}
\]

Unlike the three identities proved in file 184, (185.19) is not forced by
the tangent cone alone: it also depends on the first two higher homogeneous
parts of the normalized curve equation. Equation (185.19) isolates exactly
what must be recovered from the missing base normal form.

