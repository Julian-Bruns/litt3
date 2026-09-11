# Nonlinear integral absorption for every cyclic power of five

Version1,2026-09-10. Proved; fresh bounded audit PASS by
/root/audit_uniform_nonlinear_absorption. Audited prose, not Lean.

Let k be perfect of characteristic5, a>=1, q=5^a, O=W_(a+1)(k),
M=Fun(Z/q,O), e=sigma-1 for sigma f(s)=f(s+1). Let A:M→M be
additive and deck-equivariant, with A mod5=e². Mixed coefficient
operators are permitted; coefficient Frobenius has been transported
into the source once.

Let Q_d:M→M be deck-equivariant and a finite sum of diagonals of
d-additive maps of underlying Z/5^(a+1)-modules. The presentations
themselves need NOT be equivariant. No division by d! is required.

1. Every actual solution of

       Ay=sum_(d=2)^(a+1)5^(d-1)Q_d(y)

   reduces to the invariant line kB_0=k e^(q-1).

2. For m>=2, every actual solution of

       Ay=N eta+sum_(d=2)^(1+floor(a/m))5^(m(d-1))Q_d(y)

   has eta∈5O and reduction in kB_0. Here N eta is the constant
   function eta, equivalently the group-ring norm of a cyclic basis
   coefficient. An empty nonlinear sum is allowed.

The proof uses combined binomial-degree bounds and integral absorption:
initial error sum5^jP_(3j-1) has preimages in sum5^jP_(3j+1);
later error sum5^jP_(2j+4-2m) has preimages in sum5^jP_(2j+6-2m).
The correcting input is divisible by5, so its leading digit is unchanged.

This is an algebraic theorem about the stated nonlinear equations.
It does not identify an arbitrary higher inverse-Cartier comparison
with those equations, assert that every invariant leading input has
a solution, or prove unmarked common-cover nonexistence.

[Proof](../Solutions/Sol_cyclic_power_nonlinear_absorption.md) ·
[Audit](../Research/audits/CYCLIC_POWER_NONLINEAR_ABSORPTION_AUDIT_2026_09_10.md).
