import Theorems.Deformations.AugmentationBasisKernel

namespace Litt3.Deformations

variable {k V ι : Type*} [CommRing k] [AddCommGroup V] [Module k V]

/-- An actual augmentation which reads precisely the distinguished
basis coordinate has kernel equal to the actual span of all others.
The basis and coefficient ring may be infinite or nonreduced. -/
theorem augmentation_basis_kernel (b : Module.Basis ι k V) (z : ι) (ε : V →ₗ[k] k)
    (origin : ε (b z) = 1) (vanishing : ∀ i, i ≠ z → ε (b i) = 0) :
    Specifications.AugmentationBasisKernel b z ε := by
  classical
  have hcoord : ε = b.coord z := by
    apply b.ext
    intro i
    by_cases hi : i = z
    · subst i
      simp [origin, Module.Basis.coord_apply]
    · simp [vanishing i hi, Module.Basis.coord_apply, Ne.symm hi]
  ext x
  rw [LinearMap.mem_ker, hcoord, Module.Basis.coord_apply, b.mem_span_image]
  constructor
  · intro hz i hi heq
    subst i
    exact (Finsupp.mem_support_iff.mp hi) hz
  · intro support
    by_contra hz
    exact (support (Finsupp.mem_support_iff.mpr hz)) rfl

end Litt3.Deformations
