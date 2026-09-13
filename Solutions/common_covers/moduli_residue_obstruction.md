# Proof: Frobenius acts on the geometric stable special fiber

Version 1, 2026-09-11. This is a residue-field filter, not an
arithmetic-curve classification.

Pass to the completion F_v and choose a finite extension over which
the stable model exists and its special fiber is smooth. Work in an
algebraic closure of F_v. Every element of Gal(bar(F_v)/F_v) sends
the curve to an isomorphic curve, since C is defined over F_v.
After passing to a common finite extension, that generic isomorphism
extends uniquely to the two stable models. Their geometric special
fibers are consequently isomorphic.

This uses [Stacks, Lemma 109.24.2](https://stacks.math.columbia.edu/tag/0E97),
which gives uniqueness of a stable model with its generic marking.
The residue map from the local absolute Galois group onto
Gal(bar(F_p)/F_(p^f)) is surjective. A lift of residue Frobenius p^f
therefore gives an isomorphism between the smooth geometric special
fiber and its p^f coefficient conjugate. Its moduli orbit length
divides f. The same comparison handles twists that are geometrically
isomorphic and all further extensions.

Apply the backup's already established moduli orbit length three.
For F=Q one has f=1. For a quadratic F every v|5 has f=1 or 2.
Neither is divisible by three. For an arbitrary field one must test
actual residue degrees, not assume they divide [F:Q] unless F/Q is
Galois.

This immediately removes the rationally defined classical quaternionic
Shimura models and their rational Atkin-Lehner quotients from a
backup arithmetic-reduction search. It applies without computing their
equations or making assumptions on tame reduction of a Belyi map.

The remaining search is genuinely broader. The genus-at-most-two
Eichler-order lists in
[Voight's corrected paper](https://jvoight.github.io/articles/shimbound-mcom-fixed-errata.pdf)
concern specified congruence groups; the derived genus-two list in
[Macasieb](https://arxiv.org/pdf/0803.1519) concerns derived groups.
Neither is the complete set of arbitrary arithmetic genus-two curves.
The [Maclachlan-Rosenberger publication abstract](https://abdn.elsevierpure.com/en/publications/commensurability-classes-of-arithmetic-fuchsian-surface-groups-of/)
claims a complete list of their commensurability data, but its full
paper and geometric models have not been obtained in this workspace.
No missing classification or field-of-definition assertion is inferred.
