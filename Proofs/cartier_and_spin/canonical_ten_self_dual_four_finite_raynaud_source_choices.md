# Proof: finite actual self-dual four-source choices and singular Raynaud pencils

Version1, 3 October2026. [Statement](../../Theorems/cartier_and_spin/canonical_ten_self_dual_four_finite_raynaud_source_choices.md). Preserve both actual finite étale maps on the same original $T$. All quotient torsors below are actual quotients of $q_1$ when an original source is specified; no original $X$-map is assigned to them.

## Accepted inputs and the exact finite coefficient image

Use [genuine evaluation rigidity](../../Theorems/cartier_and_spin/canonical_ten_genuine_four_source_evaluation_and_lift_rigidity.md) for the $J_4,J_4,2+2$ tuple, absence of a symmetric form, $\dim H^1(G,U)\le1$, and the unique evaluation onto fixed $K$. Use [genuine-source extraction](../../Theorems/cartier_and_spin/canonical_ten_original_net_genuine_source_extraction.md) for the genuine small-simple exclusion, no characters, actual orbit pushout and original carrier hypotheses. Use [reflection rigidity](../../Theorems/quotient_geometry/local_actions/weak_cyclic_reflection_module_constraints.md) only on the five-dimensional exterior-square module specified below. The [Raynaud conventions](../../Definitions/theta_cartier.md) give stable rank-four degree-four $B$ on $Y_1$; its canonical alternating form gives $\det B=\omega_{Y_1}^2$. Ordinarity gives $H^0(B)=H^1(B)=0$.

The EXTRA self-duality of $U$ gives an alternating nondegenerate form by Schur's lemma and absence of a symmetric form. It is invariant, rather than merely a form line with nontrivial multiplier, because every genuine character is trivial. Split contraction in odd characteristic gives
\[
\bigwedge^2U=k\Omega\oplus W,\qquad\dim W=5.
\]
The exterior-product pairing is nondegenerate and symmetric on $W$, and $W^G=(W^*)^G=0$: invariant bivectors are just $k\Omega$ by Schur's lemma. A simple submodule of $W$ has dimension at least four. A four-dimensional one would have trivial one-dimensional quotient, whose dual would give an invariant vector in $W$, impossible. Thus $W$ is simple.

Its tame pattern is $1+4$. Moreover $\bigwedge^2J_4=J_5\oplus J_1$ in characteristic five. Indeed realize $J_4$ as the cubic symmetric power of the two-dimensional regular unipotent; its exterior square splits as the fourth symmetric power plus its invariant line, using only invertible factors two and three. The fourth nilpotent power on the fourth symmetric power has nonzero leading coefficient $4!$, so its block is $J_5$. Reflection rigidity therefore applies to the exact original tuple on $W$.

An explicit matching tuple is
\[
A_0=P,\quad C_0=\operatorname{diag}(1,-1,-1,-1,-1),\quad B_0=P^{-1}C_0,
\]
where $P$ cycles five coordinates. The two signed five-cycles have product of signs one and are diagonally conjugate to $P$, hence are regular $J_5$ of order five. The five conjugates of $C_0$ generate the even-sign group $V\simeq C_2^4$. Their distinct coordinate characters are cycled transitively, proving simplicity of this tuple. Its exact conjugacy classes match the original tuple. Linear rigidity consequently identifies the image on $W$ with
\[
H=V\rtimes C_5,\qquad |H|=80.
\]

The kernel of $\operatorname{Sp}(U)\to GL(W)$ is $\{\pm I\}$: triviality on $W$ and $\Omega$ is triviality on $\bigwedge^2U$, which forces a scalar fixing every two-plane and with square one. If the actual image $R$ mapped injectively to $H$, its normal abelian $V$ would have at most four distinct restriction characters in its simple four-dimensional representation. An order-five element cannot permute a nontrivial set of size at most four; there is one character. Faithfulness would make noncyclic $V$ scalar, impossible. Hence the kernel has order two and $|R|=160$.

Let $N$ be the inverse image of $V$, of order thirty-two. Its restriction types on $U$ again form one orbit of size at most four, hence one type. Its commutator pairing on $V$ takes values in $\{\pm I\}$. If a vector were in its radical, its lift would be central in $N$ and hence scalar on the one irreducible restriction type and all its copies. Faithfulness of the projective $V$ action forces that vector to be zero. Thus the pairing is nondegenerate and $N$ is extraspecial, with its central-character irreducible module of dimension four. The quadratic form from squares of lifts is minus type: order-five conjugation acts fixed-free on $V\setminus\{0\}$, since $X^4+X^3+X^2+X+1$ is irreducible over $\mathbf F_2$. The number of nonzero isotropic vectors, either five or nine, must be divisible by five. It is five. Therefore
\[
N=2_-^{1+4},\qquad R=N\rtimes C_5,
\]
where the retained order-five element supplies the complement.

This coefficient representation has a genuine $\mathbf F_5$ model. On two tensor factors use
\[
X_1=\operatorname{diag}(2,-2),\quad Y_1=\begin{pmatrix}0&1\\-1&0\end{pmatrix},\quad
X_2=\operatorname{diag}(1,-1),\quad Y_2=\begin{pmatrix}0&1\\1&0\end{pmatrix}.
\]
Each pair anticommutes; the first has squares $-I$, the second squares $I$. They realize the quaternion and dihedral factors of $N$ and generate $\operatorname{Mat}_4(\mathbf F_5)$. The unique irreducible nontrivial-central-character module identifies the actual restriction with this model. The conjugation automorphism of the retained order-five matrix has an invertible intertwiner $T$ over $\mathbf F_5$, since its one-dimensional solution space is defined over that field. Write $T^5=\delta I$, $\delta\in\mathbf F_5^*$. Replacing $T$ by $\delta^{-1}T$ makes its fifth power one. The actual order-five matrix differs by a scalar of fifth power one, necessarily one. Thus all of $R$ is defined over $\mathbf F_5$. Its representation is unique up to equivalence: the restriction to $N$ is unique, and two extensions differ by a character of $C_5$, which is trivial in characteristic five.

## The exact two-dimensional original Raynaud pencil

Let $\mathcal U$ be the actual étale $\mathbf F_5$ local system of $U_0$ on $Y_1$, with coherent bundle $E$. Actual torsor inflation gives
\[
H^1(G,U_0)\hookrightarrow H^1_{\mathrm{et}}(Y_1,\mathcal U).
\]
By field extension of finite-group cochains, the SAME-socle hypothesis $H^1(G,U)\ne0$ makes the left side nonzero. Étale-locally the usual Artin–Schreier sequence in four coordinates gives
\[
0\to\mathcal U\to E\xrightarrow{\Phi-1}E\to0.
\]
The transition matrices lie in $GL_4(\mathbf F_5)$, so coordinate fifth power is intrinsic. Since $H^0(E)=0$, this identifies $H^1_{\mathrm{et}}(Y_1,\mathcal U)$ with $H^1(Y_1,E)^{\Phi=1}$. Riemann–Roch gives $h^1(E)=4$. Semilinear descent on the bijective part shows its fixed space has $\mathbf F_5$ dimension equal to that part's $k$ dimension. It is nonzero, so the generalized nilpotent dimension $r$ is at most three.

Tensor the actual relative sequence defining $B$ with $E$. Both finite coefficient bundles have no sections, so
\[
H^0(B\otimes E)=\ker[H^1(Y_1,E)\to H^1(Y,F_Y^*E)].
\]
Absolute Frobenius factors as $Y_1\xrightarrow{p}Y\xrightarrow{F_Y}Y_1$, where $p$ is the base-field semilinear projection. The actual $\mathbf F_5$ local system canonically identifies the absolute Frobenius pull of $E$ with $E$. Semilinear transport therefore identifies the displayed kernel dimension with $\dim\ker\Phi$, without a $k$-isomorphism $Y\simeq Y_1$ or a positive scalar root choice.

Self-duality identifies this space with $\operatorname{Hom}(E,B)$, which is nonzero by the actual evaluation. The accepted [general symplectic-coefficient parity lemma](../jacobians/theta_divisors/galois_raynaud_rank_gap.md#a-direct-parity-lemma-for-symplectic-coefficients) makes its dimension even, without a prime-to-characteristic condition on the group. It is at most $r\le3$, hence exactly two. Thus $r=2$ or $3$, and the nilpotent Jordan lengths are $(1,1)$ or $(2,1)$. The bijective dimension is $t=4-r$.

For a basis $f_0,f_1$, the determinant section is
\[
\det(\lambda f_0+\mu f_1)\in H^0(Y_1,\omega_{Y_1}^2)\otimes H^0(\mathbf P^1,\mathcal O(4)).
\]
If it is nonzero, at least one coordinate is a nonzero quartic, leaving at most four rank-at-most-three directions. Each integral rank-three image is determined by its direction, and evaluation rigidity forbids two different directions onto the same embedded $K$.

If it is identically zero, the actual selected good member makes the general generic rank three. Good constant-rank, locally free cokernel and stable degree-one image conditions are open, giving a nonempty open $W\subset\mathbf P^1$. The Raynaud annihilator lines on $Y_1\times W$ define $W\to\operatorname{Pic}^{-1}(Y_1)$. Properness extends this to $\mathbf P^1$, and every map from $\mathbf P^1$ to a Picard variety is constant, also in characteristic five. Thus the Picard class is fixed; the embeddings need not be.

## A finite cohomological parametrization on the fixed endpoint

The central quotient of $R$ is $H=V\rtimes C_5$, with $V$ the unique irreducible four-dimensional $\mathbf F_2[C_5]$ module and endomorphism field $\mathbf F_{16}$. The ordinary genus-two endpoint has $H^1_{\mathrm{et}}(Y_1,\mathbf F_5)=\mathbf F_5^2$, giving twenty-four nonzero labeled connected $C_5$ quotient torsors $C_\chi\to Y_1$.

For each, étale Hurwitz gives $g(C_\chi)=6$ and $\dim H^1_{\mathrm{et}}(C_\chi,\mathbf F_2)=12$. As five is invertible in $\mathbf F_2$, this is a semisimple $C_5$ module. Its invariants have dimension four, by Hochschild–Serre and $g(Y_1)=2$. Its remaining eight dimensions are two copies of the unique nontrivial simple $V$. For the twisted local system $\mathcal V_\chi$, coefficient descent gives
\[
H^1_{\mathrm{et}}(Y_1,\mathcal V_\chi)
\simeq\operatorname{Hom}_{C_5}(V^*,H^1_{\mathrm{et}}(C_\chi,\mathbf F_2))
\simeq\mathbf F_{16}^2.
\]
The split extension $V\rtimes C_5$ gives at most $256$ labeled lifts. A connected $H$ lift requires a nonzero class: its additive kernel image is $C_5$-stable, hence zero or all of $V$, and a zero image is a complement with zero class since $H^1(C_5,V)=0$. Thus there are at most $255$ connected lifts.

For the central extension $1\to\mathbf F_2\to R\to H\to1$, the obstruction lies in $H^2_{\mathrm{et}}(Y_1,\mathbf F_2)=\mathbf F_2$. If it vanishes, lifts with fixed quotient identification form a torsor under $H^1_{\mathrm{et}}(Y_1,\mathbf F_2)$, of size sixteen. Every such lift of a connected $H$ torsor is connected; a disconnected lift would give a complement of the center in $R$, impossible since the inverse image of $V$ is nonabelian extraspecial. Forgetting labels can only decrease the count. Therefore
\[
\#\{\text{possible connected }R\text{-torsors}\}\le24\cdot255\cdot16=97\,920.
\]
This also bounds the associated source bundles by the fixed genuine representation. A nonzero determinant pencil contributes at most four annihilator classes, a singular pencil at most one. Multiplication gives $391\,680$ classes, and the same bound for embedded images only in the nonzero-determinant alternative.

## Actual affine extension choices and their original origin

For a fixed linear torsor, Artin–Schreier gives $H^1_{\mathrm{et}}(Y_1,\mathcal U)=\mathbf F_5^t$, $t=1$ or $2$. A continuous cocycle $z$ gives the finite homomorphism
\[
\gamma\longmapsto(z(\gamma),\rho(\gamma))\quad\text{into }U_0\rtimes R.
\]
Its additive kernel image is an $R$-stable $\mathbf F_5$ subspace of absolutely irreducible $U_0$, hence zero or $U_0$. In the former case the image is a complement and the cocycle factors through $R$. But $H^n(R,U_0)=0$ for all $n$: the central order-two subgroup acts fixed-free by $-I$, and its Hochschild–Serre sequence has zero invariant coefficients and zero higher cohomology. Thus a nonzero class has full image $U_0\rtimes R$. This is an actual connected étale affine torsor of order $625\cdot160=100000$.

Multiplication by $\mathbf F_5^*$ changes only the additive labeling and leaves the fundamental-group kernel unchanged. The number of possible underlying covers is at most $(5^t-1)/4$, namely six or one. For $t=1$ it is exactly one since the set is nonempty. Across the fixed endpoint the bound is $6\cdot97\,920=587\,520$.

The original $H^1(G,U)$ has dimension one by the first package and the present nonzero hypothesis. Cochain field extension gives $H^1(G,U_0)$ of $\mathbf F_5$ dimension one. An original nonzero class is a $k$ scalar multiple of an $\mathbf F_5$ class whose cocycle factors through the ACTUAL $G$ torsor. The affine torsor is therefore an actual quotient of $T_1$. Scalar change leaves its underlying kernel unchanged; a specified evaluation is rescaled inversely to retain a fixed pushout. Only when the original minimum orbit has $Z_0=U$ is this class identified with the original $Z_{\mathrm{net}}$ and hence with the specified pushout $e_J$.

## The complete numerical strata of a singular pencil

Assume the determinant pencil is identically zero. On the regular surface $S=Y_1\times\mathbf P^1$, the universal kernel is rank-one reflexive and hence a line bundle: its image in the target is torsion-free, and the depth lemma gives kernel depth two. The product Picard group writes it as $L=D\boxtimes\mathcal O(-\ell)$. At the selected good point $D$ is the kernel of $E\twoheadrightarrow K$, so $\deg D=-1$.

Its quotient in $\pi^*E$ is torsion-free, so no parameter fiber makes the map $D\to E$ identically zero. Every nonzero such map is nowhere zero: a saturated image of degree $-1+b$, $b\ge0$, would violate stability of degree-zero $E$ unless $b=0$. Thus $L$ is globally a line subbundle and $\ell\ge0$. Put $I=\pi^*E/L$. Every $I_u$ is stable of rank three and degree one: the inverse image in $E$ of a proper rank-one or rank-two subbundle of degree $b$ has degree $b-1$ and hence $b\le0$.

The injection $I\to\pi^*B(1)$ gives a cokernel $\mathcal C$ with a length-one locally free resolution, so it has no zero-dimensional subsheaf. Any horizontal torsion would persist at a good parameter; its torsion $\mathcal T$ is therefore vertical. The rank-one torsion-free quotient has a line double dual and a finite defect:
\[
\mathcal C/\mathcal T=(R_0\boxtimes\mathcal O(s))I_Z,\qquad\deg R_0=3.
\]

Every nonzero pencil member has generic rank at least two: a rank-one image is a proper quotient of stable $E$ with positive integer degree, whereas a line in stable slope-one $B$ has degree at most zero. For a rank-two member its image has degree at least one and its saturation in $B$ has degree at most one; thus it is saturated of degree one. Its kernel in $I_u$ is a degree-zero line $M_u$.

For a local parameter $z$ at this member, base change gives $\mathcal C[z]=\mathcal T[z]=M_u$. In particular the vertical torsion occurs precisely at generic-rank-two members. The finite pushforward $\pi_*\mathcal T$ is a vector bundle, since any torsion over $Y_1$ would be a zero-dimensional subsheaf. On each primary summand multiplication by $z$ is nilpotent with kernel $M_u$. Its saturated kernel filtration has successive line bundles injecting into $M_u$, hence degrees at most zero. Therefore $\delta=\deg\pi_*\mathcal T\le0$. A simple primary summand has degree zero; a length-two summand has degree $-b$ for an effective divisor of degree $b$.

With numerical curve point class $x$ and parameter hyperplane class $t$, $x^2=t^2=0$, the exact sequences give
\[
c_1(I)=x+\ell t,\quad\operatorname{ch}_2(I)=-\ell xt,
\quad c_1(\mathcal C)=3x+(4-\ell)t,\quad\operatorname{ch}_2(\mathcal C)=(4+\ell)xt.
\]
Devissage on vertical fibers gives $c_1(\mathcal T)=vt$ and $\operatorname{ch}_2(\mathcal T)=\delta xt$, while the torsion-free quotient has $c_1=3x+st$ and $\operatorname{ch}_2=(3s-|Z|)xt$. Thus
\[
s=4-\ell-v,\qquad4\ell=8-3v-|Z|+\delta.
\]
Since $\ell\ge0$, $\delta\le0$, $|Z|\ge0$, this forces $\ell\le2$, $v\le2$. For $v=0,1$, the vertical degree is zero. For $v=2$, it is zero at two distinct simple fibers and otherwise $-b$. Substitution gives exactly the table in the statement, including $0\le b\le2$ in its last row. This is an integer Chern-character calculation, not reduction modulo five.

The cokernel map to the double dual, after removing the target twist, is
\[
\pi^*B\to R_0\boxtimes\mathcal O(s-1).
\]
Dualizing with the Raynaud alternating pairing gives the annihilator family
\[
(\omega_{Y_1}R_0^{-1})\boxtimes\mathcal O(1-s)\to\pi^*B.
\]
There is no common parameter factor: at the generic point of every vertical fiber the quotient surjects onto its torsion-free double dual. Its homogeneous parameter degree is therefore $j=s-1\le3$, as in the table. The possible codimension-two defect does not change that degree.

For $\ell=2$ the table gives $\mathcal T=0$, $Z=\varnothing$, so every member has constant rank three and saturated degree-one image. Over the function field of $Y_1$, its quadratic source kernel has three independent coefficients: if it spanned two vectors with coprime quadratic coordinates, multiplication by the matrix pencil would force both vector-valued linear products to vanish, giving a common two-dimensional kernel, impossible. A one-dimensional span would have a parameter zero. The three corresponding maps $D\to E$ are fiberwise independent, since every nonzero linear combination is nowhere zero by stability. Thus $D^{\oplus3}\subset E$ is a subbundle.

The alternating form has rank two on every such three-dimensional fiber. Its three entries are sections of $D^{-2}$ without a common zero. This degree-two line is basepoint free, hence canonical on a genus-two curve: Riemann–Roch gives $h^0(M)=1+h^0(\omega M^{-1})$, and basepoint freeness forces $h^0(M)\ge2$. Therefore $D^{-2}=\omega$. If $Q$ is the good annihilator, the Raynaud form gives $B/K=\omega Q^{-1}$ and $\det K=\omega Q$, so $D=\omega^{-1}Q^{-1}$. It follows that $Q^2=\omega^{-1}$ precisely in this uniform row. No marked point is selected.

## The minimum ORIGINAL net and its same finite killing torsor

Now impose the exact actual minimum extension $0\to E\to E_{Z_{\mathrm{net}}}\to\mathcal O\to0$, with class $e$ and nonzero original pushout $e_J$. Acyclicity of $B$ gives
\[
\operatorname{Hom}(E_{Z_{\mathrm{net}}},B)\xrightarrow{\sim}\operatorname{Hom}(E,B).
\]
Thus the socle pencil has a unique lifted pencil from this SAME finite extension. Its universal map $b$ contains $L$ in its kernel. At the selected good parameter it has generic rank four: rank three would put its image in the saturated original $K$, giving a lift of the evaluation to $E_{Z_{\mathrm{net}}}\to K$ and splitting the pushout $e_J$, contrary to hypothesis. Therefore its universal kernel has rank one. Since $\pi^*E_{Z_{\mathrm{net}}}/L$ is locally free, extending $I$ by $\mathcal O_S$, the kernel is exactly $L$.

Put $\mathcal J=\pi^*E_{Z_{\mathrm{net}}}/L$. Its induced map to $\pi^*B(1)$ gives a section $\sigma_{\mathcal C}:\mathcal O_S\to\mathcal C$. Projection to the torsion-free double dual gives
\[
\sigma\in H^0(Y_1,R_0)\otimes H^0(\mathbf P^1,\mathcal O(s)).
\]
It is nonzero at the selected parameter. Degree three gives $h^0(R_0)=2$, so its two homogeneous coordinates, after a common factor is removed, define a rational net map of degree at most $s=j+1\le4$, with a constant map allowed.

At a good parameter $\mathcal C_u$ is the actual line cokernel of $I_u\subset B$. Since $B$ is acyclic its unit boundary is $H^0(\mathcal C_u)\simeq H^1(I_u)$. The extension diagram is precisely the pullback along $\sigma_{\mathcal C,u}$ of $0\to I_u\to B\to\mathcal C_u\to0$, giving $e_u=\partial\sigma_u$ with the standard pullback sign convention. Independently, for EVERY parameter the sequence $0\to I_u\to\mathcal J_u\to\mathcal O\to0$ is the pushout of the fixed finite extension, so its class is $(E\twoheadrightarrow I_u)_*e$. All these classes vanish on the SAME actual quotient torsor trivializing $Z_{\mathrm{net}}$, even at bad parameters. That torsor is an actual quotient of $T_1$, and does not acquire the original $X$-map.

If a bad-parameter pushout vanishes, split $\mathcal J_u=I_u\oplus\mathcal O$. The trivial summand maps to zero in $B$, since $H^0(B)=0$, so the further projected section $\sigma_u$ is zero. A nonzero pair of degree-$s$ coordinates has at most $s$ common zeros. This proves the stated zero-pushout bound at all parameters; its converse is used only at good parameters where the unit boundary is an isomorphism. In particular no rank-four assertion is made from a nonzero pushout at a rank-two socle member.

This exact finite extension and its pushouts are the original net, not an annihilator's unit-Cartier lifting class. No step decides compatibility with the original positive $A_8$, its height-zero obstruction, or its scalar connection. Both actual endpoint maps remain on the original same $T$.

## Frozen inputs and review provenance

The following independently audited source notes are consolidated inline. Each full SHA256 binds its original review. The repaired genuine-net note is the version used here; its earlier hash is superseded. No numerical calculation was run for this extraction.

| Source and corresponding independent audit | Source SHA256 | Audit SHA256 |
|---|---|---|
| [Self-dual four carrier](../../Research/notes/oct03_ten_hour/genuine_self_dual_four_carrier.md), [audit](../../Research/notes/oct03_ten_hour/genuine_self_dual_four_carrier_audit.md) | `27e97c8e1b29db5be472d7a313f6f7a4f1522440b459eb0fff57fa2199d18885` | `fb3cbc7633ef9eeb40b66557dd719e1fd5ab4052c33bf1982ebfb7cb3cdb063d` |
| [Raynaud source pencil](../../Research/notes/oct03_ten_hour/symplectic_four_raynaud_source_pencil.md), [audit](../../Research/notes/oct03_ten_hour/symplectic_four_raynaud_source_pencil_audit.md) | `66a0819468efc4abf1eb4775c13d8fad6f5b1b87fb6e024a729e20719468e905` | `c832066c435ba60950f219a083ad2fd844146d4b742ddfc796ab25b379975549` |
| [Finite torsor and annihilator family](../../Research/notes/oct03_ten_hour/symplectic_four_finite_torsor_annihilator_family.md), [audit](../../Research/notes/oct03_ten_hour/symplectic_four_finite_torsor_annihilator_family_audit.md) | `7f7ae2c73917f76d6a56310b1d85ed1b2499eb49f6bcbf2ec988ff26ff2bc53e` | `0519dea34b1cbae4fe6c11c9215675cdc42e57b1a96aa9aad0fc8ff736e6c342` |
| [Finite actual extension choices](../../Research/notes/oct03_ten_hour/symplectic_four_finite_actual_extension_choices.md), [audit](../../Research/notes/oct03_ten_hour/symplectic_four_finite_actual_extension_choices_audit.md) | `9448b0b7157f37745f868051768eb59d9ab12c93ebe130c91df7c375af009116` | `c0b4cb6496650250a2ad93bdf96889981f6061406239387a843bd678d6abb9ed` |
| [Singular-pencil exceptional strata](../../Research/notes/oct03_ten_hour/singular_raynaud_pencil_exceptional_strata.md), [audit](../../Research/notes/oct03_ten_hour/singular_raynaud_pencil_exceptional_strata_audit.md) | `f38b889b0ef957b73a5b5dd2cfba4b7eb4c759c6773e83f1721be9834ad81429` | `ac1694707cbe6d42645d97c02870ba4c6bdb31e386bb643f73f291b7b84d0a3f` |
| [Genuine original net curve, repaired](../../Research/notes/oct03_ten_hour/singular_pencil_genuine_net_curve.md), [audit](../../Research/notes/oct03_ten_hour/singular_pencil_genuine_net_curve_audit.md) | `4deb1ccf6bd22d9a8e44992f663418b7697296213451acc66d6b61f193592595` | `d69bf2570b62eb1d02d353d4efe7f75748351e7b187e6cf7cb157b7eab83d293` |

The preceding canonical evaluation/lift package contains its own frozen source reviews and the accepted original-extraction snapshot. The general parity input is used only in its precise symplectic-coefficient scope; its older surrounding rank-gap theorem is not imported. The canonical reflection input is used only for the simple genuine five-dimensional $W$ with the exact $1+4$ tame pattern. Neither ordinary carrier data nor an abstract group identification replaces the original same-source two-leg hypothesis.
