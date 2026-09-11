# Complete degree-two Prym sieve — final audit target

2026-09-11,06:43 CEST. Computation COMPLETE; final assembly audit PASS.
Canonical result: backup_degree_two_atlas_exclusion. This note retains
the implementation handoff; the exact theorem and proof are canonical.
The original unmarked common-cover problem remains UNSOLVED.

## Audited consequence

For every nontrivial geometric two-torsion line L on the fixed genus-nine
cyclic trigonal X, the actual Prym of its connected etale double has no
geometric isogeny factor J(C_alpha), alpha^3+alpha+1=0.

Consequently there is no common finite etale source W with deg(W/X)=2
and deg(W/C_alpha)=16. In particular, X has no actual degree16 orbifold
map to the SAME six-point P1(2,2,2,2,2,2) of C_alpha's hyperelliptic map.
This removes the backup's degree2 atlas row, not all common covers.

## Exact finite coverage

The audited backup_degree_two_prym_reduction supplies the actual A4
carrier and Prym identification, including the SAME source's original
two legs. Its geometric-factor condition is constant on Frobenius25
orbits of F4-lines in JX[2]. There are1533 such orbits, covering all
262143nonzero double labels. This is a factor test, not a claim that
Frobenius-conjugate curves are geometrically isomorphic.

The nonzero actual two-torsion point is in F_(5^342), with verified
doubling zero. Irreducibility of the degree18 binary Frobenius polynomial
makes its first18Frobenius translates a basis. Cached exact Jacobian
arithmetic constructs each of the1533 chosen labels. No coefficient-field
search replaces this enumeration.

The FULL first pass checks all1533 actual anti-Cartier matrices, all of
rank8. Every trivialization, eight-dimensional anti-form basis, matrix,
and342-fold linear norm is retained. The audited geometric factor sieve
excludes1408 carriers modulo5. The125 survivors are all processed by
the actual norm/quartic/toric construction; every one satisfies the
coprime quadratic-Q chart and has all toric edges transverse. There is
no unsupported or failed chart. The higher all-twist factor sieve
excludes114 more modulo25.

The remaining indices are

    74,108,176,754,794,809,918,925,1184,1254,1427.

Every one is excluded modulo125. None requires modulo625. Thus

    1408 + 114 + 11 = 1533.

All ordinary geometric twists and multiplicities are covered by the nine
orders1,2,3,4,5,6,8,10,12 in backup_prym_toric_unit_root_sieve.
Norm-recovery rescaling retains its verified quadratic character. The
entire filter family is invariant under this twist.

## Reproduction and receipts

External data root:

    /Users/julian/Documents/litt3-computation-data

Coverage receipt degree2-prym-coverage-complete-20260911.json records every
source hash, all three stage links, all integral divisor remainders and
all1533exclusion verdicts. scripts/verify_prym_sieve_coverage.py is a
standard-library independent division implementation: it constructs the
two root digits by exhaustive five-way lifting, independently of the
producer's Newton carry formula. It returns coverage_and_division_PASS,
with no open indices. It does not pretend to recompute matrix entries.

The labels file has SHA256
37ea5af38067dc2c66bc128b0f078a1b5fd1cb6abe7927ee9e621f2ee1419830.
The actual initial torsion file has SHA256
3a39cdf2afb3c7e1df3dfec8b2e5482ad57c8baf38b4048e47464cbf1673e6e6.

All carrier outputs are in degree2-prym-sieve-full-LO-HI-20260911,
with disjoint ranges0:511,511:1022,1022:1533. Higher outputs are in
degree2-prym-higher-stage-20260911 and final outputs in
degree2-prym-final-stage-20260911. Source matrices and models are linked
explicitly in the complete receipt; the first final carrier reuses its
earlier independently matched model-hash result, also linked there.

The higher-precision engine computes beta25 AND beta125 modulo125 before
forming U=beta125*sigma(beta25)^(-1). It uses true Witt Frobenius, not
coefficient fifth powers. All192matrix entries on carrier74 agree with
an independent full-precision-products run. Precision-aware arithmetic
takes54s instead of201s on that actual carrier. Independent small-field
multinomial checks cover350coefficients through precision4 and exponent624.
The separate actual genus8 audit checks all64beta25 entries by direct
expansion and projective point counts overF5,F25,F125.

scripts/replay_prym_cartier_witnesses.py additionally regenerates the
actual normal spaces and verifies every anti-Cartier equation, with an
independent iterative binary norm. Its stratified15carrier timing test
passed15/15, mean2.149s/carrier. The full1533replay is now running in two
disjoint ranges. It remains pending until every receipt is complete.

## Inherited prerequisites and exact logical endpoint

The geometric reduction is backup_degree_two_prym_reduction; actual
norm carriers are cyclic_trigonal_kummer_carriers; Cartier comparison
and the geometric all-twist filters are backup_prym_cartier_factor_sieve
and backup_prym_toric_unit_root_sieve. All have scoped PASS audits.

If an actual W in the proposed conclusion existed, its pullback of J(B)
would lie in J(W). Hom(JX,JB)=0 and the double-cover decomposition force
that factor into its Prym. The complete computation excludes that Prym.
This is a necessary obstruction to the actual two-leg diagram, never
a replacement of either leg by an arbitrary Jacobian factor.

The remaining degree84 atlas and the original coreless common-cover
obstructions are unaffected. The main pair has not been replaced.
