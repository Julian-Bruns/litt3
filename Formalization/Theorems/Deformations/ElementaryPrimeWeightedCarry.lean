import Solutions.Deformations.ElementaryPrimeWittGradedProduct
import Solutions.Deformations.ElementaryPrimeWittOriginalInitial
import Definitions.Deformations.ElementaryPrimeCriticalTheta
import Definitions.Deformations.ElementaryPrimeWittRepairSpace
import Definitions.Deformations.ElementaryPrimeWittReduction
import Solutions.Deformations.ElementaryPrimeWittInitialPolynomial
import Theorems.Deformations.ElementaryPrimeCriticalDimensions
import Definitions.Deformations.ElementaryAugmentationDegreeSpan
import Solutions.Deformations.WeightedRootProductRelations
import Solutions.Deformations.ElementaryOriginalIntegralNorm
import Solutions.Deformations.ElementaryPrimeCriticalExponents

namespace Litt3.Deformations

open scoped BigOperators LinearAlgebra.Projectivization WeightedRootPolynomialScalars
  ElementaryPrimeGradedScalars

variable (p : ℕ) [Fact p.Prime]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

/-- Nonvanishing only on the original rational directions, as in the
canonical theorem, over any perfect extension of the original prime field. -/
def ElementaryPrimeOriginalAnisotropy (r : ℕ) (q : MvPolynomial (Fin r) k) : Prop :=
  ∀ v : Fin r → ZMod p, v ≠ 0 →
    q.eval (fun i => ZMod.castHom (dvd_refl p) k (v i)) ≠ 0

section Precision

variable (N : ℕ) [Fact (0 < N)] (r : ℕ)

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

/-- The actual associated-weight quotient, derived coefficient-field
action, full natural product and literal original generators identify
every degree of the genuine finite parameter quotient. -/
structure ElementaryPrimeWeightedCarryGrading : Prop where
  equivalence : ∀ d, Nonempty (ElementaryPrimeWittGradedClass p N k r d ≃ₗ[k]
    elementaryPrimeTruncatedParameterDegree p N k r d)
  scalar : ∀ d (t : TruncatedWittVector p N k)
      (x : elementaryNormalWeightFiltration (TruncatedWittVector p N k)
        p (Fact.out : p.Prime).pos r d),
    (QuotientAddGroup.mk (t • x) : ElementaryPrimeWittGradedClass p N k r d) =
      truncatedWittResidue p N (Fact.out : 0 < N) k t •
        (QuotientAddGroup.mk x : ElementaryPrimeWittGradedClass p N k r d)
  naturalProduct : ∀ d e
      (x : elementaryNormalWeightFiltration (TruncatedWittVector p N k)
        p (Fact.out : p.Prime).pos r d)
      (y : elementaryNormalWeightFiltration (TruncatedWittVector p N k)
        p (Fact.out : p.Prime).pos r e),
    elementaryPrimeWittGradedClassProduct p N k r d e (QuotientAddGroup.mk x)
      (QuotientAddGroup.mk y) =
        QuotientAddGroup.mk (elementaryPrimeWittWeightProduct p N k r d e x y)
  comparisonProduct : ∀ d e (x : ElementaryPrimeWittGradedClass p N k r d)
      (y : ElementaryPrimeWittGradedClass p N k r e),
    (elementaryPrimeWittGradedClassLinearEquiv p N k r (d + e)
      (elementaryPrimeWittGradedClassProduct p N k r d e x y)).val =
        (elementaryPrimeWittGradedClassLinearEquiv p N k r d x).val *
          (elementaryPrimeWittGradedClassLinearEquiv p N k r e y).val
  originalParameters : ∀ i : Fin r,
    ∃ member : elementaryAugmentationParameter (R := TruncatedWittVector p N k) p r i ∈
        elementaryNormalWeightFiltration (TruncatedWittVector p N k)
          p (Fact.out : p.Prime).pos r 1,
      elementaryPrimeWittAssociatedMap p N k r 1 ⟨_, member⟩ =
        weightedRootProductParameter (TruncatedCoefficientRing k N) p (truncatedParameter k N) r i
  originalPrime : ∃ member : (p : AddMonoidAlgebra (TruncatedWittVector p N k)
        (Fin r → ZMod p)) ∈ elementaryNormalWeightFiltration (TruncatedWittVector p N k)
          p (Fact.out : p.Prime).pos r (p - 1),
    elementaryPrimeWittAssociatedMap p N k r (p - 1) ⟨_, member⟩ =
      algebraMap (TruncatedCoefficientRing k N)
        (weightedRootProduct (TruncatedCoefficientRing k N) p (truncatedParameter k N) r)
          (truncatedParameter k N)
  parameterTruncation : (truncatedParameter k N) ^ N = 0
  parameterRelations : ∀ i : Fin r,
    weightedRootProductParameter (TruncatedCoefficientRing k N) p (truncatedParameter k N) r i ^ p =
      -algebraMap (TruncatedCoefficientRing k N)
        (weightedRootProduct (TruncatedCoefficientRing k N) p (truncatedParameter k N) r)
          (truncatedParameter k N) *
        weightedRootProductParameter (TruncatedCoefficientRing k N) p (truncatedParameter k N) r i

end Precision

section IntegralPrecision

variable (r : ℕ) [Fact (0 < r)] (a : ℕ)

local instance : Nontrivial (TruncatedWittVector p r k) :=
  truncated_witt_nontrivial p r (Fact.out : 0 < r) k

/-- Entire integral norm-target clause at precision r, in the literal
Witt algebra, with its full augmentation and genuine leading ideals. -/
structure ElementaryPrimeWeightedCarryIntegral
    (L : AddMonoidAlgebra (TruncatedWittVector p r k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p r k) (Fin r → ZMod p)) : Prop where
  normTarget : ∀ x (eta : TruncatedWittVector p r k),
    L x = eta • elementaryOriginalNorm (R := TruncatedWittVector p r k) p r →
    x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p r k)
      p (Fact.out : p.Prime).pos r ((p - 1) * r - a) ∧
        additiveGroupAlgebraAugmentation x = 0
  leadingNorm : ∀ x (eta : TruncatedWittVector p r k),
    L x = eta • elementaryOriginalNorm (R := TruncatedWittVector p r k) p r →
    AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p)
      (truncatedWittResidue p r (Fact.out : 0 < r) k) x ∈
        (elementaryOriginalAugmentationIdeal k p r ^ (a + 1)).annihilator
  divisibleNormTarget : ∀ x (eta : TruncatedWittVector p r k),
    truncatedWittResidue p r (Fact.out : 0 < r) k eta = 0 →
    L x = eta • elementaryOriginalNorm (R := TruncatedWittVector p r k) p r →
    x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p r k)
      p (Fact.out : p.Prime).pos r ((p - 1) * r - a + 1)
  divisibleLeadingNorm : ∀ x (eta : TruncatedWittVector p r k),
    truncatedWittResidue p r (Fact.out : 0 < r) k eta = 0 →
    L x = eta • elementaryOriginalNorm (R := TruncatedWittVector p r k) p r →
    AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p)
      (truncatedWittResidue p r (Fact.out : 0 < r) k) x ∈
        (elementaryOriginalAugmentationIdeal k p r ^ a).annihilator
  annihilatorIdentity : (elementaryOriginalAugmentationIdeal k p r ^ (a + 1)).annihilator =
      elementaryOriginalAugmentationIdeal k p r ^ ((p - 1) * r - a)
  divisibleAnnihilatorIdentity : (elementaryOriginalAugmentationIdeal k p r ^ a).annihilator =
      elementaryOriginalAugmentationIdeal k p r ^ ((p - 1) * r - a + 1)

end IntegralPrecision

section FinalPrecision

variable (r a : ℕ) [Fintype (ℙ (ZMod p) (Fin r → ZMod p))]

local instance : Fact (0 < r + 1) := ⟨by omega⟩
local instance : Nontrivial (TruncatedWittVector p (r + 1) k) :=
  truncated_witt_nontrivial p (r + 1) (by omega) k

/-- Every final-precision clause for the entire actual operator. The
detector retains the actual whole signed sum and inverse Frobenius. -/
structure ElementaryPrimeWeightedCarryFinal (large : 2 < p)
    (L : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p))
    (q : MvPolynomial (Fin r) k) : Prop where
  kernel : ∀ x, L x = 0 → x ∈ elementaryNormalWeightFiltration
    (TruncatedWittVector p (r + 1) k) p (Fact.out : p.Prime).pos r ((p - 1) * r)
  tail : ∀ z, z ∈ elementaryNormalWeightFiltration (TruncatedWittVector p (r + 1) k)
      p (Fact.out : p.Prime).pos r ((p - 1) * r + a) →
    ∃ x, x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p (r + 1) k)
      p (Fact.out : p.Prime).pos r ((p - 1) * r) ∧ L x = z
  normLine : ∀ y : AddMonoidAlgebra k (Fin r → ZMod p),
    (∃ x : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p),
      x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p (r + 1) k)
        p (Fact.out : p.Prime).pos r ((p - 1) * r) ∧
      AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p)
        (truncatedWittResidue p (r + 1) (by omega) k) x = y) ↔
      ∃ c : k, y = c • elementaryOriginalNorm (R := k) p r
  detector : ∀ R : elementaryNormalWeightFiltration (TruncatedWittVector p (r + 1) k)
      p (Fact.out : p.Prime).pos r ((p - 1) * r + a - 1),
    (∀ i : Fin r, elementaryPrimeCriticalTheta p k r q
      (elementaryPrimeWittInitialPolynomial p (r + 1) k r ((p - 1) * r + a - 1) R) i = 0) ↔
    ∃ x : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p),
      x ∈ elementaryPrimeWittRepairSpace p (r + 1) k r ∧ L x = R.val
  criticalDivision : ∀ Z : weightedRootProduct (Polynomial k) p Polynomial.X r,
    Z ∈ weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r
      ((p - 1) * r + a - 1) →
    ∃! H : weightedRootProduct (Polynomial k) p Polynomial.X r,
      H ∈ weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r
        ((p - 1) * r - 1) ∧
      weightedRootPolynomialEvaluation p Polynomial.X r (MvPolynomial.map Polynomial.C q) * H = Z
  detectorCoefficients : ∀ H Z : weightedRootProduct (Polynomial k) p Polynomial.X r,
    H ∈ weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r
      ((p - 1) * r - 1) →
    weightedRootPolynomialEvaluation p Polynomial.X r (MvPolynomial.map Polynomial.C q) * H = Z →
    ∀ i : Fin r, elementaryPrimeCriticalTheta p k r q Z i =
      (_root_.frobeniusEquiv k p).symm
        ((weightedRootPolynomialBasis k p (Fact.out : p.Prime).one_lt r).repr H
          (0, primeDetectorExponent p large i))
  dimensions : Specifications.ElementaryPrimeCriticalDimensions p r a k
  projectiveIndependence : ∀
      (Z : weightedRootProduct (Polynomial k) p Polynomial.X r)
      (_ : Z ∈ weightedRootHomogeneousComponent k p (Fact.out : p.Prime).one_lt r
        ((p - 1) * r + a - 1))
      (i : Fin r) (v w : Fin r → ZMod p) (hv : v ≠ 0) (hw : w ≠ 0),
    Projectivization.mk (ZMod p) v hv = Projectivization.mk (ZMod p) w hw →
      ZMod.castHom (dvd_refl p) k (v i) *
        primeWeightedPolynomialFunction p k (ZMod.castHom (dvd_refl p) k) r Z v /
          q.eval (fun j => ZMod.castHom (dvd_refl p) k (v j)) =
      ZMod.castHom (dvd_refl p) k (w i) *
        primeWeightedPolynomialFunction p k (ZMod.castHom (dvd_refl p) k) r Z w /
          q.eval (fun j => ZMod.castHom (dvd_refl p) k (w j))
  normNecessary : ∀ (eta : TruncatedWittVector p (r + 1) k) x,
    L x = eta • elementaryOriginalNorm (R := TruncatedWittVector p (r + 1) k) p r →
    truncatedWittResidue p (r + 1) (by omega) k eta = 0 ∧
      x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p (r + 1) k)
        p (Fact.out : p.Prime).pos r ((p - 1) * r)
  normSoluble : ∀ eta : TruncatedWittVector p (r + 1) k,
    (∃ x, L x = eta • elementaryOriginalNorm (R := TruncatedWittVector p (r + 1) k) p r) ↔
      truncatedWittResidue p (r + 1) (by omega) k eta = 0
  fullNormFiber : ∀ (eta : TruncatedWittVector p (r + 1) k)
      (y : AddMonoidAlgebra k (Fin r → ZMod p)),
    (∃ x, L x = eta • elementaryOriginalNorm (R := TruncatedWittVector p (r + 1) k) p r ∧
      AddMonoidAlgebra.mapRangeRingHom (Fin r → ZMod p)
        (truncatedWittResidue p (r + 1) (by omega) k) x = y) ↔
    truncatedWittResidue p (r + 1) (by omega) k eta = 0 ∧
      ∃ c : k, y = c • elementaryOriginalNorm (R := k) p r

end FinalPrecision

/-- Whole current Version3 additive theorem, at every original precision
and for every actual original operator satisfying only its source inputs. -/
structure ElementaryPrimeWeightedCarryResult (r a : ℕ) (large : 2 < p) (positive : 0 < r)
    [Fintype (ℙ (ZMod p) (Fin r → ZMod p))] : Prop where
  grading : ∀ N (h : 0 < N),
    letI : Fact (0 < N) := ⟨h⟩
    ElementaryPrimeWeightedCarryGrading p k N r
  precision : ∀ N (h : 0 < N), N ≤ r →
    letI : Fact (0 < N) := ⟨h⟩
    letI : Nontrivial (TruncatedWittVector p N k) := truncated_witt_nontrivial p N h k
    ∀ (L : AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p N k) (Fin r → ZMod p)) (q : MvPolynomial (Fin r) k),
      ElementaryPrimeWittReduction p N k r a L q → ElementaryPrimeOriginalAnisotropy p k r q →
      ∀ x, L x = 0 → x ∈ elementaryNormalWeightFiltration (TruncatedWittVector p N k)
        p (Fact.out : p.Prime).pos r ((p - 1) * N - a + 1)
  integral :
    letI : Fact (0 < r) := ⟨positive⟩
    letI : Nontrivial (TruncatedWittVector p r k) := truncated_witt_nontrivial p r positive k
    ∀ (L : AddMonoidAlgebra (TruncatedWittVector p r k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p r k) (Fin r → ZMod p)) (q : MvPolynomial (Fin r) k),
      ElementaryPrimeWittReduction p r k r a L q → ElementaryPrimeOriginalAnisotropy p k r q →
        ElementaryPrimeWeightedCarryIntegral p k r a L
  final :
    letI : Fact (0 < r + 1) := ⟨by omega⟩
    ∀ (L : AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p) →+
      AddMonoidAlgebra (TruncatedWittVector p (r + 1) k) (Fin r → ZMod p)) (q : MvPolynomial (Fin r) k),
      ElementaryPrimeWittReduction p (r + 1) k r a L q → ElementaryPrimeOriginalAnisotropy p k r q →
        ElementaryPrimeWeightedCarryFinal p k r a large L q

end Litt3.Deformations
