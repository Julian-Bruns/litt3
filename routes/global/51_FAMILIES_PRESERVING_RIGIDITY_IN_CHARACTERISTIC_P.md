# Families-preserving rigidity for full characteristic-\(p\) curve groups

## Status

**Proved, conditional on the cited theorem of
Minamide--Sawada--Tsujimura.**  **Audit: PASS** --
`/root/families_notes_audit`, 2026-09-04.  No breaking objection; the audit
emphasizes that this standalone extension does not bypass normal-core
alignment in the root-stack problem.
[Audit record](audits/51_FAMILIES_PRESERVING_RIGIDITY_IN_CHARACTERISTIC_P_AUDIT.md).

This note extends their characteristic-zero
almost-surface conclusion to the full geometric etale fundamental group of
a smooth proper curve in positive characteristic. It also explains why this
does not solve the self-correspondence problem: the families-preserving
hypothesis already contains the missing normal-core alignment.

## The theorem

Let \(k\) be an algebraically closed field of characteristic \(p>0\), let
\(C/k\) be a smooth proper connected curve of genus at least two, and put

\[
                         G=\pi_1^{\mathrm{et}}(C).
\]

Let \(H,H'\subseteq G\) be open subgroups and let

\[
                         \alpha:H\buildrel\sim\over\longrightarrow H'
\]

be a continuous isomorphism. Suppose that \(\alpha\) is **families
preserving in \(G\)**: for every procyclic closed subgroup \(I\subseteq H\),
there is \(g_I\in G\) such that

\[
                         \alpha(I)=g_I I g_I^{-1}.
\]

Then \(\alpha\) is the restriction of an inner automorphism of \(G\).

The same proof works for any hyperbolic smooth curve for which the required
prime-to-\(p\) specialization and lifting statement is available. Only the
proper case is used here.

## Proof

Let \(\mathcal C_{p'}\) be the full-formation of finite groups of order
prime to \(p\). Choose an auxiliary prime \(\ell\ne p\), so
\(\mathbf Z/\ell\mathbf Z\in\mathcal C_{p'}\).

Let \(\mathscr N\) be the directed set of normal open subgroups

\[
                       N\triangleleft G,\qquad N\subseteq H\cap H'.
\]

For \(N\in\mathscr N\), define

\[
 R_N=\ker\bigl(N\longrightarrow N^{\mathcal C_{p'}}\bigr),
 \qquad Q_N=G/R_N.                                             \tag{1}
\]

Because \(N\) is normal in \(G\) and \(R_N\) is characteristic in \(N\),
\(R_N\triangleleft G\). Moreover, \(R_N\subseteq H\cap H'\).

We first check that \(Q_N\) is an almost pro-\(\mathcal C_{p'}\) surface
group in the precise sense of Minamide--Sawada--Tsujimura. Lift \(C\) to a
smooth proper curve over a complete mixed-characteristic discrete valuation
ring. Such a lift exists because deformations of a smooth curve are
unobstructed. The connected finite etale Galois cover \(C_N\to C\)
corresponding to \(N\) lifts uniquely with \(C\). Let

\[
 P=\pi_1(C_{\bar\eta}),\qquad N_\eta\triangleleft P
\]

be the characteristic-zero geometric groups of the lifted generic fibers.
Proper smooth specialization gives a surjection \(P\twoheadrightarrow G\),
identifies \(P/N_\eta\) with \(G/N\), and gives an isomorphism

\[
          N_\eta^{\mathcal C_{p'}}\buildrel\sim\over\longrightarrow
          N^{\mathcal C_{p'}}.                                  \tag{2}
\]

It follows from (2) that the inverse image of \(R_N\) in \(P\) is

\[
 R_{N,\eta}=\ker\bigl(N_\eta\longrightarrow
                  N_\eta^{\mathcal C_{p'}}\bigr).
\]

Consequently

\[
 P/R_{N,\eta}\buildrel\sim\over\longrightarrow G/R_N=Q_N.       \tag{3}
\]

The left side of (3) is, by definition, the almost
pro-\(\mathcal C_{p'}\)-maximal quotient of the characteristic-zero
surface group \(P\) associated to \(N_\eta\). Hence \(Q_N\) is an almost
pro-\(\mathcal C_{p'}\) surface group.

By Definition 2.7 and Remark 2.7.1(ii) of
Minamide--Sawada--Tsujimura, a families-preserving isomorphism is normal.
Applied to the ambient-normal subgroup \(R_N\subseteq H\cap H'\), this gives

\[
                             \alpha(R_N)=R_N.                    \tag{4}
\]

Thus \(\alpha\) induces an isomorphism

\[
 \alpha_N:H/R_N\buildrel\sim\over\longrightarrow H'/R_N
\]

between open subgroups of \(Q_N\). Remark 2.7.1(iii) says that
\(\alpha_N\) remains families preserving in \(Q_N\). Each of its two
open subgroups contains a nontrivial normal closed subgroup of \(Q_N\): its
normal core is open, and \(Q_N\) is infinite because it contains the open
infinite group \(N^{\mathcal C_{p'}}\). Therefore Theorem 3.11(iii) of that
paper applies and shows that \(\alpha_N\) is induced by an inner
automorphism of \(Q_N\).

It remains to pass to the inverse limit. If \(N_1,N_2\in\mathscr N\), then
\(N_3=N_1\cap N_2\in\mathscr N\), and maximality of the
pro-\(\mathcal C_{p'}\) quotient gives

\[
                         R_{N_3}\subseteq R_{N_1}\cap R_{N_2}.
\]

Thus the \(R_N\) form a directed family. Also

\[
             \bigcap_{N\in\mathscr N}R_N
             \subseteq\bigcap_{N\in\mathscr N}N=1,
\]

because normal open subgroups contained in the fixed open subgroup
\(H\cap H'\) are cofinal among the normal neighborhoods of the identity.
Hence

\[
                         G\buildrel\sim\over\longrightarrow
                         \varprojlim_{N\in\mathscr N}Q_N.
\]

Every induced \(\alpha_N\) is inner. Lemma 2.5 of
Minamide--Sawada--Tsujimura now implies that \(\alpha\) itself is induced
by one inner automorphism of \(G\). This proves the theorem. \(\square\)

## Application boundary for the triangle root stack

Let

\[
 S=\mathbf P^1_k(31,31,31),\qquad
 i,j:H\hookrightarrow\pi_1(S)=G_S
\]

come from a finite etale self-correspondence, and let \(\sigma\in S_3\).
Set

\[
 A=i(H),\qquad B=\sigma_*^{-1}j(H),\qquad
 \beta=\sigma_*^{-1}ji^{-1}:A\to B.
\]

If \(\beta\) were families preserving in the original ambient group
\(G_S\), then it would be normal. The subgroup

\[
       D=\operatorname{Core}_{G_S}(A)\cap
         \operatorname{Core}_{G_S}(B)
\]

is normal open in \(G_S\) and lies in \(A\cap B\), so normality gives
\(\beta(D)=D\). Its inverse image in the common source has normal image
under both legs. It is therefore admissible by Proposition 21.1, and the
existing simultaneous-envelope argument gives visibility.

Thus proving families preservation in the original group is stronger than
the already isolated core-alignment goal. Passing to a smooth atlas and to
the quotients (1) does not make it automatic: the partial isomorphism
descends to \(Q_N\) exactly when it preserves \(R_N\). That preservation is
one of the normality consequences that is currently missing.

## Source and exact dependency

A. Minamide, K. Sawada, and S. Tsujimura,
[*Families preserving isomorphisms via techniques in anabelian geometry:
with an application to a generalized Neukirch--Uchida theorem*](https://arxiv.org/abs/2608.01417),
submitted 2 August 2026. The proof uses Definition 2.7 and Remark 2.7.1 on
pp. 14--15, Theorem 3.11(iii) on pp. 21--22, and Lemma 2.5 on p. 14.

The lifting/specialization input is the standard proper-smooth
specialization theorem for prime-to-\(p\) fundamental groups, together with
the equivalence of finite etale covers over a proper adic lift and its
special fiber. A convenient modern source for the latter formulation is
S. Schroeer and Y. Takayama,
[*On equivariant formal deformation theory*](https://arxiv.org/abs/1704.01725),
Theorem 4.1.
