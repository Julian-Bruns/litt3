# Frobenius equivariance does not force families preservation

## Status and scope

**Status: proved-text; independent audit requested.**

This note isolates the exact gap between finite-field descent and the
families-preserving hypothesis of Minamide--Sawada--Tsujimura. It proves
that the gap cannot be crossed by a formal density or continuity argument
using only algebraic realization and Frobenius equivariance.

More precisely, there is an algebraically realized finite-etale
self-correspondence of a smooth proper curve over a finite field whose
open-subgroup automorphism has the full arithmetic enhancement, and is
therefore Frobenius-equivariant in the canonical sense, but fails families
preservation on a concrete geometric procyclic subgroup. The example is
not a counterexample to the order-\(31\) triangle-stack problem: its target
is a different curve. It is a no-go theorem for the proposed shortcut.
Any successful argument for the triangle stack must use its special
geometry or its three inertia partitions, rather than finite-field descent
alone.

## 1. The closedness observation and the missing density

Let \(G\) be a profinite group, let \(H,H'\subseteq G\) be closed, and let

\[
                     \alpha:H\buildrel\sim\over\longrightarrow H'
\tag{64.1}
\]

be continuous. Give the set of closed subgroups of a profinite group its
usual profinite Chabauty topology: it is the inverse limit of the finite
sets of subgroups in finite quotients.

### Lemma 64.1 (families preservation is a closed condition)

The set

\[
 \mathcal F_\alpha=
 \{I\subseteq H:\ I\text{ is closed procyclic and }
                  \alpha(I)\text{ is }G\text{-conjugate to }I\}
\tag{64.2}
\]

is closed in the space of closed procyclic subgroups of \(H\).
Consequently, it would be enough to prove the required conjugacy on a
dense collection of geometric procyclic subgroups.

#### Proof

The map on closed-subgroup spaces induced by \(\alpha\) is continuous.
Conjugation is also continuous. If a net \(I_s\to I\) satisfies

\[
                    \alpha(I_s)=g_s I_s g_s^{-1},
\]

compactness of \(G\) supplies a convergent subnet \(g_s\to g\). Passing to
the limit gives

\[
                         \alpha(I)=gIg^{-1}.
\]

This proves closedness. (Equivalently, one may work quotient by quotient
and use compactness of the inverse system.) \(\square\)

The useful half of this lemma is precisely the half for which the
correspondence supplies no input. For a finite-etale correspondence

\[
                     \mathcal T\rightrightarrows S,
\]

the automatically controlled geometric cyclic groups are the stabilizer
groups at the finitely many stacky points of \(\mathcal T\). Their
conjugacy orbits form a finite union of compact, hence closed, subsets of
the subgroup space. This union is not dense: every such group is finite
of order dividing \(31\), whereas an open subgroup of the hyperbolic
triangle-stack group contains infinite procyclic subgroups after passage
to a torsion-free smooth atlas.

Closed-point decomposition groups do not repair this failure. If
\(T/\mathbf F_q\) is a smooth proper curve, the decomposition group of a
closed point \(t\) is

\[
                         D_t\simeq\widehat{\mathbf Z},
\]

and its map to
\(\operatorname {Gal}(\overline{\mathbf F}_q/\mathbf F_q)\simeq
\widehat{\mathbf Z}\) is injective (its image is
\(\deg(t)\widehat{\mathbf Z}\)). Hence

\[
          D_t\cap\pi_1(T_{\overline{\mathbf F}_q})=1.       \tag{64.3}
\]

Thus Chebotarev density concerns arithmetic cyclic groups, not the
nontrivial geometric procyclic groups quantified over in the
Minamide--Sawada--Tsujimura hypothesis. Moreover, algebraicity sends the
decomposition group at \(t\) to the decomposition groups at the two
generally different image points. Frobenius equivariance says that these
two actions are intertwined; it does not say that the two ambient
decomposition groups are conjugate.

## 2. An algebraic Frobenius-equivariant counterexample to the shortcut

### Theorem 64.2

There are a finite field \(k_0\) of characteristic \(5\), smooth projective
geometrically connected curves \(C,X\) over \(k_0\), and degree-two finite
etale maps

\[
                            u,v:C\rightrightarrows X          \tag{64.4}
\]

with the following properties.

1. \(g(C)=7\) and \(g(X)=4\).

2. The associated isomorphism between arithmetic open subgroups is an
   automorphism over
   \(\Gamma_{k_0}=\operatorname {Gal}(\overline{k}_0/k_0)\). In
   particular it has the exact arithmetic enhancement of Theorem 25.1,
   and its geometric outer class commutes with Frobenius.

3. On geometric fundamental groups, put

   \[
     G=\pi_1(X_{\overline{k}_0}),\qquad
     R=u_*\pi_1(C_{\overline{k}_0})
       =v_*\pi_1(C_{\overline{k}_0}).
   \]

   There is a closed procyclic subgroup \(I\subseteq R\) such that

   \[
                   \alpha(I)\ne gIg^{-1}
                   \qquad\hbox{for every }g\in G,             \tag{64.5}
   \]

   where \(\alpha=v_*u_*^{-1}:R\to R\). Thus \(\alpha\) is not
   families preserving in \(G\).

#### Proof

Choose a smooth projective genus-two curve \(B\) over
\(\overline{\mathbf F}_5\). Its prime-to-\(5\) geometric fundamental group
surjects onto \(S_3\): in the usual genus-two surface presentation, send
two \(a\)-generators to a transposition and a three-cycle and send the
\(b\)-generators to \(1\). Let

\[
                            C\longrightarrow B
\tag{64.6}
\]

be the resulting connected etale \(S_3\)-Galois cover. Write

\[
                a=(12),\qquad A=\langle a\rangle,
                \qquad\gamma=(123),
\]

and set

\[
           X=C/A,\qquad u:C\longrightarrow X,
           \qquad v=u\circ\gamma.                              \tag{64.7}
\]

All this finite-presentation data, including the full \(S_3\)-action,
descends after enlarging a finite subfield \(k_0\subset
\overline{\mathbf F}_5\). The two maps in (64.7) are then degree-two
finite etale maps over \(k_0\). Riemann--Hurwitz gives

\[
     g(C)-1=6(g(B)-1)=6,
     \qquad g(C)-1=2(g(X)-1),
\]

so \(g(C)=7\) and \(g(X)=4\).

Let \(\Pi_C,\Pi_X\) denote the arithmetic fundamental groups. Since
\(\gamma\) is defined over \(k_0\), \(\gamma_*:\Pi_C\to\Pi_C\) induces the
identity on \(\Gamma_{k_0}\). Also

\[
                v_*=u_*\gamma_*,\qquad
                v_*(\Pi_C)=u_*(\Pi_C)=:U.
\]

It follows that

\[
              \widetilde\alpha
                =u_*\gamma_*u_*^{-1}:U\buildrel\sim\over\longrightarrow U
\tag{64.8}
\]

is an automorphism over \(\Gamma_{k_0}\). This is the full arithmetic
Frobenius equivariance furnished by an algebraic correspondence, not just
an accidental equality on a finite quotient. Equivalently, its geometric
outer class is fixed by the \(k_0\)-Frobenius action. As usual, equality
with conjugation by one chosen Frobenius lift is subject to the independent
inner path ambiguities of Theorem 25.1.

It remains to exhibit the failure of families preservation. Identify
geometric groups using (64.6). If

\[
       P=\pi_1(B_{\overline{k}_0}),\qquad
       R=\pi_1(C_{\overline{k}_0}),
\]

then \(R\triangleleft P\), \(P/R\simeq S_3\), and

\[
                         G/R\simeq A.                         \tag{64.9}
\]

Put

\[
                V=H_1^{\mathrm{et}}(C,\mathbf Z_{31})
                  \simeq R^{\mathrm{ab},(31)}.
\tag{64.10}
\]

The deck group \(S_3\) acts on \(V\); denote this action by \(\rho\).
The action of \(\operatorname {Aut}(C)\) on
\(H^1_{\mathrm{et}}(C,\mathbf Q_{31})\) is faithful. Indeed, if a
nonidentity automorphism acted trivially, the Lefschetz intersection of
its graph with the diagonal would be
\(2-2g(C)<0\), impossible for two distinct effective curves on
\(C\times C\).

Every element of \(S_3\) fixes pointwise the nonzero subspace
\(H^1_{\mathrm{et}}(B,\mathbf Q_{31})\) pulled back to
\(H^1_{\mathrm{et}}(C,\mathbf Q_{31})\); pullback is injective because its
composite with trace is multiplication by \(6\). It follows, by duality,
that no nonidentity element of \(S_3\) acts as a scalar on \(V_{\mathbf Q}\):
a scalar action on \(V_{\mathbf Q}\) would give a scalar dual action fixing
that subspace, so the scalar would be \(1\), and faithfulness would then
make the deck transformation the identity.

In particular, both

\[
                         \rho(\gamma),\qquad
                         \rho(a^{-1}\gamma)                   \tag{64.11}
\]

are nonscalar. Since their orders divide \(6\) and
\(\mu_6\subset\mathbf Q_{31}\), their projective eigenvectors form a
finite union of proper linear subspaces of
\(V_{\mathbf Q}=V\otimes\mathbf Q_{31}\). The field \(\mathbf Q_{31}\) is
infinite, so choose a primitive vector \(w\in V\) outside this union.
Surjectivity of \(R\to V\) supplies \(h\in R\) mapping to \(w\). Let

\[
                         I=\overline{\langle h\rangle}.       \tag{64.12}
\]

This is a closed procyclic subgroup.

Suppose that \(\alpha(I)=gIg^{-1}\) for some \(g\in G\). Let
\(\bar g\in A=\{1,a\}\) be the image of \(g\) in (64.9). Passing to the
\(31\)-adic abelianization (64.10), inner conjugation by \(R\) disappears,
and equality of the two procyclic images gives

\[
            \mathbf Z_{31}\rho(\gamma)w
               =\mathbf Z_{31}\rho(\bar g)w.                 \tag{64.13}
\]

Both vectors are primitive, so (64.13) says that
\(\rho(\bar g^{-1}\gamma)w\) is proportional to \(w\). For
\(\bar g=1\) or \(a\), this contradicts the choice of \(w\) following
(64.11). Hence (64.5) holds. \(\square\)

### Corollary 64.3 (normalization does not repair the example)

For every algebraic automorphism \(\sigma\in\operatorname {Aut}
(X_{\overline{k}_0})\), the normalized virtual isomorphism
\(\sigma_*^{-1}\alpha\) is not families preserving in \(G\).

#### Proof

The argument of file 52, in the simpler torsion-free case of the smooth
proper curve \(X\), applies Minamide--Sawada--Tsujimura on a cofinal system
of virtual pro-\(31\) surface quotients. It says that a families-preserving
isomorphism between open subgroups of \(G\) is the restriction of an inner
automorphism of \(G\).

If \(\sigma_*^{-1}\alpha\) were families preserving, it would therefore be
inner on \(R\). Absorb that inner automorphism into the base-path choice
for \(\sigma_*\). We then have
\(\alpha=\sigma_*|_R\), and in particular \(\sigma_*(R)=R\). The Galois
category now says that \(\sigma\) lifts to an automorphism
\(\widetilde\sigma\) of \(C\) satisfying

\[
                    u\widetilde\sigma=\sigma u.
\]

Moreover, the equality
\(u_*\widetilde\sigma_*=\sigma_*u_*=u_*\gamma_*\), understood up to
base-point inner automorphisms, says that
\(\widetilde\sigma\) and \(\gamma\) have the same outer action on
\(\pi_1(C_{\overline{k}_0})\). The faithfulness argument used above gives
\(\widetilde\sigma=\gamma\). Consequently

\[
                            u\gamma=\sigma u.                 \tag{64.14}
\]

But the left side has deck group \(\gamma^{-1}A\gamma\), while the right
side has deck group \(A\). Equality would give
\(\gamma^{-1}A\gamma=A\), contrary to
\(\gamma\notin N_{S_3}(A)=A\). \(\square\)

## 3. Consequence for the triangle-stack strategy

Theorem 64.2 rules out the implication

\[
 \boxed{\text{algebraic realization plus arithmetic Frobenius equivariance}}
 \quad\Longrightarrow\quad
 \boxed{\text{families preservation}}
\tag{64.15}
\]

as a formal theorem about finite-etale correspondences. Lemma 64.1 does
not rescue it: the geometric cyclic groups controlled by ramification are
not dense, and the dense Frobenius data live in the arithmetic group and
do not start with the necessary conjugacy assertion.

This does not exclude a theorem special to

\[
                   \mathbf P^1(31,31,31).
\]

But in that special case files 50 and 52 show that full normalized families
preservation is strategically too strong. Its first mod-\(31\) abelian
shadow already forces alignment of the three residual partitions and the
two Kummer classes; in the main low-degree range those conclusions imply
visibility directly. The efficient application-specific target is
therefore to prove those finite partition and torsion statements, not to
strengthen Minamide--Sawada--Tsujimura or to infer all geometric procyclic
conjugacies from Frobenius.

## References

1. A. Minamide, K. Sawada, and S. Tsujimura,
   *Families preserving isomorphisms via techniques in anabelian geometry:
   with an application to a generalized Neukirch--Uchida theorem*,
   [arXiv:2608.01417](https://arxiv.org/abs/2608.01417), especially
   Theorems 2.3--2.4, Definition 2.7, Remark 2.4.1(iii), and Theorem 3.11.
2. File 25, Theorem 25.1 and Proposition 25.3, for the precise arithmetic
   Frobenius relation and the underlying non-extension example.
3. Files 50 and 52 for the mod-\(31\) shadow and the virtual-surface
   application of families rigidity to the triangle-stack group.
