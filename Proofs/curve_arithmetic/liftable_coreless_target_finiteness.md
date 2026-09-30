# Proof: finite arithmetic reductions and nonliftable correspondences

[Statement](../../Theorems/curve_arithmetic/liftable_coreless_target_finiteness.md).
Use S_h and E_(h,p) from the
[arithmetic reduction conventions](../../Definitions/arithmetic_curve_reductions.md).

## 1. Finiteness of the arithmetic reduction set

[Borel, Theorem8.2](https://www.numdam.org/article/ASNSP_1981_4_8_1_1_0.pdf)
gives finitely many conjugacy classes of arithmetic lattices of bounded
covolume in PGL₂(R). A compact genus-h curve has area4π(h−1), so S_h
is finite, including noncongruence lattices.

Every such curve Γ\H has a number-field model. Choose a torsion-free
congruence lattice Λ in Γ's commensurability class and a finite-index
subgroup Δ⊂Γ∩Λ normal in Γ. The Δ-curve is a finite étale cover of a
Shimura curve over bar(Q), hence is defined over bar(Q). Its finite
deck group Γ/Δ and quotient descend as well.

For each C_i∈S_h choose a model over a number field L_i. At each of
the finitely many places v|p, form its stable model after a finite local
extension. Retain the geometric special fiber if smooth, together with
its finitely many residue-field conjugates. This finite list includes
every potential good reduction of every geometric copy or twist of C_i:
after a finite extension, a generic isomorphism extends uniquely between
stable models. This comparison also holds over an arbitrary algebraically
closed residue field k: the special fiber is the base change of one of
the retained finite-field models. A singular stable fiber stays singular
under extension.
This uses [Stacks, Lemma109.24.2 and Theorem109.24.3](https://stacks.math.columbia.edu/tag/0E8C).
Taking the union over i proves E_(h,p) finite and Frobenius-stable.

## 2. A lifted coreless correspondence has arithmetic endpoints

[Krishnamoorthy, Lemma4.13](https://arxiv.org/html/1704.00335v2)
(published Lemma4.14) says that a core in the generic fiber of a smooth
proper correspondence over a DVR specializes to a core. After a finite
base extension this also applies to a geometric generic core. Thus a
lift of a coreless special fiber stays coreless.

The characteristic-zero arithmeticity theorem
[Krishnamoorthy, Theorem3.10 and Remarks3.11/3.14](https://arxiv.org/html/1704.00335v2)
then places the generic genus-h endpoint in S_h. Consequently its
special class is a base change from E_(h,p). This is the argument of Corollary4.14
there (published Corollary4.15), with Lemma4.13 allowing an arbitrary
mixed-characteristic DVR. The correspondence and both finite étale
maps are retained throughout.

## 3. The selected pair avoids the finite set

The [fixed-X atlas bound](../quotient_geometry/local_actions/fixed_x_orbifold_bound.md)
and [bounded-atlas partner theorem](../quotient_geometry/bounded_atlas_partner_finiteness.md)
make every span for the selected X,Y_t coreless. The
[arithmetic count](low_genus_arithmetic_bounds.md) gives
|E_(2,5)|<2^2000000. For the prescribed parameter bound K,
D=335999!≥2^335998 and K>2^(D²)>2^2000000.

By the [branch-family theorem](prime_field_branch_family.md), the
Frobenius25 orbit of [Y_t] has length r>K. It cannot meet the
Frobenius-stable set E_(2,5), proving nonliftability. The same argument
applies after any common finite étale refinement: enlarging the ambient
source field does not change the intersection of the two endpoint fields.

An ordinary common nilpotent connection would supply a full canonical
lift by the [ordinary-source theorem](../projective_connections/ordinary_source_partner_finiteness.md),
so it is excluded. An admissible active match still supplies a
[simultaneous W₂ lift](../deformations/admissible_two_leg_w2_lifts.md).
The deformation consequences are recorded with their sharper bounds in
[shared negative extensions](../deformations/two_leg_negative_extensions.md).

The arithmetic count has its separate scoped audit. The lifting and
application deductions here retain author-prose status.
