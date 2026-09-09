# Hyperelliptic roots have explicit etale quotients and Cartier tests

Version2,2026-09-09. Author proof, not independently audited.
Let k be algebraically closed of odd characteristic p. Let

    Y: v²=F(u),  deg F=2g+1, g>=2,
    q=P(u)(du/v)², deg P=2g-2,

where F,P are squarefree and coprime. Thus q has simple zeros.
Use smooth projective normalizations throughout. Put

    B: v²=F(u), w²=P(u),
    C: z²=F(u)P(u),       E: w²=P(u).

1. B is the canonical quadratic root of q, of genus4g-3. The map
   h:B→C, z=vw, is finite ETALE of degree2. The curve C has genus2g-1,
   E has genus g-2, and a prime-to-p isogeny gives

       J_B ~ J_Y x J_E x J_C.

   The root form alpha=w du/v descends to alpha_C=P du/z. Its divisor
   is twice the reduced sum of the2g-2 branch points of C above P=0.
   In particular, for g=2 the root Prym is isogenous to the explicit
   GENUS-THREE Jacobian J_C; E is rational.

2. Suppose an ACTUAL coreless finite etale span X←Z→Y matches q with
   a regular quadratic q_X on X. Let A be the canonical root of q_X.
   The common root W→Z is connected, and the induced span

       A ← W → C

   is again coreless with BOTH maps finite etale. The forms agree.
   Here g(A)=4g(X)-3. The map A→X is RAMIFIED: this does not give a
   new etale cover of the original X by replacing A with X.

3. Write m=2g-2, P=sum a_j u^j. The root form is Cartier-fixed exactly
   when the following m+1 equations hold:

       [u^(pi+p-1)] F^((p-1)/2) P^((p+1)/2)=a_i^p,
       i=0,...,m.                                      (Q)

   With F fixed, this invariant quadratic-eigenform scheme has length
   p^(2g-1), including all multiplicities and bad-divisor boundary points.
   At a point with P squarefree, coprime to F, and of full degree,
   its tangent dimension is a(C), the Cartier-kernel dimension of C.
   It is reduced there exactly when C is ordinary.

4. For the FULL quadratic-eigenform scheme on Y, including the
   non-hyperelliptic-invariant quadratic directions when g>2, the
   tangent dimension at this q is a(E)+a(C). Its scheme length is
   p^(3g-3). Thus these two ordinary tests coincide in genus two but
   must not be identified in higher genus.

For g=2,p=5, (Q) uses only the coefficients u^4,u^9,u^14 of F²P³.
Its Jacobian is a nonzero scalar times the THREE-by-THREE Cartier
coefficient matrix of z²=FP. For split admissible active indigenous
data, the existing inverse-character criterion identifies this with
the endpoint ordinary test. It does not test an arbitrary common source.

## Nonsplit genus-two quartics have a genus-five quotient

Now p=5,g=2. Let s=A(u)(du/v)^4 be a normalized active admissible
quartic with div(s)=2D, D reduced, and with nontrivial Hasse root class.
The hyperelliptic invariance theorem makes A a polynomial. Choose a
Weierstrass point outside D as infinity. Then

    F=RS, A=R H²,

after absorbing a nonzero scalar into R or H. Here R,S are squarefree,
R divides F, b=deg R is2 or4, deg H=2-b/2, and H is squarefree and
coprime to F. Use the actual factorization, so the scalar is retained.
The canonical fourth-root curve B, with w^4=A and v²=F, has genus9.
The diagonal involution (v,w)↦(-v,-w) acts freely. Its genus-five
quotient C has the explicit cyclic equation and descended root form

    C: z^4=R S² H²,             alpha_C=H du/z.

The inverse root-character Cartier block has basis

    S H u^i du/z³, i=0,1,2,

and coefficient matrix

    M_ij=[u^(5(i+1)-j-1)] F² A,   0<=i,j<=2.              (K)

Thus (K) tests ordinary indigenous status of this endpoint. More
sharply, its kernel has dimension at most1 when b=2 and is ZERO
when b=4. Every such datum supported on four Weierstrass points
is therefore ordinary, without assuming Y or J_C ordinary.

Scope: this quartic quotient is not a quadratic on Y. Section2's
corelessness proof concerns the quadratic case only; a fourth-root
pullback can split over the common source, so the same Cartesian
corelessness argument cannot silently be applied to a chosen component.
Neither endpoint test implies ordinariness on an arbitrary common
source. No atlas, uniform partner finiteness, or unmarked common-cover
exclusion is concluded.

[Proof](../Solutions/Sol_hyperelliptic_quadratic_root_quotient.md).
