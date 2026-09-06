# Proof record: Finite composition-closed images give an effective orbifold

Canonical statement: [`finite_correspondence_groupoid`](../Theorems/Thm_finite_correspondence_groupoid.md).
Migrated 2026-09-06; hypotheses restated below are proof context.
The canonical statement and registry control promoted scope and evidence.

---

# Finite composition-closed correspondences have a canonical orbifold

Date: 2026-09-06. Construction by `/root/finite_correspondence_groupoid_envelope`;
formulation and proof consolidation by `/root`.
Status: included in the substantial independent PASS audit by
`/root/canonical_marked_quotient_major_stress_test`, 2026-09-06.
[Verdict and nonbreaking clarifications](../routes/global/audits/CANONICAL_MARKED_QUOTIENT_MAJOR_STRESS_TEST_2026_09_06.md).
The lemma is in arbitrary characteristic and has no differential or
Jacobian hypothesis.

## Theorem

Let C be a smooth projective connected curve over an algebraically closed
field. Let F be a FINITE set of distinct integral reduced curves in C x C
whose normalizations R_Gamma are finite etale over both factors. Assume:

1. F contains the diagonal and is closed under transposition.
2. For every connected component of R_Gamma x_C R_Lambda, its reduced
   joint image under the two outer endpoint maps belongs to F.

Then R=disjoint_union R_Gamma is canonically a finite etale groupoid over
C. The quotient S=[C/R] is a smooth proper connected effective
Deligne--Mumford curve, and

    C -> S is representable finite etale,
    C x_S C = R,
    deg(C/S)=sum_Gamma deg(R_Gamma/C).                         (1)

Effectivity means trivial generic inertia, or faithful action on formal
germs. It does NOT mean faithful action on tangent spaces in wild
characteristic.

If an effective finite etale atlas C -> T has self-relation a subunion
of R over C x C, there is a unique compatible factorization, up to unique
2-isomorphism,

    C -> T -> S,                                               (2)

and T -> S is representable finite etale. This is the direction of the
universal property: enlarging the relation makes the quotient smaller.

The construction also works with C a finite disjoint union of smooth
projective curves, with the same finite etale hypotheses. Its quotient
is connected if the relation connects its connected components.

## Proof: composition is defined on the whole normalization

Every connected component P of a fiber product of arrows is smooth and
integral. Its first endpoint is finite etale over C. The two outer
endpoints give a dominant map onto an integral curve Gamma in F. The
normal-source universal property gives a unique factorization

    P -> R_Gamma -> Gamma subset C x C.

This factorization does not require P -> Gamma to be birational; it
holds on the entire curve, including collisions of joint-image branches.
See [Stacks, Lemma29.55.5(4)](https://stacks.math.columbia.edu/tag/035E).
The first map is finite etale, being a map over C between finite etale
C-schemes. These maps define composition.

The same uniqueness proves the groupoid laws. On a connected component
of any space of composable triples, two parenthesized composites have
the same endpoint maps. They must land in components with the same
integral joint image, hence in the same R_Gamma, and normalization
uniqueness makes them equal. Transposition gives inversion and the
diagonal gives the identity; the identical argument proves their laws.

This argument also explains why distinct normalized images, not a list
of path sources with repetitions, are essential. Two distinct components
of R cannot represent the same generic arrow.

## Proof: the quotient and its effectivity

The finite etale groupoid has an algebraic quotient stack, with etale
atlas C and relation R; use
[Stacks, Theorem97.17.2](https://stacks.math.columbia.edu/tag/06FI).
Its atlas is finite etale by base change, since the corresponding maps
R -> C are finite etale. Smoothness and dimension follow from this atlas.
The anchor R -> C x C is finite (use the graph of one endpoint and
finiteness of the other), so the quotient has finite diagonal. It is
universally closed: after any base change, a closed subset has closed
inverse image in the proper surjective cover C, with the same image in
the base. It is of finite type. Thus S is proper and Deligne--Mumford.

Every nondiagonal joint image meets the diagonal at only finitely many
points. Remove their projections. Over the remaining nonempty open of C,
the only stabilizer is the identity; generic inertia is therefore trivial.
Locally, a stabilizer arrow inducing the identity formal germ would have
a branch contained in the diagonal. Its integral joint image would then
be the diagonal, whose normalization has only the identity arrow. This
also proves faithful action on formal germs, without a tameness assumption.

## Proof: factorization

Write H=C x_T C. Its inclusion in R respects composition, by the same
normalization uniqueness. It induces [C/H] -> [C/R]. A competing
factorization respecting the given atlas would give another morphism
H -> R with the same endpoints, which is again the same morphism.

After base change by C -> S, this map is the finite etale scheme of
H-cosets in R (arrows with fixed target, modulo precomposition by H).
The action is free by cancellation. Existence and finiteness can be
checked after etale-local trivialization by finite sets. This proves
representability and finite etaleness; its degree is deg(R/C)/deg(H/C).

## A useful finiteness supplement

If S has a finite etale atlas C of genus at least two, its group of
geometric automorphisms is finite, including when inertia is wild.

Indeed pi_1(S) has the finitely generated open subgroup pi_1(C), hence
is finitely generated. There are only finitely many connected degree-n
etale covers of S, where n=deg(C/S). Aut(S) acts on this finite set.
The stabilizer of the isomorphism class of C consists of automorphisms
lifting to C; it is a quotient of a subgroup of the finite group Aut(C).
Thus it is finite, of finite index in Aut(S). Effectivity makes any
2-isomorphism between automorphisms unique when it exists. No bound on
wild stabilizer orders was inserted into this argument.

The lemma does not prove F finite. A separate boundedness theorem must
provide that hypothesis; it must not be inferred from finite generation
of a correspondence by one or finitely many seeds.
