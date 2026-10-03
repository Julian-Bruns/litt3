import Definitions.CartierAndSpin.TruncatedFieldTaylor
import Solutions.CartierAndSpin.IteratedPBasisDegree

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Polynomial Module

variable {L : Type*} [Field L] {p : ℕ} [Fact p.Prime] [CharP L p]

noncomputable def iteratedPBasisPowerBasis (b : PowerPBasis L p) (e : ℕ) :
    PowerBasis (iteratedFrobeniusSubfield L p e) L :=
  Classical.choose (iterated_p_basis_power_basis_exists b e)

theorem iteratedPBasisPowerBasis_gen (b : PowerPBasis L p) (e : ℕ) :
    (iteratedPBasisPowerBasis b e).gen = b.parameter :=
  (Classical.choose_spec (iterated_p_basis_power_basis_exists b e)).1

theorem iteratedPBasisPowerBasis_dim (b : PowerPBasis L p) (e : ℕ) :
    (iteratedPBasisPowerBasis b e).dim = p ^ e :=
  (Classical.choose_spec (iterated_p_basis_power_basis_exists b e)).2

omit [Fact p.Prime] [CharP L p] in
theorem truncated_taylor_parameter_power_zero (e : ℕ) :
    truncatedTaylorParameter (L := L) p e ^ (p ^ e) = 0 := by
  have h := AdjoinRoot.mk_self (f := (X ^ (p ^ e) : L[X]))
  simpa only [map_pow, AdjoinRoot.mk_X, truncatedTaylorParameter] using h

/-- A p-basis parameter admits an actual truncated Taylor ring map at
every depth. The shift t↦t+z respects the actual minimal polynomial over
the actual p^e-th-power subfield. -/
theorem truncated_field_taylor_map_exists (b : PowerPBasis L p) (e : ℕ) :
    ∃ f : L →+* TruncatedFieldTaylor L p e,
      f b.parameter = algebraMap L (TruncatedFieldTaylor L p e) b.parameter +
        truncatedTaylorParameter (L := L) p e ∧
      ∀ c : iteratedFrobeniusSubfield L p e,
        f c.val = algebraMap L (TruncatedFieldTaylor L p e) c.val := by
  let S := iteratedFrobeniusSubfield L p e
  let Q := TruncatedFieldTaylor L p e
  letI : Nontrivial Q := AdjoinRoot.nontrivial (X ^ (p ^ e) : L[X]) (by
    rw [degree_X_pow]
    norm_cast
    exact pow_ne_zero e (Fact.out : p.Prime).ne_zero)
  letI : CharP Q p := CharP.of_ringHom_of_ne_zero (algebraMap L Q) p
    (Fact.out : p.Prime).ne_zero
  letI : IsScalarTower S L Q := by infer_instance
  let pb := iteratedPBasisPowerBasis b e
  let y : Q := algebraMap L Q b.parameter + truncatedTaylorParameter (L := L) p e
  have hy : aeval y (minpoly S pb.gen) = 0 := by
    rw [iteratedPBasisPowerBasis_gen, iterated_p_basis_minpoly]
    change (aeval y : S[X] →ₐ[S] Q)
      (X ^ (p ^ e) - C (iteratedFrobeniusImageEquiv L p e b.parameter)) = 0
    rw [map_sub, map_pow, aeval_X, aeval_C]
    dsimp only [y]
    rw [add_pow_char_pow, ← map_pow, truncated_taylor_parameter_power_zero, add_zero]
    rw [IsScalarTower.algebraMap_apply S L Q]
    change algebraMap L Q (b.parameter ^ (p ^ e)) -
      algebraMap L Q (iteratedFrobeniusImageEquiv L p e b.parameter : L) = 0
    rw [iterated_frobenius_image_equiv_coe, sub_self]
  let f := pb.lift y hy
  refine ⟨f.toRingHom, ?_, ?_⟩
  · change f b.parameter = y
    rw [← iteratedPBasisPowerBasis_gen b e]
    exact PowerBasis.lift_gen pb y hy
  · intro c
    exact f.commutes c

end Litt3.CartierAndSpin
