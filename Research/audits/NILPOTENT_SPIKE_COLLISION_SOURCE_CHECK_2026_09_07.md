# Bounded check: nilpotent spikes may meet the oper–kernel collision divisor

Date:2026-09-07.
Checker: `/root/library_generalization_cleanup_max`, Astra Max.
Verdict: **PASS** for the local example, its compact genus55 realization,
and the exact divisor identity below; **SOURCE RESTRICTION REQUIRED**
for the unrestricted Bouw–Wewers marked/unmarked correspondence.
This is a requested bounded independent check by an existing library
agent, NOT a fresh-agent audit of `nilpotent_scalar_model` or another
whole theorem. No prior audit body was opened. No solver, mathematical
statement, proof, registry or state file was changed during the check.

## 1. The discrepancy is documented in a later primary source

Hoshi, [*On the Supersingular Divisors of Nilpotent Admissible Indigenous
Bundles*, AppendixA, RemarkA.3.1(ii)–(iii), p37](https://www.kurims.kyoto-u.ac.jp/~yuichiro/rims1867revised.pdf),
identifies Bouw–Wewers Proposition3.6(iv) with disjointness of the
generalized supersingular and spike divisors, states that this fails
in general, and supplies a genus5 characteristic3 example. His
PropositionA.5 retains the admissibility criterion: the square-Hasse
zeros all have order2. This is not a newly alleged error based only
on our computation.

In [Bouw–Wewers, arXiv:math/0505275v2, pp6–8,12–16](https://arxiv.org/pdf/math/0505275v2),
normalization means a horizontal surjection to O; supersingularity
means a simple pole of its canonical Hodge section. Their proof of
Proposition3.6(iv) cannot infer nonvanishing of curvature from its
value on that MEROMORPHIC section. Formula(5) and Theorem4.11 use
the failed disjointness in classifying the integral bundle extension.
No broader literature audit, author contact, or published-version
comparison is claimed.

## 2. Exact local replay, including normalization

Work in K=F5(t), write H=1+t^11, and put

    a=t^7/H,
    r=3a''/a+(a'/a)^2=(t^20+4t^9)/H^2,
    E=r''−3r^2=3a,
    M=[[0,1],[r,0]],              nabla_D=D−M.

Literal iteration of nabla_D five times on the two constant basis
vectors, using N_(j+1)=D(N_j)−M N_j, gives

    P=−[[E',3E],[E''+3rE,−E']].

Exact rational-function calculations verify P^2=0, P!=0,
D^4(1/a)+1=0, and entry valuations(6,7,5,6) at t=0.
The potential r is regular there. These tests use polynomial
numerators of differences, not raw equality of unnormalized fractions
with a scalar: Sage may print D^4(1/a)=4t^10/t^10 and mishandle
its direct comparison with−1.

The following explicit local normalization removes any ambiguity:

    h=(tH,1+3t^11)^T,
    gamma=(−H(1+3t^11), tH^2),
    e0=(0,1/(tH^2))^T.

The vector h is primitive and generates the saturated curvature kernel.
The row gamma is regular and surjective at0, and

    gamma'+gamma M=0,              gamma(e0)=1,
    P=(t^5/H^4) h gamma,
    nabla_D(e0)=−h/(t^2 H^3)=−(1/a)P(e0).             (1)

Each identity in(1) was checked exactly. The Hodge line is generated
by e2=(0,1); its projection under gamma vanishes simply. Thus e0
has a simple pole, while the normalized curvature STILL has order5.
The kernel and Hodge line collide at0. Normalizing does not remove
this spike, change the quartic, or turn the point into a marked one.

For the paper's identification of the abstract D^⊗5 with−P(e0),
(1) recovers precisely v=1/a, not a differently normalized datum.
The fourth-root form a^(1/4)dt has sigma=1+7/4=11/4.

The paper's FORWARD construction chooses another integral model at0:
it marks0, sets its spike order to11, and uses the local basis
(m_BW,e0), with m_BW=t^−6 D^⊗5. Its connection matrix for D is

    [[4/t,H/t],[0,0]],

so its logarithmic residue has exponents4,0. Under the generic
identification with our normalized model, m_BW maps to
−t^−1 H^−4 h. The change-of-lattice determinant has valuation−1;
its elementary divisors are−1,0, not a uniform line-bundle twist.
Thus a generic identification does not identify these projective
bundle extensions. The regular oper is not the marked extension
selected by that forward construction.

## 3. Exact divisor identity, with overlap allowed

For any regular rank-two oper in characteristic p>2 with active
square-zero p-curvature, use a determinant frame and write the
Hodge line as O e2. At a point the saturated curvature kernel has
a primitive generator h=(b,c)^T. Every rank-one square-zero curvature
matrix has the unique form, up to its chosen generator,

    P=mu h(−c,b).

Indeed its image lies in O h and its row annihilates h. Since(b,c)=O,
the matrix-entry ideal is(mu): the products b^2,bc,c^2 generate O.
Hence the spike order is ord(mu). The collision ideal of the kernel
and Hodge sections is(b), whereas the restriction of P to the
Hodge line followed by projection to the quotient has coefficient
mu b^2. These are intrinsic divisors, so

    div(square Hasse)=S_spike+2D_collision.             (2)

There is NO disjoint-support assumption, including when both divisors
are nonzero at the same point. This is a direct local proof, not a
strengthening attributed to Hoshi's stated inequalities.

The kernel is preserved by the connection. In a local oper frame,
its first horizontal equation has the form b'=c+beta b, with beta
regular. At a collision c is a unit, so b has a simple zero.
Equivalently the oper's invertible Kodaira–Spencer map makes the
horizontal and Hodge sections meet transversely. Thus D_collision
is reduced. Horizontality of P in the regular line bundle
Hom(E/kernel,kernel)⊗(T^⊗p)^−1 implies mu'/mu is regular.
Writing mu=t^n times a unit shows n=0 modulo p.

Consequently, in characteristic5 the quartic zero orders are 5n or
5n+2, with n≥0. Admissibility (no spikes on an unmarked curve) is
equivalent to every positive quartic zero having order2. The local
example has order7=5+2: a genuine nonadmissible oper, not a
normalization artifact.
No marked-point or wild-coordinate extension is audited here.

## 4. Compact genus55 realization: all points checked

On P1_u put t=u^5−u, H_u=1+t^11, and s=(t^7/H_u)(du)^4.
Since dt=−du, this is the actual quartic pullback of the local model.
H_u has degree55 and is squarefree; its derivative is−t^10 and
it is coprime to t. The quartic s has order7 at the five F5 points,
order−1 at the55 H_u-roots, and order12 at infinity.

Take the smooth projective normalization C of

    w^4=H_u^2 u(u−1).

The valuation1 at u=0 proves connectedness of the degree4 Kummer
cover. It is tame, with inertia2 at the55 H_u-roots, inertia4 at
u=0,1, and no inertia at infinity (the right side has degree112).
Riemann–Hurwitz gives2g(C)−2=−8+55·2+2·3=108, hence g(C)=55.
Tame pullback changes quartic order e to me+4(m−1). Therefore:

| Base points | Points on C | Quartic order | Collision order | Spike order |
| --- | ---: | ---: | ---: | ---: |
|55 roots of H_u|110|2|1|0|
|u=0,1|2|40|0|40|
|u=2,3,4|12|7|1|5|
|infinity|4|12|1|10|

There are no other quartic zeros or poles. Its degree is
110·2+2·40+12·7+4·12=432=4(2g(C)−2); its collision and spike
degrees are126 and180, satisfying432=2·126+180.

Coordinate covariance was checked as an exact characteristic5 jet
identity. For x=x(z), q=x', h=q'/q and A_z=A_x q^4,

    r(A_z)=q^2 r(A_x)+2h'+4h^2=q^2r(A_x)−{x,z}/2,
    E(r_z)=q^4 E(r_x).

The jet derivation uses D^5x=0, valid in a separating parameter.
Thus the pulled-back rational projective connection has E=3s_C
regular everywhere. The only possible poles of r(A) are double
and simple poles; its double coefficient at order e is e(4e−3).
All orders in the table are0 or2 modulo5, so that coefficient
vanishes. A remaining simple pole c/z would give E a nonzero
2c/z^3 term, impossible. Hence r is regular at EVERY point of C.
It is active nilpotent by separable pullback and the exact curvature
identity. This removes a genus-zero or noncompact loophole without
any large computation. The table includes16 collision–spike overlaps.

## 5. Exact scope to preserve when repairing the older translation

The root-form Cartier equivalence and sigma=1+e/d remain valid;
so does the local rational model. What must NOT be retained without
restriction is the assertion that every active nilpotent oper is
recovered with the same integral extension and the same markings
by the unrestricted Bouw–Wewers rule, or that every collision has
zero spike order/exact quartic order2. In particular e=7 can be
unmarked, although that rule calls sigma=11/4 singular.

The reduced quadratic/simple-zero and quartic/double-zero admissible
scopes do not acquire a counterexample here. A corrected general
quartic–regular-oper dictionary should use direct covariance,
curvature and divisor arguments, keeping admissibility explicit.
No ordinary-object deformation criterion, full common-connection
theorem, oper census, or common-cover exclusion was audited.
