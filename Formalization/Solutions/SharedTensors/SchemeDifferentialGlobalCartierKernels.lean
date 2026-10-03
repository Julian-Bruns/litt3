import Solutions.SharedTensors.SchemeDifferentialGlobalCartierIterations
import Solutions.CartierAndSpin.SmoothEtaleGlobalDifferentialInjection

open CategoryTheory AlgebraicGeometry

set_option maxHeartbeats 1000000
set_option synthInstance.maxHeartbeats 200000

namespace Litt3.SharedTensors

open Litt3.QuotientGeometry Litt3.CartierAndSpin

universe u

variable {k : Type u} [Field k] [PerfectField k] [IsAlgClosed k]
  {X Y : Scheme.{u}} [IsIntegral X] [IsIntegral Y]
  {p : ℕ} [Fact p.Prime] [CharP k p]

/-- The literal kernel of EVERY actual Cartier iterate on ORIGINAL H0
is a genuine k-submodule. Closure under the original scalar action is
derived from inverse-p^n semilinearity and actual coefficient roots. -/
noncomputable def actualSmoothCurveSheafGlobalCartierKernel
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] (n : ℕ) :
    Submodule k (schemeDifferentialGlobalSections sX) where
  carrier := {a | (actualSmoothCurveSheafGlobalCartier (p := p) sX)^[n] a = 0}
  zero_mem' := iterate_map_zero _ n
  add_mem' := by
    intro a b ha hb
    change (actualSmoothCurveSheafGlobalCartier (p := p) sX)^[n] (a + b) = 0
    rw [iterate_map_add, ha, hb, add_zero]
  smul_mem' := by
    intro c a ha
    change (actualSmoothCurveSheafGlobalCartier (p := p) sX)^[n] (c • a) = 0
    obtain ⟨z, hz⟩ := IsAlgClosed.exists_pow_nat_eq c
      (pow_pos (Fact.out : p.Prime).pos n)
    rw [← hz, actualSmoothCurveSheafGlobalCartier_iterate_semilinear, ha, smul_zero]

@[simp] theorem mem_actualSmoothCurveSheafGlobalCartierKernel
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    (n : ℕ) (a : schemeDifferentialGlobalSections sX) :
    a ∈ actualSmoothCurveSheafGlobalCartierKernel (p := p) sX n ↔
      (actualSmoothCurveSheafGlobalCartier (p := p) sX)^[n] a = 0 := Iff.rfl

/-- The true height-zero kernel is zero. -/
@[simp] theorem actualSmoothCurveSheafGlobalCartierKernel_zero
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] :
    actualSmoothCurveSheafGlobalCartierKernel (p := p) sX 0 = ⊥ := by
  ext a
  simp only [mem_actualSmoothCurveSheafGlobalCartierKernel,
    Function.iterate_zero, id_eq, Submodule.mem_bot]

/-- The ORIGINAL Cartier-kernel filtration is ascending at ALL
heights. No finite H0 or presumed stabilization is used. -/
theorem actualSmoothCurveSheafGlobalCartierKernel_mono
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    {m n : ℕ} (hmn : m ≤ n) :
    actualSmoothCurveSheafGlobalCartierKernel (p := p) sX m ≤
      actualSmoothCurveSheafGlobalCartierKernel (p := p) sX n := by
  intro a ha
  induction n, hmn using Nat.le_induction with
  | base => exact ha
  | succ n hmn ih =>
    exact actualSmoothCurveSheafGlobalCartier_iterate_kernel_step sX n a ih

/-- EVERY finite-height original Cartier kernel is both preserved
and REFLECTED by the actual finite étale H0 pullback. The equality is
of true submodules of original sheaf sections, not a rational model. -/
theorem actualSmoothEtaleSheafGlobalCartierKernel_comap
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
    (f : X ⟶ Y) [IsFinite f] [IsEtale f] [Surjective f]
    (hover : f ≫ sY = sX) (n : ℕ) :
    (actualSmoothCurveSheafGlobalCartierKernel (p := p) sX n).comap
        (actualSmoothEtaleGlobalDifferentialPullback sX sY f hover) =
      actualSmoothCurveSheafGlobalCartierKernel (p := p) sY n := by
  ext a
  simp only [Submodule.mem_comap, mem_actualSmoothCurveSheafGlobalCartierKernel]
  rw [actualSmoothEtaleSheafGlobalCartier_iterate_pullback]
  constructor
  · intro h
    apply actualSmoothEtaleGlobalDifferentialPullback_injective sX sY f hover
    exact h.trans (map_zero _).symm
  · intro h
    rw [h, map_zero]

/-- Height one consists exactly of genuine H0 forms with an actual
rational primitive. Higher-height B_a cohomological identifications are
not presumed by this filtration construction. -/
theorem actualSmoothCurveSheafGlobalCartierKernel_one_iff_exact
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX] :
    letI := (genericBaseFieldHom sX).toAlgebra
    letI : Nonempty (⊤ : X.Opens) := ⟨⟨genericPoint X, trivial⟩⟩
    ∀ a : schemeDifferentialGlobalSections sX,
      a ∈ actualSmoothCurveSheafGlobalCartierKernel (p := p) sX 1 ↔
        ∃ f : X.functionField, KaehlerDifferential.D k X.functionField f =
          schemeDifferentialSheafOpenToFunctionField sX ⊤ a := by
  letI := (genericBaseFieldHom sX).toAlgebra
  letI : Nonempty (⊤ : X.Opens) := ⟨⟨genericPoint X, trivial⟩⟩
  intro a
  rw [mem_actualSmoothCurveSheafGlobalCartierKernel, Function.iterate_one]
  exact actualSmoothCurveSheafGlobalCartier_zero_iff_rational_exact sX a

end Litt3.SharedTensors
