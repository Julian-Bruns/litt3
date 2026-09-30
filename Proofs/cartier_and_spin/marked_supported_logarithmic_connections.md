# Proof: the marked divisor group determines every logarithmic derivative

[Statement](../../Theorems/cartier_and_spin/marked_supported_logarithmic_connections.md).
The [marked subgroup](marked_support_five_saturation.md) Gamma is finite
of order prime to five. For R in Z let N_R be the order of[R-O], and
choose f_R with div(f_R)=N_R(R-O). Put omega_R=N_R^-1*dlog(f_R),
where the integer inverse is interpreted in F5. This is independent
of f_R and of replacing N_R by a multiple still prime to five. It has the asserted simple poles
and residues and is fixed by Cartier.

For g choose integers a_R with a_R*N_R=ord_R(g) mod5. The divisor of
g/product_R f_R^(a_R) is five times a divisor supported on Z union{O}.
Five-saturation makes this ratio a fifth power up to a constant.
Differentiating proves the formula. No bound on degrees or multiplicities
has been used. Each omega_R is a logarithmic differential divided by
an element of F5, so absolute Cartier fixes it.

## A small exact construction without finding the large f_R

Use B=F25, E=F_(5^8), alpha, rho3=P(alpha) and zeta=[11] as in
the earlier two-jet theorem. The marked points are in F_(5^24),
with rho^(5^8)=zeta*rho. Arithmetic25-Frobenius to the fourth power
acts on the marked divisor exactly as the cubic automorphism gamma.
Therefore coefficient conjugation sends omega_R to gamma^-1*omega_R.
This assertion uses pushforward on the divisor and pullback on the form;
it is why the inverse of gamma occurs.

A third-kind differential with residues1,-1 at R=(alpha,rho),O is

(1/3)(1+rho/y+rho2/y2) dx/(x-alpha).

It is regular at the other two points above alpha and at every cubic
branch point. At O its only pole is simple, with residue-1. Adding a
regular form with the stated coefficient covariance gives the complete
form

omega_R=[1/3+rho*A0(x)/y+rho2*B0(x)/y2] dx/(x-alpha),

where A0,B0 are over E, deg A0<=3, deg B0<=6, and
A0(alpha)=B0(alpha)=1/3. Indeed the regular-form basis is
x^j dx/y,0<=j<=2, and x^j dx/y2,0<=j<=5. Covariance requires their
coefficients to lie in rho*E and rho2*E, respectively.

For a polynomial H over E define car(H)=sum H_(5j+4)^(1/5) x^j,
using the inverse fifth power on E, and put p0=P(alpha), d=x-alpha.
The condition C(omega_R)=omega_R is exactly

A0=p0^(-1/5)*car(B0*P*d4),
B0=p0^(-3/5)*car(A0*P3*d4).

These formulas follow by pulling d5 outside Cartier and by
rho^(1/5)=rho2*p0^(-3/5), rho^(2/5)=rho*p0^(-1/5).
The first logarithmic summand is already Cartier-fixed.

There are eleven E-coefficients. Expressing E over F5 and appending
the two residue constraints gives104 scalar equations in88 unknowns.
Its coefficient matrix has rank88 and its affine system is consistent.
Thus the computed solution is the omega_R constructed abstractly above.
The [exact constructor](../../scripts/arithmetic/marked_logarithmic_connection_20260929.py)
and [receipt](../../../litt3-computation-data/conceptual_continuation_20260929/marked_log_connection/connection_and_sections.json)
give the field, both polynomials and rank. Arithmetic and cubic
conjugation recover all twelve forms.

## The resulting ordinary linear system for a section

Put v=y/rho and Q=P/p0, so v3=Q. Express any target logarithmic form as
omega=(H0+H1*v/Q+H2*v2/Q)dx/D, with all H_i,D polynomials over E.
For g=U+Vv+Wv2 the equation dg=omega*g is equivalent to

D Q U' = Q H0 U+Q H1 W+Q H2 V,
D(Q V'+Q'V/3) = Q H0 V+H1 U+Q H2 W,
D(Q W'+2Q'W/3) = Q H0 W+H1 V+H2 U.

All equations are linear over E in the coefficients of U,V,W. Their
geometric solution space is obtained by scalar extension. A zero
divisor prescribed modulo five gives omega=sum e_R omega_R; additional
fixed jets impose the required integral base divisor.

At a marked point, a nonzero horizontal function has valuation
congruent to the residue of omega modulo five. Thus after a base
vanishing order r is imposed, forcing the coefficients at r,r+5,...
to vanish successively forces five more zero orders at each step.
This is useful for support tests on the much smaller horizontal space.

The general formula is a consequence of the marked divisor group,
not of a guessed splitting of an arbitrary Frobenius bundle. Horizontal
sections may have fivefold zeros away from Z; the logarithmic equation
alone does not exclude them.
