# Proof: the uniform even-order Hasse bound at orders twenty-four and thirty-six

Version1. [Statement](../../../Theorems/jacobians/torsion/family_twenty_four_thirty_six_abel_exclusion.md). [Independent whole-implication review: PASS](../../../Research/audits/FAMILY_TWENTY_FOUR_THIRTY_SIX_ABEL_AUDIT_2026_10_03.md). Reuse the accepted [single-point torsion criterion](../../../Theorems/jacobians/torsion/superelliptic_single_point_torsion_test.md), [BACKUP arithmetic](../../../Theorems/curve_arithmetic/backup_curve_arithmetic.md), and [twelve-torsion properness and isolated-point argument](family_twelve_torsion_abel_exclusion.md). No numerical check is run.

Let U be the smooth parameter curve t^5−t≠0. For N=24 or36, J[N]→U is finite étale. Its six Weierstrass Abel sections form an open-and-closed union. Removing those sections and intersecting with the closed relative Abel curve produces a proper finite incidence overU. Its BACKUP fiber is empty by W1[N], so it has no component dominatingU. Thus its parameter support is finite. This is precisely the argument already established for N=12; both new orders are prime to five and even, so its hypotheses remain intact.

Write N=2m and Φ=u(u−1)(u−2)(u−3)(u−t). Use the polynomial Hasse coefficients
\[
A_j=\Phi^j[h^j]\sqrt{\Phi(u+h,t)/\Phi(u,t)},\qquad
\deg_u A_j\le4j,\quad\deg_t A_j\le j.
\]
For a nonbranch point the single-point criterion has rows n=m+1,...,2m−1 and columns i=0,...,m−3, with entries A_(n−i). In local coordinates these columns represent (u−u(P))^i v. Polynomial elimination of the degree-m part leaves precisely these rows. The original Laurent criterion and the column rescaling by powers ofΦ are valid on Φ≠0. There are m−1 rows and m−2 columns; their maximal minors vanish exactly at the nonbranch Abel N-torsion incidence.

For any maximal minor, the largest possible sum of its row indices minus its column indices is
\[
\sum_{n=m+2}^{2m-1}n-\sum_{i=0}^{m-3}i=m^2-4.
\]
Consequently every maximal minor has u-degree at most4(m²−4), t-degree at mostm²−4, and total degree at mostD=5(m²−4).

Introduce w and wΦ−1=0, of total degree SIX. On its smooth surface the common zero locus of the minors is finite over the good parameters, as just proved by properness. Choose two generic constant linear combinations of the minors. As in the accepted twelve-torsion proof, they have no common curve meeting good parameters outside the finite base locus: choose the second combination to avoid the finitely many curve components of the first. Every good incidence point is therefore an isolated point of their intersection with wΦ−1=0. Affine Bézout for isolated components bounds their number by6D². Components confined to excluded parameters do not alter this isolated-point bound.

For m=12 this gives D=700 and6D²=2,940,000. For m=18 it gives D=1600 and6D²=15,360,000. Parameter projection cannot increase either bound. The defining incidence is over F5, so each finite parameter support is Frobenius-stable. A parameter of degree greater than the corresponding bound cannot belong to it.

The accepted MAIN selection has much larger prime degree. BACKUP exclusion is the accepted arithmetic input. This proves the two assertions and does not infer unrestricted MAIN Jacobian simplicity or torsion-difference exclusions.
