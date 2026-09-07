# Proof: horizontal determinant and the exact active-curvature inverse

[Statement](../Theorems/Thm_nilpotent_scalar_model.md).
Author /root,2026-09-07. Exact symbolic identities checked; no independent
audit of this assembled proof. Both actual pullbacks are retained in
the final application.

## 1. Scalar curvature and its two intrinsic projections

Write D=d/dt and E=r''−3r². For the companion connection D−M,
M=[[0,1],[r,0]], five iterations give

    psi=−[[E',3E],[E''+3rE,−E']],
    Delta=det(psi)=−E'^2−3E(E''+3rE).                 (1)

The rank-two trace is zero. Thus dormancy is E=0 and nilpotence is
Delta=0, including their scheme equations. The oper line is the second
coordinate: projection of its p-curvature into the first coordinate
has coefficient−3E. Intrinsically it is a section of
Hom(theta,theta^−1) tensor omega^5=omega^4. Hence E(dt)^4 is intrinsic.
Determinant p-curvature is an intrinsic section Delta(dt)^10.

Direct differentiation gives D(Delta)=0, using D^5r=0. Its highest
total-degree term in r and its derivatives is−r^5; all others have
degree at most4. The
[short jet checker](../scripts/check_cartier_dormant_secants.sage)
verifies both identities, the full fifth iterate, and the line determinant.
They can also be read from horizontality of p-curvature and its determinant.

## 2. N equations, their exact length and infinity

Regular projective connections form a torsor under H^0(omega²).
It is nonempty: their local Schwarzian transition cocycle has obstruction
in H^1(omega²)=0 by Serre duality. Choose r_* and a basis
q_i=a_i(dt)^2, and put r=r_*+sum x_i a_i, where D(x_i)=0.

Expand Delta as a polynomial in the x_i. Each coefficient is a regular
10-differential and is horizontal by Section1. Its scalar coefficient
belongs to k(C)^5. Its unique fifth root is a regular quadratic
differential: valuations divide by5 and the transition factor
(dt/du)^10 takes its unique fifth root (dt/du)^2.
The horizontal regular10-differentials are therefore precisely the
k-linear span of the independent q_i^5. Consequently

    Delta(dt)^10=sum P_i(x) q_i^5,
    P_i(x)=−x_i^5 + terms of degree<=4.              (2)

This is a polynomial coefficient identity, not a claim that parameter
variables themselves have fifth roots. It remains valid over nonreduced
parameter algebras. Nilpotence is exactly all P_i=0.

The leading monomials of −P_i are the relatively prime x_i^5. The
Groebner product criterion makes these N equations a Groebner basis;
their standard monomials have every exponent<5. The quotient has
dimension5^N, proving the exact scheme length. Homogenizing to degree5,
the hyperplane at infinity requires all x_i^5=0 and the homogenizing
variable0, hence has empty projective support and is empty as a scheme.

The same monic basis works over a polynomial target ring for equations
P_i(x)=y_i, proving finite flatness of the scalar determinant map.
The general result is classical: Mochizuki,
[*A Theory of Ordinary p-adic Curves*](https://www.kurims.kyoto-u.ac.jp/~motizuki/A%20Theory%20of%20Ordinary%20p-adic%20Curves.pdf),
ChapterII, Theorem2.3, pp63–67. Its proof derives the leading term
−Frobenius, then finite flatness and the degree. Those pages were read
completely here; Section1 supplies our direct characteristic-five version.
No characteristic-zero lifting or ordinary-indigenous hypothesis is used.

## 3. Active nilpotence determines its quartic, in both directions

If r is active nilpotent, E is nonzero. Solving Delta=0 in(1) gives

    r=3E''/E+(E'/E)^2.                              (3)

Set a=E/3 and s=a(dt)^4. In a separable radical extension take v^4=a
and b=v². Then (3) is r=b''/b. The scalar identity from
`cartier_dormant_secants` is

    E(b''/b)=2D^4v/v.

Since E(r)=3a=3v^4, this says D^4v=−v^5, equivalently C(vdt)=vdt.
The product rule applied to a^4=v^15 v now gives C_3(s^4)=s.
Conversely that Cartier equation gives C(vdt)=vdt and the same identity
gives E(r)=3a for r in(3). Substitution into(1) then gives Delta=0.
No radical was required to descend through another endpoint: it only
checks a rational identity that descends to k(C).

The coordinate rule for r=3a''/a+(a'/a)^2 is the projective Schwarzian
rule (equivalently apply the quadratic identity to b²=a). At a zero
a=t^m u, its double-pole coefficient is4m(m+3). Thus a double pole
is absent precisely for m=0 or2mod5. If this coefficient vanishes,
the only remaining possible pole is simple. But E(r)=3a is regular;
a nonzero simple pole of r would give a nonzero third-order pole in
r''−3r². The simple pole therefore vanishes. This proves the exact
regularity criterion, with infinity included. It proves both directions
of the geometric-point bijection without any extension classification
from deformation-data literature.

## 4. Admissibility is strictly weaker than ordinariness

Here is a factorization argument that also explains every multiplicity.
In a local determinant frame let the oper line be e2 and generate the
saturated kernel of psi by h=(a,b), a unimodular column. The induced
map from the quotient by h to h gives

    psi=mu h(-b,a).

The entry ideal is(mu); the projection from e2 through psi to the first
coordinate is mu*a². The collision ideal is(a). Thus the quartic's
divisor is EXACTLY S+2D, even at overlapping points. No divisor-support
disjointness has been used. Horizontality preserves the kernel line.
At a collision h is a unit multiple of the oper line; applying the
connection and projecting modulo that oper line shows da is nonzero.
Consequently D is reduced. The induced regular connection on
Hom(E/ker(psi),ker(psi)) tensor omega^5 makes mu horizontal in a regular
line-bundle frame. The absence of a logarithmic pole in mu'/mu implies
ord(mu)=0mod5 at every point. Hence S=5R, with R effective.
Now div(s)=2D+5R immediately proves the admissibility test.

The same factorization works in every odd characteristic p: replace
omega^5 by omega^p, so S=pR and the square-Hasse divisor has degree
(p−1)(2g−2). Its degree minus2deg D equals p deg R, an even integer.
Thus deg R is even. For genus two, a nonzero R would contribute at
least2p to a divisor of total degree2p−2, impossible. Hence R=0.
This genus-two fact does NOT assert ordinariness.

Suppose a common regular active nilpotent connection exists in an ACTUAL
coreless span involving fixed X. Its quartic is a nonzero shared section,
so `canonical_intersection` makes its divisor uniform. On X write it
as mT, with T reduced; since deg(omega_X^4)=64, m divides64. The above
decomposition requires m=0 or2mod5, leaving only m=2 or32. In the
latter case deg T=2 and omega_X=O(16O) gives

    32[T−2O]=0.

The audited `two_primary_w3` then forces T=2O, impossible for reduced T.
Thus m=2 and T has32 points, so R=0 on X and after actual etale pullback.
The SAME connection on the source is therefore admissible. This argument
does not assume a clump in advance: its common quartic supplies one.
Nor does it identify a full deformation tangent space with a common
tangent intersection or infer ordinariness.

## 5. Source boundary retained while checked

The older Bouw–Wewers deformation-data source translation is not a proof
input here. Hoshi explicitly documents the failure of their disjointness
claim in [AppendixA, RemarkA.3.1(ii)–(iii)](https://www.kurims.kyoto-u.ac.jp/~yuichiro/rims1867revised.pdf);
his PropositionA.5 independently gives the admissibility criterion used
above. The relevant statements and source correction were read directly.
The direct factorization and a characteristic-five example are checked in
[the exact local and compact test](../Research/NILPOTENT_ZERO_SOURCE_CHECK.md).
In particular, the pointwise statement above permits curvature order7:
regularity and admissibility must not be conflated. No existing audited
special case is removed on the basis of this new author proof.

Bounded independent check: PASS, `/root/library_generalization_cleanup_max`,
2026-09-07, for the divisor factorization including overlap and the
local/compact source correction; [record](../Research/audits/NILPOTENT_SPIKE_COLLISION_SOURCE_CHECK_2026_09_07.md).
It was an existing agent, not a fresh whole-theorem audit; neither the
genus-two corollary nor the other assembled statements acquire a whole
audit claim from that check.
