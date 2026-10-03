import Solutions.QuotientGeometry.SmoothCurveDifferentialFrames
import Solutions.QuotientGeometry.SmoothRationalDifferentialIdentities
import Solutions.SharedTensors.SchemeRegularDifferentials

open CategoryTheory AlgebraicGeometry

namespace Litt3.QuotientGeometry

open Litt3.SharedTensors

universe u

variable {k : Type u} [Field k] [IsAlgClosed k]
  {X : Scheme.{u}} [IsIntegral X]
  (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
  {p : ℕ} [Fact p.Prime] [CharP k p]

include p

/-- The global rational identity with an actual globally regular form
nonvanishing in the ORIGINAL residue fiber produces the original unit
slope and literal universal differential identity. Original local Ω
identity, differential frame and slope are all conclusions. -/
theorem actual_smooth_curve_global_differential_identity_unit_slope (x : ClosedPoint X) :
    letI := (stalkBaseFieldHom sX x.val).toAlgebra
    letI := (genericBaseFieldHom sX).toAlgebra
    letI : IsScalarTower k (X.presheaf.stalk x.val) X.functionField :=
      IsScalarTower.of_algebraMap_eq' (stalk_base_field_generic_compatibility sX x.val).symm
    letI := actual_smooth_curve_closed_point_dvr sX x
    ∀ (d : DVRCompletionParameters k (X.presheaf.stalk x.val))
      (G : X.presheaf.stalk x.val) (c : k)
      (sigma : KaehlerDifferential k X.functionField),
      sigma ∈ schemeGlobalRegularDifferentials sX →
      (∀ omega : KaehlerDifferential k (X.presheaf.stalk x.val),
        KaehlerDifferential.map k k (X.presheaf.stalk x.val) X.functionField omega = sigma →
        omega ∉ IsLocalRing.maximalIdeal (X.presheaf.stalk x.val) •
          (⊤ : Submodule (X.presheaf.stalk x.val)
            (KaehlerDifferential k (X.presheaf.stalk x.val)))) →
      KaehlerDifferential.D k X.functionField
        (algebraMap (X.presheaf.stalk x.val) X.functionField G) =
        (algebraMap k X.functionField c *
          (algebraMap (X.presheaf.stalk x.val) X.functionField d.parameter) ^ (p - 2)) • sigma →
      ∃ S : X.presheaf.stalk x.val, IsUnit S ∧
        KaehlerDifferential.map k k (X.presheaf.stalk x.val) X.functionField
          (S • KaehlerDifferential.D k (X.presheaf.stalk x.val) d.parameter) = sigma ∧
        KaehlerDifferential.D k (X.presheaf.stalk x.val) G =
          (algebraMap k (X.presheaf.stalk x.val) c * d.parameter ^ (p - 2) * S) •
            KaehlerDifferential.D k (X.presheaf.stalk x.val) d.parameter := by
  letI := (stalkBaseFieldHom sX x.val).toAlgebra
  letI := (genericBaseFieldHom sX).toAlgebra
  letI : IsScalarTower k (X.presheaf.stalk x.val) X.functionField :=
    IsScalarTower.of_algebraMap_eq' (stalk_base_field_generic_compatibility sX x.val).symm
  letI := actual_smooth_curve_closed_point_dvr sX x
  intro d G c sigma hregular hnonvanishing hglobal
  obtain ⟨omega, hmap⟩ := (mem_schemeLocalRegularDifferentials_iff sX x.val sigma).mp
    ((mem_schemeGlobalRegularDifferentials_iff sX sigma).mp hregular x)
  obtain ⟨S, hunit, homega⟩ := actual_smooth_curve_original_nonvanishing_unit_slope
    (p := p) sX x d omega (hnonvanishing omega hmap)
  refine ⟨S, hunit, homega ▸ hmap, ?_⟩
  have hlocal := actual_smooth_rational_differential_identity_descends sX 1 x.val
    G (algebraMap k (X.presheaf.stalk x.val) c * d.parameter ^ (p - 2)) omega
    (by rw [map_mul, map_pow, ← IsScalarTower.algebraMap_apply k
          (X.presheaf.stalk x.val) X.functionField, hmap]; exact hglobal)
  rw [homega, smul_smul] at hlocal
  exact hlocal

end Litt3.QuotientGeometry
