import Theorems.Deformations.FiniteCyclicCohomology
import Mathlib.RepresentationTheory.Homological.GroupCohomology.Basic
import Solutions.Deformations.RepresentationNormMaps

namespace Litt3.Deformations

open CategoryTheory Finsupp

universe u

variable {k G : Type u} [CommRing k] [CommGroup G] [Fintype G]
    (A : Rep k G) (g : G)

omit [Fintype G] in
/-- Evaluation at the actual identity coefficient intertwines
precomposition by the cyclic difference operator with its actual
action on the coefficient representation. -/
theorem left_regular_hom_difference (f : Rep.leftRegular k G ⟶ A) :
    Rep.leftRegularHomEquiv A ((Rep.applyAsHom (Rep.leftRegular k G) g - 𝟙 _) ≫ f) =
      (A.ρ g - (LinearMap.id : A →ₗ[k] A)) (Rep.leftRegularHomEquiv A f) := by
  change f.hom ((Representation.leftRegular k G) g (single 1 1) - single 1 1) =
    A.ρ g (f.hom (single 1 1)) - f.hom (single 1 1)
  rw [map_sub]
  exact congrArg (fun x => x - f.hom (single 1 1))
    (Rep.hom_comm_apply f g (single 1 1))

/-- The same evaluation intertwines precomposition by the actual
full group norm with the actual coefficient norm. -/
theorem left_regular_hom_norm (f : Rep.leftRegular k G ⟶ A) :
    Rep.leftRegularHomEquiv A ((Rep.leftRegular k G).norm ≫ f) =
      A.ρ.norm (Rep.leftRegularHomEquiv A f) := by
  change f.hom ((Representation.leftRegular k G).norm (single 1 1)) =
    A.ρ.norm (f.hom (single 1 1))
  exact equivariant_map_norm _ _ f.hom.hom
    (fun g x => Rep.hom_comm_apply f g x) _

/-- Hom into the actual periodic free resolution is the actual
periodic coefficient cochain complex. This holds over every
commutative coefficient ring and all finite cyclic groups. -/
noncomputable def finiteCyclicCochainsIso
    (generated : ∀ x : G, x ∈ Subgroup.zpowers g) :
    ((Rep.FiniteCyclicGroup.resolution k g generated).complex.linearYonedaObj k A) ≅
      Rep.FiniteCyclicGroup.moduleCatCochainComplex A g := by
  refine HomologicalComplex.Hom.isoOfComponents
    (fun _ => (Rep.leftRegularHomEquiv A).toModuleIso) ?_
  rintro i j (h : i + 1 = j)
  subst j
  apply ModuleCat.hom_ext
  apply LinearMap.ext
  intro f
  by_cases even : Even i
  · simpa [Rep.FiniteCyclicGroup.resolution, Rep.FiniteCyclicGroup.chainComplexFunctor,
      ChainComplex.linearYonedaObj_d, HomologicalComplex.alternatingConst,
      even, Nat.even_add_one, -Rep.leftRegularHomEquiv_apply]
      using (left_regular_hom_difference A g f).symm
  · simpa [Rep.FiniteCyclicGroup.resolution, Rep.FiniteCyclicGroup.chainComplexFunctor,
      ChainComplex.linearYonedaObj_d, HomologicalComplex.alternatingConst,
      even, Nat.even_add_one, -Rep.leftRegularHomEquiv_apply]
      using (left_regular_hom_norm A f).symm

/-- Every positive odd degree of the genuine cohomology is computed
by the actual generator-difference followed by the actual full norm. -/
noncomputable def finiteCyclicCohomologyOddIso
    (generated : ∀ x : G, x ∈ Subgroup.zpowers g) (n : ℕ) (odd : Odd n) :
    groupCohomology A n ≅ (Rep.FiniteCyclicGroup.subCompNormHom A g).homology := by
  classical
  exact groupCohomologyIso A n (Rep.FiniteCyclicGroup.resolution k g generated) ≪≫
    (HomologicalComplex.homologyMapIso (finiteCyclicCochainsIso A g generated) n) ≪≫
    HomologicalComplex.alternatingConstHomologyIsoOdd A.V (by ext; simp) (by ext; simp)
      _ (by rcases odd with ⟨j, rfl⟩; simp) (by simp) odd

/-- The full genuine H¹ is the actual norm-kernel/difference-image
quotient, over arbitrary commutative coefficients. -/
noncomputable def finiteCyclicOneCohomologyEquiv
    (generated : ∀ x : G, x ∈ Subgroup.zpowers g) :
    groupCohomology A 1 ≃ₗ[k] CyclicOneCohomologyQuotient A.ρ g :=
  ((finiteCyclicCohomologyOddIso A g generated 1 ⟨0, rfl⟩).trans
    (Rep.FiniteCyclicGroup.subCompNormHom A g).moduleCatHomologyIso).toLinearEquiv

theorem finite_cyclic_cohomology_formula
    {V : Type u} [AddCommGroup V] [Module k V]
    (ρ : Representation k G V) (generated : ∀ x : G, x ∈ Subgroup.zpowers g) :
    Specifications.FiniteCyclicCohomologyFormula ρ g :=
  ⟨finiteCyclicOneCohomologyEquiv (Rep.of ρ) g generated⟩

end Litt3.Deformations
