import Solutions.CartierAndSpin.InverseFrobeniusFixedDimension
import Definitions.CartierAndSpin.SharedGlobalCartierFixed

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [PerfectField k] [IsAlgClosed k]
    {X : Scheme.{u}} [IsIntegral X] {p : ℕ} [Fact p.Prime] [CharP k p]

/-- On literal global sections of the ORIGINAL differential sheaf,
finite k-dimension yields a finite actual Cartier fixed group and its
sharp size bound. Finite H0 is an explicit input; no genus identification
or cohomological finiteness is presumed. -/
theorem actual_H0_cartier_fixed_finite_and_card_le
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    [Module.Finite k (schemeDifferentialGlobalSections sX)] :
    Finite (actualSmoothCurveSheafGlobalCartier (p := p) sX -
        AddMonoidHom.id (schemeDifferentialGlobalSections sX)).ker ∧
      Nat.card (actualSmoothCurveSheafGlobalCartier (p := p) sX -
        AddMonoidHom.id (schemeDifferentialGlobalSections sX)).ker ≤
          p ^ Module.finrank k (schemeDifferentialGlobalSections sX) :=
  ⟨inverse_frobenius_fixed_kernel_finite
      (actualSmoothCurveSheafGlobalCartier (p := p) sX)
      (actualSmoothCurveSheafGlobalCartier_pth_semilinear sX),
    inverse_frobenius_fixed_kernel_card_le
      (actualSmoothCurveSheafGlobalCartier (p := p) sX)
      (actualSmoothCurveSheafGlobalCartier_pth_semilinear sX)⟩

variable {Y : Scheme.{u}} [IsIntegral Y]
    (s : FiniteEtaleSpan X Y) [IsIntegral s.source]
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
    (hbase : s.right ≫ sY = s.left ≫ sX)

/-- The same bound on the literal Cartier fixed group in BOTH original
H0 images in the SAME smooth source. Finite dimension of that actual
intersection is explicit; no constant-intersection, clump or rank-one
hypothesis is required. -/
theorem actual_shared_H0_cartier_fixed_finite_and_card_le
    [Module.Finite k (actualSharedGlobalDifferentialSubspace s sX sY hbase)] :
    Finite (actualSharedGlobalCartierFixed (p := p) s sX sY hbase) ∧
      Nat.card (actualSharedGlobalCartierFixed (p := p) s sX sY hbase) ≤
        p ^ Module.finrank k (actualSharedGlobalDifferentialSubspace s sX sY hbase) :=
  ⟨inverse_frobenius_fixed_kernel_finite
      (actualSharedGlobalCartier (p := p) s sX sY hbase)
      (actualSharedGlobalCartier_pth_semilinear s sX sY hbase),
    inverse_frobenius_fixed_kernel_card_le
      (actualSharedGlobalCartier (p := p) s sX sY hbase)
      (actualSharedGlobalCartier_pth_semilinear s sX sY hbase)⟩

end Litt3.CartierAndSpin
