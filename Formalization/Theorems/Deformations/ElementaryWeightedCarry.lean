import Solutions.Deformations.ElementaryWittGradedProduct
import Solutions.Deformations.ElementaryWittOriginalInitial
import Definitions.Deformations.ElementaryCriticalTheta
import Definitions.Deformations.ElementaryWittRepairSpace
import Definitions.Deformations.ElementaryWittQuadraticReduction
import Solutions.Deformations.ElementaryWittInitialPolynomial
import Solutions.Deformations.WeightedRootProductRelations

namespace Litt3.Deformations

open scoped BigOperators LinearAlgebra.Projectivization WeightedRootPolynomialScalars
  ElementaryGradedScalars

variable (k : Type*) [Field k] [Fact (Nat.Prime 5)] [CharP k 5] [PerfectRing k 5]

/-- The exact original rational-direction hypothesis. The coefficient
field can be any perfect extension of the prime field. -/
def ElementaryOriginalAnisotropy (r : ℕ) (q : MvPolynomial (Fin r) k) : Prop :=
  ∀ a : Fin r → ZMod 5, a ≠ 0 →
    q.eval (fun i => ZMod.castHom (dvd_refl 5) k (a i)) ≠ 0

section Precision

variable (N : ℕ) [Fact (0 < N)] (r : ℕ)

local instance : Nontrivial (TruncatedWittVector 5 N k) :=
  truncated_witt_nontrivial 5 N (Fact.out : 0 < N) k

/-- Genuine quotient classes, their derived field action, and their
natural product identify every degree with the entire literal degree
of the actual finite parameter quotient. Foundational constructions
are imported because these are actual maps, not presumed interfaces. -/
structure ElementaryWeightedCarryGrading : Prop where
  equivalence : ∀ d, Nonempty (ElementaryWittGradedClass N k r d ≃ₗ[k]
    elementaryTruncatedParameterDegree N k r d)
  scalar : ∀ d (t : TruncatedWittVector 5 N k)
      (x : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d),
    (QuotientAddGroup.mk (t • x) : ElementaryWittGradedClass N k r d) =
      truncatedWittResidue 5 N (Fact.out : 0 < N) k t •
        (QuotientAddGroup.mk x : ElementaryWittGradedClass N k r d)
  naturalProduct : ∀ d e
      (x : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r d)
      (y : elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r e),
    elementaryWittGradedClassProduct N k r d e (QuotientAddGroup.mk x) (QuotientAddGroup.mk y) =
      QuotientAddGroup.mk (elementaryWittWeightProduct N k r d e x y)
  comparisonProduct : ∀ d e (x : ElementaryWittGradedClass N k r d)
      (y : ElementaryWittGradedClass N k r e),
    (elementaryWittGradedClassLinearEquiv N k r (d + e)
      (elementaryWittGradedClassProduct N k r d e x y)).val =
        (elementaryWittGradedClassLinearEquiv N k r d x).val *
          (elementaryWittGradedClassLinearEquiv N k r e y).val
  originalParameters : ∀ i : Fin r,
    ∃ member : elementaryAugmentationParameter (R := TruncatedWittVector 5 N k) 5 r i ∈
        elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r 1,
      elementaryWittAssociatedMap N k r 1 ⟨_, member⟩ =
        weightedRootProductParameter (TruncatedCoefficientRing k N) 5 (truncatedParameter k N) r i
  originalPrime : ∃ member : (5 : AddMonoidAlgebra (TruncatedWittVector 5 N k)
        (Fin r → ZMod 5)) ∈
        elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r 4,
    elementaryWittAssociatedMap N k r 4 ⟨_, member⟩ =
      algebraMap (TruncatedCoefficientRing k N)
        (weightedRootProduct (TruncatedCoefficientRing k N) 5 (truncatedParameter k N) r)
          (truncatedParameter k N)
  parameterTruncation : (truncatedParameter k N) ^ N = 0
  parameterRelations : ∀ i : Fin r,
    weightedRootProductParameter (TruncatedCoefficientRing k N) 5 (truncatedParameter k N) r i ^ 5 =
      -algebraMap (TruncatedCoefficientRing k N)
        (weightedRootProduct (TruncatedCoefficientRing k N) 5 (truncatedParameter k N) r)
          (truncatedParameter k N) *
        weightedRootProductParameter (TruncatedCoefficientRing k N) 5 (truncatedParameter k N) r i

/-- The full finite-precision kernel clause, strengthened to positive
precision. The only operator hypotheses are the literal source ones. -/
def ElementaryWeightedCarryPrecision : Prop :=
  ∀ (L : AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5) →+
      AddMonoidAlgebra (TruncatedWittVector 5 N k) (Fin r → ZMod 5))
    (q : MvPolynomial (Fin r) k),
    ElementaryWittQuadraticReduction N k r L q → ElementaryOriginalAnisotropy k r q →
    ∀ x, L x = 0 → x ∈
      elementaryNormalWeightFiltration (TruncatedWittVector 5 N k) 5 (by omega) r (4 * N - 1)

end Precision

section FinalPrecision

variable (r : ℕ)
variable [Fintype (ℙ (ZMod 5) (Fin r → ZMod 5))]

local instance : Fact (0 < r + 1) := ⟨by omega⟩
local instance : Nontrivial (TruncatedWittVector 5 (r + 1) k) :=
  truncated_witt_nontrivial 5 (r + 1) (by omega) k

/-- All final-precision source clauses in the original Witt group
algebra. The repair space is literally 5 Lambda + W(4r). -/
structure ElementaryWeightedCarryFinal
    (L : AddMonoidAlgebra (TruncatedWittVector 5 (r + 1) k) (Fin r → ZMod 5) →+
      AddMonoidAlgebra (TruncatedWittVector 5 (r + 1) k) (Fin r → ZMod 5))
    (q : MvPolynomial (Fin r) k) : Prop where
  kernel : ∀ x, L x = 0 → x ∈ elementaryNormalWeightFiltration
    (TruncatedWittVector 5 (r + 1) k) 5 (by omega) r (4 * r)
  tail : ∀ z, z ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 (r + 1) k)
      5 (by omega) r (4 * r + 2) →
    ∃ x, x ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 (r + 1) k)
      5 (by omega) r (4 * r) ∧ L x = z
  normLine : ∀ y : AddMonoidAlgebra k (Fin r → ZMod 5),
    (∃ x : AddMonoidAlgebra (TruncatedWittVector 5 (r + 1) k) (Fin r → ZMod 5),
      x ∈ elementaryNormalWeightFiltration (TruncatedWittVector 5 (r + 1) k)
        5 (by omega) r (4 * r) ∧
      AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod 5)
        (truncatedWittResidue 5 (r + 1) (by omega) k) x = y) ↔
      ∃ c : k, y = c • ∑ g : Fin r → ZMod 5, AddMonoidAlgebra.single g (1 : k)
  detector : ∀ R : elementaryNormalWeightFiltration (TruncatedWittVector 5 (r + 1) k)
      5 (by omega) r (4 * r + 1),
    (∀ i : Fin r, elementaryCriticalTheta k r q
      (elementaryWittInitialPolynomial (r + 1) k r (4 * r + 1) R) i = 0) ↔
    ∃ x : AddMonoidAlgebra (TruncatedWittVector 5 (r + 1) k) (Fin r → ZMod 5),
      x ∈ elementaryWittRepairSpace (r + 1) k r ∧ L x = R.val
  projectiveIndependence : ∀
      (Z : weightedRootProduct (Polynomial k) 5 Polynomial.X r)
      (_ : Z ∈ weightedRootHomogeneousComponent k 5 (by omega) r (4 * r + 1))
      (i : Fin r) (a b : Fin r → ZMod 5) (ha : a ≠ 0) (hb : b ≠ 0),
    Projectivization.mk (ZMod 5) a ha = Projectivization.mk (ZMod 5) b hb →
      ZMod.castHom (dvd_refl 5) k (a i) *
        weightedRootPolynomialFunctionEvaluation (ZMod 5) k (ZMod.castHom (dvd_refl 5) k) r Z a /
          q.eval (fun j => ZMod.castHom (dvd_refl 5) k (a j)) =
      ZMod.castHom (dvd_refl 5) k (b i) *
        weightedRootPolynomialFunctionEvaluation (ZMod 5) k (ZMod.castHom (dvd_refl 5) k) r Z b /
          q.eval (fun j => ZMod.castHom (dvd_refl 5) k (b j))

end FinalPrecision

/-- The whole canonical abstract theorem, indexed over its actual Witt
precisions and original additive operators. This asserts no nonlinear
geometric comparison estimate or detector vanishing. -/
structure ElementaryWeightedCarryResult (r : ℕ)
    [Fintype (ℙ (ZMod 5) (Fin r → ZMod 5))] : Prop where
  grading : ∀ N (positive : 0 < N), @ElementaryWeightedCarryGrading k _ _ _ _ N ⟨positive⟩ r
  precision : ∀ N (positive : 0 < N), N ≤ r →
    @ElementaryWeightedCarryPrecision k _ _ _ _ N ⟨positive⟩ r
  final : ∀ (L : AddMonoidAlgebra (TruncatedWittVector 5 (r + 1) k) (Fin r → ZMod 5) →+
      AddMonoidAlgebra (TruncatedWittVector 5 (r + 1) k) (Fin r → ZMod 5))
      (q : MvPolynomial (Fin r) k),
    @ElementaryWittQuadraticReduction (r + 1) ⟨by omega⟩ k _ _ _ _ r L q →
    ElementaryOriginalAnisotropy k r q → ElementaryWeightedCarryFinal k r L q

end Litt3.Deformations
