# Proof of the two-sided middle source bound

Use the [statement](../../Theorems/cartier_and_spin/middle_common_eigenvector_boundary.md).
The original H tensor and its identification with actual Laurent
equations are the accepted inputs from
[correction rigidity](middle_character_correction_rigidity.md).

## Removing the two scalar parameters

The coefficient of b0 is (I15,0) vertically, and that of b1 is
(0,I15). The independent verifier checks these identities directly
in the original tensor. A nonzero kernel vector s therefore satisfies
Us=-b0*s and Vs=-b1*s. Put C=[U,V]. Then for every a,b>=0,
\[
C U^a V^b s=(-b_0)^a(-b_1)^b C s=0.
\]
Thus a polynomial left inverse of any stack of these word matrices
excludes a kernel, uniformly in b0,b1. This argument uses actual
matrix multiplication, not an assumption that U and V commute.

Write z=(b2,...,b9). If z=0, at least one of b0,b1 is nonzero,
and the two scalar blocks themselves prove injectivity. Otherwise
normalize the first nonzero entry of z to one. U and V are linear
in z; scaling z preserves their common eigenvectors. This covers
the relevant geometric parameter space without losing any exceptional
eigenvalue of U or V.

## The exact finite cover of the new boundary

On b2=b3=b4=0, the first nonzero index of z is5,6,7,8 or9.
For indices6,7,8, explicit polynomial left inverses are supplied for
the45-by15 stack C,CU,CV. At index9 the constant commutator alone
has rank15.

At index5 use instead the90-by15 stack
\[
S=\begin{pmatrix}C\\CU\\CV\\CU^2\\CUV\\CV^2\end{pmatrix}.
\]
An exact compact certificate supplies L with LS=I15 on the entire
four-variable affine stratum. The coefficient degrees are bounded by
7 minus the degree of the corresponding row of S. No determinant or
other parameter is inverted. Every common eigenvector is killed by
all six blocks, so the identity proves the assertion there too.

The original a-coordinates enter b through their twenty-fifth powers.
They vanish exactly when the corresponding b-coordinate vanishes.
The previous (a1,a2,a3)!=0 result and the new (a3,a4,a5)!=0 result
give the two-sided support condition. Neither implies that all five
coefficients are nonzero.

## Evidence and replay

The
[constructor](../../scripts/arithmetic/middle_common_eigenvector_obstruction.py)
builds the word matrices from the original tensor. The independent
[verifier](../../scripts/arithmetic/verify_middle_common_eigenvector.py)
rebuilds U,V, their commutator and each recorded word using integer
F25 tables, then checks all225 entries of LS=I15. It also checks the
constant index9 commutator directly. No Groebner algorithm or point
search occurs in that verification.

The index5 evidence is the
[compact NPZ certificate](../../../litt3-computation-data/overnight_three_replies_20260926/eigen_middle_b5_words2_compact7.npz)
and its
[successful replay](../../../litt3-computation-data/overnight_three_replies_20260926/verify_eigen_middle_b5_words2_compact7.json).
Its construction uses the
[bounded coefficient solver](../../scripts/arithmetic/middle_compact_commutator_inverse.py)
on a4950-by5565 exact system. The saved certificate is48358 bytes.
The bound is used to FIND the identity; the verified identity proves
the exclusion at every geometric parameter value.

The remaining certificates and successful replays are
[index6](../../../litt3-computation-data/overnight_three_replies_20260926/eigen_middle_b6.json),
[replay6](../../../litt3-computation-data/overnight_three_replies_20260926/verify_eigen_middle_b6.json),
[index7](../../../litt3-computation-data/overnight_three_replies_20260926/eigen_middle_b7.json),
[replay7](../../../litt3-computation-data/overnight_three_replies_20260926/verify_eigen_middle_b7.json),
[index8](../../../litt3-computation-data/overnight_three_replies_20260926/eigen_middle_b8.json), and
[replay8](../../../litt3-computation-data/overnight_three_replies_20260926/verify_eigen_middle_b8.json).

To reproduce, invoke the independent verifier with the original
residual_system.npz tensor, each certificate above and a separate
--output receipt. It accepts both expanded JSON and compact NPZ
certificates and requires only Python and NumPy.

The unfinished wider source strata and earlier map-degree ideal
calculations are not used in this proof. A full quotient window or
strict return is not constructed by any of these matrix identities.
