# Proof: the actual self-dual four-source and its selected original net

Version1, 3 October2026. This is the human-readable canonical proof of the [statement](../../Theorems/cartier_and_spin/canonical_ten_self_dual_four_actual_source_and_selected_net.md). All new source arguments below have independent frozen PASS audits listed at the end. The canonical adaptation requires a separate fidelity review. No numerical computation or enumeration is used.

## Scope, accepted foundations and notation

Retain exactly (H), (U), (Q) of the statement, including BOTH actual finite étale maps from SAME $T$, and impose (N) only for assertions about the original minimum-five net. No dimension of the original projective positive representation is prescribed. The four-module here is the genuine evaluating socle, not that representation or an unspecified composition detector.

Use the accepted [genuine-source extraction](canonical_ten_original_net_genuine_source_extraction.md), [self-dual four-source theorem](canonical_ten_self_dual_four_finite_raynaud_source_choices.md), [evaluation rigidity](canonical_ten_genuine_four_source_evaluation_and_lift_rigidity.md), [weak reflection constraints](../quotient_geometry/local_actions/weak_cyclic_reflection_module_constraints.md), and the exact [symplectic coefficient parity lemma](../jacobians/theta_divisors/galois_raynaud_rank_gap.md#a-direct-parity-lemma-for-symplectic-coefficients). Retain their actual no-$A_5$-quotient and small-simple exclusions as stated in the hypotheses; the four-source foundation uses them, rather than deriving its exterior-five simplicity from self-duality alone. These foundations supply the actual group $R=A_2:C_5$, $A_2=2_-^{1+4}$, genuine symplectic $U_0$, the étale Cartesian quotient square (Q), ordinary $C$ of genus nine, its central étale double quotient $H$ of genus five, and the SAME-source Frobenius alternatives used in section7. We do not re-prove those settled foundations.

The group $A_2$ has order32, center $C_2$, and $D=A_2/C_2=\mathbf F_2^4$. The cyclic-five action on $D$ is irreducible. Write $H_0=D:C_5=R/C_2$. All scalar characters of $R$ and the original $G$ are trivial. Superscript $(1)$ and subscript1 always mean the actual relative base twist; use the [relative Cartier conventions](../../Definitions/theta_cartier.md). Coefficient Frobenius later comes from the genuine prime-field local system, not a chosen coordinate model of $Y$.

## 1. Actual canonical descent and the effective fold theta

The quotient $C/A_2$ is the degree-five weak break-one cover of the rational coarse base, hence rational. Normalize its coordinate $u$ so the retained wild generator acts by $u\mapsto u+1$ and the five finite tame values are $\mathbf F_5$. Then $z=u^5-u$ is a coarse coordinate. The map $f_C:C\to\mathbf P^1_u$ has degree32 and only tame index-two inertia at these five values. If $R_a$ is its reduced ramification divisor, then $2R_a=f_C^*(a)$ and Hurwitz gives
\[
\omega_C^2=f_C^*\mathcal O(-4)\otimes\mathcal O(2\sum_aR_a)
=f_C^*\mathcal O(1).
\tag{8}
\]
Both sides have genuine $R$ actions: on $\mathcal O(1)$ use the unipotent translation lift. Their underlying comparison is equivariant because $R$ has no scalar characters.

The SPECIFIED canonical identity (H) descends through the actual étale Cartesian $N$ square to $\omega_{T_R}=r^*\omega_C^2$. Put $Z_5=T_R/A_2$ and $p:Z_5\to Y$. Descent of this genuine identity through the actual étale $A_2$ cover, using (8), gives
\[
\omega_{Z_5}=u^*\mathcal O(1),\qquad
\operatorname{div}_\infty(u)=p^*E,\qquad
E=\operatorname{div}\eta\in|\omega_Y|.
\tag{9}
\]
Indeed the infinity section is invariant under $C_5$, which has no nontrivial scalar character, and descends to the nonzero $\eta$. Here $\deg u=10$, $p$ is the actual connected étale degree-five quotient and $g(Z_5)=6$. The coarse $z$ has pole divisor $5E$. The local indices of $u$ above all five finite branch values are even: its pullback kills the actual tame inertia in the étale $A_2$ square. Thus every finite zero of $z$ on $Y$ has even multiplicity.

Write $\operatorname{div}_0(z)=2\Delta$ with $\deg\Delta=5$. Set $\theta=\mathcal O(\Delta)\omega_Y^{-2}$, so $\theta^2=\omega_Y$, and choose $s\in H^0(Y,\theta^5)$ with $z=s^2/\eta^5$. This uses $2\Delta\sim5E$. The supports of $\Delta$ and $E$ are disjoint. Use the canonical connection on the EXACT line $\theta^5=F_Y^*(\theta^{(1)})$.

At a simple pole point of $E$, take a local theta frame $\tau$ with $\tau^2=dt_0$, and write $\eta=t_0v_0(t_0)dt_0$, $s=b(t_0)\tau^5$, $b(0)\ne0$. Then $z=b(t_0)^2/(t_0^5v_0(t_0)^5)$. Unramified Artin--Schreier descent permits only the polar part $\gamma^5t_0^{-5}-\gamma t_0^{-1}$. Since $v_0^5$ has only fifth-power terms, successive coefficients of orders $-4,-3,-2$ give $b_1=b_2=b_3=0$. The derivative $\nabla s$ is nonzero because $u$ is separating, and vanishes to order at least three at each point of $E$. Its line has degree seven, so $\theta$ is effective. An effective genus-two theta is $\mathcal O(P_\theta)$ for a Weierstrass point. The nonzero order-$-1$ polar term forces exact order three, hence $P_\theta\notin E$ and
\[
\nabla s=c\eta^3\tau_\theta,\qquad c\ne0.
\tag{10}
\]
For a double fiber $E=2W$, the allowed polar orders are $-10,-5,-2,-1$. The same expansion instead forces $b_1=\cdots=b_4=b_6=b_7=0$ and $b_8\ne0$. Thus $\nabla s$ has exact order seven at $W$ and $\theta=\mathcal O(W)$.

The actual different selects the effective theta, rather than a degree argument. From $dz=2s\nabla s/\eta^5$ one obtains $\operatorname{div}(dz)=\Delta+P_\theta-2E$; pulling to $Z_5$ yields the ramification divisor of $u$ as $p^*(\Delta+P_\theta)$. In the Cartesian tame covering square, the $p^*\Delta$ term cancels precisely the reference index-two inertia. The remaining different of $r$ is $q_R^*P_\theta$. It is also $q_R^*P_0$ by the retained original different, so the actual effective divisors agree and $P_\theta=P_0$. The third-value assumption excludes $E=2P_0$, which would place that point at the wild value. Consequently $E$ is reduced and disjoint from $P_0$, and $\theta=\vartheta=\mathcal O(P_0)$.

The actual scalar AS class $a_5$ annihilates $\eta$. The principal parts of $u$ at its pole divisor in (9) descend to principal parts on $E$ because translation by constants does not change them. Their boundary in $H^1(Y,\mathcal O)$ is the actual $a_5$, up to the chosen generator sign. The boundary for $\mathcal O(E)=\omega_Y$ is the Serre-dual annihilator of $k\eta$, giving $\langle a_5,\eta\rangle=0$. No annihilator $Q$ in $B$ has been identified here.

## 2. Fixed-curve jets and the exact eight-function list

Put $a=1+\alpha\ne0$. Direct expansion in characteristic five gives
\[
f(x)=x^5-ax^4+ax^3-ax^2+\alpha x,
\qquad f'(x)=a(x+1)^3-1.
\tag{11}
\]
For completeness, (10) selects the same effective theta even without using its retained marking. At infinity, a theta frame has $\tau^2=dx/y$, and $H^0(\theta^5)$ has basis $1,x,x^2,y$ times $\tau^5$. For $s=(r_0+r_1x+r_2x^2+r_3y)\tau^5$ the derivative condition becomes
\[
(r_1+2r_2x)y+r_3f'/2=c(b_0+b_1x)^3.
\]
The two function-field summands force $r_1=r_2=0$, $r_3\ne0$. But (11) is not a linear cube: its first three coefficients force $a(x+1)^3$, with the wrong constant term. At a finite Weierstrass point $P_b$, take $t_b=(x-b)^{-1}$, $w_b=yt_b^3$ and $F_b=t_b^6f(b+1/t_b)$. Its derivative is
\[
F_b'=a(b+1)^2t_b^3+3a(b+1)t_b^2+3at_b+1.
\]
For this to be $(1+Bt_b)^3$, the linear coefficient gives $B=a$ and the quadratic coefficient gives $b+1=a$. Thus $b=\alpha$ is the only possibility; its cubic coefficient agrees.

Now write $t=(x-\alpha)^{-1}$, $w=yt^3$, $\ell=1+at$. Then
\[
w^2=F(t)=(a^4-1)t^5+4a^3t^4+a^2t^3+4at^2+t,
\qquad F'=\ell^3.
\tag{12}
\]
Choose $\tau^2=dt/w$ with divisor $P_0$. Equation (10) has exactly the primitives $s=(r_0+r_3w)\tau^5$, $r_3\ne0$, and $\eta=\ell\,dt/w=-(x+1)dx/y$. This proves the claimed pole fiber $E$.

At $t_*=-a^{-1}$, $F(t_*)=a^{-5}$. Choose $\beta^2=a^{-5}$ and set $T_0=t-t_*$. Since $F'=a^3T_0^3$, at the two pole points
$w=\pm\beta\pm(2a^3/\beta)T_0^4+O(T_0^5)$. For $L_+=r_0+r_3\beta$, the polar coefficients of $z=(r_0+r_3w)^2/\ell^5$ at the plus point are
\[
A_+=L_+^2/a^5,\qquad B_+=4L_+r_3/(a^2\beta).
\]
The other forbidden polar terms vanish. Exact unramified AS matching is $B_+^5=-A_+$, with the analogous condition at the minus point. Since both $L_\pm\ne0$, the two conditions are
\[
r_3^5(r_0+r_3\beta)^3=a^5\beta^5,
\qquad r_3^5(r_0-r_3\beta)^3=-a^5\beta^5.
\tag{13}
\]
Putting $R_0=r_0/(r_3\beta)$ reduces them to $r_3^8(R_0+1)^3=1$, $r_3^8(R_0-1)^3=-1$, hence $R_0(2R_0^2+1)=0$. The solutions are $R_0=0$, $r_3^8=1$, or $R_0^2=2$, $r_3^8=3$. Taking the quotient by $s\mapsto-s$ leaves four functions in the first direction and the eight functions (1) in the other two. This is exact polar matching, not only jet vanishing.

Here is the connectedness distinction. Rewrite (12) as $F=(a^4-1)t^5+(4/a)(\ell^4-1)$, and put $g=\lambda/(a\ell)$, $c_0=\lambda(a^4-1)a^{-5}$. For the first direction $\lambda^4=1$,
$\lambda F/\ell^5=g^5-g+c_0$, so its AS cover is disconnected over algebraically closed $k$. For (1), $\lambda^4=3$, $\rho^2=2a^{-5}$, and
\[
\lambda(F+\rho^2)/\ell^5=g^5-g+c_0,
\qquad[z_{\lambda,\rho}]_{\rm AS}=[2\lambda\rho\,w/\ell^5]_{\rm AS}.
\tag{14}
\]
The last class is nonzero. If it were $b^5-b$, its pole divisor would force $b\in H^0(\mathcal O(E))$. This is a two-dimensional space of functions in $k(t)$ because $E$ is canonical. Its AS differences are in $k(t)$, whereas the displayed nonzero $w$ term is not. Thus all eight covers are connected and étale, with no further ramified point. Their AS classes differ by nonzero $\mathbf F_5$ multiples: ratios of allowed $\lambda$ lie in $\mathbf F_5^*$ and ratios of $\rho$ are signs. They have the same underlying scalar torsor. Relative twisting transports these exact identities and finite constants; it does not supply a new arbitrary root or entrywise coefficient identification.

## 3. Reference uniqueness, all connected pullbacks, and the two-source bound

The accepted invariant-carrier Picard proof supplies an ineffective invariant theta $\theta_C$ of degree eight, its genuine double lift, and $\operatorname{Pic}(C)^R=\mathbf Z[\theta_C]$. Its square is $\omega_C$ equivariantly. The genuine order-two deck lift of the central involution descends $\theta_C$ through the actual étale double cover $\pi:C\to H$ to $\Theta$ of degree four. Equivariant square descent gives EXACTLY $\Theta^2=\omega_H$. Write $\varepsilon_H$ for the nontrivial two-torsion defining $\pi$.

The accepted central extension presentation gives $H^2(H_0,k^*)=\mathbf F_2^2$: $\varepsilon_H$ has obstruction $\kappa\ne0$, and $\Theta$ has an obstruction independent of $\kappa$. The zero-obstruction equivariant Picard group for the actual weak/tame quotient is $\mathbf Z[\omega_H]$; this uses the [two-point wild Picard presentation](../quotient_geometry/local_actions/two_point_wild_orbifold_picard_group.md). Reducing an invariant line by $\Theta$ and $\varepsilon_H$ removes its obstruction, so
\[
\operatorname{Pic}(H)^{H_0}
=\mathbf Z[\Theta]\oplus C_2[\varepsilon_H],\qquad\Theta^2=\omega_H.
\tag{15}
\]
Degree and nontriviality of $\varepsilon_H$ give the asserted only relations. Moreover $0=h^0(C,\theta_C)=h^0(H,\Theta)+h^0(H,\Theta\varepsilon_H)$, so both invariant theta classes are ineffective. We use the geometric invariant Picard group, not a fixed subgroup scheme inferred from degrees.

The connected $D$ cover $H\to\mathbf P^1_u$ has Kummer character squareclasses supported among the five finite values, with even valuation at infinity. Their space is the four-dimensional even-subset space of $\mathbf F_2^5$. A squareclass of entirely even valuation on $\mathbf P^1$ is trivial over $k$, so there are no extra classes. Connected degree16 requires the FULL space and forces
\[
k(H)=k(u)\bigl(\sqrt{(u-b)/(u-0)}:b=1,2,3,4\bigr).
\tag{16}
\]
Any connected central étale double cover admitting lifts of all $H_0$ is defined by a nonzero invariant two-torsion line. Equation (15) permits only $\varepsilon_H$. Square-trivialization scalars give the same cover over $k$. Consequently the underlying reference $C\to\mathbf P^1_u$ is unique. This is not a uniqueness of marked groups, original $\Gamma$, or two-leg sources.

For a function (1), normalize the reference pullback along $u:Z_5\to\mathbf P^1$. The even finite indices kill tame inertia, so this is étale over $Z_5$. Its half-fibers $D_b=\tfrac12\operatorname{div}_0(u-b)$ have degree five. The map from the irreducible four-dimensional binary augmentation module to $J(Z_5)[2]$, given by differences $D_b-D_c$, has zero or full image. If it were zero, all ratios $(u-b)/(u-c)$ would be squares in $k(Z_5)$. Equation (16) would then embed the full degree16 field $k(H)$ into the degree10 extension $k(Z_5)/k(u)$, impossible since $16\nmid10$. Thus the monodromy maps onto $D$. A subgroup of the extraspecial $A_2$ mapping onto $D$ must be all $A_2$: otherwise it would be a complement to its nonzero commutator extension. ALL eight reference pullbacks are therefore connected, giving étale $R$-torsors of degree160 over $Y$ and separating degree-ten maps to $C$. Étale Hurwitz gives genus161. The original $T_R$ is precisely this normalized pullback by its equivariant full-degree square, not by a simultaneous endpoint Galois closure.

For $b\in\mathbf F_5^*$, scaling $u\mapsto bu$ preserves the full Kummer character space in (16), so lifts to an automorphism of $H$ normalizing $H_0$. It preserves the UNIQUE nonzero invariant torsion class $\varepsilon_H$ in (15), hence lifts to $C$ and normalizes $R$. Changing a square trivialization is harmless over $k$. Since $z_{b\lambda,\rho}=b z_{\lambda,\rho}$, the substitution $u'=bu$, coupled to this reference automorphism, identifies the underlying pullbacks over $Y$. It identifies all four $\lambda$ values for fixed $\rho$.

There is only one genuine simple four-module for $R$. With trivial center, semisimple restriction to $D$ has at most four character types; their permutation would give a prime-to-five quotient, so it is a single invariant type, necessarily trivial, leaving only one-dimensional cyclic-five simples. With nontrivial center, the extraspecial algebra has its unique four-dimensional simple, and extending over $C_5$ is unique: two normalized intertwiners differ by $\xi$ with $\xi^5=1$, hence $\xi=1$. Existence is the actual $U$. Thus every induced automorphism of $R$ preserves $U$. Its intertwiner can be chosen over $\mathbf F_5$: its linear equations have prime-field coefficients, and any nonzero solution is invertible by simplicity. Hence there are at most two underlying source/bundle classes, with their exact prime-field coefficient transport. Finally $\iota^*z_{\lambda,\rho}=z_{\lambda,-\rho}$, where $\iota(x,y)=(x,-y)$. This exchanges the two sources by base involution, without asserting their isomorphism over the identity of $Y$.

## 4. The canonical affine pullback and original Prym selection

The central anti-part $P^-=H^1(C_1,\mathcal O)^-$ has dimension $9-5=4$ and is the simple genuine $U$: restriction to the normal two-group has its unique nontrivial-central-character four-simple. Ordinarity makes its intrinsic Frobenius bijective. Its fixed character space has dimension four over $\mathbf F_5$ and is the same $U_0$.

For any of the degree-ten reference pullbacks, $\ker(r_1^*|_{P^-})$ is an $R$ submodule, hence zero or all. If all, the four étale AS characters vanish after pull. The AS sequence injects étale $\mathbf F_5$ cohomology into coherent cohomology on a connected projective curve, because constants' AS map is surjective over $k$. Thus $r$ would lift to their common-kernel cover $C_{\rm aff}\to C$ of degree625, forcing $625\mid10$. This is impossible. It proves the asserted injectivity on $P^-$, not arbitrary coherent pullback injectivity.

The monodromy of the pullback of $C_{\rm aff}$ is an $R$-stable subspace of its simple translation module $U_0^*\simeq U_0$, so zero or full. Zero would again give the impossible degree625 lift. Therefore the affine pullback is connected. All $H^i(R,U_0)$ vanish: the central order-two subgroup acts by minus one and has no invariants or higher cohomology in characteristic five. Consequently its extension group splits as $U_0\rtimes R$ by $H^2=0$, with conjugate complements by $H^1=0$. Its order is100000, and étale Hurwitz gives the stated genera5001 and100001. These are one-leg sources, whose degree-ten carrier map remains ramified.

Now use the ORIGINAL Cartesian $N$ square. For any connected étale $N$-torsor $W\to V$, coherent Cartan--Leray begins
\[
0\to H^1(N,k)\xrightarrow{j_V}H^1(V,\mathcal O)
\to H^1(W,\mathcal O)^N.
\tag{17}
\]
The two vertical torsors in (Q) have the SAME constants and natural maps, so $r_1^*j_{C_1}=j_{T_{R,1}}$. This proves injectivity of $r_1^*$ on their specified entire pull-kernel and identifies the two kernels canonically with $H^1(N,k)$. No order of $N$ or averaging over it is assumed.

Since $H^1(R,U)=H^2(R,U)=0$, inflation--restriction and actual coherent descent give
\[
H^1(G,U)=(H^1(N,k)\otimes U)^R,
\quad H^1(Y_1,E_U)=(H^1(T_{R,1},\mathcal O)\otimes U)^R.
\tag{18}
\]
Inject the first space into $(H^1(C_1,\mathcal O)\otimes U)^R$. The central plus component contributes nothing and the anti-component is ONE copy of $U$, so this latter space has dimension one. Nonzero $H^1(G,U)$ forces its image to fill that line; equivalently ALL of $P^-$ lies in $\ker\psi_1^*$. Naturality of (17) then identifies its coherent image exactly with $\mathcal L_r$ in (2). In particular $H^1(G,U)$ has dimension one. The line is bijective for the intrinsic Frobenius and has a prime-field fixed line.

The common kernel of these four anti AS characters defines the actual quotient $C_{\rm aff}$ of $\Gamma$. Its actual Cartesian pullback is the affine quotient of the original $T$. The unique class in $H^1(\widehat R,U_0)=\operatorname{Hom}_R(U_0,U_0)=\mathbf F_5$ selects its underlying finite-unit cover. In (N), $e_U$ is precisely the image of that original group class, so $e_J=v_*e_U$ is the original evaluation pushout. When the whole stable space on $Y_1$ is two-dimensional, other affine covers exist, but their different finite-unit lines do not replace this original one.

## 5. Mandatory fold quotient and the exact unresolved scalar

Hurwitz for $r$, compared with the genuine canonical identity descended in section1, gives
\[
r^*\omega_C=\mathcal O(D_r)=q_R^*\vartheta.
\tag{19}
\]
Its comparison is genuine because $R$ has no characters. The section $q_R^*\tau$ has divisor $D_r$; the actual differential inclusion $r^*\omega_C\to\omega_{T_R}$ is multiplication by this section, up to nonzero constant. This fixes the line-sections versus actual-differentials comparison.

The central anti-canonical forms $H^0(C_1,\omega)^-$ are the same simple $U$ of dimension four. Pulling them as LINE sections and using (19) gives the canonical map line $f_{\rm Prym}:E_U\to\vartheta_1$. The finite simple $E_U$ is stable of degree zero. A nonzero rank-one image is a proper quotient of strictly positive integer degree and sits in a degree-one line, so has degree one with no defect: the map is surjective. Its kernel $G_3$ has rank three and degree $-1$, and is stable because every proper rank-$s$ subbundle has negative integer degree, hence slope at most $-1/s<-1/3$.

For the selected unit define $\nu=f_*e_U$. The target has dimension one. The actual AS class annihilates $\eta$ of divisor $E_1$, while the dual of theta multiplication is the section $\tau_1^2$ of divisor $2P_{0,1}\ne E_1$. Hence $\tau_{1*}a_5\ne0$. Its actual $p_1$ pull is zero because $p_1^*a_5=0$, so the entire one-dimensional $H^1(\vartheta_1)$ pulls to zero. Therefore (4) defines one definite scalar up to allowed nonzero normalizations; its zero status cannot be obtained by cancellation through $q_{R,1}$.

Under (N), applying $\operatorname{Hom}(-,\vartheta_1)$ to $0\to E_U\to E_{Z_{\rm net}}\to\mathcal O\to0$ gives the exact criterion $f$ extends if and only if $f_*e_U=0$. The lifts differ by $H^0(\vartheta_1)=k\tau_1$ and remain surjective. Their coefficient maps from $Z_{\rm net}$ to the pulled section space are injective: a nonzero kernel contains its unique socle $U$, whose evaluation is nonzero. Thus for $B_g=\ker(E_{Z_{\rm net}}\to\vartheta_1)$,
\[
\operatorname{rk}B_g=4,\quad\deg B_g=-1,\quad
H^0(T_1,q_1^*B_g)=0,\quad0\to G_3\to B_g\to\mathcal O\to0.
\tag{20}
\]
Any degree-zero subbundle of the finite semistable $E_{Z_{\rm net}}$ pulls to a constant subspace of its trivial source bundle and descends to a genuine submodule. Every such nonzero submodule contains $U$, so none lies in $B_g$. Its proper subbundles therefore have negative integer degree, proving stability. The same constant-relation argument after a component of ANY finite curve pull of the actual torsor shows $H^0(C',h^*B_g)=0$ for every finite surjective $h:C'\to Y_1$. In particular the specified class in (20) survives every such pull: a splitting would give a unit section of $h^*B_g$.

For completeness, $B_g^*$ is ample. On the actual torsor it is a globally generated quotient of $\mathcal O^5$. A positive-dimensional fiber of its tautological morphism would contain a curve finite over the base (the restriction to each projective fiber is an embedding). Its corresponding quotient would make a nonzero constant relation in the dual kernel after that finite base pull, contradicting the vanishing just proved. The tautological morphism is thus finite and its pullback of $\mathcal O(1)$ ample. Ampleness descends through the finite torsor. No strong stability or numerical Frobenius bound is asserted for $B_g$.

The carrier's full canonical nine-space $V_C$ embeds in $H^0(T_1,q_1^*\vartheta_1)$. It has no invariants: averaging over $A_2$ descends invariant regular differentials to $C/A_2=\mathbf P^1$, with no poles at tame index-two points. Thus the invariant $q_1^*\tau_1$ adds one section, giving ten. If $\nu=0$ under (N), the injected five-module $Z_{\rm net}$ intersects $V_C$ exactly in $U$. Otherwise it would lie entirely in $V_C$ and factor through $R$, contrary to $H^1(R,U)=0$. Their sum has dimension ten and no invariants: its extension by $k$ is nonsplit since $U\subset V_C$ is split by central-character projection. The invariant theta section is outside that sum, giving eleven.

## 6. Naturality of the selected line and the fold zero status

The reference scaling lift in section3 preserves the central involution, both anti-carrier spaces and their Frobenius-fixed AS character space. It therefore transports the canonical affine cover and its selected coherent line. Its induced $R$ automorphism and prime-field intertwiner transport $E_U$, its coefficient Frobenius and the canonical anti-form map. The genuine different comparison (19) changes at most by a nonzero scalar. Hence it preserves whether $\nu$ is zero.

The hyperelliptic involution fixes $P_0$ and exchanges the two signs in (1). Use its actual relative twist $\iota_1$ and the natural underlying comparison $\iota_1^*\vartheta_1\simeq\vartheta_1$. The corresponding source, reference carrier map, selected affine unit and fold map all transport functorially. Thus the two signs have the same fold-zero status and the same intrinsic Frobenius ranks. This is comparison under base involution, not an identification of sources over the identity map of $Y$.

## 7. Downstairs stable duality and the genuine $r_{\rm nil}=3$ gate

Put $V=H^1(Y_1,E_U)$, $W=H^0(Y_1,E_U^*\omega)$ and $h_\theta=\tau_1f_{\rm Prym}\in W$. The genuine $\mathbf F_5$ local system defines the intrinsic absolute coefficient Frobenius $\Phi$ and coefficient Cartier operator $\mathcal C$. Their Serre adjunction is
\[
\langle\Phi v,w\rangle=\langle v,\mathcal Cw\rangle^5.
\tag{21}
\]
The selected $e_U$ is in the bijective part by (2). So is the NONzero $h_\theta$. To see this without scalar descent, pull its coefficient differentials through the actual étale $q_{R,1}$: by (19) they are the differential pulls of the carrier anti-canonical forms. Cartier commutes with separating differential pull, is bijective on those forms because $C$ is ordinary, and preserves the one-dimensional intertwiner line because $U$ has its prime-field model. Its pull map on sections is injective. Therefore the line $kh_\theta$ is bijective downstairs. This proves a local Cartier statement, not an upstairs scalar pairing division by160.

For generalized semilinear Fitting decompositions, $V_{\rm nil}$ pairs trivially with $W_{\rm bij}$ by iterating (21) and taking inverse Cartier iterates of the second vector. Adjoint powers have equal ranks, so the two bijective dimensions agree and their restricted Serre pairing is perfect. If that dimension is one, nonzero $e_U$ and $h_\theta$ pair nontrivially. By duality of the fold pushout this is exactly $\nu\ne0$.

Only now use the accepted EXACT SAME evaluating symplectic Raynaud source and nonzero SAME-socle cohomology. Its parity proof gives $h^1(E_U)=4$, $\dim\ker\Phi=2$ and the nilpotent possibilities $(1,1)$ or $(2,1)$, of dimensions two or three. Accordingly the bijective dimension is two or one. The latter forces nonzero $\nu$. In the former a nonzero vector and nonzero stable functional may still be orthogonal; no vanishing or nonvanishing is inferred there. Neither this gate nor the canonical trace below forces a fold extension to exist.

## 8. The entire different trace and the exact wild scalar row

Let $M_\theta=H^0(Z_{5,1},p_1^*\vartheta_1)$. Its $C_5$ invariant space is $k\tau_1$, so its module is a single Jordan block of length at most five. If its length exceeded one, its invariant vector $p_1^*\tau_1$ would lie in $(\sigma-1)M_\theta$. The map from $H^1(C_5,k)$ into
$H^1(C_5,M_\theta)=\ker(1+\cdots+\sigma^4)/(\sigma-1)M_\theta$ would kill the AS class. The injective coherent Cartan--Leray edge and its naturality with theta multiplication identify its image with the NONzero $\tau_{1*}a_5$, a contradiction. Hence $M_\theta=k\tau_1$ with trivial action. Its Euler characteristic is zero by genus six and degree five, so its $h^1$ is also one.

Write $W_D=H^0(T_{R,1},\mathcal O(D_{r_1}))$. Genuine tame descent gives $W_D^{A_2}=M_\theta=kq_{R,1}^*\tau_1$. Under (19), that section is constant rational1 in $\mathcal O(D_{r_1})$, up to a nonzero scalar. The inverse-different trace $W_D\to H^0(C_1,\mathcal O)=k$ is $A_2$-equivariant with trivial target. Averaging ONLY over the order32 group reduces it to this invariant line; its trace on1 is $\deg r=10=0$. It is therefore zero on the ENTIRE $W_D$. Nothing averages over the wild quotient, original $N$, or all $R$.

There is also an exact cohomological check. The nonzero invariant tensor $e_C\in(P^-\otimes U)^R$ and carrier intertwiner $f_C:U\to H^0(C_1,\omega)^-$ are isomorphisms. Their contraction through central-anti Serre duality gives a nonzero $\xi_C\in H^1(C_1,\omega)$: the composition is $\lambda\operatorname{Id}_{U^*}$ and its trace is $4\lambda\ne0$. Naturality gives $r_1^*\xi_C=q_{R,1}^*\nu=0$ by section5. Thus the entire one-dimensional canonical coherent pull map is zero, whose dual is the same full different trace. It does NOT make $\nu$ zero, since that target already has zero actual wild pull.

Finite relative duality identifies the dual of the unit $\mathcal O_{C_1}\to r_{1*}\mathcal O_{T_{R,1}}$ with the sheaf different trace. The unit is a line subbundle of a finite flat algebra, so the SHEAF trace is surjective. A global retraction would give a global section of nonzero trace, impossible. The specified boundary of this auxiliary trace extension is consequently nonzero and its actual $r_1$ pull splits by the multiplication counit. This is an auxiliary one-leg extension, not the original net.

Finally exact invariants under $A_2$ give $H^1(R,W_D)=H^1(C_5,k)\tau_1$. Its coherent Cartan--Leray edge is an isomorphism onto $H^1(Y_1,\vartheta_1)$: it is injective and sends the AS basis to nonzero $\tau_{1*}a_5$, between one-dimensional spaces. Represent $\nu$ by a downstairs Čech cocycle. Its actual $p_1$ pull is a coboundary, so choose a primitive $b$. Then $\sigma b-b$ is a GLOBAL section, necessarily $c_{\rm Prym}p_1^*\tau_1$ with the chosen edge sign. Global changes of primitive have trivial wild action and change no coefficient; downstairs representative changes are pulled invariant and likewise change none. A primitive on the full torsor may first be averaged over $A_2$, then this wild difference taken. This is the exact unresolved scalar detector.

## Scope and frozen inputs

The canonical fold theta is fixed by the actual different. It is not an annihilator inverse selected by degree. The original finite unit is fixed by the actual Cartesian Prym kernel and only its specified evaluation gives the original $e_J$. A different stable class or an annihilator lift cannot supply that unit. The scalar in (4), its possible minimum-net extension, original positive-source lifting and arbitrary retained-packet extraction remain separate. Both original actual finite étale maps stay on SAME $T$; none is furnished on an auxiliary carrier or quotient. The package applies to ANY original positive representation dimension supplying these hypotheses, and makes no unrestricted common-cover exclusion. The uniform ineffective-theta Schubert branch is deliberately outside this statement.

Frozen NEW input/audit pairs, retained without numerical replay:

| Source | Source SHA256 | Independent PASS audit | Audit SHA256 |
|---|---|---|---|
| [Actual canonical AS theta family](../../Research/notes/oct03_ten_hour/actual_four_source_canonical_as_theta_family.md) | `970d196d9f1825f98b345f9eb44f63de85a843f5629aefd21cba29ce88ae0847` | [AS-family audit](../../Research/notes/oct03_ten_hour/actual_four_source_canonical_as_theta_family_audit.md) | `cd9dc7fd8ff895991c44274e7fce7f5a2345cc15434f626a51cb972c43696b56` |
| [Humbert theta/reference uniqueness](../../Research/notes/oct03_ten_hour/self_dual_four_humbert_theta_and_source_family.md) | `9b854e5e1758b254a4f2996f9227b3a856350d07cdfed0da79420f8c3d978421` | [Humbert audit](../../Research/notes/oct03_ten_hour/self_dual_four_humbert_theta_and_source_family_audit.md) | `5b3b872f1c8346e5bc82eaa13d882ad60cf9200d153d8ba0b841d96d97e2993a` |
| [Fixed eight AS functions](../../Research/notes/oct03_ten_hour/fixed_backup_actual_source_eight_as_functions.md) | `de654b7a02dc39cca92143c0d73eb3b2d7ab8522e86c95a5b5efc8e97480b80e` | [Fixed-list audit](../../Research/notes/oct03_ten_hour/fixed_backup_actual_source_eight_as_functions_audit.md) | `159ec8d05643ec8ed0398c6a63b407fd12f9df10099a093a6d2e1bd8d4232008` |
| [Connected sources/affine unit](../../Research/notes/oct03_ten_hour/canonical_as_connected_sources_and_prym_affine_unit.md) | `bb593b63a0a368e6fee567be12c9b3e6ab015b4a8a95159e68598117ad2e3cec` | [Connectedness audit](../../Research/notes/oct03_ten_hour/canonical_as_connected_sources_and_prym_affine_unit_audit.md) | `d0f11f9ea120596edad3cd22778e88d96ee146f301664ffc1f8c435f7fbe1ccd` |
| [Original selected Prym class](../../Research/notes/oct03_ten_hour/original_minimum_net_carrier_prym_cohomology.md) | `38707e5e16bff75dc31b7687fbf438e6807afafe32cac4b1b296f650f9d409dd` | [Prym bridge audit](../../Research/notes/oct03_ten_hour/original_minimum_net_carrier_prym_cohomology_audit.md) | `7217834a0d8feb3024fd1e0b5941e195a53c75d8ec662ad612cb7b3e91ad465a` |
| [REPAIRED fold/scalar source](../../Research/notes/oct03_ten_hour/original_prym_fold_theta_quotient_and_net_trace.md) | `05f16aacdb18b3474459a71ec372ac1642609bdb0a39df59e733b7b798d4822c` | [Repaired fold audit](../../Research/notes/oct03_ten_hour/original_prym_fold_theta_quotient_and_net_trace_audit.md) | `7234fed1f92878cf13ed01f5e78e81c2c672d75205b5c31cf322a4d9a20bfbd0` |
| [Two sources/stable scalar](../../Research/notes/oct03_ten_hour/self_dual_four_two_sources_and_stable_fold_scalar.md) | `e011a1210e2a596826be210cc30af423f39cd7c98a6d7cd98661761df7b30f72` | [Two-source audit](../../Research/notes/oct03_ten_hour/self_dual_four_two_sources_and_stable_fold_scalar_audit.md) | `d8dfb1f43cc4dcc5dbc859011430086844a11ac3bbb4b973096cc60fa3c8bef4` |
| [Full different trace/wild scalar](../../Research/notes/oct03_ten_hour/actual_carrier_different_trace_and_wild_fold_scalar.md) | `e329f8f7eea92c6e04feb11a76b9bba35d116e3e81e13a36e3b2be133661d181` | [Trace/wild-row audit](../../Research/notes/oct03_ten_hour/actual_carrier_different_trace_and_wild_fold_scalar_audit.md) | `a736824974eee09c8af031f66f8fa475fef07579310086af67cc15a5d51dc9ec` |

Focused accepted dependencies additionally frozen for this extraction:

- Genuine-source proof SHA256 `0b77844ee76c676f626dcbca4598ea25aa1bbf6819afebe02a6d1cb7afdb53fb`; finite self-dual Raynaud-source proof `351fd489c38c433aeda275e7ddd80fa9e34fd471550772624b99399488ad3708`; genuine evaluation/lift proof `3bb3015f4d17dea7602445c04cd0c37a85a03ac89049540240862740dd2e97b2`.
- [Invariant carrier theta/Picard source](../../Research/notes/oct03_ten_hour/self_dual_four_invariant_theta_and_kernel_divisibility.md) `d69867d5689b443267c7b6baa908bf8306b324cd6fcb7e1347c042a0aa6b2e2b`, [PASS](../../Research/notes/oct03_ten_hour/self_dual_four_invariant_theta_and_kernel_divisibility_audit.md) `405d9c301c704c0bde88f14582ed2ee542307bed14a83b0ae83b0bba4c59dcb0`.
- [Ineffective invariant carrier theta](../../Research/notes/oct03_ten_hour/self_dual_four_invariant_theta_ineffective.md) `4b4b08250c2f3201362fbed142be5708dc0acd51d872c095b3630615da42ce80`, [PASS](../../Research/notes/oct03_ten_hour/self_dual_four_invariant_theta_ineffective_audit.md) `62171e714cdbc50c9cadacae68b682c6d3c9b02bd9f6508a880f7491200ac4c7`.
- [Actual self-dual carrier](../../Research/notes/oct03_ten_hour/genuine_self_dual_four_carrier.md) `27e97c8e1b29db5be472d7a313f6f7a4f1522440b459eb0fff57fa2199d18885`, [PASS](../../Research/notes/oct03_ten_hour/genuine_self_dual_four_carrier_audit.md) `fb3cbc7633ef9eeb40b66557dd719e1fd5ab4052c33bf1982ebfb7cb3cdb063d`.
- Wild quotient Picard proof `d4e83f070595303eb26c40969b4839012189065a9b135e4baa3e2a602adceae3` at the linked canonical proof in section3.

The rejected initial fold source `3af99094f31077767a51b9ad2a9e2b0a3161fbf6c91cf554e90f3a4e6e1706ca` is NOT an input. Its unsupported descent of degree-ten trace zero to $\nu=0$ is specifically avoided in sections5,7,8. All section bounds and stable-kernel consequences that need $\nu=0$ retain it explicitly. No independent numerical or marking certificate is transferred.
