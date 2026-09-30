# Properness would provide a simultaneous Galois refinement

This proves
[the stated one-way implication](../../Theorems/quotient_geometry/coreless_profinite_amalgam.md).
The proof applies in arbitrary characteristic.

Assume both vertex groups embed in G. A continuous injection from a
profinite group into a profinite group identifies it with a closed
subgroup. The two copies of H agree. Since H is open in each vertex,
the subsets G_X minus H and G_Y minus H are compact and omit the
identity. Open normal subgroups form a neighborhood basis of the
identity in G. Compactness therefore supplies one open normal U in G
disjoint from both complements. Hence
\[
N=U\cap G_X=U\cap H=U\cap G_Y
\]
is open in H and normal in both vertices. This is the special
profinite case of
[Cusinato, Lemma3.4](https://arxiv.org/html/2609.01234v2), with a direct
proof included so that properness remains explicit.

The subgroup N determines one pointed connected finite etale cover
W->T. Viewed inside either endpoint fundamental group it is open and
normal, so the corresponding composites W->X and W->Y are Galois.
These are the composites of the original two maps; no endpoint
field has been replaced by an abstract isomorphic copy.

By Hurwitz, W has genus at least two. Its group of geometric
automorphisms is finite. The two deck groups G'_X and G'_Y therefore
generate a finite subgroup D of Aut(W). The field k(W)^D has
transcendence degree one over k, and
\[
k(W)^D\subset k(W)^{G'_X}\cap k(W)^{G'_Y}
           =k(X)\cap k(Y)
\]
inside k(W). Both endpoint fields lie in the specified embedded k(T),
so their intersection is exactly the original intersection, transported
along the injection k(T)->k(W). It is a core of the given span.

The argument establishes no faithful compatible family of finite
representations: that would be additional input. In particular,
Cusinato's abstract examples of trivial profinite amalgams are not
examples of the present geometric span. Nonproperness does not rule
out individual nontrivial compatible finite coefficients.
