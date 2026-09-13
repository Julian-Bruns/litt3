# Complete dormant-oper census, homogeneous local algebras and cubic quotient

Version2,2026-09-13. Use the [complete scalar chart on the fixed X](fixed_x_dormant_equations.md),
over F25=F5[a]/(a^2+4a+2), and rho=2a+1. Let S be its dormant-oper scheme
and let sigma:y->rho*y be the actual cubic deck automorphism. Then:

1. S has28,990 distinct geometric points and length29,375:55 fixed points
   A=C=0 of local length8, and28,935 further reduced points. The fixed
   scheme is reduced, with six residue degrees1,1,2,9,19,23 over F25.
2. At every fixed geometric point the full local algebra is explicitly

       k[t0,t1,t2]/(Q1,Q2,Q3),

   a homogeneous complete intersection of three quadrics, with Hilbert
   function(1,3,3,1). The three tangent parameters lie in the A block and
   have deck weight2; in these coordinates A=A1, C=C2, B=B0+B3, with
   homogeneous degrees1,2,3. The original B,C,A tangent-block ranks are
   8,5,8. In particular m^4=0. The coefficient c4 is a nonzero quadratic
   generating an ideal of length2. Thus S intersect(c4=0) has exactly
   these55 points, each of slice length6, and total length330.
3. Scheme-theoretically a10=c4^2. On c4!=0 put t=c4, lambda=t^3,
   C=t Chat and A=t^2 Ahat, with Chat and Ahat monic of degrees4 and10.
   The cubic quotient has the14 lower coefficients of Chat,Ahat as
   coordinates; B and lambda are uniquely reconstructed by monic division.
   Its44 coefficient equations have maximum degree16. The reconstructed
   lambda is already a unit in this whole quotient, so adjoining an
   inverse variable is unnecessary, including scheme-theoretically.
   The original open scheme is recovered by the finite etale degree-three
   extension t^3=lambda. All three cubic branches are distinct.
4. This normalized quotient is the reduced F25 algebra

       A=F5[z]/(P(z)), deg P=19290, a=h_zeta(z), a9=z,

   of F25 dimension9645. Its12 residue degrees are

       1,2,13,17,40,124,205,220,403,578,718,7324.

   The [frozen algebra certificate](../../Research/computations/normalized_oper_algebra_certificate.json)
   specifies P and every coordinate; the [factor data](../../Research/computations/normalized_oper_closed_points.json)
   specifies the irreducibles. Only roots satisfying the specified F25
   embedding are counted. The [exact index ranges](../../Research/computations/complete_oper_solutions.json)
   retain every cubic branch and multiplicity.
5. The full categorical quotient S/<sigma> has9645 reduced geometric
   points and55 double points, hence9700 points and length9755. At each
   fixed point its local algebra is k[epsilon]/(epsilon^2), the degree0
   and degree3 part of the homogeneous local algebra. This quotient is
   distinct from the reduced fixed-point scheme in(1).

The actual untwisted Hermitian-atlas existence test therefore needs18
oper representatives:12 normalized and six invariant Frobenius orbits.
Frobenius and precomposition by the actual deck automorphism preserve
finite etaleness. Each test still quantifies over every quotient map.
For a nontrivial torsion twist, these symmetries also transform the twist;
they do not reduce all twists to18 scalar tests. No atlas or common-cover
exclusion follows from the census alone.

The new [small center data](../../Research/computations/invariant_oper_centers.json)
and [local verifier](../../scripts/atlases/opers/verify_oper_local_quadrics.sage) replace saved
formal expansions by three homogeneous quadrics per closed point.
The [full verifier](../../scripts/atlases/opers/verify_oper_census.sage) proves completeness
by exhausting the independent global length, without a discovery basis.
Independent mathematical audit and fresh full replay PASS.
[Proof](../../Proofs/projective_connections/fixed_x_oper_enumeration.md) ·
[Consolidation audit](../../Research/audits/OPER_CENSUS_CONSOLIDATION_AUDIT_2026_09_13.md).
