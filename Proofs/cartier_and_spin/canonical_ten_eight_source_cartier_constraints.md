# Proof: stable original descent and a forbidden determinant fifth root

Version1, 3 October2026. Independent bounded mathematical review [PASS](../../Research/audits/OCT03_EIGHT_SOURCE_STABILITY_AND_CARTIER_AUDIT.md); its literal Frobenius corrections are applied. No computation.

## Use the actual free source for descent

Use Y₁=Y^(1), T₁=T^(1), q₁=q^(1), and the retained Λ with F_T*Λ=L⁵. In particular FIVE degΛ=FIVE degL, so degΛ=N/EIGHT. The original coefficient action on V₈ has the inverse multiplier to Λ². Thus V₈⊗Λ² has the given genuine original G-action onT₁. The Frobenius-twisted free finite étale q₁:T₁→Y₁ is still an actual G-torsor, so this bundle descends to A₈ onY₁. The ORIGINAL integral source surjection descends to A₈→K. Its rank isEIGHT and its degree isEIGHT degΛ²/N=TWO. This is effective faithfully flat descent along the specified torsor. It does not average over G, so FIVE-divisibility of |G| causes no problem. No auxiliary coefficient-trivialization cover or identification of Λ with a different root is introduced.

Pullback along q₁ trivializes the projective coefficient part, giving eight copies of the SAME line Λ². For the first relative Frobenius pull, the exact étale Frobenius square gives q*F_Y*A₈=W₈⊗L¹⁰. To describe every iterate without identifying scalar twists, put Y_e=Y^(1−e), T_e=T^(1−e) and pull A₈ along the composite relative Frobenius Y_e→Y₁. The corresponding q_e:T_e→Y_e are the actual twists of the original torsor. At each step basechange of the specified étale q is again an étale G-torsor, and the relative Frobenius square is Cartesian. Pulling back the original descent isomorphisms gives the genuine G-action at that stage. The paired multipliers are pulled back together and still cancel; no new G-action on an unidentified root is presumed. The common line is the actual corresponding Frobenius pull of Λ². With the retained ORIGINAL coefficient calibration the constant module is V₈^[5^e]; this is not an entrywise-power assertion for an unlabelled constant representation under a relative k-morphism. These modules remain irreducible because coefficient Frobenius is an automorphism of the perfect k: a proper invariant subspace after coefficient Frobenius would pull back to one before it. Scalar twists of the paired lifts do not change invariant subspaces. Each torsor pullback is a direct sum of one line, hence semistable. A destabilizing subbundle downstairs would pull back with degree multiplied by the torsor degree and rank unchanged, and would destabilize this direct sum. Thus each descended Frobenius pull is semistable.

Suppose a proper subbundle B of one of these descended bundles attained the same slope. Pulling back along its actual torsor and tensoring by the inverse common line, B becomes a degreeZERO subbundle of a trivial rankEIGHT bundle on that smooth connected projective source. Such a subbundle is constant: choose a generically invertible projection onto r coordinate factors; its determinant has degreeZERO and is nonzero, so it is an isomorphism everywhere. The resulting inclusion matrix has global regular coefficients, hence constant coefficients. This is an actual r-dimensional constant subspace, not just a fiber at one point. The genuine original descent datum preserves the pulled-back subbundle; after canceling its common line, the actual coefficient-Frobenius projective G-action preserves this constant subspace. Scalar rescaling has no effect on its preservation. Irreducibility forces r=ZERO orEIGHT, contradicting propriety. Therefore every Frobenius iterate is stable, proving strong stability of A₈.

## The small-degree quotient and kernel

Every proper torsion-free quotient Q of the stable A₈ has μ(Q)>ONE/FOUR. If K had a destabilizing rankONE orTWO subbundle of degree at leastONE, its quotient would respectively have rankTWO orONE and degree at mostZERO. It would also be a quotient of A₈, contradicting this strict slope bound. A rankTHREE degreeONE bundle has no equality-slope proper subbundle by integrality of degree. Hence K is stable.

The kernel C₅ has rankFIVE and degreeONE. Any rank r≤FOUR subbundle of C₅ is a proper subbundle of A₈, so its degree is strictly less than r/FOUR. For all r=ONE,…,FOUR its degree is therefore at mostZERO. This is strictly less than r/FIVE, proving stability of C₅.

The first Frobenius pull F_Y*C₅ has rankFIVE and degreeFIVE. It is a subbundle of the stable rankEIGHT degreeTEN F_Y*A₈. A rank r≤FOUR subbundle consequently has degree strictly less than FIVE r/FOUR. For r=ONE,TWO,THREE,FOUR the integer upper bounds are respectivelyONE,TWO,THREE,FOUR. They are at most r, so F_Y*C₅ is semistable of slopeONE. No higher Frobenius semistability of C₅ is asserted.

## Cartier evaluation has no zero divisor

The actual embedded K⊂B_Y has its nonzero Frobenius-adjoint evaluation λ_Y:F_Y*K→ωY. Its image is the line bundle ωY(−D) for an effective divisorD. The ORIGINAL horizontal source is the Frobenius pull of A₈→K, so this image is a rankONE quotient of the stable degreeTEN rankEIGHT F_Y*A₈. Thus
\[
2-\deg D=\deg\omega_Y(-D)>5/4.
\]
Since degD is a nonnegative integer, degD=ZERO. Therefore λY is surjective and its rankTWO kernel has degreeFIVE−TWO=THREE.

On the actualT, the original scalar calibration identifies F_T*(V₈⊗Λ²) with W₈⊗L¹⁰, and λY pulls to the ORIGINAL adjoint evaluation into ωT=L¹⁶. Dividing by L¹⁰ gives the actual constant-section surjection W₈O_T→L⁶. Thus all scalar adjoint basepoints are removed by the original source argument, independently of any integral Γ image or of ℓ(q₁).

## The rank-three power relation is nonhorizontal

Now assume the rankFOUR zero-Gram confinement case. Its original lift surjects onto J₅=M⁶F₄. Since detF₄=ωΓ⁻², the exact relation sequence gives
\[
\det R=(\det J_5)^{-1}=M^{-30}\omega_\Gamma^2
\]
under the determinantONE normalization of the coefficient source. This is the retained paired scalar identity; Hom(G,k×)=ZERO removes its genuine character ambiguity.

Suppose R were preserved by the constant connection on W₈OΓ. Cartier descent then gives a rankTHREE R₁⊂V₈OΓ^(1), with FΓ*R₁=R. The original paired calibration makes R₁⊗(M^(1))² a GENUINELY native bundle onΓ^(1). Its determinant has genuine native Frobenius pull
\[
F_\Gamma^*\det\bigl(R_1\otimes(M^{(1)})^2\bigr)
=\det R\otimes M^{30}=\omega_\Gamma^2.
\]
Its degree would be TWO N/FIFTY. Every genuinely native line onΓ^(1) has degree in(N/TEN)Z, because the actual orbit sizes remain N/FIVE,N/TWO,N under relative Frobenius. TWO N/FIFTY is not in that lattice. Thus R cannot be horizontal. The determinant root stays onΓ^(1); no unidentified coefficient-conjugate endpoint is used.

For a local relation c=Σc_iw_i inR, the ACTUAL scalar row relation is Σc_ib_i=ZERO onT. If a(φ*R)=ZERO, horizontality gives a(dφ*c)=ZERO and evaluation gives Σdc_ib_i=ZERO. Because dc has Γ coefficients, this places dc in the Γ relation R. Hence R would be horizontal, a contradiction. Therefore a(φ*R)≠ZERO.

On H=kerλ the intrinsic first jet is O-linear and independent of any auxiliary connection on L⁶. Differentiation gives
\[
j_1\lambda(a(c))=-\sum_i dc_i b_i.
\]
If this vanished for all c, the same Γ relation argument would preserve R under the constant connection. Thus this first-jet map is nonzero. This proves no rank lower bound greater thanONE for a(φ*R).

## Its map descends to the original Y

The paired source action makes R M¹⁰ genuinely native onΓ. Its pullback φ*R L¹⁰ descends along the actual free q to E_R onY. Its determinant is
\[
\phi^*(\det R\,M^{30})=\phi^*\omega_\Gamma^2
=\omega_T=q^*\omega_Y.
\]
The identities are native, so descent gives detE_R=ωY. The rank remainsTHREE. Multiply the original horizontal a by L¹⁰. Its target becomes q*F_Y*K, and the original scalar relation places its image in q*H_Y. Equivariance descends this SAME nonzero map to α:E_R→H_Y. Its first jet is nonzero by the preceding argument. No power quotient is identified with E_R orH_Y, and both original finite étale endpoint maps remain onT.
