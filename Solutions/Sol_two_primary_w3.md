# Proof record: Odd trigonal pencils, two-primary W3, and three-point tensors

Canonical statement: [`two_primary_w3`](../Theorems/Thm_two_primary_w3.md).
Migrated 2026-09-06; hypotheses restated below are proof context.
The canonical statement and registry control promoted scope and evidence.

---

# Odd trigonal maps, two-primary W3, and a three-point Cartier obstruction

Author: /root, 2026-09-06. Status: independently audited PASS, including
certificate replay, by `/root/contact_bound_to_core_audit`, 2026-09-06;
[audit record](../routes/global/audits/ENDPOINT_TWO_PRIMARY_LOW_DEGREE_TORSION_AUDIT_2026_09_06.md).
The parameterized mechanisms are the trace-bundle bound and the two-step
Frobenius criterion. W3 is a test/application, not their definition.
The old W2 note now retains only the short two-point corollary needed by
existing proof links; its duplicate proof and calculation were removed.

## 1. A trace-bundle bound for independent pencils

Let x:C->P1 be a degree-three map in characteristic different from three,
and suppose its trace-zero bundle is

    ker(Tr:x_*O_C->O_P1)=O(-a) direct_sum O(-b), a<=b.

Every function f not in k(x) has degree at least b.

Proof. Since 3 is prime, x and f give a birational map to their image
Gamma in P1 x P1. If deg f=e, Gamma has bidegree(e,3), with projection
to the x-line finite flat of degree3. Push forward
0->O(-e,-3)->O->O_Gamma->0 along that projection. Its trace-zero bundle
is O(-e)^2: the resulting exact sequence has quotient O(-e)^2 and
the trace splits off O. Normalization induces a generically full-rank
injection

    O(-e)^2 -> O(-a) direct_sum O(-b).

If e<b, both components mapping to O(-b) vanish, since
Hom(O(-e),O(-b))=H0(O(e-b))=0. The injection then has rank at most one,
a contradiction. QED.

Suppose in addition every ramification index of x is odd and 2r<b.
Then W_r(C,O) is disjoint from every translate by nonzero J(C)[2].
Indeed, if a=[E-rO], a+tau=[F-rO] lie in W_r and 2tau=0, the function
with divisor 2(F-E), after cancelling common support, has degree<=2r.
The pencil bound makes it R(x). As all local indices of x are odd,
every valuation of R is even. Thus R is a square in k(x), and F-E
is principal, so tau=0. This argument concerns classes, not uniqueness
of effective divisors within a pencil.

For the curve y^3=F_10(x) in file76 the trace-zero splitting is (-4,-7).
On the affine x-line it is spanned by y,y²; at infinity its integral
basis is y/x^4,y²/x^7, with distinct valuation residues2,1 modulo3.
This proves the splitting. All ramification indices are1 or3. Thus
the disjointness statement applies to r=3, since6<7.

## 2. A stronger finite-field torsion criterion

Let A be an abelian variety over a finite field of odd characteristic,
W a closed Frobenius-stable subvariety containing zero, and suppose W
is disjoint from all its nonzero A[2]-translates. Suppose a Frobenius
power M satisfies

    M-I=2U on T_2A, with both U and I+U invertible.

Then W intersect A[2^infinity]={0}.

Proof. M²-I=4U(I+U) is four times a unit. By the checked finite-field
translation lemma, any two-primary a in W outside A[4] would have
an M²-power translate a+tau also in W, with 0!=tau in A[2]. Thus
a lies in A[4]. If its order is four, (M-I)a=2Ua is nonzero of order
two, another forbidden translate within W. If its order is two, it
already gives a forbidden translate between a and0. Hence a=0.

More generally, if M-I=2^s U for s>=2 and U invertible, the same
translation argument puts all such W-torsion in A[2^s]. Thus proving
W intersect A[2^s]={0} is another sufficient criterion; no two-step
factorization is required in this version.

For the fixed J(X), take M=pi^171, where pi is F25-Frobenius. In the
quotient by its actual Weil polynomial P, the remainder modulo4 is

    T^171-1 = 2(T17+T16+T14+T10+T8+T7+T6+T2+T) mod(P,4).

P mod2 is irreducible of degree18. The displayed degree17 polynomial
and its sum with one are both nonzero modulo P, hence units. As in
the checked W2 proof, Cayley--Hamilton and Bezout give the asserted
integral endomorphism property on the ACTUAL Tate module. Therefore

    W_3(X,O) intersect J(X)[2^infinity]={0}.           (1)

No companion-matrix identification, extension-field point enumeration,
or independence of a Galois orbit is assumed.

## 3. Uniform three-point tensors: one remaining one-variable test

Suppose s is a weight d=3g0 regular tensor on X, where g0 is a power
of two, and

    div(s)=16g0 E,  E reduced of degree3.

Since div(theta)=16O for theta=dx/y², the relation implies
16g0[E-3O]=0. By (1), E is linearly equivalent to3O. The pencil
L(3O)=span(1,x) shows E=x^*(c) for some finite c with F_10(c)!=0;
the infinity and cubic branch fibers are not reduced of degree3.
Consequently, up to a nonzero scalar,

    s=s0^g0,  s0=(x-c)^16 theta³
               =(x-c)^16/F_10(x)^2 (dx)³.           (2)

This tensor can NEVER satisfy its eligible generalized-Cartier-zero
condition. For weight3, that condition is C_1(s0²)=0. The fifth-power
rule shows it is equivalent to

    C(F_10(x)(x-c)^32 dx)=0.                          (3)

Let a in F25 satisfy a²+4a+2=0 as in file76. The coefficients of x^34
and x^39 in the polynomial in (3) are respectively

    u(c)=(a+3)c7+(2a+3)c6+(2a+4)c5
                    +(3a+4)c²+3ac+3a+3,
    v(c)=(4a+2)c²+(3a+2)c+3a+1.

They cannot vanish together: exact division gives

    u mod v=(2a+1)(c+1),   v(-1)=4a+1!=0.

Thus (3) is impossible over the ENTIRE algebraic closure.
For general g0, choose r in {1,2,3,4} with dr=1 mod5 and write
g0 r=2+5j, j>=0. The generalized Cartier fifth-power rule identifies
the image of s^r with s0^j times the nonzero image of s0².
Hence its Cartier image is nonzero as well.

Both the Frobenius remainder and coefficient identities are checked by
the [short exact certificate](../routes/global/GENUS9_W3_CARTIER_CERTIFICATE.sage).

## 4. Application and boundary

Every two-branch atlas produces a uniform Cartier-zero tensor

    s=F^*((dz)^d/z^(d-1)), d=other tame inertia order.

To check Cartier zero directly, choose rd=1 mod5. The coefficient of
((dz)^d/z^(d-1))^r has exponent r(1-d)=r-1 mod5, never4; ordinary
Cartier therefore kills it. The claim follows by pullback.

The single-wild-jump signature family (q,j,t0,m,D)=(5,2,1,3,16)
has d=3g0 and div(s)=16g0 E with E reduced degree3. Section3 therefore
eliminates this ENTIRE family, for all its possible tame factors g0.
The two-point family D8,m1 is already excluded by the checked W2 theorem.

The same three-point obstruction applies to any coreless primitive
invariant of this specified shape: its degree3g0 does not divide4, so
the retained coreless Cartier theorem would require the impossible
vanishing. Other supports and weights are not excluded here.
