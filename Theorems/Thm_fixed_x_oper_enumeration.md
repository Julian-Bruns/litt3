# Complete fixed-X dormant-oper census and symmetry reduction

For the [fixed curve X](../Definitions/Def_fixed_pair.md), the full
[dormant-oper scheme](Thm_fixed_x_dormant_equations.md) has exactly
**28,990 distinct geometric points**:

- 55 deck-invariant points, each of local length8;
- 28,935 further points, each of local length1.

Its total length is55*8+28935=29375. This is a complete rank-two candidate
census, not a common-cover exclusion.

More precisely, the normalized [cubic quotient](Thm_fixed_x_oper_cubic_quotient.md)
is the explicitly certified reduced F25 algebra

    A = F5[z]/(P(z)),       degree(P)=19290,
    a -> h_zeta(z),        a^2+4a+2=0.

The polynomial P and every normalized coordinate h_i are recorded in the
[algebra certificate](../Research/computations/normalized_oper_algebra_certificate.json).
They satisfy the ORIGINAL input equations; h_a9=z, and gcd(P,P')=1.
The independently known length gives an algebra isomorphism, not just
a collection of roots or a candidate Groebner basis.

The normalized scheme has12 closed points overF25, of residue degrees

    1,2,13,17,40,124,205,220,403,578,718,7324.

These degrees sum to9645. Their exact irreducible F5 polynomials, with
the specified F25 embedding, are in the
[closed-point data](../Research/computations/normalized_oper_closed_points.json).
For each point, all three roots t^3=lambda give distinct original opers
by C=t*Chat and A=t^2*Ahat, and preserve multiplicity1.

Consequently the actual untwisted Hermitian-atlas existence test needs
only **18 oper representatives**: the12 normalized closed points and
the6 invariant closed points. This uses Frobenius overF25 and the actual
deck automorphism y->rho*y of X, not a heuristic sampling argument.
Every allowed quotient map for a representative must still be included.
For nontrivial torsion twists these symmetries also act on the twist;
the statement does not replace that remaining family by18 scalar tests.

Audit: PASS, fresh `/root/normalized_enumeration_certificate_audit`,
2026-09-07, for the algebra certificate, reducedness and geometric counts.
The subsequent factor degrees are exact factorization output; the18-test
consequence is the elementary symmetry argument in the proof, not a
separately audited atlas exclusion. [Proof](../Solutions/Sol_fixed_x_oper_enumeration.md).
[Audit metadata](../Research/audits/NORMALIZED_OPER_ENUMERATION_AUDIT_2026_09_07.md).
