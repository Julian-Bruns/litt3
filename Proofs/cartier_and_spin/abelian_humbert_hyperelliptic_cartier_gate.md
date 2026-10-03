# Proof: exact Kummer coordinates and the full twisted Cartier kernel

Version2,3 October2026. [Root whole-scope review PASS](../../Research/audits/ABELIAN_HUMBERT_QUADRATIC_MODEL_AND_CARTIER_GATE_AUDIT_2026_10_03.md); Version2 adds the exact determinant norm. [Statement](../../Theorems/cartier_and_spin/abelian_humbert_hyperelliptic_cartier_gate.md). Inherit both original finite étale maps, the actual coefficient cover C and inclusion q_C*J_Y=P⊗V4⊂B_C, and the [quadratic model](abelian_humbert_row_quadratic_hyperelliptic_model.md). No computation or whole branch exclusion is claimed.

## The cubics and actual hyperelliptic field

Replace the row coordinates by Y₀=X₀+X₂,Y₁=X₀−X₂,Y₂=X₁+X₃,Y₃=X₁−X₃. The four invariant quadrics are then an invertible linear combination of Y₀²,Y₁²,Y₂²,Y₃². On the twisted cubic their restrictions are four independent sections of O(3). Choose a base coordinate x whose infinity avoids all their zeros. They become degreeTHREE polynomials F_i with nonzero leading coefficients.

The scheme-theoretic quadratic inverse-image description gives the displayed Kummer ratio field. It has degreeEIGHT over k(x), since the actual C→E→P¹ has degreesFOUR andTWO. The subgroup A[2] acts by the four distinct character signs on the Y_i, with product of those signsONE. Its quotient therefore has field k(x,√(F₀F₁F₂F₃)). This is the actual E, of genusFIVE. A double cover defined by a product of four cubics has at mostTWELVE branch values; genusFIVE requires exactlyTWELVE. Consequently every root is simple, the four root sets are pairwise disjoint, and infinity is unramified. Rescale y to arrange y²=Φ exactly.

## Descent with its actual linearizations

Use the genuine A[2] action on Arow from the Schrödinger coordinate lifts. Its square descends to K=H³ on E, while ω_C descends to ω_E=H⁴ through the actual étale quotient. Hence Arow⁸ω_C⁻³ descends to K⁴ω_E⁻³=O_E with its trivial character. This keeps the descent ambiguity that an underlying line equality alone would miss.

The exact identity P=Arow³ω_C⁻¹ therefore equips P with an A[2] linearization for which P³=Arow as LINEARIZED lines. Let R denote its descent. Then
\[
R^2=K^3\omega_E^{-2}=H,\qquad R^8=\omega_E.
\]
The FOUR coefficient eigenline descents are R_i=R⊗η_i for the FOUR characters η_i of the actual A[2]-torsor C→E. Their squares are all H, and each has an actual integral inclusion R_i⊂B_E, by étale Cartier base change and the original inclusion P⊗V4⊂B_C. Their actual Frobenius adjunction lines are consequently ω_E R_i⁻⁵=R_i³.

Each adjunction eigenspace has dimensionONE. Indeed its pullback is one of the FOUR distinct character spaces in the complete four-dimensional H⁰(P³), and the corresponding row section is Y_i. Its zero divisor on E is D_i, the THREE Weierstrass points over the roots of F_i. Squaring Y_i and using P²=π*H identifies R_i⁶=H³ and gives this exact divisor. In particular R_i=O_E(D_i−H), since R_i³=O_E(D_i) and R_i²=H.

## The actual determinant is an even theta characteristic

The same finite étale eigenline adjunction used for the cyclic-four induction applies to f_E:E→Y with groupV₄. Namely R_i→f_E*J_Y induces f_E*R_i→J_Y. The FOUR columns upstairs are distinct coefficient eigenlines, so this is full rank; source and target degrees are bothONE, hence it is an isomorphism. Since f_E*O_E is the sum of its FOUR orderTWO character lines, its determinant is their product, which isTRIVIAL. Therefore detJ_Y=Norm_f R_i.

The residual V₄ permutes the four cubics simply transitively. No TWO roots of a seed cubic lie in the same residual V₄ orbit: translating one to the other would give a repeated root in the product Φ. Thus D_i contains exactlyONE point from each of the THREE branch orbits. On the actual quotient Y the corresponding three points W_a,W_b,W_c are distinct Weierstrass points; the hyperelliptic involution of E descends to the hyperelliptic involution of Y, since its quotient is the rational curve P¹/V₄. Hence Norm_f D_i=W_a+W_b+W_c.

Writing M=detJ_Y, the identity R_i³=O(D_i) gives M³=O(W_a+W_b+W_c), so M⁶=ω_Y³. The quadratic model already gives M⁴=ω_Y². For χ=M²ω_Y⁻¹ these give χ³=χ²=O, hence χ=O. Therefore M²=ω_Y and M=O(W_a+W_b+W_c)ω_Y⁻¹.

This theta characteristic has no section. An effective degreeONE theta characteristic would be O(W) for a Weierstrass point W. Its cube would then be ω_Y(W), whose degreeTHREE pencil has the fixed point W and a moving hyperelliptic pair; it cannot contain a divisor of THREE distinct Weierstrass points. The TEN complementary three-plus-three partitions give the usual distinct even theta characteristics. This is an exact norm calculation on the actual cover, not a point-torsion exclusion for an arbitrary determinant line.

## Ordinary differential representatives of the four twisted maps

Let H∞ be the TWO-point unramified infinity fiber. Then div(dx/y)=FOUR H∞ and divF_i=TWO D_i−THREE H∞. Choose the rational line frame for R_i=O(D_i−H∞). The Frobenius-adjoint map R_i→B_E is represented by an ordinary rational differential whose divisor is
\[
5(D_i-H_\infty)+D_i=6D_i-5H_\infty.
\]
Up to a nonzero constant this is exactly F_i³ dx/y. Thus its ACTUAL Cartier condition is C(F_i³ dx/y)=ZERO. The standard hyperelliptic Cartier formula in characteristicFIVE gives
\[
C\left(F_i^3\frac{dx}{y}\right)
=\frac{1}{y}C\left(F_i^3\Phi^2\,dx\right)
=\frac{F_i}{y}C\left(G_i^2\,dx\right).
\]
The last equality uses Φ=F_iG_i and pulls the fifth power F_i⁵ through Cartier. Since F_i/y is nonzero, the desired vanishing is equivalent to C(G_i²dx)=ZERO. A polynomial differential of degreeEIGHTEEN is killed by Cartier precisely when its coefficients in degreesFOUR,NINE,FOURTEEN areZERO. This proves all four explicit gates with the actual line frames, rather than treating the four Frobenius descents as an arbitrary ordinary Cartier map on regular differentials.

## Why the full gate has three representation scalars

The original inclusion P⊗V4⊂B_C says exactly that ALL FOUR sections of ω_C F*P⁻¹=P³ are in the twisted Cartier kernel. They exhaust that space by the complete row theorem. Thus C_P on H⁰(P³) must be zero.

The line P has primitive orderFOUR projective multiplier. A nonzero invariant space of its sections has dimension divisible byFOUR by taking determinants. But degP=FOUR and Clifford bounds h⁰(P) byTHREE, so h⁰(P)=ZERO. Riemann–Roch, using ω_C=P⁸, gives h⁰(P⁷)=TWELVE.

For a perfect primitive multiplier on A=C₄×C₄ the twisted group algebra is Mat₄(k). Hence H⁰(P³) is its unique FOUR-dimensional irreducible module, and H⁰(P⁷) consists of THREE copies. Cartier is Frobenius-semilinear and equivariant for the actual deck action. Its source and target multiplier classes agree after that twist: the fourth roots of unity lie in F₅, and 3α=7α moduloFOUR. Semisimplicity is valid since the finite central extension has order prime toFIVE. Schur's lemma therefore identifies the map with THREE Frobenius-semilinear intertwiner scalars. They must all vanish.

## The quadratic syzygy is not already a Cartier inclusion

One cannot replace these scalar tests by an asserted positive rankTWO Cartier plane from the Hilbert–Burch syzygies. That proposed finite coefficient bundle would pull to P²⊗S2. Its adjunction line has degree deg(ω_C P⁻¹⁰)=THIRTY TWO−FORTY=MINUS EIGHT; consequently every map from it to B_C isZERO. Evaluating the quadratic matrix does instead produce ordinary differential-valued coefficients using P²Arow²=ω_C. These have not undergone Frobenius adjunction and do not supply the prohibited nonzero Cartier map.
