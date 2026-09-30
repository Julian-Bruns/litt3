# Rootwise residue separation removes multiple five-block exceptions

27 September2026. Retain the notation and fixed two-jets of
[the differentiated trace proof](differentiated_endpoint_phase_balance.md).
Its two full-rank k=2 matrices imply, at EACH root alpha independently,
\[
S_{\alpha,0}(4)+\zeta S_{\alpha,1}(4)+\zeta^2S_{\alpha,2}(4)=0,
\quad
S_{\alpha,0}(8)+\zeta S_{\alpha,1}(8)+\zeta^2S_{\alpha,2}(8)=0.
\tag{1}
\]
These implications precede the anchor argument and do not assume
anything about the k=1 Fourier sums.

## A four-phase anchor and complementary cyclotomic orbits

For multisets of at most three phases, the first relation in(1)
alone forces the three multisets to be identical. For length four,
the TWO relations together force equality. Exact finite proofs are
given below; arbitrary repetitions are retained. If m<=19, one of
the four root multiplicities is at most four, including an absent
root. Thus there is an anchor at which the three phase multisets
already agree as integers.

The two k=1 coefficient matrices have rank three and one-dimensional
kernels with all coordinates nonzero. Their Fourier sums vanish at
the anchor, hence at every root. As in the earlier proof, both
S(4) and S(8) agree sheetwise everywhere. Their exponent Frobenius
orbits exhaust all nontrivial29th roots; equal cardinalities then
force all phase multiplicities to agree modulo five.

## The index-five norm coefficient separates all four roots

Write each sheetwise count as its common residue in{0,...,4} plus
five times a nonnegative integer. At root alpha_i, the resulting
five-block multisets have a common cardinality b_i<=floor(m_i/5)<=3.
The residual integer phase multisets are already balanced. At the
opposite endpoint the leading pole-residue polynomial has the form
G(W)^5 J(W^3), with deg G=3 sum b_i. Its index-five coefficient is
-(sum of roots of G)^5. The full norm polynomial adds only the factor
W^(n-3m) at leading order. Since L(5O)=span(1,x), that coefficient
has no pole term of order five and must vanish.

Choose rho_0^3=P(alpha_0) and rho_i=rho_0^(25^i). Let B_i be the
canonical leading endpoint constant in the earlier proof. The leading
residue of each block on sheet s is, up to a common nonzero factor,
\[
w_i\zeta^{2s}\xi^{-10j},\quad
w_i=\frac{2A'(\alpha_i)}{[13]}B_i^{-10}
 P(\alpha_0)^{2(25^i-1)/3}.
\tag{2}
\]
The common factor includes rho_0^2 and the comparison scalar; it
may be removed from a zero sum. All w_i lie in E=F_(5^8). In its
basis1,alpha_0,alpha_0^2,alpha_0^3 over F25 their column matrix is
\[
\begin{pmatrix}
[0]&[16]&[3]&[22]\\
[24]&[22]&[19]&[17]\\
[13]&[8]&[6]&[18]\\
[7]&[16]&[20]&[22]
\end{pmatrix},\qquad\det=[12]\ne0.
\tag{3}
\]
Because E and K0 are linearly disjoint over F25, the same four
columns are independent over K0. The index-five zero sum therefore
separates rootwise:
\[
\sum_{s=0}^2\zeta^{2s}\sum_{j\text{ in block sheet }s}\xi^{-10j}=0
\quad\text{for each root }\alpha_i.
\tag{4}
\]
Each block multiset has length at most three. The exponent-10 map
permutes mu29 and swapping the two nontrivial cubic sheets swaps
zeta with zeta^2. The first-moment three-phase rigidity now makes
the three block multisets identical. Together with their balanced
residues this proves INTEGER phase balance at every root.

The argument does not require all five-blocks to occur at one root.
That was the restriction in the earlier m<=9 proof; the invertible
matrix(3) is exactly what removes it. The bound m<=19 is retained:
the proof uses both a four-phase anchor and block length at most three.

## Complete local Fourier certificates

For length three there are4,495 phase multisets. Testing all20,205,025
pairs for the first two sheets gives exactly4,495 triples satisfying
the first Fourier relation, all balanced. For length four there are
35,960 multisets and1,293,121,600 pairs. The first relation has42,050
solutions, including6,090 unbalanced ones. NONE of those6,090 satisfies
the doubled-phase relation. Thus the two-coefficient test is essential.

The [relative-F25 producer](../../scripts/arithmetic/cubic_fourier_phase_multisets.cpp)
forms all exact sum keys in seven F25 coordinates. The
[independent absolute-F5 verifier](../../scripts/arithmetic/verify_cubic_fourier_phase_absolute.cpp)
reconstructs the degree14 field, the cubic character and every sum
without the producer's field tables, using fourteen F5 coordinates.
Both complete runs agree on all counts and find zero unbalanced
two-moment triples. No hash collision is treated as field equality:
the keys encode all field coordinates injectively.

The expanded [two-jet certificate](../../scripts/arithmetic/differentiated_endpoint_phase_certificate.py)
reconstructs(2)--(3) directly and records determinant[12]. Evidence is
cubic_fourier_three.log,cubic_fourier_four_two_moments.log,
cubic_fourier_three_absolute.log,cubic_fourier_four_absolute.log and
differentiated_endpoint_phases_v2.json in
[the phase directory](../../../litt3-computation-data/prime_field_phases_20260927/).
The complete one- and two-phase cases remain in the earlier certificate.
