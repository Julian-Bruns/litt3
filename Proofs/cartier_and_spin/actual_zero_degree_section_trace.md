# Proof: zero-degree raw sections force an actual bounded replacement

Version3,2 October2026. [Independent whole-branch review](../../Research/audits/RAW_DEGREE_ZERO_GLOBAL_AUDIT_2026_10_02.md) PASS.
[Statement](../../Theorems/cartier_and_spin/actual_zero_degree_section_trace.md).
No numerical calculation is used.

## The weighted original support bound

The raw trace R is a quotient of the actual finite etale coefficient
$g_*O_S$. If $\deg R=0$, it is finite etale: on the actual one-leg
Galois closure its presentation is trivial, and a globally generated
degree-zero bundle is trivial. In particular $g^*R$ is semistable
of degree zero. The ORIGINAL raw-section map $O_S\to g^*R$ is
nonzero and nowhere zero. A zero would give a positive-degree
saturation line inside a degree-zero semistable bundle.

At an actual lifted zero of s of multiplicity m, its image in
$g^*K$ is a uniformizer to power m times the unit image of the
saturated source line. Its section is a unit in $g^*R$, so the
inclusion R into K has a local Smith exponent at least m at the
opposite image. All maps are etale, so valuation and multiplicity
are unchanged. The local length of K/R is therefore at least
$m(Q)$. Their sum is $\deg K-\deg R=\deg K$, proving the bound.

For q0 the section zeros are exactly $2O$, as established in the
[positive single-section theorem](actual_positive_single_section_trace.md).
Its positive line trace cannot have rank one. Rank two has degree
one by stability of $B_Y$, and the same theorem would make its raw
trace equal to it, contrary to $\deg R=0$. Rank three has degree
at most two, and rank four has degree at most four. In the branch
$\deg K\le3$, the positive-trace minimum-slope bound and exact
degree-one raw-generation theorem force $\deg K=2$ or three.
The weighted support bound then says that the actual opposite
image of O consists of ONE point W.

## A second-jet kernel has dimension at most one

Take the original one-leg Galois closure $q:T\to Y$, of degree
$8d$, with conjugate actual maps $h_i:T\to X$ of degree d.
The pullback of R is trivial. Each raw q0 section is consequently
a nonzero constant vector in this trivial bundle. Its image in
$q^*K$ has zero divisor precisely $2H_i$, where $H_i=h_i^*O$;
the saturated q0 line is a subbundle of the ambient Cartier bundle,
so it has no other fibre zeros.

At a point z above W, the space of these CONSTANT sections whose
images vanish to order at least two has dimension at most one.
Indeed the total local length of K/R on Y is at most three.
In a local Smith decomposition, a constant-section two-jet kernel
injects into the subspace of the residual R-fibre belonging to
Smith exponents at least two: its zeroth jet kills exponent-zero
directions and its first jet kills exponent-one directions.
There is at most one exponent at least two when the total length
is at most three. Changes between the constant trivialization and
the Smith frame can shrink this kernel, but cannot enlarge it.

Thus two DISTINCT projective raw q0 vectors cannot both have an
O-zero at the same z. Conversely coincident generic q0 image lines
come from proportional constant R-vectors and have identical zero
divisors $2H_i$.

## The eight distinct lines and actual intermediate cover

Let N be the number of distinct projective raw q0 vectors. The deck
group is transitive on them. Their reduced H-divisors are pairwise
disjoint and each has degree d. Their union is deck invariant and
supported over W. It is nonempty, and a Galois etale fibre is
transitive, so that union is the ENTIRE reduced fibre $q^{-1}(W)$
of degree $8d$. Consequently
\[
Nd=8d,\qquad N=8.
\]

Fix one projective vector and its stabilizer H in the actual deck
group. The intermediate curve $Z'=T/H$ gives a finite etale map
to Y of degree eight, so its genus is nine. The map $r:T\to Z'$
has degree d, the SAME as the actual conjugate $h_i:T\to X$.
The zero divisor $H_i$ is H-invariant, since H preserves the raw
section line and its map to the Cartier bundle. It descends to a
reduced degree-one divisor P on $Z'$, giving
$H_i=r^{-1}(P)$ exactly.

The chosen constant vector line is an H-subrepresentation. It
descends to a finite etale degree-zero line A on $Z'$ inside the
pullback of R, with its actual map to $B_{Z'}$. Its zero divisor
is $2P$, and its saturation is $A(2P)$. Pullback to T recovers
the SAME embedded positive q0 line $h_i^*O_X(2O)$.

H acts on the vector line by a character, not necessarily trivially.
Hence no untwisted global section of A follows. Nevertheless the
singleton fibre identity supplies the following ACTUAL bounded
replacement without identifying the two genus-nine targets.

## Degree four: two defect points and the exceptional projective incidence

The weighted bound allows at most TWO opposite points. If there are two,
each has local length two. Its constant second-jet kernel has dimension
at most one, by the same Smith argument. Thus distinct projective raw
vectors have disjoint reduced H-divisors. Their union is the two complete
Galois fibres, of total degree $16d$, and hence $N=16$.

Suppose instead that the opposite support consists of one point W.
If its constant second-jet kernel has dimension one, the preceding
argument gives $N=8$. It cannot have dimension zero: some raw q0
section vanishes there, and deck transitivity gives such a section
at every point of the fibre. If the dimension is two, the local length
is at least four. It is exactly four, the two Smith exponents are
$(2,2)$, and $K=B_Y$ has rank four. This is the sole new case.

Trivialize $q^*R$ as $O_T\otimes k^4$. Its N distinct projective raw
vectors form points of $\mathbf P^3(k)$. For each $z\in q^{-1}(W)$,
let $C_z\subset k^4$ be the two-dimensional space of constant
sections whose images in $q^*K$ vanish to order at least two at z.
The projective lines $\mathbf P(C_z)$ form one deck orbit. Let M
be the number of distinct lines in this orbit; each occurs at exactly
$8d/M$ fibre points. A raw projective point belongs to $\mathbf P(C_z)$
if and only if z belongs to its reduced H-divisor, because its raw
zero divisor is EXACTLY $2H_i$.

The sum of the N reduced H-divisors is deck invariant and has degree
Nd. Therefore every orbit line contains exactly $N/8$ of the observed
projective points. Conversely each observed point lies on exactly
$M/8$ orbit lines, since its H-divisor has degree d. In particular
N and M are multiples of eight. Distinct projective lines intersect
in at most one projective point, so counting pairs of lines through
the observed points gives
\[
N\binom{M/8}{2}\le\binom M2.
\]
If $M\ge16$, this implies
\[
N\le64\frac{M-1}{M-8}\le120.
\]
If $M=8$, each observed point lies on exactly one orbit line. All
observed points on that line have the SAME H-divisor, namely the d
points where that orbit line occurs. Equal H-divisors give proportional
pulled theta forms. Theta-Cartier recognition then makes the source
maps differ by $C_3$, which fixes x and scales $y$. Their pulled
$q_0(x)\theta$ forms are proportional, so their projective raw vectors
are equal. There is therefore one observed point per orbit line,
and $N=8$.

This proves $N\le120$ in every raw degree-zero case. It neither
assumes a finite field of definition for the projective points nor
classifies finite projective groups.

## Theta recognition makes a bounded quotient of the existing source

In any of the cases above, fix one of the N projective raw section
vectors and let H be its stabilizer in $\operatorname{Gal}(T/Y)$.
For every $\sigma\in H$, the maps $h_i$ and $h_i\circ\sigma$
have the same pulled O-divisor. The canonical form
$\theta=dx/y^2$ on X has divisor $16O$. Thus their pulled theta
forms have the same divisor and differ by a nonzero constant.
The settled [theta-Cartier recognition](new_line_comparison_normal_form.md)
applies to arbitrary actual finite etale maps from the SAME source:
proportional theta pullbacks preserve the embedded X-field and the
maps differ by an element of $\operatorname{Aut}(X)=C_3$.
Consequently
\[
h_i\circ\sigma=\gamma_\sigma\circ h_i,
\qquad \gamma_\sigma\in C_3.
\]
Surjectivity of $h_i$ makes $\gamma_\sigma$ unique, and composition
gives a homomorphism $H\to C_3$. Let $H_0$ be its kernel and put
$e=[H:H_0]\in\{1,3\}$.

The stabilizer H has order $8d/N$, since its index in the actual deck
group is N. The quotient
\[
C=T/H_0
\]
is therefore a smooth connected projective curve with an actual
finite etale map to Y of degree $eN\le360$. The original map $h_i$
descends to C because $H_0$ acts trivially on its embedded X-field.
Its descended map to X has degree
\[
\deg(C/X)=\frac{\deg(T/X)}{|H_0|}
=\frac d{|H_0|}=\frac{eN}{8}\le45.
\]
It is finite etale: both $T\to X$ and $T\to C$ are etale,
so ramification indices and differentials in the intervening map
are trivial. Thus C, not a hypothetical independent normalization,
is an ACTUAL common source with degrees $(eN/8,eN)$.
The exact-eight case retains the sharper degrees $(e,8e)$.
No simultaneous Galois closure or clump hypothesis was assumed.

For the selected MAIN partner the independently proved
[quotient-descent bound](../curve_arithmetic/genus_two_quotient_descent.md)
says every actual common witness has X-degree greater than
$(335999!)^2$. The replacement X-degree at most45 contradicts that bound.
This completes the ENTIRE main branch $\deg R=0$,
without restricting the original covering degree.

For the backup partner the same genuine replacement exists, but
this proof supplies no separate exclusion of its small witnesses.
Positive-degree raw trace remains open. The broader unmarked problem
remains undecided.
