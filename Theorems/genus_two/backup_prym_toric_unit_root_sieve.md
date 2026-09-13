# Small toric Prym models and higher-precision geometric factor sieves

Version1,2026-09-11. Focused geometric and arithmetic audits PASS.

For an ACTUAL genus8 carrier of cyclic_trigonal_kummer_carriers, suppose
degQ=2 and gcd(P,Q)=1 in P^3+FQ^3=R^2. Put p=R/P modQ, degp<=1, and

 A=(p^2-P)/Q, B=(p^3+2Pp+2R)/Q^2,
 C=(p^4+4Pp^2-2Rp+2P^2)/Q^3.

These are polynomials and Z=Qw-p gives the birational equation

              Qw^4+pw^3+Aw^2+Bw+C=0.

For degP=6, replace w by z-(lcR/lcP/lcQ)x. For degP<=5 no shift is
needed. The resulting ACTUAL Newton polygon has exactly the eight
interior points (1,1),(2,1),(3,1),(1,2),(2,2),(3,2),(1,3),(2,3).
Its toric closure is smooth. Actual edge-polynomial squarefreeness
certifies transverse boundary and Newton nondegeneracy; it must be checked.

Let G be a support-preserving coefficient lift of the final equation to
W(F_(5^a)), with true Witt Frobenius sigma. If its interior Hasse--Witt
matrix is invertible, put

 beta_(5^s)[u,v]=[x^(5^s v-u)]G^(5^s-1),
 U_s=beta_(5^s)*sigma(beta_(5^(s-1)))^(-1) mod5^s.

The projective Jacobian unit-root characteristic polynomial modulo5^s is

       det(TI-U_s sigma(U_s)...sigma^(a-1)(U_s)).

For a=342, let r1,r2 be the roots reducing to1,2 of the established
backup Weil polynomial T^4-8T^3+182T^2-1000T+15625 in Z5, and v_i=r_i^114.
If this Jacobian contains J(C_alpha) GEOMETRICALLY, its unit-root
polynomial is divisible modulo5^s by at least one monic polynomial

       product_(i=1,2) v_i^phi(n) Phi_n(T/v_i),
       n in {1,2,3,4,5,6,8,10,12}.

All multiplicities and finite-field twists are retained. At s=2 this
gives six distinct filters: the five integer polynomials in
backup_prym_cartier_factor_sieve and T^8+T^6+T^4+T^2+1.

Failure of all tests excludes this actual carrier. Passing is inconclusive.
The theorem does not cover an unchecked Q1/noncoprime chart, certify an
untested carrier, construct a map to the backup, or exclude the whole row.
Finite-field comparison with a saved Prym must retain the quadratic
character of any norm-recovery rescaling; the whole filter family is
invariant under that twist at every precision.

[Proof](../../Solutions/genus_two/backup_prym_toric_unit_root_sieve.md) ·
[Toric audit](../../Research/audits/TORIC_PRYM_NORMALIZATION_AUDIT_2026_09_11.md) ·
[Arithmetic audit](../../Research/audits/PRYM_HIGHER_PRECISION_FACTOR_SIEVE_AUDIT_2026_09_11.md).
