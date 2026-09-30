# Proof: Frobenius on the twelve marked points

[Statement](../../Theorems/cartier_and_spin/marked_support_five_saturation.md).
Write pi for25-Frobenius and gamma(x,y)=(x,[11]y). Let alpha be a
root of A in E=F_(5^8), and rho3=P(alpha). The fixed exact arithmetic gives
P(alpha)^((5^8-1)/3)=[11]. Thus pi4 fixes alpha and sends rho to[11]rho.
The same identity holds on all twelve marked points, and both pi and
gamma fix O. Therefore pi4=gamma on Gamma.

The quotient x:X->P1 gives1+gamma+gamma2=0 on J(X): the endomorphism
is pullback after the norm to J(P1)=0. Hence
Q(pi)=0 on Gamma, where Q(T)=T8+T4+1. The established Weil polynomial
Pi_X also annihilates pi on J(X). The integral resultant identity
therefore annihilates Gamma by

45095046841912830021622485696625833846862308638737180792041321268886159213510179436939976808107828897.

Its residue modulo five is2. The group Gamma is finitely generated
and killed by this nonzero integer, so it is finite and has no
five-primary torsion. In particular5[D]=0 for a degree-zero divisor
supported on Z union{O} forces[D]=0.

If div(g)=5D, D has degree zero and its class belongs to Gamma.
Thus D is principal, say D=div(h). Properness gives g/h5 in k*,
and the algebraically closed constant field contains a fifth root
of that constant. This proves1.

For2, divide g by product_i(x-alpha_i)^(e_i). The exponents at all
finite points are nonnegative and divisible by five. The exponent
at O is divisible by five by the degree-zero identity. Part1 gives
the claimed fifth root h. The finite valuations of h remain
nonnegative, giving the precise pole degree. If pole_O(g)<=144,
that degree is at most28. The
[complete bounded supported-norm theorem](bounded_supported_norms.md)
then makes h a polynomial in x. So is g.

## Evidence and limitations

The [small exact script](../../scripts/arithmetic/marked_support_frobenius_module_20260929.py)
checks the cubic phase, the integral resultant, and a polynomial Bezout
identity modulo five. It reuses the established Weil polynomial;
it does not recompute curve point counts or the bounded support search.
Its [receipt](../../../litt3-computation-data/conceptual_continuation_20260929/marked_support_frobenius_module.json)
records all inputs and checks. The focused independent
[logarithmic-method audit](../../Research/audits/LOGARITHMIC_PHASE_COST_2026_09_29.md)
checks this marked-subgroup deduction and its use in five-saturation.
It applies to the marked subgroup, although the full Jacobian has
positive five-rank.

This reduction cannot remove a nonzero constant phase discrepancy
across all29 phases: its total sheet discrepancy need not be zero
modulo five. That remaining branch must be retained.
