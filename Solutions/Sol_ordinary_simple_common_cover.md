# Proof: remove the unnecessary split-branch restriction

[Statement](../Theorems/Thm_ordinary_simple_common_cover.md).

## 1. Parameterized geometry, including infinity

For coprime squarefree monic cubics A,B over an algebraically closed
field of characteristic different from3, valuations at a root of A
and a root of B prove independence of their classes modulo cubes in
k(t)^*. Hence adjoining u^3=A,v^3=B gives a connected degree9 Galois
extension with group C3^2. Its normalized projective curve T is smooth.
There are exactly six branch points, each of index3. At a root of A
inertia is the u-axis; at a root of B it is the v-axis. At infinity,
both poles have order3 and their leading units are cubes in k((1/t)),
so there is NO inertia. Riemann--Hurwitz gives

    2g(T)-2=-18+6*6=18, hence g(T)=10.

The diagonal and anti-diagonal subgroups of order3 meet none of the
inertia groups. Their actions are free everywhere, so both quotient
maps are finite Galois etale. Invariant functions u/v and uv give
exactly C_minus and C_plus: adjoining u to either invariant field
recovers v and has degree3. Their genera are therefore4. The two
subgroups generate C3^2, so the quotient fields intersect in k(t).
All maps use the SAME normalized source. No unspecified cover or
simultaneous Galois refinement is substituted.

## 2. Fixed coefficients and exact arithmetic

The [fixed verifier](../scripts/cubic_ordinary_common_cover_certificate.py)
checks squarefreeness and coprimality of the displayed A,B, counts all
fibers exactly, and saves the full
[certificate](../Research/computations/cubic_ordinary_common_cover_certificate.json).
Its finite-field models and conventions are recorded in the
[computation note](../Research/CUBIC_ORDINARY_COMMON_COVER_CERTIFICATE.md).
The counts over extensions of F25 of degrees1,2,3,4 are

    C_plus:  33,615,16095,392427;
    C_minus: 33,657,15726,391017.

A rational root of A or B gives one point on either curve, including
the poles of A/B. All other finite fibers have3 or0 points according
to the cube test. Both curves have three rational points at infinity,
since A,B are monic. Newton identities and the functional equation give

    P_plus(T)=T^8+7T^7+19T^6+175T^5+1525T^4
              +4375T^3+11875T^2+109375T+390625,
    P_minus(T)=T^8+7T^7+40T^6+199T^5+931T^4
               +4975T^3+25000T^2+109375T+390625.

Both are irreducible over Q. Their p-ranks are respectively2 and4:
the highest indices of coefficients not divisible by5 in the reciprocal
polynomials are2 and4. Thus the minus Jacobian is ordinary, while the
plus Jacobian is not.

For the two self-pairs and the cross-pair form

    Res_T(P(T), z^8 Q(T/z)).

From each self-resultant remove exactly (z-1)^8. All three remaining
resultants have no cyclotomic factor. Full coefficients and irreducible
factorizations are saved, and independent exact gcd tests against all
127 cyclotomic polynomials of degree<=64 agree. The order bound8192
is exhaustive because m/phi(m)^2<=2. These are finite polynomial
certificates, not sampled eigenvalues or approximate roots.

The general Frobenius argument in
[the Picard certificate proof, Section3](Sol_picard_simple_common_cover.md)
now applies verbatim with degree8 in place of6: irreducibility and no
nontrivial self-root ratios imply irreducibility over EVERY finite
extension and hence absolute simplicity. No cross-root ratio implies
geometric Hom-zero. Alternatively, once simplicity is established,
different ordinarity already rules out an isogeny and hence any nonzero
homomorphism. No ordinary hypothesis is used to prove simplicity of
the plus endpoint.

The earlier24-trial experiment forced every branch point to be rational
over F25. That extra restriction was not geometrically necessary and
was removed here. The failed sample did not prove a general obstruction.
Only fixed-pair verifiers remain active; exploratory prototypes are
recoverable in the Trash location recorded in the computation note.
