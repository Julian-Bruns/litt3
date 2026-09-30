# A supported unit shows the limit of modular phase costs

[Statement](../../Theorems/cartier_and_spin/modular_norm_relaxation_nonempty.md).

## The exact first example

The [exact marked-divisor theorem](marked_divisor_relation_lattice.md)
provides a nonpolynomial function g with pole1,617,894 and rootwise
zero triples
\[
(133365,65556,0),\ (22212,0,30252),\
(0,4980,657153),\ (599548,104828,0).
\]
For each sheet count n let r be the representative of4n modulo five
in{0,1,2,3,4}. Define its29 phase counts by
\[
m_0=n-28r,\qquad m_j=r\quad(1<=j<29).
\]
All these counts are nonnegative for the displayed n. They sum to n,
and m_0-r=n-29r is divisible by five. Thus on each sheet the residue
is constant across all29 phases, and the required sheet differences
are constant too. The exact data are:

| Root | Common residue triples r | Phase-zero count triples |
| ---: | --- | --- |
|0|(0,4,0)|(133365,65444,0)|
|1|(3,0,3)|(22128,0,30168)|
|2|(0,0,2)|(0,4980,657097)|
|3|(2,2,0)|(599492,104772,0)|

For every nontrivial phase character the sheetwise Fourier sum is
r times the sum of all29 roots, hence zero in characteristic five.
In particular the two trace moments4 and8, and both cubic characters,
vanish separately. The supported-logarithmic identity is automatic.
The same exact lattice theorem excludes every lower nonpolynomial
supported function, independently of its phase counts, proving sharpness.
The compact [integer receipt](../../../litt3-computation-data/conceptual_continuation_20260929/marked_minimum_phase_packet.json)
checks nonnegativity, all sums, residues and the total degree.

The other eleven minimizing divisors are arithmetic Frobenius conjugates
and have the same property. This gives the exact boundary of the
relaxation, but still supplies no actual maps or complete local branches.

## A general construction, retained independently of the exact minimum

Choose one marked point R. By the
[marked subgroup theorem](marked_support_five_saturation.md), its class
[R-O] has finite order N prime to five. Choose a positive multiple
e of N with e>=29 and e congruent to29 modulo five. There is a rational
function g with divisor eR-eO. It is regular away from O. It is not
a polynomial in x, since its zero divisor is confined to one point
of an unramified three-point cubic fibre.

At this root and sheet set the phase multiplicities to1 at each of
the28 nonzero phase indices, and to e-28 at phase0. Set every count
at the other eleven points to zero. These are nonnegative integers,
their total at R is e, and their residues modulo five are1 at all29
phases on the selected sheet. Sheet differences are therefore constant
as required by the unbounded modular theorem. For every nontrivial
29th root xi and every r not divisible by29,
\[
\sum_j m_j\xi^{rj}=\sum_{j=0}^{28}\xi^{rj}=0
\]
in characteristic five. In particular both trace moments4 and8 vanish,
with both cubic characters and all root weights included.

The logarithmic identity holds automatically, giving dg/g=4omega_R.
Equivalently this is the single-root residue profile(29,0,0) with
(e-29)/5 additional fivefold zeros. Thus it passes the exact integer
phase-cost condition as well, at a sufficiently large budget.

No two maps, local branch series, full norm polynomial or actual
common source have been supplied. The construction only proves that
these particular necessary conditions form a strictly weaker problem.
It explains why the finite low-degree exclusions can be useful without
supporting extrapolation to all degrees. This general construction needs
no additional computation beyond the stated marked-group input.
