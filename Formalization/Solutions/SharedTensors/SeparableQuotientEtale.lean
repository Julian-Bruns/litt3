import Mathlib.RingTheory.Etale.StandardEtale
import Mathlib.Algebra.Polynomial.FieldDivision

namespace Litt3.SharedTensors

open Polynomial
variable {K : Type*} [CommRing K]

/-- A separable monic polynomial gives a standard étale presentation with
no localization: the Bezout identity makes the derivative invertible. -/
noncomputable def separableQuotientStandardPair (F : K[X]) (hm : F.Monic)
    (hs : F.Separable) : StandardEtalePair K where
  f := F
  monic_f := hm
  g := 1
  cond := by
    obtain ⟨a, b, hab⟩ := hs
    refine ⟨b, a, 0, ?_⟩
    rw [pow_zero, mul_comm F.derivative b, mul_comm F a, add_comm]
    exact hab

/-- The actual standard presentation is the original polynomial quotient,
including all disconnected factors. -/
noncomputable def separableQuotientStandardEquiv (F : K[X]) (hm : F.Monic)
    (hs : F.Separable) :
    (separableQuotientStandardPair F hm hs).Ring ≃ₐ[K] AdjoinRoot F := by
  let P := separableQuotientStandardPair F hm hs
  have hf : P.f = F := rfl
  have hg : P.g = 1 := rfl
  let forward : P.Ring →ₐ[K] AdjoinRoot F :=
    P.lift (AdjoinRoot.root F) ⟨by rw [hf, AdjoinRoot.aeval_eq, AdjoinRoot.mk_self],
      by rw [hg, map_one]; exact isUnit_one⟩
  let backward : AdjoinRoot F →ₐ[K] P.Ring :=
    AdjoinRoot.liftAlgHom F (Algebra.ofId K P.Ring) P.X (hf ▸ P.hasMap_X.1)
  refine AlgEquiv.ofAlgHom forward backward ?_ ?_
  · apply AdjoinRoot.algHom_ext
    change forward (backward (AdjoinRoot.root F)) = AdjoinRoot.root F
    dsimp only [backward]
    rw [AdjoinRoot.liftAlgHom_root]
    exact StandardEtalePair.lift_X _ _ _
  · apply StandardEtalePair.hom_ext
    change backward (forward P.X) = P.X
    dsimp only [forward]
    rw [StandardEtalePair.lift_X]
    exact AdjoinRoot.liftAlgHom_root _ _ _ _

/-- The finite source quotient has its genuine étale property from the
actual monic and separable polynomial. No field structure is introduced. -/
theorem separable_monic_quotient_etale (F : K[X]) (hm : F.Monic) (hs : F.Separable) :
    Algebra.Etale K (AdjoinRoot F) :=
  Algebra.Etale.of_equiv (separableQuotientStandardEquiv F hm hs)

/-- Over a field the original nonmonic separable quotient is genuinely
étale as well; normalization is transported by an actual algebra equivalence. -/
theorem separable_polynomial_quotient_etale
    {L : Type*} [Field L] (F : L[X]) (hs : F.Separable) :
    Algebra.Etale L (AdjoinRoot F) := by
  have hc : F.leadingCoeff ≠ 0 := leadingCoeff_ne_zero.mpr hs.ne_zero
  have hu : IsUnit (C F.leadingCoeff⁻¹) :=
    (isUnit_iff_ne_zero.mpr (inv_ne_zero hc)).map C
  letI : Algebra.Etale L (AdjoinRoot (F * C F.leadingCoeff⁻¹)) :=
    separable_monic_quotient_etale _ (monic_mul_leadingCoeff_inv hs.ne_zero) (hs.mul_unit hu)
  exact Algebra.Etale.of_equiv (AdjoinRoot.algEquivOfAssociated L _ F
    (associated_mul_unit_left F (C F.leadingCoeff⁻¹) hu))

/-- Finiteness of the original source algebra is also transported from
the actual normalized monic power basis, retaining all factors. -/
theorem separable_polynomial_quotient_finite
    {L : Type*} [Field L] (F : L[X]) (hs : F.Separable) :
    Module.Finite L (AdjoinRoot F) := by
  have hc : F.leadingCoeff ≠ 0 := leadingCoeff_ne_zero.mpr hs.ne_zero
  have hu : IsUnit (C F.leadingCoeff⁻¹) :=
    (isUnit_iff_ne_zero.mpr (inv_ne_zero hc)).map C
  letI : Module.Finite L (AdjoinRoot (F * C F.leadingCoeff⁻¹)) :=
    (monic_mul_leadingCoeff_inv hs.ne_zero).finite_adjoinRoot
  let e := AdjoinRoot.algEquivOfAssociated L (F * C F.leadingCoeff⁻¹) F
    (associated_mul_unit_left F (C F.leadingCoeff⁻¹) hu)
  exact Module.Finite.of_surjective e.toLinearMap e.surjective

end Litt3.SharedTensors
