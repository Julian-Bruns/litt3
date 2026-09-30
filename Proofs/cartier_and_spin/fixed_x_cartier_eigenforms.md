# Proof: Cartier eigenforms on the fixed genus-nine curve

[Statement](../../Theorems/cartier_and_spin/fixed_x_cartier_eigenforms.md).
Write X:y³=F(x) for the fixed curve. The
[exact certificate](../../scripts/arithmetic/fixed_x_cartier_eigenforms.sage)
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

The full kernel, stable Cartier rank and three explicit Petri products
are now computed in the separate
[excess-one proof](cartier_petri_excess_one.md), Sections3--4. That small
calculation does not repeat the finite eigenform algebra below.

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

## 4. Ordinary partners with no common Jacobian factor

Let Y be ordinary with Hom(JX,JY)=0, and let
V=f^*H^0(X,omega_X)∩g^*H^0(Y,omega_Y) for an actual
bi-etale span X←Z→Y. It is Cartier-stable by etale functoriality.
Ordinarity of Y makes Cartier injective on V and hence
bijective. If V!=0, an invertible semilinear operator over an algebraically
closed field has a nonzero eigenvector (indeed a Cartier-fixed basis,
by the usual Frobenius/Lang argument). Such a vector descends to a
nonzero Cartier eigenform on X. By the theorem it has only simple zeros.

The [canonical marked quotient theorem](../quotient_geometry/canonical_marked_quotient.md)
forces a core. The
[low-zero Cartier lemma](../shared_tensors/cartier_fixed_low_zero_core.md)
makes it positive-genus. That gives a common positive-dimensional isogeny
factor of JX and JY, contrary to Hom(JX,JY)=0. Thus V=0.

The [original audit](../../routes/global/audits/GENUS9_ALL_NONZERO_EIGENVALUE_CARTIER_FORMS_SIMPLE_AUDIT_2026_09_06.md)
passed, including an independent exact Sage replay. The general partner
corollary uses precisely the same argument; no genus or field-degree
restriction on Y entered it.

## 5. Uniform divisors in the Cartier kernel

The small Cartier calculation gives
$\ker C_X=\{B(x)\theta:N B=0,\ \deg B\le5\}$, where
$\theta=dx/y^2$ and $\operatorname{div}\theta=16O$.
Suppose $0\ne B\theta$ has a uniform positive zero multiplicity $e$.
If $j=\deg B$, its order at $O$ is $16-3j>0$, so
$e=16-3j\equiv1\pmod3$.

A root of $B$ at a cubic branch point would have order divisible
by three on $X$, contradicting uniformity. All polynomial roots
are therefore unramified and have multiplicity $e$. If $j>0$,
this forces $e\mid j$. Among $1\le j\le5$, the equation
$e=16-3j$ permits only $(j,e)=(4,4)$ or $(5,1)$.
The first is impossible for a Cartier-killed differential: its
leading term at $O$ would be a nonzero multiple of $z^4dz$,
whose Cartier image has nonzero constant coefficient.
For $j=0$, the form is a scalar multiple of $\theta$; it is not
Cartier-killed, since the first column of $N$ is $(19,22,0)^t$.
Thus necessarily $j=5,e=1$.

Together with Sections1--3, every Cartier eigenform, including
eigenvalue zero, that has uniform positive zero multiplicities
has only simple zeros. The final endpoint-root corollary of
[the Cartier-generator theorem](cartier_generator.md) now excludes
every matched weight-$M$ tensor that is an $M$-th power of a
regular one-form on $X$. This new argument uses only the already
computed rank-three Cartier blocks, the local Cartier coefficient
rule, and the recorded root/core theorem.
