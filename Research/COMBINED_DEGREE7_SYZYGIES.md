# Complete linear-U cancellation test for the saved genus-nine tensor

2026-09-07. Exact coefficient computation, first saved acyclic oper only.
The common-cover problem remains unsolved; this does not exclude an atlas.

Let N_r(U,beta^[5]) (64 rows) and R_j(U,beta^[5]) (32 rows) be the
cached canonical homogeneous degree-six expressions. The original ideal
has generators N_r, R_j-beta_j, and U.beta-2.

The complete coefficient matrix of all U_m*N_r and U_m*R_j has shape
3072 by16896, with columns U_i*U_j*beta_l^5 for i<=j. Over the specified
F25 its rank is **3063**, so the entire left syzygy space has dimension9.
All9 basis syzygies are supported on the2048 U_m*N_r rows: their1024
coefficients on the U_m*R_j rows are identically zero.

Every such syzygy would yield a quadratic original-ideal consequence
sum d_(m,j)*U_m*beta_j, by replacing R_j with R_j-beta_j. Their complete
consequence space therefore has **rank0**. In particular it contains no
nonzero multiple of U.beta, and supplies no contradiction to U.beta=2.
Equivalently, the1024 U_m*R_j classes are linearly independent modulo
the span of U_m*N_r. Thus adding these R rows creates no new cancellation
beyond the9 existing N-only syzygies.

This rules out the specified homogeneous linear-U multiplier mechanism
for obtaining new quadratics by degree-seven cancellation. It does not
rule out multipliers involving beta, normalization-assisted mechanisms,
higher degrees, or other ways of obtaining consequences of the full ideal.

Reproduce with `sage scripts/combined_degree7_syzygies.sage`. The script
performs one augmented echelonization, extracts the complete kernel,
checks its row independence, and multiplies it into the original matrix
to verify all152,064 coefficient equalities. It saves all9 syzygies with
roundtrip-checked field encoding and an input SHA256 in
`Research/computations/combined_degree7_syzygies.json`. These are exact
polynomial identities, with no sampling and no Groebner computation.
The run took19.31 seconds and peaked at460,390,400 bytes resident memory.
