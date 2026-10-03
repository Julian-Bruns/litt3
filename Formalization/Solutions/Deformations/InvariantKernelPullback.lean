import Definitions.Deformations.InvariantKernelPullback

namespace Litt3.Deformations.InvariantDescentSquare

universe u

variable {k G L U DL DU : Type u} [Field k] [Group G]
    [AddCommGroup L] [Module k L] [AddCommGroup U] [Module k U]
    [AddCommGroup DL] [Module k DL] [AddCommGroup DU] [Module k DU]
    (square : InvariantDescentSquare k G L U DL DU)

/-- Full descent of ambient invariants implies full descent of the
actual kernel invariants, directly from the actual commuting square. -/
theorem kernel_pullback_invariant_image :
    LinearMap.range square.kernelPullback = square.kernelAction.invariants := by
  ext v
  constructor
  · rintro ⟨d, rfl⟩
    apply (Representation.mem_invariants _ _).mpr
    intro g
    apply Subtype.ext
    change square.sourceAction g (square.sourcePullback d.1) = square.sourcePullback d.1
    apply (Representation.mem_invariants _ _).mp _ g
    rw [← square.sourceInvariantImage]
    exact ⟨d.1, rfl⟩
  · intro fixed
    have source_fixed : v.1 ∈ square.sourceAction.invariants := by
      apply (Representation.mem_invariants _ _).mpr
      intro g
      exact congrArg Subtype.val ((Representation.mem_invariants _ _).mp fixed g)
    rw [← square.sourceInvariantImage] at source_fixed
    obtain ⟨d, hd⟩ := source_fixed
    have kernel : square.lowerMap d = 0 := square.targetInjective (by
      calc
        square.targetPullback (square.lowerMap d) = square.upperMap (square.sourcePullback d) :=
          (LinearMap.congr_fun square.commutes d).symm
        _ = square.upperMap v.1 := congrArg square.upperMap hd
        _ = 0 := v.2
        _ = square.targetPullback 0 := (map_zero _).symm)
    exact ⟨⟨d, kernel⟩, Subtype.ext hd⟩

theorem kernel_pullback_injective (sourceInjective : Function.Injective square.sourcePullback) :
    Function.Injective square.kernelPullback := by
  intro d e h
  exact Subtype.ext (sourceInjective (congrArg Subtype.val h))

/-- Actual lower kernel points are precisely actual invariant upper
kernel points, with the given pullback as the underlying map. -/
noncomputable def kernelInvariantEquiv
    (sourceInjective : Function.Injective square.sourcePullback) :
    LinearMap.ker square.lowerMap ≃ₗ[k] square.kernelAction.invariants :=
  (LinearEquiv.ofInjective square.kernelPullback
    (square.kernel_pullback_injective sourceInjective)).trans
    (LinearEquiv.ofEq _ _ square.kernel_pullback_invariant_image)

theorem kernel_invariant_finrank_eq
    (sourceInjective : Function.Injective square.sourcePullback) :
    Module.finrank k square.kernelAction.invariants = Module.finrank k (LinearMap.ker square.lowerMap) :=
  (square.kernelInvariantEquiv sourceInjective).finrank_eq.symm

end Litt3.Deformations.InvariantDescentSquare
