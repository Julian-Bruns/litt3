# Proof: the global resultant-gradient identity

2026-09-07, /root. Bounded independent major audit PASS.
[Statement](../Theorems/Thm_resultant_gradient_atlas.md).
The proof applies to every fixed geometric oper on our curve.

Use the canonical extension pencil, differential projection, and residue
conventions. A=S_U has dimension32, E=P48 dimension56, and Q:L64->A is
onto. Let J=Ann ker Q, and identify J with A* by

    i(Y)(Qh)=Res_O(Y h theta).

Take the primitive homogeneous kernel vector e(U) of N_U, degree46,
in E^[5]. Put T(U)=-aff(U e(U)) and

    Delta(U)=Wh(U,T(U)),         B(U)=R_U e(U).

Both are polynomial: Delta has degree48, B degree47. The tensor projection
theorem puts B in J. Claim:

    i(B(U)) = -d Delta(U).                                  (G)

## 1. Delta is the reduced resultant

View A as the Frobenius-coordinate realization of H0(W(24O)). Let D be
the locus of sections with a zero. E0=W(24O) has rank2 and degree48;
stability and Serre duality imply separation of subschemes of length<=7
(the dual twist has slope -8+length<0). The incidence of pairs (u,P)
with u(P)=0 is a projective bundle over C. Its image D in P31 is an
irreducible divisor, generically one simple zero; the incidence map is
birational and generically unramified. Its degree is48: on C times a
general P1 of sections, the zero scheme has length c2(E0 box O(1))=48.
These assertions persist in the coefficient-Frobenius coordinate space.
If f(u) is the degree48 resultant in descent-section coordinates and
U_i=u_i^5, the reduced scalar equation is f^[5](U), obtained by raising
COEFFICIENTS to fifth powers, still degree48. Its pullback f(u)^5 has
degree240; that is a different operation and is not Delta here.

On the generic one-zero locus, the cup pencil still has rank55. Its
kernel e is nonzero. Wh(U,T)=0 there, since U,delta U vanish at that
point whereas the Wronskian is constant. On the nowhere-zero locus the
kernel Wronskian is nonzero. Thus Delta is a nonzero degree48 polynomial
vanishing on D, so it is a constant multiple of D's reduced equation.

## 2. Evaluate B on a generic point of D

Fix U with exactly one simple zero P as a section of W24; take P!=O
and otherwise general, so pole U=112. Write e=eta^[5] at this geometric
point, eta in P48. Since the Wronskian is zero,

    T=U h^5

for a rational h. It has exactly one possible finite pole, at P, of
order at most1: scalar U has order5 or6 at P, and order1 at its other
finite zeros. The pole at P actually occurs; otherwise h is affine
and N eta5=0 would imply eta=0. Its pole at O is at most17.

Put V=T+U eta^5. Since val_O V>=128, val_O(eta+h)>=48. We may therefore
replace eta by -h in the principal-part construction. The local-gauge
calculation of the direct criterion is valid even when Wh=0: a change
t48g changes the R-class by U t155(g^5-g(0)^5), which has valuation>=48.
Now V=0 and lambda=rho32(delta h). Replacing this lambda by delta h
changes U lambda^5 by an affine function plus a term of valuation>=48.
Consequently

    B(U) = class of -U(delta h)^5 in H1(O(-48O)).             (1)

For g in L64 and Z=Qg, the definition of i and the global residue
theorem give

    i(B(U))(Z)=Res_P U(delta h)^5 g theta.                   (2)

There are no finite poles other than P in this differential.

## 3. The local computation fixes the sign and normalization

Take a local unit horizontal solution u0 and complementary solution w0
with Wh(u0,w0)=1. Let z=w0/u0 vanish at P. Then
delta z=u0^-2, theta=u0^2 dz. Write

    U=u0 z^5(a(z)^5+z b(z)^5),      h=c/z+regular,
    Z=u0(C(z)^5+z D(z)^5),         c!=0.

Put H=u0^3 g. The local formula Qg=u0^-9 partial_z^3 H gives

    C(0)^5=u0(0)^-10 [z^3]H,
    D(0)^5=4 u0(0)^-10 [z^4]H.

Since (delta h)^5=-c^5 u0^-10 z^-10 plus regular terms, (2) is

    -c^5 u0(0)^-10 (a(0)^5 [z^4]H+b(0)^5 [z^3]H)
      =c^5(a(0)^5 D(0)^5-b(0)^5 C(0)^5).                  (3)

On the other hand T=U h^5 has the same value and first derivative at P
as c^5 u0(a(z)^5+z b(z)^5). Therefore (3) equals -Wh(Z,T)(P).
Differentiate the polynomial identity Delta(U)=Wh(U,T(U)) in direction Z:

    dDelta_U(Z)=Wh(Z,T)(P)+Wh(U,dT_U(Z))(P)=Wh(Z,T)(P),

because U and delta U vanish at P. Thus i(B(U))=-dDelta_U for EVERY
direction Z in A at a generic point U of D.

## 4. Polynomial continuation

Each coordinate of i(B)+dDelta is a polynomial of degree47 vanishing
on the irreducible reduced degree48 hypersurface D. It is divisible by
Delta, hence zero. This proves (G) on all of A. No logarithmic residue
extension or unproved normality of the resultant is needed.

## Consequences and scope

Euler gives i(B)(U)=-48Delta=2Delta. In particular B is NEVER zero on
the admissible locus Delta!=0. The atlas equation is equivalent to

    B(U)^[5]=Delta(U)^4 e(U),   Delta(U)!=0.                (4)

Indeed e/Delta gives Wronskian1 and R sends it to B/Delta, whose fifth
power must be e/Delta. Thus the nonzero-output proviso in the prior
projective criterion becomes automatic. At an actual normalized atlas,
i(eta)(U)=2, a quadratic scalar condition.

Equation (4) has not been excluded. The theorem converts the full
remaining test to a Frobenius-polar equation; it does not solve Litt3.
The exact line certificate wronskian_line_gradient.json independently
checks (G) along an entire projective line, including its coefficient
Frobenius convention, but is not used as proof of the global assertion.
