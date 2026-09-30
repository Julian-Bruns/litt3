# Unramified rank-two coefficients force a common lift

Let $k$ be algebraically closed of characteristic $p>2$, and let
$K/\mathbf Q_p$ be unramified of degree $f$, with ring of integers
$\mathcal O_K$. A rank-two $\mathcal O_K$-BT group means a full
$p$-divisible group whose rational Dieudonné module has rank two
over $K$ (and whose underlying height is $2f$).

Suppose $C$ has genus two and such a group $G/C$ has nonconstant
Newton polygon and generic slopes $(0,r/f)$, with $1\le r\le f$.
Then intrinsic Frobenius untwisting within its isogeny class produces
an integral rank-two crystalline summand with a Hodge line of degree
one and Kodaira--Spencer isomorphism. No abelian-scheme realization
or polarization is required. The summand need not be Frobenius-stable.

Consequently, let $X\xleftarrow f Z\xrightarrow g Y$ be an actual
finite bi-étale span with $g(Y)=2$. Suppose rank-two $K$-isocrystals
on the endpoints have isomorphic actual source pullbacks, and the
one on $Y$ has such a BT realization. Then the ORIGINAL span lifts
simultaneously over $W(k)$. Only rational compatibility is needed:
the oper lattice on $Y$ descends through the other map by
[crystalline oper rigidity](crystalline_oper_lifting.md).
Compatibility on a connected finite étale refinement also suffices.

## Common arithmetic local systems

Suppose the actual span is defined over a finite field and its
endpoints carry absolutely irreducible rank-two
$\overline{\mathbf Q}_\ell$-local systems, $\ell\ne p$, with trivial
determinant, infinite image, and isomorphic ARITHMETIC pullbacks.
Let $E$ contain their Frobenius traces. Assume that at one place $v$
of $E$, the completion $E_v/\mathbf Q_p$ is unramified and the
corresponding crystalline companion is not everywhere isoclinic.

Then the original geometric span lifts over $W(k)$.
In particular it suffices that $E$ be unramified at every place above
$p$: infinite image supplies a nonisoclinic companion somewhere.
Neither slope difference one nor a prior integral lattice is required.

The main candidate therefore excludes this class of common systems.
For the backup the conclusion is the still-open fully liftable branch.
Every ramified coefficient place and residue degree is now covered
by [the ramified extension](ramified_rapoport_oper.md); its
arbitrary-cycle argument removes the trace-place restriction from
the general common rank-two lifting consequence.
Construction of a common system from a bare span remains open.

## The smallest slope gap fixes the entire exceptional profile

In the arithmetic assertion, suppose the generic slope difference
is $1/f$. For a coreless span its unique clump has exactly
\[
|g(S)|=p^f-1
\]
points on the genus-two endpoint. The normalized companion has
exceptional slopes $(1/(2f),1/(2f))$. Its shared canonical ring has
primitive weight $(p^f-1)/2$ and primitive zero multiplicity one.
For $f>1$ the compatible oper reduction is dormant; for $f=1$ it
has nonzero nilpotent $p$-curvature. These are statements about the
actual span and its common coefficient, not constructions of either.

More generally the cardinality and exceptional-slope assertions hold
for rationally compatible rank-two $F$-isocrystals with a mixed BT
realization of generic slopes $(0,1/f)$ on the genus-two endpoint.
The canonical-weight assertion additionally uses geometrically
trivial determinant, as supplied by the arithmetic normalization.

## The ordinary subcase gives more precise geometry

Let $G/C$ be such a group on a smooth projective curve, generically
ordinary, with at least one nonordinary fiber. Its dimension is $f$.
The $f$ Hodge eigenspaces are lines of positive degrees $d_i$.
Intrinsic Frobenius untwisting eventually gives a group $G_0$ in its
isogeny class with nonzero Kodaira--Spencer map.

If $g(C)=2$, then ALL the Hodge eigenlines of $G_0$ have degree one,
and each partial Kodaira--Spencer map is an isomorphism. Hence
\[
G\simeq F_C^{a*}G_0,\qquad d_i=p^a\quad\text{for every }i
\]
for some $a\ge0$. Each partial Hasse divisor of $G_0$ is reduced of
degree $p-1$. No abelian-scheme realization or polarization is assumed.

## Uniqueness and the ordinary clump

Let $X\xleftarrow f Z\xrightarrow g Y$ be an actual finite bi-étale
span of smooth projective hyperbolic curves, with $g(Y)=2$.
Suppose rank-two $\mathcal O_K$-BT groups on its endpoints have
$\mathcal O_K$-linearly isogenous pullbacks on the source, and the
group on $Y$ is generically ordinary with a nonordinary fiber.
Compatibility may instead hold after a connected finite étale
refinement of the source.

Then the ORIGINAL span lifts simultaneously over $W(k)$, with both
maps finite étale. The residue degree $f$ is unrestricted.

The integral step is stronger than choosing unrelated lattices:
two generically ordinary rank-two $\mathcal O_K$-BT groups with
nonzero Kodaira--Spencer maps in the same $\mathcal O_K$-linear
isogeny class are isomorphic. After endpoint untwisting this identifies
the actual source lattices. A compatible rank-two crystalline summand
then gives the lift; that summand need not be Frobenius-stable.

If the span is coreless, all partial Hasse divisors have the same
reduced support, its unique clump. Its image on $Y$ has size $p-1$.
Every nonordinary fiber is superspecial; all its Newton slopes are
$1/2$.
In particular this class of common group data is impossible for the
selected main pair, whose full-lift branch is excluded. For the backup
the conclusion is the still-open fully liftable branch.

Thus, when the companion in the arithmetic assertion has generic
slope difference one, its half-Tate normalization has only the
exceptional polygon $(1/2,1/2)$, at exactly $p-1$ points on $Y$.
This more precise ordinary profile is not asserted for smaller gaps.

Version4,20 September2026. The unramified construction contracts the
zero-Hodge components and uses one-endpoint stable-lattice descent;
the one-active-component case determines the exact clump profile.
Those sharper geometric profiles remain useful after the general
ramified lifting extension. Author proof with local curvature,
partial-Hasse and isogeny checks.
[Proof](../../Proofs/deformations/unramified_bt_genus_two.md).
