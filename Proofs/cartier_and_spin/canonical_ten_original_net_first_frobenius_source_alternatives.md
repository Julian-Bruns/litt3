# Proof: the two exact original-net first-Frobenius source alternatives

Version1, 3 October2026. This coherent extraction proves the new cohomology, unmarked dual-span, actual finite-source, permanent kernel and quantitative positivity claims inline. Its three producer arguments have separate fresh independent PASS, and [canonical extraction fidelity](../../Research/notes/oct03_ten_hour/canonical_original_net_first_frobenius_source_alternatives_fidelity_audit.md) is recorded separately. Neither first-Frobenius branch is excluded.

## Exact scope and accepted inputs

Retain the [statement](../../Theorems/cartier_and_spin/canonical_ten_original_net_first_frobenius_source_alternatives.md), including BOTH actual finite étale maps on the SAME original $T$, the actual connected free torsor $q$, the original canonical degree-ten carrier and group restrictions, the actual relative square $q_1=q^{(1)}$, and the original $K\subset J\subset B_Y$ on $Y_1$. In particular $e_J\ne0$ and $q_1^*e_J=0$ are the ORIGINAL net hypotheses.

Ordinarity makes $B_Y$ acyclic, so $H^0(K)=0$ and Riemann--Roch gives $h^1(K)=2$. The actual eight-source theorem supplies $E=F^*K$ of rank three and degree five, its regular canonical Cartier connection, the surjective restriction evaluation $\lambda:E\to\omega_Y$, and $\mu_{\min}(E)\ge5/4$. The last inequality holds because $E$ is a quotient of the actual strongly stable $F^*A_8$ of slope $5/4$; no choice of scalar root is involved.

Only the conditional relation conclusion uses the exact original Gram-four quotient theorem. Only the killed-branch source conclusions use the EXTRA ORIGINAL minimum five-dimensional orbit and its exact finite pushout. The connection-stability and minimal constant-relation ampleness methods are accepted dependencies; the new applications and numerical argument are given below.

## 1. The first Frobenius image has dimension at most one

A nonzero map $E\to\omega_Y$ has image $\omega_Y(-D)$ for an effective divisor $D$. Its image is a line bundle quotient of $E$, hence has integral degree at least $5/4$, and therefore at least two. Since $\deg\omega_Y=2$, $D=0$. Thus every nonzero such map is surjective and every nonzero section of $E^*\omega_Y$ is nowhere zero.

Its global section space injects into every fiber: a fiber dependence of constant coefficients would give a nonzero global section vanishing at that point. It cannot have dimension three, since that would trivialize the rank-three bundle $E^*\omega_Y$, whose degree is $-5+3\cdot2=1$. Serre duality and the given evaluation yield
\[
1\le h^1(E)=\dim\operatorname{Hom}(E,\omega_Y)\le2.
\tag{1}
\]
The coherent map $H^1(K)\xrightarrow{F^*}H^1(E)\xrightarrow{H^1(\lambda)}H^1(\omega_Y)$ is zero: it factors naturally through $F^*H^1(B_Y)=0$, because $\lambda$ is the restriction of the canonical $F^*B_Y\to\omega_Y$. The second map is surjective, by the long exact sequence and the absence of coherent $H^2$ of its kernel on a curve. Its target is one-dimensional. Therefore
\[
\operatorname{im}F^*\subset\ker H^1(\lambda),\qquad\operatorname{rank}F^*\le h^1(E)-1\le1.
\tag{2}
\]
For $h^1(E)=1$ the map is zero. If $F^*e_J\ne0$, then $h^1(E)=2$ and the nonzero image is precisely the one-dimensional kernel in (2). This is a statement about the actual relative map; a semilinear twist identification cannot change its rank.

## 2. Two quotient directions give the universal ordinary extension

Assume $h^1(E)=2$. The two independent maps to $\omega_Y$ are independent in EVERY fiber by the nowhere-zero argument above. Together they give
\[
0\to L_E\to E\to\omega_Y^{\oplus2}\to0,
\qquad L_E=\det E\otimes\omega_Y^{-2},\quad\deg L_E=1.
\tag{3}
\]
The two classes lie in $H^1(L_E\omega_Y^{-1})$, a space of dimension two by degree $-1$ Riemann--Roch. They are independent. Otherwise a quotient direction splits, producing an ordinary direct summand $\omega_Y$ in $E$. Projecting the regular connection onto this summand gives a regular algebraic connection on a degree-two line. A line with a regular connection in characteristic five has degree divisible by five: a rational frame has logarithmic residues equal to its divisor orders modulo five, and their sum is zero. This is impossible for degree two. No summand was assumed horizontal; projection of the connection onto an ordinary summand already gives the contradiction.

The accepted regular-connection degree-one/two/two lemma applies to (3), giving stability of $E$ for any $L_E$ of degree one. This use does not mark $L_E$ or identify its root.

We prove the unmarked dual-span assertion directly. Let $L$ be ANY degree-one line and set $N=\omega_Y^2L$. Every degree-five line is very ample: for each length-two subscheme $Z$, $N(-Z)$ has degree three and vanishing $H^1$, so $h^0(N)-h^0(N(-Z))=2$. In particular $N$ is globally generated and $h^0(N)=4$. Let $M_N$ be its complete evaluation kernel.

If $L$ is ineffective, $T_N=N\omega_Y^{-1}=\omega_YL$ is a base-point-free degree-three pencil. A base point would leave a degree-two pencil, necessarily $\omega_Y$, making $L$ effective. The canonical pencil trick gives
\[
H^0(\omega_Y)\otimes H^0(T_N)\xrightarrow{\sim}H^0(N),
\]
with kernel $H^0(L)=0$. Factor full evaluation through $H^0(T_N)\otimes\omega_Y\to N$. The first kernel is $(\omega_Y^{-1})^{\oplus2}$ and the second is $L^{-1}$. Thus
\[
0\to(\omega_Y^{-1})^{\oplus2}\to M_N\to L^{-1}\to0.
\tag{4}
\]

If $L=\mathcal O_Y(R)$, use the three canonical quadratic products $H^0(\omega_Y^2)\subset H^0(N)$. Their two elementary syzygies give the same kernel $(\omega_Y^{-1})^{\oplus2}$ for evaluation onto $\omega_Y^2\subset N$. The fourth section is nonzero at $R$. Quotienting the evaluation diagram gives $\mathcal O_Y\to N/\omega_Y^2=k_R$, with kernel $\mathcal O_Y(-R)=L^{-1}$. The snake lemma again gives (4). Dualizing proves that $M_N^*$ has an extension (3).

The dual evaluation sequence shows that extra sections beyond $H^0(N)^*$ are the kernel of $H^1(N^{-1})\to H^0(N)^*\otimes H^1(\mathcal O_Y)$. Its dual is multiplication $H^0(N)\otimes H^0(\omega_Y)\to H^0(N\omega_Y)$. The canonical pencil trick gives kernel $H^0(N\omega_Y^{-1})$ of dimension two. Source and target dimensions are eight and six, so multiplication is surjective. Hence the former cohomology map is injective and $h^0(M_N^*)=4$.

This dual span is globally generated. Its two extension classes in (3) are independent: otherwise it has an ordinary summand $\omega_Y$ and a globally generated rank-two complement of degree three. That complement has exactly two sections because the total has four and $h^0(\omega_Y)=2$. Its complete evaluation would trivialize it, contradicting degree three. Finally $\mathrm{GL}_2(k)$ acts transitively on basis pairs of the two-dimensional $H^1(L\omega_Y^{-1})$. All basis-pair extensions (3) are therefore isomorphic as ordinary bundles. Applying this with $L=L_E$ gives
\[
E\simeq M_{\det E}^*,\qquad h^0(E)=4,
\qquad0\to(\det E)^{-1}\to H^0(E)\otimes\mathcal O_Y\to E\to0.
\tag{5}
\]
Nothing in this argument identifies the given connection or embedded Cartier data with the dual span's ordinary description.

## 3. The exact original relation gives only a pulled annihilator marking

Add the precise original Gram-four relation diagram from the stated dependency: the actual saturated $R\subset H$, $\deg R=1$, and its original-unit-induced splitting $E/R\simeq(H/R)\oplus\omega_Y$. Assume $F^*e_J\ne0$, so (5) applies. The quotient is globally generated, hence both its line summands are globally generated. Each has degree two. On a genus-two curve the only globally generated degree-two line is $\omega_Y$; any other such line has one section with nonempty zero divisor. Hence
\[
H/R=\omega_Y,\qquad\det E=R\omega_Y^2,
\qquad R=L_E.
\tag{6}
\]
The last equality also follows because both maps to $\omega_Y$ vanish on $R$, whose rank equals their common kernel. It is proved from global generation and the EXACT original splitting, not from a comparison of degrees.

Saturation gives the ACTUAL annihilator $Q=K^\perp$ and $\det K=\omega_{Y_1}Q$. Relative Frobenius has $F^*\omega_{Y_1}=\omega_Y^5$. Thus (6) yields $F^*Q=R\omega_Y^{-3}$. If $R=\mathcal O(P_0)$ is independently supplied at the original Weierstrass point, this is $\mathcal O(-5P_0)$. For the actual relation $\mathcal O(-P_0)\to R$ with complete zero divisor $Z$, one has $R=\mathcal O(Z-P_0)$ and $\deg Z=2$, giving $F^*Q=\mathcal O(Z-7P_0)$.

These identities determine the PULLED class, not $Q$ on $Y_1$; a nontrivial relative Frobenius-kernel line can remain. Contraposition forces first-Frobenius killing if a corresponding retained gate fails, with no source exclusion.

## 4. The killed branch extends the ACTUAL minimum orbit

Now impose only the stated minimum-orbit source hypothesis, with its genuine extension $0\to U\to Z_{\rm net}\to k\to0$, actual finite bundles $E_U,E_{Z_{\rm net}}$, and specified pushout $v_*e_U=e_J$. Self-duality is unnecessary. Put $D=\ker v$, and use actual pulled $E_1,Z_1,D_1$ as in the statement.

The pulled finite extension $e_1=F^*e_U$ is still nonzero. In the ACTUAL cartesian Frobenius square, $q^*Z_1$ is the constant bundle with the original transported genuine extension of constant modules. Relative Frobenius is a $k$-morphism and preserves the constant descent matrices in this retained trivialization. A splitting downstairs would be a fixed constant lift of the unit upstairs, contradicting nonsplitting of the original genuine extension. Hence $H^0(Y,Z_1)=H^0(Y,E_1)=0$ and $e_1\ne0$. On the actual $T$ it is a split sequence of constant vector bundles, so $q^*e_1=0$. No arbitrary coefficient representation is relabeled by entrywise fifth powers.

Applying $\operatorname{Hom}(-,E)$ to this extension says that the obstruction to extending the specified $v_1:E_1\twoheadrightarrow E$ is $v_{1*}e_1=F^*e_J$. The long exact sequence of
\[
0\to D_1\to E_1\xrightarrow{v_1}E\to0
\tag{7}
\]
identifies the same vanishing with $e_1\in\operatorname{im}H^1(D_1)$. Every extension $r:Z_1\to E$ surjects everywhere because its restriction $v_1$ does. The affine ambiguity is exactly $H^0(E)$. By (1) and Riemann--Roch this has dimension three or four.

At height zero, $H^0(K)=0$ and the accepted genuine-source rigidity gives $\operatorname{Hom}(E_U,K)=kv$. In the Hom sequence its connecting map sends $v$ to nonzero $e_J$. Thus $\operatorname{Hom}(E_{Z_{\rm net}},K)=0$, proving the stated height distinction.

## 5. The kernel class is nonzero on the actual torsor

For an extending surjection $r$ let $P=P_r$. The exact source pushout diagram and snake lemma give
\[
0\to D_1\to P\to\mathcal O_Y\to0,
\qquad\operatorname{rk}P=2,\quad\deg P=-5.
\tag{8}
\]
Its class $\xi_r$ maps to $e_1$ in $H^1(E_1)$, hence is nonzero. Since $q^*D_1$ has negative degree it has no sections. Coherent Hochschild--Serre for the ACTUAL free torsor shows that the kernel of $H^1(Y,D_1)\to H^1(T,q^*D_1)$ comes from $H^1(G,H^0(T,q^*D_1))=0$. Therefore this pullback is injective, and $q^*\xi_r\ne0$ despite $q^*e_1=0$.

The pulled extension (8) consequently has no sections: its negative line has none, and its boundary of one is nonzero. The pulled exact sequence $0\to P\to Z_1\to E\to0$ now gives an ACTUAL embedded constant nonsplit module
\[
Z_1^{\mathrm{const}}\hookrightarrow H^0(T,q^*E).
\tag{9}
\]
Its socle restriction is the original $U_1$ evaluation. This is an embedded original orbit module, not a composition detector or the original projective $V_8$.

Every line subbundle of $P$ has negative degree. Semistability of the actual finite bundle $Z_1$ excludes positive degree. A degree-zero subline becomes trivial on $T$ because it sits inside the trivial bundle and has a nonzero constant-degree coordinate. Its descent character is trivial by the original group hypothesis, giving a section of $Z_1$, which was proved to vanish. In particular $\mu_{\min}(P^*)\ge1$; this is a rank-two minimum-slope bound, not a stability assertion.

## 6. The specified class survives EVERY finite pull

On the actual $T$ the kernel in (8) is the kernel of the actual matrix $\mathcal O_T^5\xrightarrow{q^*r}q^*E$, with no global kernel section. For ANY finite dominant $f:C\to T$, a section of $f^*q^*P$ would be a constant vector in $k^5$ killed by the pulled matrix. Faithful flatness forces that same vector to be killed already on $T$. This contradicts $H^0(T,q^*P)=0$.

For an arbitrary finite surjective $g:C\to Y$, take a connected component $C'$ of the actual fiber product $T\times_Y C$. Its map to $C$ is finite étale and surjective and its map to $T$ is finite dominant. A section of $g^*P$ would pull to one just excluded. Hence
\[
H^0(C,g^*P)=0\quad\text{for EVERY such }g.
\tag{10}
\]
This is only a base change of the existing actual torsor, not a simultaneous Galois closure or replacement of either endpoint leg.

Pulling (8) by $g$, its negative line and middle term both have no sections. The boundary $k\to H^1(C,g^*D_1)$ is injective and sends one to the specified pulled class. Thus $g^*\xi_r\ne0$ for EVERY finite surjective $g$, including inseparable maps and all subsequent Frobenius pulls. This is persistence of this PARTICULAR class, not arbitrary finite injectivity on the whole negative-line $H^1$.

## 7. Ampleness and the exact rank-two Frobenius estimate

The dual $q^*P^*$ is globally generated as a quotient of $\mathcal O_T^5$. Its tautological map $\mathbf P(q^*P^*)\to\mathbf P^4$ is finite. A positive-dimensional fiber would contain a projective integral curve. It cannot lie over one point of $T$, since each projective-line fiber embeds linearly. Its normalization is a finite dominant $f:C\to T$, and the constant image gives a trivial line quotient of $f^*q^*P^*$. Dualizing gives a section of $f^*q^*P$, contradicting (10). Properness gives finiteness. The tautological line is therefore ample, and ampleness descends through the finite actual $q$, proving that $P^*$ is ample. This applies the established minimal constant-relation kernel method at the present source scope.

For the quantitative estimate write $P_e^*=F^{e*}P^*$ on the actual successive relative domains, all of genus two. Its rank is two and degree is $5^{e+1}$. At $e=0$ every quotient line has positive integral degree, at least one, and the whole slope is $5/2$.

Inductively suppose the minimum slope at height $e-1$ is at least $5^{e-1}$. If a quotient line at height $e$ had degree $c<5^e$, its kernel $S$ would have degree $5^{e+1}-c$, and
\[
\deg S-\deg(L\omega)=5^{e+1}-2c-2\ge3\cdot5^e>0.
\]
The LAST canonical Cartier connection on $P_e^*=F^*P_{e-1}^*$ has zero second fundamental map $S\to L\omega$. Its saturated kernel is horizontal. Cartier descent gives a quotient line at height $e-1$ of degree $c/5<5^{e-1}$, a contradiction. In particular descent forces $5\mid c$; no horizontal quotient was assumed initially. The whole rank-two quotient has slope $5^{e+1}/2>5^e$, so
\[
\mu_{\min}(F^{e*}P^*)\ge5^e\quad(e\ge0).
\]
No connection on the original $P$, semistability of its pulls, or horizontal descent of the extending $r$ is used.

## Frozen inputs and review provenance

The NEW arguments consolidated here have these unchanged frozen source/audit pairs:

| Source | Source SHA256 | Independent PASS SHA256 |
|---|---|---|
| [Surviving net and unmarked dual span](../../Research/notes/oct03_ten_hour/original_net_frobenius_universal_dual_span.md), [audit](../../Research/notes/oct03_ten_hour/original_net_frobenius_universal_dual_span_audit.md) | `0f8a08c88b14958ffbf449112f1189282522095970171e759f1c09c5a26a9280` | `54da3b67d9d85de29f64680771df8282b0950c579613d6afc6de3529f01ec20f` |
| [Killed net and original orbit source](../../Research/notes/oct03_ten_hour/original_first_frobenius_killed_orbit_source.md), [audit](../../Research/notes/oct03_ten_hour/original_first_frobenius_killed_orbit_source_audit.md) | `995d8270ca5fb5680e8bcbc18acb4b6202efd6eea29ac30c861b8512cf8774bc` | `4f34f84320007e891b5463527f669965c85ce81e0f916d71aa8caddc84659dad` |
| [Kernel persistence and quantitative positivity](../../Research/notes/oct03_ten_hour/original_first_killed_kernel_uniform_positivity.md), [audit](../../Research/notes/oct03_ten_hour/original_first_killed_kernel_uniform_positivity_audit.md) | `dda5ff2d0ea2aeab2fbc050803c6f0ba25656418940152096c279ffa8201059f` | `a9ddb63fe9952b02e3a013e2a3ca0da9c2d9cc84d35928e20979c465e6947baa` |

Focused accepted dependency reads used:

| Dependency | Proof SHA256 |
|---|---|
| [Original genuine-source extraction](canonical_ten_original_net_genuine_source_extraction.md) | `0b77844ee76c676f626dcbca4598ea25aa1bbf6819afebe02a6d1cb7afdb53fb` |
| [Genuine evaluation/lift rigidity](canonical_ten_genuine_four_source_evaluation_and_lift_rigidity.md) | `3bb3015f4d17dea7602445c04cd0c37a85a03ac89049540240862740dd2e97b2` |
| [Actual eight-source Cartier theorem](canonical_ten_eight_source_cartier_constraints.md) | `a6d6283ee93792abb6c53d803f1b30f16d12225ab9ec227e1da264cdbc8bb893` |
| [Regular connection stability](genus_two_horizontal_rank_three_split_quotient_stability.md) | `15ff1e63196501d964f3c5bb20b1dc2e30f769689ee700182c1d9c3554081e61` |
| [Exact original Gram-four quotient splitting](canonical_ten_gram_four_original_kernel_quotient_splitting.md) | `dc6e8283dd2f5b8039c58ab28085bdecd75556838165e35b61c476d8143fac6e` |

The accepted general ampleness method is also linked in the statement; its exact constant-kernel proof is reproduced in Section7 rather than treating its conclusion as a new general theorem. Canonical extraction fidelity is separate from these original mathematical reviews. No numerical certificates or replays are required.

## Exact unresolved implication

Both actual first-Frobenius branches remain possible. Net survival forces an ordinary dual span and conditional pulled-class gates, while killing in the minimum-orbit branch forces an embedded finite orbit and a permanently nonzero kernel class. Neither provides a positive lift, equates $e_J$ with $\mu_0$ or an annihilator-unit class, transfers ordinary trace, identifies the native $H$, marks the descended $Q$, or descends an endpoint map. The original unmarked same-source common-cover problem is UNSOLVED.
