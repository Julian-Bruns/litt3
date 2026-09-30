# A scale-independent collision filter for normalized ramification

Version1,30 September2026. Fix a primitive allowed ratio in the constant
degree140 family, over a perfect field k0 containing its coefficients.
Let
\[
E_\ell=d_0+d_1\ell+d_2\ell^2,\qquad
\Delta=d_1^2-4d_0d_2,\qquad a=-d_1/(2d_2).
\]
The critical normalization C has function field k0(X)(Lambda), with
minimal equation E, and every point over O is a pole of Lambda.
Retain all geometric points of the smooth affine base X-O.

Form the finite set of points p satisfying
\[
d_2(p)\ne0,\quad 0<\operatorname{ord}_p\Delta\in2\mathbf Z,
\quad\left(\operatorname{ord}_p\Delta=2
                  \ \text{or}\ \delta_0a(p)\ne0\right).
\]
Define B(ell)=product_p(ell-a(p)), with repeated values retained. This
monic polynomial belongs to k0[ell], has degree at most136, and is
constructed once for the ratio, independently of a proposed scale.

For a nonzero geometric scale lambda, the ENTIRE normalized Lambda
fibre is ramified if and only if BOTH conditions hold:
\[
E_\lambda\mid(\delta_0E_\lambda)^2\quad\text{in }k[X-O],
\qquad B(\lambda)\ne0.
\]
Thus even total multiplicity on X is not silently substituted for
ramification of both normalized branches. All coefficient drops and
even-order critical-discriminant zeros are retained by the filter.

Equivalently, let g be the gcd of the140 consistency polynomials from
the uniform304-by164 squarefulness test on X. Remove from g every
factor supported on B, with its full multiplicity, and then take the
radical, retaining characteristic-five power factors. Removing scale
zero gives a polynomial whose roots are EXACTLY the fully ramified
nonzero scales. It has at most three distinct roots. This construction
uses the base curve and a finite value filter, rather than a computed
normalization or a doubled-different matrix.

This integrates the accepted exact local criterion into a reusable
fixed-ratio algorithm. No global parameter elimination, actual étale
cover, or common-cover decision is claimed.

[Proof and provenance](../../Proofs/cartier_and_spin/degree140_base_curve_ramification_filter.md).
