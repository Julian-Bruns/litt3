import Mathlib.RingTheory.DedekindDomain.Dvr

open scoped nonZeroDivisors

namespace Litt3.Jacobians

/-- DVRs at maximal ideals already force a domain to have dimension
at most one. No Noetherian or finite type hypothesis is needed here. -/
theorem dimensionLEOne_of_maximal_localization_dvr
    (A : Type*) [CommRing A] [IsDomain A]
    (h : ∀ (q : Ideal A) (_ : q.IsMaximal), q ≠ ⊥ →
      IsDiscreteValuationRing (Localization.AtPrime q)) :
    Ring.DimensionLEOne A where
  maximalOfPrime := by
    intro p hp hpp
    rcases p.exists_le_maximal hpp.ne_top with ⟨q, hq, hpq⟩
    letI : q.IsMaximal := hq
    have hq0 : q ≠ ⊥ := ne_bot_of_le_ne_bot hp hpq
    letI : IsDiscreteValuationRing (Localization.AtPrime q) := h q hq hq0
    let f := (IsLocalization.orderIsoOfPrime q.primeCompl (Localization.AtPrime q)).symm
    let P := f ⟨p, hpp, hpq.disjoint_compl_left⟩
    let Q := f ⟨q, hq.isPrime, Set.disjoint_left.mpr fun _ a => a⟩
    have hinj : Function.Injective (algebraMap A (Localization.AtPrime q)) :=
      IsLocalization.injective (Localization.AtPrime q) q.primeCompl_le_nonZeroDivisors
    have hp1 : P.1 ≠ ⊥ := fun x => hp ((p.map_eq_bot_iff_of_injective hinj).mp x)
    have hq1 : Q.1 ≠ ⊥ :=
      fun x => hq0 ((q.map_eq_bot_iff_of_injective hinj).mp x)
    rcases (IsDiscreteValuationRing.iff_pid_with_one_nonzero_prime
      (Localization.AtPrime q)).mp inferInstance with ⟨_, huq⟩
    rw [show p = q from Subtype.val_inj.mpr <| f.injective <|
      Subtype.val_inj.mp (huq.unique ⟨hp1, P.2⟩ ⟨hq1, Q.2⟩)]
    exact hq

end Litt3.Jacobians
