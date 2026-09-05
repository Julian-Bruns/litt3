# Low-degree monodromy and the independent-closure obstruction

## Status and scope

**Status: proved.** This note applies to every generalized-profile row in
file 16, not only to profile \(4\). It gives an exhaustive candidate list
for the possible
geometric monodromy groups in degrees \(32\) and \(33\), proves alternating
monodromy in degrees \(34,\ldots,46\), and isolates a necessary condition for
a non-visible pair in those latter degrees.

It does not construct a non-visible correspondence. Its main limitation is
also made precise below: numerical cycle/profile data do not force two
marked source curves to be isomorphic.

Put

\[
 S=\mathbf P^1_k(31,31,31),\qquad k=\overline{\mathbf F}_5,
\]

and let

\[
 u:\mathcal T\longrightarrow S
\]

be a connected representable finite etale cover in one of the generalized
profile strata of file 16. Thus its degree is

\[
 d=31+m,\qquad 0\leq m\leq15,
\]

and the coarse cover \(x:C\to\mathbf P^1\) has, above each of
\(0,1,\infty\), one point of ramification index \(31\) and \(m\) unramified
points. Let \(G_x\leq S_d\) be its geometric monodromy group in the action
on a geometric generic fiber.

## The monodromy theorem

**Theorem 26.1.**

1. The action of \(G_x\) is primitive for every \(0\leq m\leq15\).
2. If \(3\leq m\leq15\), then
   \[
                         G_x=A_{31+m}.
   \]
3. If \(m=2\), then
   \[
                         G_x\in\{A_{33},\operatorname{PSL}_2(32)\},
   \]
   where the second group has its natural action on
   \(\mathbf P^1(\mathbf F_{32})\).
4. If \(m=1\), then
   \[
   G_x\in\{A_{32},\operatorname{PSL}_2(31),
            \operatorname{AGL}_5(2),\operatorname{AGL}_1(32)\}.
   \]
5. For completeness, if \(m=0\), then
   \[
   G_x\in\{C_{31},\operatorname{PSL}_3(5),
            \operatorname{PSL}_5(2),A_{31}\}.
   \]

### Proof

An inertia generator at any of the three branch values acts as a \(31\)-cycle
with \(m\) fixed letters. We first prove primitivity uniformly in \(m\).
Suppose that a nontrivial block system has \(b\) blocks, each of size
\(a\geq2\). The induced action of a \(31\)-cycle on the blocks has order
either \(1\) or \(31\). In the latter case \(b\geq31\), whence
\(d=ab\geq62\), contrary to \(d\leq46\). It therefore fixes every block.
Its orbit of length \(31\) must then lie in one block. But a block in a
nontrivial transitive block system has size at most \(d/2<31\), again a
contradiction. Hence \(G_x\) is primitive.

We use two further facts. First, all the displayed inertia generators are
even permutations. Second, they normally generate \(G_x\). Indeed, let
\(N\triangleleft G_x\) be their normal closure. The quotient of the Galois
closure by \(N\) is unramified above \(0,1,\infty\), and is already
unramified away from those points. It is therefore a finite etale cover of
\(\mathbf P^1_k\), so it is trivial. Consequently

\[
                              G_x\leq A_d.                 \tag{26.1}
\]

For \(m\geq3\), Jordan's theorem says that a primitive group of degree \(d\)
containing a prime cycle of length \(31\leq d-3\) contains \(A_d\). Combining
this with (26.1) gives \(G_x=A_d\).

For \(m=1,2\), use G. A. Jones, *Primitive permutation groups containing a
cycle*, Bull. Aust. Math. Soc. **89** (2014), 159--165, Theorem 1.2
([arXiv:1209.5169](https://arxiv.org/abs/1209.5169)). For one fixed letter
and degree \(32\), its exceptional cases specialize to

\[
 \operatorname{AGL}_5(2),\quad
 \operatorname{AGL}_1(32)\leq G\leq\operatorname{A\Gamma L}_1(32),\quad
 \operatorname{PSL}_2(31),\quad\operatorname{PGL}_2(31).
\]

The strict semilinear extension has quotient of order \(5\). Every element
of order \(31\), hence every inertia generator, lies in its normal
\(\operatorname{AGL}_1(32)\) subgroup. Normal generation excludes the strict
extension. Also \(\operatorname{PGL}_2(31)\) is not contained in \(A_{32}\):
if \(a\) generates \(\mathbf F_{31}^{*}\), the map \(t\mapsto at\) fixes
\(0,\infty\) and is a \(30\)-cycle on the other letters, so it is odd.
Equation (26.1) excludes that case. This proves part 4.

For two fixed letters and degree \(33\), Jones's sole exceptional family is

\[
 \operatorname{PGL}_2(32)\leq G\leq\operatorname{P\Gamma L}_2(32).
\]

Here \(\operatorname{PGL}_2(32)=\operatorname{PSL}_2(32)\), and the
semilinear quotient again has order \(5\). Every order-\(31\) element maps
trivially to that quotient, so normal generation excludes every strict
extension. This proves part 3.

The same theorem gives part 5. In prime degree \(31\), the affine exception
is \(C_{31}\leq G\leq\operatorname{AGL}_1(31)\). Every \(31\)-cycle in this
group is a translation, so normal generation forces \(G=C_{31}\). The
projective-degree equation

\[
             31=1+q+\cdots+q^{e-1}
\]

has precisely \((q,e)=(5,3)\) and \((2,5)\) among prime powers \(q\) and
\(e\geq2\). In these cases PGL equals PSL; there are no field automorphisms,
and the remaining exceptional sporadic degrees in Jones's list are \(11\)
and \(23\). This gives the stated list. \(\square\)

## Tame lifting and what a permutation search really enumerates

**Proposition 26.2.** Every cover \(x\) above has a characteristic-zero
lift with the same monodromy and ramification indices. In particular there
is a transitive generating triple

\[
 \sigma_0\sigma_1\sigma_\infty=1,\qquad
 \operatorname{ctype}(\sigma_i)=(31,1^m),\qquad
 \langle\sigma_0,\sigma_1,\sigma_\infty\rangle=G_x.       \tag{26.2}
\]

### Proof

Lift the marked target \((\mathbf P^1;0,1,\infty)\) to a complete
mixed-characteristic DVR. The coarse cover is tame because all its
ramification indices are \(31\), which is invertible in characteristic
\(5\). Wewers's tame lifting theorem says that reduction from tame covers
of the marked lift to tame covers of the special fiber is an equivalence of
categories: S. Wewers, *Deformation of tame admissible covers of curves*,
in *Aspects of Galois Theory*, LMS Lecture Note Ser. 256 (1999),
Corollary 3.1.3. This is the same result used, with its effectivity argument,
in file 15.

Connectedness, degree, local ramification indices, and the categorical
Galois closure are preserved by the equivalence. Descend the finite generic
fiber data to a finitely generated characteristic-zero subfield, embed that
field in \(\mathbf C\), and apply the complex Riemann existence theorem.
This gives (26.2). \(\square\)

Thus a genuinely characteristic-\(5\) cover with no ordinary branch-cycle
triple cannot occur here. The converse direction is the delicate one: if
\(5\mid |G|\), a characteristic-zero triple can have bad reduction at \(5\),
so enumerating all triples gives a finite list of candidates, not a list of
special-fiber covers. If \(5\nmid |G|\), the Galois closure has tame good
reduction after finite extension by Wewers, Proposition 4.2.4, so this extra
test disappears. Among the
exceptional groups in Theorem 26.1, the prime-to-\(5\) groups are

\[
 C_{31},\qquad \operatorname{AGL}_1(32),\qquad
 \operatorname{PSL}_2(32).
\]

For example the affine Nielsen class is nonempty without computation. If
\(\alpha\) generates \(\mathbf F_{32}^{*}\), then

\[
 a(t)=\alpha t,\qquad b(t)=\alpha t+1,\qquad c=(ab)^{-1}
\]

are three \(31\)-cycles with one fixed point, have product \(1\), and
generate \(\operatorname{AGL}_1(32)\): \(ba^{-1}\) is translation by \(1\),
and its conjugates under \(a\) give all translations.

There is in fact no cycle-existence obstruction in any of the sixteen rows.

**Proposition 26.2a.** For every \(0\leq m\leq15\), there is a transitive
triple of permutations of \(31+m\) letters satisfying (26.2).

**Certificate.** For \(m=15\), split the \(46\) letters into

\[
 C=(0,1,\ldots,15),\quad X=(16,17,\ldots,30),\quad
 Y=(31,32,\ldots,45)
\]

and take

\[
 a_{15}=(C,X),\qquad b_{15}=(15,14,\ldots,0,Y),\qquad
 c_{15}=(a_{15}b_{15})^{-1}.
\]

Each has one \(31\)-cycle and fifteen fixed letters; explicitly
\(a_{15}b_{15}\) fixes \(1,\ldots,15\) and cycles the other \(31\) letters.
For \(m=15,14,\ldots,1\), obtain permutations on one fewer letter as follows.
Put \(t=0\) when \(m\) is odd and \(t=m\) when \(m\) is even. Conjugate
\(a_m\) by the transposition \((t,31)\), conjugate \(b_m\) by \((t,16)\),
delete the now-fixed letter \(t\), and decrease every label larger than \(t\)
by one. This defines \(a_{m-1},b_{m-1}\); put
\(c_{m-1}=(a_{m-1}b_{m-1})^{-1}\).

At each of these fifteen finite steps, all three permutations have cycle
type \((31,1^{m-1})\), and \(a_{m-1},b_{m-1}\) have no common fixed letter.
Their two \(31\)-point supports intersect, so the latter condition makes
their generated group transitive. The exact direct check is the short,
dependency-free script 26_NIELSEN_TRIPLE_CERTIFICATE.py. This proves the
proposition. \(\square\)

## The relative Galois-closure dichotomy

Now let

\[
                 u,v:\mathcal T\rightrightarrows S               \tag{26.3}
\]

be a generalized-profile self-correspondence of degree \(d\), with coarse
functions \(x,r\in K=k(C)\). Let \(L_x\) and \(L_r\), inside a fixed
separable closure of \(K\), be the function fields of the Galois closures
of the two maps to \(\mathbf P^1\).

**Theorem 26.3 (independent-closure obstruction).** Suppose both legs in
(26.3) have monodromy \(A_d\). Then exactly one of the following holds.

1. \(L_x=L_r\), and the correspondence is visible.
2. \(L_x\cap L_r=K\), the extensions are linearly disjoint over \(K\), and
   \[
       \operatorname{Gal}(L_xL_r/K)
          \simeq A_{d-1}\times A_{d-1}.                         \tag{26.4}
   \]

Consequently every non-visible generalized-profile correspondence with
\(3\leq m\leq15\) must satisfy alternative 2.

### Proof

In the natural degree-\(d\) action of \(A_d\), a point stabilizer is
\(A_{d-1}\). Therefore

\[
              \operatorname{Gal}(L_x/K)\simeq A_{d-1},\qquad
              \operatorname{Gal}(L_r/K)\simeq A_{d-1}.           \tag{26.5}
\]

These are the relative Galois closures over \(C\). More intrinsically, after
putting the order-\(31\) roots at the common simple boundary \(U\), their
normalizations are finite etale Galois covers of \(\mathcal T\). At a high
point, the branch inertia \(C_{31}\) has trivial intersection with the
relevant point stabilizer, so \(L_x/K\) is unramified. At a point of \(U\),
that inertia lies in the point stabilizer, so \(L_x/K\) has ramification
index \(31\), exactly absorbed by the order-\(31\) root on \(\mathcal T\).
The same statements hold for \(L_r\).

The intersection \(E=L_x\cap L_r\) is Galois over \(K\). Its Galois group is
a quotient of each group in (26.5). Since \(A_{d-1}\) is simple, either
\(E=K\), or \(E=L_x=L_r\). In the first case the standard
Galois-intersection criterion gives linear disjointness and (26.4).

In the second case the common normalization \(W\) is simultaneously the
Galois closure of both legs. Both maps \(W\rightrightarrows S\) are Galois,
so \(W\to\mathcal T\) is a simultaneous Galois refinement. By Theorem 21.2
and Corollary 21.4, the correspondence is visible. \(\square\)

The same dichotomy applies in degree \(32\) when both legs have monodromy
\(A_{32}\), \(\operatorname{AGL}_5(2)\), or
\(\operatorname{AGL}_1(32)\): their point stabilizers are respectively
\(A_{31}\), \(\operatorname{GL}_5(2)=\operatorname{PSL}_5(2)\), and
\(C_{31}\), all simple. It does not directly apply to the natural projective
actions of \(\operatorname{PSL}_2(31)\) and
\(\operatorname{PSL}_2(32)\), whose point stabilizers are solvable Borel
groups.

The exceptional intersections can nevertheless be described completely.

**Corollary 26.4.**

1. In degree \(32\), a non-visible pair has linearly disjoint relative
   Galois closures unless both legs have monodromy
   \(\operatorname{PSL}_2(31)\). In that last case their intersection is
   either \(K\), or a cyclic extension of degree \(3\), \(5\), or \(15\)
   which is unramified over the coarse curve \(C\).
2. In degree \(33\), a non-visible pair has linearly disjoint relative
   Galois closures unless both legs have monodromy
   \(\operatorname{PSL}_2(32)\). In that last case their intersection is
   either \(K\), or a cyclic extension of degree \(31\), fully ramified at
   the six points of the common simple boundary and unramified elsewhere.

### Proof

In the degree-\(32\) projective action, a point stabilizer is

\[
 H_{31}=C_{31}\rtimes C_{15},
\]

with faithful action. Its only nontrivial proper quotients are
\(C_3,C_5,C_{15}\): the normal \(C_{31}\) is the commutator subgroup, and
the normal subgroups containing it are the inverse images of subgroups of
the cyclic quotient \(C_{15}\). The inertia of the relative closure at a
simple boundary point is precisely this \(C_{31}\), so every proper quotient
kills all inertia. The resulting intersection cover of \(C\) is unramified.

The other three degree-\(32\) point stabilizers listed above are pairwise
nonisomorphic simple groups and have no nontrivial common quotient with
\(H_{31}\). Thus any nontrivial intersection outside the projective/projective
case makes the two relative closures equal, which is visible by the proof of
Theorem 26.3.

In the degree-\(33\) projective action, a point stabilizer is

\[
 H_{32}=(C_2)^5\rtimes C_{31},
\]

where the Singer cycle \(C_{31}\) acts irreducibly on \((C_2)^5\). Its only
nontrivial proper normal subgroup is \((C_2)^5\), and hence its only
nontrivial proper quotient is \(C_{31}\). At each of the six simple boundary
points, relative inertia is a complement \(C_{31}\) and maps isomorphically
to this quotient. This proves the stated ramification. Finally,
\(H_{32}\) and the simple point stabilizer \(A_{32}\) have no nontrivial
common quotient. \(\square\)

## An exhaustive finite algorithm, and its exact bottleneck

For a fixed \(m\leq15\), the following is an exhaustive algorithm in
principle.

1. Enumerate, up to simultaneous conjugacy, all transitive triples (26.2).
   Theorem 26.1 sharply restricts their generated groups.
2. Construct the corresponding characteristic-zero Belyi maps and retain
   precisely the primes above \(5\) at which the Galois closure has tame good
   reduction. Proposition 26.2 shows that every characteristic-\(5\) cover
   occurs in this way. Alternatively one may solve the same finite tame
   Hurwitz scheme directly over \(\mathbf F_5\).
3. For every two retained covers, compute their source curves together with
   the reduced divisor \(U\) of the \(3m\) simple boundary points. Test
   isomorphism of these marked curves. On an isomorphic pair, transport the
   second function to the first source and test whether it differs from the
   first by a permutation of \(0,1,\infty\).
4. In the alternating cases, discard at once any pair whose two relative
   Galois closures meet nontrivially, by Theorem 26.3.

The third step is indispensable. Each full permutation triple determines
its own characteristic-zero Belyi cover and hence its own algebraic source,
but numerical cycle/profile data alone do not identify two such sources.
After choosing good reductions, one must still test whether the resulting
marked special-fiber curves are isomorphic. Requiring one finite cover to be
simultaneously Galois over both copies of \(S\) searches only the visible
case by file 21. A non-visible pair in degrees
\(34,\ldots,46\), if it exists, necessarily lies in the difficult remaining
case of two independent \(A_{d-1}\)-closures on the same marked curve.
