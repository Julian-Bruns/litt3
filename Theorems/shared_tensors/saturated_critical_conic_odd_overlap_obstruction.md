# A saturated critical conic cannot have odd common infinity

Version1, 3 October 2026. [Independent whole-scope audit PASS](../../Research/audits/OCT03_NONSPLIT_RESIDUAL_TWENTY_ALL_DEGREE_PARITY_WHOLE_AUDIT_2026_10_03.md), with no required corrections.

Let C be smooth projective over an algebraically closed field of characteristic different from two. Let d0≠0 and actual rational functions A,B,z, with z nonconstant, satisfy
\[
B^2+d_0=z^3(A^2+d_0),\qquad
\operatorname{div}(z)=2D_1-2D_2,
\]
with D1,D2 reduced and disjoint. Suppose the exact poles of A and B are respectively3(J+D1) and3(J+D2), with J reduced and disjoint from both D_i. Require that z³−1 has no zeros outside J, and that B/A has leading value ONE at every point of J. Then deg(J) is even.

Indeed H=(d0−AB)/(A+B) has exact pole divisor3J and satisfies H²+d0=z³F², with F=(B−A)/(z³−1). The even divisor of z makes both distinct fibers H=±sqrt(−d0) have even multiplicities, so their degree3deg(J) is even. This includes inseparable H and requires no curve map to descend.

[Proof](../../Proofs/shared_tensors/saturated_critical_conic_odd_overlap_obstruction.md).
