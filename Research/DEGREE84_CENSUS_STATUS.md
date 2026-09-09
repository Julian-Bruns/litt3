# Degree84 census — complete local replay, source comparison OPEN

Received and replayed2026-09-09. This certifies the finite permutation
census, NOT a curve-specific exclusion. The backup degree84(2,3,7)
row and the five-case backup remainder are unchanged.

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

Exactly three primitive survivors can accommodate a three-element
Frobenius orbit. The earlier degree24/48 counting contradiction does not
extend. Neither good tame reduction nor identification of the45 possible
sources with the specified curve is established. Group identification
alone excludes none of them.

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
Latest user priority remains the SHARED coreless obstruction; backup-only
source comparison is paused. No new Pro request or computation is running.
