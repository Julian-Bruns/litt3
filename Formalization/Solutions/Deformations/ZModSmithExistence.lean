import Solutions.Deformations.ResidueOperatorDiagonalization
import Solutions.Deformations.ZModPowerUnitFactorization
import Definitions.Deformations.ScalarPowerDiagonalization
import Mathlib.LinearAlgebra.Pi

namespace Litt3.Deformations

/-- Existence of an actual prime-power Smith diagonalization for
every square operator over Z/p^N. Both basis changes and the whole
operator identity are constructed from the checked integral PID
theorem. No factor counts or cokernel result are inputs. -/
theorem zmod_pi_smith_existence (p N d : ℕ) [Fact p.Prime]
    (A : Module.End (ZMod (p ^ N)) (Fin d → ZMod (p ^ N))) :
    Nonempty (ScalarPowerDiagonalization (p : ZMod (p ^ N)) d N A) := by
  classical
  haveI : NeZero (p ^ N) := ⟨pow_ne_zero _ (Fact.out : p.Prime).ne_zero⟩
  obtain ⟨source, target, diagonal, equation⟩ := residue_operator_diagonalization (p ^ N) d A
  choose exponent unit bound factor using fun i => zmod_prime_power_unit_factorization p N (diagonal i)
  let normalize : (Fin d → ZMod (p ^ N)) ≃ₗ[ZMod (p ^ N)] (Fin d → ZMod (p ^ N)) :=
    LinearEquiv.piCongrRight fun i => LinearEquiv.smulOfUnit (M := ZMod (p ^ N)) (unit i)⁻¹
  refine ⟨⟨source, target.trans normalize, exponent, bound, ?_⟩⟩
  intro v
  ext i
  change (↑((unit i)⁻¹) : ZMod (p ^ N)) * target (A (source.symm v)) i =
    (p : ZMod (p ^ N)) ^ exponent i * v i
  rw [equation]
  dsimp only
  rw [factor]
  calc
    (↑((unit i)⁻¹) : ZMod (p ^ N)) * ((p : ZMod (p ^ N)) ^ exponent i * (unit i) * v i) =
        (p : ZMod (p ^ N)) ^ exponent i * ((↑((unit i)⁻¹) : ZMod (p ^ N)) * unit i) * v i := by ring
    _ = _ := by simp

/-- The same existence theorem for any actual finite coordinate
equivalence, retaining the original module and original operator. -/
theorem zmod_smith_existence (p N d : ℕ) [Fact p.Prime]
    {M : Type*} [AddCommGroup M] [Module (ZMod (p ^ N)) M]
    (basis : M ≃ₗ[ZMod (p ^ N)] (Fin d → ZMod (p ^ N)))
    (A : Module.End (ZMod (p ^ N)) M) :
    Nonempty (ScalarPowerDiagonalization (p : ZMod (p ^ N)) d N A) := by
  let B := basis.toLinearMap.comp (A.comp basis.symm.toLinearMap)
  obtain ⟨normal⟩ := zmod_pi_smith_existence p N d B
  refine ⟨⟨basis.trans normal.source, basis.trans normal.target,
    normal.exponent, normal.exponent_bound, ?_⟩⟩
  intro v
  simpa [B] using normal.equation v

end Litt3.Deformations
