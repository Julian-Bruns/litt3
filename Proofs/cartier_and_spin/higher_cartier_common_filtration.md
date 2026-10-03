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

## Simplicity from the later seed theorem

The first-height Cartier theorem makes B common-simple, of
rank p-1 with its perfect common omega-valued alternating pairing.
The [general seed theorem](common_atiyah_jet_obstruction.md)
therefore proves that EVERY H_s=F_*^[s]B is common-simple and that
J^(ell-1)H_s has a common connection exactly when p divides ell.
This single application supplies all factor simplicity required
below. It retains actual relative twists and common subobjects.

The canonical filtration and preservation of semistability under
Frobenius direct image are the curve case of
[Sun's direct-image theorem](https://arxiv.org/pdf/math/0611360).

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

## The interval category

All factors are common-simple by the seed theorem. The preceding
nonsplitting argument therefore identifies every common subbundle
of B^[r] with exactly one displayed P_j^[r].

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
