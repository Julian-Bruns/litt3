# Etale refinement cannot repair a simultaneous-lifting obstruction

**Status: author proof, 2026-09-05; independent audit pending.**
Author: `/root`.

This is an all-degree structural consequence of the deformation mechanism
in file 110. It applies to arbitrary finite etale refinements, not merely
Galois or prime-to-characteristic ones. It also explains a contrast:
the simultaneous-lifting obstruction persists under refinement, whereas
the elementary cross-trace operators can all be erased by a refinement
whose degree is divisible by the characteristic.

Throughout k is algebraically closed of characteristic p > 0. Curves
are smooth, projective, connected and of genus at least two. All
deformations are marked: their special fiber is identified with the
specified original curve and maps.

## 1. The full deformation statement

Fix a bi-etale diagram and a further finite etale cover:

\[
       f:Z\longrightarrow X,\qquad g:Z\longrightarrow Y,
       \qquad h:W\longrightarrow Z.
\]

For a local Artinian W(k)-algebra A with residue field k, let
Def(f,g)(A) be the set of marked smooth proper deformations of
X,Y,Z and both maps over A. Define Def(fh,gh)(A) similarly.
The maps in a deformation are required to be finite etale. This is
also automatic for finite flat liftings of these etale special-fiber
maps, but no such reformulation is needed here.

### Theorem 116.1

Lifting the fixed cover h through an etale deformation gives a natural
bijection, for every A:

\[
                 \boxed{\operatorname{Def}(f,g)(A)
                      \xrightarrow{\sim}\operatorname{Def}(fh,gh)(A).}
                                                               \tag{116.1}
\]

In particular, the original diagram lifts simultaneously over W_m(k)
if and only if its refinement does, for every finite m >= 1.

The assertion concerns refinements of the SPECIFIED correspondence.
It does not identify all different correspondences between the same
pair of target curves.

## 2. Negative line bundles give injectivity without a trace denominator

### Lemma 116.2

For any finite etale h:W -> Z and any negative-degree line bundle L
on Z, the pullback map

\[
                         H^1(Z,L)\longrightarrow H^1(W,h^*L)
                                                               \tag{116.2}
\]

is injective. No assumption on p dividing deg(h) is made.

#### Proof

The quotient

\[
                         Q=h_*O_W/O_Z
\]

is locally free: etale locally it is the quotient of a permutation
module by its constant-vector line. After a finite etale Galois
closure Z' -> Z it becomes a trivial vector bundle. This uses
trivialization of the finite etale cover, not semisimplicity of a
representation and not division by its degree.

A section of L tensor Q pulls back to a section of a direct sum
of negative-degree line bundles on Z', so it must vanish. Faithful
flatness gives H^0(Z,L tensor Q) = 0.

Tensor the exact sequence 0 -> O_Z -> h_*O_W -> Q -> 0 by L.
The cohomology sequence, together with the projection formula and
the vanishing just proved, gives the injection (116.2). \(\square\)

For L = T_Z, etaleness identifies h^*T_Z with T_W. We obtain

\[
 a_h:H^1(Z,T_Z)\hookrightarrow H^1(W,T_W).               \tag{116.3}
\]

This is the tangent map on deformation spaces used below.

## 3. The deformation of a curve is recoverable from its etale cover

Write Def(C)(A) for marked deformations of a single curve C over A.
Finite etale covers are invariant under a nilpotent thickening, so
the fixed h induces a natural map

\[
                      \Phi_h:\operatorname{Def}(Z)
                                        \longrightarrow\operatorname{Def}(W).
\]

### Lemma 116.3

The map Phi_h is a monomorphism of deformation functors: for every A,
it is injective on marked isomorphism classes. Any marked isomorphism
between the two resulting W-deformations is induced by the unique
marked isomorphism between the Z-deformations.

#### Proof

First, a marked deformation of any curve C of genus at least two
has no nontrivial automorphism reducing to the identity on C.
Induct over small extensions of the base. Across an extension with
kernel I annihilated by the maximal ideal, the possible difference
automorphisms lie in

\[
                            H^0(C,T_C)\otimes_k I=0,
\]

since T_C has negative degree.

Now induct on the length of A. Choose a small quotient A -> A_0
with kernel I annihilated by the maximal ideal. Suppose two marked
Z-deformations over A induce isomorphic marked W-deformations.
By induction the Z-deformations over A_0 are uniquely isomorphic.
Use that isomorphism to regard both as liftings of the same
deformation over A_0.

Their difference class is an element

\[
                         \delta\in H^1(Z,T_Z)\otimes_k I.
\]

Functoriality of lifting an etale cover sends this difference to
a_h(delta). The W-deformations are isomorphic, so a_h(delta) = 0.
Lemma 116.2 implies delta = 0. The two Z-deformations are therefore
isomorphic over A, compatibly with the specified isomorphism over A_0.

Uniqueness follows from the vanishing of infinitesimal automorphisms.
The induced W-isomorphism is likewise the given one, since their
difference would be an automorphism reducing to the identity.
This completes the induction. \(\square\)

Only standard square-zero deformation theory of smooth curves is
used: lifting differences lie in H^1(T) tensor I and automorphism
differences in H^0(T) tensor I. The argument is independent of any
chosen origin in a deformation torsor.

## 4. Proof of Theorem 116.1

An etale map f:Z -> X identifies its deformation problem with
deforming X and then lifting the fixed cover. Similarly for g.
Since marked curve deformations have no infinitesimal automorphisms,
the simultaneous deformation functor is the fiber product

\[
 \operatorname{Def}(f,g)=
 \operatorname{Def}(X)\times_{\operatorname{Def}(Z)}\operatorname{Def}(Y),
                                                               \tag{116.4}
\]

using the maps Phi_f and Phi_g. The corresponding two maps into
Def(W) are exactly Phi_h Phi_f and Phi_h Phi_g. Because Phi_h is
a monomorphism by Lemma 116.3, the fiber product does not change
when its middle functor is replaced by Def(W):

\[
 \operatorname{Def}(X)\times_{\operatorname{Def}(Z)}\operatorname{Def}(Y)
 \simeq
 \operatorname{Def}(X)\times_{\operatorname{Def}(W)}\operatorname{Def}(Y).
                                                               \tag{116.5}
\]

The right side is Def(fh,gh), proving the theorem.

Concretely, given a refined diagram over A, lift the intermediate
cover Z/X from its X-deformation, and separately lift Z/Y from its
Y-deformation. Their induced W-deformations are both the supplied
one. Lemma 116.3 identifies the two Z-deformations uniquely. This
recovers the original simultaneous diagram, as well as the compatible
lift of h. \(\square\)

The same proof works for any finite number of etale maps from the
same source.

## 5. The first obstruction embeds under refinement

At W_2 level, use the notation of file 110:

\[
 V_C=H^1(C,T_C),\qquad
 Q_{f,g}=V_Z/(a_fV_X+a_gV_Y).
\]

The affine obstruction o(f,g) belongs to Q_(f,g). Functoriality and
Lemma 116.2 give an injection

\[
 \begin{aligned}
 \bar a_h:Q_{f,g}&\hookrightarrow Q_{fh,gh},\\
 \mathfrak o(fh,gh)&=\bar a_h\bigl(\mathfrak o(f,g)\bigr).
 \end{aligned}                                           \tag{116.6}
\]

Indeed the denominator upstairs is exactly
a_h(a_fV_X + a_gV_Y). If a_h(v) lies in that denominator, the
injectivity of a_h forces v into the original denominator.
The identity of obstruction classes follows by pulling back any
two target-induced source liftings used to define their affine
difference.

### Dual formulation retaining both maps

Serre duality identifies Q_(f,g)^* with

\[
 \mathcal K_{f,g}=
 \ker\bigl(\operatorname{Tr}_f:H^0(Z,\omega_Z^2)\to H^0(X,\omega_X^2)\bigr)
 \cap
 \ker\bigl(\operatorname{Tr}_g:H^0(Z,\omega_Z^2)\to H^0(Y,\omega_Y^2)\bigr).
\]

Dualizing (116.6) gives a surjection

\[
                 \operatorname{Tr}_h:
                 \mathcal K_{fh,gh}\twoheadrightarrow\mathcal K_{f,g}.
                                                               \tag{116.7}
\]

This is a joint-kernel statement for the two actual maps on the
same source, not a claim about independent one-leg kernels.

## 6. Why elementary cross traces behave differently

For every integer m >= 1, define the cross trace

\[
 T_m(f,g)=\operatorname{Tr}_g\circ f^*:
 H^0(X,\omega_X^m)\longrightarrow H^0(Y,\omega_Y^m),
\]

using the canonical differential identifications supplied by etaleness.
If n = deg(h), transitivity of trace and the projection formula give

\[
 \boxed{\quad T_m(fh,gh)=n\,T_m(f,g)\quad(m\ge1).\quad}  \tag{116.8}
\]

Thus if p divides n, ALL these cross traces vanish on the refinement,
regardless of their values on the original diagram. A curve Z of
positive p-rank has a connected etale C_p-cover, by a nonzero class
in H^1_et(Z,F_p). On such a source the simultaneous vanishing of
all cross traces can always be achieved by etale refinement.

This does not contradict (116.7). For every m >= 2 the full trace

\[
          H^0(W,\omega_W^m)\longrightarrow H^0(Z,\omega_Z^m)
\]

is surjective: its Serre-dual pullback is (116.2) with
L = omega_Z^(1-m), of negative degree. But the trace of a section
PULLED BACK from Z is n times that section and can be zero.
Surjectivity must not be confused with invertibility on pulled-back
sections. The m=1 negative-degree argument is unavailable.

## 7. Actual example and exact boundary

File 114 constructs two free cubic actions on the characteristic-five
Hermitian curve H of genus ten. Their quotient maps have genus-four
targets and cannot lift simultaneously over W_2(k), although either
map lifts separately. The obstruction is certified by their generated
non-weakly-ramified unitary group action and
[Garnek's W_2 lifting criterion, arXiv v2 Corollary 5.9](https://arxiv.org/pdf/1904.05074).
The published version has different numbering, cited in file 114.

Theorem 116.1 shows that NO finite etale refinement of that specified
correspondence repairs its simultaneous W_2-lifting obstruction.
In particular, taking a separate Galois closure of either leg does
not repair it.

The two genus-four targets in file 114 are isomorphic. They also
have other correspondences, including the identity after choosing
an isomorphism, which do lift. Thus the persistence theorem is
NOT a claim that the unordered pair of curves has no liftable
common cover.

This result also does not exclude a common cover for the fixed
genus-nine/genus-25 pair. It closes a potential repair step in a
lifting-based strategy and supplies an obstruction formalism that
genuinely survives the Galois-to-non-Galois transition.
