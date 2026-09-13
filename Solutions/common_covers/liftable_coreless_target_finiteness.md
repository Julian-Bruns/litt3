# Proof: arithmetic generic fibers and their finite good-reduction sets

[Statement](../../Theorems/common_covers/liftable_coreless_target_finiteness.md).

## 1. A finite characteristic-zero list

By [Borel, Theorem8.2](https://www.numdam.org/article/ASNSP_1981_4_8_1_1_0.pdf),
there are finitely many conjugacy classes of arithmetic lattices of
bounded covolume in PGL2(R). A compact arithmetic genus-h curve is a
torsion-free orientation-preserving quotient of covolume4pi(h−1).
Passing from PGL2 to its index-two orientation-preserving subgroup
introduces at most a factor two in the list. Thus there are finitely
many complex curve classes C_i. This is arithmetic-lattice finiteness,
NOT Wang's theorem for arbitrary lattices, which excludes this group.
Borel8.1–8.2, printed pp25–26, explicitly treats the real rank-one case.
An equivalent surface statement is
[Belolipetsky–Gelander–Lubotzky–Shalev, Corollary1.4 and Section5.3](https://annals.math.princeton.edu/wp-content/uploads/annals-v172-n3-p17-p.pdf).

Every C_i is defined over a number field, even for a noncongruence
lattice Gamma. Choose a torsion-free congruence lattice Lambda in its
commensurability class and a finite-index subgroup Delta of Gamma∩Lambda
normal in Gamma. The Delta curve is a finite etale cover of a Shimura
curve over bar(Q), so descends to bar(Q). Its finite deck group Gamma/Delta
also descends (the automorphism scheme of a hyperbolic curve is finite).
Taking its quotient descends C_i. Spreading gives a number-field model.
These are the arithmetic curves in
[Krishnamoorthy, Theorem3.10 and Remarks3.11/3.14](https://arxiv.org/html/1704.00335v2).

## 2. Only finitely many reductions of each curve

For a fixed model C_i/L_i and each of the finitely many places v|p,
choose its stable model after a finite local extension. If the geometric
special fiber is smooth, retain all its base changes to bar(F_p) through
the finitely many embeddings of its residue field; otherwise retain none.
This gives a finite set R_p(C_i).

It contains every possible smooth geometric reduction of a twist or
geometric copy of C_i. After completing a proposed DVR and extending its
fraction field finitely, a generic isomorphism and an embedding of L_i
are defined. The embedding selects a place above p. Compare with the
chosen stable model after another finite extension. Uniqueness of stable
models identifies the geometric special fibers. A singular stable fiber
cannot become smooth under further extension. See
[Stacks, Lemma109.24.2 and Theorem109.24.3](https://stacks.math.columbia.edu/tag/0E8C).
Including residue embeddings is essential: Frobenius-conjugate k-curves
need not be k-isomorphic.

## 3. Apply this to the SAME lifted span

A core in the geometric generic fiber of a simultaneous lift would
specialize to a core. This is
[Krishnamoorthy, Lemma4.13 of arXivv2](https://arxiv.org/html/1704.00335v2)
(published Lemma4.14). Its proof reduces a common rational function,
successively subtracting lifted residue constants and dividing by a
uniformizer until its reduction is nonconstant. After completion this
procedure must terminate: otherwise the function is a convergent series
of constants in the complete fraction field and was constant already.
Algebraic extension of the ground field preserves having a core
(Proposition3.8), so the geometric version follows as well.

The lifted span is therefore coreless, and Theorem3.10 makes its endpoint
curves arithmetic in characteristic zero. This is precisely Corollary4.14
of arXivv2 (published Corollary4.15) for Witt lifts; the same argument
allows any mixed-characteristic DVR. If necessary descend the finite
generic diagram to a finitely generated characteristic-zero field before
embedding it in C. Hence Y's generic geometric class is one of the C_i,
and its special class belongs to

    E_(h,p) = union_i R_p(C_i).

## 4. Effective application to the existing parameter (version2)

For our fixed X, [the audited atlas bound](../orbifolds/fixed_x_orbifold_bound.md)
and [bounded-atlas finiteness](../atlases/bounded_atlas_partner_finiteness.md)
already exclude cored partners for the prescribed Y_t. The new
[arithmetic count](../arithmetic/arithmetic_genus_two_reduction_bound.md) gives
|E_(2,5)|<2^2000000. This is below the EXISTING parameter bound K:
D=335999!>=2^335998, so D²>2000000, while
K>=3^(4G²L)>2^(D²)>2^2000000. Only these symbolic inequalities are
needed; neither D nor K is computed.

The [affine branch-family theorem](../genus_two/prime_field_branch_family.md)
gives Y_t a full Frobenius25 moduli orbit of length r>K>5. Since
E_(2,5) is Frobenius-stable and smaller than r, it cannot contain Y_t.
Section3 excludes full mixed-characteristic lifts of every actual
common span for this pair.

[Refinement invariance](../deformations/etale_refinement_deformations.md) shows that
refining a fixed diagram cannot repair a missing full lift: any full
refined lift descends through all marked Artinian levels, and the unique
compatible factorizations algebraize by the proper finite-etale
equivalence (Stacks0BQC). One may also apply the same target-set theorem
directly, since corelessness of the specified endpoint intersection is
unchanged when the ambient source field is enlarged.

Finally the canonical-lift argument in
[ordinary_source_partner_finiteness](ordinary_source_partner_finiteness.md)
rules out ordinary compatible common nilpotent connections for this
pair. [admissible_two_leg_w2_lifts](../deformations/admissible_two_leg_w2_lifts.md)
still gives the first lift for an admissible active match. The small
deformation-ring and p-nilpotence statements of
[etale_refinement_deformations](../deformations/etale_refinement_deformations.md)
then give R a quotient of W(k)[[t_1,t_2,t_3]], with finite nilpotence
exponent e for5. A W2 point forces e>=2. Refinement identifies R, hence
also e; it cannot remove the obstruction. No bound on e across different
spans follows, and a W2 point does not itself imply a W3 point.

The count ingredient was independently audited. The current-pair and
deformation corollaries above are author integration, not a new audit
of the prior general lifting theorems. Nonliftable common spans and the
no-common-connection branch remain open.

For clarity about the two ordinariness notions, the scalar nilpotence
equation is N(r)=-(E')²-3E(E''+3rE), with E=r''-3r². At a dormant point
E=0 its linearization is zero in EVERY quadratic direction. Thus the
nilpotent tangent there is all H^0(omega²), whereas the dormant tangent
is the kernel of phi->phi''-r phi and can be zero. Only for an active
admissible connection does the canonical-double theorem identify its
nilpotent tangent with the dormant tangent(s) of its canonical pair.
The new nonliftability result must not be used to claim that every
shared dormant connection is a nonreduced dormant point.
