import Solutions.CartierAndSpin.MatrixCommutatorCriterion
import Solutions.CartierAndSpin.PowerCommutatorStacks
import Solutions.CartierAndSpin.ShiftedMatrixPencils
import Solutions.CartierAndSpin.LinearMatrixFamilies
import Solutions.CartierAndSpin.CommutatorRows
import Solutions.CartierAndSpin.CommutatorStackCounts
import Solutions.CartierAndSpin.CommutatorStackSpecialization

namespace Litt3.CartierAndSpin.Specifications

universe u v

open Matrix

/-- All three original conditions on actual matrices, in arbitrary
positive dimension and algebraically closed characteristic. -/
def FiniteCommutatorEigenCriteriaClause : Prop :=
  ∀ {k : Type u} [Field k] [IsAlgClosed k] (n : ℕ) (_hn : 0 < n)
    (U V : Matrix (Fin n) (Fin n) k),
    (boundedPowerCommutatorKernel U V ≠ ⊥ ↔
      ∃ a b : k, ∃ x : Fin n → k, x ≠ 0 ∧ U *ᵥ x = a • x ∧ V *ᵥ x = b • x) ∧
    ((orderedCommutatorStack U V (n - 1)).rank < n ↔
      ∃ a b : k, ∃ x : Fin n → k, x ≠ 0 ∧ U *ᵥ x = a • x ∧ V *ᵥ x = b • x) ∧
    ((powerCommutatorStack U V).rank < n ↔
      ∃ a b : k, ∃ x : Fin n → k, x ≠ 0 ∧ U *ᵥ x = a • x ∧ V *ᵥ x = b • x)

/-- Exact equality over the original commutative coefficient ring. -/
def CommutatorRowCompressionClause : Prop :=
  ∀ {R : Type u} [CommRing R] (n d : ℕ) (U V : Matrix (Fin n) (Fin n) R),
    matrixRowModule {M | ∃ w : List Bool, w.length ≤ d ∧
      M = (U * V - V * U) * twoGeneratorWord U V w} =
    matrixRowModule {M | ∃ a b : ℕ, a + b ≤ d ∧
      M = (U * V - V * U) * U ^ a * V ^ b}

def OneDimensionalPowerIntersectionClause : Prop :=
  ∀ {R : Type u} [CommRing R] (U V : Matrix (Fin 1) (Fin 1) R),
    boundedPowerCommutatorKernel U V = ⊤

/-- Literal specialization of the displayed source block form; arbitrary
eight-variable coefficient matrices include the actual middle matrices. -/
def MiddlePencilFiberClause : Prop :=
  ∀ {k : Type u} [Field k] [IsAlgClosed k]
    (coeffU coeffV : Fin 8 → Matrix (Fin 15) (Fin 15) k) (z : Fin 8 → k), z ≠ 0 →
    ((∃ a b : k, ∃ s : Fin 15 → k, s ≠ 0 ∧
      shiftedPencilStack (linearMatrixFiber coeffU z) (linearMatrixFiber coeffV z) a b *ᵥ s = 0) ↔
    (orderedCommutatorStack (linearMatrixFiber coeffU z)
      (linearMatrixFiber coeffV z) 14).rank < 15)

def MiddleAlternativePowerFiberClause : Prop :=
  ∀ {k : Type u} [Field k] [IsAlgClosed k]
    (coeffU coeffV : Fin 8 → Matrix (Fin 15) (Fin 15) k) (z : Fin 8 → k), z ≠ 0 →
    ((∃ a b : k, ∃ s : Fin 15 → k, s ≠ 0 ∧
      shiftedPencilStack (linearMatrixFiber coeffU z) (linearMatrixFiber coeffV z) a b *ᵥ s = 0) ↔
    (powerCommutatorStack (linearMatrixFiber coeffU z)
      (linearMatrixFiber coeffV z)).rank < 15)

def MiddleZeroFiberClause : Prop :=
  ∀ {k : Type u} [Field k]
    (coeffU coeffV : Fin 8 → Matrix (Fin 15) (Fin 15) k) (a b : k),
    (∃ s : Fin 15 → k, s ≠ 0 ∧
      shiftedPencilStack (linearMatrixFiber coeffU 0) (linearMatrixFiber coeffV 0) a b *ᵥ s = 0) ↔
      a = 0 ∧ b = 0

def MiddlePolynomialDegreeClause : Prop :=
  ∀ {k : Type u} [Field k]
    (coeffU coeffV : Fin 8 → Matrix (Fin 15) (Fin 15) k),
    (∀ i j, (orderedCommutatorStack (linearPolynomialMatrix coeffU)
      (linearPolynomialMatrix coeffV) 14 i j).totalDegree ≤ 16) ∧
    (∀ i j, (powerCommutatorStack (linearPolynomialMatrix coeffU)
      (linearPolynomialMatrix coeffV) i j).totalDegree ≤ 28)

def MiddleStackCountsClause : Prop :=
  Fintype.card (OrderedCommutatorPairs 14) = 120 ∧
    Fintype.card (OrderedCommutatorPairs 14 × Fin 15) = 1800 ∧
    Fintype.card (PowerCommutatorPairs (Fin 15)) = 196 ∧
    Fintype.card (PowerCommutatorPairs (Fin 15) × Fin 15) = 2940

/-- Literal polynomial specialization commutes with each full stack. -/
def CommutatorStackSpecializationClause : Prop :=
  ∀ {R : Type u} {S : Type v} [CommRing R] [CommRing S] (f : R →+* S)
    (n d : ℕ) (U V : Matrix (Fin n) (Fin n) R),
    (orderedCommutatorStack U V d).map f =
      orderedCommutatorStack (U.map f) (V.map f) d ∧
    (powerCommutatorStack U V).map f = powerCommutatorStack (U.map f) (V.map f)

def LinearMatrixScalingClause : Prop :=
  ∀ {R : Type u} [CommRing R] (n : ℕ)
    (coeff : Fin 8 → Matrix (Fin n) (Fin n) R) (z : Fin 8 → R) (a : R),
    linearMatrixFiber coeff (a • z) = a • linearMatrixFiber coeff z

/-- Full canonical finite commutator criterion. The source's final scope
limitations assert no further proposition: determinantal emptiness,
polynomial left inverses and a common cover are not conclusions here. -/
def MiddleFiniteCommutatorCriterion : Prop :=
  FiniteCommutatorEigenCriteriaClause.{u} ∧
    CommutatorRowCompressionClause.{u} ∧
    OneDimensionalPowerIntersectionClause.{u} ∧
    MiddlePencilFiberClause.{u} ∧
    MiddleAlternativePowerFiberClause.{u} ∧
    MiddleZeroFiberClause.{u} ∧
    MiddlePolynomialDegreeClause.{u} ∧
    MiddleStackCountsClause ∧
    CommutatorStackSpecializationClause.{u,v} ∧
    LinearMatrixScalingClause.{u}

end Litt3.CartierAndSpin.Specifications
