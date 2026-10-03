# Proof: the square coefficients contradict the source Hasse coefficient

Version1,3 October2026. Independently accepted in the [signed-packet audit](../../Research/audits/Q0_DEGREE_SIX_SIGNED_ELLIPTIC_PACKETS_AUDIT_2026_10_03.md); see the [statement](../../Theorems/cartier_and_spin/actual_q0_tensor_degree_six_negative_involution_r1_exclusion.md). This is a direct hand polynomial identity. A fresh [direct multiplication certificate](../../scripts/genus_two/oct03_q0_degree_six_elliptic_involution_norm_gates.py) corroborates every displayed coefficient; its [receipt](../../../litt3-computation-data/oct03_q0_degree_six_elliptic_involution_norm_gates/gate.json) records that successful assertion without replaying older arithmetic.

In the [complete signed elliptic reduction](actual_q0_tensor_degree_six_one_uniform_elliptic_reduction.md), η=−ONE,r=ONE gives a=±ONE and x2=a(tY−L). Put
\[
\ell=\lambda^2,\quad m=\mu^2,\quad
A=\ell+1,\quad B=2\lambda\mu,\quad C=m-2\ell+1.
\]
Then
\[
\Phi=A(t^4+1)+B(t^3-t)+Ct^2.
\]
Ordinary ZERO/infinity require A≠ZERO. Cartier ZERO on the actual supersingular source gives
\[
I=\ell^2+3\ell m+m^2+2m+3=0.
\]
Every actual xi has local indices ONE orTHREE. The invariant differential σ=dt/Y has no zeros on the elliptic B, and dx2/σ has finite zeros of even order TWO only. Its norm under the degree-TWO t-map therefore has only even finite zero orders. Since x2 has exact triple poles at BOTH ordinary infinity points, this norm is a polynomial of degree EIGHT with nonzero leading coefficient and must be a square over the algebraically closed field.

Ignoring the irrelevant a²=ONE, the polynomial is
\[
N=(\Phi+t\Phi'/2)^2-(2\lambda t+\mu)^2\Phi.
\]
Direct differentiation in characteristic FIVE gives $\Phi+t\Phi'/2=3At^4+2Ct^2+Bt+A$. Write N=Σ n_jt^j. The needed coefficients are
\[
n_8=4A^2,\quad n_7=0,\quad n_6=A(2C-4\ell),\quad n_5=4B,
\]
\[
n_3=B(m+2),\quad n_1=mB,\quad n_0=A(A-m),
\]
and for the ZERO cases
\[
n_4=4C^2+A^2-4\ell C-2B^2-mA,\quad
n_2=3B^2+4A(C-\ell)-mC.
\]
These identities follow by multiplying the two displayed squares; no evaluation at finite parameters is used.

Choose the square root's sign so its leading coefficient is TWO A. Comparing n7,n6,n5 forces its form
\[
Q=2At^4+q_2t^2+q_1t+q_0,\quad
q_2=3(m+A),\quad q_1=B/A.
\]
Assume first B≠ZERO, so λμ≠ZERO. The n3 coefficient gives $q_2=3A(m+2)$, hence $\ell m=-A$. The n1 coefficient gives $q_0=3mA$. The constant coefficient then gives
\[
4m^2A=A-m.
\]
Substitute $m=-A/\ell$; both ℓ and A are nonzero. Cancellation yields FOUR A=ℓ, so ℓ=TWO and m=ONE. But the source Hasse expression at these values is I=ONE, a contradiction.

If λ=ZERO, then ℓ=ZERO,A=ONE,B=ZERO,C=m+ONE. The square has q1=ZERO,q2=THREE C, while n4 forces q0=FOUR(ONE−m). Its constant coefficient requires $(1-m)^2=1-m$, hence m=ZERO orONE. The source I is respectively THREE orONE, again nonzero.

If μ=ZERO, then m=ZERO,B=ZERO and I=ZERO gives ℓ²=TWO. The square has q1=ZERO,q2=THREE A. Its n2 coefficient gives q0=FOUR+THREE ℓ. The constant coefficient q0²=A² now implies ONE+TWO ℓ=ZERO, hence ℓ=TWO, incompatible with ℓ²=TWO. This also covers both λ signs. The overlap λ=μ=ZERO was already excluded by I≠ZERO.

Thus no physical parameter in the ENTIRE stated packet survives the necessary source Cartier and ramification conditions. The proof never discards a ZERO λ or μ boundary, assumes a full fixed-P cube identity from a norm square, or replaces an original source leg. The OTHER signed packets remain outside its conclusion.
