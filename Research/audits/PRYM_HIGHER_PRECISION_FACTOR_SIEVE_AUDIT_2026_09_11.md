# Higher-precision geometric backup factor sieve

Verdict: PASS at every precision5^s, with all nine cyclotomic orders
retained before deduplication. At s=2 they give exactly six distinct
filters. Auditor: /root/audit_toric_prym_normalization.
Date: 2026-09-11. This is a bounded arithmetic/prose audit, not Lean.
No canonical theorem was modified and no carrier exclusion was replayed.

## Inherited inputs and exact scope

The audited theorem `backup_prym_cartier_factor_sieve`, especially
Sections2--3 of its canonical proof, supplies the following facts.

The backup B is defined over F125, ordinary, and geometrically absolutely
simple, with End^0_geom(B)=K=Q(pi) and Weil polynomial

    W_B(T)=T^4-8T^3+182T^2-1000T+15625.

If A/F_q, q=5^342, has dimension8 and contains B up to GEOMETRIC
isogeny, its maximal B-isotypic abelian subvariety C is defined overF_q.
Geometrically C is isogenous to B^m for1<=m<=4. After such an isogeny,
its Frobenius is pi^114 U with U in GL_m(K) of finite order. The
K-characteristic polynomial of U is a product, with multiplicities,
of the rational polynomials Phi_n, for

    n in N={1,2,3,4,5,6,8,10,12},
    sum_n e_n*phi(n)=m.

Those cyclotomic polynomials remain irreducible over K. This audit
accepts the canonical proof of that bounded list and the descent of C;
it does not repeat the earlier geometric argument or the backup's
arithmetic certification.

Write H_A(T) for the MONIC characteristic polynomial of the unit roots
of q-Frobenius, with roots equal to the eigenvalues themselves. For an
ordinary A here it has degree8. This differs from the reciprocal
convention det(1-T*F): a characteristic-polynomial computation uses
det(T*I-F). The filters below use the monic convention.

## Integral unit-factor divisibility

No integral cohomological projector is required. Because C is an actual
defined abelian subvariety, D=A/C is defined overF_q and

    W_A=W_C*W_D in Z[T].

For any monic Weil polynomial W, write its reduction uniquely as

    W mod5 = T^b*h(T), h(0)!=0.

The two monic factors are coprime, so Hensel factorization gives unique
monic factors in Z5[T], one reducing to T^b and the other to h. They
are respectively the positive-valuation and unit-root factors. Repeated
roots INSIDE h cause no problem: only gcd(T^b,h)=1 is needed.

Uniqueness applied to products therefore gives

    H_A=H_C*H_D in Z5[T].

In particular H_C divides H_A integrally, even when the rational
isotypic projector has denominator divisible by5. This argument also
works for nonordinary A if its actual unit-root polynomial is supplied;
the eight-dimensional toric formula under present use assumes ordinary A.

## The complete cyclotomic factors

The two roots of W_B reducing to1 and2 modulo5 are simple, so there
are unique Hensel lifts r1,r2 in Z5. Put

    v_i=r_i^114 in Z5^*, i=1,2.

These are the two unit embeddings of pi^114. Its other two embeddings
have positive valuation342. For d=phi(n), define

    F_n(T)=product_(i=1,2) v_i^d*Phi_n(T/v_i).

This is a monic degree2d polynomial in Z5[T], with unit constant term.
For implementation, if Phi_n(T)=sum_j c_j T^j, evaluate each factor as

    sum_(j=0..d) c_j*v_i^(d-j)*T^j.

Thus no division or extension containing roots of unity is necessary.
In particular primitive fifth roots need not lie in an unramified
extension of Q5; their symmetric cyclotomic polynomial is what is used.

Under each of the two unit embeddings of K, every cyclotomic block of
U contributes all d roots v_i*zeta with zeta primitive of ordern.
The nonunit embeddings contribute no unit roots. Consequently

    H_C(T)=product_n F_n(T)^e_n in Z5[T].

At least one entire F_n therefore divides H_A. This remains true modulo
5^s for every s>=1, with full multiplicity, including n=5 and10.
Their primitive roots can merge modulo5; that never licenses replacing
the factor by its radical. Orders5,8,10,12 have d=4, so each is a
degree8 EQUALITY test when H_A has degree8.

Polynomial remainder is a valid exact test over Z/5^s despite its zero
divisors, because each divisor F_n is monic. Failure of all orders
excludes a geometric B factor; success is only a necessary condition.

## Exactly six filters modulo25

Hensel lifting gives

    (r1,r2)=(1,7) mod25,
    (v1,v2)=(1,-1) mod25.

Hence the nine orders collapse to the following six polynomials:

| Orders | Required monic factor modulo25 |
| --- | --- |
| 1,2 | T^2-1 |
| 3,6 | T^4+T^2+1 |
| 4 | (T^2+1)^2 |
| 5,10 | T^8+T^6+T^4+T^2+1 |
| 8 | (T^4+1)^2 |
| 12 | (T^4-T^2+1)^2 |

For5,10 the integer identity is Phi_5(T)*Phi_5(-T)
=sum_(j=0..4)T^(2j). Only modulo5 does this equal(T^2-1)^4.
Modulo25 it is NOT divisible by T^2-1: its values at1 and-1 are5.
Accordingly the original five integer expressions alone are insufficient
at two digits. The sixth degree8 filter must be included, unless its
full modulo5 multiplicity has already excluded it for that carrier.

## Modulo125 and arbitrary precision

The next lifts are

    (r1,r2)=(51,82) mod125,
    (v1,v2)=(76,74) mod125.

In particular v1+v2=25 and v1*v2=-1 modulo125, giving

    F_1=T^2-25T-1,
    F_2=T^2+25T-1 mod125.

They are distinct. The3/6 and5/10 pairs separate as well, so all nine
orders must be constructed for the arbitrary-precision routine. Any
deduplication must use the actually calculated coefficients at that
precision, not the modulo25 table.

The displayed roots and powers were independently replayed by a tiny
standard-library integer Hensel check through125: all root remainders
were zero, and modular powers returned(1,24) modulo25 and(76,74)
modulo125. This was not a production curve computation.

## Quadratic twists and the carrier handoff

The full filter family is invariant under H_A(T)->H_A(-T), which is
the effect of a quadratic twist on its even-degree unit-root polynomial.
Indeed F_n(-T)=F_(iota(n))(T), with

    1<->2, 3<->6, 5<->10, and4,8,12 fixed.

At higher precision the individual polynomials in the paired orders
need not be even. The family, rather than every individual filter, is
what remains invariant. Thus a preceding nonsquare Kummer rescaling
does not alter the ALL-ORDERS geometric rejection criterion at any
precision. Its quadratic character must still be retained when
comparing the finite-field polynomial with a particular saved Prym.

The toric matrix computation and its passage to projective unit roots
are treated separately in
[the toric normalization audit](TORIC_PRYM_NORMALIZATION_AUDIT_2026_09_11.md).
This arithmetic audit does not verify the parent computation for any
specific carrier, its saved matrix, or its proposed remainder verdict.
