# Finite constituent closure under étale induction detects a core

Let $k$ be algebraically closed, let $\ell\ne\operatorname{char}k$,
and let $X\xleftarrow f Z\xrightarrow g Y$ be an actual finite
étale span of connected smooth projective curves of genus at least two.
On finite-rank $\overline{\mathbf Q}_\ell$-local systems put
\[
S=g_*f^*,\qquad S^*=f_*g^*.
\]
Start with ANY nonzero local system $L$ on $X$. Retain the
irreducible Jordan--Hölder constituents, up to geometric isomorphism, of every finite
word in $S,S^*$ applied to $L$, with the endpoints respected.

The following are equivalent:

1. Only finitely many constituent isomorphism classes occur.
2. One finite étale cover of $X$ splits every finite path cover rooted
   at $X$ for the actual span.
3. There is a connected finite étale refinement $W\to Z$ such that
   BOTH composites $W\to X$ and $W\to Y$ are Galois.
4. The original span has a core:
   $f^*k(X)\cap g^*k(Y)\ne k$ inside $k(Z)$.

A path cover retains every edge choice, including repeated vertices
and edges; it is the actual iterated fiber product, not only the reduced
outer joint image. Splitting means becoming a disjoint union of copies
of the base after pullback. It is enough in(1) to bound the constituent
classes occurring back on $X$.

Thus in ANY coreless span full alternating induction produces infinitely
many distinct irreducible constituents from every nonzero
seed. Removing multiplicities does not make the closure finite. This
holds even if the span has a clump or already has some common coefficient.
It does not exclude a construction that selects particular subobjects
or quotients, and does not assert unbounded constituent ranks.

The result needs no finite-ground-field hypothesis, arithmetic Frobenius
structure, semisimplicity, ordinariness, or restriction on the degrees.

There is an exact modular counterpart. Use a finite coefficient field
$\Lambda$ of ANY characteristic and a nonzero finite-rank local system
$L$. Retain the WHOLE word objects. Then the core condition is equivalent
to the conjunction of:

- finitely many simple constituent types occur;
- the Loewy lengths of the word objects are uniformly bounded.

Here Loewy length means the radical-filtration length for the actual
finite monodromy group algebra. It is not a Cartier nilpotence height.
Thus a coreless modular induction closure must produce either new
simple types or arbitrarily deep extensions. Simple types alone can
miss unbounded characteristic-primary covers.

The forward implication from these two bounds is effective. Let $N$
be the common kernel of the finitely many simple systems on $X$, let
$d$ topologically generate $N$, and let $h$ bound the Loewy lengths.
There is a cover splitting all rooted path covers with degree at most
\[
[\pi_1(X):N]\,|\Lambda|^{d+d^2+\cdots+d^{h-1}}.
\]
For $h=1$ the sum is zero. One may take
$d\le1+[\pi_1(X):N](2g(X)-1)$.

Version2,20 September2026. Semisimplicity is unnecessary, and the
modular version identifies the additional extension-depth condition.
Author proof retaining the complete path
schemes and the given field embeddings. A simultaneous Galois refinement
is a CONCLUSION of bounded closure, not an assumption.
[Proof](../../Proofs/shared_tensors/etale_induction_core.md).
