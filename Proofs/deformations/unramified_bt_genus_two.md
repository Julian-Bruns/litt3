# Proof: specialize the general lattice, then recover unramified precision

[Statement](../../Theorems/deformations/unramified_bt_genus_two.md).
All source comparisons and coefficient Frobenius arrows are retained.

## The general normalization contains every active unramified component

Apply [the general coefficient theorem](ramified_rapoport_oper.md) with
ramification index e=1. Each determinant height is zero or one,
and their sum is r, so exactly r outgoing edges are positive.
EVERY such source is a degree-one oper in the same isogeny class.
The actual Hodge eigenspaces at these sources are therefore the
claimed active lines. This uses the one general protected transfer
argument; there is no separate binary normalization.

For the ordinary group, all f Hodge modules are already free in the
unramified setting. Use the intrinsic free-Hodge untwisting in the
general proof, retaining \(G\cong F_C^{b*}G_0\). A nonzero partial
Kodaira--Spencer map propagates around the height-one cycle by its
local curvature formula. Thus all terminal Hodge degrees are one;
reversing the untwisting gives every original degree p^b. The Hasse
derivative gives reduced partial divisors of degree p-1.

## Uniqueness of the nonzero-Kodaira--Spencer lattice

Let $G,G'$ on a smooth curve be generically ordinary rank-two
$\mathcal O_K$-BT groups, both with nonzero Kodaira--Spencer maps,
and let their rational Dieudonné modules be $K$-linearly isomorphic.
For generically ordinary groups with a nonordinary fiber, the partial
Hasse inequalities \(d_i\le p d_{i-1}\) and a Hasse zero make all
Hodge degrees positive. The local curvature formula(G9a) in the
[general proof](ramified_rapoport_oper.md#every-positive-edge-leaves-an-oper),
valid in any genus, makes every partial Kodaira--Spencer map nonzero.
A horizontal line differs from the Hodge line and projects nontrivially
to its negative-degree quotient. Thus each reduced rank-two
connection is stable of degree zero.

Apply the stable-lattice argument from
[crystalline oper lifting](crystalline_oper_lifting.md) componentwise.
That argument only uses stability of the reductions here, not an
oper isomorphism. Under the fixed rational identification, the two
lattices differ in component $i$ by $p^{a_i}$ for some integer $a_i$.
Frobenius in an ordinary component has a unit elementary divisor.
Its preservation of the second lattice therefore requires
$a_{i-1}\ge a_i$. Going around the cycle makes all $a_i$ equal.
One scalar power of $p$ identifies the FULL Dieudonné crystals,
including $F,V$ and the integer action, and hence the groups.

This proves the required uniqueness without a classification of
generic finite subgroup schemes or a simultaneous Galois closure.

The stated nonzero-Kodaira--Spencer uniqueness also holds without
the mixed-polygon hypothesis. Here one can retain the generic
argument of [Krishnamoorthy, Lemma8.8](https://arxiv.org/pdf/1711.04797):
divide an isogeny by its maximal scalar power of $p$. The connected
and étale factors of $G[p]$ are simple $\mathbf F_{p^f}$-modules.
Their extension is nonsplit when Kodaira--Spencer is nonzero, as
is seen in the ordinary Dieudonné Hodge matrix. A remaining
nontrivial kernel would contain the connected factor and inject
the étale quotient into $G'[p]$, splitting its extension. This
contradicts nonzero Kodaira--Spencer for $G'$. Thus the remaining
isogeny is an isomorphism. This last argument is not needed for
the mixed case proved above.

## Plain rational compatibility lifts the original span

Choose one active crystalline oper on Y. The specified rational source
comparison respects the coefficient action and its chosen component.
[Oper-lattice descent](crystalline_oper_lifting.md#a-rationally-compatible-lattice-descends-from-one-endpoint)
descends that SAME lattice and maximal line through the other leg.
Its integral oper crystal lifts both ORIGINAL maps over W(k), by
the divided-power oper theorem. This step requires only the rational
crystal comparison. Compatibility on an étale source refinement
descends by the marked refinement equivalence.

For the clump profile, the comparison additionally respects EVERY
Frobenius arrow. The general theorem then descends all active lattices
and their contracted maps through the actual other leg.

## From a nonisoclinic unramified companion to the integral data

Let the positive generic slope difference at the indicated place
be $\delta$. The rank-two slope bound gives $0<\delta\le1$.
Twist to make the smaller generic slope zero. After extending the
finite constant field if necessary,
[Krishnamoorthy, Proposition7.4](https://arxiv.org/pdf/1711.04797)
descends this normalized companion to $K=E_v$. Its generic slopes
are $(0,\delta)$. Newton specialization and constant determinant
put all slopes in $[0,\delta]\subseteq[0,1]$. Some fiber has two
strictly positive slopes, because otherwise the generic polygon
would be constant and its global slope filtration on the proper
curve would contradict absolute irreducibility. These facts are
preserved by the actual finite étale maps.

For completeness the integer action can be retained in constructing
a Dieudonné lattice. Forget coefficients and start with a lattice in
the rank-$2f$ isocrystal. Replace it by the sum of its images under a
$\mathbf Z_p$-basis of $\mathcal O_K$, then perform the $F$- and
$V$-stable saturation and reflexive-hull construction in
[Krishnamoorthy--Pál, Lemma5.8](https://arxiv.org/pdf/1809.02106).
These operations preserve the integer action, since it commutes with
$F,V$ and the connection. The lemma's excluded base locus has
codimension at least two, hence is empty on a smooth curve. De Jong's
equivalence produces a full group with its actual
$\mathcal O_K$-action. Its dimension is $r=f\delta$, an integer
between one and $f$. The general lattice theorem constructs an integral oper component
on the genus-two endpoint.

The arithmetic pullback isomorphism makes the companions' source
Frobenius polynomials equal. Their pullbacks are still absolutely
irreducible: any rank-one subobject would have constant slope, which
is incompatible with generic slopes $(0,\delta)$ and a fiber whose
two slopes both lie strictly between zero and $\delta$.
Companion uniqueness gives an isomorphism over
$\overline{\mathbf Q}_p$. It descends to $K$, since scalar extension
commutes with Hom and the invertible locus is a nonempty open in that
finite-dimensional Hom space over the infinite field $K$.
Forget Frobenius and take the selected rank-two component. The
one-endpoint crystalline lattice-descent criterion now supplies
the simultaneous lift. No initial integral choice on the other
endpoint is necessary.

If the trace field is unramified at every place above $p$, the
all-companion unit-root criterion supplies a nonisoclinic place
because the image is infinite. The proof applies there. For a
ramified place, use the coefficient-free lattices and protected-oper
height transfer of [the ramified proof](ramified_rapoport_oper.md).
That extension now removes the trace-place restriction, while the
geometric profiles below use the particular unramified construction.

## Unramified heights force the exact exceptional polygon

For the Frobenius-compatible coreless span, the general common-divisor
theorem has m=r. It gives
\[
r\mid f,\qquad a=f/r,\qquad |S_Y|=p^a-1.
\]
At an exceptional point, ALL contracted Hasse maps vanish. The image
of each reduced contracted Frobenius equals the Hodge line killed
by the next. Their two-step matrix product is divisible by p and has
determinant p² times a unit, so dividing by p gives an invertible
semilinear map. Pairing over two full contracted circuits gives
\(F^{2f}=p^r U\), U invertible. Every exceptional slope is therefore
\(r/(2f)=1/(2a)\); two circuits also cover odd r.

If a>1, every active component has an incoming zero-height isomorphism,
so its reduced connection is a canonical Frobenius pullback and dormant.
If a=1, the local curvature formula gives nonzero nilpotent p-curvature.
At the exceptional points all Hodge and conjugate lines then coincide;
the a-number is f and the fibers are superspecial.

With geometrically constant determinant on BOTH endpoints, the general
[determinant profile](ramified_rapoport_oper.md#determinant-torsion-gives-the-exact-canonical-profile)
gives the two-torsion classes tau_X,tau_Y, their r-th power triviality,
and the exact primitive canonical weight and zero multiplicity.
Odd r forces both classes trivial. This contains the original r=1
profile and the ordinary r=f clump, retaining the sharper unramified
Newton slopes which use the equal height-one steps.
