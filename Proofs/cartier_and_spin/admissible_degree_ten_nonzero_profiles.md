# Proof: a small pole-two cohort cannot survive the trace equations

The audited nonzero-source report's exhaustive Newton classification
is retained in
[P28--P29](../../../litt3-computation-data/october01_audited_replies/nonzero_first_moment/nonzero_first_moment_audited/REPORT.md).
It tests fifty partitions and five first-moment charts by exact linear
equalities and nonvanishing conditions, removes two thin cases, and
leaves twenty-seven necessary profiles. No original computation is
replayed here. Its fivefold leading-cohort exclusion is P51 in the
same report. None of that classification asserts actual existence.

The [uniform annihilator theorem](admissible_annihilator_trace_vanishing.md)
now excludes exactly one, two or three pole-two sheets in every actual
degree. In degree ten the large poles equal $2+g_i$, where the five
$g_i\ge0$ sum to $10-d$. Thus the number of pole-two sheets is the
number of zero parts after padding the positive $G$-partition to five.

Among the twenty-seven surviving profiles, every one except the nine
listed in the statement has two, three or four positive $G$-parts,
hence respectively three, two or one pole-two sheets. These are now
excluded. The four profiles with one positive part have $m=12$ and
$d=0,3,6,9$. The five profiles with no positive part have $d=10$
and the five displayed values of $m$. This proves the profile list.

For completeness, retain repeated leading residues in the Vandermonde
argument. On pole-two sheets write $W_i=\beta_i r^{-2}+\cdots$ and
$\chi_i=c_i+\cdots$, with $\beta_i,c_i\ne0$. The uniform lemma gives
\[
\sum c_i\beta_i^j=0\quad(j=2,3,4),\qquad
\sum\beta_i^{-1}=0.
\]
Group equal values of $\beta_i$. If there are at most three groups,
the weighted three-row Vandermonde matrix is injective. Every group's
weight sum must vanish, so a singleton group is impossible.

For four sheets the only remaining repeated partition is two plus two,
or one group of four. The latter contradicts $4/\beta=0$. For two
groups of two the unweighted identity is $2/a+2/b=0$, hence $b=-a$.
Otherwise all four residues are distinct.

For five sheets, three or fewer groups without a singleton leave a
single group of five or groups of sizes three and two. The first is
the already excluded fully concentrated leading cohort. In the second,
$3/a+2/b=0$ gives $3b+2a=0$, hence $b=a$ in characteristic five,
contrary to distinct groups. Thus at least four residues are distinct.

The resulting nine profiles and these residue alternatives still do
not solve their global torsion or étale-normalization incidences.
