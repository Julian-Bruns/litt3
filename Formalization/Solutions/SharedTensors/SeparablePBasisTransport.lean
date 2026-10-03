import Solutions.SharedTensors.PBasisChangeParameter
import Solutions.SharedTensors.PBasisKaehler
import Solutions.SharedTensors.SeparableKaehlerCoordinates
import Solutions.SharedTensors.EtaleSymmetricTrace
import Mathlib.FieldTheory.PurelyInseparable.PerfectClosure
import Mathlib.Algebra.CharP.IntermediateField

namespace Litt3.SharedTensors

open IntermediateField Polynomial Module

variable {K L : Type*} [Field K] [Field L] [Algebra K L] [Algebra.IsSeparable K L]
variable {p : ℕ} [Fact p.Prime] [CharP K p] [CharP L p]

/-- Separability and the literal full downstairs p-basis imply that the
image parameter generates upstairs over the actual upstairs p-th powers.
No finite generation, finite extension degree or constant field is input. -/
theorem separable_p_basis_parameter_generates (b : PowerPBasis K p) :
    IntermediateField.adjoin (frobeniusSubfield L p)
      {algebraMap K L b.parameter} = ⊤ := by
  let S := frobeniusSubfield L p
  let J := IntermediateField.adjoin S {algebraMap K L b.parameter}
  have ht : algebraMap K L b.parameter ∈ J :=
    IntermediateField.subset_adjoin S _ (Set.mem_singleton _)
  have hK : ∀ a : K, algebraMap K L a ∈ J := by
    intro a
    have hexp := congrArg (algebraMap K L) (p_basis_actual_expansion b a)
    simp only [map_sum, map_mul, map_pow] at hexp
    rw [← hexp]
    apply J.sum_mem
    intro i _
    apply J.mul_mem
    · exact J.algebraMap_mem
        ⟨(algebraMap K L (pRootCoefficient K p b a i)) ^ p,
          ⟨algebraMap K L (pRootCoefficient K p b a i), rfl⟩⟩
    · exact pow_mem ht i.val
  let JK : IntermediateField K L := { J.toSubfield with algebraMap_mem' := hK }
  have hS : IntermediateField.adjoin K (S : Set L) ≤ JK := by
    rw [IntermediateField.adjoin_le_iff]
    intro a ha
    change a ∈ J
    exact J.algebraMap_mem ⟨a, ha⟩
  have hwhole : IntermediateField.adjoin K (Set.univ : Set L) = ⊤ := by
    apply top_unique
    exact IntermediateField.subset_adjoin K Set.univ
  have hpth := IntermediateField.adjoin_eq_adjoin_pow_expChar_of_isSeparable'
    K L (Set.univ : Set L) p
  have himage : ((fun a : L => a ^ p) '' Set.univ) = (S : Set L) := by
    ext a
    change (∃ r, r ∈ Set.univ ∧ r ^ p = a) ↔ ∃ r, r ^ p = a
    simp
  rw [himage, hwhole] at hpth
  have htop : JK = ⊤ := top_unique (hpth ▸ hS)
  ext a
  change a ∈ J ↔ a ∈ (⊤ : IntermediateField S L)
  change a ∈ JK ↔ True
  rw [htop]
  simp

/-- Every actual separable field extension transports a full actual
one-parameter p-basis. All upstairs powers, basis and dimension are
constructed, even for an infinite separable extension. -/
theorem separable_power_p_basis_exists (b : PowerPBasis K p) :
    ∃ bL : PowerPBasis L p, bL.parameter = algebraMap K L b.parameter := by
  let F := frobeniusSubfield K p
  letI : Algebra F L :=
    Algebra.ofSubring F.toSubring
  letI : IsScalarTower F K L := inferInstance
  obtain ⟨e, he⟩ := p_basis_kaehler_coordinate_exists b
  let eL := separableKaehlerCoordinate (L := L) e
  let t := algebraMap K L b.parameter
  let D := universalCoordinateDerivation eL
  have ht : D t = 1 := by
    change eL (KaehlerDifferential.D F L (algebraMap K L b.parameter)) = 1
    rw [← KaehlerDifferential.map_D F F K L]
    change separableKaehlerCoordinate e
      (KaehlerDifferential.map F F K L (KaehlerDifferential.D F K b.parameter)) = 1
    rw [separableKaehlerCoordinate_map, he, map_one]
  have hnot : t ∉ frobeniusSubfield L p := by
    rintro ⟨r, hr⟩
    change r ^ p = t at hr
    have hzero : D (r ^ p) = 0 := by
      rw [D.leibniz_pow, nsmul_eq_mul, CharP.cast_eq_zero L p, zero_mul]
    rw [hr, ht] at hzero
    exact one_ne_zero hzero
  let S := frobeniusSubfield L p
  have htop : IntermediateField.adjoin S {t} = ⊤ :=
    separable_p_basis_parameter_generates b
  have hmin : minpoly S t = X ^ p - C (frobeniusImageEquiv L p t) :=
    nonpth_element_frobenius_minpoly t hnot
  have hint : IsIntegral S t := by
    refine ⟨X ^ p - C (frobeniusImageEquiv L p t),
      monic_X_pow_sub_C _ (Fact.out : p.Prime).ne_zero, ?_⟩
    rw [← hmin]
    exact minpoly.aeval S t
  let eqv : (IntermediateField.adjoin S {t}) ≃ₐ[S] L :=
    (IntermediateField.equivOfEq htop).trans IntermediateField.topEquiv
  let pb := (IntermediateField.adjoin.powerBasis hint).map eqv
  have hgen : pb.gen = t := rfl
  have hdim : pb.dim = p := by
    change (minpoly S t).natDegree = p
    rw [hmin]
    exact natDegree_X_pow_sub_C
  refine ⟨{
    parameter := t
    basis := pb.basis.reindex (finCongr hdim)
    basis_eq_power := ?_ }, rfl⟩
  intro i
  rw [Basis.reindex_apply, pb.basis_eq_pow, hgen]
  rfl

end Litt3.SharedTensors
