# Proof: finite whole-germ criterion and algebraization of line sections

[Statement](../../Theorems/shared_tensors/clump_formal_transport.md).
We use the existing [finite groupoid theorem](../quotient_geometry/finite_correspondence_groupoid.md)
only after proving finiteness of all reduced joint images.

## The actual formal path group

Regard S as a finite connected bipartite graph. An edge $z\in S_Z$
gives an isomorphism between the completed endpoint discs through
the two étale identifications with $\widehat Z_z$. Reverse edges
give inverse isomorphisms. Composition defines a representation of
the graph's path groupoid. At a chosen vertex it gives a quotient
of the finitely generated free group $\pi_1(S,y)$, namely $\Lambda_y$.
No identification of tangent lines substitutes for these complete germs.

Choose a path from y to each other vertex. Every germ starting at y
is one of these chosen germs composed with an element of $\Lambda_y$.
Thus finiteness of the loop group is equivalent to finiteness of
all germs starting there, and, by connectedness, to finiteness of
all germs between clump vertices.

## Finite formal transport forces a core

Put $C=X\sqcup Y$. Every finite path word gives a finite disjoint
union of smooth curves, finite étale over its starting and ending
endpoint, by taking the specified fiber products. Take a connected
component and then its reduced joint image $D\subset C\times C$.
The normalization of D is again finite étale over either endpoint:
its function field is an intermediate field of an actual finite
étale cover. This statement includes non-Galois intermediate fields.

Fix one clump point on each endpoint. The first projection of any
such path component is surjective, so it has a point above the chosen
starting point. Because the clump is saturated, the whole path stays
within the finite graph S. Its formal branch at the two endpoints is
one of the path germs just described.

Distinct integral reduced curves in a smooth surface cannot contain
the same complete formal branch: otherwise their local intersection
would have infinite length, whereas two distinct proper integral curves
have a finite intersection. Hence a finite set of germs supports only
finitely many reduced joint images D. These images contain the
diagonals, are transpose-closed, and are closed under the reduced
images of all further compositions. The finite groupoid theorem
therefore gives a common effective orbifold quotient of X and Y.
Its coarse curve is a core for the original span.

Conversely, if the span has a core curve B, every path joint image
lies in the fixed finite correspondence $C\times_B C$. There are
only finitely many reduced integral components and finitely many
formal branches of them at pairs of clump points. All formal path
germs lie among these branches, so $\Lambda_y$ is finite. This proves
the equivalence, without a characteristic restriction.

## No new common meromorphic line sections appear on completion

First observe that the fixed field of an infinite subgroup of
$\operatorname{Aut}_k k[[t]]$ inside $k((t))$ is k. If a nonconstant
Laurent series u were fixed, subtracting its constant term or inverting
it gives a fixed series of positive finite order. The extension
$k((t))/k((u))$ is finite, including when it is inseparable, and has
only finitely many automorphisms. This contradicts infinitude.

Let P be the group of actual common line triples. Its degree-zero
subgroup is finite, and its degree image is an infinite cyclic subgroup
of $\mathbf Z$. Consequently $P/\mathbf Z[\mathcal O(S)]$ is finite.
For a common line L choose N>0 and a common isomorphism
\[
L^N\simeq\mathcal O(aS),\qquad a\in\mathbf Z.
\]
Let v be a nonzero compatible meromorphic formal section of L, and
write $s_S$ for the canonical section of $\mathcal O(S)$. Then
$v^N/s_S^a$ is a common meromorphic formal function. The preceding
fixed-field observation shows that it is a nonzero constant.

In a regular local frame of L, let c be the order of v at a clump
vertex. Edge compatibility makes this the same integer at all vertices.
The displayed identity gives $Nc=a$. Comparing endpoint degrees
also gives $N\deg L_Y=aR$, hence $\deg L_Y=cR$. Therefore
\[
\tau=L\otimes\mathcal O(-cS)
\]
is a common degree-zero torsion line. The section $v/s_S^c$ is a unit
on every formal disc, and its leading terms give a nonzero compatible
section of $\tau|_S$. We handle both the inseparable and prime-to-p
torsion, without assuming that shared regular one-forms vanish.

Write the order of $\tau$ as $p^a n$, with $p\nmid n$.
Raise this formal unit to that order using a common trivialization;
the result is a common formal function, hence a nonzero constant.
Rescale so it is one. Its nth power is a formal unit section of
$\tau^n$ whose $p^a$th power is the fixed global trivialization.
For an endpoint function field F and its completion K at a smooth
point,
\[
F\cap K^{p^a}=F^{p^a}.
\]
Indeed a rational local uniformizer is separating; its continuous
derivative detects whether an element of F is a pth power. Repeat
this test a times. In a rational frame of $\tau^n$, the formal unit
is consequently rational. Its $p^a$th power is nowhere vanishing,
so it is itself regular and nowhere vanishing globally. The two
endpoint sections match on Z: their ratio has $p^a$th power one.
Thus $\tau^n$ is the trivial COMMON line.

Now $\tau$ has order prime to p and trivial restriction to the
clump fibers. [Finite clump descent](clump_finite_descent.md) gives
$\tau=\mathcal O$ as an ACTUAL common line. Finally
$v/s_S^c$ itself is a common formal function, so it is constant.
This proves both (6) and the claimed restriction isomorphism.

Apply this to $L=\Omega^m$ for all integral m. The established
primitive common section ring identifies the possible pairs
$(m,c)$ as the integral multiples of $(d,e)$. Thus the formal
meromorphic invariant algebra is $k[s,s^{-1}]$, and nonnegative
orders give exactly its polynomial subalgebra.

Finally, under the stated genus-two characteristic-five hypotheses,
the clump-size connection theorem
provides a global regular common projective connection $\nabla_0$.
The difference between it and any compatible formal meromorphic
projective connection is a formal meromorphic common quadratic tensor.
The line-section result makes that difference global; positive weight
makes it regular. Conversely every global common quadratic may be
added to $\nabla_0$. The common quadratic space has dimension one
exactly when d divides two. The absence of a shared one-form excludes
d=1. With d=2, the identity $2d=eR$ and R>=4 force R=4,e=1.
Otherwise the connection is unique even formally. No step asserts
that an arbitrary formal subbundle or representation algebraizes.
