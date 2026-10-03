import Solutions.Deformations.ElementaryAugmentationBasis

namespace Litt3.Deformations

variable {R : Type*} [CommRing R] [Nontrivial R]

/-- Original cyclic coordinate inclusion into the actual elementary
group algebra, preserving the selected original generator. -/
noncomputable def elementaryCoordinateMap (q r : ℕ) (i : Fin r) :
    CyclicGroupAlgebra R q →ₐ[R] AddMonoidAlgebra R (Fin r → ZMod q) :=
  AddMonoidAlgebra.mapDomainAlgHom R R
    ({ toFun := fun x : ZMod q => (Pi.single i x : Fin r → ZMod q)
       map_zero' := by ext j; simp
       map_add' := by
        intro x y
        ext j
        by_cases equality : j = i
        · subst j; simp
        · simp [Pi.single_apply, equality] } : ZMod q →+ (Fin r → ZMod q))

@[simp] theorem elementary_coordinate_parameter (q r : ℕ) (i : Fin r) :
    elementaryCoordinateMap (R := R) q r i
      ((cyclicGroupGenerator R q : CyclicGroupAlgebra R q) - 1) =
      elementaryAugmentationParameter (R := R) q r i := by
  rw [map_sub, map_one]
  change elementaryCoordinateMap (R := R) q r i
    (AddMonoidAlgebra.single (1 : ZMod q) 1) - 1 = _
  simp [elementaryCoordinateMap, AddMonoidAlgebra.mapDomainAlgHom,
    AddMonoidAlgebra.mapDomainRingHom, elementaryAugmentationParameter]

/-- Every original five-cycle coordinate has the exact integral
mixed-characteristic relation used by the weight-four prime filtration. -/
theorem elementary_five_coordinate_relation (r : ℕ) (i : Fin r) :
    let e := elementaryAugmentationParameter (R := R) 5 r i
    e ^ 5 = -(5 : AddMonoidAlgebra R (Fin r → ZMod 5)) *
      (e + 2 * e ^ 2 + 2 * e ^ 3 + e ^ 4) := by
  have original := original_five_cycle_relation (R := R)
  dsimp only at original ⊢
  have mapped := congrArg (elementaryCoordinateMap (R := R) 5 r i) original
  simpa only [map_pow, map_neg, map_mul, map_add, map_natCast, map_ofNat,
    elementary_coordinate_parameter] using mapped

end Litt3.Deformations
