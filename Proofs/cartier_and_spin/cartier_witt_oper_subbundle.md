# Proof: bracket closure precedes Atiyah descent

[Statement](../../Theorems/cartier_and_spin/cartier_witt_oper_subbundle.md).
The rank lemma in the [skew-Atiyah proof](common_projective_atiyah_detection.md#2-the-unique-possible-proper-subbundle-of-w)
does not assume that the centered Atiyah class vanishes. It makes
every proper nonzero common subbundle of \(W\) rank three and
degree zero, unique and common-simple, with common-simple
rank-two quotient \(Q\). Its numerical step is
\[
5\deg N_Y=s(s-3),\qquad 1\le s\le5,
\]
which leaves only \(s=3,5\).

The composite of the actual vector-field bracket
\[
\Lambda^2K\longrightarrow W\longrightarrow Q
\]
is zero. Indeed \(\Lambda^2K\simeq K^\vee\otimes\det K\) is
common-simple of rank three, whereas \(Q\) has rank two; a
nonzero common map would be injective. Hence \(K\) is a Lie
subbundle before a connection on \(K\) is constructed.

Its bracket is not zero. At the generic point \(W\) is the
derivation algebra of a purely inseparable field extension of
degree five. If \(D\ne0\), then its constant field is the base
field; two nonzero multiples of \(D\) commute only when their
ratio belongs to that field. An abelian subspace therefore has
dimension at most one. Simplicity and equal rank now make the
nonzero bracket an isomorphism
\(\Lambda^2K\xrightarrow{\sim}K\).

The induced action \(K\to\operatorname{End}^0(Q)\) has trace zero
because \(K=[K,K]\). It is nonzero: otherwise \(K\) would be an
ideal in the generic Witt algebra \(W(1;1)\), which is simple in
characteristic five. The source is common-simple and both sides
have rank three. Its generic injection is an isomorphism:
the determinant's rank-drop locus would be a clump, so is empty.

The first three grades of \(F^*K\subset F^*W\) are
\(\omega^{-1},\mathcal O,\omega\). The last two grades of
\(F^*W\) therefore identify with \(F^*Q\), giving
\[
0\longrightarrow\omega^3\longrightarrow F^*Q
\longrightarrow\omega^2\longrightarrow0.
\]
The Cartier connection has the oper second fundamental
isomorphism, and injectivity of Frobenius on common Picard
classes gives \(\det Q=\omega\). These filtration and determinant
steps are proved in the [skew-Atiyah argument](common_projective_atiyah_detection.md#3-the-alternating-second-fundamental-form);
they use bracket closure here in place of its connection
hypothesis.

Conversely the [complementary Bol complex](../projective_connections/dormant_bol_complex.md)
of a common dormant oper has
\[
0\longrightarrow K\longrightarrow F_*\omega^{-1}
\longrightarrow Q\longrightarrow0.
\]
Its kernel is common under the specified original source
comparison and is the unique proper subbundle above. This proves
both directions.
