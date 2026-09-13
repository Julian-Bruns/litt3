# Proof: positive pointed bundles attached to a first Witt lift

[Statement](../../Theorems/deformations/two_leg_negative_extensions.md).

## 1. Any common negative extension produces a clump

A nonzero element of J_m gives matching nonsplit pointed extensions

    0->O_i --e_i--> E_i --q_i--> omega_i^m->0.                 (1)

The matching is unique because H^0(Z,omega_Z^(-m))=0. Nonzero endpoint
classes remain nonzero on Z by negative-degree etale cohomology
injectivity. All Frobenius iterates remain nonsplit by the negative-power
Cartier calculation in
[joint_tangent_clump_dormancy, Section1](joint_tangent_clump_dormancy.md).
The positive-degree bundles in(1) have matching nowhere-zero sections,
so the general pointed-bundle principle in that proof's Section2 rules
out strong semistability directly.

Thus some common Frobenius iterate is unstable. Etale preservation and
reflection of semistability identify the first index and maximal HN line
N_i on both endpoints after pullback. Its degree exceeds
m*5^n(g(C_i)-1)>0, so N_i cannot map to O_i and has nonzero projection
to omega_i^(m*5^n). An everywhere-invertible projection would split the
iterate of(1), already ruled out. Its nonempty zero divisors Delta_i have
equal pullbacks. Their supports are saturated under BOTH original fiber
relations, giving a clump.

## 2. An arbitrary simultaneous W2 lift supplies such an extension

This step does NOT assume that the FL bundle is indigenous.

For a curve C, set T=F_C^*T_(C^(1))=omega_C^(-5), with canonical
connection. Mochizuki's Cartier/FL construction gives an injective
forgetful map H1_dR(T)->H1(T) and an exact sequence

    0->H1(C^(1),T_(C^(1)))->H1_dR(T)->k->0.                 (2)

Marked W2 liftings of C^(1) identify with the affine fiber of the last
map at the fixed nonzero normalization. A class in that fiber represents
a horizontal extension0->T->G->O->0. Its underlying extension is NONZERO
by the injectivity in(2). These are II Propositions1.1--1.2 and
Definition1.3 in [Mochizuki, A Theory of Ordinary p-adic Curves](https://www.kurims.kyoto-u.ac.jp/~motizuki/A%20Theory%20of%20Ordinary%20p-adic%20Curves.pdf),
printed pp.58--60, read directly; none of their indigenous or ordinary
specializations is required here.

The construction is functorial under finite etale maps with their marked
W2 lifts. Indeed, form its obstruction cocycle using local lifts of
relative Frobenius into the chosen lift of C^(1). The Frobenius square
of an etale cover is Cartesian. Local lifts therefore extend uniquely to
the etale cover; their differences divided by5 pull back under
a*F_C^*T_(C^(1))=F_W^*T_(W^(1)). This proves functoriality of the underlying
H1 class AND its connection and normalization. This is the same
local construction used in
[admissible_two_leg_w2_lifts](admissible_two_leg_w2_lifts.md), before
the additional step that starts from an indigenous connection.

Given a simultaneous marked W2 lift of the span, Witt-Frobenius base
change first gives such a lift of its Frobenius twist. Applying(2) on
the original curves gives FL bundles G_X,G_Y with matching pullbacks
on Z. Dualize to obtain matching pointed extensions

    0->O_i->E_i=G_i^vee->omega_i^5->0.                     (3)

Their common underlying class is nonzero, either by(2) on Z or by
negative-cohomology etale injectivity. Hence J_5!=0. Section1 gives
the clump. This applies to an ARBITRARY simultaneous W2 lift; no matching
projective connection was inserted as an extra hypothesis.

For a no-clump span Section1 with m=1 gives zero joint tangent. The
marked deformation theorem then writes its whole ring as W(k)/(5^e),
where e>=1 or e=infinity. Section2 rules out a W2 point, so e=1.
Every fixed etale refinement has the same deformation ring. This is a
first-obstruction statement, not a nonexistence theorem for its special
fiber.

## 3. Genus two: the first destabilization, including index zero

Normalize(3) by theta_i^(-5). The projective-monodromy argument rules
out strong semistability, and identifies a finite common first index
n>=0. Put P=5^(n+1), so det(F^n E_i)=omega_i^P.

If n>=1, use the canonical connection on F^n E_i=F*F^(n-1)E_i.
The maximal line N_i cannot be horizontal: Cartier descent would give
a destabilizing line one stage earlier. Hence its second fundamental
map to Q_i tensor omega_i is nonzero, where Q_i=F^n E_i/N_i.

If n=0, use the original dual FL connection. Its p-curvature is nonzero
nilpotent everywhere, with kernel exactly the distinguished O-line.
This follows either from the local matrix in II Proposition1.4
(pp.60--61) or by dualizing that proposition. A horizontal line must be
stable under p-curvature. A nilpotent endomorphism acts by zero on a
stable line, so that line must be the O-kernel. But deg N_i>0. Thus the
second fundamental map is again nonzero. This is the extra argument
needed at index zero; the previous-stage Cartier argument cannot be
used there.

On genus-two Y, slope and second fundamental map give

                P<deg N_Y<=P+1.

Therefore deg N_Y=P+1, the second fundamental map is an isomorphism,
and N_Y²=omega_Y^(P+1). Pull back to Z and descend the isomorphism
along the other actual etale leg to obtain the same statement on X.
This uses no division by a covering degree.

Projection of N_i to omega_i^P has the nonempty divisor from Section1.
It is reduced even for the FL connection at n=0. Locally write a generator
of N as A e+B v with A a unit at a zero of B. Since e is horizontal,
the coefficient of n wedge nabla(n), modulo B, is A dB. The second
fundamental map being a unit implies that B has order exactly one.
Thus Delta_Y has P-1 points and Delta_X has(P-1)(g(X)-1) points.

These lines and connections give actual matching regular projective
opers. For n=0 the p-curvature remains nonzero nilpotent everywhere;
for n>=1 it is zero. The determinant connection is the canonical one
on omega^P, and e is horizontal in both cases. The local calculation
of Section4a of the pointed tangent proof therefore applies unchanged:
with q the projection of e into Q, one has

                Q²=omega^(P-1), sigma=q²,
                sigma=u²(dx)^(P-1), u''=r u.

That calculation uses horizontality of e and of the determinant, NOT
zero p-curvature of the entire bundle. Since P=0 in k, it identifies
r with the intrinsic r_s of the common generator. Reducedness of Delta
then gives primitive(weight,zero order)=((P-1)/2,1) or(P-1,2).
All tensors use the original specified pullback identifications.

## 4. Stable extensions, secants and genus-two W2 rigidity

### The nonstable extension locus

Let C be a smooth projective curve of genus g>=2 over any algebraically
closed field, and let L have degree2d>0. The extension space is

    P H1(L^-1)=P H0(omega_C tensor L)^*, of dimension2d+g-2.

For an effective degree-d divisor D, the kernel of
H1(L^-1)->H1(L^-1(D)) has dimension d, since both line bundles have
negative degree. These kernels form a rank-d bundle over Sym^d(C).
Its projectivized image S_d is closed, irreducible and of dimension
at most2d-1.

This is exactly the nonstable extension locus. Membership means that
L(-D)->L lifts to E; its saturation has degree at least d. Conversely,
a saturated line N in E of degree at least d projects nontrivially to
L, since it cannot map into O. Hence N=L(-D_0) for an effective divisor
of degree at most d. Enlarge D_0 to degree d to obtain membership in S_d.

To compute the dimension, put M=omega_C tensor L. A general reduced D
satisfies O(2D)!=L: the Abel image of Sym^d(C) is positive-dimensional,
and multiplication by2 on the Jacobian is finite. Riemann--Roch gives

    h0(M)=2d+g-1,    h0(M(-2D))=g-1.

Thus the2d value and first-jet functionals at D are independent.
At a span point sum_i a_i ev_(P_i) with every a_i nonzero, varying its
coefficients and points gives those functionals. The projective incidence
differential has rank2d-1. Consequently

    dim S_d=2d-1,     codim S_d=g-1.                       (S)

This works in every characteristic, including2; it uses finiteness,
not separability, of multiplication by2. No secant-dimension theorem
from characteristic zero is needed.

### Bound a common extension space

For an endpoint C of the given span, take L=omega_C^m, so d=m(g-1).
Negative-cohomology pullback is injective, so regard J_m as a subspace
of H1(C,L^-1).
Suppose every nonzero class in J_m gives a semistable E on C. It is
then stable: a strictly semistable rank-two bundle is an extension of
equal-degree lines and remains semistable under every Frobenius pullback,
contrary to the positive pointed-bundle principle. Thus P J_m is disjoint
from S_d. Projective dimension and(S) give

    (dim J_m-1)+(2d-1)<2d+g-2,    hence dim J_m<=g-1.       (6)

If the endpoint clump has r>=d points, semistability is automatic.
An unstable common extension has a maximal line N of degree>d. Its
projection to L has a nonempty divisor of degree<d: an empty divisor
would split the nonzero extension. The unique maximal lines and their
projections pull back compatibly from both endpoints, as in Section1.
Their supports therefore give the unique clump, which has r>=d points,
a contradiction.

For genus two, (6) is exactly dim J_m<=1 when1<=m<=r. In this case
S_d is a hypersurface; for m=1 it is the bicanonical conic.

Every nonsplit genus-two extension of omega by O is semistable:
a line of degree at least2 would project isomorphically to omega
and split it. Thus P J_1 always avoids S_1 and dim J_1<=1. In a basis
of canonical sections, H0(omega^2)=Sym^2 H0(omega), and S_1 is exactly
the smooth evaluation conic X0 X2-X1^2=0. This retains the location
of the forbidden tangents, as well as their dimension bound.

The [marked deformation theorem](etale_refinement_deformations.md)
now makes the joint ring a quotient of W(k)[[z]]. For the selected
main pair its established mixed-characteristic nonliftability makes5
nilpotent. A ring such as W(k)[[z]]/(5^e) shows why neither this nor
the parameter bound implies finite length or removes a vertical
component; no realization of this example by a span is asserted.

### A W2 lift and a joint tangent cannot coexist

Assume both exist. The pointed tangent theorem gives a unique reduced
endpoint clump of size r=5^a-1, a>=1, and says its intrinsic r_s is
DORMANT. Section3 applied to the W2 lift therefore cannot have n=0,
which would make that SAME intrinsic r_s active. Thus n>=1, and
uniqueness plus the two reduced divisor formulas give a=n+1 and r>=24.

Apply the weighted bound with m=5: dim J_5<=1. On the other hand, a
nonzero joint tangent on the Frobenius-twisted span pulls back to a
nonzero element of J_5. Its image in(2)'s final k is zero. The actual
W2 lift supplies the FL class in J_5 whose image is the fixed NONZERO
normalization. These classes are linearly independent, using(2) on Z
and its injective forgetful map. Therefore dim J_5>=2, a contradiction.

So every W2-liftable coreless genus-two span has zero joint tangent.
The marked deformation-ring theorem then gives W(k)/(5^e), with e>=2
or infinity. This proof does not confuse source indigenous deformations
with joint curve deformations, and never assumes source ordinariness.

## 5. Where this stops

The new obstruction separates a genuinely first-order-nonliftable
no-clump span from the positive-clump alternatives. It cannot create
a W2 lift for such a span, and so does not exclude that span. On the
positive-clump side the unstable FL case is precisely the already
known active connection range; a semistable FL bundle can still become
unstable at a later Frobenius stage. Section4 adds rigidity for all
W2-liftable genus-two spans but does not prove they lift farther. No upper
bound on that instability index or on e, no W3 lift, and no automatic
source ordinariness is obtained. The remaining one-tangent branch must
fail to lift to W2; that does not by itself make5 zero in its whole ring.
For example W(k)[[z]]/(z²-5,5²) has no W2 point but5!=0. This is an
abstract caution, not a realized correspondence ring.
