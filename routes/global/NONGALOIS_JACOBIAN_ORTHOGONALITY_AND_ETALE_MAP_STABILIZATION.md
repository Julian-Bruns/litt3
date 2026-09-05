# Non-Galois Jacobian orthogonality and stabilization of actual etale maps

Author: `/root`. Date: 2026-09-05.
Status: independently checked **PASS**, with nonbreaking wording suggestions
incorporated. The whole-Jacobian descent theorem has an independent
**PASS** from `/root/gluing_cohomology_rigidity`, 2026-09-05, with no
breaking objection; its principal suggestion was the fiber-product proof
which removes Galoisness. The one-factor non-Galois extension and graph
application received **PASS** from `/root/x_elliptic_quotient_maps`,
2026-09-05. The preceding Galois version also received focused PASS verdicts.
[Audit record: scope, auditors, date and suggestions](audits/NONGALOIS_JACOBIAN_STABILIZATION_AUDIT.md).
No claim to have solved Litt's problem or to have established priority.

## 1. Setup and statements

All curves are smooth projective geometrically connected over an
algebraically closed field `k`. A hyperbolic curve means one of genus at
least two. All Jacobian homomorphisms and isogeny factors are geometric.
Write `Hom^0=Hom tensor Q`.

Let

\[
                 V\xleftarrow{q}W\xrightarrow{r}X                     \tag{1}
\]

be an actual diagram, with `q` finite etale. Set

\[
                 P_q=(\ker(q_*:J(W)\to J(V)))_{\rm red}^0.
\]

### Theorem A: exact descent from whole-Jacobian orthogonality

If `X` is hyperbolic and `Hom(P_q,J(X))=0`, every morphism `r:W->X`
descends uniquely through `q` to a morphism `V->X`. If `r` is finite
etale, so is the descended morphism. No Galois assumption on `q` is made.

### Theorem B: bounded descent from one factor

Let `X` be hyperbolic, and let `A` be a simple isogeny factor of `J(X)`.
There is an integer `M=M(X,A)>0` such that, whenever both arrows in
(1) are finite etale and `Hom(P_q,A)=0`, the normalization `C` of the
image of `(q,r):W->V times X` fits in an actual diagram

\[
                 V\longleftarrow C\longrightarrow X,
                       \qquad \deg(C/V)\le M,                         \tag{2}
\]

whose two arrows are finite etale. The integer is independent of `V,W`
and both cover degrees. In particular no Galoisness is required anywhere.

### Theorem C: stabilization in arbitrary nested etale towers

Let `W_n/B`, `n>=0`, be any nested connected finite etale tower with
fixed hyperbolic base `B`, in a common field `E_infty=union k(W_n)`.
Let `X` be hyperbolic and `A` one simple factor of `J(X)`.
If `m_A(J(W_n))` is bounded, all finite etale maps from sufficiently high
tower levels to `X` descend to a single finite level. Equivalently, up to identification
after pullback along the tower, there are finitely many actual such maps.

These statements do not replace the two etale maps of a hypothetical
common cover by unrelated Jacobian embeddings. Theorem B and its tower
application retain the actual maps in (1). The elliptic-factor proof
explicitly needs etaleness of `r`.

## 2. A norm identity on the actual equivalence relation

By Poincare reducibility and `q_*q^*=[deg q]`, the Jacobian `J(W)` is
isogenous to `J(V) times P_q`. Consequently, if `Hom(P_q,A)=0`,
composition with norm is an isomorphism

\[
 \operatorname{Hom}^0(J(V),A)\xrightarrow{\ \sim\ }
 \operatorname{Hom}^0(J(W),A),\qquad \psi\longmapsto\psi q_* .          \tag{3}
\]

Let `a:X->A` be any morphism. Choose `w_0 in W(k)` and compatible
Abel base points. Clearing denominators in (3), the Albanese universal
property gives an actual homomorphism `psi:J(V)->A` and an integer
`n>0` such that

\[
 [n]\big(a r(w)-a r(w_0)\big)
       =\psi\big([q(w)-q(w_0)]\big).                                  \tag{4}
\]

Now use the actual fiber product

\[
                        E=W\times_V W.
\]

Its connected components `E_j` are smooth projective connected curves,
and both projections `E_j->W` are surjective finite etale maps. By (4),

\[
 \delta_j=a r\operatorname{pr}_1-a r\operatorname{pr}_2:E_j\to A
                  \quad\hbox{has image in }A[n].                      \tag{5}
\]

The finite group scheme `A[n]` is affine and `H^0(E_j,O)=k`. Thus (5)
is a constant geometric point `c_j in A[n](k)`. This remains true if
the characteristic divides `n`: no division on points, etaleness of the
isogeny, or reducedness of `A[n]` is being assumed.

If `r` is nonconstant, both maps `r pr_i` are surjective. Hence every
`c_j` translates the reduced image `a(X)` onto itself.

## 3. The Abel--Jacobi curve has trivial translation stabilizer

Let `i:X->J(X)` be an Abel--Jacobi embedding, with `g(X)>=2`.
The group `K` of geometric translations preserving `i(X)` injects into
the finite group `Aut(X)`, so is finite. It acts freely on `X`, since
a nonzero translation of an abelian variety has no fixed point.

Each element acts trivially on `J(X)`: translating `i(x)` changes the
basepoint constant but not the induced Jacobian homomorphism. For the
finite etale quotient `pi:X->X/K`, the norm identity is therefore

\[
                 \pi^*\pi_* =\sum_{h\in K}h_*=[|K|]\quad\hbox{on }J(X).
                                                                         \tag{6}
\]

Multiplication by a nonzero integer on an abelian variety is surjective,
including when that integer is divisible by the characteristic. Equation
(6) implies `g(X/K)>=g(X)`. On the other hand etale Riemann--Hurwitz gives

\[
                        g(X)-1=|K|(g(X/K)-1).
\]

As `g(X)>=2`, necessarily `|K|=1`.

**Proof of Theorem A.** Constant maps descend. Otherwise apply (4)--(5)
with `A=J(X)` and `a=i`. The preceding paragraph makes every `c_j=0`.
Since `i` is an embedding, `r pr_1=r pr_2` on `W times_V W`. Faithfully
flat descent along the surjective finite etale map `q` gives a unique
map `V->X`. When `r` is etale this factor is nonconstant, finite and
separable. Multiplicativity of ramification indices, or etale descent,
makes it etale. This proves Theorem A, also for initially inseparable
nonconstant `r` when no etaleness conclusion is requested.

## 4. A uniform finite set of possible translations for one factor

Choose a quotient `J(X)->A` and let `a:X->A` be its composition with
an Abel--Jacobi map. Its reduced image `D=a(X)` is a nonconstant curve
generating `A`. Put `d=[k(X):k(D)]_sep`.

### 4.1. Dimension at least two

If `dim A>=2`, the translation stabilizer

\[
                        K_D=\{c\in A(k):D+c=D\}
\]

is finite. Indeed a positive-dimensional reduced connected stabilizer
would be an abelian subvariety whose cosets lie in the curve `D`, hence
an elliptic subvariety. This contradicts simplicity of `A`. More
generally the same conclusion holds for any generating curve in an
abelian variety of dimension at least two, since the curve would be a
coset of that elliptic subvariety.

All constants in (5) belong to `K_D`. Take

\[
                              M=|K_D|d.                               \tag{7}
\]

### 4.2. Elliptic factors

For elliptic `A`, choose a separable nonconstant map `a:X->A'`, where
`A'` is an elliptic curve isogenous to `A`, and rename `A'` as `A`.
This is possible without changing `X`: factor an initial map through
the maximal relative Frobenius of `X`, then inverse-twist its separable
factor. Frobenius twists of an elliptic curve are isogenous to it, so
the orthogonality hypothesis and isogeny multiplicity are unchanged.
See [Stacks, Proposition 53.13.7](https://stacks.math.columbia.edu/tag/0CD2).

The branch-value set `S_a` is nonempty and finite: the different of `a`
has degree `2g(X)-2>0`. Since `r pr_i:E_j->X` is etale, the branch-value
set of each composite `a r pr_i` is exactly `S_a`. This uses the
different identity in a tower and allows wild ramification of `a`.
Equation (5) implies

\[
                           S_a+c_j=S_a.
\]

The translation group `K_{S_a}` preserving this finite nonempty set has
size at most `|S_a|`: its action on a fixed point is free. Thus we may use

\[
                         M=|K_{S_a}|\deg a\le |S_a|\deg a.            \tag{8}
\]

Allowing arbitrary ramification in `r` would introduce extra branch
values and invalidate this fixed bound. Its etaleness is substantive.

## 5. Counting the joint image, without a deck group

Fix a geometric generic point `v` of `V` and one point `w_0` of the
finite etale fiber `q^{-1}(v)`. For any other point `w` of that fiber,
the pair `(w,w_0)` lies on some component `E_j`, and (5) says

\[
                           a(r(w))=a(r(w_0))+c_j.                     \tag{9}
\]

There are at most `|K_D|`, respectively `|K_{S_a}|`, possible values on
the right. The map from `X` to the normalization of `D` has at most `d`
geometric points in a generic fiber; a purely inseparable part creates
no extra points. The values in (9), when realized, are generic points
of `D`, so there are at most `M` distinct values `r(w)`.

The field of the normalization of the joint image is exactly

\[
                       k(C)=k(V)\,r^*k(X)\subset k(W).
\]

This is a separable intermediate extension of `k(W)/k(V)`. Its degree
over `k(V)` is the number of distinct restrictions of the geometric
generic fiber embeddings to `r^*k(X)`, equivalently the number of
distinct values `r(w)` just counted. Therefore `deg(C/V)<=M`.
Both `C/V` and `C/X` are intermediate extensions of the original finite
etale covers in (1), hence finite etale. This proves Theorem B.

## 6. Finitely many actual maps along an arbitrary etale tower

Norm surjectivity makes `m_A(J(W_n))` nondecreasing. If bounded, it is
constant for `n>=N`. For each `q:W_n->W_N`, simplicity of `A` and the
isogeny decomposition show `Hom(P_q,A)=0`. Apply Theorem B to every
actual etale `r:W_n->X`.

There are finitely many connected etale covers of `W_N` of degree at
most `M`, because the etale fundamental group of a proper curve is
topologically finitely generated. Each representative has at most its
degree many embeddings over `k(W_N)` into `E_infty`. Thus only finitely
many actual embedded fields `k(C)` from (2) occur, not merely finitely
many abstract source curves.

For each such `C`, there are finitely many etale maps to the fixed `X`:
their degree is `(g(C)-1)/(g(X)-1)`, there are finitely many covers of
`X` of that degree, and `Aut(C)` is finite. Consequently only finitely
many actual embeddings `k(X)->E_infty` arise from all the maps under
consideration. A single finite tower level contains their finitely many
images. Every later map descends to this level, and remains etale by
the intermediate-cover argument. The finitely many earlier levels
contribute only finitely many additional maps. This proves Theorem C.

## 7. Uniform targets when new Jacobian parts are ordinary

In characteristic `p`, suppose `P_q` is ordinary and `J(X)` has no
ordinary simple isogeny factor. Then `Hom(P_q,J(X))=0`, so Theorem A
applies. Thus **every** morphism `W->X` descends through `q`.

If the successive Pryms in any nested etale tower are ordinary from
level `N` onward, all composite Pryms `P_(W_n/W_N)` are ordinary up to
isogeny. The same level `W_N` therefore receives every etale target map
to every hyperbolic `X` whose Jacobian has no ordinary simple factor.
In particular there are only finitely many such target isomorphism
classes occurring anywhere in the tower.

For completeness, a fixed hyperbolic curve `V` has finitely many etale
quotient curves of genus at least two, even when the target varies.
Indeed `d=deg(V/X)<=g(V)-1`. A Galois closure `U/X` has `U/V` finite
etale of degree at most `(d-1)!`. There are finitely many such covers
of `V`, and each `Aut(U)` is finite, with finitely many subgroups and
quotient curves. This proves the assertion, including targets reached
at earlier tower levels by pulling their maps up to `W_N`.

## 8. Coreless correspondences force every endpoint factor to grow

Let `X<-Z->Y` be a coreless bi-etale correspondence of hyperbolic curves.
In its connected two-colored generic graph, choose a distinguished
`X` vertex and the nested closed-ball fields. These are finite Galois
extensions of the distinguished field, and exhaust the graph field:
[Krishnamoorthy, Lemma 5.4, Corollaries 5.5 and 5.8](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf).
All corresponding curve maps to `X` are etale, since they are obtained
by finite etale fiber products and Galois closures. More generally any
nested cofinal sequence of such finite etale subfields may be used.

By the same paper's Proposition 5.10, corelessness makes this connected
locally finite graph infinite, hence gives infinitely many vertices of
each color. For a chosen vertex, include its entire path field from
the distinguished vertex in a tower level. This certifies an actual
etale map from that level to the fixed endpoint represented by the
vertex, not just an embedding of its function field. Infinitely many
vertices give infinitely many such actual maps. There are also infinitely
many image fields: each fixed image field accounts for at most the finite
number of automorphisms of the endpoint curve.

Theorem C implies, for every simple factor `A` of either endpoint,

\[
                            m_A(J(W_n))\longrightarrow\infty.         \tag{10}
\]

For a nonordinary endpoint choose `A` with
`Delta(A)=dim A-f(A)>0`. Isogeny additivity gives

\[
                 g(W_n)-f(W_n)\ge m_A(J(W_n))\Delta(A)\to\infty.      \tag{11}
\]

Thus bounding even one endpoint factor along an actual cofinal core
tower forces a core. This implication is parameterized and applies in
every degree; original legs and chosen tower need not be Galois.

## 9. Exact remaining gap

No bound on (10) has been proved for the tower forced by a hypothetical
common cover of our candidate curves. Arbitrarily choosing a cyclic
tower with bounded defect does not make it cofinal in that core tower.
Raynaud's no-theta covers also show that base-changing an initial
nonordinary etale cover along an ordinary curve's abelian tower can
have unbounded total defect. In particular bounded one-step monodromy and
fixed finite prime support alone do not bound defect. Such growth need not be growth of a fixed
isogeny type; these are separate issues.

The fixed genus-nine curve of file 76 has an absolutely simple
nonordinary Jacobian and so meets the target hypothesis of Section 7.
This theorem does not need absolute simplicity of the whole Jacobian:
Theorem C and (10) apply factor by factor, including elliptic factors.
The known Galois deck-rigidity results 87, 90, 91 and 92 have different
hypotheses and are not claimed to be superseded.
