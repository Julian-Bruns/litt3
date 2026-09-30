# Proof: intermediate Frobenius algebras and the scalar obstruction

[Statement](../../Theorems/cartier_and_spin/higher_cartier_common_filtration.md).
All subobjects and maps below belong to the actual two-map diagram.
Use relative Frobenius and its actual twists throughout.

## Common images have no torsion defects

Let $I_C$ be the image of a common morphism and $\overline I_C$
its saturation. Étale pullback commutes with both operations, so
$\overline I_C/I_C$ pulls back to the same torsion sheaf on $Z$.
A nonempty support would be a clump. Thus every common image is
saturated. Kernels, images, intersections and quotients remain
common vector bundles. In particular these common bundles form
an abelian category with the usual actual kernels and cokernels.

Call an object common-simple when it has no proper nonzero common
subobject. The first-height
[Cartier theorem](common_cartier_subbundles.md) proves that $B^{[1]}$
is common-simple under the stated condition on $g(Y)-1$.

## One more direct image

Let $E$ be common-simple, of rank $d$ and degree $d(g(Y)-1)$ on $Y$.
For a nonzero common $V\subset F_*E$, intersect $F^*V$ with the
canonical filtration $\mathcal H_i$ of $F^*F_*E$, whose graded terms
are $E\omega^i$, $0\le i<p$. Its induced graded images are zero
or the whole $E\omega^i$: tensoring preserves common simplicity,
and the preceding lemma removes every image defect.

The Cartier connection restricts to $F^*V$. The transversality
isomorphisms on the ambient filtration induce injections from its
$i$th image into its $(i-1)$st image tensored with $\omega$.
Thus the nonzero images are exactly those indexed by
$0,\ldots,\ell-1$, for some $1\le\ell\le p$. Consequently
\[
\operatorname{rk}V=d\ell,\qquad
p\deg V_Y=d\ell^2(g(Y)-1).
\tag{1}
\]
For $E=B^{[1]}$, $d=p-1$ and degree integrality forces $p\mid\ell$.
Thus $\ell=p$ and saturation gives $V=F_*B^{[1]}$.

The canonical filtration and preservation of semistability under
Frobenius direct image are the curve case of
[Sun's direct-image theorem](https://arxiv.org/pdf/math/0611360).
Only those established properties, not a claim that direct image
preserves common simplicity in general, are used here.

## Nonsplitting on each individual curve

Let $q=F_C^{[r]}$ and $0<j<r$. The quotient $q_*\mathcal O_C\to
B_C^{[r]}$ and finite Frobenius duality give
\[
\operatorname{Hom}(B_C^{[r]},P_{j,C}^{[r]})
\hookrightarrow H^0(C,q^*P_{j,C}^{[r]}\otimes\omega_C^{1-p^r}).
\tag{2}
\]
The bundle on the right is filtered by the line bundles of exponents
\[
p^{r-j}m+1-p^r,\qquad 1\le m\le p^j-1.
\]
They are all negative. Since $C$ is hyperbolic, the right side of
(2) vanishes. In particular the actual height-two sequence
\[
0\longrightarrow B_{C^{(1)}}^{[1]}\longrightarrow B_C^{[2]}
\longrightarrow F_{C^{(1)}*}B_C^{[1]}\longrightarrow0
\tag{3}
\]
has no retraction.

Both end terms of (3) are common-simple. A common subbundle has
intersection with the first term either zero or the whole term,
and image in the last term either zero or the whole term. The
only additional possibility would split (3). This proves the
complete height-two lattice, including its actual extension data.

If $M,N$ are semistable of the same slope on a hyperbolic curve,
adjunction proves
\[
\operatorname{Hom}(F_*M,F_*N)=\operatorname{Hom}(M,N).
\tag{4}
\]
Indeed the kernel of $F^*F_*M\to M$ is filtered by the semistable
$M\omega^i$, $1\le i<p$, all of greater slope than $N$.
Every map from that kernel to $N$ is zero. Iteration is valid
because Frobenius direct image preserves semistability and the
equality of slopes.

Each adjacent two-factor extension $P_j/P_{j-2}$ is the
$(j-2)$-fold direct image of (3) on the appropriate earlier twist.
Its middle and first terms come from semistable bundles of the
same slope. Equations(2),(4) rule out a retraction, hence a splitting,
at every height.

## Why simplicity of the factors is the exact remaining condition

Suppose all factors $E_i=P_i/P_{i-1}$ are common-simple. For a
common subbundle $U$, put $U_i=U\cap P_i$. Each graded term
$U_i/U_{i-1}$ is zero or $E_i$. A zero term followed by a nonzero
term would give a section of
\[
0\to E_{i-1}\to P_i/P_{i-2}\to E_i\to0,
\]
contrary to the preceding nonsplitting. Thus the nonzero terms
form an initial interval. Saturation then identifies $U$ with
the corresponding actual $P_j$.

Conversely a proper common subbundle of $E_j$ has a saturated
inverse image strictly between $P_{j-1}$ and $P_j$. This proves
both directions, without replacing the filtration by a direct sum.

## Common simplicity at all heights

Let $H_s=F_*^{[s]}B^{[1]}$ on its specified twist. The first-height
Cartier theorem supplies the induction base $H_0=B^{[1]}$.
Suppose $H_s$ is common-simple and let $0\ne V\subset F_*H_s$
be a common saturated subbundle.

The one-step argument above applies without requiring its rank
prime to $p$. The induced grades of $F^*V$ are exactly
$H_s\omega^i$, $0\le i<\ell$, for some $1\le\ell\le p$.
Projection from $F^*F_*H_s$ to its first $\ell$ diagonal-ideal
grades is the canonical map to the ACTUAL principal-parts bundle
$J^{\ell-1}H_s$. Restricted to $F^*V$, it is an isomorphism:
its kernel is the vanishing intersection with the $\ell$th
filtration term, and each of its induced graded maps is an
isomorphism. Hence
\[
F^*V\simeq J^{\ell-1}H_s
\tag{5}
\]
is a common identification, carrying the canonical Cartier
connection on its left side.

The [scalar Atiyah theorem](common_atiyah_jet_obstruction.md) gives
$\gamma_s=\operatorname{id}_{H_s}\otimes a(\omega)\ne0$ at EVERY
height. This assertion uses only first-height common simplicity,
not the present induction conclusion. Finite Frobenius duality
also gives $H_s\simeq H_s^\vee\otimes\omega$.

For a connection on the right side of (5), the general block-sum
calculation in that theorem gives
\[
\ell a(H_s)+\frac{\ell(\ell-1)}2\gamma_s=0.
\]
Adding the adjoint and using $a(H_s)+a(H_s)^\dagger=\gamma_s$
yields $\ell^2\gamma_s=0$. Thus $p\mid\ell$. Since
$1\le\ell\le p$, necessarily $\ell=p$, and $V$ has the full
rank of $F_*H_s$. Its saturated inclusion is an equality.
This proves common simplicity of $H_{s+1}$ and closes induction.

The earlier nonsplitting argument now classifies every common
subbundle of $B^{[r]}$ as one of the displayed $P_j^{[r]}$.

The factors $E_i$ have distinct ranks and hence are pairwise
nonisomorphic common-simple objects. Every interval $P_b/P_a$
therefore has exactly its initial subintervals as subobjects. A
nonzero morphism to $P_d/P_c$ has a final interval of its source
as image and an initial interval of its target. Matching the
distinct simple factors forces $a\le c<b\le d$, and its image
is precisely $P_b/P_c$. The canonical quotient followed by
inclusion supplies such a morphism.

An endomorphism of an interval is scalar on each simple factor.
Adjacent nonsplitting forces all these scalars equal: pushing and
pulling an adjacent extension multiplies its nonzero class by the
two scalars, which must coincide. Subtract their common scalar.
The remaining endomorphism induces zero on every grade, so its
image would simultaneously be an initial subinterval of the target
and a disjoint final subinterval of the source. It is zero.
Thus each interval has endomorphism ring $k$, and the preceding
canonical map spans every nonzero Hom space. This proves the
stated complete interval-morphism formula.

At $p=5,r=3$ this recovers both of the returned connection
exclusions, without separately handling the dual rank60/rank80
cases. For all $s$ the same scalar obstruction excludes jets of
EVERY length not divisible by $p$; lengths $pm$ have the common
Cartier connection through
\[
J^{pm-1}H_s=F^*J^{m-1}(F_*H_s).
\]
The proof preserves the original maps and all relative twists.
It supplies no clump and no contradiction to the existence of a
clumpless span.
