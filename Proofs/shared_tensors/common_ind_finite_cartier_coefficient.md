# Proof: endpointwise ind-finite Cartier coefficients

Version2, 2 October2026.
[Statement](../../Theorems/shared_tensors/common_ind_finite_cartier_coefficient.md).

## One actual universal pro-cover for both legs

Work on the relative Frobenius targets, so all Cartier bundles below
are vector bundles on those targets. Let $\widetilde S$ be the
inverse limit of pointed connected finite étale covers of $S^{(1)}$.
Finite transitions are affine, and the limit is a quasi-compact
quasi-separated scheme. Connected Galois covers form a cofinal system.
The usual finite étale Galois correspondence gives its deck group
$G_S=\pi_1(S^{(1)})$.

Every finite étale cover of $S^{(1)}$, composed with the actual
finite étale map to $X^{(1)}$, is dominated by a pointed connected
finite étale Galois cover of $X^{(1)}$. Hence X-cover levels are
cofinal in the same pro-cover. The identical argument works for Y.
Thus this ONE pro-scheme is the universal pointed pro-étale cover of
both endpoints, with deck groups $G_X,G_Y$ containing the same
$G_S$ as an open subgroup. This uses separate one-leg Galois closures
to establish cofinality. It does not assert a simultaneous FINITE
Galois refinement.

These standard facts follow from the
[finite étale Galois correspondence](https://stacks.math.columbia.edu/download/pione.pdf),
Sections58.3 and58.6. The construction is intrinsic to the original
span and retains both endpoint maps.

## Regular sections and the two deck actions

On an étale cover, relative Frobenius is the base change of the base
relative Frobenius. Consequently the Cartier bundle on
$\widetilde S$ is the pullback of $B_S$, and also of the two endpoint
Cartier bundles. These identifications are functorial. Both endpoint
deck groups therefore act $k$-linearly on
$W=H^0(\widetilde S,B_{\widetilde S})$, agreeing on $G_S$.

Every element of W descends to a finite cover level. One can check this
on a finite affine cover of $S^{(1)}$: its inverse images are affine
inverse limits, sections of a finite-presented module descend at some
finite level, and the finitely many equalities on overlaps descend at
a common later level. This is the usual affine-transition limit
principle; see
[the Stacks limit framework](https://stacks.math.columbia.edu/tag/01YU).
In particular $H^0(\widetilde S,\mathcal O)=k$, since each connected
finite projective cover has only constant global functions.

For a section descending to a finite cover level, its stabilizer in
$G_S$ is open. Its $G_S$ orbit is therefore finite. Because $G_S$
has finite index in either endpoint group, its orbit under either
$G_X$ or $G_Y$ is also finite. This observation applies to EVERY
section, not just to the initial exact forms.

Let V be the $k$-span of the orbit of the pulled $V_0$ under finite
words in $G_X$ and $G_Y$. It is a subspace of W preserved by both
groups. For either endpoint, the span of the orbit of finitely many
vectors is finite-dimensional, and its action factors through a finite
quotient. Thus V is a filtered union of finite-dimensional continuous
finite-image representations at that endpoint.

Each such representation has its finite étale coefficient bundle.
Its vectors are regular sections of the Cartier bundle on a common
finite trivializing cover. Equivariant evaluation there descends to
a morphism from that coefficient into the endpoint Cartier bundle.
These morphisms commute with inclusion of orbit spaces. Their colimits
give $\mathcal V_X\to B_X$ and $\mathcal V_Y\to B_Y$.
The restrictions of the two representations to $G_S$ are the SAME
representation V, so source pullback gives a canonical coefficient
isomorphism. Both maps become the same evaluation map on
$\widetilde S$, and hence are compatible on the original source.
Faithfully flat descent, or descent at each finite coefficient level,
justifies this last equality. Evaluation is nonzero, since $V_0$ was
nonzero. Nothing in this construction uses a trace average.

## The exact finite-extraction gap

First identify the construction with the canonical minimal domains,
rather than only with a separately chosen section orbit. A finite
coefficient $R_X\to B_X$ trivializes on the universal cover. Its
constant vectors map to regular sections there. The kernel of this
map on constant vectors is a $G_X$-stable subspace; hence it is exactly
the largest finite coefficient subrepresentation killed by the map.
After minimalization, constant-vector evaluation is injective and
identifies the coefficient representation with a finite $G_X$-stable
section space $E_i$.

Under the actual étale induction to Y, constant vectors of the induced
domain are sums of the sheet copies of $E_i$. Their evaluated sections
are precisely the $G_Y$ translates of $E_i$. The trace map sums these
sheet evaluations, with independently selectable sheet coefficients.
Its constant evaluated image is therefore
$F_i=\operatorname{span}_k(G_YE_i)$. Removing its killed finite
subrepresentation identifies its minimal quotient with this image.
The reverse transport gives
$E_{i+1}=\operatorname{span}_k(G_XF_i)$ in exactly the same way.
Each span is finite-dimensional, since finitely many vectors have
finite endpoint orbits.

The inclusions $E_i\subset F_i\subset E_{i+1}$ are literal
inclusions of sections and preserve evaluation. Both $E_i$ and
$E_{i+1}$ are $G_X$-stable, so their inclusion is $G_X$-equivariant
and descends to an endpoint coefficient injection. The analogous
Y-return inclusion also descends. The two endpoint colimits are
the SAME section space V with its two locally finite actions;
the source identifications commute with these inclusions.

This descent is supplied by injective constant evaluation AFTER
minimalization. The ordinary left-adjunction unit into the raw return
coefficient instead composes with evaluation as the covering degree
times the original map. If that scalar vanishes, that particular raw
unit is killed. The compatible section-space inclusion may only appear
after passing to the minimal quotient, since invariants are not an
exact functor in modular characteristic. Thus no inverse trace scalar
and no unjustified source-colimit descent are being used. When the
degree is invertible, the normalized ordinary unit agrees with this
inclusion after minimalization, since both have the same evaluation
and minimal constant evaluation is injective.

Suppose common finite coefficients have no nonzero compatible maps
to B on the original endpoints. A nonzero finite-dimensional subspace
of V invariant under BOTH groups would define such a common finite
coefficient. Its evaluation would be nonzero, since V is an actual
subspace of regular sections and a nonzero vector is a nonzero
section. This is impossible. Likewise, if the evaluation factored
through a finite-dimensional common coefficient quotient, that
quotient would carry a nonzero compatible map to B, again impossible.

There is no contradiction with the existence of V. Being locally
finite separately for two open profinite groups does not mean that
their jointly generated group has finite-dimensional orbits. In
categorical terms,
$\operatorname{Ind}(\mathcal C_X)\times_{
\operatorname{Ind}(\mathcal C_S)}\operatorname{Ind}(\mathcal C_Y)$
is not identified here with
$\operatorname{Ind}(\mathcal C_X\times_{\mathcal C_S}\mathcal C_Y)$.
Finite presentation of B controls maps FROM B to a filtered colimit;
it does not make a map FROM this ind-coefficient to B factor through
a common finite quotient. No such converse limit claim is used.

Finally, if $H\subset G_S$ is open and $D\to S$ is its cover,
invariant sections on the universal cover descend to D. Hence
$V^H\subset H^0(D^{(1)},B_D)$, a finite-dimensional space on a
smooth projective finite cover. V is generated under the jointly
generated deck group by the given finite basis of $V_0$. This gives
finite generation and finite open-subgroup invariants, but the proof
does not turn them into finite joint dimension. The source is still
hypothetical if the original common-cover question is unresolved.
