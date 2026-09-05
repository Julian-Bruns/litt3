# Audit: maximal lower break forces a common residue class

**Verdict:** **PASS.**  The proposed lemma and its stated first-break
consequence are correct.

**Auditor:** `/root/x_elliptic_quotient_maps`

**Date:** 2026-09-05

## Statement checked

Let `P` be a finite `p`-subgroup of `Aut(k[[z]])`, with lower filtration

\[
 P_i=\{\sigma:v_z(\sigma(z)-z)-1\geq i\}.
\]

If `B` is the largest positive lower jump, then every positive lower jump
`b` satisfies

\[
                              b\equiv B\pmod p.           \tag{1}
\]

Consequently, if the first lower jump is one, then

\[
                         P_2=P_3=\cdots=P_{p+1}.          \tag{2}
\]

## Checks

1. The standard lower-filtration commutator inclusion is

   \[
                         [P_i,P_j]\subseteq P_{i+j}
                         \qquad(i,j\geq1).                \tag{3}
   \]

   Thus `[P_1,P_B]` is contained in `P_(B+1)=1`.  Hence
   `P_B` is central in `P=P_1`.  The indexing agrees with the convention
   in file 13, where an element with first nonlinear term of degree
   `i+1` has break `i`.

2. Choose `tau` of exact break `B` and `sigma` of exact break `b`, and
   write

   \[
   \sigma(z)=z+a z^{b+1}+O(z^{b+2}),\qquad
   \tau(z)=z+c z^{B+1}+O(z^{B+2}),
   \]

   with `ac != 0`.  Direct composition gives the degree-`B+b+1`
   commutator coefficient `(B-b)ac`, up to the harmless choice of
   commutator convention.  This is precisely
   `LEM-LEADING-COMMUTATOR` in file 13.  If `B-b` were nonzero modulo
   `p`, the commutator would be nonidentity, contradicting the centrality
   of `tau`.  This proves (1).  There is no division by `B-b`, no
   inseparability issue, and no convergence issue: the calculation takes
   place in the formal power-series ring.

3. A jump occurs at one by the first-break hypothesis.  Equation (1)
   therefore makes every jump congruent to one modulo `p`.  There is no
   jump at any of `2,...,p`, which is exactly (2).  This remains true if
   `P_2=1`.

4. This is the classical result of Serre, *Local Fields*, Chapter IV,
   section 2, Proposition 11: the positive integers `i` with
   `G_i != G_(i+1)` are all congruent modulo the residue characteristic.
   Serre's preceding Proposition 10 supplies (3) and the leading
   commutator calculation.  A scan of the primary text is available
   [here](https://www.sas.rochester.edu/mth/sites/doug-ravenel/otherpapers/Serre-Local.pdf),
   at printed page 70.  Thus the proposed lemma exactly matches a primary
   theorem, rather than requiring a new strengthening of ramification
   theory.

## Numerical consequence checked

In the stated application, suppose the first quotient has order
`|P/P_2|=25`, write `Q=|P|`, and put

\[
 T=\sum_{i\geq2}(|P_i|-1)=\frac{Q+15}{7}.
\]

By (2), the five groups `P_2,...,P_6` all equal `P_2`, of order `Q/25`.
Therefore

\[
 T\geq5\left(\frac Q{25}-1\right).
\]

Combining this with the displayed value of `T` gives

\[
 \frac{Q+15}{7}\geq\frac Q5-5
 \quad\Longrightarrow\quad Q\leq125.
\]

The inequality and its integer rounding are correct.

## Objections and scope

There is no breaking objection.  The warning in file 13 remains
historically accurate: its leading-term lemma alone did not justify a
blanket common-residue assertion.  Maximal-break centrality is the
additional argument that was missing there.  This audit establishes the
local theorem; any downstream use must still verify the separately stated
formula for `T` and the hypothesis `|P/P_2|=25` in its geometric case.

