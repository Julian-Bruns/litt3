# Proof: localizing the shared ring leaves only a point or a line

[Statement](../Theorems/Thm_coreless_connection_spectrum.md).
Author /root,2026-09-07; version2,2026-09-08. No independent audit of
the whole statement; the retained Igusa construction has its own scoped audit.

## 1. The curvature quantities used

For a projective connection r in characteristic five put E=r''−3r^2.
The scalar companion calculation in `cartier_dormant_secants` gives
the horizontal fifth-iterate matrix

    M5=[[E',3E],[E''+3rE,−E']],
    det(psi)=−(E')^2−3E(E''+3rE),                    (1)

where psi=−M5 is p-curvature. In particular dormancy is E=0.
The expression E(dt)^4 is an intrinsic quartic differential: p-curvature
followed by projection from the oper line to the oper quotient is a
section of F^*omega tensor omega^−1=omega^4, with coefficient−3E.
Equivalently this follows by substituting the projective-coordinate
rule. Determinant p-curvature is an intrinsic section of omega^10.
For regular connections these tensors are regular, and both commute
with the ACTUAL etale pullbacks.

If A=k, two common regular connections would differ by A_2=0, so at
most one exists. It has E in A_4=0 and is therefore dormant. Intersections
of affine-linear spaces have no scheme multiplicities, proving this case.

## 2. A rational connection and a localization argument

Assume A=k[s], d>=2. Primitivity gives5 not dividing d. Put
ell=a'/(d a), so r_s=−ell'/2+ell^2/4. The coordinate chain rule makes
r_s an intrinsic rational projective connection with poles only at S.
It descends through both endpoints since their tensors actually agree.
This is the connection already constructed, with explicit solutions,
in [the all-weight equation theorem](../routes/global/EXPLICIT_SECOND_ORDER_EQUATION_FOR_CARTIER_ZERO_PLURIFORMS.md).
No new clump or rational function is assumed to descend.

If r is any common regular connection, q=r−r_s is a shared rational
quadratic differential whose poles are supported on S. For sufficiently
large N, both endpoint sections q s^N are regular. Hence

    q s^N ∈ A_(2+Nd).

If d>2 this space is zero, so q=0. If d=2 it is k s^(N+1), so q=c s,
which is already REGULAR. It follows that a common regular connection
exists iff r_s is regular; its entire space is respectively the point
r_s or the line r_s+k s. This pole-clearing step is what prevents an
unrelated regular connection from cancelling r_s's poles.

## 3. Exact regularity and Cartier type

At a zero write a=t^e u, u a unit. The double-pole coefficient of r_s
is E0(E0+2)/4, where E0=e/d in F5. It vanishes exactly for E0=0 or3.
Otherwise the double pole cannot disappear. When it vanishes there is
at most a simple pole.

In the Cartier-zero branch the all-weight equation theorem gives E(r_s)=0.
In the nonzero branch d is2 or4. Normalize the shared scalar eigenvalue
to1. For d=2, `cartier_dormant_secants` gives

    E(r_s)=3s^2.

For d=4, take a rational quadratic root b of s in a separable quadratic
extension. Cartier's product rule gives C_1(b^3)=b. The same secant
identity yields E(r_s)=3b^2=3s, an identity over the original field.
Here r_s=b''/b; changing b's sign does not change that connection.

Thus E(r_s) is regular in every case. But a genuine simple pole of r_s
would give a nonzero pole of order3 in r_s''−3r_s^2. The possible simple
pole therefore vanishes. This proves the stated regularity iff, including
infinity and all unit coefficients.

For every d the rational connection r_s has a rational horizontal
solution a^j, where2dj=−1mod5. In the basis y=a^j z,
w=a^(2j)z', its connection matrix is strictly upper triangular.
Its p-curvature is therefore nilpotent. It is dormant exactly when the
eligible Cartier image of s vanishes, by the explicit primitive test in
the all-weight theorem. This proves the single-point assertions.

## 4. The complete line calculation, including scheme lengths

For d=2, write s=a(dt)^2 and r0=a''/a. If C_1(s^3)=epsilon s with
epsilon0 or1, the secant identities give

    a''=r0 a,             E(r0)=3epsilon a^2.

For constant parameter t put r_t=r0+t a. Direct substitution gives

    E(r_t)=3(epsilon−t^2)a^2,
    det(psi_(r_t))=4t(epsilon−t^2)^2 a^5.             (2)

For the second identity, write E(r_t)=kappa a^2 in(1). The relation
a''=r0 a makes the bracket
((a^2)')^2+3a^2((a^2)''+3r_t a^2) equal4t a^5.
Since kappa^2=4(epsilon−t^2)^2, equation(2) follows.
The nonzero sections a^2 and a^5 have a nonzero scalar coordinate.
Consequently all their coefficient equations generate precisely the
displayed ideals in k[t], even over nonreduced parameter algebras.
This proves the exact schemes, not just their geometric roots.

At epsilon1 the midpoint t=0 is active nilpotent and t=±1 are dormant.
At epsilon0 the only point is t=0, with the asserted lengths.
The short [jet checker](../scripts/check_cartier_dormant_secants.sage)
checks the determinant identity separately, without endpoint sampling.

## 5. Fixed-X interpretation and boundaries

Write rX=|image_X(S)|. The actual uniform divisor identity is e rX=16d.
Since5 does not divide d, neither e nor rX is divisible by5. Thus the
regularity condition reduces to e=−2dmod5, equivalently rX=2mod5.
`fixed_x_nonzero_cartier_profiles` then gives exactly the two retained
nonzero profiles in the statement. The zero-Cartier quadratic regular
case is excluded by `cartier_dormant_secants` (equivalently its dormant
intersection here would have length2, contradicting that theorem's
reducedness assertion for fixedX).

No curve has been replaced and no root was asserted to descend through
the other map. The quadratic extension in Section3 proves only a
rational identity that then descends. In particular this argument does
not replace a non-Galois leg by a simultaneous Galois closure.
It does not prove existence of a common regular connection in the
no-generator case, nor identify compatible endpoint opers in the other
cases. Ordinary-indigenous lifting hypotheses concern a larger tangent
space on the source; they do not follow from these intersection lengths.

## 6. Weight one and a genuine empty-connection family

Let alpha=f*alpha_X=g*alpha_Y be a nonzero common one-form in an actual
coreless span. In a separating coordinate write alpha=a dt and put

    r_alpha=-a''/(2a)+3(a'/a)^2/4.

The projective coordinate rule makes this an intrinsic rational connection,
as in Section2. It is shared because its formula commutes with the actual
etale maps. For ANY shared rational connection r,
(r-r_alpha)/alpha^2 belongs to both endpoint function fields. Corelessness
makes it constant. Hence the ENTIRE common rational-connection space is

    r_alpha+k alpha^2.                                      (3)

In particular no other rational connection can cancel a pole of r_alpha
while being regular at both endpoints: alpha^2 is already regular.

At a zero write a=t^e u, with u a unit, and b=u'/u. Then

    r_alpha=e(e+2)/(4t^2)+e*b/(2t)-b'/2+b^2/4.             (4)

Cartier carries the shared one-dimensional space to itself, so after
rescaling C(alpha)=epsilon alpha, epsilon=0 or1. If e=0mod5, (4) is
regular. If e=3mod5, write e=5m+3. The coefficient u_1 of t^(e+1)
in alpha contributes u_1^(1/5)t^m dt to C(alpha). Since m<e, the
Cartier eigenrelation forces u_1=0. Thus b(0)=0 and (4) is regular.
For all other e modulo5 its double-pole coefficient is nonzero.
This proves the same regularity criterion for d=1, including the possible
simple pole, rather than merely checking the double-pole coefficient.

Put q=alpha^2. In characteristic5, r_alpha=q''/q. Cartier's product
rule gives C_1(q^3)=epsilon q. Consequently Section4 applies verbatim
with q in place of s, proving the exact dormant/nilpotent algebras in
the statement. No claim that q is primitive is needed for that calculation.

Now use the already constructed
[genus-seventeen partial Igusa family](../routes/global/UNBOUNDED_DOUBLE_ZERO_HECKE_LEAVES_ON_A_FIXED_GENUS17_CURVE.md),
audited relative to its retained quaternionic Igusa input. Its fixed
curve P has a Cartier-fixed alpha with div(alpha)=2D, D reduced, and
jointly minimal coreless etale spans of degrees12*11^(n-1), n>=1,
preserving alpha through BOTH maps. At every zero, (4) has double-pole
coefficient2 in F5. Equation(3) therefore contains no regular connection.

This is an explicit counterexample to universal existence of a shared
regular projective connection in positive characteristic, even with a
nonempty clump, fixed endpoints, and unbounded actual etale degrees.
It is not a counterexample to Litt, and its endpoints need not have
the fixed pair's absolute simplicity or Hom-zero condition. Those
extra endpoint hypotheses would have to enter any proposed repair.
