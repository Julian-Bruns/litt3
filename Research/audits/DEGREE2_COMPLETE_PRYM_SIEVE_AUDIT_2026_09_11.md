# Complete degree-two Prym sieve: final-assembly audit

Verdict: **PASS** for the complete carrier coverage, source linkage,
geometric-factor implication, and the resulting degree-two exclusion.
Auditor: `/root/audit_complete_degree2_sieve`. Date: 2026-09-11.
This is a bounded computational/prose audit, not Lean verification.

The audit concerns
[DEGREE2_COMPLETE_PRYM_SIEVE.md](../DEGREE2_COMPLETE_PRYM_SIEVE.md).
It does not assert that the original common-cover problem is solved.
The full independent replay of all saved Cartier matrices is running
separately at the time of this audit; only its completed 15-carrier sample
has been reported. Nothing below labels that full replay complete.

## Exact conclusion and inherited facts

For the fixed genus-nine cyclic trigonal curve X, every nontrivial
geometric two-torsion label has a Prym with no geometric isogeny factor
J(C_alpha), where alpha^3+alpha+1=0. Therefore a common connected finite
etale source W with degrees 2 over X and 16 over C_alpha cannot exist.
The associated degree-two atlas row is excluded. Degree84 and the
remaining coreless common-cover problem are not addressed by this result.

The audit accepts the existing scoped PASS results for
`backup_degree_two_prym_reduction`, `cyclic_trigonal_kummer_carriers`,
`backup_prym_cartier_factor_sieve`, and
`backup_prym_toric_unit_root_sieve`. Their actual-cover, Cartier/Dwork,
and CM-factor arguments are not reproved here. The new point is the
assembly of their hypotheses across the complete finite computation.

If such W existed, pullback would inject J(C_alpha) into J(W) up to
finite kernel. The double-cover isogeny decomposition and the established
Hom(JX,J(C_alpha))=0 place that factor in the Prym of W/X. Thus a
necessary Jacobian-factor obstruction is being applied to the original
two-leg diagram. It is not being substituted for the existence of a
second map. The split atlas double is already excluded by the same Hom
vanishing, as recorded in the canonical reduction.

## Label coverage and actual Jacobian labels

I independently replayed the binary-polynomial arithmetic by polynomial
long division and binary powering. The degree18 polynomial is irreducible:
T^(2^18)=T, and the required gcd tests at 2^9 and 2^6 give 1. Its root
has exact order171: T^171=1, T^57!=1 and T^9!=1. Multiplication by
T^57 is a nontrivial cube root of unity. Starting from the retained
1533 seeds and iterating T gives a disjoint partition of all262143
nonzero binary labels; each seed is its orbit minimum.

The retained initial point is an actual nonzero point of JX[2] over
F_(5^342), with doubling zero checked by exact Jacobian arithmetic.
Irreducibility makes its first18 Frobenius25 translates a basis. The
producer represents a seed by the sum of the translates at its nonzero
bits. It caches sums of the low and high bytes and combines them by
addflip. Addflip negates a sum, which is the same sum on two-torsion;
there is no unrecorded sign in this conversion. The maximum seed is19879,
so the two-byte preparation in the completed run covers every seed.
The cache is keyed to the SHA256 of the retained initial torsion file.
The arithmetic model uses the actual pole-semigroup spaces and the fixed
polynomial of X, with Frobenius25 acting coefficientwise.

This label construction is replayable from the retained initial point,
field modulus, ordered Frobenius basis rule, seeds, and exact Jacobian
operations. An algebraic relation between the labels and the source
matrices has not been replaced by a coefficient-field search. The separate
Cartier-witness replay correctly states that label generation is a
different prerequisite; it does not itself claim to re-enumerate labels.

The reduction from262143 doubles to1533 tests is valid for this task.
The three nonzero elements of each F4-line have isomorphic Pryms under
the trigonal automorphism. Frobenius25 conjugation preserves the
*geometric isogeny-factor* condition: relative Frobenius gives geometric
isogenies of both the carrier Jacobian and the backup Jacobian. This
does not identify conjugate source curves or replace a finite etale map
by Frobenius. The larger4599 count is needed for an actual-map or
source-isomorphism comparison, not for this necessary factor sieve.

## Independent complete receipt replay

The audited receipt is

    /Users/julian/Documents/litt3-computation-data/degree2-prym-coverage-complete-20260911.json

I performed a fresh read-only replay, independently of the producer and
without invoking its factor-sieve function. It checked all5382 distinct
retained artifact hashes, the ordered1533 labels, all recorded factor
polynomials and all monic integral remainders. The counts are exactly

    1408 excluded modulo5
     114 excluded modulo25
      11 excluded modulo125
    1533 excluded in total; no open index.

The eleven final indices are

    74,108,176,754,794,809,918,925,1184,1254,1427.

The labels SHA256 is
37ea5af38067dc2c66bc128b0f078a1b5fd1cb6abe7927ee9e621f2ee1419830.
The initial torsion SHA256 is
3a39cdf2afb3c7e1df3dfec8b2e5482ad57c8baf38b4048e47464cbf1673e6e6.

The three first-pass selection files cover the disjoint ranges0:511,
511:1022,1022:1533 and bind the seed list and original torsion source.
Every first-pass result has rank8 and retains its actual divisor-space
matrix, trivialization, anti-form basis, Cartier matrix and linear norm.
There is no inferred result for a missing first-pass carrier.

## Actual-model and precision handoff

I checked the source paths, field moduli, model hashes, complete status,
prior-precision congruences and recorded dimensions for every one of the
125 higher-stage cases. All have Q of degree2; P has degree5 or6.
The model producer explicitly requires gcd(P,Q)=1 and squarefree Q,
checks the norm equation and every quotient in the birational change,
and retains the resulting actual model. All125 model records have the
expected eight interior lattice points and five transverse edges.
There is no unsupported Q1/noncoprime chart or failed case hidden among
the excluded higher-stage carriers. The first-pass enumeration itself
is chart-independent, so no other chart was omitted from coverage.

The norm recovery may introduce a nonsquare rescaling. The unit-root
producer checks the actual function identity

    (P+Qy)*g = scalar*v^2

against the saved double's trivialization. The quadratic characters are
59 positive and66 negative among the125 higher cases. The modulo5
toric polynomial is checked against the saved Prym polynomial with
precisely that sign. A scalar square-class change is therefore not
silently treated as an equality of finite-field Pryms.

Every final computation retains beta25 and beta125 **both at precision
125**, and then the unit-root matrix. All three saved matrices have64
entries and the same dimension8 and coefficient-field modulus. The
first final carrier's earlier result is reused only with the identical
model hash and previous-precision congruence. This is not a two-digit
beta25 matrix used where three digits are required.

I inspected the higher ghost recursion and its precision-aware product
reduction. Its expansion is the exact binomial identity for
f^5=sigma(f)(x^5)+5G; a term carrying5^j needs its product only modulo
5^(s-j). Coefficient Frobenius remains the actual Witt Frobenius. The
truncated coefficient lifts do not require Teichmuller representatives,
and no interpolation or floating arithmetic occurs. The existing
independent direct and multinomial checks, and the full192-entry
comparison on carrier74, remain separate evidence for this engine.

## Completeness of twists and divisors

The inherited CM/isotypic theorem allows exactly the nine orders
1,2,3,4,5,6,8,10,12 before deduplication, with all multiplicities.
I verified that every receipt stage includes all nine. My independent
replay used the unit roots reducing to1,2, with their recorded digits
(1,7) modulo25 and (51,82) modulo125; direct substitution in the
backup Weil polynomial checks each root. Their114th powers construct
the monic cyclotomic divisors without adjoining roots of unity.

The orders5 and10 are retained as full degree8 divisors. In particular,
the sixth modulo25 filter is not replaced by T^2-1 or by its radical.
All divisions are by monic polynomials, so the remainder test is valid
over Z/25 and Z/125 despite their zero divisors.

I also checked the entire twist family at all three precisions:
T->-T interchanges1/2,3/6,5/10 and fixes4,8,12. Thus the verified
quadratic rescalings cannot create an omitted geometric-factor case.
Passing a congruence is treated only as inconclusive; every such case
has its next stage until all orders fail.

## Evidence boundary

The complete source-hash, coverage and division replay above is done.
This audit did not recompute all1533 Cartier matrices or all125 toric
unit-root matrices. The former's independent full replay is currently
running; the latter has the retained exact production checks and focused
independent engine audits described above. Do not relabel a sample as
a completed full replay. No source-linkage, missing-chart, twist-order,
or geometric-scope objection remains in the final assembly.
