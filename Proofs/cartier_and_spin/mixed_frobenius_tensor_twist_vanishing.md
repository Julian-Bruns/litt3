# Cubic fixed-point norms of a Frobenius bilinear form

This proves the [mixed-tensor vanishing](../../Theorems/cartier_and_spin/mixed_frobenius_tensor_twist_vanishing.md).
All geometric parameters range over the algebraic closure of F5.
The integer code i+5j denotes i+ja in F25, with a^2-a+2=0.
The actual data are
\[
X:y^3=P(x),\quad
P=(11,22,18,5,19,20,15,16,9,22,1),
\]
\[
0\to O(-5O)\to K\to O(6O)\to0,\qquad
e=y^2\sum_{m=1}^{10}c_mx^{-m},
\]
where c=(2,16,16,7,1,2,7,1,24,11). The transition is
(v_A,v_B) -> (v_A-e v_B,v_B). These are the fixed extension conventions.

## The actual invariant norm

Let gamma(x,y)=(x,zeta y), with zeta of order three. The specified
extension is linearized by diag(zeta,1) in its affine rational frame:
T(e)diag(zeta,1)=diag(zeta,1)T(zeta^2 e). Consequently F*K has the
induced characters(zeta^2,1).

Write W=K tensor F*K. Multiplication gives an injection of bundles
W -> Sym6 K, with binary indices0,1,5,6. For a hypothetical nonzero
s in H0(W tensor L), its three conjugates have a product
\[
G=s\,\gamma(s)\,\gamma^2(s)
\in H^0\bigl(\operatorname{Sym}^3K\otimes
                  F^*\operatorname{Sym}^3K\bigr)^{C_3}.
\]
Indeed L tensor gamma*L tensor gamma2*L is x*Nm_x(L), and the degree-zero
norm line on P1 is trivial. Its natural cubic linearization is also
trivial. Thus no additional character or choice of a torsion root is
being suppressed. At a fixed point the group action cyclically
permutes three copies of the same line fiber and acts trivially on
their tensor product.

The product is nonzero. At the generic point its factors are nonzero
bilinear polynomials, whose product is nonzero in a polynomial domain.
The natural map Sym3 K tensor F*Sym3 K -> Sym18 K is fiberwise
injective: its binary indices i+5j,0<=i,j<=3, are all distinct.
Thus its forbidden indices are exactly4,9,14.

## Complete section-space calculation

A section of Sym18 K has affine coefficients f_0,...,f_18 in
k[x,y]/(y^3-P). The other chart coefficients are
\[
g_i=\sum_{j=i}^{18}{j\choose i}(-e)^{j-i}f_j,
\qquad \operatorname{ord}_O g_i\ge90-11i.
\]
The affine monomials x^m y^r,0<=r<=2, have distinct pole orders3m+10r.
Descending in i, the polynomial part of each transition determines
all coefficients except the affine monomials of pole order at most
-90+11i. The remaining negative-power coefficients give a complete
489-by508 linear system. Its rank is489 over F25 and978 after the
independent restriction of scalars to F5. Hence h0(Sym18 K)=19.

The three cubic character dimensions are10,6,3. The condition that
coordinates4,9,14 vanish has rank one on each character space.
In particular the invariant subspace containing G has dimension nine.
Its complete basis, both chart expressions, and original linear
system are retained in `k_sym18_sections.json` in the
[external evidence directory](../../../litt3-computation-data/overnight_three_replies_20260926/).
The [section constructor](../../scripts/arithmetic/k_symmetric_section_space.py)
rebuilds these data from the actual transition, without a point search.

## Three universal fiber identities

At a finite cubic branch point use the regular affine frame. Write
a bilinear form as h=aUS+bUT+cVS+dVT, of respective cubic weights
0,1,2,0. Its orbit product is exactly
\[
(aUS+dVT)^3+(bUT)^3+(cVS)^3-3(aUS+dVT)bc\,USVT.
\]
After S=U^5,T=V^5 let A,B,C,D,X,Y be its binary coefficients with
indices0,15,3,18,6,12, respectively. Put J=ad-bc. Then
\[
A=a^3,\ B=b^3,\ C=c^3,\ D=d^3,\ X=3aJ,\ Y=3dJ.
\]
It follows that
\[
X^3D-Y^3A=0,
\]
\[
X^4-9AYX^2+27A^2Y^2+27ABCX-27A^2DX=0,
\]
\[
Y^4-9DXY^2+27D^2X^2+27DBCY-27D^2AY=0.
\]
For the second identity, substitution gives81a^4J times
((J-ad)^3+(bc)^3), which is zero. The third is its transpose.
These are homogeneous polynomial identities; they include zero
fibers, repeated factors, and every zero coefficient. Multiplication
by the scalar from the twisting-line trivialization preserves them.

For the invariant global section, the six indicated affine
coefficients have y-residue zero. The identities at all ten finite
branch points are therefore equivalent to divisibility of each
displayed quartic expression by the squarefree polynomial P(x).
Taking its remainder gives ten equations per identity.

At O put t=x^3/y. The regular K frame is(t^5e_A,t^-6e_B), of weights
(zeta^2,1), so only the two nontrivial fiber weights interchange.
The same three identities apply. For i in0,3,6,12,15,18, the fiber
coefficient is the coefficient of x^{(-90+11i)/3}, with y-residue
zero, in g_i. The leading units of x t^3 and y t^10 are both one.
This accounts for infinity without dropping a boundary condition.

## Exhaustive geometric elimination and verification

Write b_0,...,b_8 for the nine invariant section coordinates. These
are norm coefficients, unrelated to the middle-return coordinates.
Normalize their first nonzero entry to one, giving nine projective
charts. The [constructor](../../scripts/arithmetic/k_hermitian_norm_probe.py)
produces the exact quartic equations. It reduces affine coefficients
modulo P before forming the products, which does not change them.

The first identity alone excludes charts b8 through b1. Retaining
all three identities excludes the remaining chart b0 and gives
smaller certificates on b1,b2. All exclusions were computed by exact
sparse F4 over F5 with the additional equation a^2-a+2. The main
chart's33 equations in eight geometric variables were independently
recomputed over F25 by Singular slimgb, again giving the unit ideal.
There is no finite-field equation on a geometric parameter.

The [independent elementary checker](../../scripts/arithmetic/verify_k_hermitian_fixed_norm.py)
reconstructs the actual section transitions, checks the nine-dimensional
kernel subspace, expands the six-coefficient fiber product in both
cubic orientations, rebuilds every finite and infinite quartic, and
matches the retained equations. It uses only standard-library coded
field arithmetic. On charts1..8 it also replays explicit polynomial
identities for1. On chart0 its `--basis-only` receipt matches the
independently completed F25 unit-basis calculation to those rebuilt
equations. The main-chart expanded identity is additional evidence
under extraction, not a missing premise of the two completed exact
basis computations. The verification distinction is retained in
the receipts and the [audit](../../Research/audits/MIXED_FROBENIUS_TENSOR_2026_09_26.md).

All nine geometric charts are therefore empty. The hypothetical
nonzero G cannot exist, and hence neither can s. This proves the
all-geometric Pic0-twist vanishing, without any assumption on the
generic rank of s or on the degree of a trivializing cover.
