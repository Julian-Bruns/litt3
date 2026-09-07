# The extra atlas radical is a space of liftable parabolic Higgs fields

Work in characteristic5 with an ACTUAL normalized untwisted Hermitian
atlas on C, with 5 not dividing2g-2. Write omega=omega_C, n=g-1, and
write its actual rank-three bundle and osculating flag as

    0 -> O --e--> E3 -> V ->0,             class alpha,
    O e subset K subset E3,   K/O=omega^-1,   E3/K=omega^2.

Assume V is stable with H0(V)=0. Put E2=V omega, and let u in H0(E2)
be the nowhere-zero section induced by K/O. Normalize the Serre
functional lambda_alpha on A=H0(E2) so lambda_alpha(u)=1. Let A_s and
M_s be the actual canonical-divisor maps in the preceding rank records.

1. The hyperplane

       H_alpha=ker(lambda_alpha)
              =image[H0(E3 omega)->H0(V omega)]

   has odd dimension4n-1. Restriction of A_s to it gives an odd
   alternating form B_s, and there are canonical identifications

       ker M_s = rad(A_s)/ku = rad(B_s).                  (1)

   Thus the extra radical directions are exactly the radical sections
   that LIFT to the actual rank-three atlas bundle, not atlas tangent
   vectors. The actual R equation is retained in the choice of E3,
   alpha, the Frobenius form, and the osculating flag.

2. Every trace-free Higgs field phi on V has a UNIQUE lift to a
   trace-free Higgs field Z on E3 with Z(e)=0. Under this lift, ker M_s
   is EXACTLY the space of such Z satisfying both conditions:

   - Z preserves K along the entire scheme D_s=div(s);
   - the eigenvalue on (K/O)|D_s is the restriction of a GLOBAL
     canonical form r in H0(omega).

   A kernel dimension at least3 means at least three independent
   fields with these two properties. Neither condition may be replaced
   by an infinitesimal Frobenius-isometry assertion.

3. The signed maximal Pfaffians of B_s give a canonical polynomial
   section, with its natural determinant-line factor, of its radical.
   Its degree in s is2n-1. It is NONZERO precisely when dim ker M_s=1;
   when nonzero it constructs the required intrinsic kernel line.
   It vanishes precisely on the extra-kernel locus dim ker M_s>=3.

   Equivalently, in the even-dimensional A presentation this candidate
   is PfaffAdj(A_s) lambda_alpha. It is orthogonal to lambda_alpha and
   is NOT the common radical vector u. For genus9 the candidate has
   canonical-pencil degree15. Its being nonzero GENERICALLY at every
   actual atlas remains the unresolved assertion, not a proved premise.

4. For each canonical s there is a unique covector sigma_s in
   H0(E3^vee omega) with sigma_s(e)=s. For any basepoint-free canonical
   pencil s0,s1, their wedge gives a NONZERO liftable section

       sigma_s0 wedge sigma_s1 in H0(E3 omega),

   whose image in H_alpha is nonzero. This image is not in the COMMON
   radical. Thus a lift to E3 alone does not establish the radical
   condition or supply the missing generic kernel line.

5. The actual Frobenius form gives F_C^(2*)E3=E3 omega^8. Hence E3
   is strongly semistable; for genus9 it is stable since gcd(3,16)=1.
   In every basepoint-free canonical pencil, a general sigma_s is
   nowhere zero. Its kernel F_s is then a rank-two degree-zero bundle
   with determinant O and H0(F_s)=0, constructed from the ACTUAL atlas.
   No identification ker M_s=H0(End F_s), nor stability of F_s, is
   asserted without an additional proof.

The first, second and fourth constructions are diagram lemmas that also
hold for a suitable abstract rank-three extension. Here they are applied
only to the actual E3 furnished by the full Hermitian atlas equations.
They do not show that the Frobenius form forces generic nullity1, nor
construct a higher-normal-corank atlas. Orbit0011 is not excluded.

Status: author proof,2026-09-07; no independent audit claimed. The intrinsic
Pfaffian candidate is nonzero at all26 F25 pencil parameters for all33
known genus-two atlas points; every resulting extra vector is liftable
but fails the common-kernel condition. Full original equations and
R-sensitive negative controls remain in the check.
[Proof](../Solutions/Sol_atlas_liftable_radical.md).
