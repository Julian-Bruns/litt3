# Universal one-sided domination and the full etale Jacobian spectrum

Date: 2026-09-05. Author: `/root`.
Status: elementary consequences of the cited published theorems;
independently checked **PASS** by the fresh agent
`/root/universal_spectrum_boundary_check`, 2026-09-05.
[Scoped audit record](audits/UNIVERSAL_ETALE_JACOBIAN_SPECTRUM_AUDIT.md).
This is a strategic boundary, not a new solution or a priority claim.
The one-sided domination theorem was already recorded in the project's
literature review; the all-factors, arbitrary-multiplicity, and
above-every-level consequences are made explicit here.

## 1. Abstract form and actual quantifiers

Call a smooth projective connected hyperbolic curve C over an
algebraically closed field k one-sided universal if, for every smooth
projective connected curve T/k, there is a connected finite etale
cover W -> C and a surjective morphism W -> T. The latter morphism
need not be etale or separable.

### Theorem

Suppose C is one-sided universal. For every abelian variety A/k,
every integer r>=1, and every prescribed connected finite etale
cover V -> C, there exists a connected finite etale U -> V and a
surjective homomorphism

\[
                         J(U)\twoheadrightarrow A^r.       \tag{1}
\]

Equivalently, J(U) is isogenous to A^r times an abelian variety B.
The surjection in (1) need not itself have finite kernel.
One may additionally require the composite U -> C to be Galois.

### Proof

Every abelian variety over the infinite field k is a quotient of
a Jacobian. Applied to A^r, this gives a smooth projective connected
curve T and a surjection J(T) -> A^r. For example, a sufficiently ample
smooth complete-intersection curve in A^r generates it. The precise
standard result is [Milne, Jacobian Varieties, Theorem 10.1](https://www.jmilne.org/math/xnotes/JVs.pdf#page=33).

Choose W -> C and b:W -> T by universality. The map b is finite
locally free of some total degree d>0: a nonconstant map between
smooth proper curves is finite, and its local modules over the
regular one-dimensional target are torsion-free and hence flat.
Norm and pullback on Jacobians satisfy

\[
                           b_*b^*=[d].                    \tag{2}
\]

This uses the total degree, including any inseparable degree. Norm
exists for finite locally free maps and its composition with pullback
on line bundles is the d-th tensor power; see
[Stacks, Lemmas 31.18.2 and 31.18.6](https://stacks.math.columbia.edu/tag/0BCX).
Multiplication [d] on an abelian variety is surjective even if the
characteristic divides d. Thus b_* and J(W) -> J(T) -> A^r are
surjective. Poincare complete reducibility gives the isogeny formulation.

Now choose a connected component U_0 of V times_C W. Both projections
are finite etale. Each is surjective: the image is nonempty, open and
closed in its connected target. Norm J(U_0) -> J(W) is surjective by
the same argument, proving (1) with U_0.

If Galoisness over C is desired, replace U_0 by its connected finite
etale Galois closure over C. It still dominates V, and norm preserves
the quotient (1). This proves all the quantifiers. QED.

## 2. The bases in this investigation satisfy the hypothesis

Let k=Fbar_p, p>=5. Bogomolov--Tschinkel,
[*Unramified correspondences*, Theorem 1.7](https://arxiv.org/pdf/math/0202223#page=3),
prove one-sided universality for every hyperelliptic C/k of genus at
least two. Their conclusion is explicitly a finite etale cover of C
with a surjective regular map to the arbitrary target T. It is not
a common finite etale cover.

The same conclusion holds for every tamely superelliptic C/k, meaning
a cyclic cover of P1 of degree prime to p and genus at least two.
By [Poonen, Corollary 1.9](https://math.mit.edu/~poonen/papers/etale.pdf#page=2),
there is an actual diagram C <- V -> H with V/C finite etale and H
hyperelliptic of genus at least two. If H <- Z -> T is the diagram
from Bogomolov--Tschinkel, take a connected component of V times_H Z.
Its map to V is finite etale by base change, even if V -> H is
inseparable. It is smooth, so no normalization is needed. The
component is a curve and its finite maps to V and Z are surjective.
Composing proves one-sided universality for C.

Consequently the theorem applies, in characteristic five, to:

- every auxiliary ordinary genus-two base, regardless of its Jacobian;
- the fixed hyperelliptic genus-25 Y of file76;
- the fixed cyclic-triple genus-nine X of file76;
- the earlier y^31=x(x-1) curve. This last curve is also directly
  hyperelliptic via (2x-1)^2=1+4y^31.

The last example is asserted here in characteristic five. Its
hyperelliptic/superelliptic genus statement must not be transferred
to characteristic 31.

## 3. Spectrum and multiplicity consequences

Define

\[
 \Sigma_{\rm et}(C)=\bigcup_{W/C\ {m connected\ finite\ etale}}
       \{\text{simple geometric isogeny factors of }J(W)\}.
                                                               \tag{3}
\]

For every one-sided universal C, this is the set of ALL simple
abelian k-isogeny classes. For every such simple S,

\[
                   \sup_{W/C} m_S(J(W))=\infty.             \tag{4}
\]

The same unboundedness holds above every prescribed finite etale
level V/C, and even when only Galois covers of C are counted.
Any nested tower cofinal among all connected finite etale covers
of C must therefore have unbounded multiplicity of every S.

For completeness, the spectrum (3) is invariant under finite etale
commensurability for arbitrary hyperbolic curves, whether universal
or not. If Z covers both C and D etale, pull any W/C back to Z and
take a component. It is an etale cover of D whose Jacobian still
surjects onto J(W). This proves one inclusion of spectra; interchange
C and D for the other.

For our present bases, this otherwise natural invariant has the same
maximal value. Changing the selected abelian factor, its dimension,
Newton slopes, or endomorphism field cannot produce an exclusion by
its complete absence from ALL finite etale-cover Jacobians.

## 4. What this does not say

It does not produce an etale second map to any prescribed hyperbolic X.
In particular, a quotient J(W) -> J(X) does not recover such a map.
The second map in one-sided universality may ramify; precomposing a
ramified separable map W -> X with an etale cover of W preserves the
ramification indices and cannot repair it. Inseparability likewise
persists under etale precomposition.

It does not contradict our packet obstructions for restricted Galois
groups or our finite-target/stabilization results for specified
character towers. The covers supplied by the theorem need not occur
in those restricted families.

Finally, being cofinal in the tower generated by one correspondence
is NOT the same as being cofinal among all etale covers of a base.
The latter universal tower has unbounded factor multiplicities by
(4), even without any common etale cover with the proposed X.
Any eventual-ordinarity or bounded-multiplicity argument for a
correspondence must therefore use an additional restriction actually
forced by its two maps. No such restriction is supplied here.

All quotients and isogeny classes are geometric over k. No fixed finite
field of definition or uniform arithmetic Frobenius assertion is made.
