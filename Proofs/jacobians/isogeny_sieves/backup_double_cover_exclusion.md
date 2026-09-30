# Complete actual Prym-factor exclusion for the backup

2026-09-11. Author /root. Fresh bounded assembly audit by
/root/audit_complete_degree2_sieve PASS. Exact computation.

## 1. The complete actual carrier reduction

Use [backup_degree_two_prym_reduction](../../../Theorems/jacobians/isogeny_sieves/backup_degree_two_prym_reduction.md).
Every connected etale double of X corresponds to a nonzero element of
JX[2]. The order-three trigonal automorphism groups these into F4-lines;
the actual A4 cover and its genus8 quotient identify the latter Jacobian
up to isogeny with the original double's Prym. No map from that genus8
quotient to B is asserted.

The binary Frobenius polynomial of X is irreducible of degree18, with
Frobenius25 of order171. Hence all262143nonzero labels are covered by
1533Frobenius/F4 orbits. For this GEOMETRIC ISOGENY-FACTOR question those
orbits suffice: relative Frobenius is an isogeny on both Jacobians.
This does not identify the Frobenius-conjugate source curves.

A retained nonzero actual two-torsion point over F_(5^342) has verified
doubling zero. Its first18Frobenius translates form a binary basis by
irreducibility. Exact cached Khuri--Makdisi operations construct each
listed label. The generator, coefficient field, basis rule,1533seeds and
all resulting divisor matrices are retained; no field-bounded random
search substitutes for the full label partition.

## 2. The complete three-stage sieve

For every carrier, the first stage constructs the actual trivialization
div(g)=2D-20O and the eight-dimensional space L(26O-D). It checks all
eight anti-Cartier images and retains their matrix and342-fold linear
norm. The theorem
[backup_prym_cartier_factor_sieve](../../../Theorems/jacobians/isogeny_sieves/backup_prym_cartier_factor_sieve.md)
excludes1408of1533carriers from these modulo5 polynomials. All1533
Cartier matrices have rank8.

Every one of the125remaining carriers admits the actual coprime
quadratic-Q norm chart. Its quartic-to-toric substitution is checked
exactly, its Newton polygon has eight interior points, and each of its
five actual boundary edges is transverse. There are no failed or
unsupported charts. The audited theorem
[backup_prym_toric_unit_root_sieve](../../../Theorems/jacobians/isogeny_sieves/backup_prym_toric_unit_root_sieve.md)
then identifies the projective Jacobian unit-root polynomial by

    U_s=beta_(5^s) sigma(beta_(5^(s-1)))^(-1) mod5^s,
    det(TI-U_s sigma(U_s)...sigma^341(U_s)).

Both beta matrices are computed at the NEW precision. True Witt
Frobenius is used. The verified quadratic character of the norm-recovery
rescaling relates the toric polynomial to the original Prym:66of these
125models require sign−1,59require sign+1.

All nine cyclotomic orders1,2,3,4,5,6,8,10,12, with their full monic
factors and multiplicities, are tested. The entire factor family is
invariant under the quadratic twist. Passing a lower congruence is
never interpreted as either existence or exclusion.

The modulo25stage excludes114more. The remaining indices

    74,108,176,754,794,809,918,925,1184,1254,1427

all fail every applicable factor modulo125. Thus the disjoint partition
of the COMPLETE set is1408+114+11=1533. No modulo625 calculation or
higher-precision extrapolation is needed.

## 3. Exact certificate provenance and replay

Data root: /Users/julian/Documents/litt3-computation-data.

The complete manifest is degree2-prym-coverage-complete-20260911.json.
It records all1533labels, every stage link, all5382artifact hashes and
all nine-order monic remainder tests. The first output ranges are
degree2-prym-sieve-full-0-511-20260911, -511-1022-20260911 and
-1022-1533-20260911. Higher outputs are
degree2-prym-higher-stage-20260911 and
degree2-prym-final-stage-20260911. Exact matrices, models and norm
functions remain available at the paths recorded by the manifest.

Labels SHA256:
37ea5af38067dc2c66bc128b0f078a1b5fd1cb6abe7927ee9e621f2ee1419830.
Initial actual two-torsion SHA256:
3a39cdf2afb3c7e1df3dfec8b2e5482ad57c8baf38b4048e47464cbf1673e6e6.

[The standard-library coverage verifier](../../../scripts/arithmetic/verify_prym_sieve_coverage.py)
independently constructs the root digits by exhaustive five-way lifting
and performs all polynomial divisions. It reports
coverage_and_division_PASS,1533excluded, no open indices. The fresh audit
independently checks the entire binary label partition, all5382hashes,
the source/model links, every higher-precision link, the66/59twist split,
and all remainders. Its verdict is PASS,2026-09-11.

Implementation cross-checks include independent direct expansion of all
64beta25entries on a small actual genus8 curve and agreement with its
projective point counts overF5,F25,F125. The higher ghost recursion has
350independent multinomial coefficient checks through precision4 and
exponent624. All192beta25/beta125/unit-matrix entries at actual carrier74
agree between full-precision and precision-aware product implementations.

The independent saved-Cartier replay regenerated every normal space
for all1533carriers, checked all eight anti-Cartier equations and
independently iterated the342-fold norm, with no failed case.
All hash-linked receipts remain in degree2-prym-cartier-replay-20260911.

## 4. Return to the original two maps

If W→X were a connected etale double and W→B an etale degree16map,
pullback would put J(B) into J(W) up to isogeny. The double-cover
decomposition J(W)~J(X)×Prym(W/X), together with Hom(JX,JB)=0 and
absolute simplicity of J(B), forces it into that actual Prym. Section2
excludes every such Prym.

For the six-point atlas, base-changing B's hyperelliptic map supplies
these SAME-source maps, by backup_degree_two_prym_reduction. If the
double splits, a component gives X→B, already excluded by Hom=0.
Therefore the degree2 atlas is impossible. No simultaneous Galois
closure, presumed source ordinariness, or invented second map is used.

## 5. The maximal elementary-abelian two-cover

The geometric mod-two abelianization supplies the connected cover
\(X_{[2]}\to X\) with group \(A=(\mathbf Z/2)^{18}\). The nontrivial
characters of \(A\) label all \(2^{18}-1\) connected étale doubles
\(X_\chi\to X\). Rational character idempotents, equivalently the
pullback and norm maps, give an isogeny
\[
J(X_{[2]})\sim J(X)\times
\prod_{\chi\ne1}\operatorname{Prym}(X_\chi/X).
\]
The dimensions agree: \(9+(2^{18}-1)8=1+8\cdot2^{18}\), the genus
from étale Riemann--Hurwitz. Sections 1--3 exclude a geometric
\(J(B)\) factor from every Prym, and the established absolute
simplicity of \(J(X)\) and \(J(B)\), of dimensions nine and two
([fixed-pair arithmetic](../../curve_arithmetic/fixed_pair_arithmetic.md),
[backup arithmetic](../../curve_arithmetic/backup_curve_arithmetic.md)),
excludes \(\operatorname{Hom}(J(B),J(X))\). Thus the displayed
decomposition proves
\(\operatorname{Hom}(J(B),J(X_{[2]}))=0\).

Any nonconstant map \(U\to B\) between smooth proper curves gives
nonzero pullback \(J(B)\to J(U)\), because norm after pullback is
multiplication by its positive degree. This remains true for an
inseparable map. Such a map from an intermediate cover of
\(X_{[2]}\to X\) would compose to a map from \(X_{[2]}\), which is
impossible. Likewise an actual common span whose \(X\)-leg has
elementary-abelian two-group Galois closure would pull its \(B\)-map
back to an intermediate cover of \(X_{[2]}\). Finally every Prym in
the displayed product is ordinary by the exact Cartier rank test in
Section 2. The \(J(X)\) factor retains its nonordinary contribution
by the [fixed-X Cartier theorem](../../cartier_and_spin/cartier_petri_excess_one.md);
no ordinarity of the entire cover is claimed.
