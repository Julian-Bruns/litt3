# Genuine four-source evaluation and original lift rigidity

Version1, 3 October2026. This consolidates three independently audited original-source arguments. Their frozen source and audit hashes are recorded in the [proof provenance](../../Proofs/cartier_and_spin/canonical_ten_genuine_four_source_evaluation_and_lift_rigidity.md#frozen-inputs-and-review-provenance). [Fresh canonical fidelity audit PASS](../../Research/notes/oct03_ten_hour/canonical_genuine_and_self_dual_four_fidelity_audit.md); mathematical input snapshots are preserved.

Work over $k=\overline{\mathbf F}_5$. Preserve BOTH actual finite étale maps $h:T\to X$ and $q:T\to Y$ from the SAME connected smooth projective source, where $Y$ is ordinary of genus two and $q$ is a connected free $G$-torsor. Retain the actual faithful canonical degree-ten carrier $\varphi:T\to\Gamma$ with $\Gamma/G=\mathbf P^1$, original weak cyclic-five inertia of break one and tame cyclic-two inertia. Retain the accepted opposite-class generating tuple $a,b,c$, with $abc=1$, orders $5,5,2$ and $b$ conjugate to $a^{-1}$, the absence of nontrivial prime-to-five quotients, and the absence of an $A_5$ quotient. In the original application $g(X)=9$, $\deg h=d$, $|G|=\deg q=8d$.

Put $Y_1=Y^{(1)}$, $T_1=T^{(1)}$, $q_1=q^{(1)}$, and $B=B_Y=F_{Y*}\mathcal O_Y/\mathcal O_{Y_1}$. Require the ORIGINAL embedded stable $K\subset B$ of rank three and degree one. For a genuine $G$-module $M$, write $E_M=(M\otimes\mathcal O_{T_1})/G$ for its actual untwisted degree-zero descent. The accepted [genuine-source extraction](canonical_ten_original_net_genuine_source_extraction.md) excludes nontrivial genuine simple modules of dimension at most three. Let $U$ be a genuine simple module of dimension four actually evaluating nontrivially onto $K$, and put $E=E_U$ and $v:E\twoheadrightarrow K$.

Then the following hold without self-duality or a minimum orbit hypothesis.

1. For every actual finite $G$-bundle $E_M$ of rank $m$, every nonzero map $E_M\to K$ is an integral surjection. For $m\ge4$,
\[
\dim\operatorname{Hom}(E_M,K)\le m-3;
\]
for $m\le3$ this Hom space is zero. In particular $\operatorname{Hom}(E,K)=kv$. The isomorphism class $U$ has multiplicity at most one in the socle of $H^0(T_1,q_1^*K)$. Any retained actual positive semistable source $A_n$ of rank $n$ and slope $1/4$ likewise satisfies $\dim\operatorname{Hom}(A_n,K)\le n-3$; every nonzero map is an integral surjection.

2. The original tame involution acts on $U$ with multiplicities $2+2$, and BOTH original cyclic-five generators act by $J_4$. There is no nondegenerate invariant symmetric form. Moreover
\[
\dim_k H^1(G,U)\le1,
\]
and restriction to either original cyclic-five subgroup is injective. Every nonzero class gives a five-dimensional nonsplit extension $0\to U\to Z\to k\to0$ with tame multiplicities $3+2$ and BOTH wild blocks $J_5$.

3. If the original orbit construction of the genuine-source extraction has $Z_0=U$ and $\dim Z=5$, its actual pushout $e_J=v_*[Z]\ne0$ has at most one projective direction for this fixed $U$ and embedded $K$. This requires the original exact pushout and actual $q_1$-killed net; it is not asserted for an arbitrary four-dimensional socle of a larger orbit module.

For the following additional original lift assertion, retain the actual irreducible eight-source sequence
\[
0\longrightarrow C_5\longrightarrow A_8\xrightarrow{a_K}K\longrightarrow0,
\]
where $A_8$ is stable of rank eight and degree two and $C_5$ is stable of rank five and degree one. These stability hypotheses are those of the [actual eight-source Cartier theorem](canonical_ten_eight_source_cartier_constraints.md), with its ORIGINAL scalar descent and relative twists; they are not supplied by slope arithmetic or by a chosen fifth root. Put
\[
c_U=\dim\operatorname{Hom}(E,C_5),\qquad
\mu_0=v^*[A_8]\in\operatorname{Ext}^1(E,C_5).
\]
Then every nonzero map $E\to C_5$ or $E\to A_8$ is a global rank-four degree-zero subbundle injection, $c_U\in\{0,1\}$, and
\[
\dim\operatorname{Hom}(E,A_8)=
\begin{cases}c_U,&\mu_0\ne0,\\c_U+1,&\mu_0=0.\end{cases}
\]
When $\mu_0\ne0$ every map lands in $C_5$. When $\mu_0=0$ the lifts of the specified original $v$ form a nonempty affine space of dimension $c_U\le1$. A nonzero kernel map has line quotient $\det C_5\,(\det E)^{-1}=\det C_5$ of degree one; this equality does not mark that line by a point.

The classes $\mu_0$, the actual $q_1$-killed net class $e_J$, and an annihilator's lifting class into $F_{Y*}\mathcal O_Y$ are distinct. No annihilator lift, horizontal descent of a Frobenius lift, ordinary-trace preservation, or native marking is inferred. The injection assertion uses strict stability of $A_8$ and is not asserted from strong semistability alone. Both original endpoint maps remain on $T$; no quotient acquires an $X$-map here. These are source restrictions, not a source exclusion or an unmarked common-cover solution.

Accepted dependencies are the [genuine-source extraction](canonical_ten_original_net_genuine_source_extraction.md), its original group inputs, and, only for the positive-source assertions, [all-dimensional source semistability](actual_finite_source_strong_semistability_and_cartier_surjectivity.md) and the [eight-source theorem](canonical_ten_eight_source_cartier_constraints.md). The dimension, cohomology and height-zero lift arguments are proved inline in the [proof](../../Proofs/cartier_and_spin/canonical_ten_genuine_four_source_evaluation_and_lift_rigidity.md).
