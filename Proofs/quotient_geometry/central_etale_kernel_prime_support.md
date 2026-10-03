# Proof: split central quotients and unchanged local inertia

Version1,3 October2026. [Statement](../../Theorems/quotient_geometry/central_etale_kernel_prime_support.md). [Root whole-proof review PASS](../../Research/audits/CENTRAL_ETALE_KERNEL_AND_HUMBERT_CLOSURE_AUDIT_2026_10_03.md). No computation or ordinarity input is needed.

Since J is central it is abelian. If a primeℓ∤|V| divides |J|, choose a surjective character χ:J→Cℓ. Its kernel is normal in E. Thus H′=Γ′/kerχ is a smooth connected actual finite étale Cℓ cover of H, with central extension E′=E/kerχ of V by Cℓ.

Finite-group cohomology gives H²(V,Cℓ)=0, since multiplication by |V| is invertible on Cℓ. The extension splits. The splitting is UNIQUE because H¹(V,Cℓ)=Hom(V,Cℓ)=0. Consequently
\[
E'=\widetilde V\times C_\ell,
\qquad \widetilde V\simeq V.
\]

Put R=H′/Ṽ. Its map R→H/V=P¹ is connected, Galois, and of degreeℓ. We show it is ÉTALE without assuming that V-inertia is tame.

Fix x∈H and let V_x be its stabilizer. Its unique lifted subgroup Ṽ_x acts on the étale Cℓ-torsor fiber above x. It commutes with the regular Cℓ action. Every automorphism of a regular torsor commuting with that action is a translation. This gives a homomorphism V_x→Cℓ, necessarily trivial because their orders are coprime. Therefore EVERY point w above x is fixed by Ṽ_x.

The point stabilizer E′_w injects into V_x, since the Cℓ action of the étale H′→H leg is free. The preceding paragraph supplies the entire subgroup Ṽ_x inside it. Hence
\[
E'_w=\widetilde V_x.
\]
Its image in the quotient deck group E′/Ṽ=Cℓ is trivial. Thus the actual Galois map R→P¹ has trivial inertia at EVERY point and is finite étale. Equivalently, étaleness of H′→H identifies their completed local fields; after the two identical lifted stabilizers are divided out, the completed local extension on R→P¹ has degreeONE. This includes wild inertia and primesℓ equal to the characteristic.

A connected finite étale cover of P¹ of degreeℓ>1 cannot exist: Hurwitz would give2g(R)−2=−2ℓ. This contradiction proves the prime-support assertion.
