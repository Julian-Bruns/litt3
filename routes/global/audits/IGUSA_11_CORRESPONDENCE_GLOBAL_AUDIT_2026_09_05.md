# Igusa 11-correspondence: independent global audit

Date: 2026-09-05. Auditor: Codex, independent subagent `/root/igusa_global_geometry_audit`.

Scope: global geometry, genus, and corelessness of the proposed characteristic-5 construction. This audit uses the construction summary supplied by the parent; it does not audit the separate Tango differential calculation or claim to have inspected the complete Pro response.

Verdict: **the global construction and corelessness argument pass**, with the proof details below made explicit. No global obstruction was found. The main points requiring care are geometric-generic endomorphisms, finite-index monodromy after descent, and level transport along reversed edges.

## Primary inputs actually checked

[Buzzard, Integral models of certain Shimura curves](https://www.ma.imperial.ac.uk/~buzzard/maths/research/papers/shimura.pdf), printed pp. 4–7, 16–19:

- Conditions (i)–(iii): determinant image is all of the finite integral ideles; maximal level at discriminant primes; containment in V1(N), N at least 4 and prime to the discriminant.
- Theorem 2.1, Corollary 2.3, Propositions 2.4–2.5 give smooth proper relative curves, scheme/projective representability, geometrically irreducible fibers, and étale forgetful maps.
- Definition 4.8, Proposition 4.9 and the following discussion give the global Drinfeld-generator Igusa scheme: finite, flat, regular, irreducible, étale over ordinary points, totally ramified over supersingular points. Section 5 specifies degree p−1. Proposition 5.1 gives the supersingular count s=(p−1)(g(C)−1).

[Voight's primary tables](https://jvoight.github.io/shim-tables/shimbound-tables.pdf), Table 4.1, give signature (0;2,2,3,3) for discriminant 6, level 1.

The rest of this audit consists of deductions and explicit checks for the proposed parameters, rather than additional claims attributed to these sources.

## Level and global checks

Set d=6, p=5, and U=V1(7). The subgroups U, U intersect V0(11), and U intersect V1(11^m) satisfy all three conditions. At 7 and 11, diagonal matrices with entries (u,1) supply arbitrary determinant; the local conditions occur at different primes and introduce no determinant relation. At 2 and 3 the groups remain maximal. Every group lies in V1(7), and 5 divides none of its level or discriminant denominators.

Consequently C and H are smooth projective geometrically connected curves over k=Fbar5. The source map a:H→C is finite étale of degree 12: its geometric fiber is the set of lines of a two-dimensional F11-space. The target map b is obtained by quotienting the O_D-stable subgroup corresponding under Morita equivalence to such a line, transporting level 7. It is also finite étale of degree 12. One direct justification is the dual-isogeny automorphism of H; its square is the invertible diamond operation multiplying level 7 by 11. Thus b is a composed source map and an automorphism, with a possible invertible diamond factor depending on conventions.

The Igusa curve I is the whole Drinfeld-generator scheme, including its supersingular points, not just the ordinary torsor. Finiteness follows also because the generator scheme is closed in the finite group scheme ker(V) on the chosen height-two factor. A finite cover of projective C is projective; regularity over the perfect field k gives smoothness. Its generic degree is 4, and its supersingular ramification index is 4.

The universal 11-isogeny is an isomorphism of 5-divisible groups, commuting with O_D, Frobenius and Verschiebung. Its Frobenius twist therefore transports the chosen generators of ker(V) over arbitrary characteristic-5 bases, including nonreduced bases. Its inverse on 5-divisible groups is 11^{-1} times the dual. This proves an isomorphism of the two entire Igusa pullbacks, not merely of their ordinary restrictions:

    Z = H ×_(a,C) I ≅ H ×_(b,C) I.

Both maps Z→I are consequently finite étale of degree 12. Z is connected: choose a supersingular point h of H. Its fiber under Z→H has just one geometric point. Since Z is smooth and finite flat over connected H, every connected component dominates H; hence there can be only one. This also verifies that the fiber products used in the function-field argument below are fields rather than products.

## Genus arithmetic

The norm-one group at level 7 has index 48 before passing to the effective projective action, and index 24 afterwards: |SL2(F7)|=336, and the unipotent subgroup has order 7. The level-7 group is torsion-free. The level-1 orbifold has negative Euler characteristic

    −2 + 2(1−1/2) + 2(1−1/3) = 1/3.

Thus 2g(C)−2=24/3=8, so g(C)=5. Smooth proper reduction preserves this genus. Here s=4·4=16. Tame Riemann–Hurwitz gives

    2g(I)−2 = 4·8 + 16·3 = 80,
    2g(H)−2 = 12·8 = 96,
    2g(Z)−2 = 12·80 = 960.

Therefore g(I)=41, g(H)=49, and g(Z)=481, as claimed for I and Z.

## Generic endomorphisms: the monodromy proof completed

Let A be the universal false elliptic curve at a geometric generic point of C, and let T be its rank-two Morita 11-adic Tate module. Connectedness of the covers with extra V1(11^m)-level implies transitivity of geometric monodromy on primitive vectors modulo 11^m. Since level 7 has already killed automorphisms, there is no extra division by ±1 in these fibers. Hence the image G_m has size at least

    (11²−1)·11^(2m−2).

The polarization induces a preserved nondegenerate alternating form on the Morita module, so this geometric monodromy lies in SL2(Z11). Suppose a nonscalar O_D-linear geometric-generic endomorphism exists. It descends to a finite extension of k(C). Passing to its separable part changes the monodromy group by finite index at most some constant d, independent of m; a purely inseparable part does not change its étale monodromy. Thus the descended subgroup still has size at least |G_m|/d.

The endomorphism acts as a fixed nonscalar matrix on T. Its centralizer in SL2(Z11), reduced modulo 11^m, has size O(11^m). For completeness, subtract a scalar and divide by the largest common power of 11 so its reduction is nonscalar. Its matrix centralizer is a rank-two quadratic algebra; the determinant-one condition has one-dimensional unit group. As 11 is odd, its norm-one fibers are smooth (the trace of the identity is 2), giving the asserted growth, with a constant allowing for the initial division by a power of 11. This contradicts the quadratic exponential lower bound.

A scalar Tate action also forces a rational scalar endomorphism: its degree-four characteristic polynomial has rational coefficients, so its trace gives 4λ rational; faithfulness then identifies the endomorphism with that rational scalar. An integral endomorphism which is a rational scalar is an integer. Accordingly End_O_D(A)=Z.

This argument must be made at the **geometric generic point**. Closed ordinary points over Fbar5 have extra endomorphisms; applying the conclusion to all closed points would be false.

## Distinct targets and absence of a core

There are 12·11^(n−1) cyclic order-11^n subgroups on the Morita factor. Their O_D-stable counterparts give isogenies of false degree 11^n (actual degree 11^(2n)). If two quotient targets were O_D-isomorphic, compose the first quotient map, that isomorphism, and the dual of the second. This is an O_D-endomorphism of A of false degree 11^(2n), and hence scalar ±11^n. Cancellation in the rational Hom space then shows that the two quotient maps differ by that isomorphism and a sign, so their kernels coincide. Distinct kernels therefore give distinct underlying targets at every fixed n.

Use even n to produce unbounded sets of vertices on one side of the bipartite correspondence graph. Every cyclic chain can be read as alternating edges. On a reversed edge, transport level 7 by the inverse of the isogeny on 7-torsion, equivalently by 11^{-1} times the dual. Ignoring this scalar would introduce a diamond operation; accounting for it gives actual alternating graph paths. Underlying quotient targets remain distinct regardless of these level labels.

If a nonconstant common function existed, it could be written u(a(h))=v(b(h)) with u,v rational functions on the two copies of C. Its value would stay fixed on each graph component. The generic component would then lie in finite fibers of u and v, contradicting the unbounded collection just constructed. This proves a*k(C) intersect b*k(C)=k inside k(H).

## The Cartesian Igusa lift preserves this conclusion

Write B=k(H), L=k(Z), and E_i for the two images of k(I) in L; let A_i be the corresponding images of k(C) in B. Both full Cartesian squares give L=B tensor_(A_i) E_i, a field of degree 4 over B.

If z belongs to E_1 intersect E_2, form the characteristic polynomial of multiplication by z on the four-dimensional B-vector space L. Base change shows that its coefficients belong to A_1 and also to A_2. They therefore lie in k. The monic polynomial makes z algebraic over k, and k is algebraically closed, so z belongs to k. Consequently f*k(I) intersect g*k(I)=k.

This uses both full Cartesian identities and connectedness. It is not a general assertion that choosing an arbitrary component of arbitrary simultaneous finite covers preserves corelessness.

## Remaining boundary

This audit does not verify the exact differential, its Cartier vanishing, the Tango line and its compatibility under the two maps, or any stronger nonweakness condition in the original problem. Those require the separate local/differential audit. On the global geometry and no-core claims examined here, the listed clarifications complete the proposed argument rather than reveal a counterexample to it.
