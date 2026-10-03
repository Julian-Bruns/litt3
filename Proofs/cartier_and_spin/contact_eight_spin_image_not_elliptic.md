# Proof: exclusion of an elliptic normalized spin image

Version2,2 October2026. The original contact-eight whole implication passed [independent review](../../Research/audits/CONTACT_EIGHT_ELLIPTIC_SPIN_IMAGE_AUDIT_2026_10_02.md). The proof below uses only the general antecedent D=2Q; that isolation passed [focused extension review](../../Research/audits/ACTUAL_SPIN_EXTRACTION_EXTENSIONS_REVIEW_2026_10_02.md). [Statement](../../Theorems/cartier_and_spin/contact_eight_spin_image_not_elliptic.md).

## Exact raw jet image and normalization

Use the accepted actual sixteen-spin and raw first-jet results. The span W generates L and its dimension is divisible by eight. Assume its general descended critical divisor is D=2Q, so its RAW jet image P_T has exact common critical divisor2q*Q. The contact-eight theorem is one way to supply this hypothesis; nothing else below uses that contact or trace degree. In particular
\[
\deg P_T=18d-16d=2d.
\]
Let φ:T→Γ be the map to the normalization of the projective image. It is separating: a ratio of actual infinity sections has a simple zero or pole, so cannot be a fifth power. Let κ=degφ and let M be the induced hyperplane line onΓ, with L=φ*M, degM=δ, d=κδ. The same W generates M. Write P_Γ for its raw first-jet image and R_Γ for its effective common critical divisor.

The chain-rule map φ*J¹M→J¹L is an injective map of rank-two bundles: in local coordinates its determinant is dφ, which is a nonzero element of the function field because φ is separating. It sends the pulled generating columns to their actual jet columns. Hence it restricts to an isomorphism of φ*P_Γ onto P_T as abstract bundles, even at ramified points. Do not saturate either image. Consequently
\[
2d=\kappa\deg P_\Gamma
=\kappa\bigl(2\delta+2g(\Gamma)-2-\deg R_\Gamma\bigr).
\]
It follows that degR_Γ=2g(Γ)−2. Effectivity gives g(Γ)≥1.

Suppose Γ is elliptic. Then R_Γ=0. The determinant chain rule gives R_W=R_φ+φ*R_Γ, where R_φ is the different divisor of the separating curve map. Therefore
\[
R_\varphi=2q^*Q.
\]
If δ_Γ is a nonzero invariant elliptic differential, η=φ*δ_Γ is a nonzero regular differential onT with EXACT divisor2q*Q.

## Actual semi-invariant differential and root cover

The actual deck group G acts projectively on W and hence on its projective image and normalizationΓ; φ is G-equivariant. Every elliptic automorphism acts on invariant differentials through its linear part. In characteristic five this character has order
\[
a\in\{1,2,3,4,6\}.
\]
Translations act trivially. In characteristic different from2and3, an origin-fixing automorphism of a short Weierstrass model x³+Ax+B is x↦λ²x,y↦λ³y, with Aλ⁴=A and Bλ⁶=B; thus its differential character has order2,4or6. Hence g*η=χ(g)η for an actual characterχ of ordera, which is prime to five.

The tensor ηᵃ is G-invariant and descends through the actual étale torsor q to a nonzero tensor s∈H⁰(Y,ωYᵃ), with
\[
\operatorname{div}s=2aQ.
\]
More concretely choose a nonzero rational canonical frame ξ onY and write η=f q*ξ. Then fᵃ is a rational function onY, and its Kummer equation gives the actual normalized a-root cover ofs. Its divisor is divisible bya, so the cover is étale. The character-kernel quotient T/kerχ is that connected root component: the eigenfunction f has faithful character and generates the degree-a cyclic subextension. This is an actual intermediate quotient retaining the original source comparison, not an invented separable replacement. Cartier commutes with the separating pullbacks in use here; a Cartier-zero η gives a Cartier-zero tautological root differential.

## Supersingular elliptic images are excluded

If Γ is supersingular, Cartier(δ_Γ)=0, and therefore Cartier(η)=0. The settled [all-weight singleton Cartier-zero root exclusion](../../../Theorems/jacobians/torsion/family_singleton_root_exclusion.md), assertion2, excludes a tensor s of divisor2aQ with Cartier-zero differential on its actual étale a-root cover, for EVERY prime-to-five weighta and arbitraryQ. It applies to the selected family endpoint and the cubic backup, including WeierstrassQ and disconnected ambient torsors. This is an immediate contradiction. No six- or twelve-torsion Abel classification is required.

## Ordinary elliptic images are excluded

If Γ is ordinary, its invariant differential is a nonzero Cartier eigenform. Moreover its origin-fixing automorphism character has ordera∈{1,2,4}: the exceptional order3or6 case has j=0, with model y²=x³+1. Its Cartier scalar is the coefficient of x⁴ in (x³+1)², which is zero in characteristic five, so that model is supersingular. From divs=2aQ and ωY∼2O_Y one obtains
\[
2a[Q-O_Y]=0.
\]
Since2a divides8, the settled eight-torsion Abel theorem forcesQ to be Weierstrass on both endpoints. For MAIN this is [family_small_torsion_specialization](../../../Theorems/jacobians/torsion/family_small_torsion_specialization.md), whose parameter-degree hypothesis is already met. For BACKUP it is the accepted [backup arithmetic](../../../Theorems/curve_arithmetic/backup_curve_arithmetic.md), whose two-primary Abel points are exactly the Weierstrass classes.

Choose a canonical differential ζ onY with divisor2Q. The ratio η/q*ζ has zero divisor, so is a constant. Thus η descends to a constant multiple ofζ, even if the originally displayed character had a larger order. Cartier functoriality and the elliptic eigenform identity now makeζ a nonzero Cartier eigenform. The settled family theorem excludes every regular double-zero Cartier eigenform, including eigenvaluezero, for every admissible family parameter; the backup satisfies the same assertion. This is the final contradiction.

Both elliptic cases are impossible, and genuszero was already excluded by the exact raw determinant identity. Hence g(Γ)≥2. Nothing in this proof bounds that genus, identifiesΓ with an actual X field, or excludes the remaining noncyclic contact-eight source.
