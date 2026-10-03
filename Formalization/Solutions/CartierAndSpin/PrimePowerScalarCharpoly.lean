import Mathlib.LinearAlgebra.Charpoly.BaseChange
import Mathlib.LinearAlgebra.Eigenspace.Zero
import Mathlib.Algebra.CharP.Algebra
import Mathlib.FieldTheory.IsAlgClosed.AlgebraicClosure
import Mathlib.Tactic

namespace Litt3.CartierAndSpin

open Polynomial
open scoped TensorProduct

variable {K V : Type*} [Field K] [AddCommGroup V] [Module K V]
  [Module.Finite K V] {p : ℕ} [Fact p.Prime] [CharP K p]

/-- A genuine p-dimensional operator with scalar pth power has the
literal pure-power characteristic polynomial when the scalar has a
root. The proof is a true nilpotent scalar shift, with no matrix or
supplied eigenvalue multiplicity. -/
theorem prime_dimension_scalar_power_charpoly_of_root
    (T : Module.End K V) (c r : K) (hr : r ^ p = c)
    (hdim : Module.finrank K V = p)
    (hT : T ^ p = algebraMap K (Module.End K V) c) :
    T.charpoly = (X : K[X]) ^ p - C c := by
  letI : Nontrivial V := Module.nontrivial_of_finrank_pos (by
    rw [hdim]
    exact (Fact.out : p.Prime).pos)
  letI : CharP (Module.End K V) p := charP_of_injective_algebraMap
    (algebraMap K (Module.End K V)).injective p
  have hshift : (T - algebraMap K (Module.End K V) r) ^ p = 0 := by
    rw [sub_pow_char_of_commute p (Algebra.commute_algebraMap_right r T),
      hT, ← map_pow, hr, sub_self]
  have hnil : IsNilpotent (T - algebraMap K (Module.End K V) r) := ⟨p, hshift⟩
  have hchar := hnil.charpoly_eq_X_pow_finrank
  rw [Algebra.algebraMap_eq_smul_one, LinearMap.charpoly_sub_smul, hdim] at hchar
  have hcomp : (X + C r : K[X]).comp (X - C r) = X := by
    simp only [Polynomial.add_comp, Polynomial.X_comp, Polynomial.C_comp]
    ring
  have hshiftback := congrArg (fun q : K[X] => q.comp (X - C r)) hchar
  have hform : T.charpoly = (X - C r) ^ p := by
    simpa only [Polynomial.comp_assoc, hcomp, Polynomial.comp_X,
      Polynomial.pow_comp, Polynomial.X_comp] using hshiftback
  rw [hform, sub_pow_char, ← map_pow, hr]

/-- The actual p-dimensional scalar-power characteristic polynomial
over EVERY prime-characteristic field, including imperfect fields.
A literal algebraic-closure scalar extension supplies the root and
true characteristic-polynomial base change descends the equality. -/
theorem prime_dimension_scalar_power_charpoly
    (T : Module.End K V) (c : K)
    (hdim : Module.finrank K V = p)
    (hT : T ^ p = algebraMap K (Module.End K V) c) :
    T.charpoly = (X : K[X]) ^ p - C c := by
  let E := AlgebraicClosure K
  let b := Module.Free.chooseBasis K V
  have hdimE : Module.finrank E (E ⊗[K] V) = p := by
    rw [Module.finrank_eq_card_basis (b.baseChange E),
      ← Module.finrank_eq_card_basis b, hdim]
  obtain ⟨r, hr⟩ := IsAlgClosed.exists_pow_nat_eq (algebraMap K E c)
    (Fact.out : p.Prime).pos
  have hTE : (T.baseChange E) ^ p =
      algebraMap E (Module.End E (E ⊗[K] V)) (algebraMap K E c) := by
    rw [← LinearMap.baseChange_pow, hT]
    change (Module.End.baseChangeHom K E V)
      (algebraMap K (Module.End K V) c) = _
    rw [AlgHom.commutes, IsScalarTower.algebraMap_apply K E]
  have hE := prime_dimension_scalar_power_charpoly_of_root
    (T.baseChange E) (algebraMap K E c) r hr hdimE hTE
  apply Polynomial.map_injective (algebraMap K E) (algebraMap K E).injective
  simpa only [LinearMap.charpoly_baseChange, Polynomial.map_sub,
    Polynomial.map_pow, Polynomial.map_X, Polynomial.map_C] using hE

end Litt3.CartierAndSpin
