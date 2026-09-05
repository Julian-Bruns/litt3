# Families rigidity for the order-$31$ root-stack group

## Status and scope

**Status: proved.**  **Audit: PASS** -- `/root/families_notes_audit`,
2026-09-04.  The result is correct but strategically redundant for
visibility, because families preservation already aligns a common normal
core.  [Audit record](audits/52_VIRTUAL_SURFACE_FAMILIES_RIGIDITY_AUDIT.md).

Let

\[
 S=\mathbf P^1_{\overline{\mathbf F}_5}(31,31,31),
 \qquad G=\pi_1^{\mathrm{et}}(S).
\]

This note removes the ambient-group obstruction to applying the recent
families-rigidity theorem of Minamide--Sawada--Tsujimura.  Although $G$
itself is not one of the almost-surface groups appearing in their Theorem
3.11, it has a cofinal family of quotients that are finite extensions of
pro-$31$ surface groups.  Their group-theoretic argument applies to each
such quotient and then passes to $G$ by compactness.

The conclusion is exact but conditional on the genuinely strong remaining
hypothesis.  If an isomorphism between open subgroups of $G$ preserves,
up to ambient conjugacy, **every** procyclic subgroup, then it is the
restriction of an inner automorphism of $G$.  Thus, after a fixed
$S_3$-normalization, families preservation implies the ambient-extension
statement needed by the visibility route.

This note does **not** prove that an algebraic self-correspondence is
families preserving.  Algebraic realization presently controls the three
order-$31$ peripheral inertia classes, not all abstract procyclic
subgroups.

## 1. Statement

Recall that an isomorphism

\[
                 \alpha:H\xrightarrow{\sim}H'
\tag{50.1}
\]

between closed subgroups of $G$ is *families preserving in $G$* if, for
every closed procyclic subgroup $I\subseteq H$, there exists $g_I\in G$
such that

\[
                    \alpha(I)=g_I I g_I^{-1}.
\tag{50.2}
\]

### Theorem 50.1 (virtual-surface families rigidity)

Let $H,H'\subseteq G$ be open subgroups.  Every families-preserving
continuous isomorphism

\[
                    \alpha:H\xrightarrow{\sim}H'
\]

is induced by an inner automorphism of $G$.  In other words, there is a
single $g\in G$ such that

\[
                    \alpha(h)=ghg^{-1}
             \qquad\text{for every }h\in H.
\tag{50.3}
\]

More generally, let \(\sigma\in\operatorname{Aut}(S)=S_3\).  If

\[
                   \sigma_*^{-1}\alpha
\tag{50.4}
\]

is families preserving in $G$, then

\[
                   \alpha=\sigma_*\circ\operatorname{Ad}(g)|_H
\tag{50.5}
\]

for some $g\in G$.

The second assertion follows immediately from the first.  We prove the
first in Sections 2--5.

## 2. A cofinal family of virtual pro-$31$ surface quotients

Choose a connected representable finite etale atlas $C_0\to S$ with
$C_0$ a smooth projective curve.  Replacing its subgroup by the
intersection of its finitely many $G$-conjugates and its six
$S_3$-translates gives an $S_3$-stable normal open subgroup

\[
                         N_0\triangleleft G
\tag{50.6}
\]

whose corresponding cover is still a smooth projective curve.  Consider
the directed set $\mathcal U$ of normal open subgroups
$U\triangleleft G$ contained in $N_0$.  Put

\[
 K_U=\ker\bigl(U\longrightarrow U^{(31)}\bigr),
 \qquad Q_U=G/K_U,
 \qquad P_U=U/K_U=U^{(31)},
\tag{50.7}
\]

where \(U^{(31)}\) denotes the maximal pro-\(31\) quotient.

The cover corresponding to $U$ is a smooth projective curve $C_U$.
Since $31\ne5$, prime-to-characteristic specialization identifies
$P_U$ with the pro-$31$ surface group of a characteristic-zero curve of
the same genus.  In particular, $P_U$ is an open normal, torsion-free,
center-free pro-$31$ surface group in $Q_U$, and

\[
                         Q_U/P_U=G/U.
\tag{50.8}
\]

The kernels $K_U$ form a directed family.  Indeed, if $U'\subseteq U$,
then every finite $31$-group quotient of $U$ restricts to one of $U'$,
so $K_{U'}\subseteq K_U$.  Moreover,

\[
                 \bigcap_{U\in\mathcal U}K_U=1,
\tag{50.9}
\]

because $K_U\subseteq U$ and the normal open subgroups $U\subseteq N_0$
are cofinal at the identity.  Compactness therefore gives

\[
                       G\xrightarrow{\sim}
                       \varprojlim_{U\in\mathcal U}Q_U.
\tag{50.10}
\]

## 3. The finite extension introduces no finite normal subgroup

We first record a standard faithfulness fact in a form useful here.

### Lemma 50.2 (faithful prime-to-$5$ deck action)

Let $C$ be a smooth projective curve of genus at least two over an
algebraically closed field of characteristic $5$.  Then

\[
 \operatorname{Aut}(C)\longrightarrow
 \operatorname{Out}\bigl(\pi_1^{(31)}(C)\bigr)
\tag{50.11}
\]

is injective.

#### Proof

An automorphism acting trivially in the outer automorphism group acts
trivially on the abelianization, hence on
$H^1_{\mathrm{et}}(C,\mathbf Q_{31})$.  Suppose that a nonidentity
automorphism $\delta$ did so.  Its graph and the diagonal are distinct
effective curves on $C\times C$, and therefore have nonnegative
intersection.  The Lefschetz trace formula computes that intersection as

\[
 \Delta_C\cdot\Gamma_\delta
   =1-\operatorname{Tr}\bigl(\delta^*\mid H^1_{\mathrm{et}}
          (C,\mathbf Q_{31})\bigr)+1
   =2-2g(C)<0,
\tag{50.12}
\]

a contradiction.  Hence $\delta=1$.  $\square$

### Lemma 50.3

Every open subgroup of $Q_U$ has no nontrivial finite normal subgroup.
Consequently $Q_U$ is strongly subnormally internally indecomposable.

#### Proof

First, the outer action

\[
                    G/U\longrightarrow\operatorname{Out}(P_U)
\tag{50.13}
\]

is faithful.  It is the action of the faithful deck group \(G/U\) on
$C_U$, and Lemma 50.2 detects every nonidentity deck transformation.
It follows that

\[
                         Z_{Q_U}(P_U)=1:
\tag{50.14}
\]

an element centralizing \(P_U\) has trivial image in \(G/U\) by
faithfulness, and then lies in the trivial center of $P_U$.

Let \(R\subseteq Q_U\) be open and let \(A\triangleleft R\) be finite.  Set
$P_0=R\cap P_U$.  Since a pro-$31$ surface group is torsion-free,
$A\cap P_0=1$.  Normality of both groups in $R$ then gives
$[A,P_0]=1$.

For \(a\in A\), conjugation by \(a\) on \(P_U\) fixes the open subgroup
$P_0$ pointwise.  It therefore fixes the normal open subgroup
\(\operatorname{Core}_{P_U}(P_0)\) pointwise.  A pro-\(31\) surface group is
internally indecomposable, so Minamide--Sawada--Tsujimura, Proposition 1.6,
implies that conjugation by \(a\) is the identity on all of \(P_U\).
Equation (50.14) gives $a=1$.  Thus $A=1$.

The pro-$31$ surface group $P_U$ is strongly subnormally internally
indecomposable by Minamide--Sawada--Tsujimura, Theorem 3.11(ii).  Their
Proposition 1.9(i), applied for every subnormal depth, now promotes this
property across the finite extension $P_U\subseteq Q_U$, because we
have just verified its no-finite-normal-subgroup hypothesis for every open
subgroup of $Q_U$.  $\square$

## 4. Rigidity in each virtual-surface quotient

### Proposition 50.4

Let $\overline H,\overline H'\subseteq Q_U$ be open.  Every
families-preserving isomorphism

\[
                  \overline\alpha:\overline H
                        \xrightarrow{\sim}\overline H'
\tag{50.15}
\]

in $Q_U$ is induced by an inner automorphism of $Q_U$.

#### Proof

By Minamide--Sawada--Tsujimura, Theorem 3.11(i), the closed commutator
subgroup

\[
                         D_U=[P_U,P_U]
\tag{50.16}
\]

is a nontrivial free pro-$31$ group of infinite rank.  It is
characteristic in $P_U$, hence normal in $Q_U$.

Let \(A,A'\triangleleft Q_U\) be the cores of
\(\overline H,\overline H'\).
They are nontrivial normal open subgroups.  Since $Q_U$ is internally
indecomposable, Minamide--Sawada--Tsujimura, Proposition 1.7(ii), gives

\[
                    F_U=D_U\cap A\cap A'\ne1.
\tag{50.17}
\]

This is a closed subgroup of a free pro-$31$ group, hence is itself free
pro-$31$; it is normal in $Q_U$ and contained in
$\overline H\cap\overline H'$.

A families-preserving isomorphism is normal in its ambient group by
Minamide--Sawada--Tsujimura, Remark 2.7.1(ii).  Consequently
$\overline\alpha(L)=L$ for every closed subgroup
$L\subseteq F_U$ normal in $Q_U$.  The procyclic-conjugacy hypothesis
in their Theorem 2.4 is a direct restriction of families preservation.
Apply that theorem with

\[
 n=1,\qquad \widetilde F=Q_U,\qquad F=F_U.
\tag{50.18}
\]

Lemma 50.3 supplies internal indecomposability, and all the other
hypotheses were just checked.  Theorem 2.4 says precisely that
$\overline\alpha$ is induced by one inner automorphism of $Q_U$.
$\square$

## 5. Descent and compactness

Let $\alpha:H\to H'$ be as in Theorem 50.1.  For every $U$, families
preservation implies

\[
                    \alpha(H\cap K_U)=H'\cap K_U.
\tag{50.19}
\]

Indeed, if \(h\in H\cap K_U\), then the procyclic group
\(\overline{\langle h\rangle}\) lies in the normal subgroup \(K_U\); its
\(G\)-conjugate \(\alpha(\overline{\langle h\rangle})\) lies there as
well. Apply the same argument to \(\alpha^{-1}\) for equality.

Thus $\alpha$ induces an isomorphism $\alpha_U$ between the images of
$H,H'$ in $Q_U$.  It remains families preserving after quotienting by
the normal subgroup $K_U$, by Minamide--Sawada--Tsujimura, Remark
2.7.1(iii).  Proposition 50.4 makes every $\alpha_U$ inner.  Equations
(50.9)--(50.10) and Minamide--Sawada--Tsujimura, Lemma 2.5, now give one
$g\in G$ inducing $\alpha$ itself.  This proves Theorem 50.1.

## 6. What remains for the correspondence problem

Suppose an algebraic self-correspondence supplies an open-subgroup
isomorphism

\[
                    \alpha:i(H)\xrightarrow{\sim}j(H)
\tag{50.20}
\]

inside $G$.  Theorem 50.1 proves the following exact implication:

\[
 \boxed{
 \begin{gathered}
 \text{for some }\sigma\in S_3,\quad
 \sigma_*^{-1}\alpha\text{ preserves the ambient conjugacy class}\\
 \text{of every procyclic subgroup of }i(H)
 \end{gathered}}
 \quad\Longrightarrow\quad
 \boxed{\alpha=\sigma_*\circ\operatorname{Ad}(g)|_{i(H)}}.
\tag{50.21}
\]

Thus a common almost-surface quotient is no longer missing.  The sole
input in (50.21) that has not been obtained from algebraic realization is
families preservation.

It would be much stronger than peripheral compatibility: it quantifies
over all procyclic subgroups of an open surface-type group.  The proof of
Proposition 50.4 shows a potentially narrower target.  In each quotient
$Q_U$, it is enough to establish the two hypotheses of
Minamide--Sawada--Tsujimura, Theorem 2.4, on the particular free normal
group $F_U\subseteq[P_U,P_U]$: preservation of its $Q_U$-normal closed
subgroups and conjugacy of the specified non-Frattini procyclic subgroups.
This is the application-specific weakening worth testing.  Dropping
procyclic control from the abstract theorem would instead require a new
general theorem about free pro-\(p\) groups; Minamide--Sawada--Tsujimura,
Remark 2.4.1(iii), explicitly records a closely adjacent weakening as
open.

## References

1. A. Minamide, K. Sawada, and S. Tsujimura,
   *Families preserving isomorphisms via techniques in anabelian geometry:
   with an application to a generalized Neukirch--Uchida theorem*,
   [arXiv:2608.01417](https://arxiv.org/abs/2608.01417), especially
   Proposition 1.6, Proposition 1.7, Proposition 1.9, Theorem 2.4,
   Lemma 2.5, Remark 2.7.1, and Theorem 3.11.
2. A. Grothendieck et al., *Revêtements étales et groupe fondamental
   (SGA 1)*, Expose X, Corollary 3.9 (prime-to-characteristic
   specialization for proper smooth curves).
