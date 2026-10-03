# A core is equivalent to faithful profinite gluing and finite path closure

Let $k$ be algebraically closed, let $\ell\ne\operatorname{char}k$,
and let $X\xleftarrow f Z\xrightarrow g Y$ be an actual finite
étale span of connected smooth projective curves of genus at least two.
Choose a geometric point $z$ on $Z$ and use its images to identify
$H=\pi_1(Z,z)$ with its actual open images in $G_X=\pi_1(X)$
and $G_Y=\pi_1(Y)$. Let $G=G_X\amalg_HG_Y$ be the pushout
in the category of all profinite groups.
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
5. The pushout is proper: both natural vertex maps $G_X,G_Y\to G$
   are injective.
6. The natural source-group map $H\to G$ is injective.

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

A coreless span therefore has a nontrivial kernel already on $H$.
This does not make $G$ trivial or exclude its nontrivial finite quotients
and selected compatible coefficients. Conditions(5)--(6) concern the
full profinite pushout; no restricted pro-$\mathcal C$ version is claimed.

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

## Finite-field path-growth trichotomy

Let the finite coefficient field be $\Lambda=\mathbf F_q$, and extend
coefficients to $\overline{\mathbf F}_q$. A simple type means an absolute
Jordan--Hölder type of a whole word object. Coefficient Frobenius
$\sigma_q$ raises all its monodromy matrix entries to the $q$-th power.
Every whole word is defined over $\Lambda$, so this Frobenius permutes
its simple types; it need not fix an individual selected quotient.

The original span has a core if and only if there are simultaneous
bounds $D,L,h$ on, respectively:

- ranks of all absolute simple types occurring in the word objects;
- their orbit lengths under $\sigma_q$;
- Loewy lengths of the whole word objects.

It is enough to impose these bounds on words ending at $X$.
Thus every nonzero finite seed on a coreless actual span has at least
one of these three quantities unbounded. Uniform Frobenius period
of whole objects does not remove the orbit-length condition.

More explicitly, put $b=\operatorname{lcm}(1,\ldots,L)$ and
$\Lambda'=\mathbf F_{q^b}$. Every absolute simple type descends to
$\Lambda'$, and the number of possible types on $X$ is at most
\[
\sum_{d=1}^D|\mathrm{GL}_d(\Lambda')|^{2g(X)}.
\]
The preceding splitting-cover bound then applies over $\Lambda'$.
The comparison and path schemes remain the original actual ones.

Version4,3 October2026. The properness implication and source-group
faithfulness use [Cusinato, Lemmas3.4 and3.16](https://arxiv.org/html/2609.01234v2);
the converse uses the established actual cored orbifold.
The modular and finite-field bounds retain all full path schemes,
whole word objects and original field embeddings. A simultaneous
Galois refinement is a conclusion of bounded closure.
[Proof](../../Proofs/shared_tensors/etale_induction_core.md).
