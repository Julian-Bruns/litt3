# The backup degree-two atlas forces a genus-eight Prym factor

Version1,2026-09-11. Focused audit PASS /root/audit_degree2_a4_prym.
The Frobenius-isogeny distinction was corrected before acceptance.

Let X be the fixed genus-nine cyclic trigonal curve and B=C_alpha the
genus-two backup. If there is an actual degree-sixteen map from X to
the SAME six-point orbifold P1(2,2,2,2,2,2) of B's hyperelliptic map,
then there are actual connected curves X',U,R with:

1. X'→X finite etale of degree2, X'→B finite etale of degree16;
2. U→X finite etale V4-Galois and dominating the ORIGINAL X';
3. U→P1_x A4-Galois, with eleven inertia groups of order3;
4. R=U/C3 of genus8, with an actual degree4 map to P1_x and eleven
   complete branch fibers of type(3,1);
5. J(R) is isogenous to Prym(X'/X), and J(B) is a geometric isogeny
   factor of J(R).

The original same-source maps U→X and U→X'→B are retained. Part5 does
not assert an actual map R→B.

These necessary carriers are indexed by the F4-lines in J(X)[2]
under the order-three trigonal action. The Frobenius25 action has
exactly1533 orbits on these87381 lines, each of length57. Thus1533
carrier representatives suffice for the GEOMETRIC ISOGENY-FACTOR test
against fixed J(B), since Frobenius conjugates of an abelian variety
are geometrically isogenous. These are label orbits, not a count of
nonisomorphic curves R. For actual-map or source-isomorphism testing,
retain all three backup conjugates or4599 Frobenius25^3 label orbits.

No carrier equations or complete factor sieve are supplied by this
reduction. The degree-two atlas case remains open.

[Proof](../Solutions/Sol_backup_degree_two_prym_reduction.md) ·
[Audit](../Research/audits/DEGREE2_A4_PRYM_AUDIT_2026_09_11.md) ·
[Exact orbit checker](../scripts/check_degree2_frobenius_orbits.py).
