# Fixed-X dormant projective-oper equations audit

Verdict: PASS, including scheme-theoretic completeness, with documentation
fixes listed below. Auditor: independent bounded agent
`fixed_x_dormant_equations_audit`. Date: 2026-09-06.

Scope: `scripts/fixed_x_dormant_opers.sage` and the derivation supplied in
the audit request. This does not construct or exclude a common cover.
The full Groebner calculation was not rerun. Running `--build-only`
confirmed 24 variables, 96 equations of maximum degree two, and the
script's recurrence assertions.

## Global regularity and completeness

Write A9 for the coefficient of x^9 in F. The equation for z=x^3/y is
z^-3=F/x^9=x+A9+A8/x+..., so x=z^-3-A9+O(z^3).
Indeed the expansions of x and y lie respectively in
z^-3 k[[z^3]] and z^-10 k[[z^3]]. Consequently
theta=2z^16(1+O(z^3)) dz. In particular there are no relative terms of
orders one or two in this frame.

Use the convention u_xx=r_x u. Under a coordinate change x=x(t),
the potential becomes

    r_t = (dx/dt)^2 r_x - (1/2){x,t}.

Locally write theta=h dt. The theta-induced rational projective
connection has potential (h^-1/2)''/(h^-1/2) in the t coordinate.
Square roots can be taken etale locally; changing their sign does not
change this expression. No primitive of theta is required in
characteristic five. In the x coordinate h=y^-2, giving y''/y.
Since y'/y=2F'/F, this equals 2F''/F+2(F'/F)^2, exactly as in the script.

Away from O, theta is a regular nowhere-zero differential, so its
induced projective connection is regular, including the finite branch
points of x. At O, h^-1/2 is a constant times z^-8(1+O(z^3)). Its
second logarithmic quotient has polar part
(-8)(-9)z^-2=2z^-2 and has no simple pole. The quadratic differential
2x^8 y theta^2 has polar part 8z^-2 dz^2=3z^-2 dz^2 and likewise no
simple pole. The two cancel. Its x-coordinate coefficient is 2x^8/F.
Thus the stated baseline R is globally regular, with the asserted sign.

All differences of regular projective connections are global quadratic
differentials. Here H0(omega^2)=L(32O) theta^2. The functions regular
off O have basis x^i y^j, i>=0, j=0,1,2, with pole orders 3i+10j.
The orders in the three residue classes modulo three are distinct,
so there is no cancellation that could add further terms to L(32O).
The bounds are i<=10,7,4, respectively, totaling 24=3g-3.
This proves that the script uses the entire affine space, not a
function-field subset or an incomplete regularity ansatz.

More explicitly, writing the added tensor as
(A(x)+B(x)y+C(x)y^2)theta^2 gives additions
A(x)y^2/F^2+B(x)/F+C(x)y/F to r. This is exactly the script's a,b,c
placement in n2,n0,n1. Under y -> zeta y, theta -> zeta theta, so only
the B(x)y theta^2 part is invariant. The invariant switch is correct.

The identification with projective opers is the usual one in rank two;
one may choose the fixed theta characteristic O(8O). The hypotheses
p>2 and p not dividing g-1 hold. The affine-space identification also
works in families, with translation space H0(omega^2) tensor the base
algebra. There is no additional factor counting theta characteristics
for projective opers. See Joshi--Pauly, section 3.2, especially Lemma
3.2.2 and the projective-oper identification on printed page 13:
https://arxiv.org/pdf/0912.3602 .

## Dormancy, including infinitesimal bases

Set D=d/dx. Since K(X)/k(x) is separable, D^5 is the zero derivation:
it vanishes on k(x) and has a unique extension across the separable
extension. This remains true after extension of the constant algebra.
Put E=r''-3r^2. Direct differentiation of u''=ru gives the fifth
horizontal iterate matrix

    [[ E',          3E ],
     [ E''+3rE,    -E' ]].

Thus vanishing is equivalent to E=0. The induced projective
p-curvature vanishes exactly when this matrix is scalar; its trace is
zero and 2 is invertible, so that is again equivalent to zero.
This uses p-curvature itself, not just its characteristic polynomial.
The displayed identity proves equivalence over arbitrary, including
nonreduced, parameter algebras, not only on geometric points.

For r=sum(n_j y^j)/F^2, put t_j=2j-2. Differentiating the j-th term
twice gives numerator

    F^2 n_j'' + 2t_j F F' n_j'
      + t_j F F'' n_j + t_j(t_j-1)(F')^2 n_j

over F^4, with the factor y^j. This matches `second_numerator`.
Reducing r^2 by y^3=F gives exactly the three expressions `eqs`.
Taking polynomial coefficients loses no conditions: 1,y,y^2 are a
basis over k(x), F is a fixed nonzero polynomial, and these injections
remain injections after tensoring with any k-algebra. Vanishing on
this dense coordinate open is equivalent to global vanishing of the
regular p-curvature, also after constant base change. Differentiating
E preserves the coefficient ideal because D kills the parameters.
Hence the coefficient ideal cuts out the dormant scheme exactly,
without radicalization, saturation, or a Frobenius-root operation.
The derivatives are relative to the parameter base. Relative
Frobenius descent does not require replacing parameter coefficients
by fifth powers or fifth roots.

## Scheme length and limits

Wakabayashi's Theorem 3.3 makes the dormant indigenous-bundle moduli
finite faithfully flat over smooth-curve moduli for odd p. The degree
formula of Corollary 5.4 initially assumes p>2(g-1); section 6.2 cites
Liu--Osserman's polynomiality in p for the actual degree, and proves
polynomiality of the trigonometric expression. Equality at all large
primes therefore extends to every odd prime. These are different
steps; the large-prime hypothesis must not simply be omitted.
Source: https://arxiv.org/pdf/1411.1191 .

The preceding functorial identification makes this theorem applicable
to THIS coefficient scheme. Its length over F25, or geometrically
over k, is consequently

    5^8 / 2^17 * sum_{j=1}^4 csc(pi*j/5)^16 = 29375.

An exact rational check uses s0=2, s1=4,
s_n=4s_(n-1)-(16/5)s_(n-2), yielding length=5^8*s8/2^16.
This is a length with multiplicity, not a claim of 29375 distinct
points, F25-rational points, or etaleness at the fixed curve. The
reported invariant length 55 was not independently recomputed here.

## Documentation fixes before canonical promotion

1. Save the global derivation and the family-level ideal argument in
   the canonical proof. The script currently says this derivation is
   recorded in STATE.md, but the STATE.md read by this auditor still
   records the earlier rank-three atlas task. Update that pointer.
2. Call the result a scheme of dormant PGL2-opers/projective opers;
   do not silently identify it with all SL2-opers with every possible
   theta characteristic or with a chosen Frobenius-descended bundle.
3. State length 29375 with multiplicity, and cite the polynomial
   extension when applying the degree formula at p=5, g=9.

No mathematical correction to the script's equations is required.
