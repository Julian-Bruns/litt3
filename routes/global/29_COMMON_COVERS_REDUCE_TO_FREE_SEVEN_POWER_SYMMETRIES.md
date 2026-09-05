# Common covers reduce to free seven-power symmetries

## Status and purpose

**Status: proved.**  This note gives a weaker target than visibility of every
self-correspondence of

\[
 S=\mathbf P^1_k(31,31,31),\qquad
 S_0=[S/S_3]=\mathbf P^1_k(2,3,62),
 \qquad k=\overline{\mathbf F}_5.
\]

It applies specifically to the proposed pair

\[
 X:\ v^2=x^7-x+1,\qquad
 Y:\ y^{31}=x(x-1),
\]

although only \(g(X)=3\), \(g(Y)=15\), and the finite-etale atlas
\(Y\to S\to S_0\) are used.  If this pair has a common finite etale cover,
then an etale cover of \(Y\) has a fixed-point-free automorphism of
seven-power order which does not preserve its map to \(S_0\).  Thus the full
visibility conjecture can be replaced, for this counterexample, by a much
narrower torsion-symmetry problem.  In particular, the generalized profiles
of degrees \(32,\ldots,46\) are not the profiles arising directly from a
common cover after the reduction below.

All finite etale covers in this note are connected unless stated otherwise.

## 1. A torsion-visibility criterion

Write

\[
                       \rho:Y\longrightarrow S_0
\]

for the composite atlas.  It is finite etale of degree \(31\cdot6=186\).

### Theorem 29.1 (free-action descent criterion)

Suppose the following statement holds.

> For every finite etale map \(a:W\to Y\), every finite group
> \(G\leq\operatorname{Aut}_k(W)\) acting freely on \(W\), and every
> \(g\in G\), the two maps
> \[
>                         \rho a,\quad \rho a g:W\rightrightarrows S_0
> \]
> are 2-isomorphic.

Then \(X\) and \(Y\) do not have a finite etale cover in common.

It is enough to impose the displayed hypothesis only on the finite groups
which occur as deck groups of Galois covers of genus-three curves.

#### Proof

Assume that \(Z\to X\) and \(Z\to Y\) are finite etale.  Take a connected
Galois closure \(W\to X\) of \(Z\to X\).  Since the original cover is
etale, \(W\to X\) and \(W\to Z\) are finite etale.  Hence the composite

\[
                         a:W\longrightarrow Z\longrightarrow Y
\]

is finite etale.  Let \(G=\operatorname{Deck}(W/X)\).  It acts freely on
\(W\), and \(W/G=X\).

Put \(q=\rho a\).  By the hypothesis, for every \(g\in G\) there is a
2-isomorphism \(q\simeq qg\).  These isomorphisms are unique.  Indeed,
\(S_0\) has trivial generic inertia, and two 2-isomorphisms between dominant
maps from a connected reduced curve to such a separated Deligne--Mumford
curve agree at the generic point and hence everywhere.  Uniqueness also
forces the identity and cocycle conditions for the isomorphisms.  They
therefore give an effective descent datum along the finite-etale
\(G\)-torsor \(W\to X\).

Consequently \(q\) descends to a map \(X\to S_0\).  Representability and
etaleness are local for the finite-etale topology on the source, so the
descended map is representable and etale.  It is proper and nonconstant;
hence it is finite etale.  But

\[
 \deg K_{S_0}=\frac{14}{93},\qquad \deg K_X=4,
\]

so its degree would have to be \(4/(14/93)=186/7\), which is not an
integer.  This contradiction proves the theorem. \(\square\)

## 2. The exact profile supplied by a common cover

The preceding proof has a useful consequence before any visibility input is
used.

### Proposition 29.2 (scheme-atlas profile)

In the notation of the proof, put \(N=\deg(W/Y)\).  Then

\[
                 \deg(W/S)=31N,\qquad g(W)=14N+1.
\]

For the coarse function \(x:W\to\mathbf P^1\), each of the fibers over
\(0,1,\infty\) consists of exactly \(N\) points, every one having
ramification index \(31\), and there is no other ramification.  The same is
true of \(xg\) for every \(g\in G\).

#### Proof

The curve \(W\) is a scheme, so it has no residual stack inertia.  The map
\(W\to S\) is finite etale and representable.  At an order-\(31\) point of
\(S\), the induced coarse ramification index is therefore \(31\).  Its
degree is \(31N\), so there are exactly \(N\) such points in each marked
fiber.  There is no coarse ramification elsewhere.  Riemann--Hurwitz gives

\[
 2g(W)-2=-2(31N)+3N(31-1)=28N.
\]

Precomposition by an automorphism merely transports the three ramification
fibers. \(\square\)

Thus a common cover produces the \(m=0\), scheme-source pattern at a degree
divisible by \(31\), not one of the positive-stacky-point profiles.  The
low-degree case \(N=1\) is already visible by the automorphism calculation
in file 20.

## 3. Reduction to a seven-primary failure

The genus ratio makes the torsion criterion still narrower.

### Theorem 29.3 (seven-primary obstruction)

If \(X\) and \(Y\) have a common finite etale cover, then there exist

1. a finite etale map \(a:W\to Y\) of some degree \(N\);
2. a finite \(7\)-group \(P\leq\operatorname{Aut}_k(W)\), acting freely,
   of order
   \[
                         |P|=7^{v_7(N)+1};
   \]
3. an element \(\alpha\in P\), necessarily of order a positive power of
   \(7\),

such that

\[
                         \rho a\not\simeq \rho a\alpha.
                                                               \tag{29.1}
\]

Equivalently, to disprove the existence of a common cover it is enough to
prove invariance of \(\rho a\) under every free seven-group action of the
displayed size.  It is not necessary to prove visibility for arbitrary
self-correspondences of \(S\).

#### Proof

Construct \(W\), \(G\), \(a\), and \(N\) as in Theorem 29.1.  Since

\[
 g(W)-1=\deg(W/X)(g(X)-1)=2\deg(W/X)
\]

and also \(g(W)-1=N(g(Y)-1)=14N\), one has

\[
                         |G|=\deg(W/X)=7N.                 \tag{29.2}
\]

Let \(P\) be a Sylow \(7\)-subgroup of \(G\).  Equation (29.2) gives the
asserted order.

Suppose, contrary to (29.1), that \(q=\rho a\) is 2-isomorphic to \(q\alpha\)
for every \(\alpha\in P\).  As in Theorem 29.1, the 2-isomorphisms are
unique and hence automatically satisfy the cocycle condition.  The map
\(q\) descends along the free quotient \(W\to W/P\) to a representable
finite etale map

\[
                              W/P\longrightarrow S_0.
\]

Write \(N=7^sM\) with \(7\nmid M\).  Since \(|P|=7^{s+1}\), etale
Riemann--Hurwitz gives

\[
                  g(W/P)-1=\frac{g(W)-1}{|P|}
                           =\frac{14\cdot7^sM}{7^{s+1}}
                           =2M.                              \tag{29.3}
\]

Every smooth curve finite etale over \(S_0\) has genus congruent to \(1\)
modulo \(7\), because its canonical degree is an integral multiple of
\(14/93\).  Equation (29.3) violates this: \(7\nmid 2M\).  Thus (29.1)
holds for at least one \(\alpha\in P\).  Every element of \(P\) has
seven-power order. \(\square\)

### Corollary 29.4 (order-seven reduction on an intermediate cover)

If \(X\) and \(Y\) have a common finite etale cover, then there are a smooth
projective curve \(V\), a representable finite etale map

\[
                              q_V:V\longrightarrow S_0,
\]

and a fixed-point-free automorphism \(\beta\in\operatorname{Aut}(V)\) of
order exactly \(7\) such that

\[
                              q_V\not\simeq q_V\beta.       \tag{29.4}
\]

#### Proof

Use the group \(P\) and map \(q:W\to S_0\) from Theorem 29.3.  Choose a
subnormal composition series

\[
             1=P_0\triangleleft P_1\triangleleft\cdots
               \triangleleft P_r=P,
             \qquad P_{i+1}/P_i\simeq C_7.
\]

The map \(q\) is invariant under \(P_0\), but it is not invariant under all
of \(P\).  Let \(i\) be the first index for which it is invariant under
\(P_i\) and not under \(P_{i+1}\).  Uniqueness of 2-isomorphisms gives an
effective descent datum, so \(q\) descends to a finite etale map

\[
                         q_V:V=W/P_i\longrightarrow S_0.
\]

The quotient \(P_{i+1}/P_i\simeq C_7\) acts freely on \(V\).  A generator
\(\beta\) cannot preserve \(q_V\), since otherwise the original map would
be invariant under \(P_{i+1}\).  This proves (29.4). \(\square\)

## 4. Galois covers cannot supply the exceptional symmetry

The order-seven automorphism in Corollary 29.4 can occur only because the
map to \(S_0\) is non-Galois.

### Proposition 29.5 (automorphisms of a Galois cover are vertical)

Let \(Q:V\to S_0\) be a connected finite-etale Galois cover, with \(V\) a
smooth projective curve.  Then

\[
                   \operatorname{Aut}_k(V)=\operatorname{Deck}(V/S_0).
                                                               \tag{29.5}
\]

In particular, every automorphism of \(V\) preserves \(Q\).

#### Proof

First note that \(S_0\) has no nontrivial finite over-orbifold.  Indeed, if
\(S_0\to\mathcal O\) were representable finite etale, then its composite
with the degree-six cover \(S\to S_0\) would be a finite-etale map
\(S\to\mathcal O\).  The classification in file 19 says that every such
map has degree \(1,2,3\), or \(6\).  Its degree here is
\(6\deg(S_0/\mathcal O)\), so \(\deg(S_0/\mathcal O)=1\).

Put \(H=\operatorname{Deck}(V/S_0)\) and
\(A=\operatorname{Aut}_k(V)\).  The latter group is finite because
\(g(V)\geq2\), and its action is faithful, so \([V/A]\) has trivial
generic stabilizer.  For any finite group action the map
\(V\to[V/A]\) is a representable finite-etale torsor, regardless of fixed
points of the action on the coarse curve.  Since \(Q\) is Galois,
\(S_0\simeq[V/H]\).  The inclusion \(H\leq A\) gives a representable
finite-etale map

\[
                         [V/H]\longrightarrow[V/A]
\]

of degree \([A:H]\).  Maximality of \(S_0\) forces this degree to be one.
Thus \(A=H\), proving (29.5). \(\square\)

### Corollary 29.6 (failure to lift to a Galois refinement)

For the triple \((V,q_V,\beta)\) forced by Corollary 29.4, the automorphism
\(\beta\) does not lift to an automorphism of any connected finite-etale
refinement

\[
                    \widetilde V\longrightarrow V
                    \buildrel q_V\over\longrightarrow S_0
\]

whose composite \(\widetilde V\to S_0\) is Galois.

#### Proof

If \(\widetilde\beta\) were such a lift, Proposition 29.5 would give
\((q_Vh)\widetilde\beta\simeq q_Vh\), where
\(h:\widetilde V\to V\).  The lifting identity
\(h\widetilde\beta=\beta h\) would then give
\(q_V\beta h\simeq q_Vh\).  Descent along the surjective finite-etale map
\(h\), with compatibility automatic from uniqueness of 2-isomorphisms to
\(S_0\), yields \(q_V\beta\simeq q_V\), contrary to (29.4). \(\square\)

## 5. The new structural bottleneck

Theorem 29.3 turns a hypothetical common cover into a particularly rigid
object:

\[
 \begin{gathered}
 W\longrightarrow Y\longrightarrow S_0\quad\text{finite etale},\\
 \alpha\in\operatorname{Aut}(W)\quad\text{fixed-point-free of
 seven-power order},\\
 (\rho a)\alpha\not\simeq\rho a.
 \end{gathered}
\]

After passage to an intermediate quotient, Corollary 29.4 reduces this
further to one fixed-point-free automorphism of order exactly \(7\) on a
finite etale cover of \(S_0\).

This statement is robust under changes to the low-degree profile route.  It
uses only Galois closure, descent, and the canonical-degree denominator of
\(S_0\).  What remains is not a classification of all self-correspondences:
it is the exclusion of a nonvertical order-seven automorphism on a
non-Galois finite-etale cover of \(S_0\).  Proposition 29.5 settles every
Galois cover, while Corollary 29.6 identifies the exact remaining failure:
the exceptional automorphism cannot lift through any Galois refinement.
