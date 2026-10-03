import Solutions.CartierAndSpin.OneVariableIntrinsicInhomogeneous

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors

section Generic

variable {k K : Type*} [CommRing k] [Field K] [Algebra k K]

/-- The actual original k-linear universal differential connection,
retaining the TRUE Omega module as codomain. -/
noncomputable def intrinsicRationalConnection (omega : KaehlerDifferential k K) :
    K →ₗ[k] KaehlerDifferential k K :=
  (KaehlerDifferential.D k K).toLinearMap -
    (LinearMap.toSpanSingleton K (KaehlerDifferential k K) omega).restrictScalars k

theorem intrinsic_rational_connection_apply
    (omega : KaehlerDifferential k K) (v : K) :
    intrinsicRationalConnection omega v = KaehlerDifferential.D k K v - v • omega := rfl

variable {p : ℕ} [Fact p.Prime] [CharP K p]

/-- The TRUE original universal connection is bijective exactly when
omega is not fixed by actual Cartier. No finite dimension over k is
assumed; the full original field restricted formula supplies the inverse. -/
theorem p_basis_intrinsic_rational_connection_bijective_iff
    (C : RationalCartierOperator k K p) (b : PowerPBasis K p)
    (e : KaehlerDifferential k K ≃ₗ[K] K)
    (he : e (KaehlerDifferential.D k K b.parameter) = 1)
    (omega : KaehlerDifferential k K) :
    Function.Bijective (intrinsicRationalConnection omega) ↔ C.toAddHom omega ≠ omega := by
  let L := scalarDerivationConnection (universalCoordinateDerivation e) (e omega)
  have hcoordinate (v : K) : e (intrinsicRationalConnection omega v) = L v := by
    rw [intrinsic_rational_connection_apply]
    change e (KaehlerDifferential.D k K v - v • omega) =
      e (KaehlerDifferential.D k K v) - e omega * v
    simpa only [map_smul, smul_eq_mul, mul_comm v (e omega)] using
      map_sub e (KaehlerDifferential.D k K v) (v • omega)
  constructor
  · intro h
    apply (p_basis_intrinsic_cartier_connection_bijective_iff C b e he omega).mp
    constructor
    · intro x y hxy
      apply h.injective
      apply e.injective
      rw [hcoordinate, hcoordinate]
      exact hxy
    · intro y
      obtain ⟨v, hv⟩ := h.surjective (e.symm y)
      exact ⟨v, (hcoordinate v).symm.trans
        ((congrArg e hv).trans (e.apply_symm_apply y))⟩
  · intro h
    have hL := (p_basis_intrinsic_cartier_connection_bijective_iff C b e he omega).mpr h
    constructor
    · intro x y hxy
      apply hL.injective
      exact (hcoordinate x).symm.trans ((congrArg e hxy).trans (hcoordinate y))
    · intro eta
      obtain ⟨v, hv⟩ := hL.surjective (e eta)
      exact ⟨v, e.injective ((hcoordinate v).trans hv)⟩

end Generic

variable {k K : Type*} [Field k] [Field K] [Algebra k K]
  {p : ℕ} [Fact p.Prime] [CharP k p] [CharP K p] [PerfectField k]

/-- The complementary universal differential bijection on an actual
one-variable field, with every coordinate, p-basis and Cartier input
derived from genuine FG/trdeg one over perfect constants. -/
theorem actual_one_variable_intrinsic_rational_connection_bijective_iff
    (hfg : IntermediateField.FG (F := k) (E := K) ⊤)
    (htrdeg : Algebra.trdeg k K = 1) (omega : KaehlerDifferential k K) :
    Function.Bijective (intrinsicRationalConnection omega) ↔
      (oneVariableRationalCartier (p := p) hfg htrdeg).toAddHom omega ≠ omega := by
  obtain ⟨b⟩ := one_variable_power_p_basis_exists (p := p) hfg htrdeg
  obtain ⟨e, he⟩ := p_basis_perfect_base_kaehler_coordinate_exists (k := k) b
  exact p_basis_intrinsic_rational_connection_bijective_iff
    (oneVariableRationalCartier (p := p) hfg htrdeg) b e he omega

end Litt3.CartierAndSpin
