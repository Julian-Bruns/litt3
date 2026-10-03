import Theorems.Deformations.CorestrictionDescent
import Mathlib.Tactic.Abel
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas

namespace Litt3.Deformations

variable {V W : Type*} [AddCommGroup V] [AddCommGroup W]

/-- A genuine degree/corestriction identity and injective degree
multiplication force injectivity of the original pullback. -/
theorem corestriction_pullback_injective (pullback : V →+ W) (trace : W →+ V)
    (degree : ℕ)
    (injective_degree : Function.Injective (degreeMultiple (V := V) degree))
    (trace_identity : ∀ v, trace (pullback v) = degree • v) :
    Function.Injective pullback := by
  intro x y h
  apply injective_degree
  exact (trace_identity x).symm.trans
    ((congrArg trace h).trans (trace_identity y))

/-- An actual obstruction class whose pullback vanishes already
vanishes downstairs under the invertible-degree condition. -/
theorem obstruction_zero_descends (pullback : V →+ W) (trace : W →+ V)
    (degree : ℕ)
    (injective_degree : Function.Injective (degreeMultiple (V := V) degree))
    (trace_identity : ∀ v, trace (pullback v) = degree • v)
    (obstruction : V) (upstairs_zero : pullback obstruction = 0) :
    obstruction = 0 := by
  apply corestriction_pullback_injective pullback trace degree
    injective_degree trace_identity
  exact upstairs_zero.trans pullback.map_zero.symm

/-- Normalized corestriction is an actual additive retraction. -/
theorem normalized_corestriction_retraction (pullback : V →+ W) (trace : W →+ V)
    (degree : ℕ)
    (invertible_degree : Function.Bijective (degreeMultiple (V := V) degree))
    (trace_identity : ∀ v, trace (pullback v) = degree • v) (v : V) :
    normalizedCorestriction trace degree invertible_degree (pullback v) = v := by
  unfold normalizedCorestriction
  change (AddEquiv.ofBijective (degreeMultiple degree) invertible_degree).symm
    (trace (pullback v)) = v
  rw [trace_identity]
  exact (AddEquiv.ofBijective (degreeMultiple degree) invertible_degree).symm_apply_apply v

/-- The full specified-point descent criterion follows from a
retraction and retains the original point, rather than replacing it
by another upstairs choice. -/
theorem specified_point_descent (pullback : V →+ W) (retraction : W →+ V)
    (retracts : ∀ v, retraction (pullback v) = v) :
    Specifications.SpecifiedPointDescent pullback retraction := by
  intro w
  constructor
  · rintro ⟨v, rfl⟩
    unfold traceFreePart
    rw [retracts, sub_self]
  · intro h
    exact ⟨retraction w, (sub_eq_zero.mp h).symm⟩

theorem trace_free_part_in_kernel (pullback : V →+ W) (retraction : W →+ V)
    (retracts : ∀ v, retraction (pullback v) = v) (w : W) :
    retraction (traceFreePart pullback retraction w) = 0 := by
  unfold traceFreePart
  rw [retraction.map_sub, retracts, sub_self]

/-- Exact decomposition of every actual upstairs point into its
original pullback and full trace-free component. -/
theorem point_trace_decomposition (pullback : V →+ W) (retraction : W →+ V)
    (w : W) :
    pullback (retraction w) + traceFreePart pullback retraction w = w := by
  unfold traceFreePart
  rw [← add_sub_assoc, add_comm (pullback (retraction w)) w, add_sub_cancel_right]

/-- Changing the downstairs reference point preserves the complete
trace-free residue, without replacing it by a scalar detector. -/
theorem trace_free_part_reference_independent (pullback : V →+ W)
    (retraction : W →+ V) (retracts : ∀ v, retraction (pullback v) = v)
    (w : W) (v : V) :
    traceFreePart pullback retraction (w + pullback v) =
      traceFreePart pullback retraction w := by
  simp only [traceFreePart, map_add, retracts]
  abel

/-- The direct sum uses the actual full kernel of corestriction. -/
def corestrictionSplit (pullback : V →+ W) (retraction : W →+ V)
    (retracts : ∀ v, retraction (pullback v) = v) :
    W ≃+ V × AddMonoidHom.ker retraction where
  toFun w := ⟨retraction w, ⟨traceFreePart pullback retraction w,
    trace_free_part_in_kernel pullback retraction retracts w⟩⟩
  invFun p := pullback p.1 + p.2.val
  left_inv w := point_trace_decomposition pullback retraction w
  right_inv p := by
    have hp : retraction p.2.val = 0 := p.2.property
    apply Prod.ext
    · simp only [map_add, retracts, hp, add_zero]
    · apply Subtype.ext
      change traceFreePart pullback retraction (pullback p.1 + p.2.val) = p.2.val
      simp only [traceFreePart, map_add, retracts, hp, add_zero]
      abel
  map_add' x y := by
    apply Prod.ext
    · exact retraction.map_add x y
    · apply Subtype.ext
      change traceFreePart pullback retraction (x + y) =
        traceFreePart pullback retraction x + traceFreePart pullback retraction y
      simp only [traceFreePart, map_add]
      abel

/-- The normalized trace is uniquely characterized by its degree
multiple, for the actual additive groups. -/
theorem degree_multiple_normalized_corestriction (trace : W →+ V) (degree : ℕ)
    (invertible_degree : Function.Bijective (degreeMultiple (V := V) degree))
    (w : W) : degree • normalizedCorestriction trace degree invertible_degree w =
      trace w := by
  change (AddEquiv.ofBijective (degreeMultiple degree) invertible_degree)
    ((AddEquiv.ofBijective (degreeMultiple degree) invertible_degree).symm (trace w)) = _
  exact (AddEquiv.ofBijective (degreeMultiple degree) invertible_degree).apply_symm_apply _

/-- An actual additive extension boundary commutes with finite
corestriction. Dividing the extension class by the degree then
preserves the prescribed downstairs boundary. The chosen class
need not pull back to the original upstairs class. -/
theorem normalized_corestriction_preserves_boundary
    {B B' : Type*} [AddCommGroup B] [AddCommGroup B']
    (boundary : V →+ B) (upstairsBoundary : W →+ B')
    (pullbackBoundary : B →+ B') (traceExtension : W →+ V)
    (traceBoundary : B' →+ B) (degree : ℕ)
    (invertible_extension_degree : Function.Bijective (degreeMultiple (V := V) degree))
    (injective_boundary_degree : Function.Injective (degreeMultiple (V := B) degree))
    (trace_boundary_identity : ∀ b, traceBoundary (pullbackBoundary b) = degree • b)
    (boundary_trace_commutes : ∀ w,
      boundary (traceExtension w) = traceBoundary (upstairsBoundary w))
    (b : B) (w : W) (prescribed_boundary : upstairsBoundary w = pullbackBoundary b) :
    boundary (normalizedCorestriction traceExtension degree invertible_extension_degree w)
      = b := by
  apply injective_boundary_degree
  change degree • boundary _ = degree • b
  rw [← map_nsmul, degree_multiple_normalized_corestriction,
    boundary_trace_commutes, prescribed_boundary, trace_boundary_identity]

/-- Equality of the actual dimensions kills the whole trace-free
part. The pullback is linear; the retraction is only required to be
additive, and a scalar residue is never used. -/
theorem no_defect_growth_descent {k : Type*} [DivisionRing k]
    [Module k V] [Module k W] [FiniteDimensional k V] [FiniteDimensional k W]
    (pullback : V →ₗ[k] W) (retraction : W →+ V)
    (retracts : ∀ v, retraction (pullback v) = v)
    (same_dimension : Module.finrank k V = Module.finrank k W) :
    Function.Surjective pullback ∧
      ∀ w, traceFreePart pullback.toAddMonoidHom retraction w = 0 := by
  have hinj : Function.Injective pullback := by
    intro x y h
    exact (retracts x).symm.trans ((congrArg retraction h).trans (retracts y))
  have hsurj : Function.Surjective pullback :=
    (LinearMap.injective_iff_surjective_of_finrank_eq_finrank same_dimension).mp hinj
  refine ⟨hsurj, ?_⟩
  intro w
  exact (specified_point_descent pullback.toAddMonoidHom retraction retracts w).mp (hsurj w)

end Litt3.Deformations
