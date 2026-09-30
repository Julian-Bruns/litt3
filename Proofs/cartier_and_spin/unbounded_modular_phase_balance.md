# Field separation replaces the small-phase anchor

[Statement](../../Theorems/cartier_and_spin/unbounded_modular_phase_balance.md).
This new argument uses the established local two-jets and regularity of
trace from the [differentiated trace proof](differentiated_endpoint_phase_balance.md),
but does not assume its phase-cardinality bound or repeat its searches.

## The fields and local normalization

Put B=F25=F5(beta), beta2=beta+3, with the established code[a+5b]=a+b beta.
Let E=B(alpha)=F_(5^8), where
alpha4+[7]alpha3+[6]alpha2+[2]alpha+[5]=0, and alpha_i=alpha^(25^i).
Let K=B(xi)=F_(5^14), where xi has order29. Thus E and K are linearly
disjoint over B. Put zeta=[11]. The polynomials are
P=(11,22,18,5,19,20,15,16,9,22,1), A=(1,21,14,22,13), and
c=(22,7,9,23), with ascending coefficients. All alpha_i are roots of A.

Choose rho0 with rho0^3=P(alpha0), and put
rho_i=rho0^(25^i). The ratio rho_i/rho0 is the element
r_i=P(alpha0)^((25^i-1)/3) of E. This removes the possibly non-E
common cubic root without presuming that it lies in E or K.

Use the canonical leading constants from the accepted two-jet theorem:
\[
B_i=\left(3A'(\alpha_i)^3P(\alpha_i)^2/[13]^3\right)^{29^{-1}},
\quad a_i=[13]B_i^4/A'(\alpha_i),
\]
\[
b_i=\frac{4[13]B_i^3c(\alpha_i)-A''(\alpha_i)a_i^2/2}{A'(\alpha_i)}.
\]
The inverse29 is modulo5^8-1, so all these constants belong to E.
The local branch at phase xi^j has
x=alpha_i+a_i xi^(4j)t+b_i xi^(8j)t2+O(t3),
and y(0)=rho_i zeta^s on cubic sheet s. A common nonzero scalar in
the normalization at the other endpoint can be removed from each
trace equation. Changing rho0 by a cube root of unity only rescales
all four columns and relabels sheets; it does not affect independence.

For k=1,2 let
S_(i,s)(r)=sum_j m_(i,s,j) xi^(rj) and
T_(i,k)(r)=sum_s zeta^(-ks) S_(i,s)(r). All T_(i,k)(r) belong to K,
regardless of the sizes of the nonnegative integer counts m.

## Four coefficient matrices, all invertible over B

The two forms dx/y and dx/y2 are regular on X. Their traces under
the separating map t:T->P1 are regular and therefore zero. At t=0,
all branches have ramification index one in t, so the trace can be
expanded as their actual sum. Its first two coefficients give
\[
\sum_i u_{ki}T_{i,k}(4)=0,
\qquad \sum_i v_{ki}T_{i,k}(8)=0,
\]
where, after removing the common factor rho0^(-k),
\[
u_{ki}=a_i r_i^{-k},\qquad
v_{ki}=a_i^2 r_i^{-k}
\left(2b_i/a_i^2-\frac{kP'(\alpha_i)}{3P(\alpha_i)}\right).
\]
Their four column matrices in the E/B basis1,alpha,alpha2,alpha3 are
\[
U_1=\begin{pmatrix}
[21]&[22]&[17]&[23]\\[19]&[24]&[2]&[9]\\
[21]&[14]&[21]&[16]\\[10]&[20]&[17]&[21]
\end{pmatrix},\quad \det U_1=[23],
\]
\[
V_1=\begin{pmatrix}
[11]&[22]&[23]&[13]\\[23]&[8]&[23]&[14]\\
[5]&[15]&[24]&[16]\\[17]&[19]&[18]&[23]
\end{pmatrix},\quad \det V_1=[15],
\]
\[
U_2=\begin{pmatrix}
[21]&[15]&[16]&[10]\\[19]&[23]&[5]&[17]\\
[21]&[5]&[17]&[13]\\[10]&[22]&[12]&[9]
\end{pmatrix},\quad \det U_2=[16],
\]
\[
V_2=\begin{pmatrix}
[20]&[9]&[20]&[14]\\[15]&[3]&[11]&[5]\\
[4]&[19]&[10]&[16]\\[4]&[0]&[23]&[11]
\end{pmatrix},\quad \det V_2=[4].
\]
All four determinants are nonzero. Linear disjointness implies that
each set of four columns is independent over K as well. Thus
T_(i,k)(4)=T_(i,k)(8)=0 for every i and k. Inverting the cubic Fourier
transform gives equal S_(i,s)(4) and equal S_(i,s)(8) on the three sheets.
This is the step for which the earlier proof used a small-phase anchor.
The new proof uses only the two forms themselves, with no x-powers.

## What the two moments say about integer multiplicities

For any two sheets at one root put
D(Z)=sum_j(m_(i,s,j)-m_(i,s',j))Z^j in F5[Z], degree<=28.
The two equalities give D(xi4)=D(xi8)=0. The two5-Frobenius orbits of
these roots have length14, are disjoint and exhaust all nontrivial
29th roots. Consequently D is a constant multiple of Phi29(Z).
This proves the claimed uniform difference without using norm invariance.

If the sheet cardinalities agree, D(1)=0. Since Phi29(1)=29=4 in F5,
that constant is zero. Polynomial endpoint norms give precisely these
equal cardinalities. The argument imposes no degree bound on the norms.

For the integer assertion, remove the common residues of the counts
in{0,...,4}. At each root the remaining counts are five times multisets
of a common cardinality b_i. The index-five argument in the
[integer-phase proof](two_jet_integer_phase_balance.md) applies verbatim
without a total-mass bound: the leading residue polynomial is G(W)^5
times J(W3), and its index-five coefficient must vanish since5 is a
gap at O. The four fixed residue weights are independent over K
(their B-determinant is[12]), so that first Fourier relation separates
root by root. If b_i<=3, the accepted three-phase rigidity forces the
three block multisets to agree. They then agree as integers before
division by five as well. In particular m_i<=19 suffices at every root.
No statement about arbitrary-length five-block multisets is inferred.

## Focused evidence and scope

The new [small exact constructor](../../scripts/arithmetic/rootwise_trace_field_separation_20260929.py)
reconstructs these four matrices from the displayed P,A,c and field,
including the relative rho_i/rho0 factors. It passes, with the four
determinants23,15,16,4 in the stated code. Its compact
[receipt](../../../litt3-computation-data/conceptual_continuation_20260929/rootwise_trace_field_separation_v2.json)
contains all entries. No phase multiset search is performed by this script.
The [focused independent audit](../../Research/audits/UNBOUNDED_PHASE_SEPARATION_2026_09_29.md)
passes the field separation, endpoint scalar normalization, actual-source
trace and enlarged integer scope. A separate plain-Python reconstruction
matches all four matrices and the residue determinant.
The older complete three-phase and residue-basis certificates are reused
with their proved scopes, not rerun or extrapolated.

This is a comparison theorem under the shared tensor/line premise.
It does not construct such an object from an unmarked common cover,
and norm invariance in arbitrary degree is not established here.
