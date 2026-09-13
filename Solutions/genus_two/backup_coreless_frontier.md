# Proof: use the exact small fiber rather than large-degree avoidance

2026-09-11. This is an author corollary with the evidence scopes of
its prerequisites retained. No new global rigidity theorem is used.

The [complete backup theorem](../../Theorems/genus_two/backup_cored_span_exclusion.md)
excludes every cored span. The
[two-primary Frobenius criterion](backup_curve_arithmetic.md#3-a-small-frobenius-congruence-controls-all23-torsion)
makes every two-primary point on its Abel curve a Weierstrass class.

Suppose there is a singleton clump image P on B. The primitive
canonical generator has div(s_B)=2dP. In the Cartier-zero branch,
[the family singleton theorem](../../Theorems/arithmetic/family_singleton_root_exclusion.md)
already excludes it for every alpha^5-alpha!=0. In the nonzero branch,
[the fixed-X profiles](../../Theorems/connections/fixed_x_nonzero_cartier_profiles.md)
give d=2 or 4. Therefore 2d[P-O]=0, so 8[P-O]=0, and the exact
two-primary criterion makes P Weierstrass.

At a Weierstrass point there is a regular form theta with divisor
2P, and s_B is a scalar multiple of theta^d. The Cartier power rule
then makes theta a Cartier eigenform. This is excluded by the six
symbolic eigenline identities in Section 4 of
[the family proof](../arithmetic/family_small_torsion_specialization.md).
Those identities hold on the ENTIRE alpha^5-alpha!=0 domain,
including the semilinear fifth powers of the branch parameter.
Thus both singleton branches are impossible at this actual backup.

Now apply the arbitrary-genus-two part of
[the clump reduction](../../Theorems/genus_two/genus_two_clump_connection_reduction.md).
It proves r=1 OR r congruent to 4 modulo 5: r=6,11,... are excluded,
not retained. Removing r=1 gives precisely r=4,9,14,... and supplies
the intrinsic common regular nilpotent connection. The nonzero
Cartier profile theorem further gives r=4 in that branch.

If no clump exists, the canonical intersection is k and
[the connection-spectrum theorem](../../Theorems/common_covers/coreless_connection_spectrum.md)
allows an empty spectrum or a single dormant point. Parts 1--2 of
[the first-Witt theorem](../../Theorems/common_covers/two_leg_negative_extensions.md)
give joint tangent zero and absence of a simultaneous W2 lift,
hence the exact marked deformation ring k.

Finally, Part 4 of that same first-Witt theorem applies to EVERY
W2-liftable coreless span with a genus-two endpoint. It gives joint
tangent zero and W(k)/(5^e), e>=2 or infinity. The main pair's
separate high-parameter arithmetic avoidance is not a backup input.
Accordingly no finiteness of e is asserted here.
