# Nonlinear absorption and exact carries for cyclic powers

Version3,2026-09-13. Let k be perfect of characteristic p, h≥1,
p>2h, a≥1, q=p^a, O=W_(a+1)(k), and M=Fun(Z/q,O).
Write e=sigma−1 for sigma f(s)=f(s+1). Let A:M→M be additive
and deck-equivariant, with A modp=e^h. Mixed coefficient operators
are permitted; coefficient Frobenius is transported into the source.

Let Q_d:M→M be deck-equivariant and a finite sum of diagonals of
d-additive maps of underlying Z/p^(a+1)-modules. Those presentations
need not be equivariant; no division by d! is required. Write Neta
for the constant function eta, equivalently its group-ring norm, and set

    Ay=Neta+sum_(d=2)^(1+floor(a/m)) p^(m(d−1)) Q_d(y).    (*)

Assume either m≥2, or m=1 with eta∈pO and p>3h−2. Put C=eta modp.
Then every leading value

    y0=C e^(q−h−1)+sum_(i=1)^h D_i e^(q−h−1+i)

has partial solutions of (*) modulo p^a. For every such solution,
the residual p^a r of any terminal representative has exact class

    [r modp]=−U_h(e)(C+sum_(i=1)^(h−1)D_i e^i) in k[e]/e^h,
    U_h(e)=sum_(i=0)^(h−1)(−1)^i e^i/(i+1).

It extends fully exactly when C=D_1=...=D_(h−1)=0. Thus full
solutions force eta∈pO, and for such eta their leading reductions
are precisely the invariant line k e^(q−1). The statement includes
a=1 and empty nonlinear sums. No free intermediate repair changes
the terminal class.

For p=5,h=2 the class is −C−(2C+D_1)e and the hypotheses reduce
to the original alternatives eta∈5O or m≥2.

The proof uses binomial interpolation and integral degree estimates.
It is an algebraic result for (*); identifying such an equation with
an actual geometric comparison is a separate obligation.

[Proof](../../../Proofs/deformations/cyclic_descent/cyclic_power_nonlinear_absorption.md) ·
[General-order audit](../../../Research/audits/GENERAL_CYCLIC_ORDER_AUDIT_2026_09_13.md) ·
[Original audit](../../../Research/audits/CYCLIC_POWER_NONLINEAR_ABSORPTION_AUDIT_2026_09_10.md) ·
[Second-order carry audit](../../../Research/audits/CYCLIC_UNRESTRICTED_NORM_AUDIT_2026_09_13.md).
