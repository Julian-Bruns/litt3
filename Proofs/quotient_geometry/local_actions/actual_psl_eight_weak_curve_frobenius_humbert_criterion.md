# Proof: the actual fixed-curve Frobenius realization criterion

Version1. See the
[statement](../../../Theorems/quotient_geometry/local_actions/actual_psl_eight_weak_curve_frobenius_humbert_criterion.md).
The original self-contained
[author note](../../../Research/notes/oct03_ten_hour/eight_module_fixed_humbert_frobenius_curve_criterion.md)
and its
[independent audit](../../../Research/notes/oct03_ten_hour/eight_module_fixed_humbert_frobenius_curve_criterion_audit.md)
retain provenance. The
[focused scope extension](../../../Research/notes/oct03_ten_hour/eight_module_original_source_orbifold_bundle_bridge_audit.md)
checks the replacement of the particular \(J_5\oplus J_3\) class by
ANY specified nontrivial order-five class on BOTH sides.

## Fixed actual stack and projective Lang torsor

The
[Humbert uniformization theorem](../../../Theorems/cartier_and_spin/canonical_degree_ten_humbert_target_uniformization.md)
supplies the actual fixed ordinary \(H\), its order-eighty \(R\)-action,
and matched weak/tame quotient stack.
The
[two-point wild Picard theorem](../../../Theorems/quotient_geometry/local_actions/two_point_wild_orbifold_picard_group.md)
gives the genuine Picard presentation. With reduced stack divisors
\(D_5,D_2\) and the coarse line \(U\), it has
\(5D_5=2D_2=U\).
The actual different exponents EIGHT and ONE give
\[
\omega_{\mathcal S}=-2U+8D_5+D_2.
\]
Its degree \(1/10\) is the primitive positive degree; thus
\(\operatorname{Pic}(\mathcal S)=\mathbf Z[\omega_{\mathcal S}]\).
This is an actual wild quotient stack, not a tame root-stack model.

Projectivizing the specified absolute Frobenius comparison of \(E\)
gives a Frobenius structure on its \(PGL_8\)-frame torsor.
For connected smooth \(PGL_8/\mathbf F_5\), Lang's map is a finite
étale torsor under \(PGL_8(\mathbf F_5)\).
The compatible-frame construction descends on the actual atlas \(H\).
A primary precise formulation is Theorem I and Lemma2.1 of
[Lei Zhang, The Lange--Stuhler Theorem via Gerbes](https://arxiv.org/html/2609.25665v1).
Only the classical connected smooth case and its stack descent are used.
Absolute Frobenius is treated over \(\mathbf F_5\); no identification
of a \(k\)-curve with its relative Frobenius twist is required.

The determinant quotient
\(PGL_8(\mathbf F_5)/Q=C_4\) would give an étale constant \(C_4\)-torsor
on \(\mathcal S\). Kummer, algebraically closed constants and the
torsion-free genuine Picard group give
\[
H^1_{\rm et}(\mathcal S,\mu_4)
=\operatorname{Pic}(\mathcal S)[4]=0.
\]
Therefore the Lang image is contained in \(Q\).
This does not exclude proper subgroups.
Taking determinants of the specified Frobenius comparison gives
\((\det E)^4=\omega_{\mathcal S}^8\), hence
\(\det E=\omega_{\mathcal S}^2\).

## The tame rational class is forced by the SAME Frobenius map

At a tame point let \(c\) be the actual geometric order-two action on
the \(E\)-fiber. The canonical fiber has character minus ONE.
The Frobenius comparison consequently yields an invertible
five-semilinear operator \(J\) satisfying
\[
Jc=-cJ.
\]
It exchanges the two geometric eigenspaces, so they both have
dimension FOUR.

In a Lang-compatible projective basis write \(J=a\sigma\), where
\(\sigma\) is coordinatewise fifth power and \(a\in k^\times\).
The conjugated geometric order-two matrix \(c'\) then satisfies
\[
c'^{[5]}=-c'.
\]
Its projective class is defined over \(\mathbf F_5\).
Choose any rational representative \(C=\lambda c'\in GL_8(\mathbf F_5)\).
The equality \(C^{[5]}=C\) forces \(\lambda^5=-\lambda\), hence
\(\lambda^4=-1\).
The eigenvalues of \(C\) are \(\pm\lambda\), each FOUR times, and
\[
\det C=\lambda^8=1,\qquad C^2=\lambda^2 I.
\]
The scalar square \(\lambda^2\in\mathbf F_5^\times\) is a nonsquare
of exact order FOUR. Thus \(C\in SL_8(\mathbf F_5)\) has order EIGHT.
Rational scalar rescaling preserves these conclusions.

For each FIXED scalar square \(C^2=2I\) or \(C^2=3I\), there is
one such \(SL_8\) conjugacy class: its \(GL_8\)-centralizer is
\(GL_4(\mathbf F_{25})\), whose determinants onto
\(\mathbf F_5^\times\) are surjective by the norm, so a
\(GL_8\)-conjugator has its determinant corrected.
The two \(SL_8\) classes are distinct, since conjugation preserves
the scalar square. Multiplication by a central
\(\mathbf F_5^\times\) scalar exchanges the two squares, so they
give ONE projective \(Q\)-class. Balanced geometric dimensions
alone would not distinguish this from the split rational class.

## From the actual bundle to the actual curve and calibrated root

Assume the EXTRA full natural \(Q\)-image.
A connected \(Q\)-component \(D\) of the finite étale Lang torsor on
\(\mathcal S\) is representable over \(\mathcal S\).
Its total-space inertia is the kernel of base inertia into \(Q\).
The specified nontrivial order-five wild class is injective projectively,
and the tame class just proved is nonscalar. Both kernels are trivial.
Thus \(D\) is a smooth proper connected algebraic-space curve with
trivial inertia, hence an actual scheme curve.
Its quotient stack is \(\mathcal S\).
Its completed weak/tame fields, not just their numerical conductors,
are those of this fixed stack.
Hurwitz gives \(g(D)-1=|Q|/20\).

The compatible projective frame gives
\[
E|_D=P_D\otimes W
\]
for an ACTUAL invariant line. Use right frames
\(f(dg)=f(d)g\) and left deck action \(g\cdot d=dg^{-1}\).
Frame coordinates then transform by the NATURAL matrix \(g\), so
\(\operatorname{ob}(P_D)=-\alpha_Q\).
Equivalently the scalar center of \(SL_8(\mathbf F_5)\) acts inversely
on \(P_D\) and naturally on \(W\); the cancelling tensor is genuine.
No contragredient relabeling is made.

The pulled specified Frobenius comparison is scalar on the compatible
constant \(W\)-frame, whose matrices are literally fixed by fifth
powers. It gives
\[
P_D^5=P_D\otimes\omega_D,\qquad P_D^4=\omega_D.
\]
The fourth power has a genuine \(Q\)-action.
Its comparison with the canonical line is equivariant: a discrepancy
is a character of perfect \(SL_8(\mathbf F_5)\), hence trivial.
This supplies the calibrated root and its SAME actions.
It does not deduce a theta-characteristic on a different endpoint.

## From the calibrated actual curve to the bundle

Conversely retain the ACTUAL \(D,P_D\).
The matched completed-local uniformization identifies \([D/Q]\)
with the fixed \(\mathcal S\) after global scaling of the wild
coarse parameter.
The paired actions on \(P_D\otimes W\) cancel their central scalars,
giving a genuine \(Q\)-bundle, hence a bundle \(E\) on \(\mathcal S\).

The literal \(\mathbf F_5\) matrices and SAME-action root identity give
\[
F_{\rm abs,D}^*(P_D\otimes W)
=P_D^5\otimes W
=(P_D\otimes W)\otimes\omega_D.
\]
Effective étale descent supplies the specified Frobenius comparison.
Its compatible projective Lang torsor is the extension of the original
faithful \(Q\)-torsor by \(Q\subset PGL_8(\mathbf F_5)\), so its image
is FULL. This direction supplies full image from the actual input,
not from genericity or stability.
The wild scalar character is trivial in characteristic FIVE, so the
specified natural order-five Jordan class is retained.
This argument uses no particular nontrivial order-five partition.

## The fixed Humbert curve retains the full image

The coarse actual \(D/\mathbf P^1\) and \(H/\mathbf P^1\) are Galois
with groups the nonabelian simple \(Q\) and solvable \(R\).
Their intersection is a common Galois quotient and is trivial.
Their actual compositum is therefore connected with group \(Q\times R\).
Matched completed fields make it finite étale over \(H\).
Thus \(E_H\) retains full natural \(Q\)-monodromy.

On that actual connected \(Q\)-torsor, \(E_H\) is one scalar line times
the irreducible constant \(W\). Dividing by that line rules out
positive-slope subbundles of the resulting trivial bundle.
An equal-slope subbundle would be constant and contradict irreducibility.
The same argument applies after every Frobenius pull.
This is the scalar-cover lemma of the accepted
[finite-source stability proof](../../../Proofs/cartier_and_spin/actual_finite_source_strong_semistability_and_cartier_surjectivity.md);
none of that theorem's original Cartier or source-kernel conclusions
is imported here.
Hence \(E_H\) is strongly stable, has determinant \(\omega_H^2\),
and degree SIXTEEN.

## The exact realization gap

An actual curve satisfying these inputs admits the registered
[canonical quarter-root/Kummer half-class refinement](../../../Theorems/quotient_geometry/local_actions/actual_psl_eight_weak_curve_canonical_root_and_etale_half_class.md).
This criterion constructs neither the full-image periodic bundle
nor its input curve. It supplies no original Cartier map, degree-ten
carrier or row, and no original \(X\)-leg.
BOTH original étale endpoint maps remain on their SAME original \(T\).
