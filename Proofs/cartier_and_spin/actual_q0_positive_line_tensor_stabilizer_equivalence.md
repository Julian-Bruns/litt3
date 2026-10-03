# Proof: reduced zeros remove the fifth-power ambiguity

Version1,3 October2026. [Statement](../../Theorems/cartier_and_spin/actual_q0_positive_line_tensor_stabilizer_equivalence.md). [Focused whole review PASS](../../Research/audits/Q0_POSITIVE_LINE_AND_OPPOSITE_INTERPOLATION_AUDIT_2026_10_03.md). No computation or new endpoint refinement is used.

Let H_i be the reduced original infinity fiber. Since the actual map h_i is étale, div(θ_i)=16H_i and div(u_i)=H_i. The quadratic q_i has divisor D_i−6H_i, where D_i is reduced because q0 is squarefree and disjoint from the cubic branch roots. Therefore
\[
\operatorname{div}(b_i)=D_i,
\qquad q_i\theta_i=b_i u_i^{10}=b_i t_i^5.
\]
This also verifies the eight-spin convention directly. The sections b_i are nonzero sections of the SAME line M³, so b_i/b_j is a genuine function on T.

The generic scalar field for B_T=F_*O_T/O_{T^(1)}, identified with locally exact differentials, acts through fifth powers in k(T). Consequently its two generic lines agree exactly when the ratio of their differential generators is a fifth power. Saturated integral lines agree exactly when their generic lines agree. Since
\[
\frac{q_i\theta_i}{q_j\theta_j}
=\frac{b_i}{b_j}\left(\frac{u_i}{u_j}\right)^{10},
\]
line equality is equivalent to b_i/b_j being a fifth power.

Every coefficient of div(b_i/b_j)=D_i−D_j belongs to {−1,0,1}. A fifth-power function has all divisor coefficients divisible by FIVE. Thus all these coefficients are zero. A nonzero function with zero divisor on the smooth projective connected T is a constant. Hence A_i=A_j implies b_i/b_j∈k× and therefore τ_i∼τ_j.

Conversely τ_i∼τ_j says (b_i/b_j)⁸ is constant, which forces b_i/b_j itself to be constant. Constants have fifth roots because k is algebraically closed. The displayed ratio is then a fifth power, proving A_i=A_j. This proves both implications without assuming a simultaneous Galois closure or a constant Cartier frame.

Apply the equivalence to an actual source automorphism and its conjugate map. It identifies the line stabilizers. Exact invariance of τ is the additional requirement that its scalar character be ONE. No opposite differential is produced: the original q0dx is not a regular section of B_X, and an arbitrary symplectic complement to the positive line does not identify its meromorphic pullback or its Petri image.
