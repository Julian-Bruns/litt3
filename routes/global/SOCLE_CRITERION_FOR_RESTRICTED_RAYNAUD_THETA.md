# A socle criterion for proper restricted Raynaud theta

Date: 2026-09-05.
Provenance: the origin-socle criterion and generic section-dimension gap
were supplied by the user in a GPT6Pro response.
Focused proof check: **PASS**, /root/gluing_cohomology_rigidity,
2026-09-05, including modular descent and intermediate covers.
The multipoint formulation and the projective-nilpotent equivalence below
were checked and written by /root/gluing_cohomology_rigidity.
Status: proved with the cited existing inputs; no literature novelty claim
and no independent audit of the entire consolidated note.

## 1. Setup and statement

Let \(k=\overline{\mathbf F}_p\), and let
\[
                            q:W\longrightarrow C
\]
be a connected finite étale Galois cover of smooth projective connected
curves of genus at least two, with group \(G\). In particular \(p=5\)
is allowed. There is no restriction on divisibility of \(|G|\) by \(p\).
Write \(q_1:W^{(1)}\to C^{(1)}\) for its Frobenius twist, and
\[
 B_C=\operatorname{coker}(\mathcal O_{C^{(1)}}\to F_{C*}\mathcal O_C),
 \qquad
 B_W=\operatorname{coker}(\mathcal O_{W^{(1)}}\to F_{W*}\mathcal O_W).
\]
For \(L\in J(C^{(1)})(k)\), put
\[
 \mathcal D(L)=H^0(W^{(1)},B_W\otimes q_1^*L),\qquad
 \mathcal D_W=\mathcal D(\mathcal O).
                                                               \tag{1.1}
\]
These are finite-dimensional \(kG\)-modules. Define
\[
 a(W)=\dim_k\mathcal D_W,\qquad
 \delta_q=\dim_k\mathcal D(L)\quad\text{for generic }L.        \tag{1.2}
\]
Here \(a(W)\) is the a-number of the Jacobian. The generic section
dimension \(\delta_q\) is **not** the p-rank defect
\(\Delta(W)=g(W)-f_W\).

**Theorem 1: the origin-socle criterion.** Suppose every simple
submodule of \(\mathcal D_W\) is one-dimensional; equivalently,
its socle is a sum of character modules. Then
\[
                         \mathcal D(L)=0
                \quad\text{on a nonempty open subset of }J(C^{(1)}).
                                                               \tag{1.3}
\]
Thus \(q_1^*J(C^{(1)})\) is not contained in the Raynaud theta divisor
of \(W\).

The hypothesis concerns the **socle**, not all composition factors of
\(\mathcal D_W\), and not all simple modules of \(G\).

## 2. A modular-safe associated-bundle identity

For each simple \(kG\)-module \(S\), define the associated bundle
\[
                  E_S=(q_{1*}\mathcal O_{W^{(1)}}\otimes_k S^\vee)^G
                        \quad\text{on }C^{(1)}.             \tag{2.1}
\]
Finite étale torsor descent makes \(E_S\) a vector bundle of rank
\(\dim S\), trivialized by pullback to \(W^{(1)}\).
This follows after an étale-local trivialization of the torsor; it does
not require semisimplicity of \(kG\).

For every \(L\), there is a natural identification
\[
 \boxed{\quad
 \operatorname{Hom}_{kG}(S,\mathcal D(L))
     =H^0(C^{(1)},B_C\otimes L\otimes E_S).
 \quad}                                                     \tag{2.2}
\]

Indeed the étale Frobenius square gives the equivariant identity
\(B_W=q_1^*B_C\). Projection formula then identifies \(\mathcal D(L)\)
with the global sections of
\(B_C\otimes L\otimes q_{1*}\mathcal O_{W^{(1)}}\).
Tensor by \(S^\vee\) and take invariants. Global sections commute
with invariants because invariants are a kernel, and tensoring by the
trivial-action locally free bundle \(B_C\otimes L\) also commutes with
this kernel. This proves (2.2).

In particular, the proof does **not** assert that invariants are an
exact functor on arbitrary \(kG\)-modules, and never averages by
\(|G|\).

If \(S=\chi\) is one-dimensional, \(E_\chi\) is a line bundle of finite
order prime to \(p\). The finite image of \(\chi:G\to k^\times\)
has prime-to-\(p\) order, so a corresponding tensor power of
\(E_\chi\) is trivial. Consequently
\[
       \{L:H^0(C^{(1)},B_C\otimes L\otimes E_\chi)\ne0\}
                                                               \tag{2.3}
\]
is a translate of the proper Raynaud theta divisor of \(C\).
The input is [Raynaud, Theorem 4.1.1](https://www.numdam.org/article/BSMF_1982__110__103_0.pdf),
as used in
[the existing restricted-theta note](RESTRICTED_RAYNAUD_THETA_SUFFICIENT_CONDITIONS_AND_STABILITY_BOUNDARY.md).

### Proof of Theorem 1

There are finitely many isomorphism classes of simple \(kG\)-modules.
For each \(S\) of dimension greater than one, the hypothesis and (2.2)
give
\[
                         H^0(C^{(1)},B_C\otimes E_S)=0.
\]
Upper semicontinuity in \(L\) gives a nonempty open subset, containing
the origin, on which the right side of (2.2) vanishes.
For each character simple, the complement of (2.3) is likewise a
nonempty open subset.

Intersect these finitely many opens. The Jacobian is irreducible, so
their intersection is nonempty. There every simple \(S\) has
\(\operatorname{Hom}_{kG}(S,\mathcal D(L))=0\).
Every nonzero finite-dimensional module over a finite-dimensional
algebra has a nonzero simple submodule. Hence \(\mathcal D(L)=0\),
proving (1.3). \(\square\)

## 3. Translated and multipoint tests

The origin is not essential.

**Theorem 2.** The following conditions are equivalent:

1. The restricted theta locus is proper, or equivalently \(\delta_q=0\).
2. There exists \(L_0\) such that the socle of \(\mathcal D(L_0)\)
   contains only one-dimensional simples.
3. For each simple \(S\) of dimension greater than one, there exists
   a point \(L_S\), possibly depending on \(S\), such that
   \[
                    \operatorname{Hom}_{kG}(S,\mathcal D(L_S))=0.
                                                               \tag{3.1}
   \]

The first condition implies the others by choosing a point where
\(\mathcal D(L)=0\), and the second implies the third. For the third
implying the first, apply semicontinuity separately at each \(L_S\),
then intersect the resulting finitely many opens with the character
opens (2.3). The final socle argument is unchanged.

More generally, for any finite set of test points, the generic socle
support is contained in the intersection of their socle supports,
after all one-dimensional simples have been deleted. A separate test
point for each higher-dimensional simple is therefore sufficient:
one need not locate a common point satisfying all the vanishings
in advance.

This is a finite collection of actual section tests on one cover.
It is not a claim that stability of the associated bundles supplies
those tests.

## 4. The generic section-dimension gap

Let
\[
 m_p(G)=\min\{\dim S:S\text{ simple over }kG,\ \dim S>1\},
                                                               \tag{4.1}
\]
with \(m_p(G)=+\infty\) if no such simple exists.

**Corollary 3.** For every cover in §1, without the socle hypothesis,
\[
                \delta_q=0\quad\text{or}\quad
                    m_p(G)\le\delta_q\le a(W).              \tag{4.2}
\]
Indeed the character opens always exclude one-dimensional simples
from the generic socle. If the generic section module is nonzero,
it therefore contains a simple submodule of dimension at least
\(m_p(G)\). Upper semicontinuity gives
\(\delta_q\le\dim\mathcal D(\mathcal O)=a(W)\).
One may make this argument at a \(k\)-point in the intersection of
the generic-dimension open and all the character opens.

Thus \(a(W)<m_p(G)\) is a sufficient condition for properness.
At translated test points one can instead use their section dimensions
and the higher-dimensional simple supports that remain after the
tests of §3. If no higher-dimensional simple survives, properness
follows regardless of the dimensions contributed by characters at
the individual test points.

Formula (4.2) does not estimate \(\Delta(W)=g(W)-f_W\).
Away from the origin, no Frobenius endomorphism of a single
\(\mathcal D(L)\) or twisted \(H^1\) is asserted.

## 5. Exact bridge to the projective nilpotent module

Set
\[
 V_W=H^1(W,\mathcal O_W),\qquad
 \mathcal N_W=(V_W)_{\rm nil}=\bigcup_{r\ge0}\ker F^r,
                                                               \tag{5.1}
\]
where \(F\) is absolute Frobenius, a semilinear endomorphism.
The theorem in
[Projective Frobenius defect and non-Galois quotient tests](PROJECTIVE_FROBENIUS_DEFECT_AND_NONGALOIS_QUOTIENT_TESTS.md)
proves that \(\mathcal N_W\) is projective over \(kG\), even when
\(p\mid |G|\). Write
\[
                         \mathcal N_W=\bigoplus_S P(S)^{m_S},
                                                               \tag{5.2}
\]
where \(P(S)\) is the indecomposable projective cover of \(S\).

**Theorem 4.** The origin hypothesis of Theorem 1 is equivalent to
\[
                      m_S=0\quad\text{whenever }\dim S>1.
                                                               \tag{5.3}
\]
Equivalently, \(\mathcal N_W\) is a direct sum of projective covers
\(P(\chi)\) of character modules.

### Proof, including semilinearity

The defining sequence for \(B_W\) identifies \(\mathcal D_W\) with
the kernel of relative Frobenius on coherent \(H^1\): the preceding
map on \(H^0\) of the structure sheaf is an isomorphism.
After the standard scalar-twist identification this is
\(\ker(F:V_W\to V_W)\). This identification can Frobenius-twist the
labels of simple representations, but preserves their dimensions.
In particular, the condition that all socle constituents are
one-dimensional is identical for these two kernels.

All of \(\ker F\) lies in \(\mathcal N_W\), and
\[
             \operatorname{soc}(\ker F)
                   =\operatorname{soc}(\mathcal N_W)\cap\ker F.
                                                               \tag{5.4}
\]
Every simple submodule of the left side is a simple submodule of
\(\mathcal N_W\); conversely the intersection on the right is a
submodule of a semisimple module, and hence is semisimple. This proves
(5.4).

Let \(U\) be the sum of the socle isotypes of \(\mathcal N_W\)
whose simple constituents have dimension greater than one.
Frobenius preserves \(U\). To see this without treating Frobenius
as \(k\)-linear, note that on a simple submodule its kernel is
either zero or the whole module. A nonzero image is again simple,
isomorphic to a Frobenius twist of the original representation,
and has the same dimension. Perfection of \(k\) ensures that this
semilinear image is a \(k\)-subspace. Thus Frobenius carries a simple
type to its twist or to zero, and preserves the sum defining \(U\).

Frobenius is nilpotent on \(\mathcal N_W\). If \(U\ne0\), its
restriction to \(U\) therefore has nonzero kernel. Since \(U\)
is semisimple with only higher-dimensional constituents,
this kernel contains a higher-dimensional simple submodule.
By (5.4) it occurs in \(\operatorname{soc}(\ker F)\).
Consequently
\[
 \operatorname{soc}(\ker F)\text{ has only character simples}
 \quad\Longleftrightarrow\quad
 \operatorname{soc}(\mathcal N_W)\text{ has only character simples}.
                                                               \tag{5.5}
\]
The reverse implication in (5.5) also follows directly from (5.4).

Finally \(kG\) is a symmetric algebra, so
\(\operatorname{soc}P(S)\simeq S\), with multiplicity one.
Taking socles in (5.2) makes the right side of (5.5) exactly (5.3).
This proves the theorem. \(\square\)

It is \(\mathcal N_W\), **not** \(\ker F\), whose projectivity is
used. The first Frobenius kernel need not be projective.
Moreover \(P(\chi)\) can have higher-dimensional composition factors;
(5.3) does not turn the whole defect module into a module filtered
only by character simples.

## 6. Intermediate curves and the exact remaining gap

For any subgroup \(H\le G\), put \(Z=W/H\) and let \(f:Z\to C\)
be the actual intermediate cover. Étale base change gives
\[
 H^0(Z^{(1)},B_Z\otimes f^{(1)*}L)=\mathcal D(L)^H.           \tag{6.1}
\]
This is ordinary torsor descent of sections, valid without averaging
by \(|H|\). In particular pullback is injective, and properness for
the Galois cover implies properness for every intermediate cover.

If \(Z\) also has an actual finite étale map \(g:Z\to Y\), the
two-leg locus
\[
 \{(L,M):
     H^0(Z^{(1)},B_Z\otimes f^{(1)*}L\otimes g^{(1)*}M)\ne0\}
                                                               \tag{6.2}
\]
is then proper, since its restriction to \(M=\mathcal O\) is already
proper. Both original maps are retained.

The older
[restricted-theta sufficient condition](RESTRICTED_RAYNAUD_THETA_SUFFICIENT_CONDITIONS_AND_STABILITY_BOUNDARY.md),
§1, assumes that every simple module of \(G\) is a character,
equivalently that \(G\) has a normal p-Sylow subgroup with abelian
quotient. The present result only constrains the actual defect
module of the chosen cover. Together with Theorem 4, it converts
the already proved projective-module support into a new sufficient
test for restricted theta. The older exact divisor formula from a
character filtration is not asserted under the weaker socle
hypothesis.

The unresolved input is whether the actual Galois closure has this
socle support, or passes the translated tests in §3.
Neither the existence of a second étale leg, nor minimality, nor
Hom-orthogonality of endpoint Jacobians supplies that condition here.
In particular a small \(a(Z)\) is not a bound on \(a(W)\):
the pullback injection gives \(a(Z)\le a(W)\), in the opposite
direction needed to invoke \(a(W)<m_p(G)\).
No replacement of the actual Galois closure by a numerically more
favorable unrelated cover is allowed by this argument.
