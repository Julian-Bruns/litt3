# The rank-125 fourth-lift locus with zero degree-five part

Version3, 23 September 2026. Use the actual maximal \(C_5^3\) cover,
canonical ordinary-\(Y\) reference, flat periodicity line and marked
scalar coordinates of the
[quadratic channel](fourth_hodge_quadratic_channel.md). Work over the
algebraic closure of \(k_0=\mathbf F_5[t]/(t^3+t+1)\). Put
\(R=k[s_1,s_2,s_3]/(s_i^5)\), \(J=(s_1,s_2,s_3)\),
\(K=\operatorname{Ann}(f)\), \(K_d=K\cap J^d\).
For \(H\in K\), let \(Z_4\) be the locus where the given third curve
\(X_3(H)\) admits a compatible marked fourth tuple. Retain the actual
source, lower filtered object and full integral carry.

On \(K_8\), of dimension 25, the complete fourth obstruction is
\[
E_4(H)=Q(H)-[C(q_2H_8)+C(q_2H_9)]\quad\text{in }R/(f),
\]
where \(Q\) is the actual quadratic channel, \(q_2=f_2\), and \(C\)
is the first whole product carry in the original odd logarithms,
\(s_i^5/5=-c_i s_i\) with \(c=(3,1,2)\).
The degree-six carry has rank six. On its kernel \(Q\) vanishes
identically in \(R/(f)\); the full carry has rank ten. Therefore
\[
Z_4\cap K_8
 =\ker\!\left(H\mapsto[C(q_2H_8)+C(q_2H_9)]\right)
\]
is a 15-dimensional \(k\)-linear scalar subspace, with genuine terminal
primary and whole regular repairs. This is an equality on geometric
points, without a reducedness assertion for the original parameter
scheme.

In fact every fourth-compatible \(H\) with \(H_5=0\) has
\(H_6=H_7=0\):
\[
Z_4\cap K_6=Z_4\cap K_8.
\]
The two successive eliminations hold over every geometric coefficient
field, not only for \(k_0\)-rational points.

Outside this slice, write the four free leading coefficients as
\(a_0=(H_5)_{014}\), \(a_1=(H_5)_{104}\),
\(a_2=(H_5)_{113}\), \(a_3=(H_5)_{203}\).
A necessary degree-one obstruction is
\[
[78]a_0^2+[47]a_1^2+[96]a_1a_2+[56]a_2^2=0.
\]
Here \([m]=m_0+m_1t+m_2t^2\) for \(m=m_0+5m_1+25m_2\).
Over \(k\) this is the union of the two planes
\(a_1+[34]a_2=\pm\zeta^2t\,a_0\).
Their intersection \(a_0=0\) is allowed. This equation alone does
not classify the nonzero-leading locus: the later
[fourth-escape theorem](rank125_fourth_escape.md) constructs a point
in the intersection and an eight-dimensional affine fourth-lift fibre.

The exact low-slice and leading-equation evidence remains in the
[proof](../../../Proofs/deformations/elementary_covers/rank125_fourth_low_slice.md).
