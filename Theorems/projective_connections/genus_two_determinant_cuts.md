# Determinant hypersurfaces have singular Kummer cuts

Version3, 19 September 2026. The fixed two-torsion determinant
extension is identified below.

Let C be a smooth projective genus-two curve over an algebraically
closed field of characteristic different from two. Choose
\(\vartheta^2=\omega_C\), put \(A=J(C)\), and identify
\[
S=SU_C(2,\omega_C)\simeq\mathbf P^3,\qquad
j:A\to K\subset S,\quad
N\mapsto[\vartheta N\oplus\vartheta N^{-1}].
\]
Here K is the decomposable Kummer quartic in the bundle-moduli space.
Let E be a degree-zero vector bundle of rank \(r\ge1\), and assume
that its determinant theta scheme
\[
B_E=\{N\in A:H^0(C,\vartheta E\otimes N)\ne0\}
\]
is proper. Then the actual determinant-of-cohomology test on S is a
nonzero homogeneous form \(Q_E\) of degree r, up to scalar, and
\[
Q_E([V])=0\iff H^0(C,V\otimes E)\ne0,\qquad
j^*\operatorname{div}(Q_E)=B_E+[-1]^*B_E.
\tag{1}
\]
The restriction to K is nonzero, and the complete-intersection curve
\(K\cap V(Q_E)\) is never smooth, including its scheme structure.
If \(B_E\) and \([-1]^*B_E\) are smooth, distinct and transverse,
the cut has exactly \(r^2\) ordinary nodes and no other singularities.

Properness already implies semistability of E; no separate stability
hypothesis is needed. For rank two, every semistable degree-zero E
has proper \(B_E\), so the conclusion applies unconditionally in
that class. Properness must not be dropped in higher rank.

If, in addition, \(r=2\) and \(\det E\simeq\mathcal O_C\), then
\(Q_E\) is the square of a nonzero linear form on S, up to scalar.
Consequently a collection of points spanning S cannot all have
nonzero \(H^0(V\otimes E)\) for any such E.

Fix a nontrivial \(\kappa\in A[2]\). The SAME eigenspace contains
the determinant quadrics of both of the following families:

1. Every semistable rank-two degree-zero E with \(\det E=\kappa\).
2. Every \(E_L=\pi_*L\), \(L\in J(D)\), for the connected
   étale double \(\pi:D\to C\) with character \(\kappa\).

Let M be a matrix representing translation by
\(\kappa\) on the dual Kummer coordinates, with \(M^2=cI\).
Then their determinant quadrics all lie in the SAME eigenspace
\[
U_\kappa=\{Q:Q(M^{\mathsf T}z)=cQ(z)\}.
\tag{2}
\]
In both cases the sign is determined by \(\mathcal O_C\oplus\kappa\)
in a connected parameter space. In the first family, the identity
\(E^\vee=E\otimes\kappa\) and Serre duality replace the
self-twist isomorphism used in the second. Projective invariance
alone would not determine the sign. Consequently, any prescribed moduli
points whose unique simultaneous quadric in \(U_\kappa\) has a
smooth Kummer cut exclude BOTH families. A fixed determinant equal
to \(\kappa\) is not asserted to make E a double-cover pushforward.

[Proof](../../Proofs/projective_connections/genus_two_determinant_cuts.md).

If the chosen theta characteristic is odd, write
\(W_a=V_a\vartheta^{-1}\) for \(a=[V_a]\in S\). There is,
up to scalar, an actual symmetric triquadratic R on \(S^3\) with
\[
R(a,b,j(M))=0
\iff H^0(C,\vartheta W_a\otimes W_b\otimes M)\ne0.
\tag{3}
\]
It is the unique extension from the determinant section on
\(S\times S\times K\), using the isomorphism of quadratic
sections on K with ambient quadrics. On \(K^3\) its divisor
pulls back to the four theta factors at \(M\pm N\pm L\).
Thus a calibrated Kummer addition formula is an alternative way
to compute this same actual section. Necessary singularity of a
Kummer cut alone does not identify a quadric with one of these tests.

The actual R admits a smaller calibration when ten of the
two-torsion moduli nodes impose independent conditions on quadrics.
Let \(p_0=j(0)\), choose lifts \(L_\tau\) of tensoring by tau,
and put \(p_\tau=L_\tau p_0\). Let H represent the linear
identification of the actual theta section of V_b with a hyperplane
on S, so \(R(a,b,p_0)=(a^{\mathsf T}Hb)^2\). Then
\[
R(a,b,p_\tau)=\lambda_\tau(a^{\mathsf T}HL_\tau b)^2,
\qquad
\lambda_\tau=
\left(\frac{(p_\tau^{\mathsf T}H)_j}
{(p_0^{\mathsf T}HL_\tau)_j}\right)^2,
\tag{4}
\]
using any nonzero denominator coordinate. The two rows are
proportional. Ten-node quadratic interpolation therefore determines
R, including all calibration scalars; no236-unknown homogeneous
system is required. The independence hypothesis is checked in the
[family theorem](family_dormant_theta_exclusions.md).
