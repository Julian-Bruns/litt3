# Proof: minimal finite coefficient relation kernels

Version5, 2 October2026.
[Statement](../../Theorems/shared_tensors/minimal_finite_coefficient_relation_kernel.md).

## The exact minimality condition

Choose a connected finite étale Galois cover $W\to C$ trivializing $R$,
with group $G$. Its finite representation is a $k[G]$-module; no
semisimplicity assumption is made.
Let $H$ be the sum of all $G$-submodules whose associated subbundle maps
to zero in $E$. This sum is itself a finite subrepresentation and
lies in the kernel. Quotienting $R$ by $H$ keeps it a finite coefficient,
keeps its surjection to $E$, and leaves no such subrepresentation
in the new kernel. This is the asserted minimal presentation.

If $R$ is a sum of pairwise distinct characters, every subrepresentation
is a sum of some of those character lines. Nonzero restriction of the
map on each character therefore makes $H=0$. This argument uses
semisimplicity of this coefficient representation, not of an arbitrary
larger Galois group algebra.

## Negativity of every Frobenius relation kernel

Finite coefficients are strongly semistable of degree zero. Thus every
subbundle of $K\subset R$ has nonpositive degree per rank. If
$\mu_{\max}(K)=0$, its first Harder--Narasimhan piece is a degree-zero
subbundle of $R$. After trivializing $R$, every degree-zero subbundle
of $\mathcal O_W^N$ is constant: its Plücker map to the Grassmannian
has pullback of the ample Plücker line of degree zero, hence is constant.
It therefore descends to a finite coefficient subrepresentation of $R$.
This contradicts minimality. Consequently $K=0$ or
$\mu_{\max}(K)<0$.

The same argument applies after every Frobenius pullback. Frobenius
twists preserve finite representations and their minimality.
To check the latter concretely, trivialize $R$ on $W$:
finite subrepresentations are constant subspaces preserved by the finite
deck action, and the pulled map's matrix entries are the $p^r$th powers
of the original entries. A constant relation in that matrix has a unique
coefficientwise $p^r$th root over the perfect field $k$; this root is a
constant relation in the original matrix, with the inverse-twisted deck
action. Thus a killed finite subrepresentation after Frobenius would
give one before Frobenius. Minimality is retained, proving
$\mu_{\max}(F^{r*}K)<0$ whenever $K\ne0$.

## All relation-kernel cohomology persists étale

Let $q:D\to C$ be any connected finite étale cover. The actual unit
sequence
\[
0\longrightarrow\mathcal O_C\longrightarrow q_*\mathcal O_D
\longrightarrow Q\longrightarrow0
\]
has finite coefficient quotient $Q$, hence $Q^\vee$ is strongly
semistable of degree zero. This holds even when $p\mid\deg q$;
the unit is injective and no trace splitting is needed.

For $K_r=F^{r*}K$, strict maximal-slope negativity gives
$H^0(K_r\otimes Q)=\operatorname{Hom}(Q^\vee,K_r)=0$.
Tensor the unit sequence by $K_r$ and take cohomology. Its exactness
therefore gives
\[
H^1(C,K_r)\lhook\joinrel\longrightarrow
H^1(C,K_r\otimes q_*\mathcal O_D)
=H^1(D,q^*K_r).
\]
This is exactly the asserted injectivity, with the usual actual
pullback as the map. It proves persistence of every nonzero class.

## The dual kernel is ample

On the finite étale Galois cover $W$ trivializing $R$, the sequence
$0\to K_W\to\mathcal O_W^N\to E_W\to0$ has no nonzero constant
relation. Indeed the vector space of all such relations is stable under
the deck action, so if nonzero it would descend to a killed finite
subrepresentation of $R$. Thus $H^0(W,K_W)=0$.

For ANY connected finite cover $v:D\to W$ of smooth proper curves,
including inseparable or ramified covers, a section of $v^*K_W$ is a
constant vector in $\mathcal O_D^N$. The same constant vector on $W$
maps to zero after faithful flat pullback, hence maps to zero already
on $W$. There are no such relations, so $H^0(D,v^*K_W)=0$.

The dual bundle $K_W^\vee$ is globally generated, as a quotient of
$\mathcal O_W^N$. Its tautological line on $\mathbf P(K_W^\vee)$
is therefore basepoint-free. If its associated morphism had a positive
dimensional fiber, that fiber would contain a projective integral curve.
This curve cannot be vertical over $W$, since the tautological morphism
on each projective-space fiber is the full linear embedding. Its
normalization consequently gives a finite cover $v:D\to W$ and a
degree-zero tautological quotient of $v^*K_W^\vee$. A degree-zero
globally generated line is trivial, yielding a nonzero section of
$v^*K_W$, contrary to the preceding paragraph. The associated morphism
is therefore finite; its tautological line is ample. Hence
$K_W^\vee$ is ample, and ampleness descends under the finite surjective
cover $W\to C$, proving ampleness of $K^\vee$.

## Original global-section classes also persist through Frobenius

Suppose additionally that $R$ has no trivial subrepresentation. Then
$H^0(C,R)=0$, so the boundary $H^0(C,E)\to H^1(C,K)$ is injective.
Every Frobenius twist of $R$ also has no trivial subrepresentation, while a
nonzero global section of $E$ remains nonzero after flat Frobenius
pullback. The corresponding boundary is again injective. Thus the
section class remains nonzero at every Frobenius height; the preceding
paragraph then keeps it nonzero on every finite étale refinement there.
General Frobenius pullback on $H^1(K)$ was not used or proved injective.

## Actual Cartier application and its limit

For an actual span $X\xleftarrow hS\xrightarrow gY_S$, choose the
eight pairwise-coprime tame character generators of
[cyclic Cartier generation](../../Theorems/jacobians/ordinary_covers/genus_two_cartier_cyclic_global_generation.md)
with their orders avoiding every prime dividing $\deg g$.
The norm identity $\operatorname{Nm}_g g^*=[\deg g]$ keeps every
character nontrivial and keeps them pairwise distinct on $S^{(1)}$.
Their nonzero evaluation maps remain nonzero after pullback, so their
presentation of $B_S$ is minimal and has no trivial constituent.

The three independent global Cartier sections pulled from the selected
genus-nine X therefore give relation-kernel classes that no finite
étale refinement and no Frobenius height can remove. On the cyclic
refinement trivializing the characters, the eight generator sections
transform in eight distinct nontrivial characters, whereas the pulled
global sections are invariant. They are independent of one another,
so this refined curve has at least eleven independent exact forms.
Fiberwise generation of the rank-four Cartier bundle does not put
every global exact form in the constant span of its eight generators.

## The first transport of the three fixed X sections

Let $V_X=H^0(X,B_X)$, of dimension three, and transport its evaluation
$\mathcal O_X^3\to B_X$ through the ACTUAL span. Write $J_Y$ for
the actual image of $g^{(1)}_*\mathcal O_{S^{(1)}}^3\to B_Y$ and
$E_Y$ for its saturation. By adjunction, the pulled original three
sections factor through $g^{(1)*}J_Y$.

The fixed X evaluation has saturated image $U_X$ of rank three and
degree thirteen, as proved in
[the fixed Frobenius HN record](../../Theorems/cartier_and_spin/cartier_generated_frobenius_hn.md).
Thus $E_Y$ has rank at least three. If it had rank three,
$h^{(1)*}U_X\subset g^{(1)*}E_Y$ would be an inclusion of two
saturated rank-three subbundles of $B_S$. They must be equal: the
torsion quotient of one by the other would otherwise inject into the
locally free quotient by $h^{(1)*}U_X$. If $\deg h=n$, the genus
formula gives $\deg g=8n$, so equality would give
$13n=8n\deg E_Y$, impossible. Hence $E_Y=B_Y$ and $J_Y$ has
generic rank four. As a vector-bundle quotient of a finite coefficient,
$J_Y$ has nonnegative degree.

Suppose its degree were zero. A degree-zero vector-bundle quotient of
a finite coefficient is itself a finite coefficient: on an étale
trivialization the dual quotient is a degree-zero subbundle of a
trivial bundle and hence a constant Grassmannian subspace. Choose a
connected finite étale Galois cover $D\to Y$ dominating $S\to Y$
and trivializing $J_Y$. This is a closure of the ONE Y-leg, not a
simultaneous closure of both endpoint maps. The pulled original exact
three-space is contained in the four-dimensional constant space
$H^0(D,J_D)$. The latter space is preserved by the deck group.
All deck-conjugate exact three-spaces therefore lie inside this same
four-space.

[One-form recognition](../../Theorems/cartier_and_spin/two_form_map_descent.md)
states that distinct embedded actual X-fields on an étale source have
disjoint pulled exact three-spaces. Thus every deck conjugate of the
X-field would have to be the same X-field. If the deck group preserves
that field, its fixed subfield has transcendence degree one and lies
in both original endpoint fields: it lies in $k(Y)$ by Galois
invariance and in $k(X)$ by construction. This contradicts corelessness.
Therefore $\deg J_Y\ge1$. Since $\deg B_Y=4$, its integral
colength is at most three.

On the one-leg Galois closure of $S\to Y$, the induced finite
coefficient $g_*\mathcal O_S^3$ is a constant bundle with columns
the deck-conjugate pulled exact three-spaces. Its maximal killed finite
subrepresentation consists exactly of the constant linear relations
among these columns. The minimal quotient rank is therefore the
dimension of their deck span. The same recognition theorem gives
dimension at least six on a coreless span. Trivializing a further finite
coefficient does not change this dimension.

Finally, the three fixed exact forms have common zero divisor exactly
$O$ on X: the two first coefficient polynomials are coprime, and their
three orders at infinity are $10,7,1$. Their differential adjunction
image is consequently $\omega_X(-O)$, of degree fifteen. If $L_Y$
is the first opposite differential adjunction image, then on S the
pulled image contains $h^*\omega_X(-O)$. Hence
$15n\le8n\deg L_Y$. But $L_Y\subset\omega_Y$ has degree at
most two, forcing degree two and $L_Y=\omega_Y$. This gives integral
full differential adjunction at the first step, while the Cartier image
may still have a defect of length one, two, or three. No inclusion of
$h^*U_X$ in the unsaturated $g^*J_Y$ was used.

For the selected endpoints, the
[three-section integral transport proof](../../Theorems/cartier_and_spin/cartier_kernel_generated_subbundle.md)
already proves that every proper whole-round image strictly decreases
its defect. Applying it to the improved initial bound three gives
full integral generation after at most three further rounds. This is
the same actual unsaturated transport and does not assert any finite
closure of its coefficient domain.

## Strict growth of the canonical minimal domains

Start with a nonzero minimal finite coefficient map
$\alpha_X:R_X\to B_X$. Complete actual trace transport gives
$R'_Y=g^{(1)}_*h^{(1)*}R_X\to B_Y$. Quotient $R'_Y$ by its
largest finite subrepresentation killed by this map and call the
result $R_Y$. Its actual image is unchanged.

Finite étale ambidextrous adjunction supplies an injection
$h^{(1)*}R_X\to g^{(1)*}R'_Y$ whose composition with the transported
Cartier map is $h^{(1)*}\alpha_X$. Locally, after splitting the finite
étale map into its sheets, this injection selects the diagonal sheet
summand and the trace sums the sheet maps. Thus the composition is
the original map, with no covering-degree factor.

Compose this injection with the quotient to $g^{(1)*}R_Y$. Its kernel
is a finite coefficient subbundle, because every morphism between
finite coefficient bundles on a proper connected curve is a constant
intertwiner after a common finite étale Galois trivialization. This
kernel lies in $h^{(1)*}\ker\alpha_X$. Strict negativity of that kernel
persists after étale pullback, so it has no degree-zero finite
subbundle. Hence the composed injection is still injective.

If $\operatorname{rk}R_X=\operatorname{rk}R_Y$, it is an isomorphism.
Together with the two maps to the actual common Cartier bundle it
gives a common finite coefficient with compatible nonzero maps on
both original endpoints. Under the explicit no-common-coefficient
hypothesis this is forbidden. Therefore
$\operatorname{rk}R_Y>\operatorname{rk}R_X$. Iterate the same proof
in the reverse direction at every stage. Transport remains nonzero
because its source comparison contains the preceding nonzero map.
Minimal ranks strictly increase at each single transport.

Once the actual Y-image is all $B_Y$, it remains all under every
whole round by the actual nested-image property. Its kernel has
degree $-\deg B_Y=-4$ and rank $r_j-4$. For every fixed Frobenius
height $a$, its degree is $-4\cdot5^a$. The maximal HN slope is at
least the average slope and is strictly negative by the first part:
\[
-4\cdot5^a/(r_j-4)\le\mu_{\max}(F^{a*}K_j)<0.
\]
Since minimal ranks tend to infinity, these maximal slopes tend to
zero. A uniform negative gap would bound the ranks and contradict
the actual strict-growth result. This is a conditional exclusion
criterion, not a gap established by the proof.

At stages where both source images are the full $B_S$, the source
injection $h^{(1)*}R_X\to g^{(1)*}R_Y$ fits over the identity of
$B_S$. Its coefficient cokernel $C_S$ is finite étale-trivializable.
The snake lemma gives the exact sequence
$0\to h^{(1)*}K_X\to g^{(1)*}K_Y\to C_S\to0$.
The next transport gives its reversed-endpoint counterpart. The ample
dual relation kernels thus form source-level surjective dual chains with
finite degree-zero kernels and unchanged degree.

The source snake-lemma calculation alone does not supply compatible
endpoint return maps. In fact the ordinary endpoint adjunction map
$R_X\to h^{(1)}_*g^{(1)*}R_Y$ composes with the returned Cartier map
as $(\deg h)\alpha_X$, which may vanish in the characteristic.
Therefore the raw unit cannot be divided by that scalar in general.

The separate
[universal pro-étale coefficient theorem](../../Theorems/shared_tensors/common_ind_finite_cartier_coefficient.md)
now supplies the missing descent: on the actual common universal
pro-cover, each minimal domain embeds by CONSTANT evaluation into
regular Cartier sections, and successive minimal domains are the
finite spans of endpoint deck-group orbits. Their literal inclusions
give compatible same-endpoint return injections in every degree.
Their two colimits give a common endpointwise ind-finite coefficient.
In modular characteristic the new return inclusion can appear only
in the minimal quotient, rather than lift to the raw return domain.
This is compatible with the vanishing raw-unit scalar above.

Once the same-endpoint images are both full, these return inclusions
fit over the identity of B on that endpoint. The endpoint snake lemma
therefore also gives $0\to K_j\to K_{j+2}\to C_j\to0$ with
$C_j$ finite étale of degree zero. Dualizing gives ample dual-kernel
surjections with finite degree-zero kernels and unchanged endpoint
degree. The colimit is an object of the fiber product of endpoint
ind-finite categories, rather than a union of common finite objects.
No finite common subobject or quotient carrying evaluation follows
without a separate finite-extraction theorem.

Arbitrarily large minimal tame presentations of this same one-endpoint
Cartier bundle are constructed by appending new prime-avoiding torsion
characters. Their kernels already have fixed degree and unbounded rank.
They are not asserted to be the canonical alternating domains. Thus
neither endpoint numerics, kernel negativity, nor fixed-height Frobenius
data alone supplies the missing uniform gap. The unmarked common-cover
problem remains unresolved.
