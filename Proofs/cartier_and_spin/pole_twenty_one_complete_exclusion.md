# Complete seven-label endpoint exclusion on the original source

27 September2026. The [actual pole21 reduction](pole_twenty_one_trace_reduction.md)
proves integer phase balance, scalar normalization into E=F_(5^8),
and all four traces on the original source. The
[F25 scalar lemma](sextic_quadratic_scalar_exclusion.md) explicitly
covers seven labels and excludes that scalar sector. No cubic
quotient needs to be constructed.

## Exact finite problem and complete endpoint filter

Use the fields, four endpoint rows and four equations in the
[sextic proof](pole_eighteen_complete_exclusion.md), changing ONLY
the cardinality of each endpoint multiset to seven. All repeated
labels and all epsilon in E minus F25 remain. The same X,Y in
K0=F_(5^14) must occur in both endpoints and all four traces.

The five signature vectors S1(17),S2(17),S3(17),S1(4),S2(4) must
have F25 rank at most three, by the rank-two quotient coefficient
argument in that proof. U_L cannot belong to K0: otherwise prime-field
seven-phase independence forces cardinality7=4a+5b, impossible for
nonnegative a,b. At a nonconstant coordinate U_k, every permitted
scalar occurs among the625 exact proposals
epsilon=(b-V_k)/(U_k-a), a,b in F25. Each proposal is tested in all
seven coordinates. The reciprocal implementation uses V_k instead
when possible, with an explicit fallback to U_k.

Root rotation preserves the field equations and sends epsilon to
epsilon^(25^s). Every scalar-labelled endpoint orbit has a representative
whose smallest encoded label is4h. Thus the complete normalized domain
is (4h,b,c,d,e,f,g),4h<=b<=...<=g<116,0<=h<29. Its cardinality is
sum_h binom(121-4h,6)=18,247,955,940.

The [native endpoint source](../../scripts/arithmetic/septic_full_scalar_endpoints.cpp)
was run twice, using different rank and scalar reconstructions. Both
complete runs give:

| Signature rank | Multisets |
| ---: | ---: |
|0|0|
|1|900|
|2|8,368,227|
|3|11,823,268|
|at least4|18,227,763,545|

The direct scalar reconstruction checks12,606,902,150 permitted
proposals. The reciprocal one checks12,609,335,000, using its fallback
87 times. Both retain2,077,557 distinct scalar-labelled endpoints.
Their SORTED record sets agree exactly, with no duplicate in either.
They are not byte-identical in original order because the fallback
changes proposal order. The sorted set SHA256 is
b8ba45f4af68a709bc4ad8567d5f4d54e8ad385f8886bff5b719566f6884a476.
The separate original-file hashes are in record_set_comparison.json.

## Two full common-moment matches

[The matcher](../../scripts/arithmetic/septic_two_endpoint_match.cpp)
restores all four root rotations and deduplicates, obtaining5,238,952
scalar-labelled endpoints. At infinity it uses the inverse of the
one-endpoint accepted scalar, as required by the reciprocal fourth
trace. Its first run solves the second old trace for X,Y using a
nonconstant coordinate of epsilon. The remaining coordinate conditions
and the other three traces form98 F25 coordinates, additive in the
two endpoint contributions. A fixed explicit F5-linear projection
to20 coordinates is used as a necessary matching condition. There
are ZERO projected matches, hence zero exact matches.

The second run instead solves the FIRST old trace, transports the
result through bar, uses a different projection, and repeats the full
matching on the independently generated reciprocal record set. It too
finds ZERO projected matches. In particular no common-pole profile
or moment pair satisfies all four equations. The projection is a
one-way rejection filter, not a probabilistic assumption: equality
of98 coordinates implies equality under ANY chosen linear projection.

## Independent arithmetic audit and reproduction

The [literal Sage verifier](../../scripts/arithmetic/verify_septic_trace_reconstruction.py)
uses a polynomial tower of total degree56, direct Frobenius powers,
and the four equations themselves. It calls none of the native field,
signature, pivot or Frobenius-table routines. It verifies21,052
syndromes from each full matcher,42,104 altogether, including all
survivors with seven distinct phases and systematic samples of every
other shape. Every one of the4,126,192 retained F25 coordinates agrees.
These are explicitly bounded implementation checks; coverage is given
by the complete enumerations and matches, not by the samples.

The evidence directory is
[septic_full_endpoints_20260927](../../../litt3-computation-data/septic_full_endpoints_20260927/).
It retains both raw endpoint sets, concise complete counts, both empty
match files, the record-set comparison and independent execution JSONs.
The source takes output.bin and optional --reciprocal. The matcher takes
input.bin,matched.bin,--solve-second or --solve-first, and samples.bin.
The independent verifier takes output.json and one or more sample files.
Build C++17 with assertions and the mixed_phase_data.h include directory
used by the inherited audited field implementation. Sage10.9/Python3.14.3
was used for the independent checks. Bulky intermediate syndromes need
not be saved; the scripts reconstruct them deterministically.

The complete finite system is necessary for every actual pole21
comparison by the independently audited direct-source trace theorem.
Its emptiness therefore proves the stated actual-map exclusion. It
does not supply the shared Cartier object for an arbitrary common cover.
