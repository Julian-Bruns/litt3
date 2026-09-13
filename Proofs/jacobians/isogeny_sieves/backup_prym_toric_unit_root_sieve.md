# Proof and exact arithmetic for the higher Prym sieve

2026-09-11. Independent bounded audit /root/audit_toric_prym_normalization
PASS for both the normalization/unit-root bridge and higher-precision
factor divisibility. No whole degree2 exclusion is asserted here.

## Actual small equations

The original quartic is geometrically irreducible and its normalization
has genus8 by cyclic_trigonal_kummer_carriers. Set p=R/P modQ. The norm
equation implies p^2=P modQ and, successively,

 P=p^2-QA, R=p^3+pQA+3Q^2B,
 QC=2A^2-pB, F=A^3+pAB-p^2C+4QB^2.

These identities prove all the displayed polynomial divisions; no
squarefreeness of Q is needed for this algebra. Substitution Z=Qw-p
gives the normalized equation exactly, with rational inverse. Coprimality
of Q,p excludes an extraneous vertical component.

For P degree6 put k=lcR/lcP,h=lcQ. The norm coefficients give
lcP=k^2,lcR=k^3,R8=4kP5. Under w=z-(k/h)x, the coefficient degrees
of z^4,z^3,z^2,z,1 are at most2,3,3,3,4; the constant x^4 coefficient
is -lcF/k^2 and the x^3z^3 coefficient is k. For P degree<=5 the raw
bounds are2,1,3,4,4. The resulting bounding polygons have the same eight
interior lattice points stated in the theorem.

The actual toric divisor avoids all toric vertices. Its arithmetic
genus is the number of interior lattice points, at most8; its geometric
genus is already8. Thus equality holds and all local normalization
defects vanish. It is smooth. On each ACTUAL edge, squarefreeness of the
one-variable face polynomial in the primitive edge coordinate supplies
the separate boundary-transversality condition. Smoothness alone does
not supply that condition.

## Interior unit roots, not toric boundary factors

Lift the final polynomial coefficientwise, preserving its support.
The characteristic-five P,Q,R identities are not asserted over the lift.
[Beukers--Vlasenko, Dwork Crystals I](https://arxiv.org/pdf/1903.11155),
Theorem5.3, gives U_s modulo5^s. Its Theorem6.1, Corollary5.8 and
AppendixA, RemarkA.2 identify the interior determinant with the unit-root
factor of the PROJECTIVE curve as follows.

For an edge with reduced boundary divisor write E_e(T)=product(1-T^deg).
Its interior Hasse--Witt matrix is invertible: logarithmic residues
identify Cartier with inverse Frobenius on the sum-zero residue vectors.
The full edge determinant is (1-T)E_e(T), while the two vertex factors
are (1-T)^2, so its interior determinant is E_e(T)/(1-T). A polygon has
the same number of vertices and edges, hence all boundary blocks multiply
to product E_e(T). The full polygon formula gives

 D_full/(1-T)=Z(C intersect torus)_unit
             =P_unit(C)*product E_e(T)/(1-T).

Cancelling boundary blocks leaves exactly P_unit(C). AppendixA explicitly
gives the ordered product U sigma(U)...sigma^(a-1)(U), up to a harmless
transpose of the whole product. No matrix inverse or reversed product
is substituted for it.

## Integral geometric factor test

The audited isotypic argument in backup_prym_cartier_factor_sieve gives
an actual defined B-isotypic subvariety C of A, geometrically B^m,m<=4.
Its finite-order twisting operator has K-characteristic polynomial a
product of rational cyclotomic polynomials of orders1,2,3,4,5,6,8,10,12.
For each block, its unit eigenvalues are v_1 zeta and v_2 zeta over all
roots zeta of that cyclotomic polynomial. This gives the full monic F_n
in the statement, including the ramified n=5,10 blocks.

The ordinary subvariety has integral Weil factor W_C dividing W_A in Z[T].
Unique Hensel factorization into monic unit and nonunit factors is
multiplicative, so W_C^unit divides W_A^unit in Z5[T]. No integral
projector, nor division by its possible5-denominator, is used. Reduction
therefore preserves every monic divisibility test and multiplicity.

Exact Hensel lifting gives r=(1,7),v=(1,-1) modulo25 and
r=(51,82),v=(76,74) modulo125. The n5/10 modulo25 filter is
sum_(j=0)^4 T^(2j), whose value at either1 or-1 is5, not0 modulo25.
At higher precision the full nine-order family must be retained.
Quadratic twisting permutes1<->2,3<->6,5<->10 and fixes4,8,12, so it
does not affect rejection by the entire family.

## Reproducible implementation and checks

scripts/arithmetic/fixed_x_prym_toric.py verifies every birational substitution and
every actual edge. scripts/arithmetic/toric_prym_unit_roots.py first compares its
beta5 polynomial against the previously saved ACTUAL anti-Cartier matrix.
It verifies (P+Qy)*g=scalar*v^2 and uses the scalar's quadratic character
in that comparison. The true Witt Frobenius is checked on its generator,
the defining polynomial, its field order and an independent Sage image.
Native modular composition then computes its arbitrary iterates.

For the two-digit calculation write Gghost=(f^5-sigma(f)(x^5))/5.
The identity

 f^24=f^4 sigma(f^4)(x^5)
       +20 f^4 Gghost sigma(f^3)(x^5) mod25

avoids expanding a large full24th power. Only the requested64 coefficients
are accumulated. scripts/arithmetic/audit_toric_unit_root_computation.py independently
compares all64 entries with the DIRECT24th power on a small actual genus8
carrier, and checks the resulting unit traces against direct smooth-toric
point counts over F5,F25,F125. It passes, with counts12,42,120. A tuple-key
bug in the audit's first boundary counter was found and corrected before
acceptance; the production edge checker uses monomial_coefficient and was
not affected.

At the actual pilot carriers1226,1430, all geometric hypotheses and the
mod5 comparisons pass, including their respective twists-1,+1. The
computed modulo25 polynomials, in ascending coefficient order, are

 1226: [17,8,13,18,24,20,15,9,1],
 1430: [14,22,14,12,2,24,4,17,1].

Both fail all six modulo25 filters; these two actual carriers are excluded.
Each higher-precision run took about13seconds. The certificates are under
degree2-prym-unitroots-INDEX-20260911 in the external computation root.
Other labels and unsupported charts remain open until individually checked.
