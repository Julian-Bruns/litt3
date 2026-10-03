# Polynomial companion cancellation and finite-root incidence

Version2, 30 September2026. The two tools below have explicit algebraic
and local hypotheses. No actual quartic cover is presumed to exist.

Let k be a field, epsilon nonzero, E a nonzero polynomial of degree e,
and U_i,V_i polynomials for i=1,2,3. Suppose, for integers d_i>=0,
\[
T_i=(V_i-\epsilon t^7U_i)/E\in k[t],\quad
\deg T_i\le d_i,\quad \deg U_i,\deg V_i\le e-7+d_i,
\]
and U_jV_k-U_kV_j is nonzero for every j!=k. Put
M_i=U_jT_k-U_kT_j for {i,j,k}={1,2,3}. Then M_i is nonzero and
deg M_i<=e-14+d_j+d_k. If J_i is squarefree and at every root c of
J_i the values U_j,U_k,T_j,T_k are units with
U_j(c)/T_j(c)=U_k(c)/T_k(c), then J_i divides M_i. In particular
sum_i deg J_i<=3e-42+2 sum_i d_i. The proof records a formal Laurent
companion-cancellation pattern that supplies those unit and ratio hypotheses.

For the independent local tool, work over an algebraically closed field
of characteristic five. Use [a+5b]=a+b beta, beta^2=beta+3, and
ascending rows P=(11,22,18,5,19,20,15,16,9,22,1), A=(1,21,14,22,13).
Suppose u,v,t are formal germs in k[[s]], u(0)=alpha,v(0)=gamma are
roots of P, ord(u-alpha)=ord(v-gamma)=1, t(0)=b!=0,
ord(t-b)=2, and epsilon in k* satisfies
\[
A(v)/A(u)=\epsilon^4t^{-13},\qquad
(dv/du)^3P(u)^2=\epsilon^{-17}t^{48}P(v)^2.
\]
Then alpha!=gamma. Put
H(x)=P'(x)^2A'(x)/A(x), K_*(x)=H(x)^13/A(x)^48,
R=A(gamma)/A(alpha), and h=H(gamma)/H(alpha). Necessarily
\[
\epsilon^{29}=K_*(\gamma)/K_*(\alpha),\quad
b=\epsilon^7R^{11}h^{-3},\quad b^{29}=h^4R^{-17},\quad
\epsilon b^4=hR^{-4}.
\]
The fixed exact coefficient calculation proves that the ninety ordered
off-diagonal K_* ratios are distinct and different from1. Their product
Sigma_*(Z)=product_(alpha!=gamma)(Z-K_*(gamma)/K_*(alpha)) is squarefree
of degree90, nonzero at0,1. Thus Sigma_*(epsilon^29)=0, and a fixed
epsilon permits only one ordered root pair and one b, with b^29!=1
and epsilon b^4!=1. This restricts germs satisfying these hypotheses;
it asserts no global existence, bound on other fibers, or scalar
restriction when such incidence is absent.

[Proof and exact finite arithmetic](../../Proofs/cartier_and_spin/klein_four_companion_constraints.md).
