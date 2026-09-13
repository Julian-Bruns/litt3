# Proof: Cartier eigenforms on the fixed genus-nine curve

[Statement](../../Theorems/cartier_and_spin/fixed_x_cartier_eigenforms.md).
Write X:y³=F(x) for the fixed curve. The
[exact certificate](../../routes/global/GENUS9_CARTIER_EIGENFORM_SIMPLE_ZERO_TEST.sage)
parametrizes all nonzero Cartier eigenforms and tests their norm divisors.

## 1. Cartier coordinates and complete chart coverage

Every regular form has a unique expression

    omega=(A y+B) dx/y^2, deg A<=2, deg B<=5.

Cartier interchanges the two nontrivial cubic-character spaces. Its
matrix blocks are

    N_ij=F_(5i+4-j),       0<=i<3,0<=j<6,
    M_ij=(F^3)_(5i+4-j),   0<=i<6,0<=j<3,

with out-of-range coefficients zero. These follow directly from the
Cartier coefficient rule and y^3=F. Both A and B are nonzero for a
nonzero eigenvalue. Put t=lambda^(-5). The eigen-equations are

    A^[5]=t N B,       B^[5]=t M A.                    (1)

Brackets mean entrywise powers. Set Mr=M^[5], inverse fifth power on F25,
and H=N Mr. If V=A^[1/5], (1) implies

    V^[25]=rho H V, rho!=0.                           (2)

Let e3=(0,0,1) and form the matrix O with rows e3,e3H,e3H^2. Direct
calculation in the stated F25 gives

    det O=a+4 !=0,       a^2+4a+2=0.

If V_2=0, equation (2) gives e3HV=0. Raising this identity to the 25th
power and using H^[25]=H gives e3H^2V=0 as well. Thus OV=0, forcing
V=0, a contradiction. Therefore deg A=2 for every nonzero eigenform.
Scale omega so that A is monic, and
write A=(u^5,v^5,1), U=(u,v,1).

Writing b^5=t, equation (1) becomes B=b Mr U. Set c=b^3. The remaining
equations are exactly

    U^[25]=c^2 H U,       U_2=1.                      (3)

Conversely, every solution of (3) and every choice b^3=c give an eigenform
by these formulas. Its norm polynomial depends only on c, not the cube
root choice. The last coordinate of (3) excludes c=0.

## 2. One univariate finite algebra, not an extension-field search

Let sigma=charpoly(H)[1], so H^3=tr(H)H^2-sigma H+det(H)I. Iterating
(3), and taking third coordinates, yields

    e3HU=c^-2, e3H^2U=c^-52, e3H^3U=c^-1302.

Hence every solution satisfies

    P_c(c)=det(H)c^1302-sigma c^1300+tr(H)c^1250-1=0,
    U=O^(-1)(1,c^-2,c^-52)^T.                         (4)

Conversely, (4) implies (3): apply the invertible O to
U^[25]-c^2HU. Its first two coordinates vanish directly; its third
vanishes by Cayley--Hamilton and P_c(c)=0. Thus (4) parametrizes the
ENTIRE algebraic-closure eigenform chart.

The polynomial P_c is separable: its derivative is
2 det(H)c^1301, det(H)!=0, and its constant coefficient is -1.
Exact factorization over F25 has irreducible-factor degrees

    1, 1, 52, 624, 624.

These sum to1302. The certificate verifies irreducibility and the full
factorization identity, then works in each of these five quotient fields.

## 3. Norm squarefreeness proves simple zeros

Put L(x)=sum_j(Mr U)_j x^j. For the corresponding eigenform,

    R(x)=Norm_(k(X)/k(x))(A y+B)=B^3+F A^3
        =c L(x)^3+F(x)(x^2+v^5 x+u^5)^3.              (5)

It is monic of degree16. The certificate computes

    gcd(R,R')=1

in each of the five quotient fields from (4). Thus every conjugate
solution over the algebraic closure has squarefree R.

At infinity, v(x)=-3,v(y)=-10, and div(dx/y^2)=16P_infinity. Since A is
monic quadratic and deg B<=5, Ay+B has pole order16 with no leading
cancellation. Hence omega has order zero there. At every finite point,
dx/y^2 is a unit differential (also at the cubic branch points, using
y as parameter). The norm valuation at x=x0 is the sum of the orders
of Ay+B at the points above x0. All those orders are nonnegative.
A multiple zero of omega would therefore give a multiple root of R,
contradicting (5) and the gcd test. This proves the theorem.

## 4. Why this removes the entire shared-one-form case

Let V=f^*H^0(X,omega_X)∩g^*H^0(Y,omega_Y) for an actual
bi-etale span X←Z→Y. It is Cartier-stable by etale functoriality.
Ordinarity of Y makes Cartier injective on V and hence
bijective. If V!=0, an invertible semilinear operator over an algebraically
closed field has a nonzero eigenvector (indeed a Cartier-fixed basis,
by the usual Frobenius/Lang argument). Such a vector descends to a
nonzero Cartier eigenform on X. By the theorem it has only simple zeros.

The [audited simple-root/core theorem](../shared_tensors/shared_tensor_core.md)
then forces a core and, by its low-zero logarithmic-form lemma, a
positive-genus core. That gives a common positive-dimensional isogeny
factor of JX and JY, contrary to Hom(JX,JY)=0 established for the fixed
pair. Thus V=0.

The [original audit](../../routes/global/audits/GENUS9_ALL_NONZERO_EIGENVALUE_CARTIER_FORMS_SIMPLE_AUDIT_2026_09_06.md)
passed, including an independent exact Sage replay.
