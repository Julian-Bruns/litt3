# Sources: dormant indigenous bundles and rank-two candidates

[Statement](../../Theorems/projective_connections/dormant_rank_two_candidates.md).

Wakabayashi, [*An Explicit Formula for the Generic Number of Dormant
Indigenous Bundles*](https://doi.org/10.4171/PRIMS/138), Publ. RIMS **50**
(2014), 383–409: Theorem 3.3 gives finite faithful flatness and generic
etaleness; Proposition 2.4 fixes the spin normalization in the nonsplit
case; Lemma 4.2 and Proposition 4.3 give the determinant-trivial rank-two
Quot description in F_*(L^vee). We use his L, mathcal F and
M^Zzz... notation. His literal Definition2.3 requires a nonsplit
extension; the all-genus count here concerns indigenous objects.
[Full text](https://ems.press/content/serial-article-files/41233?nt=1).

His Corollary 5.4 gives d_g(p) for p>2(g-1). To include every odd prime,
combine its polynomiality calculation in §6.2(2) with Liu–Osserman,
[*Mochizuki's indigenous bundles and Ehrhart polynomials*](https://doi.org/10.1007/s10801-006-6920-x),
J. Algebraic Combin. **23** (2006), 125–136, Theorem 2.1: the moduli
degree is one polynomial in all odd primes. Agreement at infinitely
many primes identifies these polynomials. At p=5 this gives S_(g-1);
its two roots satisfy x²-5x+5=0, giving the recurrence and S_8=29375.

The oper connection and its quotient identify the filtered bundle with
J^1(L^vee): on the filtration line the induced map is the second
fundamental isomorphism. Its extension class is c1(L^vee), whose trace
is -(g-1). Thus the bundle splits exactly when p divides g-1.
Projectivization with the chosen spin line gives the indigenous object;
scalar automorphisms do not introduce additional classes. The split
case is described as a theta-oper, not by Definition2.3's terminology.

For any actual dormant theta-oper, projection of horizontal sections
embeds its degree-zero descent W into F_*(L^vee): a kernel would pull
back to a horizontal subsheaf of the oper line, contradicting the
second fundamental isomorphism. If A is a line subbundle of W,
adjunction gives a nonzero map F^*A->L^vee, so
p deg A<=-(g-1)<0. This proves stability in both split and nonsplit cases.

Only the translation to the atlas bundle remains local. With
N=L tensor tau², N²=omega tensor tau and F_C^*N=L^5 tensor tau, so

    F_C^*(V tensor N^-1)=K_C^vee tensor L^-1 ~= mathcal F.

The last identification is the nonsplit extension in the
[Hermitian criterion](../atlases/hermitian_atlas_extension_criterion.md).
Because 5 does not divide deg L=g-1, its HN line cannot be horizontal;
the second fundamental map L -> L^vee tensor omega is an isomorphism.
Cartier descent and the cited Quot identification now give the required
bijection. The quotient mathcal F -> L^vee is unique up to scalar
(Hom(mathcal F,L^vee)=k), so forgetting it introduces no new bundle
classes. As throughout the atlas records, F_C is absolute Frobenius;
the source's relative formulation is the corresponding Frobenius base twist.
