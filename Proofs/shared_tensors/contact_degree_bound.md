# Proof: count every zero stratum in the same intersection budget

[Statement](../../Theorems/shared_tensors/contact_degree_bound.md).
The original contact and root-extension audits retain their uniform
scope. The later stratified proof is consolidated into Sections1--3;
the quotient uses only the finite-groupoid theorem, avoiding a reverse
dependency on its canonical-marking application.

## 1. Global intersection budget

Let D be a finite reduced union of distinct preserving joint images
in $X\times Y$, with smooth normalizations $Z_i$ and the actual maps
of the statement. Write A,B for its total degrees and
$T=\sum_i(g(Z_i)-1)=A(g(X)-1)=B(g(Y)-1)$.
Every formal branch is a smooth graph over both endpoint coordinates.

For the two fiber classes $F_X,F_Y$, the class
$D-BF_X-AF_Y$ is orthogonal to the ample class $F_X+F_Y$.
Hodge index gives $D^2\le2AB$. Adjunction then gives
\[
\delta(D)=p_a(D)-\sum_i g(Z_i)+c-1=D^2/2+T\le AB+T,
\tag{4}
\]
where c counts normalized components. Since every branch is smooth,
local delta is the sum of pairwise branch contacts, INCLUDING
contacts between different components.

For the e-stratum, the two preimages of the endpoint zero sets are
the SAME reduced set $S_e$ on the disjoint normalization, by actual
tensor equality and etaleness. Thus
\[
|S_e|=Au_e=Bv_e,\qquad |S_e|^2/(u_ev_e)=AB.
\tag{5}
\]

## 2. Distinct slopes and the first possible collision

At an endpoint pair of zeros of order e, choose parameters and write
the tensors as $x^eU(x)(dx)^d$, $y^eV(y)(dy)^d$, with U,V units.
A preserving branch $y=h(x)$ has nonzero slope lambda satisfying
\[
h^eV(h)(h')^d=x^eU(x),\qquad
\lambda^{e+d}=U(0)/V(0).
\]
There are exactly $r_e$ DISTINCT possible slopes, where $r_e$ is
the prime-to-p part of $e+d$. Scheme multiplicity adds no slope.

Two distinct branches with the same slope have contact q at least
two. Compose one with the inverse of the other. The resulting
automorphism $h(x)=x+cx^q+O(x^{q+1})$, c nonzero, preserves
$x^eW(x)(dx)^d$. Its first changed relative coefficient is
$(e+dq)c$, in degree q-1; the unit ratio W(h)/W starts in degree
at least q. Hence $e+dq=0$ in k.

If p divides d but not e, no same-slope pair is possible, and each
endpoint pair has at most $r_e$ branches. Summing (5) proves (1).
Otherwise every same-slope contact is at least $m_e$.
In particular if p divides e+d but not d, the first allowed q is
p+1, rather than a value at most p. If p divides both e,d, q at
least two is the universally valid bound.

Distinct image branches cannot have identical completed germs:
then their integral image curves would share a component.
This is why the union is reduced.

## 3. Sum the disjoint strata

If R branches meet at one e-stratum endpoint pair and their slope
classes have sizes $R_j$, their local delta contribution is at least
\[
\binom R2+(m_e-1)\sum_j\binom{R_j}2
\ge\frac12\left(1+\frac{m_e-1}{r_e}\right)R^2
-\frac{m_e}2R.
\]
Cauchy--Schwarz over the $u_ev_e$ pairs, followed by (5), gives
\[
\delta_e\ge
\frac12\left(1+\frac{m_e-1}{r_e}\right)AB-\frac{m_e}2Au_e.
\]
Different zero strata occupy DISJOINT endpoint pairs. Sum their
contributions and compare with (4), proving (2) and then (3).
Each summand defining K is strictly greater than one, so two
strata give K positive. No Galois hypothesis enters this argument.

For uniform multiplicity with $p\nmid d(e+d)$,
$r_e=e+d=n$ and $u_e=2d(g(X)-1)/e$. Substitution gives exactly
the original uniform inequality. For e=d=1, p at least five,
n=2 and m=p-1, giving the simple-zero bound.

For an actual atlas $q:C\to S$ to an effective orbifold with
coarse curve B, the normalization of $(C\times_B C)_{\rm red}$
is $C\times_S C$: the latter is finite, normal and etale over
both factors and is generically the same relation by effectivity.
Its total projection degrees are $\deg q$, and every component
preserves the pulled-back form. The simple-zero inequality
therefore bounds $\deg q$ in arbitrary, possibly p-divisible degree.

## 4. Finiteness, the exact quotient and the line quotient

Specialize X=Y=C. Every finite set of distinct exact preserving
images has total degree bounded by the SAME constant $B_s$ from
(1) or (3). Since each image contributes a positive integer degree,
there are finitely many of them. They contain the diagonal and are
closed under transpose and normalized composition. Equality survives
joint minimalization, and both maps remain etale.

The [finite-groupoid theorem](../quotient_geometry/finite_correspondence_groupoid.md)
therefore gives $S_s$, its finite etale atlas and the full relation
$C\times_{S_s}C$. Tensor equality descends s to beta.
For two endpoints, the same bound makes all four ordered sets of
preserving images finite. Their two-object groupoid is connected by
the given cross-span. Each endpoint is a surjective atlas with its
full self-relation, so their exact quotients are identified.

A line-preserving image is exact between (C,s) and (C,lambda s).
Rescaling does not change the exact self-relation, so it gives an
automorphism of $S_s$ preserving $k\beta$. Conversely each such
automorphism gives its twisted fiber-product images. If it fixes
beta, those images already belong to the full exact relation;
hence the automorphism is generically identity, and thus identity
on the effective normal quotient. The multiplier character is
therefore injective. The finite-groupoid theorem also proves
$\operatorname{Aut}(S_s)$ finite, even with wild inertia.
Consequently G is a finite subgroup of $k^\times$, cyclic of
prime-to-p order, and $[S_s/G]$ governs all line-preserving images.

Connected finite etale refinement multiplies every zero count and
g(C)-1 by its degree, preserving the profile criterion. Applying
the two-object construction to C and its refinement identifies
their exact and line quotients. For every a at least one, equality
of the ath powers says the rational ratio is a constant ath root
of unity. Thus its exact relation is the union of the $G[a]$-twisted
relations, giving $S_{s^a}=[S_s/G[a]]$. Line preservation, and hence
the line quotient, is unchanged by powers and scalars. A power need
not satisfy the displayed numerical criterion anew.

## Boundaries and provenance

Nonuniform zero strata already force a core for an individual
span by the one-clump theorem. The new counting content is the
bound on the ENTIRE reduced union and its one simultaneous quotient.
For p=5 and uniform one-form zero orders e=1,2,5, the respective
$(r_e,m_e,K)$ are $(2,4,1/2)$, $(3,3,-1/3)$, $(6,5,-1/3)$.
Uniform d=2,e=1 has K=-2/3. These known uncontrolled profiles are
not excluded. Tensor powers do not repair a nonpositive budget;
the ramified-root theorem uses additional geometry.

The [original contact evidence](../../../litt3-computation-data/mathematical_cleanup_20261003/contact_degree_bound_v1/proof.md)
and [original stratified argument](../../../litt3-computation-data/mathematical_cleanup_20261003/stratified_contact_bound_v1/proof.md)
are retained externally. The combined generalization has focused
author review; the original independent audits retain their scope.
