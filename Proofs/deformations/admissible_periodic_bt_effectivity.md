# Proof: affine full completions and descent of only their first level

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
[the returned comparison proof](bt_hodge_obstruction_comparison.md).
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

Only first truncations were descended. Their full local completions
need not agree on overlaps, so no global prolongation has been
smuggled into this proof. The proof of the finite-character ambiguity
in [ordinary effectivity](ordinary_oper_bt_effectivity.md), under
its heading comparing two BT1 realizations, explicitly requires
only the existence of one actual realization. It applies unchanged
and gives the final torsor statement.
