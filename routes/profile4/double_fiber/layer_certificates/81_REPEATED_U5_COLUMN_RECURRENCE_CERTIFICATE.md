# Repeated-\(u^5\) response formulas

## Referee status

This file contains two different kinds of material:

- The triangular derivative recurrence and the common-column identity below
  have written arguments (**proved-text**, conditional on the displayed local
  normal form).
- The closed response formula and the scalar identities later used to prove
  the repeated-\(u^5\) atlas were reported by missing programs and external
  transcripts.  They remain **certificate-transcript**, not independently
  reproducible proofs in this checkout.

In particular, this file alone does not prove the atlas in file 83.

## Setup

Work over \(k=\overline{\mathbb F}_5\) on the clean repeated branch at
\(x=0\).  Write

\[
 w_0=u+O(u^2),\qquad
 H(u)=\frac{\partial F_{\rm old}}{\partial w}(u,w_0)
      =u^5\ell T(u),\qquad T(0)=1,
\]

where \(\ell\ne0\).  Put \(Q=w_0/u\).  The seven visible variables give
columns

\[
 i00,\ j00,\ l01,\ l02,\ m00,\ m01,\ n00.
\]

The effective columns used later are

\[
 I=\operatorname{Col}(i00),\quad
 J=\operatorname{Col}(j00),\quad
 L=\operatorname{Col}(l01),\quad
 M=\operatorname{Col}(m00),\quad
 p=\operatorname{Col}(l02)=\operatorname{Col}(m01)
   =\operatorname{Col}(n00).
\]

Columns are elements of the étale cubic algebra described in
[file 80](80_REPEATED_BRANCH_LINEAR_ALGEBRA.md).

## Triangular derivative recurrence

For a visible variable \(v\), let \(\delta F_a^v\) be its perturbation in
the coefficient of \(w^a\):

\[
\begin{array}{lll}
\delta F_{11}^{i00}=(-u+u^2),&
\delta F_{13}^{i00}=(-u+u^2)L_i,\\
\delta F_{12}^{j00}=(-u+u^2),&
\delta F_{13}^{j00}=(-u+u^2)L_j,\\
\delta F_{13}^{l01}=(-u+u^2)u,&
\delta F_{13}^{l02}=(-u+u^2)u^2,\\
\delta F_{14}^{m00}=(-u+u^2),&
\delta F_{14}^{m01}=(-u+u^2)u,\\
\delta F_{15}^{n00}=(-u+u^2).
\end{array}
\]

All other \(\delta F_a^v\) vanish.  Write

\[
 \delta_vw=\sum_{r=3}^{11}d_r(v)u^r.
\]

Implicit differentiation of \(F(u,w)=0\), coefficient by coefficient, gives

\[
d_r(v)=-\ell^{-1}[\varepsilon u^{r+5}]
\sum_a\bigl(F_a^0+\varepsilon\delta F_a^v\bigr)
\left(w_0+\varepsilon\sum_{q=3}^{r-1}d_q(v)u^q\right)^a,
\]

for \(r=3,\ldots,11\), in the dual-number ring
\(\varepsilon^2=0\).  At stage \(r\), only the already determined
\(d_3,\ldots,d_{r-1}\) occur on the right.  This proves that the response is
triangular and uniquely determined.

If \(q_0=w_0/u\) and
\(\delta_vq=\sum_{r=3}^{11}d_r(v)u^{r-1}\), then

\[
\delta_vz=-u^{-1}q_0^{-2}\delta_vq.
\]

For the repeated-\(u^5\) residual
\(E=Z_1^5-Z_5-Z_6-Z_7-Z_8-Z_9\), its derivative is

\[
\operatorname{Col}(v)
=\sum_{n=5}^9[u^{n+1}]q_0^{-2}\delta_vq,
\]

because the differential of \(Z_1^5\) vanishes in characteristic \(5\).
These formulas are an exact finite recurrence; they do not require sampling.

## Common-column lemma

The three variables \(l02,m01,n00\) first contribute to the branch equation
in degree \(16\):

\[
\begin{aligned}
(-u+u^2)u^2w_0^{13}&=-u^{16}+O(u^{17}),\\
(-u+u^2)u w_0^{14}&=-u^{16}+O(u^{17}),\\
(-u+u^2)w_0^{15}&=-u^{16}+O(u^{17}).
\end{aligned}
\]

They affect no earlier branch coefficient.  Since the coefficient of the new
branch term is \(\ell\), each perturbation gives
\(\delta w=\ell^{-1}u^{11}+O(u^{12})\).  Therefore

\[
\delta z=-\ell^{-1}u^9+O(u^{10})
\quad\text{and}\quad
\delta E=\ell^{-1}.
\]

Thus

\[
\operatorname{Col}(l02)=\operatorname{Col}(m01)
=\operatorname{Col}(n00)=p=\ell^{-1}.
\]

In particular \(p\) is a unit on the clean branch.

## Closed formula retained for reconstruction

The missing verifier and external transcript reported the raw response

\[
\mathcal R(a,b)
=\ell^{-1}[u^{15-a-b}]Q^{a-2}T^{-1}
\]

for a perturbation \((-u+u^2)u^b w^a\), together with

\[
\begin{aligned}
I&=\mathcal R(11,0)+L_i\mathcal R(13,0),&
J&=\mathcal R(12,0)+L_j\mathcal R(13,0),\\
L&=\mathcal R(13,1),&
M&=\mathcal R(14,0),&
p&=\mathcal R(13,2)=\mathcal R(14,1)=\mathcal R(15,0).
\end{aligned}
\]

The formula is compatible with the proved common-column lemma, but this
checkout contains neither its full derivation from the local normal form nor
the cited verifier.

After normalizing by \(p\), the same missing material reported

\[
\operatorname{coeff}_{s^2}(I/p)=4,\qquad M/p-L/p=s.
\]

These are precisely the two nontrivial premises of the atlas argument in
file 83.  Finite scans over \(\mathbb F_5\) were also recorded, but finite
sampling cannot prove these identities over \(k\).  A replacement proof
should derive the closed formula and both identities in the étale algebra,
or provide an executable exact certificate with all input polynomials.

For reconstruction, the old transcript contained two more specific clues.
If

\[
U_C=\operatorname{coeff}_{u^2}(Q^{11}T^{-1}),
\]

it reported \(\operatorname{coeff}_{s^2}(U_C)=1\).  Writing
\(I/p=U_A+L_iU_C\), it also reported

\[
\begin{aligned}
\operatorname{coeff}_{s^2}(U_A)
 &=c_2^2+2c_2d_1+4d_2+2e_1+3,\\
L_i&=4c_2^2+3c_2d_1+d_2+3e_1+1.
\end{aligned}
\]

The two right-hand sides sum to \(4\) in characteristic \(5\).
The coordinate names \(c_2,d_1,d_2,e_1\) are not defined by any retained
normal-form file, so these formulas are clues, not a self-contained proof.
The same transcript suggested interpreting their sum as a residue
coefficient

\[
\operatorname{coeff}_{q^{-1}}\!\left(\frac{2q^9}{G(u,q)}\right)=4.
\]

A future proof could make this residue argument precise after reconstructing
the missing normal form.
