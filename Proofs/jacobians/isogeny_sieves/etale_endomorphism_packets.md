# Proof: packet bounds, arithmetic input, and the actual map stabilizer

Consolidation/root,2026-09-09. General group inequality: earlier95/96
audit PASS2026-09-04. The abelian exact multiplicity/factor extraction and
minimal-source extension retain author-only status. No new audit claimed.

## 1. Free action and one rational packet

Put s=h−1 and choose ℓ≠char(k). For any nonidentity γ∈G, its graph
is disjoint from the diagonal, since q is étale. The cohomological
Lefschetz formula gives Tr(γ|H¹_et(W,Q_ℓ))=2. At the identity Hurwitz
gives dimension2+2|G|s. Semisimplicity in characteristic zero therefore gives

    H¹_et(W,Q_ℓ) ≅ Q_ℓ² ⊕ Q_ℓ[G]^(2s).                 (3)

This argument includes p-torsion in G. The relevant fixed-point formula
is [Milne, Étale Cohomology, Thm25.1](https://www.jmilne.org/math/CourseNotes/LEC.pdf),
whose cycle-class proof imposes no prime-to-p order on the automorphism.

For the rational central idempotent belonging to χ, the image P_χ in
J(W), defined up to isogeny, consequently has dimension s[F:Q]c².
The trivial idempotent gives J(C).

The entire A-isotypic part of P_χ is A^m, preserved by every endomorphism:
Hom between distinct simple isogeny types is zero. Thus G acts on K^m.
For a constituent χ of this action, its simple K-algebra has center FK
and form M_(c/e)(Δ), where dim_(FK)Δ=e². Every nonzero simple module
has K-dimension ce[F:F∩K]. Hence

    m≥ce[F:F∩K],   md≤s[F:Q]c²,

which proves (1). This applies to each constituent that occurs, not only
to one arbitrarily chosen character of the deck group.

For abelian G, c=e=1 and K⊗Q(ζ_n) is a product of a_n fields each of
degree b_n over K. All its modules have dimension divisible by b_n,
giving the exact multiplicity statement. Summing packets proves the
no-new-factor assertion. The same argument gives isomorphisms of rational
Hom spaces via norm and pullback when no new A-factor occurs; no equality
of integral Hom lattices is asserted.

If a cover W→C dominates a curve X, norm-pullback f_*f^*=[deg f]
makes every simple factor of J(X) occur in J(W), even for an inseparable
map. For the actual common-cover application, W is the genuine Galois
closure of ONE leg and its composed map to X is still finite étale.

An abelian subgroup B≤G gives c≤[G:B]: restrict χ to B, choose a linear
constituent, and apply Frobenius reciprocity to its induction. This proves
the bounded-index consequences without a bound on |G|.

## 2. The geometric endomorphism field of the fixed X

The arithmetic input is fixed_pair_arithmetic, with its retained exact
Frobenius certificate. It gives irreducible P_X of degree18 and
Q(π_X^n)=K for every n. Tate/Honda–Tate then gives End⁰ over every finite
extension equal to K: the Frobenius polynomial has no repeated power,
so the associated division-algebra index is one. Every geometric
endomorphism is defined over a finite extension, proving End⁰_kJ(X)=K.
This does NOT assume X ordinary.

The cubic deck transformation induces a nonidentity order3 element of K.
Its invariant Jacobian is J(P¹)=0, so 1+ρ+ρ²=0 and Q(ζ_3)⊂K.
The previously certified discriminant is

    disc K=−3^11·29²·10589²·16451926081²·24415659240899².

Let E=K∩Q^ab. It contains Q(ζ_3) and has degree2,6,or18. In either
larger case it contains a cyclic cubic field L. The discriminant tower
forces disc(L)^6|disc(K), so disc(L) is supported only at3, with valuation
at most1. A cyclic cubic field has positive square discriminant, hence
would have discriminant1, contradicting Minkowski. Thus E=Q(ζ_3).

This yields (2). If 3∤|G|, every character field lies in Q(ζ_|G|),
which cannot contain Q(ζ_3) (ramification at3); the intersection is Q.
For abelian groups9>2(h−1) and9>h when2≤h≤5, proving the stated range.

There is a useful independent arithmetic certificate, retained at
[the three-prime checker](../../../routes/global/EXPLICIT_GENUS9_ENDOMORPHISM_FIELD_ABELIAN_PART_CERTIFICATE.sage).
For θ=π+25/π its polynomial has degree9 and squarefree factor degrees
(9),(8,1),(7,2) at2,107,11. These imply transitivity, primitivity, and a
transposition, hence Galois group S9. Its root field K^+ has no proper
subfield and is not Galois. Any abelian subfield E of the CM field K
has E∩K^+=Q, so [E:Q]≤2. This independent argument and the certificate
are preserved; their large original polynomial is already in that code.
The same intersection argument proves the general primitive-non-Galois
real-subfield assertion for any CM field, without the S9-specific test.

## 3. The actual source gives a faithful multiplicity module

For the jointly minimal span let r:W→Z, v=(fr)^*∈Hom⁰(JX,JW), and
let U=K[G]v. G acts by inverse pullback, so H fixes v and K[G/H]→U.

Two surjective maps a,b:W→X inducing the same Jacobian homomorphism
are equal. Indeed, their Abel maps differ by a constant translation that
stabilizes the Abel image of X. Its finite translation stabilizer acts
freely on X and trivially on JX. For its quotient π, the norm identity
π^*π_*=[|K_0|] is surjective, so g(X/K_0)≥g(X). Étale Hurwitz forces
K_0=1. This works also in p-divisible order.

Therefore Stab_G(v) consists precisely of the automorphisms fixing k(X)
and k(Y), hence their actual compositum k(Z); it is H. The kernel of
the G-action on U is normal and contained in the core-free subgroup H,
so is trivial. The coset sum maps to q^*g_*f^*, zero when Hom(JX,JY)=0.
Thus U is a quotient of the augmentation representation, with dimension
at most[G:H]−1 and no invariant part. Frobenius reciprocity makes every
constituent H-spherical; Section1 applies to each. Intersecting their
kernels gives the stated necessary faithfulness test.

Neither faithfulness nor (1) bounds the covering degree. For example the
natural augmentation representation of A_D is faithful and irreducible
of dimension D−1, so the inequality is a lower bound on D. This is an
explicit surviving representation pattern, not a geometric realization.
