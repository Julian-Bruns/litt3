# Removing the finite residues from the positive primitive trace

Use the notation in [the statement](../../Theorems/cartier_and_spin/degree140_infinity_residue_traces.md).
The [positive-multiplier theorem](degree140_positive_multiplier_traces.md)
already bounds the Laurent trace by exponents -1 through
floor((57+pole_O(f))/4). We prove the residue identities at a generic
ratio, and then explain their specialization. This avoids imposing a
genericity hypothesis on the final statement.

## Coefficients and the finite phi-zero contribution

Compatibility of trace and residues gives
c_n=-sum_(Lambda poles) Res(Omega_n). For n>=2 the finite-pole terms
have zero residue by the valuations in the positive-multiplier proof.
Only O4 and O7 remain. For the two lower nonnegative coefficients,
expand at a finite zero of phi at which T is a unit. Put N0=delta T+B S.
Since
\[
\delta\Lambda=2TB\phi^{-3}+(BS-\delta T)\phi^{-2}-(\delta S)\phi^{-1},
\]
expanding Lambda^{-2} through the required order gives the principal
part Psi1 for Omega1. Expanding Lambda^{-1} gives the principal part
Psi0 for Omega0. The displayed formulas follow by multiplying these
three-term expansions; the coefficient at phi^-1 combines as
((delta T-BS)+2BS)^2/T=N0^2/T. Thus the plus sign in N0 is a
consequence of the expansion, not the coefficient of delta Lambda.
Terms regular at phi=0 need not be retained.
The derivative delta S is the full derivative on C. Because S_W=0
there, it is also the coefficient derivative with W held fixed.

At W=infinity, write z=1/W. Generically a has a simple zero, and the
critical equation gives a=bz+3cz^2. Thus S has pole at most two in z,
delta S has pole at most three, and phi has pole five. Every term in
Psi0 and Psi1 is regular there. They have no other possible finite poles
apart from t=0 and the phi zeros just considered.

## Cancellation at the nine endpoint branches

At a generic t=0 endpoint, phi=t^3 J, with J a local unit. The source
congruences give phi*S+T of order at least five, hence
S=-J^{-1}+O(t^2). The derivative of a function of order at least five
has order at least five in characteristic five. Therefore
N0=-phi*delta S+O(t^5), and N0^2/(T phi) is regular.

Let k=delta(t). The sum of the first two terms of Psi0, including its
outer minus sign, is
\[
-4f\eta\frac{TB}{\phi^2}\,\delta\log J\,\omega_0.
\]
Its only possible residue is3f*eta*(delta J)/J^2, evaluated at t=0,
because B=3t^2kJ+t^3 delta J and omega0=dt/k. The remaining potentially
singular term is4f*eta*B*delta S/phi*omega0, whose residue is
2f*eta*delta S=2f*eta*(delta J)/J^2. Their sum is zero in characteristic
five. No derivative of f or eta enters: the possible poles are simple.
Psi1 is regular because ord(B^2/phi)>=1. At the other critical root
over the same endpoint phi is a unit and N0 has order at least two,
so all these forms are regular there as well.

The residue theorem now replaces the sum of Psi_i residues at finite
phi zeros by minus its residues at O4,O7. Substitution in the coefficient
formula yields the claimed expressions for c0 and c1.

## The coefficient at scale zero

Only W=infinity can contribute to c_{-1}. At a generic such point,
\[
a=bz+3cz^2,\quad \Lambda=-2bz^3+O(z^4),\quad
\eta=b+O(z),\quad\phi=z^{-5}+O(1),\quad
\delta z=(\delta a)/b.
\]
The residue of f*phi*v*dLambda is f*b^2*delta a. On X this is exactly
the residue at the corresponding zero of a of
f*b^2*(delta a)^2/a*omega0. The latter differential has no other finite
poles, since all its coefficients are regular on affine X. The residue
theorem on X gives the stated negative residue at O.

## Why exceptional ratios are included

These calculations establish identities over the rational parameter
field. Their right sides use only bounded expansions at the fixed
infinity charts. The leading units required to form those expansions
are constants, h, w and F6; all are invertible on the prescribed open.
In particular the formulas have no pole at endpoint-content loci or
at normalization jumps.

For completeness, specialization of the left side is field trace,
not a trace of a singular-fibre coordinate model. Localize the scale
line at its generic point. The normalized critical map is separable
of degree140 at every admitted ratio. Its finite algebra is represented
by the monic degree140 norm polynomial, with y and eta reconstructed
rationally. The necessary denominators are nonzero functions of ell:
otherwise the stated primitive field presentation would fail. Thus at
each admitted parameter one can further localize in ell so the algebra
and the element f*phi*v specialize as a finite free algebra and an
element of it. Matrix trace commutes with that specialization. Both
coefficient expressions therefore specialize to the actual function-field
trace. The residue formulas, already regular in the ratio parameters,
extend to the exceptional charts without extra genericity assumptions.

## Constructive implementation

The new
[series engine](../../scripts/arithmetic/degree140_infinity_trace_20260929.hpp)
uses x=xi^{-3}, y=xi^{-10}Y, Y^3=xi^{30}P(xi^{-3}). The small critical
root is found by the supplied unit-derivative quadratic recursion; the
large one follows from their sum. It tracks absolute precision through
addition, multiplication, inversion, derivatives and fifth powers.
Residues are extracted only within the certified available precision.
The [driver](../../scripts/arithmetic/degree140_infinity_trace_20260929.cpp)
returns ell*Tr(phi*v), ell*Tr(x*phi*v), ell*Tr(x^2*phi*v).
Its first three newly computed profiles agree coefficient by coefficient
with the separate finite-algebra construction at h=2,3,4,w=3.
This is a focused check of the new algorithm, not a replay of incoming
certificate programs. The proof of the residue identities is the argument
above and does not rely on interpolation at those parameter values.
