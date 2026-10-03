import Definitions.Deformations.ToricHypersurfaceAlgebra
import Mathlib.Tactic

namespace Litt3.Deformations

abbrev ToricHypersurfaceAxisIndex (Q R s : ℕ) :=
  Σ a : Fin (Q-1), Fin (min R (s*(Q-(a.val+1))))

abbrev ToricHypersurfaceFiniteIndex (Q R s : ℕ) :=
  Fin R ⊕ (Bool × ToricHypersurfaceAxisIndex Q R s)

noncomputable def toricHypersurfaceIndexEncode (Q R s : ℕ)
    (i : ToricHypersurfaceNormalIndex Q R s) : ToricHypersurfaceFiniteIndex Q R s := by
  classical
  have hx := i.property.2.1
  have hy := i.property.2.2.1
  have hz := i.property.2.2.2.1
  have hzx := i.property.2.2.2.2.1
  have hzy := i.property.2.2.2.2.2
  by_cases zeroX : i.val.x=0
  · by_cases zeroY : i.val.y=0
    · exact Sum.inl ⟨i.val.z,hz⟩
    · exact Sum.inr (true,⟨⟨i.val.y-1,by omega⟩,⟨i.val.z,
        lt_min_iff.mpr ⟨hz,by
          change i.val.z < s*(Q-(i.val.y-1+1))
          have cancel : i.val.y-1+1=i.val.y := by omega
          rw [cancel]; exact hzy⟩⟩⟩)
  · exact Sum.inr (false,⟨⟨i.val.x-1,by omega⟩,⟨i.val.z,
      lt_min_iff.mpr ⟨hz,by
        change i.val.z < s*(Q-(i.val.x-1+1))
        have cancel : i.val.x-1+1=i.val.x := by omega
        rw [cancel]; exact hzx⟩⟩⟩)

noncomputable def toricHypersurfaceIndexDecode (Q R s : ℕ)
    (positiveQ : 0<Q) (below : R≤Q) (positiveS : 0<s)
    (i : ToricHypersurfaceFiniteIndex Q R s) : ToricHypersurfaceNormalIndex Q R s := by
  have qle : Q≤s*Q := by nlinarith
  rcases i with c | ⟨b,a,c⟩
  · exact ⟨⟨0,0,c.val⟩,⟨Or.inl rfl,positiveQ,positiveQ,c.isLt,
      by simpa using lt_of_lt_of_le c.isLt (below.trans qle),
      by simpa using lt_of_lt_of_le c.isLt (below.trans qle)⟩⟩
  · have small : a.val+1<Q := by omega
    have bounds := lt_min_iff.mp c.isLt
    have other : c.val<s*Q := lt_of_lt_of_le bounds.1 (below.trans qle)
    cases b
    · exact ⟨⟨a.val+1,0,c.val⟩,⟨Or.inr rfl,small,positiveQ,bounds.1,
        bounds.2,by simpa using other⟩⟩
    · exact ⟨⟨0,a.val+1,c.val⟩,⟨Or.inl rfl,positiveQ,small,bounds.1,
        by simpa using other,bounds.2⟩⟩

theorem toric_hypersurface_index_decode_encode (Q R s : ℕ)
    (positiveQ : 0<Q) (below : R≤Q) (positiveS : 0<s)
    (i : ToricHypersurfaceNormalIndex Q R s) :
    toricHypersurfaceIndexDecode Q R s positiveQ below positiveS
      (toricHypersurfaceIndexEncode Q R s i)=i := by
  classical
  rcases i with ⟨⟨x,y,z⟩,h⟩
  rcases h with ⟨axis,hx,hy,hz,hzx,hzy⟩
  by_cases zeroX : x=0
  · by_cases zeroY : y=0
    · apply Subtype.ext
      simp [toricHypersurfaceIndexEncode,toricHypersurfaceIndexDecode,zeroX,zeroY]
    · apply Subtype.ext
      simp [toricHypersurfaceIndexEncode,toricHypersurfaceIndexDecode,zeroX,zeroY,
        Nat.sub_add_cancel (by omega : 1≤y)]
  · have zeroY : y=0 := axis.resolve_left zeroX
    apply Subtype.ext
    simp [toricHypersurfaceIndexEncode,toricHypersurfaceIndexDecode,zeroX,zeroY,
      Nat.sub_add_cancel (by omega : 1≤x)]

theorem toric_hypersurface_index_encode_decode (Q R s : ℕ)
    (positiveQ : 0<Q) (below : R≤Q) (positiveS : 0<s)
    (i : ToricHypersurfaceFiniteIndex Q R s) :
    toricHypersurfaceIndexEncode Q R s
      (toricHypersurfaceIndexDecode Q R s positiveQ below positiveS i)=i := by
  classical
  rcases i with c | ⟨b,a,c⟩
  · simp [toricHypersurfaceIndexEncode,toricHypersurfaceIndexDecode]
  · cases b <;> simp [toricHypersurfaceIndexEncode,toricHypersurfaceIndexDecode]

noncomputable def toricHypersurfaceIndexEquiv (Q R s : ℕ)
    (positiveQ : 0<Q) (below : R≤Q) (positiveS : 0<s) :
    ToricHypersurfaceNormalIndex Q R s ≃ ToricHypersurfaceFiniteIndex Q R s where
  toFun := toricHypersurfaceIndexEncode Q R s
  invFun := toricHypersurfaceIndexDecode Q R s positiveQ below positiveS
  left_inv := toric_hypersurface_index_decode_encode Q R s positiveQ below positiveS
  right_inv := toric_hypersurface_index_encode_decode Q R s positiveQ below positiveS

end Litt3.Deformations
