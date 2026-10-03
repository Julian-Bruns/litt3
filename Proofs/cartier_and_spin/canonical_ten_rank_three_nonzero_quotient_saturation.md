# Proof: the native determinant and the original infinity kernel remove every saturation loss

Version1,3 October2026. Root whole-scope review **PASS**; see the [statement](../../Theorems/cartier_and_spin/canonical_ten_rank_three_nonzero_quotient_saturation.md) and [rankTHREE review](../../Research/audits/RANK_THREE_SOCLE_AND_ORTHOGONAL_ROW_AUDIT_2026_10_03.md). No computation is used. Both original endpoint maps remain on T.

Suppose K is not saturated. The accepted saturated rankTHREE Cartier bound is degree at mostTWO. Therefore its saturation E has degreeTWO and E/K has precisely lengthONE at one Y-point S. The canonical alternating Cartier pairing gives E=A^⊥ for a line A of degreeZERO, with
\[
\det E=\omega_Y\otimes A.
\tag{1}
\]
The original quotient J/K=O_Y gives detJ=detK. Since E/K is supported at S,
\[
\det E=\det J(S).
\tag{2}
\]

Let D_J be the determinant defect of J⊂B_Y. Its degree isTHREE and detJ=ω_Y²(−D_J). At every original infinity point the q1 section has zero B-fiber value, but its J/K value is the nonzero constant ℓ(q1). Thus it is a nonzero J-fiber kernel vector. The accepted original carrier support ledger consequently puts BOTH R_+ and R_- in D_J.

The point S also lies in D_J. Indeed if J=B locally at S, then J/K would have the nonzero torsion E/K, contrary to the integral locally free quotient J/K=O_Y. Thus, when S differs from both wild points, the degreeTHREE ledger is already
\[
D_J=R_++R_-+S.
\tag{3}
\]

Suppose instead S is one of the wild points. Choose an original infinity point of T above it; such points exist over BOTH wild points by the retained support ledger. The map q*K→q*B has a one-dimensional fiber kernel there, since its saturation loss has lengthONE. Its image in the q*J fiber is still one-dimensional because K→J is a subbundle: J/K is locally free. The original q1 vector is a SECOND, independent vector in the kernel q*J→q*B: its B-value is zero, whereas its value in q*(J/K) is nonzero. Therefore J's B-fiber rank is at mostTWO at S. A rankFOUR integral inclusion of this fiber rank has at leastTWO positive local Smith exponents, so D_J has multiplicity at leastTWO at S. Together with the other wild point and total degreeTHREE, this again gives (3). No condition about F₄ or source finite cubic branches is needed.

Equations (2)–(3), and the canonical equivalence R_++R_-∼ω_Y, imply
\[
\det E=\omega_Y^2(-R_+-R_-)=\omega_Y.
\]
Comparison with (1) yields A=O_Y. But A is a nonzero line subbundle of B_Y, while ordinary Y has H0(Y,B_Y)=ZERO. This contradiction proves K saturated.

Dependencies used at their accepted scopes: the saturated rankTHREE bound and native annihilator determinant in the [rankTHREE row proof](canonical_ten_rank_three_ramified_nonzero_quotient_exclusion.md); the integral original quotient and infinity support in that proof and the [carrier support record](canonical_ten_nonisotropic_trace_defect_support.md). The support argument uses only ℓ(q1)≠ZERO, degD_J=THREE and the original full infinity fibers, not the classification of nonisotropic rankTWO planes. This theorem retains that exact support ledger explicitly and imports no rankTWO plane marking.
