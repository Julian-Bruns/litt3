# Minimal finite coefficients have permanently negative relation kernels

ID: `minimal_finite_coefficient_relation_kernel`. Version5, 2 October2026.
Author proved; focused root review PASS, recorded in
[the audit](../../Research/audits/MINIMAL_FINITE_RELATION_KERNEL_AUDIT_2026_10_02.md).

Let $C$ be a smooth connected projective curve over an algebraically
closed field of characteristic $p>0$. Let $R$ be finite étale-trivializable
and let $R\twoheadrightarrow E$
surject onto a vector bundle. Assume the presentation is minimal in the
precise sense that its kernel $K$ contains no nonzero finite coefficient
subrepresentation of $R$.

Then $K=0$ or $K^\vee$ is AMPLE. In particular,
$\mu_{\max}(F^{r*}K)<0$ for every $r\ge0$.
For every connected finite étale map $q:D\to C$ and every $r\ge0$,
\[
H^1(C,F^{r*}K)\longrightarrow H^1(D,q^*F^{r*}K)
\]
is injective. No covering degree is inverted. In particular, every
nonzero relation-kernel extension class persists on every finite étale
refinement, including covers of degree divisible by $p$.

Every finite coefficient presentation can be made minimal
by quotienting its domain by the sum of the finite subrepresentations
in its kernel. Semisimplicity is not needed for this assertion or the
negative-kernel and cohomology conclusions. A direct sum of pairwise
distinct tame character lines,
each mapping nontrivially, is already minimal. Thus the eight cyclic
Cartier generators in
`genus_two_cartier_cyclic_global_generation` have this property.
If their orders avoid an actual leg degree, it also holds after pulling
them through that leg.

For a nonzero $s\in H^0(C,E)$, when $R$ has no trivial subrepresentation,
its connecting class stays nonzero after every finite étale refinement
and after every Frobenius pullback. The latter assertion concerns these
specific section classes; general Frobenius injectivity on $H^1(K)$
is not claimed.

## Minimal domains in the actual alternating transport

For a coreless actual span with the fixed genus-nine endpoint and a
genus-two endpoint, begin with its full three-dimensional global Cartier
kernel, viewed as $\mathcal O_X^3\to B_X$. Its FIRST opposite actual
trace image $J_Y$ already has generic rank four and positive degree:
$1\le\deg J_Y\le4$. Equivalently, $B_Y/J_Y$ has length at most three.
The first minimal coefficient domain has rank at least six. The first
opposite differential adjunction also fills $\omega_Y$ integrally.
These assertions use the fixed saturated rank-three bundle of degree
thirteen and the one-form recognition theorem; they do not require a
presumed simultaneous Galois closure. No bound of two or one on the
remaining integral defect is asserted.
On either selected pair, the established strict decrease of every
proper integral defect under a whole round therefore fills $B_Y$ after
at most three further whole rounds: one first transport and at most six
additional single transports. This improves the previous four-round
bound for the three-section seed; it remains a generation statement.

Retain an actual finite étale span $X\xleftarrow hS\xrightarrow gY$
with no nonzero common finite étale coefficient having compatible maps
to $B_X,B_Y$. Begin with any nonzero finite coefficient map to $B_X$.
After each full actual trace transport, quotient its induced domain by
the largest finite subrepresentation killed by that map. The resulting
minimal coefficient ranks strictly increase at EVERY transport:
$r_j\ge r_0+j$. This holds even after its image has become the whole
Cartier bundle. It does not rely on semisimplicity of induced domains.

For the selected genus-two endpoint in characteristic five, once its
image is $B_Y$, the relation kernel at a Y-stage has degree $-4$ and
rank $r_j-4$. Thus for every fixed Frobenius height $a\ge0$,
\[
-\frac{4\cdot5^a}{r_j-4}
\le\mu_{\max}(F^{a*}K_j)<0,
\qquad \mu_{\max}(F^{a*}K_j)\longrightarrow0.
\]
Consequently a uniform strictly negative maximal-slope gap for these
CANONICAL word kernels, at even one fixed height, would exclude the
actual span. Arbitrary minimal tame presentations already have unbounded
ranks, so such a gap must use the precise natural word and its original
seed. No endpoint-only slope gap or common-cover exclusion is proved.

Once both stage images are the full Cartier bundle, the source-level
successive comparisons additionally give
$0\to h^{(1)*}K_X\to g^{(1)*}K_Y\to C_S\to0$, with $C_S$
finite étale-trivializable of degree zero, and the corresponding reverse
sequence at the next transport. These are sequences on the original
source. The separate universal pro-étale construction in
`common_ind_finite_cartier_coefficient` identifies the canonical
minimal domains with nested section-orbit spaces. It consequently
provides compatible endpoint return injections and a common
ENDPOINTWISE ind-finite colimit in ALL degrees. Once endpoint images
are full, the corresponding same-endpoint relation kernels also form
increasing chains with finite degree-zero quotients and fixed degree.
Neither the source-chain snake lemma alone nor the ordinary raw return
unit supplies that descent. No finite common coefficient is extracted.

[Proof](../../Proofs/shared_tensors/minimal_finite_coefficient_relation_kernel.md).
