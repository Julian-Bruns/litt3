# Quadratic-Q toric Prym normalization audit

Verdict: PASS for the stated coprime quadratic-Q chart, with explicit
boundary checks retained. Auditor: /root/audit_toric_prym_normalization.
Date: 2026-09-11. This is a bounded geometric/prose audit, not Lean and
not an exclusion of any fixed-X carrier.

The audited inputs are the actual geometrically irreducible genus8
quartic carriers in `cyclic_trigonal_kummer_carriers`. No second map or
common-cover conclusion is supplied here. No production computation was
run by this auditor.

## Polynomial normalization

Work over a perfect field K of characteristic5, with F squarefree. Suppose

    P^3+F Q^3=R^2,
    degF=10, degQ=2, degP<=6, degR<=9, gcd(P,Q)=1.

Write h=lc(Q), and let p be the degree<=1 representative of R/P modQ.
Then p is invertible modQ and p^2=P modQ. Set

    A=(p^2-P)/Q,
    B=(p^3+2Pp+2R)/Q^2,
    C=(p^4+4Pp^2-2Rp+2P^2)/Q^3.

All three quotients are polynomials. In fact P=p^2-QA and the norm
identity moduloQ^2 forces

    R=p^3+pQA+3Q^2B.

Substitution in the constant numerator gives Q^2(2A^2-pB).
Substitution in R^2-P^3 gives

    Q^2 p^2(3A^2+pB)+Q^3(A^3+pAB)+4Q^4B^2.

Since p is a unit modQ, the norm identity now forces

    QC=2A^2-pB,
    F=A^3+pAB-p^2C+4QB^2.

These computations prove divisibility by Q^2 and Q^3 using only the
residue p modQ. Squarefreeness of Q is unnecessary for these algebraic
identities; coprimality is necessary for this proof.

The substitution Z=Qw-p in the actual quartic gives exactly

    (Z^4+4PZ^2+2RZ+2P^2)/Q^3
      =Qw^4+pw^3+Aw^2+Bw+C=:g(x,w).

The inverse over the function field is w=(Z+p)/Q. Moreover gcd(Q,p)=1,
so g is primitive as a polynomial in w over K[x]. The canonical geometric
irreducibility over K(x) therefore gives geometric irreducibility of
this affine model.

## Infinity when degP=6

Put k=lc(R)/lc(P). The x^18 norm coefficient implies lc(P)=k^2 and
lc(R)=k^3, so no square-root extension is required. Write P5=[x^5]P,
P4=[x^4]P, R8=[x^8]R, R7=[x^7]R, and F10=lc(F). The next two norm
coefficients give

    R8=4kP5,
    2k^3R7=3k^4P4+2k^2P5^2+F10 h^3.

Set lambda=k/h and w=z-lambda*x. The five coefficients, in descending
powers of z, are

    Q,
    p+lambda*x*Q,
    A+lambda^2*x^2*Q+2lambda*x*p,
    B+3lambda*x*A+3lambda^2*x^2*p+lambda^3*x^3*Q,
    C-lambda*x*B+lambda^2*x^2*A-lambda^3*x^3*p
       +lambda^4*x^4*Q.

Their degree bounds are respectively 2,3,3,3,4. To see every required
cancellation, the z^2 coefficient has zero x^4 term, the z coefficient
has zero x^5 term and x^4 coefficient

    (2R8-3kP5)/h^2=0,

and the constant coefficient has zero x^6 term and x^5 coefficient

    (3k^2P5-2kR8)/h^3=0.

Its x^4 coefficient simplifies to

    (3k^2P4+2P5^2-2kR7)/h^3=-F10/k^2 !=0.

The x^3*z^3 coefficient is k!=0. In particular neither the leading
coefficient of p nor P5 forces a further constant translation. A
constant translation is optional and preserves these degree bounds.

The support therefore lies in

    Delta6=conv{(0,0),(4,0),(3,3),(2,4),(0,4)}.

## Infinity when degP<=5

The norm identity gives degR=8 and lc(R)^2=F10*h^3. No shift is needed.
The raw coefficient degrees of w^4,w^3,w^2,w,1 are at most2,1,3,4,4.
Thus a slightly sharper polygon than originally proposed is

    Delta5=conv{(0,0),(4,0),(4,1),(2,4),(0,4)}.

It is contained in the originally proposed polygon with vertices
(0,0),(5,0),(4,1),(2,4),(0,4). Each of these bounds has eight interior
lattice points. In both charts the interior set is the same:

    J={(1,1),(2,1),(3,1),(1,2),(2,2),(3,2),(1,3),(2,3)}.

## What genus equality certifies

Let Delta be the ACTUAL Newton polygon of the normalized polynomial.
Its toric closure C is a Cartier divisor on the normal projective toric
surface X_Delta. Every vertex coefficient is nonzero by the definition
of Delta, so C avoids all toric fixed points. Those points contain the
singular locus of a normal toric surface; C lies in its smooth locus.

The divisor arithmetic genus is the number of interior lattice points.
Indeed chi(O_X)=1 and toric Riemann--Roch with Ehrhart reciprocity gives
chi(O_X(-C))=#Int(Delta), so chi(O_C)=1-#Int(Delta). This computation is
characteristic independent and does not assume nondegeneracy. For the
standard arithmetic-genus formula see also [Lang--Tyomkin, A note on the
Severi problem for toric surfaces](https://link.springer.com/article/10.1007/s00208-022-02374-z),
Section2.2; that paper itself works in characteristic zero.

The actual curve has geometric genus8 by the canonical carrier theorem,
while support containment gives at most8 interior points. The
normalization genus is at most the arithmetic genus, so Delta has
exactly those eight interior points and p_a(C)=g(C)=8. The sum of local
delta invariants is zero. Thus C is already smooth geometrically.

Smoothness alone DOES NOT imply boundary transversality. For each
actual edge e, write its face polynomial, after removing a monomial,
as h_e(t), where t uses the primitive lattice direction of e. Check

    gcd(h_e,h_e')=1 in K[t,t^-1].

This certifies transverse intersection with that boundary orbit. The
endpoints are nonzero, so one can normalize h_e to have nonzero constant
coefficient and use an ordinary polynomial gcd. This also handles
characteristic5 exponents correctly. For primitive direction (a,b),
at least one of a,b is nonzero modulo5, so this test is equivalent to
the two logarithmic derivative tests on that edge.

Together with the smoothness just proved and the automatic vertex-face
condition, these edge checks prove full Newton nondegeneracy of the
ACTUAL polynomial. No generic nondegeneracy claim, or two-variable
smoothness Groebner computation, is needed. Repeated roots of Q can
obstruct this boundary test even though the polynomial divisions hold.

## Interior higher Hasse--Witt matrix and the projective unit roots

Let the certified curve be defined over F_q, q=5^a. Lift the FINAL
normalized polynomial coefficientwise to R=W(F_q), preserving support;
write the lift as G. Let sigma be Witt Frobenius, sigma^a=1, and set

    alpha_s[u,v]=[x^(5^s*v1-u1) z^(5^s*v2-u2)] G^(5^s-1), u,v in J.

Assume det(alpha_1 mod5)!=0. The congruence is

    U=alpha_2*sigma(alpha_1)^(-1) mod25.

The coefficient congruence is [Vlasenko, Higher Hasse--Witt matrices,
Theorem1](https://arxiv.org/pdf/1605.06440). The geometric conclusion
below uses the later theorem, rather than its original conjectural
interpretation.

Precisely, [Beukers--Vlasenko, Dwork Crystals I](https://arxiv.org/pdf/1903.11155),
Theorem5.3, equation(12), supplies the limit matrix and its precision.
Theorem6.1 gives the face-block filtration. Corollary5.8 gives vertex
blocks. AppendixA, TheoremA.1 and RemarkA.2, identify the FULL-polytope
determinant with the affine zeta unit part and explicitly give the
ordered matrix product Lambda*sigma(Lambda)*...*sigma^(a-1)(Lambda),
whose transpose is q-Cartier. The passage from full to interior in this
case is the following boundary cancellation.

First every squarefree edge polynomial has invertible interior
Hasse--Witt matrix. Indeed, for degree m with nonzero endpoints, the
forms t^(u-1)dt/h_e(t), 1<=u<=m-1, form the logarithmic differential
space on P1 with poles at its m roots. Residues identify this space
with the vectors whose sum is zero. Cartier acts on residues by fifth
roots, so is bijective. Its matrix is the inverse-Frobenius transpose
of the edge coefficient matrix. The vertex matrices are units as well.
Consequently the interior invertibility assumption and Theorem6.1
imply full-polytope invertibility.

For an edge e write

    E_e(T)=product over its closed boundary points of (1-T^degree).

All those points are reduced by the edge checks. Denote each relevant
q-Cartier determinant by D. Applying the one-variable affine formula
to h_e gives

    D_full,e=(1-T)*E_e(T).

Each of its two vertex determinants is 1-T: their scalar Frobenius
ratios telescope since sigma^a=1. Hence

    D_interior,e=E_e(T)/(1-T).

There are equally many vertices and edges in a polygon, so the product
of all its boundary-block determinants is exactly product_e E_e(T).
Let P_unit(C,T) be the slope-zero factor of the smooth projective
curve's numerator. Deleting its boundary points gives

    Z(C intersect T^2,T)_unit
      =P_unit(C,T)*product_e E_e(T)/(1-T).

The two-variable full-polytope formula gives the same expression as
D_full,Delta/(1-T). Cancelling boundary blocks proves

    D_interior,Delta=P_unit(C,T).

Therefore the concrete eight-by-eight answer modulo25 is

    P_unit(C,T)=det(1-T*U*sigma(U)*...*sigma^(a-1)(U)) mod25.

For a=342 the last twist is sigma^341. There is no inverse of U and
no reversal of this ordered product. Transposing the whole product
does not change its characteristic polynomial. Its determinant
polynomial is fixed by sigma, providing a useful arithmetic check.

These statements require actual ordinariness and actual edge checks;
they do not certify either condition for an untested carrier. They
identify the projective Jacobian unit roots, with no remaining toric
boundary factors. Full mod25 factor rejection is a further computation
and is not asserted by this audit.

All finite-field Frobenius claims refer to the ACTUAL displayed quartic
and its birational normalization G. A preceding nonsquare rescaling of
P,Q can change the finite-field quadratic twist of the Kummer double.
Comparison with a previously saved Prym matrix must retain that
quadratic character; geometric isogeny alone does not identify their
finite-field Frobenius polynomials. The present audit did not replay
the norm-recovery scalar or the parent agent's actual matrix comparison.

An arbitrary lift of the coefficient field's defining polynomial
requires the TRUE unramified Frobenius lift on its generator. Mapping
that generator naively to its fifth power generally fails modulo25.
The characteristic5 norm and polynomial-division formulas above should
not be presumed valid after lifting P,Q,R to characteristic25; lift G
itself. No lift of the original double or the A4 construction is needed
for computing the good-reduction curve's Frobenius this way.
