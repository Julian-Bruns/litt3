# Proof: the trivial common class has two inconsistent sign systems

Version1,3 October2026. Independently accepted in the [whole degree-four audit](../../Research/audits/Q0_TENSOR_DEGREE_FOUR_WHOLE_RECOGNITION_AUDIT_2026_10_03.md). This proves only a necessary-equation stratum exclusion, not the whole elliptic case.

Retain the actual [elliptic coprime normal form](actual_q0_tensor_degree_four_elliptic_hyperelliptic_form.md). Scale both centered X-coordinates by a common square root of D and scale L,y accordingly. This makes D=ONE and preserves the tensor derivative ratio, all poles and branch Sidon input. No fixed-P coefficient is used in this gate. Write
\[
c=z+u,\quad b=vz+w,\quad L=l_1z+l_0,\quad A=cL,\quad B=bL,
\qquad \Phi=z[L^2+(z-\omega^2)(z-a)].
\]
Here ω²+ω+1=0 and a=ω²w². At z=1 choose the sign of y so b(1)=c(1). At z=ω the second sign δ is ±ONE. Every coprime case therefore occurs in exactly one of the two retained formulas
\[
v=[\delta\omega^2(\omega+u)-(1+u)]/(\omega-1),\quad w=1+u-v,
\qquad (\omega-1)^{-1}=3\omega+1.
\]
Let Q0=z−a, and set b_a=va+w,c_a=a+u. They are nonzero. The point Q is non-Weierstrass, so Φ(a)=aL(a)²≠0. Define the derivative numerators
\[
U=A'zQ0-A(2z-a),\quad C=B'Q0-B,
\]
\[
V=(b'\Phi+b\Phi'/2)Q0-b(3\Phi-2a\Phi/z),
\qquad W=(c'\Phi+c\Phi'/2)Q0-c\Phi.
\]
With the nowhere vanishing elliptic derivation δ0=y d/dz, the derivatives of X1,X2 have numerators V+yU and W+yC, and their denominators are squares. The actual index-ONE/THREE ramification gives even derivative divisors. Their norms are therefore polynomial squares:
\[
V^2-\Phi U^2=H_1^2,\qquad W^2-\Phi C^2=H_2^2.
\]
Choose H_i with the leading sign of V,W. Set G1=V+H1,G2=W+H2 and F1=V−H1,F2=W−H2. Their rational square classes represent the derivative classes because (V+yU+H1)²=2G1(V+yU), and similarly for the second derivative. The equality of actual tensor directions makes these two classes identical on B.

The coefficient B2 cannot vanish. Otherwise C is constant. If C=0 then B is a multiple of Q0 and the even part of X2 is constant, contrary to the branch Sidon consequence. If C≠0 then F2G2=ΦC² has degree THREE, whereas G2 has degree FOUR and nonzero leading coefficient3Φ3. This is impossible. Hence v,l1 are nonzero. Consequently G1 also has degree FOUR, with leading coefficient4vΦ3.

If the common derivative class were trivial, G1,G2 would be polynomial squares over k. The alternative rational representative Φ times a square is excluded by their even degree at infinity. The product identities and degree FOUR then force
\[
G_1=k_1U^2,\quad G_2=k_2C^2.
\]
Cancellation at the conjugate of Q gives U(a)²=b_a²Φ(a), C(a)²=c_a²Φ(a). Both derivatives have a simple pole at Q, so their norm squares vanish at a and G1(a)=−b_aΦ(a), G2(a)=−c_aΦ(a). Thus k1=−1/b_a,k2=−1/c_a. In particular U has degree TWO. The following TWO polynomial identities are necessary:
\[
U^2+b_a(2V+b_a\Phi)=0,\qquad
C^2+c_a(2W+c_a\Phi)=0.
\]
The second may equivalently use 2W+c_aΦ=Q0 c Φ′−c_aΦ. Both identities have degree at most FOUR, giving TEN coefficient equations.

The exact nonzero open used in the test is the product of
\[
a,w,b_a,c_a,v,l_1,l_1^2+1,l_0^2+\omega^2a,L(a),l_0+(u+a)l_1.
\]
Each factor has just been justified by actual poles, smoothness, non-Weierstrass Q or degree FOUR of G1. No condition u≠0 is imposed. The final factor is the negative leading coefficient of U. Smoothness of the remaining roots of Φ was not imposed; omitting that open only enlarges the necessary locus.

The fresh [source](../../scripts/genus_two/oct03_q0_degree_four_elliptic_trivial_class_gate.py) derives these equations exactly in characteristic FIVE, reduces ω²+ω+1, and tests the ideal of the ten coefficients, ω²+ω+1 and inv·open−1. For BOTH δ=±ONE the working SymPy GF(5) grevlex basis is [ONE]. The total mathematical phase took1.675432 seconds with a three-second cap and one core. The [receipt](../../../litt3-computation-data/oct03_q0_degree_four_elliptic_trivial_class_gate/gate_sympy.json) records every coefficient and open, plus both bases. The initial Homebrew Singular launch failed before mathematics because its libflint dependency was absent; its separate raw launch files and receipt are retained but supply no mathematical claim. The successful run used the same equations and performed no parameter sweep.

The unit ideals exclude the trivial common class in both sign families. They say nothing about the three two-root classes or the proportional normal form. No map from the original Y-leg has been replaced.
