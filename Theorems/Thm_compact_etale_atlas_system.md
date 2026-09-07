# A compact atlas system with no boundary cases and no nilpotent solutions

Fix any geometric oper on the chosen genus-nine curve. Use A=S_U,
J, i:J->A*, Ntilde, R, and Q from `dormant_differential_projection`.
Choose an A-basis, use its dual coordinates beta in A*, and put
eta=i^-1(beta). Choose any linear extension of i from J to E=P48.

The following system in64 scalar variables U_i,beta_i is EXACTLY the
untwisted atlas criterion:

    Ntilde_U (i^-1 beta)^[5]=0,                             64 equations
    i_proj(R_U (i^-1 beta)^[5])=beta,                       32 equations
    sum_i U_i beta_i=2.                                     1 equation

The first96 equations have degree at most6; the final one is quadratic.
There are no inverse variables, nonvanishing conditions, missing infinity
charts, or extra solutions supported on invalid quotients. In particular,
all solutions automatically have reconstructed Wronskian1 and pole U111/112.

For every fixed oper this affine solution scheme is finite and reduced
(possibly empty). Its Jacobian has rank64 at EVERY geometric solution.
Every solution reconstructs actual atlas data by the existing criterion.
Different presentations need not be counted as distinct isomorphism classes
of atlases; no enumeration of this scheme is claimed here.

The all-strata identity underlying this simplification is

    i(R_U eta^[5])(U)=2 Wh(U,-aff(U eta^5))

for every U,eta with Ntilde_U eta^[5]=0, without admissibility assumptions.
It is stronger in this respect than restricting the global gradient
identity to the primitive kernel line on a dense open set.

The complete coefficients for the first new F25 oper are exported in
`Research/computations/canonical_atlas_system.json`; this is not a solver
result or an emptiness certificate. The original Litt3 problem remains open.

Status: proved, bounded independent audit PASS. Auditor:
resultant_gradient_major_audit, 2026-09-07. No remaining objections.
[Audit reference](../Research/audits/UNIVERSAL_RADIAL_COMPACT_AUDIT_2026_09_07.md).
[Proof](../Solutions/Sol_compact_etale_atlas_system.md).
