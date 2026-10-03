import Solutions.SharedTensors.SchemeDifferentialGlobalCartierNaturality
import Mathlib.Logic.Function.Iterate

open CategoryTheory AlgebraicGeometry

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 200000

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry Litt3.CartierAndSpin

universe u

variable {k : Type u} [Field k] [PerfectField k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  {p : ℕ} [Fact p.Prime] [CharP k p]

/-- ALL finite iterates of actual Cartier on genuine original H0 have
the inverse-p^n scalar law for the original coefficient action. -/
theorem actualSmoothCurveSheafGlobalCartier_iterate_semilinear
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    (n : ℕ) (c : k) (a : schemeDifferentialGlobalSections sX) :
    (actualSmoothCurveSheafGlobalCartier (p := p) sX)^[n] (c ^ (p ^ n) • a) =
      c • (actualSmoothCurveSheafGlobalCartier (p := p) sX)^[n] a := by
  induction n generalizing c a with
  | zero => simp only [pow_zero, pow_one, Function.iterate_zero, id_eq]
  | succ n ih =>
    have hexp : c ^ (p ^ (n + 1)) = (c ^ p) ^ (p ^ n) := by
      rw [pow_succ, Nat.mul_comm (p ^ n) p, pow_mul]
    rw [hexp, Function.iterate_succ_apply', ih,
      actualSmoothCurveSheafGlobalCartier_pth_semilinear,
      Function.iterate_succ_apply']

/-- The actual original H0 realization intertwines EVERY finite
Cartier iterate with its true rational iterate. No finite dimensionality,
cohomological model, or assumed height comparison occurs. -/
theorem actualSmoothCurveSheafGlobalCartier_iterate_rational
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI : CharP X.functionField p :=
      charP_of_injective_algebraMap (algebraMap k X.functionField).injective p
    ∀ (n : ℕ) (a : schemeDifferentialGlobalSections sX),
      schemeDifferentialGlobalSectionsToFunctionField sX
          ((actualSmoothCurveSheafGlobalCartier (p := p) sX)^[n] a) =
        ((actualSmoothCurveRationalCartier (p := p) sX).toAddHom)^[n]
          (schemeDifferentialGlobalSectionsToFunctionField sX a) := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI : CharP X.functionField p :=
    charP_of_injective_algebraMap (algebraMap k X.functionField).injective p
  intro n
  induction n with
  | zero => intro a; rfl
  | succ n ih =>
    intro a
    rw [Function.iterate_succ_apply', actualSmoothCurveSheafGlobalCartier_rational,
      ih, Function.iterate_succ_apply']

/-- The genuine ORIGINAL finite étale H0 pullback commutes with EVERY
Cartier iterate. Both schemes and the actual map remain unchanged. -/
theorem actualSmoothEtaleSheafGlobalCartier_iterate_pullback
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
    (f : X ⟶ Y) [IsFinite f] [IsEtale f] [Surjective f]
    (hover : f ≫ sY = sX) (n : ℕ) (a : schemeDifferentialGlobalSections sY) :
    (actualSmoothCurveSheafGlobalCartier (p := p) sX)^[n]
        (actualSmoothEtaleGlobalDifferentialPullback sX sY f hover a) =
      actualSmoothEtaleGlobalDifferentialPullback sX sY f hover
        ((actualSmoothCurveSheafGlobalCartier (p := p) sY)^[n] a) := by
  induction n with
  | zero => rfl
  | succ n ih =>
    rw [Function.iterate_succ_apply', ih,
      actualSmoothEtaleSheafGlobalCartier_pullback,
      Function.iterate_succ_apply']

/-- Actual Cartier-kernel filtration is nested at EVERY finite height.
This is a statement about genuine H0, without an unproved B_a or genus
identification. -/
theorem actualSmoothCurveSheafGlobalCartier_iterate_kernel_step
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    (n : ℕ) (a : schemeDifferentialGlobalSections sX)
    (ha : (actualSmoothCurveSheafGlobalCartier (p := p) sX)^[n] a = 0) :
    (actualSmoothCurveSheafGlobalCartier (p := p) sX)^[n + 1] a = 0 := by
  rw [Function.iterate_succ_apply', ha, map_zero]

end Litt3.SharedTensors
