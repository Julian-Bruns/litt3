# A five-divisor Cartier sieve for geometric backup Jacobian factors

Version1,2026-09-11. Focused geometric audit PASS.

Let B be the genus-two backup C_alpha, alpha^3+alpha+1=0. For any
eight-dimensional abelian variety A over F_(5^342), let h_A(T) be the
degree-eight characteristic polynomial of the342-fold coherent Frobenius
on H1(A,O_A). If J(B) is a GEOMETRIC isogeny factor of A, then h_A in F5[T]
is divisible by at least one of

    T^2-1,
    T^4+T^2+1,
    (T^2+1)^2,
    (T^4+1)^2,
    (T^4-T^2+1)^2.

No ordinariness of A is required. The last two tests are equality tests.
This includes all possible finite-field twists and multiplicities of the
backup isotypic component. Passing the sieve does not prove a factor.

For an ACTUAL nonzero two-torsion class on fixed X:y^3=F(x), represent it
by D-10O with D effective of degree10, and choose div(g)=2D-20O. On its
etale double w^2=g, the eight Prym differentials are

    h*(dx/y^2)/w,   h in L(26O-D).

Writing theta=dx/y^2 and H=h0(x)+h1(x)y+h2(x)y^2, their Cartier operator
is computed by

    C(h theta/w)=C_X(g^2 h theta)/w,
    C_X(H theta)/theta
      =y Cpoly(h0 F)+Cpoly(h1 F^3)+y^2 Cpoly(h2),

where Cpoly(sum a_i x^i)=sum a_(5j+4)^(1/5)x^j. Reduce g^2h modulo
y^3-F before applying the second formula. In ROW coordinates C(v)=
sigma^-1(v)M, use N1=M and N_(r+1)=sigma^-1(N_r)M; the required
polynomial is det(TI-N342), without inverting its nonzero eigenvalues.

Together with the actual carrier reduction, failure of all five divisors
excludes that carrier from the degree-two backup case. It does not exclude
an untested carrier, construct a second map, or solve the common-cover problem.

[Proof](../../../Proofs/jacobians/isogeny_sieves/backup_prym_cartier_factor_sieve.md) ·
[Focused audit](../../../Research/audits/PRYM_CARTIER_FACTOR_SIEVE_AUDIT_2026_09_11.md) ·
[Exact Cartier implementation](../../../scripts/arithmetic/fixed_x_prym_cartier.py).
