# Proof: local completions and global effectivity of a supplied full tower

[Statement](../../Theorems/deformations/admissible_periodic_bt_effectivity.md).
Local continuation of the returned integral comparison proof,
21 September2026. The important distinction is between supplied
periodic filtered data and arbitrary candidate $F,V$ matrices.

The [canonical first construction](forced_canonical_witt_endpoint.md)
supplies the stated initial datum for an admissible active oper. It
retains its possible two-torsion periodicity line; it is not silently
made one-periodic. For a flat eighth-torsion line $N$, inverse Cartier
transports it to $N^5$. Hence the discrepancy after twisting is
$\kappa N^4=\kappa^2=\mathcal O$. This is exactly the permitted
fourth-root correction. Its determinant is the finite line $N^2$.

Now work with the resulting specified one-periodic datum. On an
affine etale cover of $C$, choose compatible smooth lifts through
all Witt lengths. Extend the periodic filtered datum inductively.
The new Hodge-line obstruction is a coherent $H^1$ on an affine
scheme and vanishes. Maximality persists by Nakayama and identifies
the next graded Higgs object with the unique lift of the old one.
The determinant fixes the residual graded scalar after a square
root with prescribed reduction. All predecessor maps are retained.

This is the local construction in
[the returned comparison proof](all_height_bt_hodge_dictionary.md).
It uses only the initial periodic datum; an already effective BT1
is needed there to NAME the marking, not to construct these local
completions. The general filtered-flow construction and local
divided Taylor maps are in
[Lan--Sheng--Zuo, Section5](https://arxiv.org/pdf/1311.6424v2).
The affine vanishing replaces indigenous ordinariness in this LOCAL
induction. It cannot replace ordinariness globally on a proper curve.

The full completed local datum yields strongly divisible windows
$F=U\operatorname{diag}(1,5)$ and
$V=\operatorname{diag}(5,1)U^{-1}$, with their actual crystalline
connections. Integral Dieudonne effectivity gives actual full groups
on these affine opens. Their first truncations all realize the SAME
global first crystal with connection and arrows, because every
completion retained its predecessor.

On each overlap the identity of that crystal gives an isomorphism
between two ALREADY EXISTING finite flat groups, by crystalline full
faithfulness. The triple cocycle follows by faithfulness. Effective
descent of their finite locally free Hopf algebras produces a BT1
on the original $C$. Its height, dimension, Hodge line, determinant,
and Kodaira--Spencer map are checked on the affine cover.
See [de Jong, Theorem4.1.1 and Remark2.4.10](https://www.numdam.org/item/PMIHES_1995__82__5_0.pdf)
for the integral effectivity and the comparison between existing
finite flat groups used here.

The affine construction above descends only first truncations. Its
full local completions need not agree on overlaps. The proof of the finite-character ambiguity
in [ordinary effectivity](ordinary_oper_bt_effectivity.md), under
its heading comparing two BT1 realizations, explicitly requires
only the existence of one actual realization. It applies unchanged
and gives the final torsor statement.

## A supplied global full tower realizes every level

A compatible global projective tower gives, in its limit, a projective
filtered crystal $\mathcal P$ with an actual horizontal comparison
$\operatorname{RF}(\mathcal P)\simeq\mathcal P$. Each finite
comparison uses the next curve digit and preceding filtered tuple;
the supplied full tower provides both and their truncation compatibility.

Apply the [ordinary effectivity proof's integral construction](ordinary_oper_bt_effectivity.md#integral-effectivity),
formulas (2)--(9). Indigenous ordinariness there supplies the canonical
projective object in formula (1); here the GIVEN tower supplies it.
The remaining construction has no ordinary hypothesis: the specified
spin lift extends through the etale central kernel $\mu_2$, and
the renormalized elementary lattice differs from it by a flat line
$\mathcal Q$ with $\mathcal Q^2=\mathcal O$ and reduction $\kappa$.
The unique lift $\mathcal N$ of the chosen prime-to-five line satisfies
$\mathcal N^4=\mathcal Q$, $\mathcal N^8=\mathcal O$. Thus
$\operatorname{RF}(\mathcal E\otimes\mathcal N)
\simeq\mathcal E\otimes\mathcal Q\otimes\mathcal N^5
\simeq\mathcal E\otimes\mathcal N$.

This supplies strongly divisible windows at every precision. Unlike
the unrelated affine completions used above, their crystalline overlap
maps agree at EVERY level, since they come from the supplied global
tower. Full faithfulness and finite-Hopf descent glue their truncations,
inclusions and multiplication into an actual full group on $C$.
The retained comparison preserves the first periodic marking. The
same determinant normalization as in the integral construction,
by an etale character twist trivial modulo five, preserves that marking.
