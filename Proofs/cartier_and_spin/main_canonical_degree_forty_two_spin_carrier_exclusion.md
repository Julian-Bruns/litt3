# Proof: pointed Hurwitz transversality and a finite coefficient bound

Version1. [Statement](../../Theorems/cartier_and_spin/main_canonical_degree_forty_two_spin_carrier_exclusion.md). Whole-carrier implication passed [independent review](../../Research/audits/MAIN_CANONICAL_DEGREE_FORTY_TWO_CARRIER_AUDIT_2026_10_03.md). Keep BOTH actual endpoint maps on the SAME T and retain L=φ*M, L¹⁶≅ωT, N=M¹⁶ωΓ^-1 and its canonical different identification φ*N≅O_T(qP), with original infinity sections descended to M. Reuse the accepted [canonical degree42 invariant-generator reduction](canonical_septic_triangle_ordinary_spin_reduction.md), [tame classification](tame_ramified_spin_degree_classification.md), [actual carrier obstruction](actual_spin_carrier_character_reduction.md), and [MAIN three-branch exclusion](../quotient_geometry/main_bounded_three_branch_exclusion.md).

The faithful degree42 signature is(2,3,7). If its distinguished point is a cone, the actual separating Y→P1 map has only THREE tame branch values and is excluded on MAIN. Hence consider only an ordinary distinguished point. Canonical stack Hurwitz gives K_Y∼2P, so P is Weierstrass. All the generator and primitive-even arguments in the accepted degree42 reduction depend only on this actual canonical carrier, not on its being a normalized projective image. Thus the invariant-F case is excluded. Write a monic Weierstrass model Y:y²=Φ(z), P=∞, with Φ squarefree of degree FIVE.

## Actual identities and the nonzero odd branch jet

The exact normalized generators F,G,H have sole poles6,14,21 and disjoint simple zero divisors of degrees6,14,21. They satisfy
\[
H^2=\alpha F^7+\beta G^3,\qquad\alpha\beta\ne0,
\qquad d(FG)=cH\sigma,\quad c\ne0,\quad\sigma=dz/y.
\]
Their coarse quotient coordinate is b=G³/F⁷. It has poles of order SEVEN at the six F-zeros; its zero fiber has FOURTEEN order-three points; the value−α/β has TWENTY-ONE order-two points. Its only additional ramification is the index-two point P. Direct differentiation gives
\[
db=3cG^2H\sigma/F^8.
\]
The exact pole and zero orders show that this is the ACTUAL separating tame degree42 map, with its three fixed cone values and ONE additional simple branch value at P.

Use the hyperelliptic local parameter τ with z=τ^-2 and y=τ^-5 times a unit in τ². It satisfies ιτ=−τ. Put
\[
F=f_0\tau^{-6}(1+a\tau+O(\tau^2)),\quad
G=g_0\tau^{-14}(1+d\tau+O(\tau^2)),\quad
H=h_0\tau^{-21}(1+e\tau+O(\tau^2)).
\]
Noninvariant F=U3(z)+v y has a=v/f0≠0. Since d(FG)=cHσ has pole NINETEEN, the pole-NINETEEN term of FG itself must vanish: its derivative would have pole TWENTY. Thus d=−a. The first two coefficients of H²=αF7+βG³ give
\[
h_0^2=\alpha f_0^7+\beta g_0^3,
\qquad2h_0^2e=7\alpha f_0^7a+3\beta g_0^3d=2h_0^2a.
\]
Hence e=a. In db, the relative first odd coefficient is2d+e−8a=−9a=a in characteristic five; σ has only even relative coefficients. Therefore, writing
\[
b=b(P)+A\tau^2+B\tau^3+O(\tau^4),\qquad A\ne0,
\]
we obtain
\[
3B=2Aa,\qquad B=(2/3)Aa\ne0.
\]

## Pointed tame Hurwitz deformation meets the Weierstrass locus transversely

Here is the required local deformation argument, including its marking. Fix the three cone branch values and move only the additional simple branch value of b. Away from a small formal neighborhood of P the cover has its unique étale infinitesimal continuation. At P, changing the branch value by ε is described by changing the relation b=b(P)+Aτ²+Bτ³+… to b=b(P)+ε+Aτ²+Bτ³+… . On the punctured overlap, the infinitesimal change of source coordinate is the vector field
\[
\frac1{b'(\tau)}\frac\partial{\partial\tau}
=\left(\frac1{2A}\tau^{-1}-\frac{3B}{4A^2}+O(\tau)\right)\frac\partial{\partial\tau},
\]
up to a harmless overall sign. The critical point P is marked on the inside chart. Thus this is a Čech representative in H1(Y,T_Y(−P)); changes of the inside marked coordinate must vanish at P, so its constant term cannot be discarded there. Other branch points have fixed values and indices prime to five, hence create no deformation parameters. Conversely the local tame cover equations and uniqueness of étale continuation give all cover deformations from this single moving branch value; in particular the pointed Hurwitz space is smooth of dimension ONE locally, without requiring the monodromy order prime to five.

At a genus-two Weierstrass point, the hyperelliptic involution splits the pointed tangent space into its invariant part, tangent to the marked Weierstrass locus, and its one-dimensional anti-invariant normal part. Dually, H0(ωY²(P)) consists of the THREE invariant regular quadratic differentials and the anti-invariant differential
\[
q=y\sigma^2.
\]
The latter has a SIMPLE pole at P and spans the conormal to that locus. Its local expansion is q=(q_-1 τ^-1+q1 τ+…)dτ², q_-1≠0; there is no constant term because q is anti-invariant. Serre's Čech residue pairing with the displayed cover deformation is
\[
\operatorname{Res}_P\left(q/b'(\tau)\right)
=-\frac{3Bq_{-1}}{4A^2}\ne0.
\]
Consequently the marked Weierstrass condition cuts this ONE-dimensional pointed Hurwitz deformation transversely at every noninvariant-F candidate. Its intersection is locally ZERO-dimensional. This applies even at a special curve with extra automorphisms by taking the usual marked local deformation chart; taking a finite automorphism quotient cannot create a positive-dimensional intersection.

## An explicit bounded isolated-point scheme

The following coefficient system supplies a finite bound without compactifying Hurwitz space. For each of the SIX labelled Weierstrass origins in the family Y_t, put that point at infinity. Its transformed monic Φ has coefficient numerators and a common denominator Δ(t) of degree at most FOUR, as in the accepted six-origin Cartier bounds. At t≠0,1,2,3 the chosen transformation is defined and Δ≠0.

Rescale F,G,H separately so their highest EVEN, EVEN and ODD coefficients respectively are ONE. Write
\[
F=U_3+v y,\quad U_3\text{ monic};\qquad
G=A_7+yB_4,\quad A_7\text{ monic};\qquad
H=C_{10}+yD_8,\quad D_8\text{ monic}.
\]
Allow degree-at-most10,4,8 for the remaining displayed polynomials. There are FOUR unknown F coefficients, TWELVE G coefficients, NINETEEN H coefficients, and α,β,c,t, for a total of THIRTY-NINE affine variables. Rescaling only changes the nonzero α,β,c. The two identities are polynomial coefficient equations after replacing y² by Φ:
\[
H^2=\alpha F^7+\beta G^3,\qquad
y(FG)'=cH.
\]
For the first identity, multiply by Δ³. Every term has total degree at most TWENTY: F7 has at most seven function-coefficient factors and three Φ factors; numerator and denominator contributions together have degree at most12 in t, and α contributes one. The H² and G³ terms have smaller degrees. For the second identity, multiplying by Δ² gives total degree at most TEN. Differentiation is in z and does not differentiate Δ(t). Thus every defining equation has total degree at most20.

Actual candidates lie in the open set where Φ is smooth, vαβc≠0 and the three zero divisors are simple and disjoint. In this open set, every coefficient solution gives the genuine degree42 tame cover described above. The normalization of leading coefficients removes the three scaling freedoms. A fixed cover determines F,G,H up to precisely those scalings from their actual cone divisors; the remaining ambiguity in curve coordinates and origin labelling is finite. Hence a positive-dimensional component through an actual candidate would give a positive-dimensional family in the pointed Weierstrass Hurwitz intersection, contradicted by the residue calculation. Every actual noninvariant candidate is therefore an ISOLATED geometric point of the raw coefficient scheme. Closed extraneous components in the complement of this open set do not invalidate the isolated-point conclusion.

Isolated affine Bézout bounds their number by20³⁹ for each origin. A deliberately looser bound for the union of six origins is
\[
6\cdot20^{40}.
\]
All six systems are defined over F5, so their finite candidate parameter support is Frobenius-stable. A parameter of F5-degree r in this support contributes r distinct conjugates, giving r≤6·20⁴⁰. The selected MAIN degree exceeds K>(42000!)³⁸, which is far larger than this bound. Hence MAIN avoids every ordinary noninvariant-F candidate. Together with the accepted invariant-F and three-branch exclusions, this excludes EVERY actual faithful canonical degree42 ramified carrier on MAIN. Both original finite étale maps remain on their original source throughout.
