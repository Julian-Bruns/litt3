# Focused audit: the degree84 necessary differential system

Verdict: **PASS for the necessary polynomial dictionary.**
Auditor: `/root/audit_degree84_differential_system`.
Date: 2026-09-10.
Objections: no blocking mathematical objection or coefficient correction.
The half-density argument needs the explicit calculation below; it does
not assert that the half-density itself descends to a rational section.
No degree84 exclusion or solver result is certified by this audit.

Scope: the new equations in
[DEGREE84_NATIVE_ADAPTATION.md](../DEGREE84_NATIVE_ADAPTATION.md) and
[diagnose_triangle237_compressed_system.sage](../../scripts/diagnose_triangle237_compressed_system.sage).
The canonical
[triangle237 dormant-orbit theorem](../../Theorems/Thm_triangle237_dormant_orbit_obstruction.md),
its established hyperelliptic-factor conclusion, and the complete
five-element dormant set are inputs. Their old census and audits were
not re-audited. No heavy computation was run.

## 1. Normalization covers infinity

Write the actual factorization as

    C_alpha --u--> P1_u --q--> P1_t,

with degrees2 and42, and target branch values0,1,infinity assigned
indices2,3,7. At each Weierstrass point, the composite ramification
index is twice the index of q. It must therefore be2: every one of
the six hyperelliptic branch points is a SIMPLE zero of q. In the
fixed displayed model, infinity is already the sixth such point.
No coordinate change or omitted infinity chart is needed.

All eighteen double zeros, fourteen triple points over1, and six
seventh-order poles of q are finite. Taking their monic root
polynomials gives

    q=s F A^2/C^7,       q-1=B^3/C^7,
    deg A=18, A monic;  deg C=6, C monic;
    deg B=14, leading(B)=-1;  s!=0.

The numerator of q has degree41 and that of q-1 has degree42 with
leading coefficient-1. Over the algebraically closed geometric field,
the cube root can always be chosen with leading coefficient-1.
Thus these normalizations retain every actual quotient. The resulting
identity is

    s F A^2-B^3-C^7=0.

Its coefficient of u^41 is s-3b13-2c5, giving exactly
s=3b13+2c5. The scalar s is nonzero because q has a simple zero at
infinity. Writing it as a square of an unnormalized leading coefficient
does not restrict s over the geometric field.

## 2. Both derivative identities are necessary

The ramification contribution on P1_u is18+28+36=82=2*42-2.
Consequently q' has finite zero divisor div(A)+2div(B), finite pole
divisor8div(C), and no additional zero or pole. Since
q=s/u+O(u^-2), the leading term q'=-s/u^2 fixes the scalar, giving

    q'=-s A B^2/C^8.

Differentiating the two displayed expressions for q and q-1 and
cancelling only nonzero rational functions on the actual geometric
domain gives, respectively,

    (F'A+2FA')C-2FAC'+B^2=0,
    3CB'-2BC'+sA=0.

Here7=2 in characteristic five; the signs and the coefficient3 in
the second equation are correct. These are necessities of the actual
passport, not a converse to differentiation. The production system
keeps the passport equation itself.

## 3. The half-density gives the asserted rational scalar solution

For the convention y''=r y, the polynomial

    y0(t)=t^2(t-1)^2

satisfies y0''=(2t^2+3t+2)=r0(t)y0. In a separable quadratic extension
where a square root of q' exists, the usual scalar pullback solution is

    Y=y0(q)/sqrt(q'),

for r_u=(q')^2 r0(q)-{q,u}/2. Set h=F^2AC. The passport and the
exact derivative formula give the identity

    Y^2 = -s^3 F^4 A^7 B^10/C^48,
    Y^2/h^2 = -s^3 A^5 B^10/C^50.

The last expression has zero u-derivative in characteristic five.
Because2 is invertible and Y,h are nonzero rational functions in the
extension, it follows that

    Y'/Y = h'/h,          Y''/Y = h''/h.

Hence the RATIONAL FUNCTION h=F^2AC solves h''=r_u h. This uses neither
rational descent of Y nor a chosen fifth root of its ratio. It is a
statement in the scalar u-coordinate; it does not claim a globally
regular horizontal section for an independently chosen theta lift.

The inherited regular dormant-connection classification gives

    r_u=2(F'/F)^2-F''/F+P/F,
    P=2u^3+beta*u^2+b1*u+b0,
    b1=beta^2+3F4*beta+3F3,
    b0=-F2+(F4+2beta)*b1.

Writing h=F^2H and expanding gives the exact identity

    h''-r_u*h
      = F*[F H''+4F'H'+(3F''-P)H].

Thus H=AC satisfies precisely the ODE used in the script. There is no
sign or scalar change. The ostensibly highest u^27 coefficient for
monic H of degree24 is24*23-2=0 in F5; its disappearance is legitimate,
not a truncated equation. All nonzero polynomial coefficients are
collected by the script.

## 4. The five dormant choices and the algebraic domain

The displayed separator is the known irreducible degree-five polynomial
over F125. As a small independent exact check, ordinary Python integer
polynomial arithmetic modulo(alpha^3+alpha+1,5) verifies that it is
exactly2*Psi from the canonical universal dormant quintic. Its b1,b0
substitutions agree with that theorem.

Frob125 fixes F and permutes the five beta transitively. It also
preserves all monic normalizations, s!=0, both derivative equations,
and the passport. Therefore a geometric solution for any beta gives
one for the chosen beta by coefficient Frobenius. A single
representative in F_(5^15) suffices for a GEOMETRIC unit-ideal test;
the variables are not restricted to points of this finite field.

The localization loc*s-1 imposes exactly the required nonvanishing.
Omitting squarefreeness and disjointness enlarges the system, so it is
safe for proving emptiness. It prevents an arbitrary solution of this
system from being treated as a cover. The optional quadratic-only
mode weakens the equations; the default/exported system retains the
full passport. The exporter's preliminary linear substitutions solve
equations with nonzero constant field coefficients, check that the
substitutions are closed, and substitute into every original equation;
this introduces no additional geometric restriction.

The recorded matrix rank15 and kernel dimension10 were not independently
recomputed, and are not needed for the above necessity proof. The
native restriction of scalars, Krylov implementation, bounded multiplier
span, and any eventual certificate require their separate exact replay.
This audit supplies the geometric implication from an actual remaining
degree84 map to the stated polynomial system, and nothing beyond it.
