import Definitions.CartierAndSpin.EndpointDecompositionFibers

namespace Litt3.CartierAndSpin

variable {A B W : Type*} [AddCommGroup A] [AddCommGroup B] [AddCommGroup W]

/-- The kernel of the actual two-endpoint difference is canonically
the literal intersection of their images, provided both original maps
are injective. The common image, not a scalar extension, parametrizes
simultaneous endpoint shifts. -/
noncomputable def endpoint_shared_kernel_equiv
    (mA : A →+ W) (mB : B →+ W)
    (hA : Function.Injective mA) (hB : Function.Injective mB) :
    (endpointDifferentialDifference mA mB).ker ≃+ ↥(mA.range ⊓ mB.range) := by
  let f : (endpointDifferentialDifference mA mB).ker →+ ↥(mA.range ⊓ mB.range) :=
    { toFun := fun ab => ⟨mA ab.val.1, by
        refine ⟨⟨ab.val.1, rfl⟩, ⟨ab.val.2, ?_⟩⟩
        exact sub_eq_zero.mp ab.property⟩
      map_zero' := by apply Subtype.ext; exact map_zero mA
      map_add' := by intro ab cd; apply Subtype.ext; exact map_add mA _ _ }
  apply AddEquiv.ofBijective f
  constructor
  · intro ab cd heq
    apply Subtype.ext
    apply Prod.ext
    · exact hA (congrArg Subtype.val heq)
    · apply hB
      have hab : mB ab.val.2 = mA ab.val.1 := sub_eq_zero.mp ab.property
      have hcd : mB cd.val.2 = mA cd.val.1 := sub_eq_zero.mp cd.property
      exact hab.trans ((congrArg Subtype.val heq).trans hcd.symm)
  · intro omega
    obtain ⟨a, ha⟩ := omega.property.1
    obtain ⟨b, hb⟩ := omega.property.2
    refine ⟨⟨(a, b), ?_⟩, Subtype.ext ha⟩
    change mB b - mA a = 0
    rw [ha, hb, sub_self]

end Litt3.CartierAndSpin
