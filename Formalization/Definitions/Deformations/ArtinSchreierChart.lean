import Mathlib.RingTheory.AdjoinRoot
import Mathlib.Algebra.Category.CommAlgCat.Basic
import Mathlib.RingTheory.TensorProduct.Basic

namespace Litt3.Deformations

open Polynomial
open scoped TensorProduct

/-- The literal integral monic chart relation, with no coefficient
unit or characteristic assumption. -/
noncomputable def artinSchreierRelation {R : Type*} [CommRing R]
    (p : ℕ) (a b : R) : R[X] := X ^ p - (C a * X + C b)

abbrev ArtinSchreierFactor (R : Type*) [CommRing R] (p : ℕ) (a b : R) :=
  AdjoinRoot (artinSchreierRelation p a b)

/-- The actual iterated tensor quotient by every literal original
integral Artin--Schreier relation. -/
noncomputable def artinSchreierChart (R : Type*) [CommRing R] (p : ℕ) :
    (r : ℕ) → (Fin r → R) → (Fin r → R) → CommAlgCat R
  | 0, _, _ => CommAlgCat.of R R
  | r + 1, a, b => CommAlgCat.of R
      (ArtinSchreierFactor R p (a 0) (b 0) ⊗[R]
        artinSchreierChart R p r (fun i => a i.succ) (fun i => b i.succ))

noncomputable def artinSchreierChartCoordinate (R : Type*) [CommRing R] (p : ℕ) :
    (r : ℕ) → (a b : Fin r → R) → Fin r → artinSchreierChart R p r a b
  | 0, _, _ => Fin.elim0
  | r + 1, a, b => Fin.cases
      ((Algebra.TensorProduct.includeLeft : ArtinSchreierFactor R p (a 0) (b 0) →ₐ[R]
        ArtinSchreierFactor R p (a 0) (b 0) ⊗[R]
          artinSchreierChart R p r (fun i => a i.succ) (fun i => b i.succ))
            (AdjoinRoot.root (artinSchreierRelation p (a 0) (b 0))))
      (fun i => (Algebra.TensorProduct.includeRight :
        artinSchreierChart R p r (fun i => a i.succ) (fun i => b i.succ) →ₐ[R]
          ArtinSchreierFactor R p (a 0) (b 0) ⊗[R]
            artinSchreierChart R p r (fun i => a i.succ) (fun i => b i.succ))
              (artinSchreierChartCoordinate R p r (fun i => a i.succ) (fun i => b i.succ) i))

end Litt3.Deformations
