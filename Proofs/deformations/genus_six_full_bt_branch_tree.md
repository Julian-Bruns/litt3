# Proof: all fourth roots and their complete late responses

[Statement](../../Theorems/deformations/genus_six_full_bt_branch_tree.md).
We use the audited integral comparison and effectivity of the
[original example](explicit_full_bt_existence_descent_failure.md).
The additional computation concerns its COMPLETE finite obstruction,
not a new effectiveness assumption on arbitrary matrices.

## 1. All third classes and the complete fourth scheme

Put $k_0=\mathbf F_{625}=\mathbf F_5[\tau]$, where
$\tau^4+4\tau^3+\tau^2+4\tau+3=0$.
The third-source classes are
\[
\chi(x)=\chi_0+\sum_{i=0}^3x_i\nu_i,\qquad x\in k^4.
\]
The full primary map on the fifteen cohomology coordinates has
rank eleven and the $\nu_i$ form its kernel, with coefficient
Frobenius retained. Perfectness of $k$ gives all primary solutions
in these coordinates. Negative normal $H^0$ makes the lifted Hodge
line unique once the source class is fixed. The
[BT/Hodge dictionary](all_height_bt_hodge_dictionary.md) therefore
identifies these points with all actual normalized marked BT2
extensions of $H_T$.

The complete obstruction to BT3 is
\[
E(x)=C+Ax+Lx^{[5]}+Q(x^{[5]}).
\tag{1}
\]
Its coefficient support and exact calibration were proved in the
original example. All four components vanishing is equivalent to
the whole normal vector being in the primary image. A primary
preimage and whole regular primitives give the actual fourth tuple.
This is why zeros suffice; no freely chosen quadric is substituted
for an integral obstruction.

Use $u_0=x_0^5,u_1=x_1^5,v_0=x_2,v_1=x_3$, a bijection on geometric
points. The ideal $I$ in these coordinates has equations
\[
P=F(u)+Q_{--}(v^{[5]}),\qquad
N=A_-v+B(u)v^{[5]},
\tag{2}
\]
where $A_-$ is invertible and $B(u)=B_0+u_0B_1+u_1B_2$.
The calculation retains ALL four variables. It proves:

- A Groebner basis of $I$ has $37$ elements and $375$ standard monomials.
- The ordinary Jacobian determinant of (2) is a unit modulo $I$.
- The determinant of the full Frobenius-linear block
  $J=L+dQ_{(u,v^{[5]})}$ is a unit modulo $I$.

Thus $k_0[u,v]/I$ is finite etale of degree $375$. It has exactly
$375$ geometric points. This does not assert that (1) in the
original $x$ coordinates is reduced: its two even coordinates
still have their purely inseparable fifth powers.

The ordinary Jacobian is block triangular, with blocks
$J_{++}=dF_u$ and $A_-$. Hence $J_{++}$ and $J$ are both invertible
at every one of the $375$ roots.

## 2. The complete late map has twenty-five geometric points per fiber

Fix any root $x^*$. The integral polarization identity and
[late-response theorem](late_relative_hodge_response.md) give, at
every later reached prefix,
\[
R(v)=Av+Jv^{[5]},\qquad
A=\begin{pmatrix}0&0\\0&A_-\end{pmatrix}.
\tag{3}
\]
The actual two lower digits, preceding potential and first periodic
datum are retained. The proof of (3) applies to every third point;
the earlier restriction to $x_-^*=0$ was used only to make this
matrix block diagonal, not to establish the relative identity.

For $R(v)=b$, the positive equation uniquely determines $v_+$
from $v_-$ on geometric points, since $J_{++}$ is invertible.
The remaining equation is
\[
A_-v_-+Sv_-^{[5]}=c,\qquad
S=J_{--}-J_{-+}J_{++}^{-1}J_{+-}.
\tag{4}
\]
The Schur complement $S$ is invertible because $J$ is.
After multiplication by $S^{-1}$, the equations have leading
terms $v_0^5,v_1^5$ and remaining terms of degree at most one.
Their quotient basis is $v_0^av_1^b$ for $0\le a,b<5$.
The Jacobian $S^{-1}A_-$ is invertible. Therefore every fiber of
(4) is finite etale of degree $25$, with exactly $25$ geometric
points. The complete map (3) is surjective with $25$ geometric
points per fiber; its original scheme fibers have an additional
purely inseparable factor.

At each stage, cancellation in the complete primary quotient
allows a whole primary solve and regular primitives. The
[delayed-extension lemma](marked_obstruction_torsors.md) therefore
extends every such lower prefix to a full tower. It can change a
provisional last digit, but preserves the fixed earlier prefix.

## 3. These are counts of actual group classes

For a fixed preceding tuple, the next source classes with complete
primary repairs form a torsor under the four-dimensional primary
kernel. Their remaining obstruction is affine with linear part
(3). Its $25$ solutions are distinct cohomology classes. They
cannot become one marked Hodge object: global infinitesimal source
automorphisms and additional negative normal $H^0$ are zero.

The all-height BT/Hodge bijection retains the preceding tuple,
marking, divided Frobenius and normalized determinant. At level
two, its full-extendible classes are exactly the $375$ roots.
Above each class, the next full-extendible level has $25$ choices,
each itself continuable by Section2. This proves
\[
|\mathcal F_N|=375\cdot25^{N-2}.
\]
Normalized marked comparisons on the reduced curve are unique.
Thus an infinite path gives an actual compatible system of finite
locally free groups, or equivalently a full group by the effective
periodic dictionary. Distinct paths differ at a finite truncation.
There are $2^{\aleph_0}$ paths in this nonempty regular
$25$-branching tree.

The groups have the same degree-zero rank-two oper reduction.
[Crystalline lattice rigidity](crystalline_oper_lifting.md#rigidity-of-the-integral-lattice)
therefore rescales a rational isogeny to an integral crystal
isomorphism, preserving $F,V$. The [marked scalar correction](explicit_full_bt_nonuniqueness.md#6-the-groups-are-already-distinct-up-to-isogeny)
then gives a normalized marked group isomorphism. Distinct paths
cannot admit one, so they are pairwise non-isogenous.

For each fixed finite field, the
[full comparison cutoff](finite_field_full_bt_cutoff.md) detects a
comparison at one bounded level. The formula above gives only
finitely many classes at that level. Hence finitely many of this
family descend to that field, and at most countably many descend
to any finite subfield. An infinite compatible tower over
$\overline{\mathbf F}_5$ need not descend to one finite subfield.

## 4. A fixed finite field for one hundred sixty-nine branches

An explicit separating coordinate and four coordinate polynomials
give a rational univariate representation of all $375$ points.
Over $k_0=\mathbf F_{625}$ its irreducible factor degrees are
\[
2,2,2,3,6,6,6,6,6,6,6,6,10,114,194.
\tag{5}
\]
The coordinate substitutions vanish modulo the degree-$375$
squarefree separating polynomial and recover the separating
coordinate itself. Together with Section1's length, these identities
prove completeness independently of the elimination algorithm.

At a root with residue field $K=\mathbf F_{5^{4d}}$, compute the
Schur complement $S$ in (4). Its homogeneous negative equation is
$v^{[5]}=Mv$, with $M=-S^{-1}A_-$. Iterating gives
\[
P=M^{[5^{4d-1}]}\cdots M^{[5]}M.
\]
The kernel dimension over $\mathbf F_5$ equals
$\dim_K\ker(P-I)$. Indeed the semilinear operator
$M^{-1}\sigma$ preserves this subspace and its $4d$-th iterate
is the identity there; finite-field cyclic descent gives a fixed
space of that dimension. Thus $P-I$ invertible is exactly
bijectivity of the complete response on $K$-points.

This test gives dimension two for one degree-two factor and the
degree-ten and degree-$194$ factors. It gives dimension zero for
all twelve other factors, accounting for
\[
2+2+3+8\cdot6+114=169
\]
geometric roots. At every one of these roots the complete late
response is bijective over its OWN residue field. The primary
linear solves, regular primitives and normalizations are also
defined there. The fixed-field argument from the original cubic
branch therefore constructs a full Hodge tower over that field.
The least common multiple of the good residue degrees is $114$,
so all these towers embed in $W(\mathbf F_{5^{456}})$.

Apply the same initial permitted finite-character correction and
prime-to-five line lift to these towers. One fixed additional
constant extension suffices. This gives $169$ actual full groups
over one finite field, with their different BT2 classes. At a bad
residue factor, nonbijectivity alone does NOT prove a failed
arithmetic lift: the value of the next obstruction would have to
be tested against the image. The other $206$ roots remain
arithmetically undecided by this calculation.

The degree-three factor in (5) has three roots over
$\mathbf F_{625^3}=\mathbf F_{5^{12}}$. It is one of the twelve
factors with bijective complete response, so the same construction
gives three distinct full towers over this smaller field. The
non-isogeny argument of Section 3 applies to them. After one fixed
extension for the initial marking and deck action, Section 5 gives
fifteen pairwise non-isogenous groups on the closure. This recovers
the earlier three-branch result directly from the complete census.

The [field reconstruction](../../scripts/deformations/cyclic/probe_exceptional_dihedral5_branch_fields.py)
and its [explicit univariate data](../../../litt3-computation-data/bt_obstruction_transport_20260921/exceptional_dihedral5_branch_fields.json)
are checked by a [separate verifier](../../scripts/deformations/cyclic/verify_exceptional_dihedral5_branch_fields.py).
It checks the full substitutions, factor product and deterministic
Rabin irreducibility tests, without reconstructing a multiplication
matrix or running elimination. It uses the opposite product
recursion for $P$ and, for all factors of degree at most ten, also
checks the literal restriction-of-scalars matrix over $\mathbf F_5$.
The [executed receipt](../../../litt3-computation-data/bt_obstruction_transport_20260921/exceptional_dihedral5_branch_fields_verified.json)
records the $169/206$ split. The high-degree factors use the proved
two-by-two semilinear criterion, not a claimed independent dense
scalar rank calculation.

## 5. Disjoint cyclic-five orbits

Choose one full group for each of the $375$ BT2 classes on $T$.
Pullback to the etale double $W\to T$ does not identify two of
these classes: a normalized marked comparison would descend by
uniqueness and effective finite-flat descent.

Each pullback is fixed by the chosen reflection. None is fixed
by the cyclic-five deck group, since that would give a BT2 on
the genus-three quotient $D$, which has none. If two cyclic
orbits met, two different reflections would fix one of the
classes, forcing cyclic-five invariance. The previous orbit
argument thus gives $375$ disjoint five-orbits, or $1875$ different
BT2 classes admitting full extensions on $W$.
The common first connection on $W$ is the étale pullback of the one
on $T$: its positive Hodge line and nonzero second fundamental form
retain the horizontal-line degree bound. The primitive-map argument
of Section 3 therefore makes these $1875$ full groups pairwise
non-isogenous.

Restricting to the $169$ fixed-field constructions from Section4
gives $845$ such classes over one finite field, after also defining
the finite deck action.

## Certificate and scope

The [reconstruction](../../scripts/deformations/cyclic/probe_exceptional_dihedral5_all_branches.py)
starts with the accepted complete fourth obstruction. Its
[explicit certificate](../../../litt3-computation-data/bt_obstruction_transport_20260921/exceptional_dihedral5_all_branches_certificate.json)
contains the Groebner basis, expressions of its elements in the
original generators, all $375$ standard monomials, and identities
expressing $1$ with either determinant and the input equations.

The separate [standard-library verifier](../../scripts/deformations/cyclic/verify_exceptional_dihedral5_all_branches.py)
reconstructs both determinants and finite-field arithmetic, checks
both ideal inclusions, all $666$ critical pairs (with the product
criterion where applicable), the exact standard-monomial set, and
the two unit identities. Its [executed receipt](../../../litt3-computation-data/bt_obstruction_transport_20260921/exceptional_dihedral5_all_branches_independent.json)
is independent of Sage/Singular polynomial arithmetic.

The finite checks do not by themselves imply full effectivity;
that implication uses the prior integral theorems in Sections1--3.
The cover diagram remains CORED. The result provides no new common
full comparison between two endpoints and settles neither original
unmarked common-cover candidate.
