# The simultaneous-envelope criterion and the core-tower obstruction

Author proved-text. Fix S=P¹_Fbar5(31,31,31) and an actual connected
representable finite étale self-correspondence u,v:C⇉S.
The group criteria below are formal; the complex counterexample uses
the arithmetic commensurator theorem. None proves visibility for this S.

## 1. Proposition21.1: the exact subgroup criterion

With base points and paths, write G=π₁^et(S), H=π₁^et(C) and
i,j:H↪G for the two open injections. A connected finite étale W→C
makes BOTH composites Galois exactly when its open subgroup K≤H obeys

    i(K)◁G,   j(K)◁G.                                     (1)

This is the Galois correspondence applied to each actual leg.
Conjugating base-point choices changes no assertion.
Equivalently, for θ=ji^(-1):i(H)→j(H), one needs open N≤i(H)
with both N and θ(N) normal in G. Separate normal cores do not
ensure their compatibility.

## 2. Theorem21.2: an exact stopping test

For open A≤G let Core_G(A)=⋂_(g∈G)gAg^(-1), still open because
there are finitely many conjugates. Define

    L_0=H,
    L_(n+1)=i^(-1)Core_G(i(L_n))∩j^(-1)Core_G(j(L_n)).        (2)

These are descending open normal subgroups of H.
The following are equivalent: an open K satisfying(1) exists;
the tower(2) stabilizes; some L_n satisfies(1).

Indeed such a K is normal in H and lies in every L_n by induction:
i(K),j(K) lie in each relevant normal core. The descending L_n/K
then stabilize in the finite group H/K. Conversely if L_(n+1)=L_n,
both factors on the right of(2), each contained in L_n, equal L_n.
Thus i(L_n),j(L_n) equal their normal cores, proving(1).
This is an exact semi-algorithm, with no formal bound on strict steps.

## 3. Proposition21.3 and Corollary21.4: finite envelopes

A finite envelope is a smooth proper connected orbifold O, two
representable finite étale maps f_0,f_1:S⇉O, and
a2-isomorphism f_0u≅f_1v. It exists exactly when(1)–(2) hold.

For a simultaneous Galois refinement W, its two deck groups A,B
generate finite F⊂Aut(W), by hyperbolicity. Then O=[W/F] is the
envelope, with W/A≅S≅W/B. Conversely an envelope places the two
images of H in Ω=π₁^et(O) in the SAME open subgroup D.
Pull Core_Ω(D) back to H. Its two images in G are inverse images
of this normal subgroup, hence normal, proving(1).

For scheme-curve spans of arbitrary endpoints, the
[canonical cored bridge](../../Theorems/Thm_cored_orbifold_bridge.md)
explains why a field-theoretic core supplies an actual simultaneous
étale refinement, not a possibly ramified field closure.

The S-specific specialization uses the separate
[presentation-compatible over-orbifold classification](19_STRONG_FINITE_OVER_ORBIFOLD_CLASSIFICATION.md):
every finite envelope maps compatibly to S0=P¹(2,3,62).
With that input, visibility π0u≅π0v, existence of a finite envelope,
existence of a simultaneous Galois refinement and stabilization of(2)
are equivalent. Visibility itself supplies the envelope S0;
compatibility gives the reverse implication. The envelope bridge
is therefore not a formally weaker version of the visibility problem.

## 4. Three soft inputs do not force termination

Minimal-degree arguments exclude COARSENINGS of C through which both
maps factor. The strict steps of(2) are REFINEMENTS, increasing both
degrees. Moreover visibility cannot first appear upstairs: an
isomorphism after a finite étale surjection C′→C descends, because
its two pullbacks agree generically and the effective target has
trivial generic inertia. Thus nonvisibility persists while degrees grow.

Finite-presentation data over Fbar_5 descend to some finite field;
after extending it, a Frobenius power preserves i,j and every L_n.
This gives invariance, not a descending-chain condition. Even the
characteristic chain Z_5⊃5Z_5⊃5²Z_5⊃⋯ can be infinite.
Topological finite generation gives finitely many subgroups of each
fixed index, but indices in(2) need not be bounded.

## 5. Proposition21.5: a genuine equal-degree same-target counterexample

There exist smooth projective complex curves X,C with g(X)≥2 and
finite étale u,v:C⇉X of equal degree, generically injective jointly,
for which no connected finite étale refinement makes both legs Galois.

Choose a torsion-free cocompact arithmetic Fuchsian lattice
Γ<PSL₂(R), whose commensurator is dense. There is a commensurator
element g for which Λ=⟨Γ,g^(-1)Γg⟩ is nondiscrete.
To justify this choice, first note that Γ has finitely many discrete
overgroups Δ. The universal positive lower bound on hyperbolic
orbifold area bounds[Δ:Γ]; its normal core has bounded index in Γ.
Finite generation gives finitely many such cores, and each lattice
normalizer is a finite extension, leaving finitely many overgroups.

For each Δ, there are only finitely many conjugates g^(-1)Γg⊂Δ:
they have the fixed index prescribed by covolume. The g producing
any one are a coset of the closed discrete normalizer N(Γ).
Finitely many such cosets cannot contain the dense commensurator.
Thus the asserted nondiscrete Λ exists.

Set H=Γ∩g^(-1)Γg, X=Γ\ℍ and C=H\ℍ, for the upper half-plane ℍ.
Inclusion gives u, while
z↦gz gives v. Compact Riemann surfaces algebraize to projective
curves, and these unramified maps are finite étale.
Their degrees agree by equality of the conjugate lattices' covolumes.

A simultaneous Galois refinement would give finite-index K≤H
normal in both Γ and g^(-1)Γg. Then nondiscrete Λ normalizes K,
contradicting discreteness of the normalizer of a cocompact lattice.

Finally trivialize u over an analytic disc, with sheets Hγ, γ∈Γ.
If two sheets have identical v-images on an open set, proper
discontinuity and the identity theorem give

    gγ_1=δgγ_2 for some δ∈Γ,
    γ_1γ_2^(-1)∈Γ∩g^(-1)Γg=H.

They are the same sheet. Each other pair has a proper coincidence
locus; finitely many sheets therefore imply generic injectivity
of(u,v), or ℂ(C)=ℂ(u,v).

For the arithmetic-to-dense commensurator input see Margulis,
Discrete Subgroups of Semisimple Lie Groups, Springer1991,
ChapterIX, TheoremB. No stronger direction is used.
This is a complex, not a characteristic-five counterexample for S.
It proves that finite generation, equal degrees and joint minimality
alone do not make the core tower terminate; a special geometric
argument would still be required.
