import Solutions.CartierAndSpin.MonomialParameterIrreducibility
import Solutions.SharedTensors.OneVariableKaehler
import Mathlib.FieldTheory.Minpoly.Field

namespace Litt3.CartierAndSpin

open Polynomial IntermediateField
open scoped IntermediateField.algebraAdjoinAdjoin

variable {k L : Type*} [Field k] [Field L] [Algebra k L]

/-- The exact degree of the monomial map on any actual rational
function field. The generating function is genuinely transcendental,
and the base is its actual power-generated subfield. -/
theorem function_power_minpoly_degree
    (r : L) (hr : Transcendental k r)
    (n : ℕ) (hn : 0 < n) :
    IsIntegral (IntermediateField.adjoin k {r ^ n}) r ∧
      (minpoly (IntermediateField.adjoin k {r ^ n}) r).natDegree = n := by
  let A := Algebra.adjoin k {r ^ n}
  let F := IntermediateField.adjoin k {r ^ n}
  let eA := Litt3.SharedTensors.transcendentalPolynomialSubalgebraEquiv (r ^ n) (hr.pow hn)
  let f : k[X] →ₐ[k] F := (IsScalarTower.toAlgHom k A F).comp eA.toAlgHom
  letI : Algebra k[X] F := f.toRingHom.toAlgebra
  letI : IsScalarTower k k[X] F :=
    IsScalarTower.of_algebraMap_eq (fun c => (f.commutes c).symm)
  letI : IsFractionRing k[X] F :=
    (IsFractionRing.isFractionRing_iff_of_base_ringEquiv
      (S := F) eA.symm.toRingEquiv).mp inferInstance
  let P := (monomialParameterPolynomial (k := k) n).map (algebraMap k[X] F)
  have hirr : Irreducible P := monomial_parameter_fraction_irreducible n hn
  have hmonic : P.Monic :=
    (Polynomial.monic_X_pow_sub_C (X : k[X]) hn.ne').map _
  have heval : ∀ Q : k[X], (f Q).val = Polynomial.aeval (r ^ n) Q := fun _ => rfl
  have hroot : Polynomial.aeval r P = 0 := by
    simp only [P, monomialParameterPolynomial, Polynomial.map_sub, Polynomial.map_pow,
      Polynomial.map_X, Polynomial.map_C, Polynomial.aeval_sub, map_pow,
      Polynomial.aeval_X, Polynomial.aeval_C]
    change r ^ n - (f (X : k[X])).val = 0
    rw [heval]
    simp
  have hintegral : IsIntegral F r := ⟨P, hmonic, hroot⟩
  have hmin : P = minpoly F r := minpoly.eq_of_irreducible_of_monic hirr hroot hmonic
  refine ⟨hintegral, ?_⟩
  rw [← hmin]
  dsimp only [P]
  rw [Polynomial.natDegree_map_eq_of_injective (IsFractionRing.injective k[X] F),
    monomialParameterPolynomial, Polynomial.natDegree_X_pow_sub_C]

theorem rational_monomial_function_degree
    (r : L) (hr : Transcendental k r) (hgen : IntermediateField.adjoin k {r} = ⊤)
    (n : ℕ) (hn : 0 < n) :
    Module.finrank (IntermediateField.adjoin k {r ^ n}) L = n := by
  obtain ⟨hintegral, hmin⟩ := function_power_minpoly_degree r hr n hn
  have hgenF : IntermediateField.adjoin (IntermediateField.adjoin k {r ^ n}) {r} = ⊤ :=
    IntermediateField.adjoin_eq_top_of_adjoin_eq_top (F := k) hgen
  have hdegree := IntermediateField.adjoin.finrank hintegral
  rw [hgenF, IntermediateField.finrank_top', hmin] at hdegree
  exact hdegree

/-- The monomial degree divides the actual ambient function degree,
with no Galois or separability hypothesis and no finite-over-constants
assumption. -/
theorem function_power_degree_divisibility
    (r : L) (hr : Transcendental k r) (n : ℕ) (hn : 0 < n)
    [FiniteDimensional (IntermediateField.adjoin k {r ^ n}) L] :
    n ∣ Module.finrank (IntermediateField.adjoin k {r ^ n}) L := by
  obtain ⟨hintegral, hmin⟩ := function_power_minpoly_degree r hr n hn
  let F := IntermediateField.adjoin k {r ^ n}
  let E := IntermediateField.adjoin F {r}
  letI : FiniteDimensional F E := IntermediateField.adjoin.finiteDimensional hintegral
  have hdegree : Module.finrank F E = n := by
    rw [IntermediateField.adjoin.finrank hintegral, hmin]
  refine ⟨Module.finrank E L, ?_⟩
  change Module.finrank F L = n * Module.finrank E L
  rw [← hdegree]
  exact (Module.finrank_mul_finrank F E L).symm

end Litt3.CartierAndSpin
