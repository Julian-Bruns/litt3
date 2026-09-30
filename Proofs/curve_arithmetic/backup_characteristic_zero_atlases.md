# Proof: specialization filters and complete atlas reduction

[Statement](../../Theorems/curve_arithmetic/backup_characteristic_zero_atlases.md).
The first specialization lemma and degree-six certificate are from the
returned manual Pro answer. The larger finite checks and the arithmetic
family reduction are local continuation. This proof uses the existing
arithmetic and cover certificates in their stated scopes; it does not
assume that a characteristic-zero quotient map has good reduction.

## 1. Inherited arithmetic

Fix a number field model and a finite extension of the selected
five-adic place giving a smooth proper model of $C$. Specialization
embeds its geometric Jacobian endomorphism algebra into that of $Y$.
The [settled arithmetic](../../Theorems/curve_arithmetic/backup_curve_arithmetic.md)
identifies the latter with $\mathbf Q(\pi)$ for
\[
\pi^4-8\pi^3+182\pi^2-1000\pi+15625=0.
\]
Putting $s=\pi+125/\pi$ gives $s^2-8s-68=0$. Consequently
\[
K=\mathbf Q(\sqrt{21},\sqrt{-25+\sqrt{21}}).
\]
The norm of $-25+\sqrt{21}$ to $\mathbf Q$ is $604=4\cdot151$,
which is not a square in $\mathbf Q(\sqrt{21})$. The quartic field
is therefore not Galois, and its only quadratic subfield is
$\mathbf Q(\sqrt{21})$: two quadratic subfields would make it
biquadratic. Its subfields are precisely the three in the statement.
In particular an elliptic factor, or an endomorphism with square five,
cannot specialize into $K$.

Automorphisms of a smooth stable curve extend uniquely over its stable
model and inject under specialization. Since $\operatorname{Aut}(Y)=C_2$
and every genus-two curve has its hyperelliptic involution,
$\operatorname{Aut}(C)=C_2$.

For $n$ prime to five, specialization on $J(C)[n]$ is injective after
passing to a strictly henselian good-reduction base. The six Weierstrass
sections extend distinctly. If $n[P-O]=0$ and the specialized Abel
class equals a Weierstrass class, prime-to-five torsion injectivity
identifies the two generic classes. Injectivity of the Abel map then
identifies the points. The established $W_1(Y)[24]$ calculation thus
gives the asserted characteristic-zero restriction. The same reasoning
also transfers $W_1[36]$ and the two-primary restriction when needed.

Every cyclic etale cover of degree dividing six extends etale over a
good model, after finite base extension, by prime-to-five fundamental
group specialization. Its special fiber is connected and is one of
the covers in the [complete ordinary-cover calculation](../../Theorems/jacobians/ordinary_covers/backup_small_abelian_ordinarity.md).
It is therefore ordinary.

## 2. Prime-to-five geometric monodromy

Let $C\to\mathbf P^1$ be complete and uniform, with Galois closure
$D\to\mathbf P^1$, group $G$, and sheet stabilizer $H$.
An inertia generator acts on $G/H$ with all cycles of equal length.
That length is its order, because this permutation representation is
faithful. Hence each inertia group intersects every conjugate of $H$
trivially. The actual cover $D\to C$ is etale.

If $5\nmid|G|$, this $H$-cover extends to a finite etale cover of a
good model of $C$ after finite extension, using SGA1, ExposeX,
Theoreme3.8 and Corollaire3.9. Thus $D$ also has good reduction.
Its $G$-action extends by uniqueness of the stable model. A tame finite
action on a smooth curve has smooth quotient. Fixed sections and
stabilizers persist: locally a cyclic stabilizer acts as
$z\mapsto\zeta z$, with $\zeta-1$ a unit for nontrivial $\zeta$.
Different such fixed sections cannot collide at a larger tame
stabilizer. Taking quotients by $H$ and $G$ therefore specializes the
map with the same degree and complete uniform indices.

The [Y-only tame-atlas theorem](../../Theorems/quotient_geometry/endpoint_exclusions/backup_tame_uniform_atlases.md)
now makes this map hyperelliptic. The hypothesis here is on $|G|$,
not just its inertia orders or the degree of $C\to\mathbf P^1$.

## 3. Small Galois-stable sets and bad quotient reduction

A finite Galois-stable set of characteristic-zero marked three-branch
cover classes of cardinality at most two cannot contain a cover whose
source has potentially good geometric reduction $Y$. Normalize the
branch points to $0,1,\infty$. At a fixed five-adic embedding, the
decomposition group acts on this finite set. Uniqueness of stable
reduction makes reduction of source isomorphism classes equivariant.
The residue Frobenius orbit of a smooth special source is consequently
of length at most two. The moduli orbit of $Y$ has length three.

This argument requires good reduction only of the source. It makes
no assertion about extension of the three-branch map. Intrinsic
monodromy order, deck group, fixed-point counts and existence of
specified intermediate maps define Galois-stable subsets.

## 4. Finite low-degree permutation certificates

The returned [degree-six script](../../scripts/orbifolds/degree_six_profile_certificate.py)
was copied byte-for-byte from the supplied attachment and executed.
For the fixed first inertia cycle it gives:

| Profile | Monodromy order: tuple count |
|---|---|
|$(2,2,3,3)$|$6:24,\ 24:144$|
|$(2,2,2,6)$|$12:72$|
|$(3,6,6)$|$6:3,\ 18:6,\ 24:9,\ 120:18$|

The eighteen tuples of order120 form one simultaneous-conjugacy
class. Section3 excludes this class; Section2 excludes the others.
The degree-three and degree-four monodromy groups are subgroups of
$S_3$ and $S_4$, so Section2 already applies.

The two [degree-eight triangle enumerations](../../scripts/orbifolds/degree_eight_uniform_profiles.py)
and the [quadrangle/degree-nine completion](../../scripts/orbifolds/small_uniform_atlas_completion.py)
fix the first permutation, enumerate every allowed remaining one,
and quotient by the entire centralizer of the first. Transitivity
is checked separately. Their exact class counts are:

| Profile | $(|G|,|\operatorname{Deck}|)$: number of classes |
|---|---|
|$(2,8,8)$|$(32,2):1,\ (8,8):1,\ (336,1):2$|
|$(4,4,4)$|$(32,2):3,\ (168,1):2,\ (8,8):1$|
|$(2,2,2,4)$|$(16,4):6,\ (32,4):6,\ (24,2):4,\ (8,8):3$|
|$(3,3,9)$|$(324,1):1,\ (504,1):1,\ (81,3):2$|

All these groups have order prime to five.

The [degree-five/degree-ten certificate](../../scripts/orbifolds/low_degree_wild_triangles.py)
also treats indices divisible by five, entirely in characteristic
zero. For $(5,5,5)$ there are three classes with deck group $C_5$
and one class of monodromy order60 and trivial deck group. The former
contradict $\operatorname{Aut}(C)=C_2$; the latter is a singleton
Galois-stable class, excluded by Section3.

For $(2,5,10)$ the complete counts are
\[
(|G|,|\operatorname{Deck}|):\quad
(1920,2):3,\ (720,1):1,\ (120,2):1,\ (50,5):1,\ (10,10):1.
\]
Every deck involution in the four order-two cases fixes exactly TWO
source points, as checked on its preserved inertia cycles. It is
therefore nonhyperelliptic, contradicting $\operatorname{Aut}(C)=C_2$.
The last two cases have extra automorphisms. The remaining order720
case is the unique class of that monodromy order and is excluded by
Section3. No reduction of either wild-inertia map has been assumed.

For reproducibility, all generated permutations, outputs and receipts
are external to the source repository:

* [Degree six](../../../litt3-computation-data/degree_six_profiles_20260921/output.txt).
* [Degree-eight triangles](../../../litt3-computation-data/degree_eight_profiles_20260921/classes.json).
* [Degree-eight quadrangle and degree nine](../../../litt3-computation-data/small_uniform_atlas_completion_20260921/classes.json).
* [Degrees five and ten](../../../litt3-computation-data/low_degree_wild_triangles_20260921/classes.json).

## 5. Geometric exclusions that survive bad reduction of the map

The uniform degree-twelve quadrangle $(2,2,2,3)$ is excluded directly
in characteristic zero by the [integral Hecke theorem](../../Theorems/quotient_geometry/tame_covers/quadrangular_genus_two_hecke_obstruction.md):
it would give a Rosati-symmetric endomorphism $T$ with $T^2=[5]$.

For $(2,4,12)$, put the singleton fiber at infinity $P$, and normalize
the other branch values to zero and one. Write their reduced fibers
as $D_2,D_4$. Then
\[
\operatorname{div}(df)=D_2+3D_4-13P,\qquad
\operatorname{div}\frac{(df)^{12}}{f^6(f-1)^9}=24P.
\]
Thus $24[P-O]=0$. Section1 makes $P$ Weierstrass, so choose
$\eta$ with divisor $2P$ and set
\[
H=df/\eta,\qquad y=H^3/[f(f-1)^2].
\]
The actual divisors give $y^4=c f^2(f-1)$, with $c\ne0$.
This is a connected genus-one Kummer curve of degree four over the
$f$-line; it receives a degree-three map from $C$, a contradiction
to simplicity of $J(C)$.

More generally, indices divisible pointwise by $(3,3,3)$ or $(2,3,6)$
permit base change by the corresponding cyclic degree-three or
degree-six quotient of the characteristic-zero elliptic curve with
$j=0$. Every connected normalized component is an etale cyclic
cover $D\to C$ of degree dividing six and has a nonconstant map to
that elliptic curve. By Section1, $D$ has ordinary good reduction
after extension. The elliptic target has supersingular good reduction
at five. The resulting nonzero homomorphism of Jacobians specializes
injectively, impossible from an ordinary abelian variety to a
supersingular elliptic one. This excludes, in particular,
\[
(3,6,6),\ (3,3,9),\ (3,3,6),\ (2,6,6),\ (2,3,18),\ (2,3,12).
\]
Neither the map $D\to E$ nor the original triangle map is required
to extend as a smooth map.

The complete $(3,4,4)$ census has monodromy orders
$12,24,36,96,576,1320,15552$ with class counts $1,1,1,1,3,1,2$.
All but order1320 are prime to five. Section2 excludes them; the
single order1320 class is excluded by Section3. These are the same
actual complex permutation classes as in the
[retained census](../quotient_geometry/tame_covers/tame_cover_frobenius_sieve.md).

The [complete $(2,4,6)$ certificate](../quotient_geometry/tame_covers/triangle246_frobenius_quotient_obstruction.md)
has forty classes. Twenty-three have deck group larger than two;
six have a nonhyperelliptic deck involution; three belong to intrinsic
Galois-stable parts of sizes one and two; four have an actual degree-four
elliptic quotient; four factor through a uniform $(2,2,2,3)$ map.
Every exclusion is valid in characteristic zero by Sections1,3 and
the Hecke theorem. Its prior use of special-fiber Frobenius is replaced
here only by Section3, not by assumed specialization of the cover.

Finally the [complete $(2,3,8)$ certificate](../quotient_geometry/tame_covers/triangle238_frobenius_factor_obstruction.md)
leaves, after extra automorphisms, actual intermediate maps of types
$(3,3,4)$, $(2,2,2,3)$, $(2,4,8)$, or an intrinsic two-class part
with no such intermediate map. Section3 removes that last part and
the Hecke theorem removes the quadrangle. Thus it suffices to test
the two stated smaller triangle types.

## 6. Exhaustiveness and the initial eight tests

For a degree-$n$ genus-two complete uniform atlas the Hurwitz equation
is
\[
\sum_i(1-1/e_i)=2+2/n,\qquad e_i\mid n.
\]
The minimum positive hyperbolic genus-zero orbifold degree is $1/42$,
attained at $(2,3,7)$, so $n\le84$. Also $3\le r\le6$.
Enumerating the divisors of each $2\le n\le84$ in this exact equation
gives thirty numerical profiles: twenty-two triangles and eight
longer profiles. The latter are
\[
(2;2^6),\ (3;3^4),\ (4;2^5),\ (4;2,2,4,4),\
(6;2,2,3,3),\ (6;2,2,2,6),\ (8;2,2,2,4),\ (12;2,2,2,3).
\]
All but the hyperelliptic row have just been excluded. Applying
Sections4--5 to the twenty-two triangles leaves eight profiles:
$(3,3,5),(2,4,8),(2,5,5),(3,3,4),(2,3,10),(2,3,9),(2,4,5),(2,3,7)$,
using the actual $(2,3,8)$ factorization for that extra row.
The [exact rational profile enumerator](../../scripts/orbifolds/genus_two_uniform_profiles.py)
checks all degrees at most84 and all branch counts from three to six,
using the displayed Hurwitz equality and divisibility of every index.
The triangle counts also agree with
[Singerman--Syddall, Table1](https://ftp.gwdg.de/pub/misc/EMIS/journals/BAG/vol.44/no.2/b44h2sin.pdf),
but the numerical-profile completeness is the Hurwitz calculation.

## 7. Excluding the last triangle profiles

The [general triangle enumerator](../../scripts/orbifolds/enumerate_uniform_triangles.cpp)
has now regenerated all eight remaining complete permutation lists.
It constructs the transitive Schreier table in first-encounter order,
enforces the three exact periods and their proper-divisor exclusions,
and selects the least rooted traversal code. Every inverse edge and
completed relation is checked. Its counts are respectively
$9,19,21,28,20,37,75,155$, agreeing with the complete published table.
The degree84 count also matches the retained independent character-mass
certificate. The [separate analyzer](../../scripts/orbifolds/analyze_uniform_triangles.py)
checks every full permutation table, inequivalence, deck centralizer,
fixed-point count and intermediate partition.

For $(2,4,8)$ all nineteen classes are excluded geometrically: nine
have a nonhyperelliptic deck involution, eight have extra deck
automorphisms, and two have another actual elliptic intermediate
quotient. For $(2,3,9)$ the thirty-seven classes split into eighteen
nonhyperelliptic deck involutions, eleven larger deck groups, five
other elliptic quotients, and three already excluded smaller uniform
factors. No special-fiber differential calculation is used here.

For $(2,5,5)$, fourteen classes have a nonhyperelliptic deck involution,
three have another elliptic quotient, and two have larger deck group.
The remaining two form a Galois-stable set (characterized by absence
of the preceding intrinsic obstructions), so Section3 excludes them.

The [auxiliary-atlas theorem](../../Theorems/quotient_geometry/tame_covers/auxiliary_atlas_good_reduction.md)
excludes ALL sources of $(3,3,4)$ and $(2,3,7)$ with reduction $Y$.
It uses auxiliary groups of orders24 and168, respectively. Thus it
does not need the original cover's monodromy to be prime to five.

For $(2,3,10)$, three classes have elliptic intermediate quotients,
six have nonhyperelliptic deck involutions, and four have larger deck
groups. Five further classes factor through an ACTUAL degree-fifteen
map of type $(3,3,5)$. The last two have none of these properties,
and Section3 again excludes their intrinsic two-class part.

Of the nine $(3,3,5)$ classes, four have extra automorphisms, leaving
five. Of the seventy-five $(2,4,5)$ classes, thirty-seven have extra
deck automorphisms, ten have a nonhyperelliptic deck involution, and
seven have another elliptic intermediate quotient, leaving twenty-one.
Their source curves are not asserted distinct or to have good reduction.
All twenty-one latter covers have the hyperelliptic involution as
deck involution, with branch fixed-point counts $(4,2,0)$.

The subsequent [exact $(3,3,5)$ field calculation](triangle335_reduction_exclusion.md)
excludes the five remaining degree-fifteen classes. Their source
models are defined over a degree-five field totally ramified at five;
the extra boundary model is rational. Every potential good reduction
therefore has moduli over $\mathbf F_5$, contrary to the backup's
orbit of length three. Thus $(2,4,5)$ is the sole remaining triangle
profile at that stage, with at most twenty-one normalized cover classes.

The [complete exact triangle245 calculation](triangle245_reduction_exclusion.md)
now excludes all twenty-one. Its two charts exhibit every normalized
geometric model, and the reduction of $I_4^5/I_{10}^2$ differs from
the backup in every algebraic family. Only a necessary invariant is
used, without an assumption of good reduction of the triangle map.
There are therefore no uniform triangle atlases for such a $C$.

The exact generated tables and witness records are in
[the external computation directory](../../../litt3-computation-data/uniform_triangle_continuation_20260921/analysis.json).
The data supply actual intermediate function fields by monodromy
block systems, not just abstract subgroup orders.

## 8. The remaining maximal arithmetic family

Now uniformize an arithmetic $C$ by $\Gamma\subset\mathrm{PSL}_2(\mathbf R)$.
Its hyperelliptic involution gives an index-two overgroup $\Gamma_h$
of signature $(0;2^6)$. Choose a maximal discrete arithmetic overgroup
$\Delta$ containing $\Gamma_h$. Such an overgroup exists: all discrete
overgroups have uniformly bounded index by the orbifold area bound,
so an ascending sequence terminates. The quotient has coarse genus
zero, since it receives the hyperelliptic quotient $\mathbf P^1$.
It is compact and the map $C\to\Delta\backslash\mathbb H$ is complete
and uniform. If it has at least four cone points, the preceding
exclusion makes its degree two; thus $\Delta=\Gamma_h$ is maximal.
Otherwise it is a triangle atlas, now excluded by Section7. Therefore
the hyperelliptic orbifold is itself maximal arithmetic.

For signature $(0;2^6)$ there is exactly one torsion-free subgroup
of index two: every cone generator must map nontrivially to $C_2$,
and their product relation is satisfied. This identifies the source
curve without an additional choice of a surface subgroup. Finiteness
of arithmetic lattices of bounded covolume makes this second family
finite.
The arithmetic scope includes all lattices, not just norm-one or
congruence surface groups. See also
[Long--Maclachlan--Reid, Sections3--4](https://web.math.ucsb.edu/~long/pubpdf/genus0_final.pdf)
for maximal arithmetic overgroups and their congruence property.

There is no identification of the uniformizing trace field with
the endomorphism field of $J(C)$. The subsequent six-cone exclusion
is the separate [integral dormant-pair theorem](backup_arithmetic_reduction_exclusion.md).
The original common-cover problem is not resolved by this atlas
classification.
