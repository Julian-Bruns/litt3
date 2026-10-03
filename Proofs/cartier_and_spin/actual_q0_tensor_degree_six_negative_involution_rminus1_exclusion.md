# Proof: the single rational norm parameter has no physical source-Cartier root

Version1,3 October2026. Independently accepted in the [signed-packet audit](../../Research/audits/Q0_DEGREE_SIX_SIGNED_ELLIPTIC_PACKETS_AUDIT_2026_10_03.md); see the [statement](../../Theorems/cartier_and_spin/actual_q0_tensor_degree_six_negative_involution_rminus1_exclusion.md).

Use the actual signed [elliptic reduction](actual_q0_tensor_degree_six_one_uniform_elliptic_reduction.md) with η=−ONE,r=−ONE. Both a²=−ONE roots are retained and x2=a(tL+Y). Write ℓ=λ²,m=μ²,A=ℓ+ONE,B=TWO λμ,C=m−TWO ℓ+ONE, so Φ=A(t4+ONE)+B(t3−t)+Ct2. The genuine opens are ℓ≠ZERO from the own-triple leading product and A≠ZERO from ordinary ZERO/infinity. The actual source condition is
\[
I=\ell^2+3\ell m+m^2+2m+3=0.
\]
As in the [r=ONE proof](actual_q0_tensor_degree_six_negative_involution_r1_exclusion.md), actual finite ramification indices ONE orTHREE force the degree-EIGHT derivative norm to be a square. Ignoring the harmless a² scalar, this norm is
\[
N=(\Phi'/2)^2-(3\lambda t^2+2\mu t-\lambda)^2\Phi.
\]
The coefficient identities needed here are
\[
n_8=\ell A,\quad n_7=4B,\quad
n_6=3\ell^2+3\ell m+m+4,\quad n_5=2B,
\]
\[
n_3=B(4m+2),\quad n_1=B(4m+1),\quad
n_0=\ell(m-A),\quad
n_2=m^2+2\ell^2+2\ell m+3m+\ell+1.
\]
Direct polynomial multiplication asserts all N coefficients in the fresh [source](../../scripts/genus_two/oct03_q0_degree_six_elliptic_involution_norm_gates.py), including n4=m²+FOUR ℓm+TWO ℓ+FOUR. This is not a replay of a settled calculation.

If μ=ZERO, I gives ℓ²=TWO. The odd coefficients vanish and n6=ZERO,n2=ℓ≠ZERO. An even quartic square root has zero t2 coefficient from n6, then zero n2, a contradiction. λ=ZERO is outside the genuine own-pole open, so all remaining cases have B≠ZERO.

Choose p²=ℓA and normalize the square root as p(t4+gt3+ht2+jt+s). Its odd coefficients imply
\[
g=2B/(\ell A)\ne0,\quad j+gh=3g,\quad
js=g(m+4),\quad gs+hj=g(m+3).
\]
Set k=THREE−h. Then j=gk,m=sk+ONE and
\[
s=(k^2-3k-1)/(1-k),\qquad s^2+1=m/A.
\]
The case k=ONE contradicts the same odd equations. The case s=ZERO gives m=ONE from n1 and m=A from n0, forcing ℓ=ZERO. Since μ≠ZERO, m≠ZERO, so s²+ONE≠ZERO as well. Therefore every physical solution admits the following rational parametrization, retaining k=ZERO:
\[
d=1-k,\quad n=k^2+2k+4,\quad M=k^3+2k^2+3k+1,
\quad Z=n^2+d^2,
\]
\[
A_n=Md,\quad L=A_n-Z,\qquad
s=n/d,\quad m=M/d,\quad A=A_n/Z,\quad\ell=L/Z.
\]
The five physical opens are d,n,Z,M,L≠ZERO. They follow respectively from k≠ONE,s≠ZERO,s²+ONE≠ZERO,m≠ZERO,ℓ≠ZERO; no extra discriminant or branch-value condition is saturated. Explicitly
\[
Z=k^4+4k^3+3k^2+4k+2,\quad
L=3k^4+k^2+3k+4.
\]
Substituting into I and multiplying by Z²d² gives
\[
H=L^2d^2+3LMZd+M^2Z^2+2MZ^2d+3Z^2d^2.
\]
The n6 square coefficient, since g²=m/(ℓA²), gives n6A−m−TWO(THREE−k)ℓA²=ZERO. Multiplication by Z³d gives
\[
R=(2+2k)L^3d+(1-k)L^2Zd+3(1-k)LZ^2d+4Z^3d
+LM(3L+4Z)Z.
\]
The fresh bounded univariate certificate records and directly asserts both cleared identities, then obtains
\[
\gcd(H,R)=k^2+4k+4=(k+2)^2.
\]
Its only root is k=THREE, where Z=ZERO, outside a proven physical open. Thus no physical parameter survives. Exact Bézout weights, equation polynomials and the physical removal are retained in the [executed receipt](../../../litt3-computation-data/oct03_q0_degree_six_elliptic_involution_norm_gates/gate.json). The single worker completed the two new positive gates, this new negative gate and direct coefficient assertions in 0.070857 mathematical CPU seconds, under its ten-second hard bound, with no Gröbner basis or root search.

Both a choices and λ,μ signs are covered by the necessary relations, not identified by an unproved source automorphism. The original maps remain on the original source throughout. Only this entire signed packet is excluded; the other negative r choices still require proof.
