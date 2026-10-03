import Solutions.Deformations.WeightedRootHomogeneousKernel
import Solutions.Deformations.WeightedRootScalingExtension

namespace Litt3.Deformations

variable {k R K : Type*} [Field k] [CommRing R] [Nontrivial R] [Field K]

/-- Original coefficients and original rational directions suffice:
anisotropy is verified before either extension of scalars. -/
theorem weighted_root_coefficient_homogeneous_kernel
    (F : Type*) [Field F] [Fintype F] [DecidableEq F]
    (β : k →+* R) (φ : R →+* K) (injective : Function.Injective φ) (ψ : F →+* k)
    (tau : R) (c : K) (root : c ^ (Fintype.card F - 1) = -(φ tau))
    (nonzero : c ≠ 0) (r n : ℕ) (positive : 0 < n)
    (p : MvPolynomial (Fin r) k) (homogeneous : p.IsHomogeneous n)
    (anisotropic : ∀ a : Fin r → F, a ≠ 0 → p.eval (fun i => ψ (a i)) ≠ 0)
    (x : weightedRootProduct R (Fintype.card F) tau r) :
    weightedRootPolynomialEvaluation (Fintype.card F) tau r (MvPolynomial.map β p) * x = 0 ↔
      ∃ a : R, x = a • weightedRootProductNorm (Fintype.card F) tau r := by
  apply weighted_root_homogeneous_integral_kernel F φ injective ((φ.comp β).comp ψ)
    tau c root nonzero r n positive (MvPolynomial.map β p) (homogeneous.map β)
  intro a nonzeroDirection
  rw [MvPolynomial.eval₂_map]
  change p.eval₂ (φ.comp β) ((φ.comp β) ∘ (fun i => ψ (a i))) ≠ 0
  rw [← MvPolynomial.eval₂_comp]
  exact (map_ne_zero (φ.comp β)).mpr (anisotropic a nonzeroDirection)

/-- The scaling extension and its root are constructed, so the actual
integral kernel theorem requires only the source homogeneous polynomial,
its original finite-field anisotropy, and a nonzero parameter. -/
theorem weighted_root_original_homogeneous_kernel
    (F : Type*) [Field F] [Fintype F] [DecidableEq F] [IsDomain R]
    (β : k →+* R) (ψ : F →+* k) (tau : R) (nonzero : tau ≠ 0)
    (r n : ℕ) (positive : 0 < n)
    (p : MvPolynomial (Fin r) k) (homogeneous : p.IsHomogeneous n)
    (anisotropic : ∀ a : Fin r → F, a ≠ 0 → p.eval (fun i => ψ (a i)) ≠ 0)
    (x : weightedRootProduct R (Fintype.card F) tau r) :
    weightedRootPolynomialEvaluation (Fintype.card F) tau r (MvPolynomial.map β p) * x = 0 ↔
      ∃ a : R, x = a • weightedRootProductNorm (Fintype.card F) tau r := by
  obtain ⟨c, nonzeroRoot, root⟩ := weighted_root_scaling_extension_exists R
    (Fintype.card F) Fintype.one_lt_card tau nonzero
  exact weighted_root_coefficient_homogeneous_kernel F β (weightedRootScalingMap R)
    (weighted_root_scaling_map_injective R) ψ tau c root nonzeroRoot r n positive
    p homogeneous anisotropic x

end Litt3.Deformations
