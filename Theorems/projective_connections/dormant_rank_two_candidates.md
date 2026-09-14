# Dormant indigenous bundles and rank-two atlas candidates

For every odd prime p and genus g>=2, the moduli morphism
M^Zzz..._(g,F_p) -> M_(g,F_p) of dormant indigenous bundles is finite,
faithfully flat and generically etale, of degree

    d_g(p)=p^(g-1)/2^(2g-1) sum_(j=1)^(p-1) sin(pi*j/p)^(-2g+2).

For a smooth projective connected C of genus g over an algebraically
closed field of characteristic p, fix a spin structure L^2=omega_C.
The fiber over C is represented, after fixing L, by trace-free dormant
theta-opers on the extension 0 -> L -> mathcal F -> L^vee -> 0.
Its underlying filtered bundle is J^1(L^vee), nonsplit precisely when
p does not divide g-1. Every curve has a finite nonempty scheme of such
objects of length d_g(p); only a reduced fiber has d_g(p) distinct points.

Its Cartier descent W is stable. More precisely, every line subbundle
A of W satisfies p deg A<=-(g-1), by the scalar inclusion
W->F_*(L^vee). This holds for every g>=2, including p dividing g-1.

Let C/k have genus g>=2 in characteristic five, with 5 not dividing g-1.
Put K=K_C and M=omega_C^2 tensor tau, where tau^3=O_C. There are finitely
many, and at least one, bundle classes V satisfying

    det V=omega_C tensor tau,       F_C^*V ~= K^vee tensor M.

These classes correspond to the preceding fiber via
W=V tensor (L tensor tau^2)^-1 and F_C^*W ~= mathcal F.
Fixing L introduces no factor 2^(2g). Isomorphism and marking choices
are not claimed finite.

The candidate scheme has length

    S_(g-1)=((5+sqrt(5))/2)^(g-1)+((5-sqrt(5))/2)^(g-1),
    S_0=2, S_1=5, S_n=5S_(n-1)-5S_(n-2).

In genus nine its length is 29375 for EACH fixed tau. The number of
distinct classes may be smaller: special fibers need not be reduced.

This condition exists on EVERY C and therefore cannot exclude an atlas.
The additional compatible rank-three lift remains necessary.

Version 3, 2026-09-14.
[Published sources and the atlas normalization](../../Proofs/projective_connections/dormant_rank_two_candidates.md).
