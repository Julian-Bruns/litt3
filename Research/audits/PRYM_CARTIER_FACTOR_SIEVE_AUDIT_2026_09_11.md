# Focused audit: actual double-cover Cartier and backup factor sieve

Verdict: PASS for the formulas and the necessary five-divisor criterion below.
Auditor: /root/audit_prym_cartier_sieve. Date: 2026-09-11.
Objections: none after specifying matrix orientation, the actual CM-field
intersection argument, and characteristic-polynomial reduction with multiplicity.
This is a bounded prose audit, not a carrier computation or Lean verification.

Inputs retained: the fixed smooth genus-nine X, an ACTUAL nonzero two-torsion
class and its etale double, and the backup B's ordinary absolutely simple
Jacobian with geometric endomorphism algebra K=Q(pi) and Weil polynomial
T^4-8T^3+182T^2-1000T+15625. The latter arithmetic input is recorded in
[the canonical backup theorem](../../Theorems/Thm_quadrangular_genus_two_hecke_obstruction.md);
its point counts and original absolute-simplicity check were not re-audited here.

## 1. Actual anti-invariant Cartier space

Write X:y^3=F(x), deg(F)=10, theta=dx/y^2, div(theta)=16O. If
div(g)=2D-20O with deg(D)=10 and [D-10O] nonzero in J(X)[2], the
connected etale double X':w^2=g has exactly the anti-invariant regular forms

    h theta/w,   h in L(26O-D).

Indeed div(w) is the pullback of D-10O, and etaleness makes the differential
divisor pull back without a different. Riemann--Roch gives
l(26O-D)=8+l(D-10O)=8; the last summand is zero for a nontrivial degree-zero
line bundle. This is the eight-dimensional Prym differential space. The
degree-two Jacobian/Prym splitting has degree prime to 5.

Since w^5=wg^2 and Cartier commutes with separable pullback,

    C_X'(h theta/w) = C_X(g^2 h theta)/w.

For the normal form H=h0(x)+h1(x)y+h2(x)y^2, define
Cpoly(sum a_i x^i)=sum_j a_(5j+4)^(1/5) x^j. Then

    C_X(H theta)/theta
      = y Cpoly(h0 F) + Cpoly(h1 F^3) + y^2 Cpoly(h2).

This follows termwise from y^-2=(y^-1)^5 F,
y^-1=(y^-2)^5 F^3, and C(f^5 omega)=f C(omega).
In the application first reduce g^2h modulo y^3-F; then express the
output in the actual eight-dimensional Riemann--Roch basis. Truncating an
ambient polynomial space is not a substitute for that basis calculation.

## 2. Matrix convention and direct unit roots

Let k=F_(5^e), sigma(a)=a^5, tau=sigma^-1. With COLUMN coordinates
C(v)=M tau(v), its k-linear e-fold iterate is

    N = M tau(M) ... tau^(e-1)(M).

In the Serre-dual basis, Frobenius has matrix (sigma(M))^t and its e-fold
iterate is N^t. With ROW coordinates C(v)=tau(v)M, use instead

    N_1=M,   N_(r+1)=tau(N_r)M,
    N_e=tau^(e-1)(M) ... tau(M) M.

These conventions give the same characteristic polynomial. Use e=342 here.
The nonzero roots of h_A(T)=det(TI-N_e) are DIRECT reductions of unit
Frobenius roots; they are not inverted. Roots of det(I-TN_e) use the
reciprocal convention. See [Achter--Howe, Sections 1.2, 2.4--2.5](https://www.math.colostate.edu/~achter/math/hwcm0618.pdf).

For any abelian variety A/k of dimension a,

    W_A(T) mod 5 = T^a h_A(T),

where W_A is its degree-2a Weil polynomial and h_A is the characteristic
polynomial of F^e on H^1(A,O_A). One way to see this for arbitrary A is to
reduce its free crystalline H^1 modulo 5: Frobenius kills H^0(Omega^1),
and the induced operator on the Hodge quotient is coherent Frobenius.
The crystalline and etale characteristic polynomials agree by
[Katz--Messing, Theorem 1](https://web.math.princeton.edu/~nmk/old/katzmessing.pdf).
Thus the assertion applies even when A is nonordinary. In particular h_A
has coefficients in F5. A single Cartier rank is not the required test.

## 3. Geometric factors give a finite-order matrix over K

Put q=5^342 and pi0=pi^114, the Frobenius of B over F_q. Suppose an
eight-dimensional A/F_q has J(B) as a geometric isogeny factor. Its maximal
geometric J(B)-isotypic component C is defined over F_q: Galois fixes this
isogeny type because B is defined over F_q, hence fixes its unique central
isotypic projector. Clearing denominators gives a defined abelian subvariety.
Geometrically C is isogenous to J(B)^m for some 1<=m<=4.

Choose a geometric isogeny phi:J(B)^m->C defined over F_(q^r), and set

    V=phi^-1 pi_C phi in M_m(K),   U=pi0^-1 V.

Naturality over that finite extension gives V^r=pi0^r I. The scalar pi0
is central because K is commutative, so U^r=I. No commutation of an arbitrary
geometric isogeny with pi_C over F_q has been assumed. Each eigenvalue
zeta_n of U therefore satisfies [K(zeta_n):K]<=m, initially giving
phi(n)<=4m<=16. This validates the originally proposed weaker eigenvalue sieve.
The finite-field endomorphism and factor framework is
[Tate, Section 3, Theorems 1(b) and 2](https://pazuki.perso.math.cnrs.fr/index_fichiers/Tate66.pdf).

## 4. The smaller cyclotomic bound is proved for this K

Let s=sqrt(21). From the displayed Weil polynomial,
pi+125/pi=4+2s after choosing s, and

    K=Q(s, sqrt(-25+s)),   Norm_(Q(s)/Q)(-25+s)=604=4*151.

This quartic field is not Galois over Q. If the conjugation of Q(s)
extended to K, the two square classes -25+s and -25-s would agree over
Q(s), forcing sqrt(604) into Q(s), which is false. Here neither negative
element can be a square in the real field Q(s). A non-Galois quartic field
with a quadratic subfield has no second quadratic subfield.

Consequently K intersect Q(zeta_n) is either Q or Q(s), since a cyclotomic
subfield is abelian over Q. In the latter case ramification at 3 and 7
forces 21|n, hence phi(n)>=12 and
[K(zeta_n):K]=phi(n)/2>=6. Such a root cannot occur in U with m<=4.
Thus every occurring zeta_n has phi(n)<=4 and K intersect Q(zeta_n)=Q.
The possible orders are exactly 1,2,3,4,5,6,8,10,12. Each corresponding
Phi_n remains irreducible over K, so charpoly_K(U) is a product of these
rational cyclotomic polynomials, with multiplicities.

## 5. Exact necessary five-divisor criterion

The backup polynomial modulo 5 is T^2(T-1)(T-2). Its two unit roots over
F_q reduce to 1 and 2^114=-1. A degree-d cyclotomic block Phi_n in U therefore
contributes to the ordinary part of C the complete factor

    h_n(T)=(-1)^d Phi_n(T) Phi_n(-T) mod 5.

Both embeddings and all multiplicities are retained. For n=5 or 10 this
is (T^2-1)^4; reduction of fifth roots of unity is allowed to merge roots.
It follows that h_A(T), of degree eight, must be divisible in F5[T] by at
least ONE of

    T^2-1,
    T^4+T^2+1,
    (T^2+1)^2,
    (T^4+1)^2,
    (T^4-T^2+1)^2.

The last two tests are equality tests because both divisors have degree eight.
If none divides h_A, J(B) is not a geometric isogeny factor of A.

Denominators divisible by 5 in projectors do not invalidate this argument.
Since C is defined over F_q, its monic integer Weil polynomial W_C divides
W_A in Z[T]. C is ordinary, so W_C mod 5=T^(2m)h_C with h_C(0)!=0.
Together with W_A mod 5=T^8 h_A this implies h_C divides h_A. The cyclotomic
calculation factors h_C with multiplicity. No integral splitting of de Rham
cohomology by rational idempotents is required.

Verification in this audit: independent algebraic derivation of both Cartier
identities, both matrix conventions, isotypic descent, the finite-order ratio,
the CM subfield argument, and the five-divisor criterion. A Python-standard-
library check replayed all nine cyclotomic block products, the backup
factorization modulo 5, and 2^114=4 modulo 5. No carrier enumeration, actual
Prym matrix, or numerical exclusion was executed by this auditor.

A carrier passing this necessary sieve is not proved to contain J(B).
The original common-cover problem remains unsolved, and both actual etale
maps from the same source remain required by the surrounding reduction.
