import Theorems.Deformations.RadicalDimensionDrop
import Solutions.Deformations.RadicalComplements
import Mathlib.LinearAlgebra.FiniteDimensional.Lemmas

namespace Litt3.Deformations

variable {k V : Type*} [Field k] [AddCommGroup V] [Module k V] [FiniteDimensional k V]

theorem nonzero_reflexive_radical_dimension_drop (B : LinearMap.BilinForm k V)
    (reflexive : B.IsRefl) (nonzero : B ≠ 0) :
    Specifications.NonzeroReflexiveRadicalDimensionDrop B := by
  obtain ⟨U, complement, nondegenerate⟩ := reflexive_radical_complement B reflexive
  have hradical : BilinearRadical B ≠ ⊤ := by
    intro h
    exact nonzero (LinearMap.ker_eq_top.mp h)
  have hU : U ≠ ⊥ := by
    intro h
    have hs := complement.sup_eq_top
    rw [h, bot_sup_eq] at hs
    exact hradical hs
  have positive : 0 < Module.finrank k U :=
    Nat.pos_of_ne_zero (fun h => hU (Submodule.finrank_eq_zero.mp h))
  have hdim := Submodule.finrank_add_eq_of_isCompl complement
  refine ⟨U, complement, nondegenerate, positive, ?_⟩
  omega

end Litt3.Deformations
