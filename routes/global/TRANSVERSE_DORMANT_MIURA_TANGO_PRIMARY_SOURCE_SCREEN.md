# Everywhere-transverse dormant Miura structures: precise Tango reformulation

Date: 2026-09-05. Author: `/root/dormant_miura_tango_bietale_literature`.
Status: focused primary-source screen and elementary deductions; no corelessness theorem proved. The tame-cover reduction is proved and audited separately. A source-based correction and the finite-pool deductions below passed a fresh check by /root/tango_line_class_and_uniqueness_check, 2026-09-05; [audit record](audits/TANGO_LINE_CLASS_AND_UNIQUENESS_CHECK_2026_09_05.md), for investigating doubts only.

## Sources and exact match

[Wakabayashi, *Moduli of Tango structures and dormant Miura opers*](https://arxiv.org/html/1709.04241), Theorem 5.4.1 and Proposition 5.3.2, identify dormant **generic** Miura structures with Tango structures on an unmarked smooth curve. His `sl_2` notation uses the adjoint group PGL2 (§2.1). Characteristic five satisfies the rank hypothesis `2<p`. The horizontal Borel must be everywhere opposite to the oper Borel. A Tango structure is an embedded line

    M ⊂ B_X := ker(C:F_*Ω_X → Ω_(X^(1)))

whose adjoint `F^*M → Ω_X` is an isomorphism (Definition 5.1.1). Equivalently, it is a dormant connection on Ω_X whose horizontal sections lie in ker Cartier (Definition 5.3.1). I read the proof of Proposition 5.3.2 and Theorem 5.4.1: Cartier descent and the canonical rank-two construction give the equivalence; extension from the smooth unmarked locus handles the logarithmic version. No assertion concerning cores of correspondences enters those proofs. The finite-moduli conclusions concern structures over a fixed moduli space of curves, not a bound on the curves in an iterated correspondence tower.

[Hoshi, *Frobenius-affine Structures and Tango Curves*](https://www.kurims.kyoto-u.ac.jp/~yuichiro/rims1913revised.pdf), Theorem 3.10, identifies level-N Frobenius-affine structures, affine indigenous structures, and Tango functions modulo `Aff_1(k(X)^(p^N))`. Theorem 1.9(ii) identifies level-one Tango functions with separating rational functions t satisfying `div(dt) ∈ p Div(X)`. The proof of the atlas correspondence (Lemmas 2.4–2.5, Proposition 2.7) checks regularity of rational affine transitions between étale charts. The proof of Lemma 3.7 identifies the Kodaira–Spencer map with the differential of the local chart. Thus the correspondence is sensitive to nowhere-vanishing transversality. It is not a theorem about affine transitions with constant coefficients. Remark 1.7.2 constructs hyperbolic examples by ramified cyclic covers of P1; these are not coreless projective étale spans.

## Elementary consequences for the actual span

Let `a:Z→X` and `b:Z→Y` be the specified finite étale maps, and suppose their pulled-back regular generic dormant Miura structures agree, including the horizontal Borel. Put `K=k(Z)` and regard endpoint function fields as the actual subfields of K determined by a,b.

The Tango correspondence commutes with these pullbacks: the relative Frobenius square for an étale map is Cartesian, and differentials and the locally exact sequence commute with étale base change. Consequently the two embedded Tango lines become **the same** line in `B_Z`. For two actual Tango structures on proper Z, equality is equivalent to isomorphism of their underlying line bundles on Z^(1), by Wakabayashi's Remark 5.1.3. The earlier version incorrectly said their isomorphism classes were insufficient. Equality only after Frobenius pullback to omega_Z is insufficient; these are different conditions.

## Finite classes and faithful pullback

Here is the short proof of the class criterion. For a Tango line M,
adjunction gives

    Hom(M,F_*omega_Z)=Hom(F^*M,omega_Z)=H^0(Z,O_Z)=k.

Two Tango embeddings of the same line bundle therefore have the same
image. Properness and F^*M=omega_Z are essential to this argument.

On a fixed projective C the possible root classes F^*M=omega_C,
if nonempty, form a torsor under the geometric kernel of F^* on Pic.
There are 5^f(C) such classes, where f(C) is the p-rank. Thus C has
at most 5^f(C) Tango structures. This bounds geometric points, not
scheme length; many root classes may give no Tango structure.

Etale pullback injects this pool. A difference of two root classes
is 5-torsion. If an etale cover kills it, pass to a connected Galois
closure: descent of its trivialization is a character of the deck
group into k^*, since all global units upstairs are constant. A
character with fifth power 1 is trivial in characteristic five.
Thus the original difference was trivial. Refining an actual span
cannot make two previously unequal pulled-back Tango structures equal.

## Rational-function reformulation

Choose a rational generator of each endpoint Tango line. At the generic point of X, membership in B_X means that its image is `dt_X` for some `t_X∈k(X)` with `dt_X≠0`; likewise choose `t_Y`. Equality of their lines over `K^p` gives

    d(a^*t_X) = u^p d(b^*t_Y),        u∈K^×.

Since the kernel of `d:K→Ω_(K/k)` is K^p, this integrates exactly to

    a^*t_X = u^p b^*t_Y + v^p,       v∈K.

Also `div(dt_X)` and `div(dt_Y)` are divisible by p: a rational generator of M has a divisor on X^(1), and its Frobenius pullback, identified with Ω_X, multiplies every coefficient by p. Conversely, given endpoint Tango structures represented by these functions, this rational identity makes their generic embedded lines equal; saturation gives equality of the line subbundles on Z. Thus it is an exact algebraic reformulation of preservation of the Tango structures.

This relation does not exhibit a core. If u and v were constants, then `a^*t_X` would belong to both actual endpoint fields and supply a nonconstant common function. The available identity permits u and v to be arbitrary rational functions on Z. They need not descend to either endpoint. Being defined over a finite field of constants does not make these rational functions constant. Additional control of u,v would be a new theorem.

The same point explains why the effective divisor of a chosen differential is not automatically common: the relation gives

    div(d(a^*t_X)) − div(d(b^*t_Y)) = p div(u).

The Tango line itself is canonical for the structure; its rational generator and divisor are not.

## Explicit-example and obstruction screen

[Wakabayashi, *Gaudin model modulo p, Tango structures, and dormant Miura opers*](https://arxiv.org/html/1905.03364), Theorems B/3.9, constructs Tango curves as normalizations of `y^(bp−1)=∏(x−z_j)`, with the z_j satisfying the indicated Bethe equations. The map to the x-line is ramified, so this theorem supplies no pair of everywhere-étale projective legs and no assertion that their actual field intersection is k. These examples confirm that the transverse structure itself exists in characteristic five.

The subsequent [Igusa construction](IGUSA_TANGO_COUNTEREXAMPLE_AND_RETAINED_SECTION_BOUNDARY.md)
is a verified coreless projective etale example preserving a Tango
structure. Thus the proposed general core-forcing statement is false.
The earlier literature screen did not locate this construction; it
must not be used as evidence for nonexistence.

Hoshi's higher-level condition gives `p^N | 2g−2` (Corollary 1.10), hence no hyperbolic curve carries compatible affine structures at every level. The hypothesized reduction gives only level one. Passing from it to arbitrary levels would require a further construction preserving the affine reduction; it cannot be inferred from dormancy or repeated étale pullback. The level-one genus divisibility is already satisfied by the reduction and excludes nothing here.

**Usable conclusion:** equality of embedded Cartier-kernel lines is
equivalent to the displayed rational affine relation with p-th-power
coefficients. That condition alone does not force a core. Our actual
reduction additionally retains a shared Cartier-zero positive tensor;
by the [new classification](COMPATIBLE_TANGO_STRUCTURES_SINGLETON_OR_QUARTET.md)
it lies in the singleton case. That case is now also realized by the
[additive projective etale counterexample](CORELESS_PROJECTIVE_ETALE_SINGLETON_TANGO_COUNTEREXAMPLE.md),
so retaining that tensor is insufficient for a universal core theorem.
The original Litt problem and any fixed-curve assertion remain unresolved.
