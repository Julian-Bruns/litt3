# Proof of free-Levi half-class parity and kernel cohomology

Version1, 3 October2026. Retain the exact actual curve/module/root
and optional upstairs line hypotheses of the
[statement](../../../Theorems/quotient_geometry/local_actions/actual_psl_eight_free_levi_half_class_and_kernel_cohomology.md).
The component arguments have independent
[parity review PASS](../../../Research/notes/oct03_ten_hour/eight_module_actual_free_levi_halfclass_parity_audit.md)
and [cohomology review PASS](../../../Research/notes/oct03_ten_hour/eight_module_actual_kernel_cohomology_dichotomy_audit.md).
Their original unchanged source notes are
[the free-Levi argument](../../../Research/notes/oct03_ten_hour/eight_module_actual_free_levi_halfclass_parity.md)
and [the general kernel dichotomy](../../../Research/notes/oct03_ten_hour/eight_module_actual_kernel_cohomology_dichotomy.md).
No computation is used.

## The displayed subgroup misses every actual inertia conjugate

The lift \(\operatorname{diag}(SL_7(\mathbf F_5),1)\subset H\)
intersects \(\mu_4\) trivially, hence embeds in \(Q\).
Every element of this subgroup fixes the rational line
\(\mathbf F_5e_8\).
The retained projective tame class has determinant-one lifts with
eigenvalues \(\pm\zeta\lambda\), \(\zeta\in\mu_4\subset\mathbf F_5\),
and \(\lambda^4=-1\). These eigenvalues lie outside \(\mathbf F_5\).
It has no rational eigenline, and no conjugate lies in \(S\).

An order-five member of \(S\) has the lift
\(\operatorname{diag}(A,1)\), with \(A^5=I\): if its fifth power
were scalar, its last entry makes that scalar one.
This unipotent lift has a direct \(J_1\) block.
It cannot be conjugate to either actual wild partition, which
has no such block. All nonidentity powers retain the same partition.
Multiplying a lift by a scalar cannot alter this test, since a
unipotent order-five lift has eigenvalue one and forces that scalar
to be one.
The actual wild, tame and trivial stabilizers exhaust all points.
Thus \(S\) acts freely on \(D\).

The quotient \(Z=D/S\) is an ACTUAL smooth projective curve and
\(D\to Z\) is finite étale.
Restriction of the specified \(H\)-action on \(P\) to its displayed
copy of \(S\) is a genuine \(S\)-linearization.
Faithful étale descent gives \(\bar P\) on \(Z\).
The given same-action fourth-power comparison and étaleness give
\(\bar P^4=\omega_Z\).

## Exact odd degree

The finite special-linear order formula gives
\[
\frac{|SL_8(\mathbf F_5)|}{|SL_7(\mathbf F_5)|}
       =5^7(5^8-1).
\]
Using \(|Q|=|SL_8(\mathbf F_5)|/4\) and
\(\deg P=|Q|/40\),
\[
\deg\bar P
=\frac{|Q|}{40|S|}
=\frac{5^7(5^8-1)}{160}
=12207\cdot5^6,
\]
since \(5^8-1=32\cdot12207\).
This integer is odd. The equality
\(2g(Z)-2=4\deg\bar P\) gives \(g(Z)\equiv3\pmod4\).

## Any actual upstairs half-class restricts with order two

The group \(\widetilde S\) acts freely on the actual \(\Gamma\).
A nonidentity fixed element would either project to a nonidentity
member of the already free \(S\), or belong to the already free \(N\).
Its quotient is \(Z\), since
\(k(\Gamma)^{\widetilde S}=k(D)^S\).

The specified same-action \(M^2=\pi^*P\) and genuine action on
the descended \(\bar P\) give
\[
2\operatorname{res}_{\widetilde S}\beta=0.
\]
If that restriction were zero, \(M\) would be genuinely
\(\widetilde S\)-linearizable and descend along this actual finite
étale torsor to a line on \(Z\).
Its degree would necessarily be
\[
\frac{\deg M}{|\widetilde S|}
 =\frac{|N|\deg P/2}{|N||S|}
 =\frac{12207\cdot5^6}{2},
\]
which is not integral. This is impossible for a line on a smooth
projective curve. The restriction therefore has exact order two.
The proof never assumes a complement to \(N\).

## Central closure and the low-degree kernel edge

Use the primary finite-\(SL_n\) central-closure theorem:
Steinberg's
[§7 Corollary2 after Theorem14](https://www.math.utah.edu/~ptrapa/math-library/steinberg/steinberg-yale-notes.pdf#page=102),
printed page95, explicitly covers every finite field and \(n\ge5\).
Both focused audits verified its applicability to \(SL_7(\mathbf F_5)\).
Elementary commutators give perfectness, and central closure gives
\[
H^2(S,k^\times)=0.
\]

Inner automorphisms of \(N\) act trivially on
\(N^\vee=\operatorname{Hom}(N,k^\times)\), so conjugation by any
lift of an element of \(S\) gives a well-defined coefficient action.
The Lyndon--Hochschild--Serre low-degree exact sequence for
\(1\to N\to\widetilde S\to S\to1\) contains
\[
H^2(S,k^\times)\longrightarrow
\ker[H^2(\widetilde S,k^\times)\to H^2(N,k^\times)]
\longrightarrow H^1(S,N^\vee).
\]
Its first group is zero. Hence the kernel injects into the last group.
If \(\operatorname{res}_N\beta=0\), the preceding exact-order-two
restricted class maps to an exact-order-two nonzero cohomology class.
Otherwise its restriction to \(N\) itself has exact order two.
This proves assertion3 without an abelian, split or Kummer hypothesis.

For elementary abelian two-kernel, divisibility of \(k^\times\)
identifies \(H^2(N,k^\times)\) with alternating bilinear forms
on \(N\), using the commutator pairing.
A restriction of a \(\widetilde S\)-class is invariant under its
conjugation action. Also \(N^\vee=N^*\) over \(\mathbf F_2\).
This is a form on the KERNEL, with no conclusion for \(W\).

## Every actual square-root orbit has nonzero Levi restriction

Square roots \(R^2=P\) exist on \(D\).
Indeed \(\deg P=|S|\deg\bar P\) is even, and multiplication by
two on \(\operatorname{Pic}^0(D)\) is surjective.
If such an \(R\) were invariant as an underlying \(S\)-line class,
the obstruction just shown to vanish in \(H^2(S,k^\times)\)
would make it genuinely \(S\)-linearizable.
It would descend to a line of degree \(\deg\bar P/2\), impossible.
Thus no actual root is \(S\)-invariant.

In additive Picard notation,
\(\delta_g=gR-R\) is a cocycle with values in the actual
orbit-span \(U\subset\operatorname{Pic}^0(D)[2]\).
If its restriction were zero in \(H^1(S,U)\), write
\(\delta_s=s u-u\) for an actual \(u\in U\).
Then \(R-u\) would still square to \(P\) and would be
\(S\)-invariant, contradicting the preceding paragraph.
Hence the restriction class is nonzero.

For the actual canonical Kummer cover with deck \(N=U^*\),
the line \(M=\pi^*R\) carries its natural genuine deck-group action.
Thus the restriction to \(N\) is zero and assertion3 forces the
first-cohomology alternative, in agreement with the direct affine proof.
This extra identification is kept separate from an arbitrary
original kernel.

No statement asserts that a previously constructed abstract
extension violates these restrictions. No curve or full source
is realized. The actual original line comparison, carrier and
both original finite étale legs remain on their prescribed source.
