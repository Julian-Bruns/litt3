# Translate-free Raynaud theta loci and finite étale targets

Author: `/root`. Date: 2026-09-05.
Status: author proof combining the checked non-Galois descent theorem,
the finite-support Boxall argument, and a personally inspected theorem of
Tong. The combined statement has not received a separate audit.
No novelty or solution of Litt's problem is claimed. Older notes are retained.

## 1. A geometric hypothesis replacing Jacobian simplicity

Let (k=\overline{\mathbf F}_p), and let (C/k) be a smooth projective
connected curve of genus at least two. Write

\[
 A=J(C^{(1)}),\qquad
 \mathcal B_C=F_{C/k*}\mathcal O_C/\mathcal O_{C^{(1)}},\qquad
 \Theta_C=\{L\in A:H^0(C^{(1)},\mathcal B_C\otimes L)\ne0\}.
\]

The last locus is the support of Raynaud's proper theta divisor. Assume

\[
 \Theta_C\text{ contains no translate of a positive-dimensional
 abelian subvariety of }A.                              \tag{1.1}
\]

Fix a finite set (S) of primes not containing (p). Put

\[
 N_n=\prod_{\ell\in S}\ell^n,
\]

and let (C_n/C) be the connected maximal abelian étale cover of exponent
(N_n), with compatible base points. Its degree is (N_n^{2g(C)}).

**Theorem 1.** Under (1.1), there is a level (m=m(C,S)) such that:

1. The Prym of (C_n/C_m) is ordinary for every (n\ge m).
2. For every hyperbolic curve (T) whose Jacobian has no ordinary simple
   isogeny factor, every finite étale map (C_n\to T), (n\ge m),
   descends to a finite étale map (C_m\to T).
3. Only finitely many such (T), up to geometric isomorphism and with no
   genus bound imposed in advance, admit a common finite étale cover with
   (C) whose leg to (C) is abelian with prime support in (S).
4. Every actual correspondence of this kind admits a common intermediate
   diagram (C\leftarrow D\to T), both maps finite étale, with
   (\deg(D/C)\le N_m^{2g(C)}).

No Galois condition is imposed on the map to (T). The same (m) works
for all the stated targets and all covering degrees.

### Proof

The finite-support torsion decomposition, proved in
[Section 2 of the two-leg rectangle note](ORDINARY_MIXED_BLOCKS_IN_TWO_LEG_ABELIAN_RECTANGLES.md#2-finite-support-torsion-cosets-give-horizontal-and-vertical-strips)
using the full Boxall dimension induction, writes

\[
 \Theta_C(k)\cap A[S^\infty](k)
   =\bigcup_i\bigl(t_i+B_i[S^\infty](k)\bigr),
 \qquad t_i+B_i\subset\Theta_C,
\]

with finitely many abelian subvarieties (B_i) and (S)-primary
translations (t_i). Hypothesis (1.1) forces every (B_i=0). Thus this
torsion intersection is finite; choose (m) killing every point in it.

The character decomposition of (H^1(C_n,\mathcal O_{C_n})) separates
the characters factoring through (C_m/C) from the remaining ones.
Absolute Frobenius permutes their labels by (L\mapsto L^p), so both
blocks are stable. On a character block, the relative Frobenius sequence
identifies the kernel with (H^0(\mathcal B_C\otimes L)), up to scalar
twist. Every label in the remaining block lies outside (\Theta_C).
Frobenius is therefore injective, hence bijective, on that entire block.
Since the cover degree is prime to (p), this proves that the Prym of
(C_n/C_m) is ordinary. In particular (g(C_n)-f(C_n)) is eventually
constant. This argument bounds the whole nilpotent part, not only the
first Frobenius kernel.

An ordinary abelian variety has no nonzero homomorphism to a Jacobian
having no ordinary simple factor. Theorem A of
[the checked non-Galois descent theorem](NONGALOIS_JACOBIAN_ORTHOGONALITY_AND_ETALE_MAP_STABILIZATION.md)
therefore makes every map in part 2 descend, retaining étaleness.

The fixed curve (C_m) has finitely many hyperbolic étale quotient
curves. Indeed their degrees are at most (g(C_m)-1) by
Riemann–Hurwitz. Their Galois closures over (C_m) have bounded degree,
so there are finitely many such closures by finite generation of its
étale fundamental group; each has finite automorphism group. This proves
part 3.

Finally embed an arbitrary connected abelian (S)-cover (W/C) in some
(C_n/C), with (n\ge m). Pull its actual étale map (W\to T) to
(C_n) and descend it to (C_m). Inside (k(C_n)) the joint image field

\[
 k(D)=k(C)\,k(T)\subset k(W)\cap k(C_m)
\]

has degree over (k(C)) at most (N_m^{2g(C)}). Both normalization maps
(D\to C,T) are intermediate maps of the original étale maps from (W),
and hence are étale. This proves part 4 without assuming (W) contains
(C_m). ∎

## 2. Application to every ordinary genus-two curve

**Corollary 2.** Theorem 1 applies to every ordinary genus-two curve over
(\overline{\mathbf F}_p), whether its Jacobian is simple or split.
In particular it applies in characteristic five.

### Proof

[Tong, Corollary 4.2.3.3](https://arxiv.org/pdf/0712.2046), proves that
every irreducible component of (\Theta_C) is ample when (C) is
ordinary of genus two. Its Jacobian is a surface. Any positive-dimensional
proper abelian translate contained in the divisor would therefore be an
elliptic curve and an entire irreducible component. Such a component has
self-intersection zero, whereas an ample divisor on a surface has positive
self-intersection. This is impossible. Thus (1.1) holds. ∎

The relevant source proof has been inspected, not only its statement:
Tong's Corollary 4.2.2.1 excludes elliptic components meeting the
(p)-torsion using Cartier forms and tangent spaces; Proposition 4.2.3.2
excludes the remaining elliptic components using vector bundles on an
elliptic curve. The cohomology dimensions used there depend essentially
on genus two. We do not extend this part of Tong's theorem to higher genus.

For a geometrically simple Jacobian, (1.1) holds in every genus simply
because the theta divisor is proper. Thus Theorem 1 also recovers the
earlier simple-base theorem. That note remains in place: it contains the
finite-support translation proof and the separate initial-cover variant.

## 3. Exact limitations

The result is uniform in covering degree and target genus, not in the
finite prime set (S). Taking a union over all (S) need not leave a
finite set of targets. It also does not cover nonabelian monodromy.

In particular, it gives no bound for the recursive tower forced by an
arbitrary common-cover diagram. Finite prime support of such a tower is
not enough: its successive groups need not be abelian. Nor does this
corollary imply the corresponding theta noncontainment for an arbitrary
initial étale cover (Z\to C), whose genus is larger.
