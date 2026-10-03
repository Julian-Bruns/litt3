# Proof: all odd and zero boundary square coefficients contradict the positive sign

Version1,3 October2026. Independently accepted in the [signed-packet audit](../../Research/audits/Q0_DEGREE_SIX_SIGNED_ELLIPTIC_PACKETS_AUDIT_2026_10_03.md); see the [statement](../../Theorems/cartier_and_spin/actual_q0_tensor_degree_six_positive_involution_exclusion.md).

Use the genuine signed ONE-uniform [elliptic reduction](actual_q0_tensor_degree_six_one_uniform_elliptic_reduction.md), with η=ONE. Put ℓ=λ²,A=ℓ+ONE,C=ONE−TWO ℓ. The actual supersingular source forces ℓ²=TWO. Its quartic is Φ=A(t4+ONE)+Ct2. Put u=a+a^-1,v=a−a^-1,U=u²,V=v²,W=uv, so U−V=FOUR. The second actual x-map is
\[
x_2=E+B_oY,\qquad E=\lambda(vt-u)(t^2-1)/2,\qquad B_o=(ut-v)/2.
\]
The invariant differential dt/Y is nowhere zero. All finite indices of the actual x-map are ONE orTHREE, so its differential has only even finite zero orders. Its polynomial derivative norm must therefore be a square. Write
\[
N=D_o^2-(E')^2\Phi,\qquad
D_o=B_o'\Phi+B_o\Phi'/2
=4uAt^4-vAt^3+uCt^2+2vCt+3uA.
\]
The actual own-triple leading open is J=FOUR ℓ+U≠ZERO. Direct multiplication, reducing ℓ²=TWO, gives
\[
n_8=AJ,\quad n_0=4n_8,\quad n_7=n_1=2WA,
\quad n_5=W(3\ell-1),\quad n_3=W(3+4\ell).
\]
For the zero boundaries the needed coefficients are
\[
n_6=3UAC+VA^2-V\ell C-(U+V)\ell A,
\quad n_2=4VC^2+UAC-4V\ell C-(U+V)\ell A.
\]
These are identities, not evaluations at finite candidates. Since n8≠ZERO, divide the square root by its leading coefficient and write
\[
N/n_8=(t^4+gt^3+ht^2+jt+s)^2,\qquad s^2=4.
\]
If W≠ZERO, comparison gives g=W/J≠ZERO and
\[
js=g,\quad j+gh=g(3\ell-1)/(2A),
\quad gs+hj=g(3+4\ell)/(2A).
\]
Thus j=g/s and h=(THREE ℓ−ONE)/(TWO A)−ONE/s. Substitute in the last equation and use s²=FOUR. The exact resulting relation is
\[
\ell+2=s(2\ell+1).
\]
For s=TWO it forces ℓ=ZERO, incompatible with ℓ²=TWO. For s=THREE it forces TWO=THREE. This deletes the entire nonzero W case without inverting λ-sign or choosing an a-root.

If u=ZERO, U=ZERO,V=ONE. Then n6=ZERO while n2=FOUR ℓ≠ZERO. The square has g=j=ZERO; n6=ZERO forces h=ZERO and then n2=ZERO, a contradiction.

If v=ZERO, U=FOUR,V=ZERO. Here n6/n8=THREE and n2/n8=(ONE+TWO ℓ)/A. The square has g=j=ZERO and h=FOUR. Its n2 coefficient requires
\[
1+2\ell=3s(\ell+1).
\]
For s=TWO this forces ℓ=ZERO; for s=THREE it forces ℓ=ONE. Both contradict ℓ²=TWO. The cases u=v=ZERO cannot occur because U−V=FOUR.

Thus every positive-sign physical parameter is impossible. Only genuine own-pole and ordinary-source opens were used. The proof does not remove a zero boundary on an unsupported nonvanishing claim and retains both actual original X-maps through the joint-source reduction. A separate new bounded coefficient certificate may corroborate these identities but is not needed to obtain the hand contradiction.
