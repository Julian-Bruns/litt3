import Solutions.Deformations.WeightedRootBaseCoordinates
import Solutions.Deformations.TruncatedCoefficientRing

namespace Litt3.Deformations

variable (k : Type*) [CommRing k] [Nontrivial k]

/-- Actual parameter truncation of the actual tensor quotient,
through the literal polynomial quotient k[tau]/tau^m. -/
noncomputable def weightedRootTruncation (q m : ℕ) (positive : 0 < m) (r : ℕ) :
    weightedRootProduct (Polynomial k) q Polynomial.X r →+*
      weightedRootProduct (TruncatedCoefficientRing k m) q (truncatedParameter k m) r := by
  letI : Nontrivial (TruncatedCoefficientRing k m) := (truncatedResidue k m positive).domain_nontrivial
  exact weightedRootProductBaseMap (AdjoinRoot.mk ((Polynomial.X : Polynomial k) ^ m))
    q Polynomial.X r

/-- The actual truncation kernel is exact divisibility of every
unchanged original normal coefficient by the actual parameter power. -/
theorem weighted_root_truncation_kernel (q : ℕ) (large : 1 < q) (m : ℕ) (positive : 0 < m)
    (r : ℕ) (x : weightedRootProduct (Polynomial k) q Polynomial.X r) :
    weightedRootTruncation k q m positive r x = 0 ↔
      ∀ alpha : Fin r → Fin q, (Polynomial.X : Polynomial k) ^ m ∣
        (weightedRootProductBasis q large Polynomial.X r).repr x alpha := by
  letI : Nontrivial (TruncatedCoefficientRing k m) := (truncatedResidue k m positive).domain_nontrivial
  let target := weightedRootProductBasis q large (truncatedParameter k m) r
  constructor
  · intro vanish alpha
    have coordinate := congrArg (fun z => target.repr z alpha) vanish
    dsimp only at coordinate
    rw [map_zero, Finsupp.zero_apply] at coordinate
    change (weightedRootProductBasis q large _ r).repr
      (weightedRootProductBaseMap (AdjoinRoot.mk ((Polynomial.X : Polynomial k) ^ m))
        q Polynomial.X r x) alpha = 0 at coordinate
    rw [weighted_root_base_map_coordinates] at coordinate
    exact AdjoinRoot.mk_eq_zero.mp coordinate
  · intro coordinates
    apply target.repr.injective
    ext alpha
    rw [map_zero, Finsupp.zero_apply]
    change (weightedRootProductBasis q large _ r).repr
      (weightedRootProductBaseMap (AdjoinRoot.mk ((Polynomial.X : Polynomial k) ^ m))
        q Polynomial.X r x) alpha = 0
    rw [weighted_root_base_map_coordinates]
    exact AdjoinRoot.mk_eq_zero.mpr (coordinates alpha)

end Litt3.Deformations
