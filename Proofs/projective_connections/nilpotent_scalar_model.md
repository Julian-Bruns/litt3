# Proof: horizontal determinant and the exact active-curvature inverse

[Statement](../../Theorems/projective_connections/nilpotent_scalar_model.md).
The scalar identities are in characteristic five; Section2 holds in
every odd characteristic.

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
[short jet checker](../../scripts/connections/check_cartier_dormant_secants.sage)
verifies both identities, the full fifth iterate, and the line determinant.
They can also be read from horizontality of p-curvature and its determinant.

## 2. N equations, their exact length and infinity

Use Mochizuki,
[*A Theory of Ordinary p-adic Curves*, II, Theorem2.3 and
Definitions2.2,2.4](https://www.kurims.kyoto-u.ac.jp/~motizuki/A%20Theory%20of%20Ordinary%20p-adic%20Curves.pdf#page=66)
(pp63,66–67), restricted to an unmarked smooth curve C. In his notation,
V_C:S(C)→Q(C) is finite flat of degree p^N, its leading term is minus
Frobenius, and N(C)=V_C^(-1)(0) scheme-theoretically. Choosing an origin
r_* of S(C) and a quadratic basis q_i therefore gives

    V_C(r_*+sum x_i q_i)=sum P_i(x) q_i^F,
    P_i(x)=−x_i^p + terms of degree at most p−1.     (2)

The relatively prime leading monomials x_i^p give the asserted Groebner
basis and standard monomials. At infinity the homogenized equations
require all x_i^p=0, so there is no projective solution. In characteristic
five, q_i^F is represented by the horizontal tensor q_i^5 and V_C by
Delta(dt)^10 from(1). Thus(2) is the required scalar coefficient
identity over arbitrary parameter algebras, including nonreduced ones.

The affine torsor is natural under curve automorphisms:
[Wakabayashi, Proposition2.8.1 and its preceding construction](https://arxiv.org/pdf/1411.1197v3#page=17).
An automorphism acting trivially on H0(omega²) therefore acts by a
translation b. If its order m is prime to p, then mb=0 forces b=0.
For the genus-two hyperelliptic involution, H0(omega²)=Sym² H0(omega)
and the action is trivial. Naturality of p-curvature and the Hodge
projection also makes the square Hasse invariant fixed.

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

## 5. Collisions can meet curvature zeros

The overlap in div(s)=2D+5R actually occurs. In F5(t), put

    a=t^7/(1+t^11),
    r=3a''/a+(a'/a)^2=(t^20+4t^9)/(1+t^11)^2.

Then E(r)=3a and Delta(r)=0. At t=0 the connection is regular,
the curvature entries have orders(6,7,5,6), and the saturated kernel
meets the oper line simply. Thus the quartic order is7=2+5, with
collision order1 and curvature-zero order5.

This has a compact realization: pull back by t=u^5−u and then to
w^4=(1+t^11)^2 u(u−1). Its smooth normalization has genus55; the
quartic zero orders are2,40,7,12, all0 or2 modulo5, so Section3 gives
a regular active nilpotent connection everywhere. The
[bounded independent check](../../Research/audits/NILPOTENT_SPIKE_COLLISION_SOURCE_CHECK_2026_09_07.md)
verifies the local matrices and all compact divisor orders.

Hoshi [AppendixA, RemarkA.3.1(ii)–(iii)](https://www.kurims.kyoto-u.ac.jp/~yuichiro/rims1867revised.pdf)
already records the failure of Bouw–Wewers' disjointness assertion;
PropositionA.5 retains the admissibility criterion used above. Their
marked extension can differ from this regular integral oper despite
rational agreement. The present proof uses the direct factorization,
not that unrestricted extension correspondence.

Scoped check: PASS, /root/library_generalization_cleanup_max,2026-09-07,
for the factorization with overlap and the local/compact example.
