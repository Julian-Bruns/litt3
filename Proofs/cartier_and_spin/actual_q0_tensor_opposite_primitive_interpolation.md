# Proof: opposite elliptic forms lie in a source interpolation kernel

Version1,3 October2026. Pending independent review. No numerical computation is needed. The reference leg h1 only fixes the pole divisor and frame; both actual maps stay on S throughout.

Because char(k)=5, d(wi⁻⁵)=0 and QE′=q0 give
\[
d(Q_E(x_i)/w_i^5)=q_0(x_i)\,dx_i/w_i^5=dx_i/w_i^2=\lambda_i.
\]
On E the primitive QE/w⁵ has no poles except the two q0-root points, with orders at most FIVE. At infinity x and w have poles THREE and TWO; QE/w⁵ has a zero of order one. On S′ the two elliptic marked divisors are the same reduced divisor D′, by proportional η. Thus fi has poles at most5D′.

The specified w-deck scales BOTH wi by ζ and fixes S. Hence w1⁵fi has character ζ⁵ζ⁻⁵=1 and lies in k(S). Its possible finite poles along D′ cancel, so its only poles occur at the pullback of I1, with orders at most TEN. The root is unramified there; consequently Ai∈L(10I1). Also λi=w1⁻⁵dAi is regular.

At a point of D0 the actual maps to X are étale and q0 has a simple zero. The root has tame index THREE. If dA has order n on S, its pullback has order3n+2. Thus w1⁻⁵dA is regular there exactly when3n+2−5≥0, equivalently n≥1. Elsewhere away from I1 the claimed regularity is automatic. At a point of I1 a function with pole order at most TEN has differential pole order at most TEN: a possible term of order−10 differentiates to zero in characteristic five, and every remaining negative exponent is at least−9. Since w1⁻⁵ vanishes to order TEN there, regularity follows. This proves the direct and converse kernel claims.

For the converse characterization, start with a regular exact differential of deck character ζ having a primitive with poles at most5D′. Average its primitive into the ζ eigenspace using the order-three deck group. Differentiation commutes with the averaging and the pole bound is preserved. Multiplication by w1⁵ then gives an invariant function A on S, with exactly the pole and derivative bounds just proved. Zero differential means A is a fifth power J⁵ in k(S); its pole bound is equivalent to J∈L(2I1).

If dH=η1, the alternating Cartier–Petri identity C(d(Hf))=0 gives
\[
\mu(\eta_1,df)=-C(f\eta_1).
\]
For f=A/w1⁵ the product is Aq0(x1)θ1, a differential pulled from S. It is regular there: q0θ has zero divisor D0+10I1, canceling every possible pole of A. Cartier naturality under the separating root map proves the displayed original-source formula. A fifth-power ambiguity gives zero image because C(q0θ1)=0.

Taking A=Ai gives the specified elliptic Petri images. The first image is nonzero by the accepted [fixed cyclic-vector calculation](actual_q0_tensor_petri_image_recognition.md). Hence a one-dimensional image space makes the two images proportional and invokes that theorem to identify the ORIGINAL X-fields, without any claim that S′ is étale over Y.

For completeness, on X one has
\[
L(10\infty)=\langle1,x,x^2,x^3,y\rangle.
\]
At the three points above either q0 root, dx has the same nonzero x-coordinate value while d(y)=P′(x)dx/(3y²) has three distinct cube characters. P′ is nonzero at these roots by the accepted critical gate. Therefore the derivative-vanishing condition first kills the y coefficient. A degree-at-most-two polynomial derivative vanishing at the two distinct q0 roots is a scalar multiple of q0. Integration yields the stated span of1,QE. Its nonzero image is the accepted βX, up to sign. This calculation is only on X; pullback can add trace-free sections and no kernel or image bound on a general S follows from it.
