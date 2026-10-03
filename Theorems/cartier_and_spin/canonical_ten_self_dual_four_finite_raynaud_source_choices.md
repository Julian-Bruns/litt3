# Finite actual self-dual four-source choices and singular Raynaud pencils

Version1, 3 October2026. This coherent package consolidates independently audited finite-source, Cartier-pencil and genuine-extension arguments. Full source and audit SHA256 values are retained in the [proof provenance](../../Proofs/cartier_and_spin/canonical_ten_self_dual_four_finite_raynaud_source_choices.md#frozen-inputs-and-review-provenance). [Fresh canonical fidelity audit PASS](../../Research/notes/oct03_ten_hour/canonical_genuine_and_self_dual_four_fidelity_audit.md); all extra same-socle hypotheses remain explicit.

Retain the exact actual same-source hypotheses of [genuine four-source evaluation and lift rigidity](canonical_ten_genuine_four_source_evaluation_and_lift_rigidity.md): BOTH finite étale maps $h:T\to X$, $q:T\to Y$ on the SAME connected smooth projective $T$, the actual connected free $G$-torsor, its faithful weak-five/tame-two canonical degree-ten carrier, and the original opposite-class tuple and group restrictions. Use the actual relative twists $Y_1=Y^{(1)}$, $q_1=q^{(1)}$, and $B=B_Y$ on $Y_1$. Require the ORIGINAL stable saturated $K\subset B$ of rank three and degree one and an actual genuine simple four-dimensional evaluating source $v:E_U\twoheadrightarrow K$.

Impose the EXTRA hypotheses
\[
U\simeq U^*,\qquad H^1(G,U)\ne0
\]
on this SAME evaluating module $U$. They are not supplied by the native Gram form, by degrees, or by cohomology of another simple composition detector. No minimum orbit hypothesis is needed until the final genuine-net assertion below.

Then:

1. The actual linear image and its genuine coefficient model are
\[
R=\operatorname{im}(G\to GL(U))\simeq2_-^{1+4}\rtimes C_5,
\quad |R|=160,\quad U=U_0\otimes_{\mathbf F_5}k,
\quad U_0\simeq\mathbf F_5^4.
\]
The form on $E=E_U$ is alternating and $\mathcal O$-valued. This form is distinct from the canonical $\omega_{Y_1}$-valued alternating form on $B$. The actual $R$-torsor is $T_1/\ker(G\to R)\to Y_1$.

2. The exact original Raynaud map space has dimension two:
\[
\dim\operatorname{Hom}(E,B)=2.
\]
On $H^1(Y_1,E)$, of dimension four, let $r$ denote the generalized nilpotent dimension of the intrinsic semilinear Frobenius from the actual $\mathbf F_5$ local system. Then $r=2$ or $3$, its bijective dimension is $t=4-r=2$ or $1$, and its nilpotent Jordan lengths are $(1,1)$ or $(2,1)$, respectively. This does not assume that $Y$ or its torsor is defined over $\mathbf F_5$.

3. For each fixed $E$, either its determinant pencil is nonzero, leaving at most four projective directions with rank-three stable saturated degree-one image, or the entire determinant pencil is zero. In the latter case the good directions form a nonempty open set and their annihilators $Q\subset B$ all have ONE fixed class in $\operatorname{Pic}^{-1}(Y_1)$, although the embeddings of $Q$ and $K=Q^\perp$ may vary.

4. On the fixed ordinary genus-two $Y_1$ there are at most $97\,920=24\cdot255\cdot16$ possible connected $R$-torsors and hence at most this many actual finite source bundles. Across this conditional branch there are at most $391\,680$ annihilator Picard classes. The nonzero-determinant part has at most $391\,680$ embedded images $K$. Singular pencils remain a finite collection of rational families; no finiteness of their embedded images is asserted.

5. For a fixed actual $R$-torsor, every nonzero class in $H^1_{\mathrm{et}}(Y_1,\mathcal U)\simeq\mathbf F_5^t$ gives a connected finite étale torsor with exact affine group $\widehat R=\mathbf F_5^4\rtimes R$, of order $100000$. Up to additive labeling while retaining the linear quotient, there are at most six covers when $r=2$ and exactly one when $r=3$. Every nonzero original $H^1(G,U)$ class chooses one of these covers as an ACTUAL quotient of $T_1$. Across the whole fixed-$Y_1$ branch there are at most $587\,520$ possible affine quotient covers. These are theoretical upper bounds, not an executed enumeration.

The singular alternative has the following exact geometry. On $S=Y_1\times\mathbf P^1$, let $a:\pi^*E\to\pi^*B\otimes\rho^*\mathcal O(1)$ be the universal pencil. Its kernel is a global line subbundle
\[
L=D\boxtimes\mathcal O(-\ell),\qquad\deg D=-1.
\]
Put $I=\pi^*E/L$, $\mathcal C=\operatorname{coker}a$, and let $\mathcal T$ be the torsion of $\mathcal C$. For a degree-three line $R_0$, integer $s$, and finite subscheme $Z\subset S$,
\[
\mathcal C/\mathcal T=(R_0\boxtimes\mathcal O(s))\otimes I_Z.
\]
The torsion is vertical and has no zero-dimensional subsheaf. If $v$ is its total generic vertical length and $\delta=\deg\pi_*\mathcal T$, then
\[
s=4-\ell-v,\qquad4\ell=8-3v-|Z|+\delta,\qquad\delta\le0.
\]
All possibilities for these numerical invariants are in this table; no existence of a row is asserted.

| $\ell$ | $v$ | $\delta$ | $|Z|$ | Annihilator parameter degree $j=s-1$ |
|---:|---:|---:|---:|---:|
| 2 | 0 | 0 | 0 | 1 |
| 1 | 0 | 0 | 4 | 2 |
| 1 | 1 | 0 | 1 | 1 |
| 0 | 0 | 0 | 8 | 3 |
| 0 | 1 | 0 | 5 | 2 |
| 0 | 2 | $-b$, $0\le b\le2$ | $2-b$ | 1 |

For two distinct simple torsion fibers in the last row, $b=0$. The annihilator family is represented by homogeneous sections of degree $j\le3$ without a common parameter factor. The row $\ell=2$ is uniform and forces $D^{-2}\simeq\omega_{Y_1}$ and $Q^2\simeq\omega_{Y_1}^{-1}$. These theta-class equalities are not asserted for $\ell=0,1$ and do not select a marked Weierstrass point.

Finally impose the ORIGINAL minimum orbit hypothesis $Z_0=U$, $\dim Z_{\mathrm{net}}=5$, and the actual exact nonsplit extension
\[
0\to U\to Z_{\mathrm{net}}\to k\to0,
\qquad e\in H^1(Y_1,E),\qquad e_J=v_*e\ne0.
\]
Here $e_J$ is exactly the original net pushout from the [genuine-source extraction](canonical_ten_original_net_genuine_source_extraction.md). Every socle pencil map lifts uniquely to $E_{Z_{\mathrm{net}}}\to B$. In a singular pencil the resulting universal quotient $\mathcal J=\pi^*E_{Z_{\mathrm{net}}}/L$ satisfies $0\to I\to\mathcal J\to\mathcal O_S\to0$ and determines a nonzero
\[
\sigma\in H^0(Y_1,R_0)\otimes H^0(\mathbf P^1,\mathcal O(s)),
\qquad s=j+1\le4.
\]
Since $h^0(R_0)=2$, it gives a rational net map of degree at most four. At every good parameter its unit boundary is the actual pushout $e_u=(E\twoheadrightarrow I_u)_*e=\partial\sigma_u$. All these pushouts, including the defined pushouts at bad parameters, are killed by the SAME actual finite quotient torsor trivializing $Z_{\mathrm{net}}$. At most $s$ parameters have zero pushout; the converse between a zero projected section and a zero pushout is asserted only at good parameters. A nonzero pushout at a bad rank-two member does not force its lifted map to have rank four.

The finite affine torsors do not acquire the original $X$-leg. The genuine net extension is not an annihilator's Cartier lifting class. No marking, ordinary-trace preservation, positive-source horizontal descent, or identification of $H_Y$ with a native bundle follows. The non-self-dual and larger-orbit sectors remain outside these extra hypotheses, and the singular and original positive-source compatibility gaps remain open. The unmarked same-source common-cover problem is UNSOLVED.

Dependencies are [genuine evaluation and lift rigidity](canonical_ten_genuine_four_source_evaluation_and_lift_rigidity.md), [genuine-source extraction](canonical_ten_original_net_genuine_source_extraction.md), [weak cyclic reflection rigidity](../quotient_geometry/local_actions/weak_cyclic_reflection_module_constraints.md), the general [symplectic-coefficient parity proof](../../Proofs/jacobians/theta_divisors/galois_raynaud_rank_gap.md#a-direct-parity-lemma-for-symplectic-coefficients), and the [relative Raynaud conventions](../../Definitions/theta_cartier.md). The exact finite-image, torsor count, exceptional-stratum and genuine-net arguments are proved inline in the [proof](../../Proofs/cartier_and_spin/canonical_ten_self_dual_four_finite_raynaud_source_choices.md).
