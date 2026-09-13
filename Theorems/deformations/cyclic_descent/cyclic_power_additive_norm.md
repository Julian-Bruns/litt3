# Cyclic-power norm obstruction for mixed additive operators

Version3,2026-09-13. Let p be prime, h≥1, p>2h, a≥1 and q=p^a.
Put O=Z/p^(a+1), let K be a free O-module of arbitrary rank, and define

    F=(1+e)^q−1,       N=F/e,       M=K[e]/F K[e].

Let Phi be an O-linear automorphism of K, acting coefficientwise.
Suppose L:M→M is additive, commutes with e, and reduces modulo p
to e^h Phi. Put A=L Phi^-1. Then:

1. L(x)=N eta is soluble exactly when eta∈pK. In that case the
   reductions of all solutions are precisely e^(q−1)(K/pK).
2. The coefficient remainder of degree<h gives the O-module form

       coker A ≅ K ⊕ ⊕_(i=1)^(h−1) e^i(K/p^aK),
       [N eta]=(p^a eta,0,...,0).

   For rank(K)=f finite, A has f(q−h) unit Smith factors,
   f(h−1) factors p^a and f zero factors. The infinite-rank
   conclusion uses a direct kernel argument, not dimension counting.
3. Define the truncated logarithmic unit

       U_h(e)=sum_(i=0)^(h−1) (−1)^i e^i/(i+1).

   If A y−Neta=p^a r and

       y modp=C e^(q−h−1)+sum_(i=1)^h D_i e^(q−h−1+i),
       eta modp=C,

   then in (K/pK)[e]/e^h the exact terminal carry is

       [r modp]=−U_h(e)(C+sum_(i=1)^(h−1)D_i e^i).

   It depends only on these leading coefficients. For L, use y=Phi(x).

At p=5,h=2 this is −C−(2C+D_1)e; the only unrestricted leading
coefficient of a full solution is the socle coefficient D_2.
Taking K=W_(a+1)(k) for perfect k and Phi equal to Witt Frobenius
allows arbitrary mixed coefficient-linear and coefficient-Frobenius
corrections. No W_(a+1)(k)-semilinearity of L is required.

This is a module theorem. A geometric application must supply the
actual additive comparison and account for its nonlinear repair terms.

[Proof](../../../Proofs/deformations/cyclic_descent/cyclic_power_additive_norm.md) ·
[General-order audit](../../../Research/audits/GENERAL_CYCLIC_ORDER_AUDIT_2026_09_13.md) ·
[Original preparation audit](../../../Research/audits/CYCLIC_POWER_ADDITIVE_PREPARATION_AUDIT_2026_09_10.md) ·
[Exact diagnostic](../../../scripts/deformations/cyclic/verify_general_cyclic_order.py).
