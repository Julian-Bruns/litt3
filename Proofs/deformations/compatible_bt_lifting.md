# Proof: rigid group data identifies both lifted sources

[Statement](../../Theorems/deformations/compatible_bt_lifting.md).
Author /root,2026-09-09. Both endpoint fields and both actual maps stay fixed.

## The precise external lifting input

[Xia, arXiv:1303.2954v1](https://arxiv.org/pdf/1303.2954), Theorem1.2
and Sections3--4, proves that an everywhere-versal height-two BT group
on a proper hyperbolic curve determines a unique full marked W(k)-lift
of the curve and group. The proof identifies changes of the group
obstruction with changes of the curve by the Kodaira--Spencer
isomorphism. For full groups the local identifications glue uniquely;
H^0(T_C)=0 removes the remaining deformation choices. Formal
algebraization uses the ample canonical bundle.

For TRUNCATED groups, the abstract's uniqueness wording must not be
used. Section4.9 explicitly limits uniqueness. Its Theorem4.10 and
proof give uniqueness of the underlying marked curve through a number
of Witt stages increasing with N. The safe consequence used here is
uniqueness over W_m for N>=m+2. The article writes W_n=W/p^(n+1) in
the introduction but calls the first-order lift C_2 elsewhere; our
weaker range is inside either indexing, not a proposed correction.

Here is the mechanism in that proof. On the first curve thickening,
two group lifts are locally isomorphic. Infinitesimal automorphisms
restrict trivially on the shorter p^(N-1)-torsion, so these shorter
restrictions glue to the same group. Their next obstruction is
therefore the same. The Kodaira--Spencer isomorphism then determines
the same next curve lift. Inductively one loses a truncation level
per thickening. The stated safe range stops before these levels are
exhausted. The group itself need not be unique.

Existence is proved in Sections3.11 and4.2 by changing the curve lift
to kill the group obstruction. Theorem4.11 permits a full curve lift
supporting the fixed finite BT_N group, but this curve is NOT unique
beyond the preceding finite range. This latter theorem cannot alone
identify two lifted sources. The arguments above are marked: local
comparisons reduce to the given identity on the special-fiber pair.

## Full data and finite-level data

First suppose compatibility holds on Z itself. For full groups take
the unique endpoint lifts. Their finite etale covers Z lift uniquely
as covers. Pulling back the endpoint groups gives two lifts of the
SAME specified everywhere-versal group on Z: etaleness identifies
the Kodaira--Spencer lines. Xia's uniqueness identifies these two
marked sources and their group lifts. This is precisely the proof of
[Krishnamoorthy, Corollary10.8](https://arxiv.org/html/1711.04797v2),
without the inessential restriction that both endpoints are the same.
The core hypothesis in that corollary is used for its later arithmetic
conclusion, not for this lifting construction.

For BT_N data and N>=m+2, choose endpoint lifts carrying the groups
through W_m. The same etale lifting and pullback procedure gives two
curve lifts of Z supporting its specified BT_N group. Finite-level
uniqueness identifies the underlying marked curves through W_m.
The group isomorphism need not extend uniquely: only the curve
identification is used to put both maps on one source. Marked curve
isomorphisms are unique since H^0(T_Z)=0.

If compatibility is known only on h:W->Z, apply the preceding argument
to fh,gh. The all-Artinian refinement equivalence in
[etale_refinement_deformations](etale_refinement_deformations.md)
then gives the ORIGINAL marked diagram over W_m. For full BT data,
these descended lifts are unique relative to the lifted endpoint and
are compatible at every m. Their formal curves and maps algebraize.
No simultaneous Galois closure, averaging, or change of embeddings is used.

## Arbitrarily large levels without compatible choices

Let R be the original joint deformation ring. For every m choose any
available N>=m+2 and its compatible group data, on whatever refinement
the hypothesis provides. The preceding argument gives a map R->W_m.
If p were nilpotent in R, say p^e=0, the map to W_(e+1) would be
impossible. Thus p is not nilpotent. The intrinsic lifting criterion
in etale_refinement_deformations v2 gives an actual simultaneous lift
over a finite DVR extension of W(k).

This argument needs no inverse limit of choices of groups. It proves
the nonliftability bound by taking m=e+1. It also explains why the
conclusion from unrelated finite-level choices allows ramification
in the lifting DVR, whereas the full compatible BT hypothesis gives
a lift over W(k) itself.

## Application boundary

For targets outside the finite set in liftable_coreless_target_finiteness,
every coreless witness has a finite bound on the possible compatible
BT truncation level, valid over all of its etale refinements. This
does not bound that level uniformly over different witnesses.

Mochizuki II Proposition2.10 relates active admissible connections to
MF-nabla objects with a square-trivial twist ambiguity. The observation
before II Proposition2.5 mentions associated finite flat groups.
Neither observation has been used here as a construction of compatible
BT_N groups for arbitrary N. The full group construction in ChapterIV
Section2 starts with a full canonical Frobenius object. In particular
this criterion does not yet exclude the AP residual case.
