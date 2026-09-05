# The simultaneous-envelope criterion and the core-tower obstruction

## Status and purpose

**Status: proved.**  The group-theoretic equivalences below are formal
consequences of the Galois correspondence for finite etale covers.  The
counterexample uses the standard commensurator theorem for arithmetic
Fuchsian lattices.

Put

\[
 S=\mathbf P^1_{\overline{\mathbf F}_5}(31,31,31)
\]

and let

\[
                  u,v:\mathcal C\rightrightarrows S                 \tag{21.1}
\]

be a connected representable finite etale self-correspondence.  This note
does not prove that (21.1) is visible.  It identifies exactly what the
simultaneous-Galois step would have to prove, and shows why minimal degree,
finite-field descent, and finite generation do not prove that step by
themselves.

## 1. The exact subgroup criterion

Choose geometric base points and paths.  Write

\[
 G=\pi _1^{\mathrm{et}}(S),\qquad H=\pi _1^{\mathrm{et}}(\mathcal C).
\]

The two legs induce injections with open image

\[
                         i,j:H\hookrightarrow G.                    \tag{21.2}
\]

Changing the choices conjugates the maps, and hence does not affect any of
the assertions below.

Call an open subgroup \(K\leq H\) **admissible** if

\[
                         i(K)\triangleleft G,qquad
                         j(K)\triangleleft G.                       \tag{21.3}
\]

**Proposition 21.1.**  A connected finite etale cover
\(W\to\mathcal C\) for which both composites
\(W\rightrightarrows S\) are Galois exists if and only if an admissible
\(K\leq H\) exists.

**Proof.**  Connected finite etale covers of \(\mathcal C\) correspond to
open subgroups \(K\leq H\).  Under the first map to \(S\), the resulting
cover of \(S\) corresponds to \(i(K)\leq G\); it is Galois precisely when
this subgroup is normal in \(G\).  The second leg gives the identical
criterion with \(j\).  This is exactly (21.3).  \(\square\)

Equivalently, on identifying \(i(H)\) and \(j(H)\) by the commensuration

\[
             \theta=j\,i^{-1}:i(H)\buildrel\sim\over\longrightarrow j(H),
\]

one needs an open \(N\leq i(H)\) such that both \(N\) and
\(\theta(N)\) are normal in \(G\).  Taking the two normal cores separately
does not ensure this compatibility.

## 2. A canonical tower and an if-and-only-if stopping test

For an open subgroup \(A\leq G\), put

\[
                 \operatorname {Core}_G(A)=\bigcap_{g\in G}gAg^{-1}.
\]

This is open and normal: there are only finitely many conjugates of an open
subgroup.  Define recursively

\[
\begin{split}
 L_0&=H,\\
 L_{n+1}&=
 i^{-1}\!\left(\operatorname {Core}_G(i(L_n))\right)
 \cap
 j^{-1}\!\left(\operatorname {Core}_G(j(L_n))\right).
                                                                    \tag{21.4}
\end{split}
\]

Every \(L_n\) is open and normal in \(H\), and
\(L_{n+1}\leq L_n\).

**Theorem 21.2 (core-tower criterion).**  The following are equivalent.

1. An admissible open subgroup of \(H\) exists.
2. The tower (21.4) is eventually constant.
3. There is an \(n\) for which \(L_n\) itself is admissible.

**Proof.**  Suppose first that \(K\leq H\) is admissible.  We show by
induction that \(K\leq L_n\).  If \(K\leq L_n\), then the normal subgroup
\(i(K)\triangleleft G\), being contained in \(i(L_n)\), is contained in
every conjugate of \(i(L_n)\), and hence in its normal core.  The same
argument applies to \(j(K)\), proving \(K\leq L_{n+1}\).

Normality of \(i(K)\) also implies \(K\triangleleft H\).  Thus all the
\(L_n/K\) are subgroups of the finite group \(H/K\).  A descending chain
among this finite set of subgroups must become constant.

Conversely, suppose \(L_{n+1}=L_n\).  Each of the two inverse images in
the right side of (21.4) is contained in \(L_n\).  Since their intersection
is all of \(L_n\), each inverse image equals \(L_n\).  Therefore

\[
 i(L_n)=\operatorname {Core}_G(i(L_n)),\qquad
 j(L_n)=\operatorname {Core}_G(j(L_n)),
\]

so \(L_n\) is admissible.  This also proves the equivalence with (3).
\(\square\)

Thus alternating the two normal-core operations is an exact semi-algorithm:
it constructs successively deeper finite etale covers of \(\mathcal C\),
and it stops exactly when a simultaneous Galois refinement has been found.
There is no formal bound on the number of strict steps.

## 3. Equivalence with a finite geometric envelope

Here a **finite envelope** means a smooth proper connected orbifold
\(\mathcal O\), two representable finite etale maps

\[
                    f_0,f_1:S\rightrightarrows\mathcal O,
\]

and a 2-isomorphism \(f_0u\simeq f_1v\).

**Proposition 21.3.**  A finite envelope exists if and only if the
equivalent conditions of Theorem 21.2 hold.

**Proof.**  If \(W\to\mathcal C\) is a simultaneous Galois refinement,
let \(A\) and \(B\) be the two deck groups of
\(W\rightrightarrows S\).  The hyperbolicity of \(W\) makes its
automorphism group finite, so \(F=\langle A,B\rangle\) is finite.  The
construction in file 10 gives

\[
                    \mathcal O=[W/F],
\]

with the two required maps \(W/A\simeq S\) and \(W/B\simeq S\) to
\(\mathcal O\).

Conversely, suppose an envelope is given and put
\(\Omega=\pi _1^{\mathrm{et}}(\mathcal O)\).  After choosing paths, the
2-isomorphism identifies the two images of \(H\) in \(\Omega\); call the
common open subgroup \(D\).  Let

\[
                         M=\operatorname {Core}_{\Omega}(D).
\]

Then \(M\triangleleft\Omega\) is open and \(M\leq D\).  Pull it back to
an open subgroup \(K\leq H\).  Since the maps
\(G\hookrightarrow\Omega\) induced by \(f_0,f_1\) are injective and
\(M\leq D\), the two images of \(K\) in \(G\) are precisely the inverse
images of \(M\).  They are therefore normal in \(G\).  Thus \(K\) is
admissible.  \(\square\)

Combining this with the presentation-compatible classification in file 19
gives a useful warning.

**Corollary 21.4.**  For this particular \(S\), the following assertions
about (21.1) are equivalent:

1. \(\pi _0u\simeq\pi _0v\), where
   \(\pi _0:S\to S_0=\mathbf P^1(2,3,62)\);
2. a finite envelope exists;
3. a simultaneous Galois refinement exists;
4. the core tower (21.4) stabilizes.

Indeed, (1) supplies the envelope \(\mathcal O=S_0\).  Conversely, file 19
gives one presentation-independent map \(\mathcal O\to S_0\) for any
finite envelope, and therefore turns equality over \(\mathcal O\) into
\(\pi _0u\simeq\pi _0v\).  Propositions 21.1 and 21.3 and Theorem 21.2
give the remaining equivalences.

Consequently, after the over-orbifold classification, proving the envelope
bridge is equivalent to proving the original visibility assertion; it is
not a weaker formal step.

## 4. Why the three proposed soft inputs do not close the tower

### 4.1 Minimal degree points in the opposite direction

The minimality argument in file 16 rules out a nontrivial **coarsening** of
\(\mathcal C\) through which both coarse functions factor.  In contrast,
the groups \(L_n\leq H\) in (21.4) correspond to **refinements**
\(\mathcal C_n\to\mathcal C\).  At every strict step the degrees of the
two legs increase.

Nor can visibility appear after such a refinement and then evade
minimality.  If \(p:\mathcal C'\to\mathcal C\) is finite etale surjective
and \(\pi _0up\simeq\pi _0vp\), the two pullbacks of this isomorphism to
\(\mathcal C'\times_{\mathcal C}\mathcal C'\) agree: they are
isomorphisms between the same dominant maps to \(S_0\), and such an
isomorphism is unique because \(S_0\) has trivial generic inertia.  Etale
descent therefore gives \(\pi _0u\simeq\pi _0v\).  Thus a non-visible
correspondence stays non-visible throughout (21.4), but its degree moves
upward, where minimality imposes no restriction.

### 4.2 Finite-field descent gives invariance, not termination

All finite-presentation data over
\(\overline{\mathbf F}_5=\bigcup_m\mathbf F_{5^m}\) descend to some finite
field.  After a further finite extension and compatible base-point choices,
a power of Frobenius preserves (21.2).  Since normal cores are functorial,
it then preserves every \(L_n\).

This supplies no descending-chain condition.  Even a topologically finitely
generated profinite group can have an infinite strictly descending chain of
Frobenius-stable, indeed characteristic, open subgroups; the chain

\[
                 \mathbf Z_5\supset5\mathbf Z_5\supset
                 5^2\mathbf Z_5\supset\cdots
\]

is the elementary example.  A new geometric restriction on the *specific*
tower (21.4), rather than descent alone, would be needed.

### 4.3 Finite generation controls each index, not all indices

The group \(G\) is topologically finitely generated, so it has only finitely
many open subgroups of any fixed index.  The indices in a strict core tower
need not be bounded, however.  Hence this finiteness statement does not
force repetition.  The next section shows that this is a genuine issue even
for fundamental groups of compact hyperbolic curves.

## 5. A same-target counterexample to the general envelope principle

The following standard construction shows that a simultaneous refinement is
not formal, even when the two bases are the same smooth projective hyperbolic
curve and the two covering degrees are equal.

**Proposition 21.5.**  There are a smooth projective complex curve \(X\) of
genus at least \(2\), a connected smooth projective curve \(C\), and finite
etale maps

\[
                             u,v:C\rightrightarrows X
\]

of equal degree for which no connected finite etale cover \(W\to C\) makes
both composites \(W\rightrightarrows X\) Galois.  Moreover, the map
\((u,v):C\to X\times X\) is generically injective.

**Proof.**  Choose a torsion-free cocompact arithmetic Fuchsian lattice
\(\Gamma<\mathrm {PSL}_2(\mathbf R)\).  Its commensurator is dense by the
arithmetic case of the commensurator theorem.  We first choose
\(g\in\operatorname {Comm}(\Gamma)\) such that

\[
                  \Lambda=\langle\Gamma,g^{-1}\Gamma g\rangle       \tag{21.5}
\]

is not discrete.

Here is a justification that such a \(g\) exists.  There are only finitely
many discrete overgroups \(\Delta\) of \(\Gamma\).  Indeed, the area of a
hyperbolic orbifold has a positive universal lower bound, so
\([\Delta:\Gamma]\) is bounded.  For a fixed index \(n\), the core of
\(\Gamma\) in \(\Delta\) has index at most \(n!\) in \(\Gamma\).  A
finitely generated group has only finitely many subgroups of bounded finite
index, and the normalizer of each resulting cocompact lattice is a finite
extension of it.  This leaves only finitely many \(\Delta\).

For a fixed such \(\Delta\), the subgroup
\(g^{-1}\Gamma g\leq\Delta\) has the same fixed index as
\(\Gamma\leq\Delta\).  There are only finitely many possibilities for it.
The set of \(g\)'s producing any one possibility
is a coset of the discrete group
\(N_{\mathrm {PSL}_2(\mathbf R)}(\Gamma)\).  Thus all \(g\) for which
(21.5) is discrete lie in a finite union of discrete subsets.  They cannot
exhaust the dense, non-discrete commensurator.  This proves the claim.

Set

\[
 H=\Gamma\cap g^{-1}\Gamma g,qquad
 X=\Gamma\backslash\mathfrak H,qquad
 C=H\backslash\mathfrak H.
\]

The inclusion \(H\leq\Gamma\) gives \(u\), while \(z\mapsto gz\) and
\(gHg^{-1}\leq\Gamma\) give \(v\).  These are finite unramified covers of
compact Riemann surfaces and hence finite etale maps of smooth projective
complex curves.  Their degrees agree because \(H\) and \(gHg^{-1}\) have
the same hyperbolic covolume.

Suppose that \(W\to C\) were a simultaneous Galois refinement.  It
corresponds analytically to a finite-index subgroup \(K\leq H\).  Galoisness
over \(X\) through \(u\) says \(K\triangleleft\Gamma\), while Galoisness
through \(v\) says \(gKg^{-1}\triangleleft\Gamma\), or equivalently
\(K\triangleleft g^{-1}\Gamma g\).  Hence the non-discrete group
\(\Lambda\) in (21.5) normalizes \(K\).  But \(K\) is itself a cocompact
lattice, whose normalizer in \(\mathrm {PSL}_2(\mathbf R)\) is discrete.
This contradiction proves nonexistence of \(W\).

Finally, work over a simply connected analytic open disc in \(X\) avoiding
the branch locus (which is empty here) and trivialize the finite cover
\(u:C\to X\) there.  Its finitely many sheets are indexed by a set of
representatives for \(H\backslash\Gamma\).  On the sheet indexed by
\(\gamma\), comparison with the identity sheet under \(v\) is locally the
comparison of \(z\mapsto g\gamma z\) and \(z\mapsto gz\), modulo
\(\Gamma\).  If their images agree on a nonempty open set, proper
discontinuity makes the relevant \(\delta\in\Gamma\) locally constant, and
the identity theorem gives
\[
                         g\gamma=\delta g.
\]
Thus \(\gamma\in\Gamma\cap g^{-1}\Gamma g=H\), so this is the identity
sheet.  For each of the finitely many other sheets the coincidence locus is
proper.  Removing their union leaves a nonempty open set on which every
fiber of \((u,v)\) has one point.  This proves generic injectivity.
\(\square\)

In particular, the profinite fundamental group of \(X\) is topologically
finitely generated and the correspondence has the analogue of the
field-generation property \(\mathbf C(C)=\mathbf C(u,v)\), yet its core
tower does not stabilize.  This counterexample is not a characteristic-\(5\)
counterexample for the particular orbifold \(S\); it proves that any positive
result for \(S\) must use special characteristic-\(5\) geometry or special
structure of its algebraic commensurations.

## Conclusion

With files 15--19 in place, the global route has one exact remaining gate:

\[
 \boxed{\text{prove that the tower (21.4) stabilizes for every
 self-correspondence of }S.}
\]

Neither separate Galois closures, minimal-degree descent, finite-field
descent, nor topological finite generation supplies that stabilization.

## External reference used in Proposition 21.5

The commensurator input is Margulis's criterion that an irreducible lattice
in a semisimple Lie group is arithmetic if and only if its commensurator is
dense.  A standard reference is G. A. Margulis, *Discrete Subgroups of
Semisimple Lie Groups*, Ergebnisse der Mathematik 17, Springer, 1991,
Chapter IX, Theorem B.  Only the easy arithmetic-to-dense direction is used
above.
