# Degree84 — complete census, primitive cases excluded,42 sources remain

Received and replayed2026-09-09. This certifies the finite permutation
census, NOT by itself a curve-specific exclusion. A new audited
dormant-decoration argument on2026-09-10 excludes its THREE primitive
survivors. The degree84 row remains open with42 hyperelliptic classes.

The archive's checksums passed before execution. Its native generator
visited522,737 nodes and reproduced every one of the155 supplied tables
byte-for-byte in0.83531s. The character program independently summed over
all26,543,660 partitions of84 and returned mass64 in3.8627s. The verifier
then checked the regenerated list AGAINST THIS LOCAL mass output, including
inequivalence, centralizers, all exclusion witnesses, all42 quotient
tables and the three primitive matrix-group witnesses, in1.314891s.
Total algorithm time about6.013s, SINGLE core, excluding compilation.

Centralizer distribution: {1:6,2:90,4:44,6:9,12:6}; reciprocal mass64.
Disjoint exclusions:59 larger-deck,30 elliptic-deck,3 elliptic-intermediate,
18 forbidden-degree12 classes. Survivors:42 hyperelliptic-factor and
3 primitive classes46,55,90, with verified group PSL2(F83), order285852.
The full mass algorithm is abacus/quotient based. Its independent direct
Murnaghan–Nakayama cross-check covers3953 SMALL partitions, not a second
full mass calculation. Do not claim the latter.

The new [dormant-decoration theorem](../Theorems/Thm_triangle237_dormant_orbit_obstruction.md)
improves the required orbit from3 to15: the canonical dormant connection
of an actual(2,3,7) map lands in the backup's five-cycle of dormant opers.
Its automorphisms fix those points. The three primitive survivors are
therefore excluded, without identifying their characteristic-five sources.
The new geometric argument has a fresh audit PASS; the inherited census
and earlier exclusions have their original verification status.
All42 hyperelliptic survivors have the same monodromy order, so that
additional bucket test gives no exclusion. Their source comparison is open.

## Reproduction / provenance

Archive attachment:
/Users/julian/.t3/userdata/attachments/3b70f965-756c-40f0-a788-d0304fb08048-30f78340-da43-4647-8ca4-bd67de640fba-zip.zip

Extracted source, tables and local outputs are OUTSIDE git:
/Users/julian/Documents/litt3-computation-data/degree84-certificate-20260909-mYCWoQ/degree84_census_certificate

The unmodified character source needs existing Boost headers on this Mac:

    clang++ -O3 -std=c++17 -I/var/tmp/sage-10.9-current/local/include characters84.cpp -o characters84
    ./characters84
    python3 verify84.py tables84.recomputed.jsonl character_local.txt

`character_local.txt` faithfully records the locally executed program's
stdout; it is not the supplied mass transcript. Source code and paths
were inspected before execution. No packages were installed.

Table SHA256:
97aad0a105d12d0905415d16c3df2094e87fd5522f62e11dc86680f6de053926

Compact [local receipt](computations/triangle237_census_verification.txt).
Latest user asks for a harder shared Pro theorem, followed by completion
of backup84/2 while Pro works. No census rerun is needed. The new
horizontal-product diagnostic reduces H=A18*C6 from25 coefficients to
a10-dimensional space for each of the five dormant opers. The remaining
nonlinear factor/cube equation has not yet been solved.
