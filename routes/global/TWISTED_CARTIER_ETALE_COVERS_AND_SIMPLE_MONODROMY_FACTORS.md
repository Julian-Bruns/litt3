# Twisted Cartier on étale covers: exact simple-factor criterion

Date: 2026-09-05. Author: `/root/nongalois_twisted_cartier_simple_factors`.
Status: direct proof. This concerns a fixed quartic differential, not an
assertion that ordinary indigenous data exist on a given curve.

Let k be algebraically closed of characteristic 5, let C/k be a smooth
projective connected curve of genus h >= 2, and fix

\[
 A\in H^0(C,\omega_C^4),\qquad
 T_A(t)=C_1(At),\quad t\in H^0(C,\omega_C^2).
\]

Thus T_A is additive and inverse-Frobenius-semilinear:
T_A(a t)=a^{1/5}T_A(t). No eigenform or divisor hypothesis on A is
needed for the results below.

Fix a connected finite étale Galois cover q:W -> C with group G.
For a finite-dimensional F_5[G]-module M, let E(M) be its associated
étale vector bundle on C. Equivalently, form the local system with
fiber M and then tensor with O_C on the étale site and descend.
It has locally constant transition matrices in GL(M,F_5), and q^*E(M)
is trivial. Its F_5 structure supplies a canonical Frobenius structure.

## 1. The coefficient operator and exactness

On an étale trivialization of E(M), define T_(A,M) on a tuple of
quadratic differentials by applying t -> C_1(At) componentwise.
Cartier commutes with étale pullback. A locally constant F_5 matrix
commutes with this additive inverse-Frobenius-semilinear operation,
so the local formulas glue to

\[
 T_{A,M}:Q_A(M)\longrightarrow Q_A(M),\qquad
 Q_A(M):=H^0(C,\omega_C^2\otimes E(M)).                 \tag{1}
\]

The subscript A in Q_A records the accompanying operator; the
underlying vector space does not depend on A. Module homomorphisms
induce k-linear maps on these spaces that commute with T.

**Lemma.** The functor M -> Q_A(M), with its operator (1), takes every
short exact sequence of finite F_5[G]-modules to a short exact sequence
of finite-dimensional k-vector spaces with compatible semilinear
operators. Moreover,

\[
 \dim_k Q_A(M)=(3h-3)\dim_{\mathbf F_5}M.                \tag{2}
\]

**Proof.** Exactness of M -> E(M) can be checked after the faithfully
flat finite étale cover q, where it is just exactness of tensoring
F_5-vector spaces with O_W. It does not require exactness of the
invariant functor on abstract G-modules, or division by |G|.

Serre duality gives

\[
 H^1(C,\omega_C^2\otimes E(M))^\vee
   =H^0(C,\omega_C^{-1}\otimes E(M)^\vee)=0.             \tag{3}
\]

Indeed, a section on the right pulls back injectively to a section
of a direct sum of copies of q^*omega_C^{-1} on W. This line bundle
has degree -deg(q)(2h-2)<0, so all such sections vanish.
The cohomology sequence now proves the asserted exactness. Since
q^*E(M) is trivial, degree under finite pullback gives deg E(M)=0.
Riemann--Roch and (3) prove (2). Compatibility with T follows from
its componentwise construction. ∎

## 2. The exact criterion for a specified, possibly non-Galois cover

Let g:Z -> C be a connected finite étale cover, choose its finite
étale Galois closure q:W -> C, and write Z=W/H. Let

\[
 V=\mathbf F_5[G/H]
\]

be the permutation module of its geometric sheets. Concretely one
may regard V as F_5-valued functions on the sheets, with the action
(u f)(x)=f(u^{-1}x). Delta functions identify this with the usual
permutation module on basis vectors. Thus the function/permutation
dual convention makes no difference: this module is canonically
self-dual via its permutation-invariant dot product. Choose the
monodromy convention in E to match this sheet action. Then

\[
 E(V)\simeq g_*\mathcal O_Z,
 \qquad Q_A(V)\simeq H^0(Z,\omega_Z^2).                 \tag{4}
\]

The first isomorphism respects the canonical Frobenius structures;
the second follows from étaleness and the projection formula. On
an étale open where the sheets split, both operators are the same
componentwise Cartier operator. Consequently (4) intertwines
T_(A,V) with T_(g^*A) on Z.

**Theorem.** The following conditions are equivalent:

1. T_(g^*A) on H^0(Z,omega_Z^2) is bijective.
2. T_(A,S) is bijective for every simple F_5[G]-module S occurring
   as a composition factor of V.

Multiplicities and extension classes in V do not affect this
yes/no criterion. The criterion includes the modular case 5 | |G|.

**Proof.** Apply the lemma to a composition series of V. This gives
a T-stable filtration of Q_A(V) whose successive quotients, with
their operators, are exactly Q_A(S) with T_(A,S). For an exact
sequence 0 -> U -> B -> D -> 0 preserved by inverse-Frobenius-
semilinear endomorphisms, bijectivity on U and D implies bijectivity
on B by the elementary kernel and lifting argument. Conversely,
bijectivity on B makes the restriction to U injective; finite
dimension over the perfect field makes it surjective, and then the
quotient operator on D is bijective. Induction proves the claim,
using (4). ∎

Here “simple” means simple over F_5, not absolutely simple over k.
Replacing these factors silently by simple k[G]-modules is invalid:
Cartier is inverse-Frobenius-semilinear and can permute their
Frobenius-conjugate pieces. Working over F_5 keeps each factor's
canonical Frobenius structure. For example, a non-F_5-valued tame
character is carried to its inverse-Frobenius-conjugate character,
so an individual such character space need not be T-stable.

## 3. Serre property, descent, and 5-group towers

For fixed (C,A,q), call M good if T_(A,M) is bijective. The exactness
lemma and the proof above show that the good modules form a Serre
subcategory of the finite F_5[G]-modules: they are closed under
submodules, quotients, and extensions. Equivalently this subcategory
consists of precisely the modules supported on the good simple
composition factors. No tensor-closure assertion is made.

The trivial representation occurs in every nonempty permutation
module, through the subspace of constant functions, including when
5 divides the number of sheets. Hence

\[
 T_{g^*A}\text{ bijective }\quad\Longrightarrow\quad
 T_A\text{ bijective}.                                  \tag{5}
\]

If G is a 5-group, its only simple F_5-representation is the trivial
one. Thus for every subgroup H <= G,

\[
 T_{g^*A}\text{ bijective }\quad\Longleftrightarrow\quad
 T_A\text{ bijective},\qquad g:W/H\to C.                 \tag{6}
\]

In particular, bijectivity is preserved in both directions along
every finite tower of connected Galois étale 5-group covers, by
applying (6) at each stage. The statement has no degree bound and
therefore applies to existing towers of unbounded degree. It does
not establish the existence of such towers on an arbitrary C.
Nor does the numerical condition deg(g)=5^a suffice: the general
criterion concerns its Galois-closure monodromy, not just its degree.

There is also an exact comparison between intermediate covers of
this same W. If every simple composition factor of F_5[G/H] occurs
in at least one F_5[G/K_j], then bijectivity on all W/K_j implies
bijectivity on W/H. This uses the same A and actual quotient maps
to C throughout.

## 4. Application to the indigenous criterion and its limits

In the setting of the
[inverse-character criterion](ORDINARY_INDIGENOUS_INVERSE_CHARACTER_CARTIER_CRITERION.md),
take A=s^(4/d), with d=2 or 4 and with the eigenform and reduced
equimultiple-divisor hypotheses of that note. These hypotheses
persist under finite étale pullback. The associated indigenous
bundle on Z is therefore ordinary exactly when every simple factor
in the theorem is good. In particular, ordinary indigenous data
stay ordinary under every existing tower of Galois étale 5-group
covers.

This gives structure for the cover condition left open in the
[finite eigenform-pool reduction](FINITE_GENERALIZED_CARTIER_EIGENFORM_POOLS_AND_ETALE_COMPATIBILITY.md).
It does not turn endpoint ordinariness into source ordinariness
for arbitrary finite étale covers: new simple monodromy factors
must pass their own tests. It does not bound possible monodromy
groups or degrees, produce a common source, or identify the
monodromy groups of the two legs of a span.

The result resembles the simple-factor comparison in the earlier
[projective Frobenius-defect note](PROJECTIVE_FROBENIUS_DEFECT_AND_NONGALOIS_QUOTIENT_TESTS.md),
but its proof and object differ. That note concerns ordinary
cohomology H^1(O), nilpotent Frobenius, and projective k[G]-modules.
Here the fixed-A operator acts on quadratic differentials with
finite F_5 coefficients; vanishing (3) makes global sections exact,
so a composition-series argument suffices. In weight one the
analogous H^1 vanishing is generally false. No projectivity theorem
for the twisted-Cartier kernel is used or asserted.
