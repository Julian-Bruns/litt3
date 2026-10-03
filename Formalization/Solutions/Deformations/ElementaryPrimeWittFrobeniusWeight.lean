import Solutions.Deformations.ElementaryPrimeWittPolynomial

namespace Litt3.Deformations

variable (p N : ℕ) [Fact p.Prime] [Fact (0 < N)]
variable (k : Type*) [Field k] [CharP k p] [PerfectRing k p]

local instance : Nontrivial (TruncatedWittVector p N k) :=
  truncated_witt_nontrivial p N (Fact.out : 0 < N) k

/-- Actual coefficient Frobenius is a constructed additive equivalence
on every actual original weight, with its scalar twist retained. -/
noncomputable def elementaryPrimeWittFrobeniusWeight (r d : ℕ) :
    elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (Fact.out : p.Prime).pos r d ≃+
      elementaryNormalWeightFiltration (TruncatedWittVector p N k) p (Fact.out : p.Prime).pos r d where
  toFun x := ⟨elementaryWittFrobenius p N r k x.val,
    elementary_prime_witt_frobenius_weight p N k r d x.val x.property⟩
  invFun x := ⟨(elementaryWittFrobenius p N r k).symm x.val,
    elementary_prime_witt_inverse_frobenius_weight p N k r d x.val x.property⟩
  left_inv x := Subtype.ext ((elementaryWittFrobenius p N r k).symm_apply_apply x.val)
  right_inv x := Subtype.ext ((elementaryWittFrobenius p N r k).apply_symm_apply x.val)
  map_add' x y := Subtype.ext ((elementaryWittFrobenius p N r k).map_add x.val y.val)

end Litt3.Deformations
