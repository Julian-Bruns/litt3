# Proof: odd atlas identity and the even-normalizer involution pattern

Version1. [Statement](../../Theorems/cartier_and_spin/canonical_ten_normal_abelian_row_identity.md). New conceptual consequence; focused review pending. Both original endpoint maps remain upstairs.

## The accepted odd uniform-atlas theorem applies literally

The [actual determinant-root atlas](canonical_ten_normal_abelian_etale_row_atlas.md) gives a representable finite étale map
\[
Y\longrightarrow[E/A_6]
\]
of odd degree ℓ, with its full actual quotient action retained. Its coarse separating map has COMPLETE uniform local fibers, with one identical Galois completed local extension type throughout each branch fiber. Indeed after base change along E the source is étale over E; over the algebraically closed residue field, the relevant completed étale local charts are isomorphic. Each inertia acts freely on its chart fiber, so its order divides ℓ. These are exactly the hypotheses of the accepted [odd uniform genus-two atlas exclusion](../quotient_geometry/endpoint_exclusions/odd_uniform_genus_two_atlas_exclusion.md), whose independent whole review is [PASS](../../Research/audits/ODD_UNIFORM_GENUS_TWO_ATLAS_AUDIT_2026_10_03.md).

Thus ℓ=ONE. A representable finite étale map of degree ONE is an isomorphism, so [E/A₆]=Y is a scheme and the A₆ action is free. Also C→D′ has degree ONE, hence D′=C. The retained map C→D is consequently the canonical cyclic étale trivializer of χ, of degree e equal to its order.

## Its cyclic deck has order at most two

Let S be the cyclic deck group of C→D. Its action commutes with R: S acts by root-of-unity multiplication on the canonical cyclic trivializer of the R-linearized χ, and the R action commutes with these constant multiplications. It therefore acts on Y=C/R. This action is faithful. An element acting trivially on Y is in the actual deck group R of C→Y; an element of S∩R acts trivially on D and is therefore trivial because R acts faithfully on D.

The selected Y has Aut(Y)=C₂. Thus S is trivial or has order TWO. In the latter case its nontrivial element σ acts freely on C and induces the hyperelliptic involution ι on Y. We rule out that case by the actual trace fibers.

## Every involution of the full even paired normalizer has pattern two plus two

Use the standard four-dimensional Pauli model for A=C₂⁴. Its projective nonidentity elements are tensor products of two Pauli matrices; each has trace ZERO because at least one factor is traceless. They are projective involutions with two eigenvalues of multiplicity TWO each.

Now let r∈R be an involution with nontrivial image in R/A=A₆. Every involution of A₆ has double-transposition cycle type in its SIX-letter action. In the symplectic model all these images are conjugate to the image of H⊗H, where
\[
H=\frac1{\sqrt2}\begin{pmatrix}1&1\\1&-1\end{pmatrix},
\qquad Y_0=\begin{pmatrix}0&-i\\i&0\end{pmatrix},
\qquad i^2=-1.
\]
To see the parity here, conjugation by H interchanges the X and Z Pauli labels on ONE two-dimensional factor and fixes their sum: it is a symplectic transvection, corresponding to a transposition on the SIX odd quadratic refinements. The two tensor factors give TWO distinct commuting transpositions. Their product has double-transposition type. The full even paired normalizer realizes its conjugating symplectic operators, so after conjugation r=a(H⊗H) projectively for some a∈A.

The projective condition r²=ONE requires a to be fixed by H⊗H. Its four fixed labels are
\[
1,quad Y_0\otimes1,quad1\otimes Y_0,quad Y_0\otimes Y_0.
\]
The resulting four representatives are tensor products with each factor either H or Y₀H. Both matrices are traceless. All four representatives therefore have trace ZERO. A nonscalar projective involution in characteristic FIVE has eigenvalue ratio −ONE. Multiplicities ONE andTHREE would give nonzero trace ±TWO times a scalar, whereas multiplicities TWO andTWO give zero. Thus EVERY involution in R, including those in A, has the asserted projective TWO-plus-TWO pattern. This explicit argument makes no blanket assertion about the order of the full multiplier.

## The actual hyperelliptic trace fibers give a contradiction

Because C→D is étale and J_C is the actual pullback of the embedded J_D, the deck σ has a canonical action on J_C compatible with its inclusion in B_C. This action commutes with the actual R-action. Descending along the R-torsor C→Y gives a genuine ι-linearization on the ORIGINAL embedded J_Y.

At any of the SIX Weierstrass points W of Y, choose c∈C above W. There is a unique r∈R with σc=rc. Commutation and σ²=ONE imply r²=ONE, since R acts freely on C. Also r≠ONE because σ acts freely. The equality φσc=φc makes r fix the corresponding point of D. The action of ι on the J_Y fiber at W is therefore, up to inverse and scalar, the projective coefficient action of r on the J_D fiber. The preceding involution calculation makes its pattern TWO plusTWO. Since this is a GENUINE order-two fiber action, its determinant is +ONE.

Consequently the induced ι-linearization on detJ_Y has fiber character +ONE at ALL SIX Weierstrass points. But the accepted [exact distinguished determinant](canonical_degree_ten_prime_to_five_quotients.md) is detJ_Y=O_Y(P), where P is the distinguished Weierstrass point. The natural ι-linearization of O_Y(P) has character −ONE at P and +ONE at the other FIVE fixed points: a local pole generator at P transforms by the inverse tangent character. Any other linearization differs by a SINGLE global character of C₂, so it changes all SIX signs together. Neither possible sign pattern is constantly +ONE. This contradicts the actual determinant fiber action.

Thus S is trivial and e=ONE. The row normalization target is C itself. The already extracted E=C/A is the actual degree360 A₆-Galois étale cover of Y of genus361. All original maps remain on T; no X-field descends by this argument.
