# Proof: doubled Abel curves give a sharp finite jet test

This proves the
[statement](../../../Theorems/jacobians/theta_divisors/genus_two_theta_jet_bound.md).
The returned Pro argument gave2r by intersecting a moving smooth theta
curve. The doubled Abel curve, already used in the audited
[earlier rank-four theta proof](../../../../litt3-computation-data/primitive_mixed_theta_20260915/before/genus_two_rank_four_theta.md),
improves that coefficient to3/2 and determines the equality case.
This is provenance, not a dependency: Section1 below proves the
needed geometry directly. The
[bounded independent audit](../../../Research/audits/GENUS_TWO_SHARP_THETA_JET_AUDIT_2026_09_15.md)
passes the generalization and its two-map determinant consequences.

## 1. The distinguished six-branch curve

Choose a Weierstrass base point w and embed C into A by P->P-w.
Its image is a symmetric theta divisor. Its reduced image B under
[2] has normalization C. Indeed [2] is etale, and failure of generic
injectivity on C would force C and one of its nonzero two-torsion
translates to coincide. The resulting fixed-point-free involution
on a genus-two curve contradicts etale Hurwitz. Thus [2]|C is
birational onto B.

The pushforward formula [2]_*Theta=4Theta gives B numerically4Theta.
The fiber of C->B over0 consists exactly of the six Weierstrass
points: 2(P-w)=0 iff the degree-two divisor2P is canonical. They
are six distinct points in characteristic different from2. Each
branch is smooth because [2] is etale and the Abel map is an
immersion. Therefore mult_0 B=6. Translate to get an integral curve
B_b=t_b(B) of class4Theta with multiplicity6 at an arbitrary b.
Changing the Weierstrass base point translates the Abel curve by a
two-torsion point, so [2](i_w(C)) and hence B_b are unchanged.

## 2. Multiplicity and its equality case

Let D=div(s), of class rTheta. Write D=e B_b+D0, with B_b not a
component of the effective residual divisor D0. Put r0=r-4e.
Intersecting with the ample theta class gives r0>=0; if r0=0 then
D0=0. If D0 is nonempty, positivity of local intersection numbers
on the smooth surface A gives

    6 mult_b(D0) <= i_b(B_b,D0) <= B_b.D0=8r0.

Thus

    mult_b D <= 6e+4r0/3
                 =3r/2-r0/6 <=3r/2.

This also applies if D0=0. When r=4m and mult_b D=6m, the displayed
strict loss for r0>0 forces r0=0 and e=m. Conversely m B_b has
exact multiplicity6m. Such a divisor is cut out by the canonical
section of O_A(m B_b), proving sharpness over this numerical class.
Two nonzero sections with this same divisor differ by a scalar,
which gives the one-dimensional top-order assertion.

A section killed by jets through degree floor(3r/2) would have
order at least floor(3r/2)+1. The multiplicity inequality therefore
proves the asserted injection, including all degree-zero line twists.

## 3. The actual determinant line

For the same-source span, denote JX^(1) times JY^(1) by P, and let
N be its inherited Poincare family on Z^(1). The perfect complex
Rq_*(B_Z tensor N) has Euler characteristic zero, so the inverse
determinant line T has its canonical determinant section sigma.
It may be identically zero; it is not called an effective divisor
in that case. Its generic corank delta vanishes iff sigma is nonzero.

For a fixed L in JX^(1), etale base change gives

    g^(1)_*(B_Z tensor f^(1)*L)
          =B_Y tensor g^(1)_*f^(1)*L.

The second factor has rank m and degree0, by etale Hurwitz and
Riemann--Roch. The resulting bundle has rank (p-1)m and Euler
characteristic zero. The determinant-of-cohomology formula on a
Jacobian gives T|({L} times JY^(1)) numerically (p-1)m Theta_Y.
This is the usual rank-times-principal-polarization formula; it also
follows directly from Grothendieck--Riemann--Roch for the Poincare
line. It holds for the determinant LINE even when its section is zero.

Apply Section2 to every such fiber. The full relative jet of sigma
along JX^(1) times {M0} vanishes iff every fiber section does, iff
sigma=0. This proof needs neither an external-product splitting nor
separability of the parameter map into JZ. It applies in arbitrary
cover degrees. Relative jets are defined by the power of the ideal
of that slice, so this statement is coordinate independent.

## 4. Coefficient sections and the top-order alternative

When Hom(JX,JY)=0, the Picard group of the product has no mixed
biextension part. Seesaw gives T=TX external-tensor TY. Kunneth gives

    H0(P,T)=H0(JX^(1),TX) tensor H0(JY^(1),TY).

After choosing parameters u,v at M0 and a local trivialization of TY,
the relative jet has coefficient sections sigma_ij in H0(JX^(1),TX).
In characteristic five, r=4m and jets through degree6m detect
sigma. Ample-line vanishing and abelian Riemann--Roch give
h0(TY)=r^2=16m^2. Thus16m^2 suitable linear functionals of these
jets determine the entire second-variable section.

If all coefficients of degree<6m vanish and sigma!=0, its
second-variable tensor factors lie in the kernel of evaluation
through order6m-1. Section2 makes that kernel one-dimensional,
generated by the section of m B_(M0), if it exists in TY at all.
Hence sigma=s_X tensor s_Y with the asserted divisor. The argument
does not force such a factorization or a nonzero coefficient on an
unknown actual span.
