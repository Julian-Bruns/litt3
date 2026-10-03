import Solutions.CartierAndSpin.EndpointSharedKernel
import Solutions.CartierAndSpin.AdditiveFiberTorsor

namespace Litt3.CartierAndSpin

variable {H P : Type*} [AddCommGroup H]

/-- Transport the literal group-translation torsor along an actual
bijection. The action and difference are constructed explicitly. -/
def actualTranslationTorsorOfEquiv (e : H ≃ P) : AddTorsor H P where
  vadd h a := e (h + e.symm a)
  zero_vadd a := by
    change e (0 + e.symm a) = a
    simp
  add_vadd h g a := by
    change e ((h + g) + e.symm a) = e (h + e.symm (e (g + e.symm a)))
    simp [add_assoc]
  vsub a b := e.symm a - e.symm b
  nonempty := ⟨e 0⟩
  vsub_vadd' a b := by
    change e ((e.symm a - e.symm b) + e.symm b) = a
    simp
  vadd_vsub' h a := by
    change e.symm (e (h + e.symm a)) - e.symm a = h
    simp

variable {A B W : Type*} [AddCommGroup A] [AddCommGroup B] [AddCommGroup W]

/-- Every actual decomposition fiber with an actual chosen point is
canonically parametrized by the literal shared image. -/
noncomputable def endpointDecompositionSharedEquiv
    (mA : A →+ W) (mB : B →+ W)
    (hA : Function.Injective mA) (hB : Function.Injective mB)
    (omega : W) (a0 : A) (b0 : B)
    (h0 : mB b0 - mA a0 = omega) :
    ↥(mA.range ⊓ mB.range) ≃ endpointDecompositionFiber mA mB omega :=
  (endpoint_shared_kernel_equiv mA mB hA hB).symm.toEquiv.trans
    (actualAdditiveFiberEquiv (endpointDifferentialDifference mA mB)
      omega (a0, b0) h0)

/-- The full set of original endpoint decompositions is an actual
torsor under the shared image whenever one decomposition exists. -/
noncomputable def endpointDecompositionSharedTorsor
    (mA : A →+ W) (mB : B →+ W)
    (hA : Function.Injective mA) (hB : Function.Injective mB)
    (omega : W) (a0 : A) (b0 : B)
    (h0 : mB b0 - mA a0 = omega) :
    AddTorsor ↥(mA.range ⊓ mB.range) (endpointDecompositionFiber mA mB omega) :=
  actualTranslationTorsorOfEquiv
    (endpointDecompositionSharedEquiv mA mB hA hB omega a0 b0 h0)

/-- The shared parameter of a decomposition relative to an actual
base point is exactly the simultaneous original endpoint shift. -/
theorem endpoint_decomposition_shared_parameter
    (mA : A →+ W) (mB : B →+ W)
    (hA : Function.Injective mA) (hB : Function.Injective mB)
    (omega : W) (a0 : A) (b0 : B)
    (h0 : mB b0 - mA a0 = omega)
    (ab : endpointDecompositionFiber mA mB omega) :
    ((endpointDecompositionSharedEquiv mA mB hA hB omega a0 b0 h0).symm ab).val =
      mA (ab.val.1 - a0) := rfl

end Litt3.CartierAndSpin
