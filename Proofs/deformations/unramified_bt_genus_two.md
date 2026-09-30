# Proof: contract zero-Hodge steps and descend a single oper lattice

[Statement](../../Theorems/deformations/unramified_bt_genus_two.md).
Indices below are cyclic modulo $f$; choose them so that Frobenius
sends the preceding crystalline eigenspace to the current one.
The unramified integer action is retained by every isogeny.

## Positive partial degrees and finite untwisting

Since $k$ is algebraically closed, the unramified action decomposes the
Dieudonné crystal into rank-two locally free crystals $\mathcal H_i$.
Write their Hodge sequences and partial Hasse maps as
\[
0\longrightarrow L_i\longrightarrow H_i\longrightarrow M_i
\longrightarrow0,\qquad h_i:L_i\longrightarrow F_C^*L_{i-1}.
\tag{1}
\]
The line ranks can be checked at the ordinary generic fiber: the
multiplicative and étale parts each have rank one over $\mathcal O_K$.
Their ranks in each of the $f$ eigenspaces are one, and Hodge ranks
are constant on the curve. This proves the asserted signatures
without an assumption concerning a cusp or an ambient abelian scheme.

The conjugate sequence is
\[
0\longrightarrow F_C^*M_{i-1}\longrightarrow H_i
\xrightarrow{V}F_C^*L_{i-1}\longrightarrow0.
\tag{2}
\]
Thus $\det H_i\simeq F_C^*\det H_{i-1}$, and cycling gives
$\deg H_i=0$. All $h_i$ are generically nonzero. The ordinary locus
is exactly where all are invertible, so at least one has a zero.
Putting $d_i=\deg L_i$, their degrees give $d_i\le p d_{i-1}$.
Cycling first gives $d_i\ge0$. If one were zero, the inequalities
in the forward direction would make all zero, and no $h_i$ could
vanish. Therefore every $d_i$ is positive.

If the whole Kodaira--Spencer map is zero, use
[Lam, Lemma4.2](https://arxiv.org/pdf/2210.13563) to untwist Frobenius
within the $\mathcal O_K$-linear isogeny class. Although that lemma
is stated on an affine curve, its construction glues here: in a
local formal lift take the inverse image of the Hodge subbundle
under reduction modulo $p$. It is a subcrystal because the Hodge
subbundle is connection-stable; it is stable under $F,V$ and
$\mathcal O_K$. The construction is intrinsic in the crystal and
the Hodge filtration, and hence agrees under crystalline transition
maps. The equality $F(\mathcal H'^{(p)})=p\mathcal H$ in Lam's
proof supplies the intrinsic Frobenius-pullback isomorphism.
It also shows compatibility with finite étale pullback.

Untwisting permutes the partial degrees and divides them by $p$.
The positive integer $\sum_i d_i$ therefore strictly decreases,
so the process terminates with some nonzero partial
Kodaira--Spencer map. For any such component,
\[
L_i\longrightarrow M_i\otimes\omega_C\ne0
\quad\Longrightarrow\quad 1\le d_i\le g(C)-1.
\tag{3}
\]
In genus two that map is an isomorphism and $d_i=1$.
Already this ONE component will suffice for lifting the actual span.

## Why every component is maximal after untwisting in genus two

Here is a direct local curvature calculation, avoiding a hypothesis
on an abelian-scheme realization. Work on a formal lift with an étale
coordinate $t$ and Frobenius lift $t\mapsto t^p$. Lift a Hodge basis
$(e,a)$ of $H_{i-1}$ and write its second fundamental form as
$c\,dt$. Strong divisibility says that
\[
u=F(e)/p,\qquad v=F(a)
\]
is an integral basis of the next crystalline component. Horizontality
of $F$, divided by $p$ before reducing, gives
\[
\nabla u=c^p t^{p-1}v\,dt,\qquad \nabla v=0
\quad\text{modulo }p.
\tag{4}
\]
Indeed the other coefficients acquire an additional factor of $p$.
Since $(p-1)!=-1$ in $k$ and $D^p=0$ for $D=\partial_t$, (4) gives
\[
\psi_i(D)(u)=-c^pv,\qquad \psi_i(D)(v)=0.
\tag{5}
\]
In particular $\psi_i$ is nonzero exactly when the preceding
Kodaira--Spencer map is nonzero. In that case its generic kernel is
the line $F_C^*M_{i-1}$ in (2), of negative degree $-p d_{i-1}$.

If the current Kodaira--Spencer map vanished, $L_i$ would be preserved
by the connection. The restriction of the nilpotent $p$-curvature to
this line would be zero. Consequently $L_i$ would map nontrivially
into that negative-degree kernel line, contradicting $d_i>0$.
Thus a nonzero partial Kodaira--Spencer map forces the next one to
be nonzero. Cycling and (3) prove $d_i=1$ and the isomorphism assertion
for every component in genus two. Reversing the untwisting gives
$d_i=p^a$ for the original group.

The zeros of $h_i$ are simple at this terminal stage. Locally choose a
generator of $L_i$ and a horizontal generator of $F_C^*L_{i-1}$.
At a zero of $h_i$, the Hodge line equals $\ker V$ in (2).
Horizontality of $V$ identifies the differential of $h_i$ there with
the nonzero second fundamental form, followed by the isomorphism
from the quotient of $H_i$ to $F_C^*L_{i-1}$. Its differential is
nonzero. Its degree is $p d_{i-1}-d_i=p-1$, as asserted.

## Uniqueness of the nonzero-Kodaira--Spencer lattice

Let $G,G'$ on a smooth curve be generically ordinary rank-two
$\mathcal O_K$-BT groups, both with nonzero Kodaira--Spencer maps,
and let their rational Dieudonné modules be $K$-linearly isomorphic.
For the mixed groups used in the lifting theorem, the preceding
curvature argument, in any genus, makes every partial
Kodaira--Spencer map nonzero. Every Hodge degree is positive.
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

## Lift the original span using one integral component

Untwist the two endpoint groups until their Kodaira--Spencer maps
are nonzero. Their actual source pullbacks remain isogenous and
generically ordinary with nonzero Kodaira--Spencer maps. The preceding
uniqueness supplies an $\mathcal O_K$-linear isomorphism of these
FULL groups on the source.

Choose an embedding component with nonzero Kodaira--Spencer map
on $Y$. Its degree is one by (3), so it is a rank-two crystalline
oper. The group isomorphism identifies its pullback with the same
embedding component on $X$. Its second fundamental form on $X$
is an isomorphism as well, by faithful flatness of the étale source
map. Apply [crystalline oper lifting](crystalline_oper_lifting.md).
It is irrelevant that Frobenius permutes these components.
This gives the full lift of the original two maps, also when the
initial compatibility was supplied on an étale source refinement.

For a coreless span, every nonempty partial Hasse support is a clump:
the line bundles and their sections are identified by the actual group
isomorphism. Clump uniqueness makes all these supports equal.
Their genus-two degree and reducedness give its size $p-1$.
At any point of this support all $h_i$ vanish, so the Hodge and
conjugate lines coincide in every component. The fiber has maximal
$a$-number $f$ and is superspecial. Equivalently its Dieudonné lattice
has the same $F$- and $V$-images, giving $F^2$ equal to $p$ times an
invertible semilinear map; all slopes are $1/2$.

## The smaller-slope-gap case: contract the inactive components

Now allow generic slopes $(0,r/f)$ with $0<r\le f$ and a nonconstant
Newton polygon. The dimension of $G$ is $r$. At the geometric generic
point its étale part has height $f$ and rank one over $\mathcal O_K$;
the remaining rank-one coefficient part is connected. Its Hodge
dimensions at the $f$ embeddings are zero or one. Hodge ranks are
constant over the base, so globally
\[
I=\{i:\operatorname{rk}L_i=1\},\qquad |I|=r,
\]
and $L_i=0$ for the other indices. The determinant calculation from
(2), with ranks allowed to be zero or two, still gives $\deg H_i=0$.

Call the indices in $I$ active. For each active $i$, let $j$ be the
preceding active index in the Frobenius cycle, and let $a_i\ge1$ be
the distance from $j$ to $i$. Thus $\sum_{i\in I}a_i=f$.
At a zero-Hodge index Frobenius OUT of that component is an integral
isomorphism. Composing these isomorphisms with the one noninvertible
Frobenius step gives
\[
\mathcal F_i:F_C^{a_i*}\mathcal H_j\longrightarrow\mathcal H_i,
\]
whose local elementary divisors are $(1,p)$. Consequently
$\mathcal V_i=p\mathcal F_i^{-1}$ is integral and gives, modulo $p$,
\[
0\longrightarrow F_C^{a_i*}M_j\longrightarrow H_i
\xrightarrow{\mathcal V_i}F_C^{a_i*}L_j\longrightarrow0.
\tag{6}
\]
Restricting to $L_i$ defines the generalized partial Hasse map
$h_i:L_i\to F_C^{a_i*}L_j$.

These maps are nonzero at the geometric generic point. Over its
perfection the connected and étale parts split. On the connected
rank-one part the composite $\mathcal F_i$ has precisely one factor
of $p$, so $\mathcal V_i$ is invertible there; on the étale part
it is zero modulo $p$. At an active index the Hodge line is the
connected line. This proves the assertion.

At any geometric point, all $h_i$ are invertible if and only if the
Newton polygon is the generic one. Here is the elementary mod-$p$
check. Each reduced $\mathcal F_i$ has rank one, with kernel
$F_C^{a_i*}L_j$ and image the left-hand line of (6). The next
composition remains nonzero exactly when this image differs from
the next Hodge kernel, which is the condition $h_i\ne0$. If all
conditions hold around the cycle, arbitrarily many circuits remain
nonzero and give an étale part of coefficient rank one. The other
coefficient rank-one part is isoclinic of slope $r/f$, by its total
dimension. If one condition fails, sufficiently many circuits of
Frobenius are zero modulo $p$, so there is no slope-zero part.
Thus nonconstancy of the Newton polygon forces a zero of some $h_i$.

The same degree argument as before now reads
\[
d_i\le p^{a_i}d_j\qquad(i,j\text{ consecutive active indices}).
\tag{7}
\]
Cycling gives $d_i\ge0$; equality for one would force equality for
all and make every generalized Hasse map nowhere zero. Hence all
active degrees are positive.

Apply intrinsic Frobenius untwisting whenever the whole
Kodaira--Spencer map is zero. It preserves the Newton polygons,
rotates the signatures, and divides the positive total Hodge degree
by $p$. Eventually some active partial Kodaira--Spencer map is
nonzero. On a genus-two curve (3) makes that line have degree one
and that map an isomorphism. Its integral crystalline summand is
the required oper lattice in a rank-two component of the original
isocrystal. We make no claim that all components are opers in this
case; (4)--(5) need not propagate across an inactive interval.

The source rational identification respects the $K$-action and hence
each component after base change to $W(k)[1/p]$. Apply the
one-endpoint lattice-descent assertion of
[crystalline oper lifting](crystalline_oper_lifting.md).
It produces compatible integral oper lattices and lifts the ORIGINAL
span. In particular no higher-height analogue of the ordinary
isogeny-uniqueness lemma is being assumed in this argument.

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
between one and $f$. The preceding section constructs an integral
oper component on the genus-two endpoint.

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

## One active component gives an exact Hasse profile

Assume $r=1$. After untwisting there is just one active component,
say $\mathcal H_i$, with $\deg L_i=1$. Its full Frobenius circuit
and the complementary map are
\[
\mathcal F=F^f:F_C^{f*}\mathcal H_i\longrightarrow\mathcal H_i,
\qquad \mathcal V=p\mathcal F^{-1}.
\]
Their elementary divisors are $(1,p)$. Equation(6) becomes
\[
0\longrightarrow F_C^{f*}M_i\longrightarrow H_i
\xrightarrow{\mathcal V}F_C^{f*}L_i\longrightarrow0,
\qquad h=\mathcal V|_{L_i}.
\tag{8}
\]
The divisor of $h$ has degree $p^f-1$. Every zero is simple by the
same derivative calculation used above: at a zero $L_i=\ker\mathcal V$;
the nonzero second fundamental form, followed by the quotient
isomorphism in (8), is the derivative of $h$. The target Frobenius
pullback line has its canonical horizontal local generators. Thus
the exceptional locus on $Y$ has exactly $p^f-1$ points.

This entire map, not just its divisor, descends to the other endpoint.
Use the oper lattice descended from $Y$ in the selected component of
the common rational $F$-isocrystal on $X$. On the actual source both
maps $\mathcal F,\mathcal V$ are integral in that lattice. Integrality
and the exact subbundle sequence (8) descend faithfully flatly through
the source map to $X$. Its oper line is already compatible. Hence
the zero sets of $h$ pull back to the SAME set on the original source.
It is a clump; corelessness identifies it with the unique one.

At an exceptional point the underlying group is connected of height
$2f$ and dimension one: the previous Frobenius-circuit test removes
its entire étale part. Its slopes must all be $1/(2f)$. Indeed each
distinct positive rational slope contributes a positive integer to
the total dimension, by Dieudonné--Manin denominator divisibility.
Total dimension one permits just one slope, and height fixes it.

Suppose also that the rational determinant is geometrically constant.
The determinant of the descended oper lattice is then an integral
lattice in a constant rank-one isocrystal. It is the constant lattice
up to a power of $p$. To see this, evaluate on any smooth proper Witt
lift: an invertible lattice in the trivial line with $p$ inverted can
have divisor only along the irreducible special fiber. That divisor
is an integral multiple of $(p)$. The resulting trivialization is
horizontal because it is induced by the fixed rational crystal map.
These trivializations may be made compatible on the actual source.

The oper isomorphism now identifies $L_i^{\otimes2}$ with $\omega_Y$.
Since $p^f-1$ is even, (8) is a nonzero canonical section
\[
h\in H^0\bigl(Y,\omega_Y^{(p^f-1)/2}\bigr)
\]
with a reduced divisor, and its counterpart on $X$ has exactly the
same pullback. In the shared ring $k[s]$, write $h=c s^a$. The
zero multiplicity of the pullback of $h$ is one, so both $a$ and the
primitive zero multiplicity are one. This proves the weight assertion.

If $f>1$, the component immediately before $i$ is inactive. Its
outgoing Frobenius is an integral isomorphism, so the mod-$p$
connection on $H_i$ is a Frobenius pullback and has zero $p$-curvature.
If $f=1$, formula(5) and the nonzero Kodaira--Spencer map give
nonzero nilpotent $p$-curvature. This establishes the claimed
dormant/active distinction without inferring it from section counts.
