# Proof: the trace of a fibre lies in a basepoint-free linear system

ID: `hom_disjoint_correspondence_gonality`. Version1,2 October2026.
[Statement](../../Theorems/curve_arithmetic/hom_disjoint_correspondence_gonality.md).
No numerical calculation is used.

## The degree-e trace family

Finite maps between smooth curves are flat. Their fibre divisors,
including ramified multiplicities, therefore give an algebraic family
$r^*[m]$ of effective degree-e divisors on C. The finite map h induces
a morphism of symmetric powers, so $D_m=h_*r^*[m]$ is an algebraic
family of effective degree-e divisors on X.

For a fixed $m_0\in M(k)$ the Picard class of $D_m-D_{m_0}$ is
the value at $[m-m_0]$ of the homomorphism
\[
h_*r^*:J_M\longrightarrow J_X.
\]
This homomorphism vanishes by the assumed Hom-disjointness. Hence all
$D_m$ have one line-bundle class $L\in\operatorname{Pic}^e(X)$.
They lie in the COMPLETE linear system $|L|$; equality of classes,
not merely equality of divisor degree, is the essential input.

This family is nonconstant. If all $D_m$ were one fixed divisor,
its finite support would contain h(C), because every point of C is
in one r-fibre. That contradicts nonconstancy of h.

More strongly, the family has no common basepoint. For any $P\in X(k)$,
the set $h^{-1}(P)$ is finite, as is its image under r. Choose m outside
that image. Then $D_m$ does not contain P. Let V be the linear span
of the sections of L representing the family, each defined up to scalar.
The preceding argument makes V basepoint free and of dimension at least
two. Choose one nonzero section $s_0\in V$. It has finitely many zeros.
An infinite field permits choosing $s_1\in V$ nonzero at all those
zeros, since basepoint freeness makes each forbidden condition a proper
hyperplane. Thus $s_0,s_1$ have no common zero. They define an actual
degree-e morphism $X\to\mathbf P^1$.

This proves the gonality statement and the stronger basepoint-free
degree spectrum restriction, rather than only $\operatorname{gon}(X)\le e$.

## The unique degree-three pencil descends

Suppose e=3 and X has a unique trigonal pencil x. In the application
$g_X=9$; Clifford's inequality gives $h^0(L)\le2$ for an effective
degree-three L with at least two sections. Thus $|L|$ is exactly the
unique trigonal pencil. The trace family gives a nonconstant morphism
$f:M\to|L|\simeq\mathbf P^1$ with
\[
D_m=x^*[f(m)].
\]
For every point p of C, its image h(p) occurs in $D_{r(p)}$.
Consequently $x(h(p))=f(r(p))$. These pointwise identities imply the
identity of morphisms $xh=fr$. Taking degrees yields
$3\deg h=3\deg f$, hence $\deg f=\deg h$.

The same conclusion holds whenever the unique trigonal pencil is the
full degree-three system in question. For genus greater than four in
characteristic five this follows from Clifford as above. Uniqueness
itself follows from Castelnuovo--Severi: two different degree-three
maps have either the same rational function subfield or a birational
combined map to $\mathbf P^1\times\mathbf P^1$. The latter has genus
at most $(3-1)^2=4$.

## The fixed X has no degree-four or degree-five pencil

The fixed X has genus nine and a separable degree-three map x; in
particular it is not hyperelliptic. A degree-four map would also be
separable in characteristic five. The index of the compositum of
their two rational function subfields in $k(X)$ divides both three
and four, so is one. Castelnuovo--Severi gives $g_X\le(3-1)(4-1)=6$,
a contradiction.

A degree-five map cannot be purely inseparable: that would make the
first Frobenius twist of X rational, contradicting genus nine. It is
therefore separable. The same coprime-degree argument gives
$g_X\le(3-1)(5-1)=8$, again a contradiction. Degrees one and two
are already excluded by its gonality three.

## An elementary two-group forbids a genus-five trigonal pencil

Let M have genus five and a faithful group $G\simeq(\mathbf Z/2)^4$
action, in odd characteristic. If M were trigonal, its genus greater
than four makes its degree-three pencil unique. G would act on its
target rational line. An elementary abelian two-subgroup of
$\operatorname{PGL}_2(k)$ has rank at most two: after conjugating one
involution to $t\mapsto-t$, its commuting transformations are
$t\mapsto at$ or $t\mapsto a/t$; imposing involutivity and mutual
commutation leaves at most the usual four-element subgroup.
The kernel K of the target action therefore has order at least four.

On the other hand K acts on $k(M)$ and fixes the rational field of
the degree-three pencil. Artin's fixed-field theorem gives
\[
|K|\mid[k(M):k(t)]=3,
\]
which is impossible for a two-group of order at least four. This
uses field-degree divisibility, not merely a permutation action on
three points. In the correspondence application $e=3$ and $\deg h=3$
would give precisely this forbidden degree-three map on M.

The degree-three uniqueness and elementary-group argument are the
extra inputs beyond the general Hom-disjoint gonality gate. The
critical-pencil application keeps its own field-degree, Jacobian and
square-class hypotheses; they are not inferred from this lemma alone.
