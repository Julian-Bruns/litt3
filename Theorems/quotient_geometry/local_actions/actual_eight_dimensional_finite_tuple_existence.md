# An abstract finite eight-dimensional admissible tuple exists

Version 1, 3 October 2026. All eight mathematical assertions passed the
[fresh independent audit](../../../Research/audits/OCT03_EIGHT_TUPLE_FULL_GENERATION_AUDIT_2026_10_03.md).
The word “actual” in the record ID refers to explicit matrices and their
generated finite group. The scope is entirely abstract: no curve or
common-cover source is asserted.

Let \(k=\overline{\mathbf F}_5\), let \(E_{ij}\) denote matrix units, and set
\[U=I_4+E_{12}+E_{23}+E_{34},\qquad
X=\begin{pmatrix}4&3&1&4\\2&4&3&1\\1&1&1&4\\1&3&1&0\end{pmatrix},\]
\[A=\begin{pmatrix}U&X\\0&U^{\mathsf T}\end{pmatrix},\qquad
S=\begin{pmatrix}0&3I_4\\I_4&0\end{pmatrix},\qquad B=A^4S,\qquad C=S^{-1}.
\]
All entries belong to \(\mathbf F_5\). Then:

1. \(A,B,C\in SL_8(\mathbf F_5)\), \(ABC=I\), and \(A,B\) have exact order
   five and Jordan type \(J_5\oplus J_3\). Their nilpotent rank sequence is
   \((6,4,2,1,0)\). The matrix \(C\) has exact order eight, \(C^2=2I\), and
   eigenvalues \(\pm\lambda\), each of multiplicity four, where
   \(\lambda^2=2\) and \(\lambda^4=-1\). Thus its projective order is two.
2. The SAME generated group is
   \(H=\langle A,B\rangle=SL_8(\mathbf F_5)\). There is a specified
   \(P\in H\) with \(PA^{-1}P^{-1}=B\). Inverse conjugacy is internal to
   \(H\), and hence to its projective quotient.
3. Put \(G=H/\mu_4=PSL_8(\mathbf F_5)\). Its natural projective module
   \(W=k^8\) has multiplier of EXACT order four in \(H^2(G,k^\times)\),
   with trivial coefficient action. The classes \(a,b,c\) of \(A,B,C\)
   generate this SAME \(G\), have orders \(5,5,2\), satisfy \(abc=1\), and
   \(b\) is conjugate to \(a^{-1}\) inside \(G\). The group has no nontrivial
   quotient of order prime to five.
4. \(W\) is absolutely irreducible, primitive, and tensor indecomposable,
   including systems with tensor-factor permutations. For every integer
   \(r\geq0\), it preserves no line of nonzero bilinear or
   \(5^r\)-Frobenius-sesquilinear forms, even allowing a similitude
   character. In particular it has no projectively preserved symplectic,
   orthogonal or finite-field Hermitian form.

The proof contains a transvection-star certificate producing all 56
elementary roots, and an exact determinant-one inverse conjugator. The
[standalone verifier](../../../scripts/genus_two/oct03_eight_tuple_verify.py),
[external certificate](../../../../litt3-computation-data/oct03_ten_hour/eight_tuple_verified.json)
and independent audit provide reproducible exact finite-field checks.
Neither classification nor genericity is used for full generation.

This realizes the listed finite-representation constraints of the
\(J_5\oplus J_3\), multiplier-four, primitive-eighth-root tame sector.
It constructs no weak cyclic cover of curves, canonical root or original
spin-image normalization, and neither of the two actual finite étale maps
from one smooth projective source. Source half-class and kernel-quotient
results are not dependencies of this theorem. The unmarked common-cover
problem remains UNSOLVED.

[Proof](../../../Proofs/quotient_geometry/local_actions/actual_eight_dimensional_finite_tuple_existence.md).
