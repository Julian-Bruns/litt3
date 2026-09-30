# Proof: shared pointed extensions, clump support and first Witt lifts

[Statement](../../Theorems/deformations/two_leg_negative_extensions.md).

## 1. Any common negative extension produces a clump

A nonzero element of J_m gives matching nonsplit pointed extensions

    0->O_i --e_i--> E_i --q_i--> omega_i^m->0.                 (1)

The matching is unique because H^0(Z,omega_Z^(-m))=0. Nonzero endpoint
classes remain nonzero on Z by negative-degree etale cohomology
injectivity. All Frobenius iterates remain nonsplit by the negative-power
Cartier calculation in
[pointed_bundle_instability, Section1](pointed_bundle_instability.md).
The positive-degree bundles in(1) have matching nowhere-zero sections,
so the general pointed-bundle principle in that proof's Section2 rules
out strong semistability directly.

Thus some common Frobenius iterate is unstable. Etale preservation and
reflection of semistability identify the first index and maximal HN line
N_i on both endpoints after pullback. Its degree exceeds
m*p^n(g(C_i)-1)>0, so N_i cannot map to O_i and has nonzero projection
to omega_i^(m*p^n). An everywhere-invertible projection would split the
iterate of(1), already ruled out. Its nonempty zero divisors Delta_i have
equal pullbacks. Their supports are saturated under BOTH original fiber
relations, giving a clump.

## 2. An arbitrary simultaneous W2 lift supplies such an extension

This step does NOT assume that the FL bundle is indigenous.

For a curve C, set T=F_C^*T_(C^(1))=omega_C^(-p), with canonical
connection. Mochizuki's Cartier/FL construction gives an injective
forgetful map H1_dR(T)->H1(T) and an exact sequence

    0->H1(C^(1),T_(C^(1)))->H1_dR(T)->k->0.                 (2)

Marked W2 liftings of C^(1) identify with the affine fiber of the last
map at the fixed nonzero normalization. A class in that fiber represents
a horizontal extension0->T->G->O->0. Its underlying extension is NONZERO
by the injectivity in(2). These are II Propositions1.1--1.2 and
Definition1.3 in [Mochizuki, A Theory of Ordinary p-adic Curves](https://www.kurims.kyoto-u.ac.jp/~motizuki/A%20Theory%20of%20Ordinary%20p-adic%20Curves.pdf),
printed pp.58–60. Their torsor isomorphism F:D→A applies before
any indigenous or ordinary specialization.

The construction is functorial under finite etale maps with their marked
W2 lifts. Indeed, form its obstruction cocycle using local lifts of
relative Frobenius into the chosen lift of C^(1). The Frobenius square
of an etale cover is Cartesian. Local lifts therefore extend uniquely to
the etale cover; their differences divided by p pull back under
a*F_C^*T_(C^(1))=F_W^*T_(W^(1)). This proves functoriality of the underlying
H1 class, connection and normalization.

Given a simultaneous marked W2 lift of the span, Witt-Frobenius base
change first gives such a lift of its Frobenius twist. Applying(2) on
the original curves gives FL bundles G_X,G_Y with matching pullbacks
on Z. Dualize to obtain matching pointed extensions

    0->O_i->E_i=G_i^vee->omega_i^p->0.                     (3)

Their common underlying class is nonzero, either by(2) on Z or by
negative-cohomology etale injectivity. Hence J_p!=0. Section1 gives
the clump. This applies to an ARBITRARY simultaneous W2 lift; no matching
projective connection was inserted as an extra hypothesis.

For a no-clump span Section1 with m=1 gives zero joint tangent. The
marked deformation theorem then writes its whole ring as W(k)/(p^e),
where e>=1 or e=infinity. Section2 rules out a W2 point, so e=1.
Every fixed etale refinement has the same deformation ring. This is a
first-obstruction statement, not a nonexistence theorem for its special
fiber.

### The converse is a normalization test on the actual shared class

For each curve put T=omega^-p with its canonical connection. Since
H0(T)=H0(T tensor omega)=0, the degree-one de Rham group embeds in
H1(T) with image ker(nabla:H1(T)->H1(T tensor omega)). The Cartier
sequence(2) is functorial for the two actual etale maps, with its
final term identified with H0(O)=k. A shared underlying class in
J_p^nabla therefore has unique horizontal extension lifts on the
two endpoints, and these lifts match on Z. Their final scalar is
the same, giving chi:J_p^nabla->k.

If chi vanishes on such a class, sequence(2) gives unique endpoint
preimages under Frobenius in H1(T_(C^(1))). Their pullbacks agree:
Frobenius is injective on negative H1 also on Z. Thus ker chi is
exactly F*J_1^(1), and the displayed sequence is exact.

Normalize the nonzero FL scalar in Section2 to1. The torsor
isomorphism there identifies each endpoint class with a marked W2
lift of its Frobenius twist. Pull the two lifts back by the original
etale maps. Their FL classes on Z agree, so the torsor isomorphism
on Z identifies the two source lifts. This identification preserves
the marking and is unique since H0(Z,T_Z)=0. Hence BOTH maps exist
on that same source lift. Witt-Frobenius base change gives the stated
convention for the original span. Conversely any simultaneous lift
has scalar1 by Section2. This proves the exact fiber description
and the claimed iff, without assuming a common indigenous structure.

## 3. Genus two: one pointed-oper calculation at every index

The positive pointed-bundle principle gives a finite common first
instability index n>=0 for the dual FL extensions(3). Put P=p^(n+1).
At n>=1 the maximal line cannot be horizontal for the canonical
Frobenius connection: Cartier descent would destabilize the preceding
iterate. At n=0 use the original dual FL connection.
[Mochizuki II, Proposition1.4 and Corollary1.6](https://www.kurims.kyoto-u.ac.jp/~motizuki/A%20Theory%20of%20Ordinary%20p-adic%20Curves.pdf#page=60)
give its nowhere-zero nilpotent p-curvature and distinguished degree-zero
kernel. A horizontal positive-degree line is therefore impossible.

Both connections have horizontal e and canonical determinant connection.
The shared [pointed-oper calculation, Sections4–4a](pointed_bundle_instability.md#4-a-common-pointed-oper-calculation)
now gives all assertions at once: deg N_i=(P+1)(g(C_i)−1), an
invertible second fundamental map, matching reduced divisors with
|Delta_Y|=P−1, and the intrinsic potential r_s of the primitive tensor.
The oper is active admissible at n=0 and dormant at n>=1.
The primitive (weight,zero order) is ((P−1)/2,1) or (P−1,2).

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
characteristic-five main pair its
[mixed-characteristic nonliftability](../curve_arithmetic/liftable_coreless_target_finiteness.md) makes5
nilpotent. A ring such as W(k)[[z]]/(5^e) shows why neither this nor
the parameter bound implies finite length or removes a vertical
component; no realization of this example by a span is asserted.

## 5. The complete instability alternatives and support at the clump

Let D_X,D_Y be the reduced images of the unique positive clump,
r=deg D_Y, and take a nonzero class in J_m. Its pointed extensions
and all their Frobenius pullbacks are nonsplit by Section1. Initial
strict semistability is impossible: a rank-two extension of lines of
the same degree is strongly semistable, contradicting the positive
pointed-bundle principle. Thus the initial bundles are either unstable
or stable, with their common status detected after actual etale pullback.

In the unstable case, let N_i be the maximal line. Its projection
to omega_i^m has a nonempty divisor Delta_i and is preserved by both
maps. Its multiplicities are constant on fibers of either map. Every
nonempty multiplicity level set on Z is therefore a clump. Uniqueness
of the positive clump forces

    Delta_i=a D_i,  a>=1,   N_i=omega_i^m(-a D_i).

On genus-two Y, instability says 2m-ar>m, hence ar<m. This proves
the first alternative and bounds a by q=floor((m-1)/r).

In the stable case let n>=1 be the first Frobenius-instability index
given by the same pointed-bundle principle, and put P=m*p^n. The
canonical connection on F^(n)*E_i has horizontal distinguished section
and canonical determinant. Its maximal line cannot be horizontal,
since Cartier descent would destabilize the preceding iterate. Apply
the general pointed-oper calculation of
[pointed_bundle_instability, Sections4--4a](pointed_bundle_instability.md#4-a-common-pointed-oper-calculation)
with this P. The second fundamental map is an isomorphism and the
projection divisor is REDUCED of degree P-1 on Y. It is the unique
clump, so

                         r=m*p^n-1.

That calculation also identifies the induced regular dormant oper
with the intrinsic r_s. Its distinguished section squared is the
shared tensor of weight P-1 and divisor twice the reduced clump;
the exponent of its primitive generator divides2. This gives exactly
the stated primitive weights and multiplicities. No W2 lift was
used in this argument.

When 1<=m<=r, the unstable alternative is impossible. The exact
equation is consequently necessary, and the dimension bound already
proved in Section4 applies. An active or nonregular intrinsic r_s
also excludes the stable alternative, proving its stated vanishing.

Finally suppose the stable alternative is excluded and fix q as
above. Lifting omega_i^m(-aD_i)->omega_i^m to E_i is precisely the
vanishing of the extension after pullback along that inclusion.
Thus its class lies in the kernel for twist aD_i, hence in the kernel
for qD_i. The exact principal-parts sequence is

    0->omega_i^-m->omega_i^-m(qD_i)->P_i->0.

Both line bundles have negative degree: deg D_i=r*(g(C_i)-1),
and qr<m. Consequently its boundary H0(P_i)->H1(omega_i^-m)
is injective and has exactly that kernel as image. It supplies a
unique principal part. Pulling both sequences to Z gives the SAME
line bundle and divisor. The corresponding boundary on Z is still
injective by the same negative-degree calculation. Equality of the
two extension classes therefore forces equality of the actual
principal parts there. This proves support and uniqueness on both
legs, including the case q=0.

The graph on the finite clump obtained by joining points in the same
f-fiber or g-fiber is connected. Otherwise each connected component
would itself be a nonempty clump. A common principal part vanishing
at one point vanishes along every such edge: the completed local
maps are isomorphisms, and its values come from a single endpoint
principal part. It therefore vanishes everywhere. Restriction to
one point embeds the common space into the q-dimensional local
principal-parts space there. This proves the final dimension bound.

## 6. Cartier descent of the exceptional string

Write r+1=u*p^a with p not dividing u. Section5 gives exactly the
listed possible weights in1,...,r. Let j=u*p^i<=r with i>=1.
The preceding weight j-1 is not on this list: for u>1 it is not
divisible by u, and for u=1 an odd-prime power minus1 is not a
power of p. Consequently J_(j-1)=0. The canonical connection on
omega^-j therefore kills every class in J_j.

Put v=j/p. For any endpoint the Cartier de Rham sequence for
F*omega^-v has the two terms

    H1(omega^-v) and H0(omega^(1-v)).

If v>=2 the second is zero. The forgetful map to H1(omega^-j)
is injective, since H0(omega^(1-j))=0, with image the kernel of
the canonical derivative. Every class of J_j therefore has unique
endpoint preimages under Frobenius. Their pullbacks agree by the
same injectivity on Z. Thus F*:J_v^(1)->J_j is an isomorphism.
This proves every asserted arrow except v=1, where the extra
Cartier term is k and is exactly the normalization in Section2.

When u=1 and a>=2, Section5 gives J_(p-1)=0 and dim J_p<=1.
When a=1, r=p-1: the low-weight spectrum still gives J_(p-1)=0,
and the one-point principal-parts bound gives
dim J_p<=floor((p-1)/r)=1. Hence in both cases J_p^nabla=J_p,
and Section2 supplies the stated exact normalization sequence.
The dimensions and the isomorphisms above prove the string description.

### A shorter proof of first-Witt rigidity

If a joint tangent is nonzero, Section5 with m=1 gives r=p^a-1
for some a>=1. The preceding paragraph bounds dim J_p by1. Its
subspace F*J_1^(1) is already a nonzero line in ker chi, so chi=0.
The iff criterion of Section2 rules out a simultaneous W2 lift.

Thus every W2-liftable coreless genus-two span has J_1=0 and marked
deformation ring W(k)/(p^e), with e>=2 or infinity. This proof uses
only the shared extension spaces and their normalization; it does not
identify them with source indigenous tangent defects. Section3 retains
the finer active/dormant description of the lifted pointed oper.

## 7. A leading jet constructs the boundary class

Here is the elementary construction in its general form. On a
smooth projective hyperbolic curve C let s be a nonzero tensor of weight d with divisor
eD, where D is reduced and e>=1. The conormal isomorphism

    O(-D)|D = I_D/I_D^2 --d--> omega_C|D

identifies the leading jet of s with a nowhere-zero section

    lead_D(s) in H0(D,omega_C^(d+e)|D).

For any integer l>=1, its inverse l-th power is a section of
omega_C^(-l(d+e))|D. Put m=l(d+e)-1. The dual conormal
isomorphism identifies this section with a SIMPLE principal part
of omega_C^-m on D, since

    omega_C^-m(D)/omega_C^-m = omega_C^(-(m+1))|D.

In a uniformizer z with s=z^e A(z)(dz)^d, the principal part is
A(0)^(-l) z^-1 (dz)^(-m). The conormal construction, rather than a
choice of coordinate, proves that this expression is intrinsic.
All these operations commute with actual etale differential pullback.
Thus a shared tensor produces matching principal parts on BOTH
endpoints. If m>d/e, then

    deg omega_C^-m(D) = (2g(C)-2)(-m+d/e)<0.

The principal-parts boundary is injective. Its nonzero section
therefore gives a nonzero common class in J_m. This construction
does not require genus two, corelessness or an ordinary curve;
these hypotheses are only needed for the later dimension and
instability conclusions. The case e=l=1 is deliberately excluded
by m>d/e: its principal part can be the global rational tensor1/s
and its boundary need not be nonzero.

Now take a coreless span with genus-two endpoint and primitive
multiplicity e=1 or2. The tensor tau=s^(2/e) has weight r and
divisor2D. Apply the construction to tau with l=1 and m=r+1.
The degree condition holds, giving a nonzero class in J_(r+1).
Part5's one-point bound at this weight is1, so it spans that space.
Scaling s changes the generator by a nonzero scalar and preserves
the line.

For every r>=1, the low-weight spectrum gives J_r=0: the equation
r*p^n=r+1 is impossible for an odd prime and n>=1. If p divides
r+1, the canonical derivative therefore kills the entire boundary
line J_(r+1). The Cartier argument in Section6 applies at this
boundary too. Whenever v=(r+1)/p>=2, it gives the isomorphism

    F*:J_v^(1) -> J_(r+1).

Continue down the already established string. For u>1 all spaces,
including J_u, are nonzero lines. For u=1, the descent stops at
J_p, which is a line also when a=1 and it is itself the boundary
space. Section2's exact normalization sequence then gives exactly
the tangent or first-Witt alternative. If chi is nonzero, its
normalization-one fiber is a single point, so the entire marked
span has a unique simultaneous W2 lift.

## 8. Which actual spans have a nontrivial deformation ring

If R!=k, either its relative tangent J_1 is nonzero, or J_1=0
and the marked deformation theorem gives R=W(k)/(p^b), with
b>=2 or infinity. The second case has a W2 point. In the first
case Section5 applied to J_1 forces r=p^a-1 and primitive
multiplicity1 or2. In the second case the first-instability
calculation for a W2 lift in Section3 forces precisely the same
clump profile. Thus every nontrivial R has that profile.

Conversely, for that profile Section7 gives a nonzero J_p line.
Its exact normalization sequence forces either a nonzero tangent
or a simultaneous W2 lift. Each makes R!=k. This proves the iff
without assuming either a first lift or a tangent in advance.
In particular, the previously known no-clump result extends to
every positive-clump profile outside this exceptional list.

Under the stated semistability-through-h hypothesis, a nonzero
joint tangent has first instability a by Section5 at m=1. Thus
a>h. If an exceptional clump instead has a<=h, the exact dichotomy
of Section7 forces its unique simultaneous W2 lift. This uses only
the endpoint semistability hypothesis, not any supposed lift of
its matching extension beyond the first Witt level.

## 9. Scope

A no-clump span can still exist only in characteristic p; the obstruction
does not exclude its special fiber. Positive-clump W2 lifts may have
arbitrarily late first instability or fail at a higher Witt level.
Conversely, a span with a nonzero joint tangent has no W2 point, but
this alone does not make p zero in its entire deformation ring:
W(k)[[z]]/(z²−p,p²) is an abstract counterexample to that inference.

The common pointed-oper calculation and the all-odd-characteristic
W2-rigidity argument have bounded medium audit PASS,
/root/audit_extension_fiber_scope,2026-09-14. The inherited secant and
lifting inputs retain the scoped audits linked from the statement.
The normalization converse, extension spectrum, support bound,
Cartier strings and leading-jet deformation criterion have independent
bounded medium audit PASS in the
[extension-spectrum audit](../../Research/audits/TWO_LEG_EXTENSION_SPECTRUM_AUDIT_2026_09_15.md).
