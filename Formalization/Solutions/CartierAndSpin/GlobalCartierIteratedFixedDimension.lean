import Solutions.CartierAndSpin.GlobalCartierFixedDimension
import Solutions.CartierAndSpin.InverseFrobeniusIteratedFixedCardinality

open CategoryTheory AlgebraicGeometry

namespace Litt3.CartierAndSpin

open Litt3.SharedTensors Litt3.QuotientGeometry

universe u

variable {k : Type u} [Field k] [PerfectField k] [IsAlgClosed k]
    {X : Scheme.{u}} [IsIntegral X] {p : ℕ} [Fact p.Prime] [CharP k p]

/-- On genuine original differential-sheaf H0, EVERY positive actual
Cartier iterate has a finite fixed group bounded by p^(n*dim H0).
Finite dimension of this actual H0 space is an explicit input; genus
and proper coherent-cohomology finiteness are not presumed. -/
theorem actual_H0_cartier_iterated_fixed_finite_and_card_le
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    [Module.Finite k (schemeDifferentialGlobalSections sX)]
    (n : ℕ) (hn : 0 < n) :
    let C : AddMonoid.End (schemeDifferentialGlobalSections sX) :=
      actualSmoothCurveSheafGlobalCartier (p := p) sX
    Finite (C ^ n - 1).ker ∧
      Nat.card (C ^ n - 1).ker ≤
          p ^ (n * Module.finrank k (schemeDifferentialGlobalSections sX)) :=
  inverse_frobenius_iterated_fixed_kernel_finite_and_card_le
    (actualSmoothCurveSheafGlobalCartier (p := p) sX)
    (actualSmoothCurveSheafGlobalCartier_pth_semilinear sX) n hn

variable {Y : Scheme.{u}} [IsIntegral Y]
    (s : FiniteEtaleSpan X Y) [IsIntegral s.source]
    (sX : X ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sX]
    (sY : Y ⟶ Spec (.of k)) [IsSmoothOfRelativeDimension 1 sY]
    (hbase : s.right ≫ sY = s.left ≫ sX)

/-- The literal BOTH-endpoint original H0-image intersection in the
SAME source has the same all-positive-iterate bound. No rank-one,
constant-intersection, clump or operator-invertibility premise is used. -/
theorem actual_shared_H0_cartier_iterated_fixed_finite_and_card_le
    [Module.Finite k (actualSharedGlobalDifferentialSubspace s sX sY hbase)]
    (n : ℕ) (hn : 0 < n) :
    let C : AddMonoid.End (actualSharedGlobalDifferentialSubspace s sX sY hbase) :=
      actualSharedGlobalCartier (p := p) s sX sY hbase
    Finite (C ^ n - 1).ker ∧
      Nat.card (C ^ n - 1).ker ≤
          p ^ (n * Module.finrank k
            (actualSharedGlobalDifferentialSubspace s sX sY hbase)) :=
  inverse_frobenius_iterated_fixed_kernel_finite_and_card_le
    (actualSharedGlobalCartier (p := p) s sX sY hbase)
    (actualSharedGlobalCartier_pth_semilinear s sX sY hbase) n hn

end Litt3.CartierAndSpin
