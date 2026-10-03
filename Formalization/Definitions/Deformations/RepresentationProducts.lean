import Definitions.Deformations.RepresentationCocycles

namespace Litt3.Deformations

universe u v w t

variable {k : Type u} {G : Type v} {ι : Type w} {V : ι → Type t}
    [CommRing k] [Group G] [∀ i, AddCommGroup (V i)] [∀ i, Module k (V i)]

/-- The actual componentwise representation on the full product
of actual coefficient representations. -/
def representationPi (ρ : ∀ i, Representation k G (V i)) :
    Representation k G (∀ i, V i) where
  toFun g := {
    toFun x i := ρ i g (x i)
    map_add' x y := by funext i; exact (ρ i g).map_add (x i) (y i)
    map_smul' a x := by funext i; exact (ρ i g).map_smul a (x i) }
  map_one' := by
    apply LinearMap.ext
    intro x
    funext i
    exact LinearMap.congr_fun (ρ i).map_one (x i)
  map_mul' g h := by
    apply LinearMap.ext
    intro x
    funext i
    exact LinearMap.congr_fun ((ρ i).map_mul g h) (x i)

end Litt3.Deformations
