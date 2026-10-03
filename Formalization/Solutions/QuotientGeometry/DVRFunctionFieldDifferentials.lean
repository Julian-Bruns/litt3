import Solutions.QuotientGeometry.DVRFunctionFieldCompletion
import Solutions.CartierAndSpin.LaurentDerivation

namespace Litt3.QuotientGeometry

open IsLocalRing

/-- Pullback of an actual field derivation along an actual coefficient-field
embedding, with the resulting module action specified by that embedding. -/
noncomputable def fieldDerivationAlongAlgHom
    {k K L : Type*} [CommRing k] [CommRing K] [CommRing L] [Algebra k K] [Algebra k L]
    (φ : K →ₐ[k] L) (D : Derivation k L L) :
    letI : Module k L := Algebra.toModule
    letI : Algebra K L := φ.toRingHom.toAlgebra
    letI : SMul K L := φ.toRingHom.toAlgebra.toSMul
    letI : Module K L := Algebra.toModule
    Derivation k K L := by
  letI : Module k L := Algebra.toModule
  letI : Algebra K L := φ.toRingHom.toAlgebra
  letI : SMul K L := φ.toRingHom.toAlgebra.toSMul
  letI : Module K L := Algebra.toModule
  exact
  { toFun := fun f => D (φ f)
    map_add' := fun f g =>
      (congrArg D (map_add φ f g)).trans (map_add D (φ f) (φ g))
    map_smul' := by
      intro c f
      simp only [Algebra.smul_def, RingHom.id_apply]
      rw [map_mul, φ.commutes]
      simpa only [Algebra.smul_def, RingHom.id_apply] using D.toLinearMap.map_smul c (φ f)
    map_one_eq_zero' := by
      change D (φ 1) = 0
      exact (congrArg D (map_one φ)).trans D.map_one_eq_zero
    leibniz' := by
      intro f g
      change D (φ (f * g)) = φ f * D (φ g) + φ g * D (φ f)
      rw [map_mul, D.leibniz]
      rfl }

theorem fieldDerivationAlongAlgHom_apply
    {k K L : Type*} [CommRing k] [CommRing K] [CommRing L] [Algebra k K] [Algebra k L]
    (φ : K →ₐ[k] L) (D : Derivation k L L) (f : K) :
    letI : Module k L := Algebra.toModule
    letI : Algebra K L := φ.toRingHom.toAlgebra
    letI : SMul K L := φ.toRingHom.toAlgebra.toSMul
    letI : Module K L := Algebra.toModule
    fieldDerivationAlongAlgHom φ D f = D (φ f) := rfl

variable {k R K : Type*} [Field k]
  [CommRing R] [IsDomain R] [IsDiscreteValuationRing R] [Algebra k R]
  [Field K] [Algebra R K] [IsFractionRing R K]
  [Algebra k K] [IsScalarTower k R K]

/-- The actual function-field completion respects the actual coefficient
field, without specifying a power-series or Laurent-series chart. -/
noncomputable def dvrFunctionFieldCompletionAlgHom
    (d : DVRCompletionParameters k R) : K →ₐ[k] LaurentSeries k :=
  { dvrFunctionFieldCompletion d with
    commutes' := by
      intro c
      change dvrFunctionFieldCompletion d (algebraMap k K c) = _
      rw [IsScalarTower.algebraMap_eq k R K, RingHom.comp_apply,
        dvrFunctionFieldCompletion_ring, (completedDVRStalkEmbedding d).commutes]
      simp only [PowerSeries.algebraMap_apply, LaurentSeries.algebraMap_apply,
        HahnSeries.ofPowerSeries_C, Algebra.id.map_eq_id, RingHom.id_apply] }

theorem dvrFunctionFieldCompletionAlgHom_apply
    (d : DVRCompletionParameters k R) (f : K) :
    dvrFunctionFieldCompletionAlgHom d f = dvrFunctionFieldCompletion d f := rfl

/-- The completed field carries the genuine action of the original
function field through its constructed completion embedding. -/
noncomputable def dvrFunctionFieldLaurentAlgebra
    (d : DVRCompletionParameters k R) : Algebra K (LaurentSeries k) :=
  (dvrFunctionFieldCompletionAlgHom d).toRingHom.toAlgebra

/-- Actual differentiation of original rational functions in the
constructed DVR chart is an actual coefficient-field derivation. -/
noncomputable def dvrFunctionFieldDerivation
    (d : DVRCompletionParameters k R) :
    letI : Module k (LaurentSeries k) := Algebra.toModule
    letI := dvrFunctionFieldLaurentAlgebra (K := K) d
    letI : SMul K (LaurentSeries k) := (dvrFunctionFieldLaurentAlgebra (K := K) d).toSMul
    letI : Module K (LaurentSeries k) := Algebra.toModule
    Derivation k K (LaurentSeries k) :=
  fieldDerivationAlongAlgHom (dvrFunctionFieldCompletionAlgHom d)
    (Litt3.CartierAndSpin.laurentDerivation k)

theorem dvrFunctionFieldDerivation_apply
    (d : DVRCompletionParameters k R) (f : K) :
    letI : Module k (LaurentSeries k) := Algebra.toModule
    letI := dvrFunctionFieldLaurentAlgebra (K := K) d
    letI : SMul K (LaurentSeries k) := (dvrFunctionFieldLaurentAlgebra (K := K) d).toSMul
    letI : Module K (LaurentSeries k) := Algebra.toModule
    dvrFunctionFieldDerivation d f =
      LaurentSeries.derivative k (dvrFunctionFieldCompletion d f) := by
  exact fieldDerivationAlongAlgHom_apply (dvrFunctionFieldCompletionAlgHom d)
    (Litt3.CartierAndSpin.laurentDerivation k) f

theorem dvrFunctionFieldDerivation_parameter
    (d : DVRCompletionParameters k R) :
    letI : Module k (LaurentSeries k) := Algebra.toModule
    letI := dvrFunctionFieldLaurentAlgebra (K := K) d
    letI : SMul K (LaurentSeries k) := (dvrFunctionFieldLaurentAlgebra (K := K) d).toSMul
    letI : Module K (LaurentSeries k) := Algebra.toModule
    dvrFunctionFieldDerivation d (algebraMap R K d.parameter) = 1 := by
  letI : Module k (LaurentSeries k) := Algebra.toModule
  letI := dvrFunctionFieldLaurentAlgebra (K := K) d
  letI : SMul K (LaurentSeries k) := (dvrFunctionFieldLaurentAlgebra (K := K) d).toSMul
  letI : Module K (LaurentSeries k) := Algebra.toModule
  rw [dvrFunctionFieldDerivation_apply, dvrFunctionFieldCompletion_parameter,
    Litt3.CartierAndSpin.laurent_derivative_powerSeries]
  simp

/-- The derivative of every actual regular function is the derivative of
its constructed whole power-series expansion. -/
theorem dvrFunctionFieldDerivation_regular
    (d : DVRCompletionParameters k R) (r : R) :
    letI : Module k (LaurentSeries k) := Algebra.toModule
    letI := dvrFunctionFieldLaurentAlgebra (K := K) d
    letI : SMul K (LaurentSeries k) := (dvrFunctionFieldLaurentAlgebra (K := K) d).toSMul
    letI : Module K (LaurentSeries k) := Algebra.toModule
    dvrFunctionFieldDerivation d (algebraMap R K r) =
      (PowerSeries.derivative k (completedDVRStalkEmbedding d r) : LaurentSeries k) := by
  letI : Module k (LaurentSeries k) := Algebra.toModule
  letI := dvrFunctionFieldLaurentAlgebra (K := K) d
  letI : SMul K (LaurentSeries k) := (dvrFunctionFieldLaurentAlgebra (K := K) d).toSMul
  letI : Module K (LaurentSeries k) := Algebra.toModule
  rw [dvrFunctionFieldDerivation_apply, dvrFunctionFieldCompletion_ring,
    Litt3.CartierAndSpin.laurent_derivative_powerSeries]

end Litt3.QuotientGeometry
