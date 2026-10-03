# A small section-span deficit bounds denominator clearing

ID: `section_span_clearing_degree_bound`. Version1,2 October2026.
Author proof and focused root mathematical review PASS. No characteristic
or source-degree restriction is imposed in the geometric lemma.

Let C be a smooth projective connected curve of genus g over an
algebraically closed field. Let $\psi:C\to\mathbf P^m$ be nonconstant,
with $L=\psi^*O(1)$. For $d\ge1$ let $S_d\subset H^0(C,L^d)$
be the span of the degree-d monomials in its base-point-free coordinates,
and put $t=h^0(C,L^d)-\dim S_d$. If
\[
\deg L^d\ge2g+t+1,
\]
then EVERY scheme-theoretic fiber of psi has length at most t+1.
Tangencies, distinct points in one fiber and inseparability are included.
For t positive this need not be an embedding.

For the denominator application, let $x:C\to\mathbf P^1$ be finite
separable, let $R=H^0(x^{-1}(\mathbf A^1),O_C)$, and let
$V\subset R[T]_{<m}$ have dimension m+1 and coefficient rank m over
k(C). Its maximal minors define the projective kernel map psi after
removing their common local divisor. Suppose psi is nonconstant and its
coordinate section-span deficit satisfies the displayed bound.

If $0\ne p\in V$, $c\in k(C)$, $(T-c)p\in R[T]$, and every
finite pole of c avoids the coefficient-rank-drop locus, then the monic
minimum x-clearing polynomial of c has degree at most t+1. Thus a
necessary clearing degree greater than t+1 excludes the factorization.
Poles on the rank-drop locus require a separate argument.

More generally for $\dim V>m+1$, a bound b on every fixed-section
fiber of the coefficient-kernel incidence $\mathbf P(\mathcal K)$
gives clearing degree at most b. Generic rank alone supplies no such
fiber bound, and the monomial-deficit proof above is not automatically
an incidence bound in this higher-rank case.

In the actual degree-ten m9 application, the111 kernel maps have
degree37 and full seventh section spans. The21 maps have degree35,
seventh span codimension ONE, hence scheme fibers of length at most TWO.
Both contradict clearing degree three after their separately proved
rank-boundary pole exclusion. Complete projective embeddings are
therefore unnecessary for the21 branch.

[Proof](../../Proofs/cartier_and_spin/section_span_clearing_degree_bound.md).
