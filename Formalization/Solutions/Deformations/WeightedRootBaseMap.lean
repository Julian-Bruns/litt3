import Solutions.Deformations.WeightedRootProductRelations
import Solutions.Deformations.WeightedRootProductLift

namespace Litt3.Deformations

variable {R S : Type*} [CommRing R] [Nontrivial R] [CommRing S] [Nontrivial S]

/-- Actual coefficient extension on the actual tensor quotient,
constructed by its literal original coordinate relations. -/
noncomputable def weightedRootProductBaseMap (φ : R →+* S) (q : ℕ) (tau : R) (r : ℕ) :
    weightedRootProduct R q tau r →+* weightedRootProduct S q (φ tau) r := by
  let T := weightedRootProduct S q (φ tau) r
  let ψ : R →+* T := (algebraMap S T).comp φ
  letI : Algebra R T := ψ.toAlgebra
  exact (weightedRootProductLift q tau r (weightedRootProductParameter S q (φ tau) r)
    (fun i => by
      change weightedRootProductParameter S q (φ tau) r i ^ q =
        -(algebraMap S T) (φ tau) * weightedRootProductParameter S q (φ tau) r i
      exact weighted_root_product_coordinate_relation q (φ tau) r i)).toRingHom

@[simp] theorem weighted_root_base_map_parameter (φ : R →+* S) (q : ℕ) (tau : R)
    (r : ℕ) (i : Fin r) :
    weightedRootProductBaseMap φ q tau r (weightedRootProductParameter R q tau r i) =
      weightedRootProductParameter S q (φ tau) r i := by
  let T := weightedRootProduct S q (φ tau) r
  let ψ : R →+* T := (algebraMap S T).comp φ
  letI : Algebra R T := ψ.toAlgebra
  unfold weightedRootProductBaseMap
  exact weighted_root_product_lift_parameter _ _ _ _ _ _

@[simp] theorem weighted_root_base_map_coefficient (φ : R →+* S) (q : ℕ) (tau : R)
    (r : ℕ) (a : R) :
    weightedRootProductBaseMap φ q tau r (algebraMap R (weightedRootProduct R q tau r) a) =
      algebraMap S (weightedRootProduct S q (φ tau) r) (φ a) := by
  let T := weightedRootProduct S q (φ tau) r
  let ψ : R →+* T := (algebraMap S T).comp φ
  letI : Algebra R T := ψ.toAlgebra
  unfold weightedRootProductBaseMap
  exact AlgHom.commutes _ a

/-- The genuine base ring map gives a genuine semilinear extension
map, with both actual scalar actions retained. -/
noncomputable def weightedRootProductBaseLinear (φ : R →+* S) (q : ℕ) (tau : R) (r : ℕ) :
    weightedRootProduct R q tau r →ₛₗ[φ] weightedRootProduct S q (φ tau) r where
  __ := (weightedRootProductBaseMap φ q tau r).toAddMonoidHom
  map_smul' c x := by
    change weightedRootProductBaseMap φ q tau r (c • x) = φ c • weightedRootProductBaseMap φ q tau r x
    rw [Algebra.smul_def, map_mul, weighted_root_base_map_coefficient, Algebra.smul_def]

@[simp] theorem weighted_root_base_map_basis (φ : R →+* S) (q : ℕ) (large : 1 < q)
    (tau : R) (r : ℕ) (alpha : Fin r → Fin q) :
    weightedRootProductBaseMap φ q tau r (weightedRootProductBasis q large tau r alpha) =
      weightedRootProductBasis q large (φ tau) r alpha := by
  simp only [weighted_root_product_basis_apply, map_prod, map_pow, weighted_root_base_map_parameter]

end Litt3.Deformations
