# Finite projective orbits give twisted symmetric sections

This proves
[the rank-two restriction](../../Theorems/cartier_and_spin/rank_two_projective_monodromy.md).
Use the accepted all-twist vanishing in
[degrees one through four](../../Theorems/cartier_and_spin/low_degree_twist_vanishing.md)
and [degree five](../../Theorems/cartier_and_spin/fifth_symmetric_twist_vanishing.md).

A finite coefficient is semistable of degree zero: an etale
trivializing cover takes any positive-degree subbundle to a forbidden
subbundle of a trivial bundle. If R had a one-dimensional invariant
subrepresentation, it would be an extension of two degree-zero finite
lines. Every map from either line into K is zero by the degree-one
all-twist vanishing, so Hom(R,K) would vanish. Thus R is irreducible.

For a nonzero map R->K, a rank-one image would be a torsion-free
quotient of R of nonnegative degree. Its saturation in K would be a
line of nonnegative degree, again impossible. The map has rank two
generically, hence is an injection with torsion cokernel of length one.

Choose a finite monodromy representation on a two-dimensional vector
space W. If its projective action preserves an orbit of m lines,
choose a nonzero vector on each line and multiply the vectors in
Sym^m W. The product is nonzero and its span is a one-dimensional
subrepresentation: group elements permute the factors and multiply
their product by a scalar character. The associated finite line T
has degree zero. The induced map
\[
T\longrightarrow\operatorname{Sym}^mR
 \longrightarrow\operatorname{Sym}^mK
\]
is nonzero because R->K is a generic isomorphism. It contradicts
the accepted twist vanishing when m<=5. No semisimplicity or averaging
by the group order is used.

Apply
[Faber, Theorems B/C and Remark2.3, pp3--4](https://arxiv.org/pdf/1112.1999)
to the finite projective image in characteristic five. Cyclic and
5-semi-elementary groups have a fixed point; a dihedral group has
an orbit of size two. The tame A4 case has an orbit of size four:
choose a fixed point of a cyclic order-three subgroup. Its stabilizer
is cyclic since a tame finite subgroup fixing a point acts faithfully
on its tangent line. A4 has no larger cyclic subgroup containing C3,
so this stabilizer has order three. All these types are excluded.
At this stage the classification leaves S4, PSL2(F_{5^a}) and
PGL2(F_{5^a}); A5 in characteristic five is the q=5 PSL2 case.

## The mixed tensor removes the smallest remaining types

Suppose the projective representation is conjugate into PGL2(F5).
For each actual lifted matrix write A_g=lambda_g B_g with B_g in
GL2(F5). Then
\[
A_g^{(5)}=\lambda_g^4 A_g.
\]
The scalar lambda_g^4 is independent of changing B_g by an F5 scalar.
The multiplication relation for the A_g shows that these scalars form
a character. Consequently F*R=R tensor M for a finite degree-zero
line M. The rank-two identity R=R^vee tensor det R rewrites this as
F*R=R^vee tensor T. The
[Frobenius-dual exclusion](../../Theorems/cartier_and_spin/frobenius_dual_coefficient_exclusion.md)
now forbids a nonzero map to K. Arbitrary finite scalar lifts are
included; the actual matrices need not themselves be F5-rational.

The geometric S4 type is conjugate into this PGL2(F5). The cited
Faber conjugacy classification makes it enough to exhibit one such
subgroup. The matrices
\[
\begin{pmatrix}0&1\\2&0\end{pmatrix},\qquad
\begin{pmatrix}1&1\\1&4\end{pmatrix},\qquad
\begin{pmatrix}0&1\\3&0\end{pmatrix}
\]
have projective orders two. Their adjacent products have order three
and their first and third product has order two. They therefore give
a quotient of the Coxeter group A3, namely S4. The
[elementary verifier](../../scripts/arithmetic/pgl2_five_s4.py) enumerates
exactly24 generated projective matrices inside the120-element PGL2(F5),
so this quotient is S4 itself. The executed receipt is
`pgl2_five_s4.json` in
[the external evidence directory](../../../litt3-computation-data/overnight_three_replies_20260926/).
Thus S4 and both q=5 types are excluded, leaving only a>=2.

For the limitation on further orbit-product arguments, Sym^18 K has
rank19 and degree171; on a
genus-nine curve its Euler characteristic is171-8*19=19. Thus its
global section space cannot vanish. The mixed-tensor proof uses a
specific subbundle and special fiber equations instead. No higher-twist
claim follows for the whole symmetric power.
In general the rank is m+1 and the degree is m(m+1)/2, so
\[
\chi(\operatorname{Sym}^mK)=(m+1)(m-16)/2.
\]
For m>=17 even the untwisted space cannot vanish. In particular a
q+1-point product for q>=25 would require an obstruction specific to
that product or representation, rather than vanishing of the whole
symmetric power. This observation does not assert that any of those
products actually occurs as a section.
