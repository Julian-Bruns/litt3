# Proof: exact mass, actual intermediate maps, and Frobenius conjugation

[Statement](../../Theorems/orbifolds/triangle238_frobenius_factor_obstruction.md).
Pro supplied the proof and source on2026-09-09. /root read every executable,
regenerated all77 tables, compared them byte-for-byte with the supplied
list, and replayed both exact mass calculations and every obstruction.
The integrated verifier is read-only unless --export-witnesses is given.

## 1. Completeness does not depend on the enumerator

A proposed tame map supplies a transitive permutation pair a,b on48
letters, with complete types2^24,3^16,(ba):8^6. The source-checked
[one-cover tame-specialization input](triangle344_frobenius_obstruction.md#1-complete-finite-census-and-its-characteristic-five-use)
injects actual characteristic-five cover classes into these labeled
complex permutation classes, preserving the action, centralizer and
block systems. Whole monodromy groups may have order divisible by5.
This is NOT a simultaneous lift of two etale maps.

The [list](../../Research/computations/triangle238_tables.jsonl) has77 pairs.
[The verifier](../../scripts/orbifolds/triangle238_certificate/verify48.py) checks every
cycle, transitivity and inequivalence: the canonical code is the least
of48 rooted breadth-first codes, with generator labels fixed. It also
computes the entire centralizer by trying every image of one letter.
The centralizer distribution, for orders1,2,4,6,8,12,48 respectively, is

                             2,41,24,6,1,2,1.

Their total reciprocal-centralizer weight is477/16.

Every pair with this passport is automatically transitive. Every orbit
has size divisible by24. A putative orbit of size24 would have a even
(twelve transpositions) and b even (eight3-cycles), but ba odd (three
8-cycles). Thus a disconnected pair of this passport is impossible.

The Frobenius class-product formula counts all labeled triples with
product one; dividing by48! counts classes with reciprocal-centralizer
weights. With z_e=e^(48/e)(48/e)! and H_lambda the hook product, it gives

  mass = sum_(lambda partition48)
         H_lambda chi_lambda(2^24)chi_lambda(3^16)chi_lambda(8^6)
         / (z_2 z_3 z_8).                                  (1)

This is [Jones--Zvonkin, Theorem2.1 and Section2.2](https://arxiv.org/pdf/2012.07107),
combined with the hook-length degree formula; the transitivity issue
they warn about was resolved above, not ignored.
[characters48.py](../../scripts/orbifolds/triangle238_certificate/characters48.py)
evaluates(1) over all147,273 partitions, with exact integer/rational
arithmetic, by BOTH direct Murnaghan--Nakayama rim-hook recursion and
the independent e-quotient/abacus formula. Both give477/16. The rules
also agree in763 small checks; these checks supplement, not replace,
the exact degree48 calculations.

Every omitted class would have strictly positive weight. Validity,
inequivalence and equality to the full mass therefore prove that the
77 listed classes are complete, without assuming the pruning is correct.
The [C++ generator](../../scripts/orbifolds/triangle238_certificate/enumerate48.cpp)
separately regenerates the same list in84,844 nodes,0.126s locally.

## 2. The disjoint obstruction partition

The checker applies the following tests in order:

| Obstruction | Classes |
|---|---:|
| Centralizer larger than2 |34|
| Deck involution fixes exactly2 source points |20|
| Intermediate degree24(3,3,4) map |10|
| Intermediate degree12(2,2,2,3) map |9|
| Intermediate degree16(2,4,8) map |2|
| Remaining primitive classes, trivial centralizer |2|

The first34 contradict Aut(C)=C2. The next20 also contradict it: the
only involution of a genus-two curve with that automorphism group is
hyperelliptic and fixes6 points. Equivalently the computed involution
would give an elliptic double quotient. Thus no separate Jacobian
assumption is needed for these54 exclusions.

To count its fixed points, the verifier counts inertia cycles preserved
setwise by the commuting permutation. These are precisely the branch
fiber points it fixes; there are no fixed points in an unramified fiber.
The order-two centralizers have either2 or6 such fixed points.

For an invariant partition into m blocks of size d, the ACTUAL cover
factors C->B->P1 with degrees d,m. The induced permutations determine
g(B) by Riemann--Hurwitz. If an inertia generator of order e has a
block-cycle of length ell, then every source point over that B-point
has ramification index e/ell for C->B: indices multiply, and ALL source
cycles originally had length e. There is no other ramification.

The stored/optionally regenerated witnesses for21 classes give genus-zero
B and exactly the three profiles in the table. The verifier checks
invariance directly, not just abstract existence of a triangle subgroup.
Its exhaustive partition construction successively joins the block of0
with another block and takes invariant closure. Any desired block system
is reached by adjoining its block-of0 elements, so none is missed.
For exclusion, even a single checked partition suffices.

## 3. Frobenius finishes the argument

Suppose C has none of the three asserted intermediate maps. These
nonexistence properties, as well as Aut(C)=C2, are preserved by every
constant-field automorphism. Therefore f and all its coefficientwise
Frobenius conjugates must belong to the two remaining cover classes.
But the first three source curves are geometrically nonisomorphic by
the moduli-orbit hypothesis, giving at least three distinct cover classes.
Contradiction. This is conjugation of coefficients, not composition with
an inseparable Frobenius morphism.

For C_alpha the three intermediate exclusions follow respectively from
[the Hermitian quotient identity](hermitian_monodromy_genus_sieve.md)
and [completed backup atlas exclusion](../genus_two/backup_hermitian_atlas_exclusion.md),
[the quadrangular Hecke theorem](../genus_two/quadrangular_genus_two_hecke_obstruction.md),
and [the radical quadratic theorem](../atlases/radical_quadratic_atlas_obstruction.md).
All use the same source C_alpha. No new dormant-bundle computation,
lifting of a common span, or assumption on coefficients of f is needed.

## Reproduction and provenance

```sh
python3 scripts/orbifolds/triangle238_certificate/verify48.py
```

This checks the saved list, all exclusions, and both independent
completeness counts. The [receipt](../../Research/computations/triangle238_verification.txt)
is from the local replay, not just Pro's transcript. Regeneration:

```sh
c++ -O3 -std=c++17 scripts/orbifolds/triangle238_certificate/enumerate48.cpp -o /tmp/triangle238
/tmp/triangle238 /tmp/triangle238_tables.jsonl
cmp Research/computations/triangle238_tables.jsonl /tmp/triangle238_tables.jsonl
python3 scripts/orbifolds/triangle238_certificate/verify48.py /tmp/triangle238_tables.jsonl
```

All individual witnesses are reconstructed by the verifier. Add
--export-witnesses /tmp/triangle238_witnesses.json to retain them; a
duplicated127KB report is not required in the library. The source ZIP
has SHA2561251f60ca971f91dcfb6954feb45a55655c6df01b8ad80869c9423d1f384255c.
Only CLI paths and optional report output differ from the shipped
verifier; the census and character mathematics are unchanged.
