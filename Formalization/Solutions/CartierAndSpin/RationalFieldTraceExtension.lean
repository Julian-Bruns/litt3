import Solutions.CartierAndSpin.RationalPrimitiveFields

namespace Litt3.CartierAndSpin

open Polynomial
open scoped RatFunc

attribute [local instance] Polynomial.algebra

variable {K L : Type*} [Field K] [Field L] [Algebra K L]

theorem primitive_raw_field_quotient_equiv (w : L) (F : K[X]) (hF : F ≠ 0)
    (hroot : aeval w F = 0)
    (hgen : IntermediateField.adjoin K ({w} : Set L) = ⊤)
    (hdegree : F.natDegree = Module.finrank K L) :
    ∃ e : AdjoinRoot F ≃ₐ[K] L, e (AdjoinRoot.root F) = w := by
  obtain ⟨pb, hpb, hraw⟩ := primitive_field_raw_polynomial w F hF hroot hgen hdegree
  let e := powerBasisRawQuotientEquiv pb F F.leadingCoeff
    (leadingCoeff_ne_zero.mpr hF) hraw
  exact ⟨e, (powerBasisRawQuotientEquiv_root pb F F.leadingCoeff
    (leadingCoeff_ne_zero.mpr hF) hraw).trans hpb⟩

/-- Literal trace preservation in the actual rational function fields
L(z)/K(z). The quotient equivalences and primitive bases are constructed,
and compatibility is proved on the actual generator; no compatible basis
or tensor-product identification is an input. -/
theorem primitive_rational_field_trace_constant_extension (w : L) (F : K[X]) (hF : F ≠ 0)
    (hroot : aeval w F = 0)
    (hgen : IntermediateField.adjoin K ({w} : Set L) = ⊤)
    (hdegree : F.natDegree = Module.finrank K L) (a : L) :
    Algebra.trace (RatFunc K) (RatFunc L) (RatFunc.C a) =
      RatFunc.C (Algebra.trace K L a) := by
  obtain ⟨pb, _hpb, _hdim⟩ := primitive_field_power_basis w F hF hroot hgen
  letI : FiniteDimensional K L := Module.Finite.of_basis pb.basis
  obtain ⟨e, he⟩ := primitive_raw_field_quotient_equiv w F hF hroot hgen hdegree
  let Fz := F.map (algebraMap K (RatFunc K))
  have hFz : Fz ≠ 0 := Polynomial.map_ne_zero hF
  have hrootz : aeval (RatFunc.C w) Fz = 0 := by
    rw [rational_constant_polynomial_aeval, hroot, map_zero]
  have hdegreez : Fz.natDegree = Module.finrank (RatFunc K) (RatFunc L) := by
    rw [RatFunc.finrank_ratFunc_ratFunc, ← hdegree]
    exact natDegree_map_eq_of_injective (algebraMap K (RatFunc K)).injective F
  obtain ⟨ez, hez⟩ := primitive_raw_field_quotient_equiv (RatFunc.C w) Fz hFz hrootz
    (rational_constant_generator w hgen) hdegreez
  let f := (ez.toAlgHom.restrictScalars K).comp
    (polynomialQuotientCoefficientMap (L := RatFunc K) F)
  let g := (IsScalarTower.toAlgHom K L (RatFunc L)).comp e.toAlgHom
  have hfg : f = g := by
    apply AdjoinRoot.algHom_ext
    change ez (polynomialQuotientCoefficientMap (L := RatFunc K) F (AdjoinRoot.root F)) =
      RatFunc.C (e (AdjoinRoot.root F))
    rw [polynomialQuotientCoefficientMap_root, he, hez]
  have hcompatible (x : AdjoinRoot F) :
      ez (polynomialQuotientCoefficientMap (L := RatFunc K) F x) = RatFunc.C (e x) :=
    congrArg (fun φ : AdjoinRoot F →ₐ[K] RatFunc L => φ x) hfg
  have htrace := polynomial_quotient_trace_coefficient_extension (L := RatFunc K) F hF (e.symm a)
  rw [← Algebra.trace_eq_of_algEquiv ez, hcompatible, e.apply_symm_apply,
    ← Algebra.trace_eq_of_algEquiv e, e.apply_symm_apply] at htrace
  exact htrace

end Litt3.CartierAndSpin
