# Proof: actual anti-Cartier and the geometric twist test

2026-09-11. Author /root; independent focused audit
/root/audit_prym_cartier_sieve PASS. The inherited backup point counts,
absolute simplicity and geometric endomorphism field retain their prior
evidence scope; this audit does not re-prove all that arithmetic.

## 1. The actual eight-dimensional differential space

For fixed X, g=9, div(theta)=16O. If div(g)=2D-20O with degD=10 and
L=O(D-10O) nontrivial two-torsion, then X':w^2=g is connected and etale.
An anti-invariant differential is h theta/w. Its regularity is exactly
h in L(26O-D), and Riemann--Roch gives

    l(26O-D)=8+l(D-10O)=8.

The degree-two Jacobian/Prym splitting is prime to5, so this is the
Prym differential space. Since w^5=w g^2, the Cartier identity
C(f^5 omega)=f C(omega), with separable-pullback naturality, gives

    C_X'(h theta/w)=C_X(g^2h theta)/w.

Reduce polynomial coefficients modulo y^3=F. The identities
y^-2=(y^-1)^5 F and y^-1=(y^-2)^5 F^3 then give termwise

    C_X((h0+h1y+h2y^2)theta)/theta
        =y Cpoly(h0 F)+Cpoly(h1 F^3)+y^2 Cpoly(h2).

This uses the actual Riemann--Roch space, not an ambient coefficient
truncation presented as a space of regular forms.

With row coordinates the iterate matrices satisfy N_(r+1)=sigma^-1(N_r)M.
The Serre-dual coherent Frobenius has the same342-fold characteristic
polynomial. Nonzero eigenvalues are direct unit-root reductions, not their
inverses; see [Achter--Howe, Sections1.2 and2.4--2.5](https://www.math.colostate.edu/~achter/math/hwcm0618.pdf).

For any abelian variety A/F_(5^e), dimension a, its Weil polynomial satisfies

    W_A(T) mod5 = T^a h_A(T).

Indeed crystalline H1 is free, Frobenius modulo5 kills the Hodge subspace
H0(Omega1), and induces coherent Frobenius on its quotient H1(O).
Crystalline and etale Frobenius polynomials agree by
[Katz--Messing, Theorem1](https://web.math.princeton.edu/~nmk/old/katzmessing.pdf).
This argument does not require A ordinary or an integral isotypic splitting.

## 2. Bound every geometric twist, not only defined factors

The established backup arithmetic in
[quadrangular_genus_two_hecke_obstruction](../../Theorems/genus_two/quadrangular_genus_two_hecke_obstruction.md)
is

    W_B(T)=T^4-8T^3+182T^2-1000T+15625,
    End^0_geom(J(B))=K=Q(pi),

with B ordinary and absolutely simple. Over q=5^342 its Frobenius is
pi0=pi^114. If an eight-dimensional A/Fq has a geometric B factor, the
maximal B-isotypic component C is defined over Fq. Galois fixes its unique
central rational projector, since the isogeny type B is defined over Fq;
clearing denominators gives a defined abelian subvariety. Geometrically
C is isogenous to B^m, 1<=m<=4.

Choose such an isogeny phi over F_(q^r). In M_m(K), put
V=phi^-1 pi_C phi and U=pi0^-1 V. Then V^r=pi0^r I and pi0 is central,
so U^r=I. This retains the possible failure of phi to be defined over Fq.
Each eigenvalue zeta_n of U has [K(zeta_n):K]<=m. This is the usual
finite-field isogeny/endomorphism setting of
[Tate, Section3](https://pazuki.perso.math.cnrs.fr/index_fichiers/Tate66.pdf).

Here the Weil polynomial explicitly gives

    K=Q(sqrt21,sqrt(-25+sqrt21)).

The norm of -25+sqrt21 is604=4*151, whose square root is not in Qsqrt21.
Thus K is non-Galois and has just one quadratic subfield, Qsqrt21.
Its intersection with a cyclotomic field is therefore Q or Qsqrt21.
In the latter case ramification at3 and7 forces21|n, so phi(n)>=12 and
[K(zeta_n):K]=phi(n)/2>=6, impossible for m<=4. Consequently every
occurring cyclotomic polynomial is irreducible over K and has degree<=4.
The possible orders are1,2,3,4,5,6,8,10,12. The K-characteristic polynomial
of U is a product of the corresponding rational cyclotomic polynomials,
with their multiplicities, of total degree m.

## 3. The five exact divisibility tests

Modulo5 the backup polynomial is T^2(T-1)(T-2). Over Fq the unit-root
residues are1 and2^114=-1. Each degree-d cyclotomic block Phi_n of U
therefore contributes the ENTIRE factor

    (-1)^d Phi_n(T) Phi_n(-T)

to the ordinary part of W_C modulo5. For n=5,10 this is(T^2-1)^4;
fifth roots of unity are allowed to merge on reduction. The other orders
give precisely the five divisors in the statement.

The rational projector may have a denominator divisible by5. That causes
no loss of multiplicity: W_C divides W_A in Z[T], and, since C is ordinary,

    W_C mod5=T^(2m) h_C,  h_C(0)!=0.

Comparison with W_A mod5=T^8 h_A implies h_C divides h_A in F5[T].
Thus at least one displayed block divides h_A. No integral decomposition
of H1(O_A) by that projector has been used.

## 4. Reproducibility and scope

scripts/arithmetic/fixed_x_prym_cartier.py computes the actual anti-form space by
intersecting the verified Khuri--Makdisi divisor matrix with L(26O).
It recovers the actual trivialization from products, checks dimension8,
and verifies every Cartier output lies in that same space. A divide-and-
conquer semilinear norm is checked independently against direct iteration.

The base audit independently compares all9 regular differentials on X with
Sage's function-field Cartier implementation, then checks the resulting
Frobenius25 characteristic polynomial against the established Weil polynomial.
It passed in0.318s, including direct-versus-fast iterates through13.
This is an arithmetic implementation check, not the geometric factor proof.

The complete factor sieve is necessary only. Carriers passing it require
additional work. The original same-source two-leg reduction is preserved
by [backup_degree_two_prym_reduction](../../Theorems/genus_two/backup_degree_two_prym_reduction.md).
