# A universal finite target set for liftable coreless correspondences

Fix a prime p and genus h>=2. There is a finite set E_(h,p) of geometric
genus-h curve classes over bar(F_p) with this property: in any ACTUAL
coreless finite etale span X←Z→Y, with g(Y)=h, if the entire diagram
has a simultaneous smooth proper mixed-characteristic DVR lift with
both maps finite etale, then [Y] belongs to E_(h,p).

The set depends ONLY on h,p, not X, the source genus, covering degrees,
Galois status, a connection, or ordinariness. Finite ramified base
extensions and twists are allowed. It includes all geometric potential
good reductions at p of the finite list of compact arithmetic complex
curves of genus h, including noncongruence curves and residue conjugates.

## Application to the ALREADY prescribed Litt3 pair

Let X be the fixed genus-nine curve, and use EXACTLY the prescribed
genus-two partner Y_t of bounded_atlas_partner_finiteness: with

    D=335999!, G=1+8D, L=336000²,
    K=D*(D!)^18*3^(4G²L)*(42000!)^(2G+L),

take any prime r>max(K,120) and any t of degree r over F25.
The [explicit arithmetic bound](Thm_arithmetic_genus_two_reduction_bound.md)
proves |E_(2,5)|<2^2000000<K. Thus this SAME Y_t already avoids
E_(2,5), with no optional additional parameter exclusion.

Every hypothetical actual common finite-etale span for this pair is
coreless and admits NO simultaneous smooth proper mixed-characteristic
DVR lift with both maps finite etale, even after finite ramified base
extension or any further common etale refinement. No A18/atlas candidate
exclusion is used.

For this existing choice, a compatible nilpotent connection on any
witnessing source is necessarily nonordinary in the indigenous sense:
an ordinary shared connection would give a full canonical lift. A
compatible ADMISSIBLE ACTIVE connection still supplies a common W2
lift. Thus in that branch the missing lift occurs beyond W2.

Here nilpotent ordinariness is NOT reducedness in the dormant scheme.
At every dormant connection d on any curve C, T_d N(C)=H^0(C,omega²):
it is automatically nonordinary in the NILPOTENT sense. The conclusion
does not force a nonzero DORMANT tangent. Its additional source-defect
content applies to the admissible active branch and its canonical pair.

For every fixed hypothetical span, its simultaneous marked deformation
ring R is a quotient of W(k)[[t_1,t_2,t_3]] with 5 nilpotent. If an
admissible active match exists, it has a W2 point: the nilpotence exponent
is finite but at least2. The ring and its exponent are unchanged by
etale refinement. No bound on that exponent uniform over different
spans, nor even a lift to W3, is proved.

This does not prove that common covers are absent. Nonliftable spans,
nonordinary common connections, and the possibility of no common
connection remain unresolved.

Version2,2026-09-09: the audited arithmetic count removes the additional
parameter qualification and proves the current-pair nonliftability
corollary. Application and deformation consequences are author prose;
the arithmetic ingredient has a separate scoped audit. Version1 was
the canonical restoration of the2026-09-05 qualitative result.
[Proof](../Solutions/Sol_liftable_coreless_target_finiteness.md).
