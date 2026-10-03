# Proof: proper torsion incidence and isolated affine Bézout

Version1. [Statement](../../../Theorems/jacobians/torsion/family_twelve_torsion_abel_exclusion.md). Author proof awaiting independent review. Reuse the accepted [polynomial single-point torsion criterion](../../../Theorems/jacobians/torsion/superelliptic_single_point_torsion_test.md) and [BACKUP arithmetic](../../../Theorems/curve_arithmetic/backup_curve_arithmetic.md), whose W1[24] consists only of Weierstrass classes. No new computation is run.

Let U be the smooth parameter curve t^5−t≠0 and \(\Phi=u(u-1)(u-2)(u-3)(u-t)\). The relative Jacobian J→U has finite étale twelve-torsion J[12]. The six Weierstrass Abel classes are six disjoint sections of J[12] (including zero); as sections of a finite étale scheme they form an open-and-closed union. Remove that union to obtain the finite étale scheme J[12]_new.

The Abel embedding of the proper smooth curve Y→U into J is closed. Its intersection Z with J[12]_new is therefore CLOSED in a finite U-scheme and is finite and proper over U. The accepted BACKUP specialization t=α has empty Z fiber. Since U is an irreducible curve, any component of Z dominating U would have closed image containing all U and thus meet this fiber. Therefore Z is supported over finitely many parameters. Its points are precisely the non-Weierstrass twelve-torsion Abel points.

It remains to bound this finite support. Define polynomial-scaled Hasse coefficients
\[
A_j(u,t)=\Phi(u,t)^j[h^j]\sqrt{\Phi(u+h,t)/\Phi(u,t)}.
\]
Recursive comparison of squares divides only by TWO. Hence A_j is a polynomial in characteristic five, even for j≥5. The same Hasse-weight argument as in the accepted [six-torsion proof](family_six_torsion_abel_exclusion.md) gives
\[
\deg_u A_j\le4j,\qquad \deg_t A_j\le j.
\]
Indeed a monomial of Hasse weight j is a product of derivatives Φ_[r] and powers of Φ with degree at most5j−Σr=4j, and its t-degree is at most j.

For N=12 the accepted criterion has rows n=7,8,9,10,11 and four columns i=0,1,2,3, representing u^i v. Its entry is A_(n−i). Every maximal4×4 minor Δ has
\[
\deg_u\Delta\le4(8+9+10+11-0-1-2-3)=128,
\qquad\deg_t\Delta\le32,
\]
so its TOTAL degree is at most160. At a nonbranch finite point the common vanishing of the five maximal minors is equivalent to twelve-torsion. The coordinate u gives a two-to-one identification between the non-Weierstrass incidence and its u,t image (conjugate points have opposite Abel class), so this image is finite on U.

Introduce an auxiliary variable w and the equation wΦ(u,t)−1=0, of total degree SIX. On the open t∈U, the common zero set of the five minors and this equation is finite. On the smooth surface S={wΦ−1=0} the common base locus of the minors is therefore finite away from the finitely many excluded parameters. Choose TWO generic constant linear combinations D1,D2 of those minors. They have degree at most160 and their intersection on S has no positive-dimensional component meeting t∈U: for each irreducible curve of the first divisor meeting U and not contained in the common base locus, the second generic combination avoids containing it. The finitely many good-parameter common base points are thus isolated points of the three-equation intersection
\[
D_1=D_2=w\Phi-1=0.
\]
The affine Bézout bound for isolated components of three hypersurfaces in affine three-space gives at most160·160·6=153600 isolated geometric points, counted with multiplicity. Positive-dimensional components confined to excluded parameters do not increase this bound for isolated good points. Consequently the nonbranch u,t incidence, and hence its parameter projection, has at most153600 geometric points.

Everything defining the original incidence is over F5, so its finite parameter support is Frobenius-stable. A point t of F5-degree r in that support contributes its r distinct conjugates. Thus r≤153600. The selected MAIN parameter has much larger degree by the accepted partner selection, so it avoids this support. The BACKUP conclusion is the original accepted input, not a new deduction from the bound.
