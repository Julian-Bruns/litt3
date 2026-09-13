# Cohomological Bézout matrices and a small test for their inverse

Version2, 2026-09-13. The inverse-block and primitive-adjugate conclusions
now include nonacyclic bundles; the selected-column criterion is stated
with its exact characteristic-free hypotheses.

Use the [cohomological Bézout conventions](../../Definitions/Def_cohomological_bezout.md):
C is a smooth projective connected curve, V has rank2 and degree2g−2,
T is a line bundle, M=det(V)T^-1, A=H0(VT^-1), H0(T)=H1(M)=0, and A
separates every length-two divisor. Put n=h1(T)=h0(M), r=h0(V)=h1(V).
For u in A, let D_u be its zero divisor and K the linear cup map on
E=H1(TM^-1). All statements below are characteristic-independent.

## Resultant and inverse block

Fixed Čech splittings construct the polynomial matrix

    D(u) = [ B(u)  q(u) ] : H1(T) + H0(V) -> H0(M) + H1(V),
           [ a(u)    0  ]

where B is quadratic and q=H0(b_u), a=H1(a_u) are linear. For every
nonzero u, corank D(u)=deg D_u. Its determinant is a nonzero constant
times the reduced irreducible resultant, of degree2n. Thus D is invertible
exactly on the admissible open, retaining repeated zeros and infinity.
On that open,

    (D^-1)_11=K(eta_u),   rank K(eta_u)=n-r,
    ker K(eta_u)=im q,    im K(eta_u)=ker a.

These are identities over the open's coordinate ring. If K is injective,
then r<n, and any fixed linear left inverse of K applied to
`(adj D)_11` gives a primitive homogeneous extension representative e_D
of degree2n−2, satisfying e_D=det(D)eta_u on the admissible open. It is
nonzero there. No determinant expansion or preferred minor is required.

For r=0, B is independent of the Čech splittings and B=K(eta_u)^-1.
If det V=omega, cup matrices are symmetric in Serre-dual bases, so B
is symmetric as well.

## Selected-column criterion

Let S⊂H0(M) generate M at every point, let Q_S be its basis-column
matrix, and suppose restriction

    im K -> Hom(S,H1(T))

is injective. For a variable Gamma in the fixed linear space im K,
introduce only an r by dim(S) block Z. Then

    D(u) [Gamma Q_S; Z] = [Q_S;0]                         (C)

is scheme-theoretically the full inverse-cup incidence
`det D invertible, Gamma=(D^-1)_11`; Z is unique. This includes arbitrary
coefficient algebras and all boundary strata. Recovering eta itself
additionally requires K injective.

A sufficient condition for both injectivities is surjectivity of

    S·H0(omega T^-1) -> H0(omega M T^-1),

together with the stated basepoint-freeness of S. When det V=omega,
this is S·H0(M)=H0(M²). No self-duality is assumed in the general form.

## Explicit minor patches

On any open where an r-row minor q0 of q and an r-column minor a0 of a
are invertible, order the selected coordinates last and put m=n-r,

    P=[I_m;-a0^-1 a_left],  L=[I_m,-q_top q0^-1],  Bbar=L B P.

Then det D=±det(q0)det(a0)det(Bbar), and its inverse block is
`P Bbar^-1 L`. Equivalently impose

    a Gamma=0,  Gamma q=0,  L B Gamma=L.

Writing Gamma=P Z0 L, the last equation is Bbar Z0=I_m. Logarithmic
differentiation gives

    Tr(D^-1 dD)=Tr(Bbar^-1 dBbar)+dlog det(q0)+dlog det(a0).

For det V=omega choose dual bases, so a=q^T, use the same minor twice,
and take L=P^T. The matrix Bbar is symmetric and

    det D=(-1)^r det(q0)^2 det(Bbar).

For symmetric Gamma only Gamma q=0 and Bbar Z0=I_m are needed, with
Z0 its unselected principal submatrix. All such minor opens are retained.

## Fixed curve and acyclic construction

For V=W(8O), T=omega^-1 and M=omega² on the fixed genus-nine curve,
n=24. The28,935 simple opers have r=0; the55 invariant opers have r=3,
by the actual tangent/horizontal-section calculation. Every resultant has
degree48, every primitive vector above degree46. A single choice
`S=<y,x^10,x^4 y²>` works for all opers: its products span L64. It uses
columns(4,21,23) of the pole-ordered L32 basis, hence only3 inverse columns.

For any finite degree-d map pi:C->P1 and acyclic V with det V=omega,
pi_*V=O(-1)^(2d). The dualizing trace gives a constant nondegenerate
alternating matrix J in such a frame. If P(z) represents b_u, the
divided-difference kernel `P(z)J^-1 P(w)^T/(z-w)` is polynomial and
gives B in the matching Čech and Serre-dual bases, with the fixed sign.
This construction retains its acyclicity hypothesis.

The first-oper quadratic tensor and its full six-section reconstruction
remain exactly checked. Other exceptional B tensors are not asserted
computed. These constructions do not exclude an atlas or common cover.

[Proof](../../Solutions/atlases/cohomological_bezout.md). The original matrix,
corank and determinant argument has an independent
[PASS audit](../../Research/audits/COHOMOLOGICAL_BEZOUT_AUDIT_2026_09_07.md).
The extensions and consolidated inverse arguments have the separate
[2026-09-13 scope audit](../../Research/audits/INVERSE_CUP_CONSOLIDATION_SCOPE_AUDIT_2026_09_13.md).
