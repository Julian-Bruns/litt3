import Solutions.Atlases.FiniteAlgebraDecomposition
import Solutions.Atlases.PrimitiveIdempotents

namespace Litt3.Atlases

variable {K A : Type*} [Field K] [CommRing A] [Algebra K A] [FiniteDimensional K A]
  [DecidableEq (MaximalSpectrum A)]

/-- The actual reduced quotient decomposes over the original maximal
ideals, with their actual residue fields. -/
noncomputable def finiteAlgebraReducedResiduesEquiv :
    (A ⧸ nilradical A) ≃ₐ[K] (∀ P : MaximalSpectrum A, A ⧸ P.asIdeal) := by
  classical
  letI : IsArtinianRing A := isArtinian_of_tower K inferInstance
  have hc : Pairwise (fun P Q : MaximalSpectrum A => IsCoprime P.asIdeal Q.asIdeal) := by
    intro P Q h
    exact Ideal.isCoprime_iff_sup_eq.mpr
      (P.isMaximal.coprime_of_ne Q.isMaximal (fun he => h (MaximalSpectrum.ext he)))
  let e := (Ideal.quotEquivOfEq (finite_algebra_nilradical_eq_iInf_maximal (k := K))).trans
    (Ideal.quotientInfRingEquivPiQuotient _ hc)
  exact { __ := e, commutes' := fun r => rfl }

omit [DecidableEq (MaximalSpectrum A)] in
theorem finiteAlgebraReducedResiduesEquiv_apply_mk (x : A) (P : MaximalSpectrum A) :
    finiteAlgebraReducedResiduesEquiv (K := K) (Ideal.Quotient.mk (nilradical A) x) P =
      Ideal.Quotient.mk P.asIdeal x := rfl

theorem local_coordinate_idempotent_residue (P Q : MaximalSpectrum A) :
    Ideal.Quotient.mk Q.asIdeal
      (coordinateIdempotent (fun P : MaximalSpectrum A => A ⧸ P.asIdeal ^ Module.finrank K A)
        (finiteAlgebraLocalFactorsEquiv (k := K)) P) =
      if P = Q then 1 else 0 := by
  classical
  have hle : Q.asIdeal ^ Module.finrank K A ≤ Q.asIdeal :=
    Ideal.pow_le_self (finite_algebra_finrank_pos_of_maximal (k := K) Q).ne'
  have h := congrFun (coordinateIdempotent_apply
    (fun P : MaximalSpectrum A => A ⧸ P.asIdeal ^ Module.finrank K A)
    (finiteAlgebraLocalFactorsEquiv (k := K)) P) Q
  rw [finiteAlgebraLocalFactorsEquiv_apply] at h
  have hf := congrArg (Ideal.Quotient.factor hle) h
  by_cases he : P = Q
  · subst he
    simpa only [Pi.single_eq_same, map_one, ↓reduceIte] using hf
  · simpa only [Pi.single_eq_of_ne (Ne.symm he), map_zero, if_neg he] using hf

variable [PerfectField K]

noncomputable def canonicalReducedResiduesEquiv :
    canonicalReducedSubalgebra (K := K) (A := A) ≃ₐ[K]
      (∀ P : MaximalSpectrum A, A ⧸ P.asIdeal) :=
  (canonicalReducedQuotientEquiv (K := K) (A := A)).trans finiteAlgebraReducedResiduesEquiv

omit [DecidableEq (MaximalSpectrum A)] in
theorem canonicalReducedResiduesEquiv_apply
    (b : canonicalReducedSubalgebra (K := K) (A := A)) (P : MaximalSpectrum A) :
    canonicalReducedResiduesEquiv (K := K) b P = Ideal.Quotient.mk P.asIdeal (b : A) := rfl

noncomputable def canonicalPrimitiveIdempotent (P : MaximalSpectrum A) :
    canonicalReducedSubalgebra (K := K) (A := A) := by
  classical
  exact coordinateIdempotent (fun P : MaximalSpectrum A => A ⧸ P.asIdeal)
    (canonicalReducedResiduesEquiv (K := K)) P

theorem canonicalPrimitiveIdempotent_eq_local_coordinate (P : MaximalSpectrum A) :
    (canonicalPrimitiveIdempotent (K := K) P : A) =
      coordinateIdempotent (fun P : MaximalSpectrum A => A ⧸ P.asIdeal ^ Module.finrank K A)
        (finiteAlgebraLocalFactorsEquiv (k := K)) P := by
  classical
  have hb := coordinateIdempotent_idempotent
    (fun P : MaximalSpectrum A => A ⧸ P.asIdeal) (canonicalReducedResiduesEquiv (K := K)) P
  have ha := coordinateIdempotent_idempotent
    (fun P : MaximalSpectrum A => A ⧸ P.asIdeal ^ Module.finrank K A)
    (finiteAlgebraLocalFactorsEquiv (k := K)) P
  apply eq_of_isNilpotent_sub_of_isIdempotentElem
    (hb.map (canonicalReducedSubalgebra (K := K) (A := A)).val) ha
  apply mem_nilradical.mp
  rw [finite_algebra_nilradical_eq_iInf_maximal (k := K), Ideal.mem_iInf]
  intro Q
  apply Ideal.Quotient.eq_zero_iff_mem.mp
  rw [map_sub, local_coordinate_idempotent_residue]
  have h := congrFun (coordinateIdempotent_apply
    (fun P : MaximalSpectrum A => A ⧸ P.asIdeal) (canonicalReducedResiduesEquiv (K := K)) P) Q
  rw [canonicalReducedResiduesEquiv_apply] at h
  change Ideal.Quotient.mk Q.asIdeal (canonicalPrimitiveIdempotent (K := K) P : A) = _ at h
  change Ideal.Quotient.mk Q.asIdeal (canonicalPrimitiveIdempotent (K := K) P : A) -
    (if P = Q then 1 else 0) = 0
  rw [h]
  by_cases he : P = Q
  · subst he
    simp only [Pi.single_eq_same, ↓reduceIte, sub_self]
  · simp only [Pi.single_eq_of_ne (Ne.symm he), if_neg he, sub_self]

/-- These are exactly all primitive idempotents of the actual canonical
reduced subalgebra. Their actual parts have the original residue degrees. -/
theorem canonical_primitive_idempotents_classified
    (b : canonicalReducedSubalgebra (K := K) (A := A)) :
    IsPrimitiveIdempotent b ↔ ∃ P : MaximalSpectrum A,
      b = canonicalPrimitiveIdempotent (K := K) P := by
  letI (P : MaximalSpectrum A) : Field (A ⧸ P.asIdeal) := Ideal.Quotient.field P.asIdeal
  exact primitiveIdempotent_iff_coordinate (fun P : MaximalSpectrum A => A ⧸ P.asIdeal)
    (canonicalReducedResiduesEquiv (K := K)) b

theorem canonical_primitive_reduced_part_dimension (P : MaximalSpectrum A) :
    Module.finrank K (idempotentPart (k := K) (canonicalPrimitiveIdempotent (K := K) P)) =
      Module.finrank K (A ⧸ P.asIdeal) :=
  coordinateIdempotentPart_finrank (fun P : MaximalSpectrum A => A ⧸ P.asIdeal)
    (canonicalReducedResiduesEquiv (K := K)) P

/-- The very same idempotent splits the full original algebra. Its
dimension retains the actual local length instead of discarding multiplicity. -/
theorem canonical_primitive_full_part_multiplicity (P : MaximalSpectrum A) :
    Module.finrank K (idempotentPart (k := K) (canonicalPrimitiveIdempotent (K := K) P : A)) =
      Module.finrank K (idempotentPart (k := K) (canonicalPrimitiveIdempotent (K := K) P)) *
        (Module.length (A ⧸ P.asIdeal ^ Module.finrank K A)
          (A ⧸ P.asIdeal ^ Module.finrank K A)).toNat := by
  rw [canonicalPrimitiveIdempotent_eq_local_coordinate,
    coordinateIdempotentPart_finrank, canonical_primitive_reduced_part_dimension,
    finite_algebra_local_factor_dimension_residue]

theorem every_canonical_primitive_full_part_multiplicity
    (b : canonicalReducedSubalgebra (K := K) (A := A)) (hb : IsPrimitiveIdempotent b) :
    ∃ P : MaximalSpectrum A, b = canonicalPrimitiveIdempotent (K := K) P ∧
      Module.finrank K (idempotentPart (k := K) (b : A)) =
        Module.finrank K (idempotentPart (k := K) b) *
          (Module.length (A ⧸ P.asIdeal ^ Module.finrank K A)
            (A ⧸ P.asIdeal ^ Module.finrank K A)).toNat := by
  obtain ⟨P, rfl⟩ := (canonical_primitive_idempotents_classified b).mp hb
  exact ⟨P, rfl, canonical_primitive_full_part_multiplicity P⟩

end Litt3.Atlases
