# Proof: all principal coefficients agree before the first fixed-P correction

Version1,3 October2026. Frozen pending independent review; see the [statement](../../Theorems/cartier_and_spin/actual_q0_tensor_common_triple_infinity_jet.md).

The actual coarse tensor equality is equality up to a constant of
\[
T_i(x_i)\,dx_i^3,\qquad T_i(x)=q_i(x)^8/P_i(x)^2.
\]
After the common centered scale and the retained independent sign, each fixed copy still has the same leading asymptotic $T_i(x)=x^{-4}(1+O(x^{-1}))$, up to its constant normalization. These constants are incorporated in the given tensor ratio; every correction starts at order THREE in a local parameter at a triple pole.

Choose an ACTUAL uniformizer u on B at Q, with no extraction of a cube root, and write
\[
x_i=l_i u^{-3}+m_i u^{-2}+n_i u^{-1}+O(1),\qquad l_i\ne0.
\]
Put M=mi/li,N=ni/li. In characteristic FIVE,
\[
x_i^{-4}=l_i^{-4}u^{12}[1+Mu+Nu^2+O(u^3)],
\]
and $dx_i=(2l_i u^{-4}+3m_i u^{-3}+4n_i u^{-2}+O(1))du$. Cubing and multiplying gives exactly
\[
T_i(x_i)dx_i^3=\frac3{l_i}
\left[1+3\frac{m_i}{l_i}u+2\frac{n_i}{l_i}u^2+O(u^3)\right]du^3.
\]
The mixed squared-M terms cancel in the coefficient of u². Fixed-P and fixed-q corrections occur only at order THREE or later, and do not enter either displayed coefficient.

Proportionality of the TWO original tensors first fixes ρ=l2/l1, then forces m2/l2=m1/l1 and n2/l2=n1/l1. Thus m2=ρm1,n2=ρn1 and ξ=x2−ρx1 is regular at Q. With q=xi²+ONE,
\[
\frac{q(x_2)}{q(x_1)}-\rho^2
=\frac{2\rho x_1\xi+\xi^2+1-\rho^2}{x_1^2+1}
\]
has order at least THREE, since the numerator has order at least−THREE and the denominator exactly−SIX. Its residue is ρ², so z(Q) is nonzero. The cubic map on z is étale there: THREE z(Q)² is a unit. Consequently the same order bound holds for z−z(Q). If z is nonconstant, that is its local map index and is at most its global degree. A degree-TWO map is impossible.

All calculations are on the actual coarse field of the original two-map span. No local inverse-cube coordinate, presumed simultaneous Galois completion or replacement source is used.
