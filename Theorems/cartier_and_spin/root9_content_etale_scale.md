# Étaleness selects one scale at a root-nine content endpoint

Version1, 29 September2026. Consider an actual admissible degree-ten
étale cover in the fixed root-nine coefficient family. At an endpoint
x=b of t, use the regular local coordinate T=x-b and the translated
and rescaled primitive W. Write its local equation, up to a unit, as
\[
F_\mu(T,W)=\mu V(T)\Phi(T,W)^2+\Phi(T,W)S(T,W)+E(T),
\quad\Phi=W^5+\phi(T),
\quad S=g_0W^3+g_1W^2+g_2W+g_3.
\]
These are the actual source coordinates; V(0) is nonzero. Put
\[
\phi=mT^3+m_1T^4+O(T^5),\quad
A=3g_0(0),\quad B=2g_1(0),\quad C_i=[T^i]g_2,
\quad D_i=[T^i]g_3,\quad B_1=2[T]g_1,
\]
where m and D0 are nonzero, g2(0)=0, and the source identities give
ord(phi*g3+E)>=5. Let ell0 and ell1 be the coefficients T5 and T6
of phi*g3+E. Suppose this is a content point and B is nonzero.
Set omega=-C1/B. Then necessarily
\[
D_0\omega^5-\frac{mB}{2}\omega^2+\ell_0=0,
\]
and the scale of the actual étale cover is uniquely
\[
\mu=-\frac{
\ell_1+D_1\omega^5+(mC_2+m_1C_1)\omega
 +(mB_1/2+m_1B/2)\omega^2+(mA/3)\omega^3
}{V(0)m^2}.
\]
Thus the other three possible square-norm scale values cannot support
an actual étale cover unless they coincide with this one. Cancellation
of odd discriminant orders between different points or different
collisions cannot replace this necessary local splitting condition.

Using the first identity eliminates omega5. In the endpoint ratio
coordinates H,Z, the resulting homogeneous scale has numerator
H/Z degrees at most(8,60) and denominator degrees at most(6,55).
This improves the direct presentation of degrees(12,90) and(10,85).
On the content curve the two presentations agree exactly. No whole
content curve, square locus, or common-cover problem is excluded.

[Proof](../../Proofs/cartier_and_spin/root9_content_etale_scale.md).
