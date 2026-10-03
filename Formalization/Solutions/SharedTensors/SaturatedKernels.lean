import Theorems.SharedTensors.SaturatedKernels

namespace Litt3.SharedTensors

variable {A B : Type*} [AddGroup A] [AddGroup B] [IsAddTorsionFree B]

/-- No finite-rank or finite-generation hypothesis is necessary for saturation. -/
theorem kernel_integral_roots_saturated (f : A →+ B) : KernelRootsSaturated f := by
  intro n hn a
  constructor
  · rintro ⟨⟨x, hx⟩, ha⟩
    have hfx : f x = 0 := by
      apply (IsAddTorsionFree.nsmul_right_injective hn)
      change n • f x = n • (0 : B)
      rw [← f.map_nsmul, hx, ha, nsmul_zero]
    exact ⟨⟨x, hfx⟩, hx⟩
  · rintro ⟨x, hx⟩
    refine ⟨⟨x, hx⟩, ?_⟩
    change f a = 0
    rw [← hx, f.map_nsmul, x.property, nsmul_zero]

end Litt3.SharedTensors
