# The remaining canonical degree42 profiles have a bounded Frobenius normal form

Version1,3 October2026. Exact normal-form lemma passed [independent review](../../Research/audits/CANONICAL_DEGREE_FORTY_TWO_FROBENIUS_NORMAL_FORM_AUDIT_2026_10_03.md).

Retain the actual faithful canonical degree42 spin carrier and BOTH actual finite étale endpoint maps from the SAME source. Use its actual normalized generators F,G,H and Weierstrass point P. Suppose the distinguished stabilizer order is ONE, TWO or THREE. On Y:y²=Φ(z), P=∞, write σ=dz/y and retain the exact identities
\[
H^2=\alpha F^7+\beta G^3,\qquad d(FG)=cH\sigma,
\qquad \alpha\beta c\ne0.
\]
The pole orders of F,G,H are respectively(6,14,21),(6,14,19) or(6,12,21), and F has six distinct simple zeros. The remaining case has F=U3+v y, v≠0.

There exist a polynomial B of degree at most FIVE and functions J∈H0(O_Y(9P)), K∈H0(O_Y(12P)), with
\[
R_0=vz+yB(z),\qquad dR_0=F\sigma,
\]
such that
\[
GH=\alpha cF^5R_0+J^5,
\qquad (FG)^2=\alpha c^2F^5R_0^2+2cJ^5R_0+K^5,
\qquad G=\beta^{-1/5}(J^2-\alpha^{1/5}FK).
\]
Here the constant fifth roots are unique in the algebraically closed field. The polynomial relation for B is U3=ΦB'+Φ'B/2. Thus J=A4+yB2 and K=A6+yB3 belong to explicit finite coefficient spaces; no other poles or affine charts are omitted.

These are necessary exact identities on the ACTUAL endpoint, not an existence or whole-profile exclusion. BACKUP noninvariant-F cases remain open. Both original maps are preserved.

[Proof](../../Proofs/cartier_and_spin/canonical_degree_forty_two_frobenius_normal_form.md).
