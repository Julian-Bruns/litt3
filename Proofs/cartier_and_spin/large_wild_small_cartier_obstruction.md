# Proof: five-jet interpolation and the small Cartier quotient

Version1,3 October2026. [Statement](../../Theorems/cartier_and_spin/large_wild_small_cartier_obstruction.md). Pending independent review. Use the accepted large-wild local reductions and the bounded global incidence. No computation is needed. Both actual endpoint maps remain on T.

## Every prescribed leading/fourth jet has five-dimensional interpolation freedom

At a wild point use t=F. The corrected leading relation \(\mathcal R(R)\)f0⁵=4c/λ⁵ gives the stated constant coefficient; the full Hermitian remainder constraints kill coefficients1,2,3. Their fourth-coefficient equation cH0+(2r4f0)⁵=0 gives r4⁵=2cH0D(R)⁵. These are FIVE specified coefficients at each of seven points.

The evaluation sequence on5A is surjective for L(41P), because 41P−5A∼6P and H1(Y,O(6P))=0. Equivalently the kernel is F⁵L(6P), of dimension FIVE, and dimL(41P)=40, leaving image dimension35 equal to the total jet length. Thus an interpolant exists for every collection of these target jets, and its ambiguity is exactly F⁵u, u∈L(6P).

## Cartier exactness is a class in a six-dimensional differential space

The differential \(\mathcal R_*\)F³σ has pole≤60P. Cartier lowers this bound to12P: a Laurent coefficient t^jdt survives only for j≡4 modulo FIVE, so the largest possible surviving pole is56, which becomes12. At each point in A its coefficient of t⁴dt is zero, since r1=f1=0. This is the constant coefficient of its Cartier image, so C(\(\mathcal R_*\)F³σ) vanishes at A. Dividing by F therefore produces a differential regular off P with pole≤5P, exactly Ω*∈H0(ωY(5P)).

For another interpolant \(\mathcal R_*+F^5u\), Cartier's genuine Frobenius rule gives
\[
\frac{C((\mathcal R_*+F^5u)F^3\sigma)}{F}
=\Omega_*+C(uF^3\sigma).
\]
This identity is the relative-twist identification used in the obstruction: one divides the resulting Cartier DIFFERENTIAL by the actual function F, and the added F⁵ factor exits Cartier as F. It is not an unjustified substitution of F for F⁵ before Cartier. Thus the class is independent of the chosen interpolant, and its vanishing is equivalent to the existence of an exactly Cartier-zero interpolant.

Riemann–Roch gives dimH0(ωY(5P))=6 and dimL(6P)=5. Cartier is inverse-Frobenius semilinear; over the perfect field k its image is nevertheless a k-vector space. Constants are in the kernel because C(F³σ)=0. Therefore the image dimension is at most FOUR and the obstruction quotient has dimension at least TWO. These dimensions do not prove that its class is nonzero on either endpoint or that the family support is finite.

## A direct oper expression for the class and the five columns

The function D has pole≤10P. Its fifth power has pole≤50P; at every wild point its coefficients1,…,4 vanish. Hence \(\mathcal R_*-\alpha D^5\) has zero order≥4 at A. Division by F⁴ makes V regular off P with pole≤50−28=22P. Cartier exactness of F³σ gives
\[
\Omega_*=
\frac{C(\alpha D^5F^3\sigma+F^7V\sigma)}{F}
=C(F^2V\sigma).
\]
The interpolant ambiguity becomes V→V+Fu, so its effect is precisely the same image \(\mathscr I_F\).

For the operator formula, F is a p-basis of k(Y)/k(Y)⁵ because dF≠0. The derivation δ=d/dF annihilates k(Y)⁵, sends F to ONE, and satisfies δ⁵=0. Every rational h has a unique expression h=∑j=0⁴ hj⁵Fj. Then−δ⁴h=h4⁵, since4!=−1 in characteristic FIVE, and Cartier gives C(hdF)=h4dF. Apply this to h=F³u/D and dF=Dσ to obtain exactly the stated formula. The bracket is a fifth power, so its fifth root is an actual rational function, not a choice of a field extension.

The identity dD=FEσ gives δD=FE/D. Consequently the displayed fourfold derivative operator is determined by F,D,E and derivatives of u; this supplies a bounded exact rank calculation if needed. It does not yet show that E alone determines the rank. The basis1,z,z²,z³,y spans L(6P), and the constant column is zero by the already established Cartier gate.

The obstruction is a global necessary condition for the actual carrier. It neither supplies a global Hermitian subfield nor decides the original common-cover problem.
