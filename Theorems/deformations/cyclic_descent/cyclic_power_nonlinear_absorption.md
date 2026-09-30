# Nonlinear absorption and exact carries for cyclic powers

Version4,2026-09-14. Let p be prime, h≥1, p>2h, a≥1, q=p^a,
O=Z/p^(a+1), K a free O-module, and M=Fun(Z/q,K).
Write e=sigma−1 for sigma f(s)=f(s+1). Let A:M→M be additive
and deck-equivariant, with A modp=e^h. Mixed coefficient operators
are permitted; coefficient Frobenius is transported into the source.

Let Q_d:M→M be deck-equivariant and a finite sum of diagonals of
d-additive maps of underlying Z/p^(a+1)-modules. Those presentations
need not be equivariant; no division by d! is required. Let m≥1 be
an integer. Write Neta for the constant function eta∈K, equivalently
its group-ring norm under the regular-module identification, and set

    Ay=Neta+sum_(d=2)^(1+floor(a/m)) p^(m(d−1)) Q_d(y).    (*)

Assume m≥2, or m=1 with p>3h. When eta∈pK, the latter bound may
be relaxed to p>3h−2. Put C=eta modp. Then every leading value

    y0=C e^(q−h−1)+sum_(i=1)^h D_i e^(q−h−1+i), D_i∈K/pK,

has partial solutions of (*) modulo p^a. For every such solution,
the residual p^a r of any terminal representative has exact class

    [r modp]=−U_h(e)(C+sum_(i=1)^(h−1)D_i e^i) in (K/pK)[e]/e^h,
    U_h(e)=sum_(i=0)^(h−1)(−1)^i e^i/(i+1).

It extends fully exactly when C=D_1=...=D_(h−1)=0. Thus full
solutions force eta∈pK, and for such eta their leading reductions
are precisely the invariant submodule (K/pK)e^(q−1). The statement includes
a=1 and empty nonlinear sums. No free intermediate repair changes
the terminal class.

For p=5,h=2 the class is −C−(2C+D_1)e and the hypotheses reduce
to the original alternatives eta∈5K or m≥2. For h=1,p≥5 there is
no restriction on eta even at m=1. The coefficient-module form
includes K=W_(a+1)(k)^r for every perfect field k of characteristic p.

The proof uses binomial interpolation and integral degree estimates.
It is an algebraic result for (*); identifying such an equation with
an actual geometric comparison is a separate obligation.

[Proof](../../../Proofs/deformations/cyclic_descent/cyclic_power_nonlinear_absorption.md).
