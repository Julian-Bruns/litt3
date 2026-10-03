import Solutions.CartierAndSpin.WeightedSquarePencils
import Solutions.SharedTensors.OneVariableKaehler

namespace Litt3.CartierAndSpin

open Polynomial IntermediateField
open scoped IntermediateField.algebraAdjoinAdjoin

variable {k L : Type*} [Field k] [Field L] [Algebra k L]

/-- Literal weighted square-pencil support of an actual transcendental
function, measured by its actual generated subfield degree. The rational
function presentation is constructed, not supplied. -/
theorem function_weighted_square_pencil_finite
    (r : L) (hr : Transcendental k r)
    [FiniteDimensional (IntermediateField.adjoin k {r}) L]
    (g : L) (hg : g ≠ 0) (htwo : (2 : k) ≠ 0) :
    let support : Set k := {theta | IsSquare (g * (r - algebraMap k L theta))}
    support.Finite ∧ support.ncard ≤
      1 + (Module.finrank (IntermediateField.adjoin k {r}) L).factorization 2 := by
  let A := Algebra.adjoin k {r}
  let F := IntermediateField.adjoin k {r}
  let eA := Litt3.SharedTensors.transcendentalPolynomialSubalgebraEquiv r hr
  let f : k[X] →ₐ[k] F := (IsScalarTower.toAlgHom k A F).comp eA.toAlgHom
  letI : Algebra k[X] F := f.toRingHom.toAlgebra
  letI : IsScalarTower k k[X] F :=
    IsScalarTower.of_algebraMap_eq (fun c => (f.commutes c).symm)
  letI : IsFractionRing k[X] F :=
    (IsFractionRing.isFractionRing_iff_of_base_ringEquiv
      (S := F) eA.symm.toRingEquiv).mp inferInstance
  have htwoF : (2 : F) ≠ 0 := by
    intro hz
    have hh : algebraMap k F (2 : k) = algebraMap k F 0 := by
      simpa only [map_ofNat, map_zero] using hz
    exact htwo ((algebraMap k F).injective hh)
  have hlinear : ∀ theta : k,
      algebraMap F L (algebraMap k[X] F (X - C theta)) = r - algebraMap k L theta := by
    intro theta
    change (f (X - C theta)).val = _
    have heval : ∀ P : k[X], (f P).val = Polynomial.aeval r P := fun _ => rfl
    rw [heval]
    simp
  have h := weighted_square_pencil_support_finite (k := k) (T := F) (L := L) g hg htwoF
  dsimp only
  simpa only [F, hlinear] using h

end Litt3.CartierAndSpin
