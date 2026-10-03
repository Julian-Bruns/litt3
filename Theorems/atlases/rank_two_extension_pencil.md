# Extension kernel lines and the 64-row Frobenius atlas criterion

Version2,3October2026. Use
[rank-two extension conventions](../../Definitions/rank_two_extension_space.md):
W is stable of rank two with determinant O, and deg L=ell>2g.
In EVERY characteristic:

1. For a nowhere-zero u, ker N_u is the nonzero extension line k eta_u.
   Equivalently M_u has rank2ell+g-2 and kernel u H0(omega).
2. The unique primitive homogeneous polynomial kernel vector has degree
   EXACTLY2ell-2. It is nonzero everywhere the pencil has its generic
   rank, including outside every chosen minor chart.
3. If u has zero divisor D, ker M_u=u H0(omega(D)).
   Generic rank persists for deg D<=1. The rank-drop locus has
   codimension at least two in P(H0(W L)).

## Fixed-curve scalar realization

Fix ANY geometric dormant oper on the genus-nine curve, with the
[scalar conventions](../../Definitions/scalar_hermitian_data.md).
Let A=S_U (dimension32), E=P48 (dimension56), and
S_40=ker(delta^2-P on L192) (dimension64). For a basis T_j of S_40,
expand the horizontal Wronskian in the56 monomial fifth powers of L64:
\[
U\delta T_j-T_j\delta U=\sum_l c_{j,l}(U)m_l^5,\qquad
S_{i,l}=\operatorname{Res}_O(\ell_i m_l\theta).
\]
S is invertible and
\[
N_U=(c_{j,l}(U))(S^{[5]})^T:E^{[5]}\longrightarrow k^{64}
\]
is linear in the32 scalar Frobenius coordinates U. Its primitive
kernel vector has degree46. On every admissible quotient direction
N_U has rank55; on all directions rank N_U<=55.

The later [intrinsic Bol comparison](dormant_differential_projection.md)
identifies the former136-row principal-part tensor with J_0 N_U
for ONE fixed split injection J_0:k64->k136. This holds on the
WHOLE tensor space, including all inadmissible and nonacyclic strata,
and persists over arbitrary coefficient algebras.

## Complete atlas equations

Put D=-rho32 delta:E->P32 and define the56-square pencil
\[
R_U(\eta^{[5]})=
\rho_{48}\bigl(\kappa^5\operatorname{rem}(U\eta^5)-U(D\eta)^5\bigr).
\]
Fifth powers include the coefficients of D. An actual untwisted
Hermitian atlas inducing the fixed oper exists precisely when
U in A and eta in E satisfy
\[
N_U\eta^{[5]}=0,\quad
T=-\operatorname{aff}(U\eta^5),\quad
U\delta T-T\delta U=1,\quad R_U\eta^{[5]}=\eta,
\qquad\operatorname{pole}_O(U)\in\{111,112\}.
\]
Here T is a fixed bilinear expression, not an additional variable.
The first equation makes T horizontal and its Wronskian constant,
so that one affine evaluation imposes the middle condition.
These are finite polynomial equations retaining both infinity charts
and every quotient direction; atlas equivalence is geometric-pointwise.

For an admissible direction define the128-by56 matrix
\[
B_U=\begin{bmatrix}N_U\\N_U^{[1/5]}R_U\end{bmatrix}.
\]
Some nonzero scale gives an atlas exactly when rank B_U=55 and
R_U does not kill ker N_U. Exactly three scales then work.
Otherwise rank B_U=56 or R_U kills the kernel line.
Writing U=sum u_i^5 U_i makes these two blocks polynomial
of degrees5 and6. No generic minor chart is selected.

This criterion combines the former136-row atlas result with its
intrinsic64-row extension pencil. The later
[resultant gradient](resultant_gradient_atlas.md) makes the
nonzero-output proviso automatic on the admissible locus.
No atlas emptiness or original common-cover conclusion is asserted.

[Proof](../../Proofs/atlases/rank_two_extension_pencil.md).
