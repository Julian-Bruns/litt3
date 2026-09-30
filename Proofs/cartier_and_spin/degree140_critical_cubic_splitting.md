# Proof: a cubic Newton polygon and its residual quadratic

30 September2026.
[Statement](../../Theorems/cartier_and_spin/degree140_critical_cubic_splitting.md).
This is a new local consequence of the accepted regular source model.
The residue field is algebraically closed, and R=k[[r]] has
characteristic five. All source and critical coefficients below are
integral in R.

Complete the square in the critical quadratic and translate its centre
to Z=0. Its derivative identity then reads
\[
F_\lambda'(Z)=u(\phi_0+Z^5)(Z^2-D),
\qquad u,\phi_0\in R^\times,\qquad \operatorname{ord}_rD=m.
\]
Here u=3g2 and D differs from the critical discriminant by a unit.
Because phi0 is a unit, the source reduction has exactly a triple root
at Z=0 when lambda is the common critical value. Its other local
factor is a unit near Z=0. Integrating the displayed derivative gives
the exact shape
\[
F_\lambda(Z)=b_0-u\phi_0DZ+(u\phi_0/3)Z^3+b_5Z^5
             -uDZ^6+(u/3)Z^8+b_{10}Z^{10}.
\]
The missing derivative terms are precisely the fifth powers; their
coefficients b5 and b10 are integral. Put v=ord_r(b0), allowing v=infinity.
Since lambda is the common critical value, v>0.

## Below the cubic threshold

If v<3m/2, the Newton polygon for the three positive-valuation roots
has one segment from(0,v) to(3,0). Every one of these roots has
valuation v/3. They can all belong to R only if3 divides v.
Conversely, if v=3r0, substitute Z=r^r0 U and divide by r^(3r0).
The residual polynomial is a cubic a*U^3+b with a,b nonzero.
Its three roots are distinct in k, because3 is invertible. Hensel
lifting therefore gives all three roots in R. Thus this case splits
exactly when3 divides v.

At the two critical roots Z=+/-sqrt(D), the constant b0 is the unique
lowest-valuation term: its valuation is v, whereas the linear/cubic
terms have valuation3m/2. The norm of the two critical values therefore
has valuation2v. All fixed factors in the primitive scale resultant
are units at p, giving nu=2v. This proves the first alternative.

## Above the threshold and the equal-slope case

If v>3m/2 (also when b0=0), the two nonzero Newton slopes for the
triple cluster include m/2, with multiplicity two. For odd m this
already prevents splitting. For even m=2r0 the two roots at valuation
r0 have distinct nonzero leading coefficients, and the third root
has greater valuation (or is exactly zero). All three lift in R.
The critical values have valuation3m/2, so nu=3m. This is precisely
the stated second alternative in this case.

Equality v=3m/2 requires even m=2r0. After scaling Z=r^r0 U, the
residual cubic has nonzero linear coefficient. It either has three
distinct roots, or has one double root and a distinct simple root;
it cannot have a triple root. In the first case all three roots lift.
In the second case Hensel factorization separates the simple root and
a monic quadratic. Over k[[r]] a separable quadratic splits exactly
when its discriminant has even valuation: every residue unit has a
square root. The discriminant of the triple cluster differs by a unit
from the primitive scale resultant, and scaling the three roots
subtracts6r0 from its valuation. Therefore its parity is the parity
of nu. This proves that the equal-slope case splits exactly when
nu is even; here nu>=3m. No leading-coefficient boundary is omitted.

For clarity about that discriminant comparison, factor the actual
source locally as a monic cubic times a unit. Its two critical roots
are the two roots of the displayed derivative quadratic. The product
of their source values computes the cubic discriminant up to units:
the other source factor, phi0 and the quadratic leading coefficient
are all units near the triple cluster. The primitive scale resultant
has this same local product. At these points t is nonzero. Indeed,
the accepted endpoint model has critical roots0 and a second root;
a coalescence at t=0 would be at0 where phi=0, contrary to the
present unit-phi chart. Thus its division by t^5 is also by a unit.

For odd m only the first alternative can split. With v=3r0<3m/2,
the normalized critical double cover has one point above p and its
Lambda index is the norm valuation nu=6r0. This proves the bound and
the simple-zero exclusion. These conclusions retain the ACTUAL
source splitting, rather than treating an even norm divisor or a
ramified critical fibre as sufficient.

The proof uses only the displayed derivative identity, the elementary
Newton slopes, Hensel lifting of simple factors, and the quadratic
discriminant criterion. No large computation or incoming-verifier
replay is required.
