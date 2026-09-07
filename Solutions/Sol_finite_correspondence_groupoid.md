# Proof: a finite relation gives an effective orbifold

[Statement and audit evidence](../Theorems/Thm_finite_correspondence_groupoid.md).
Construction: /root/finite_correspondence_groupoid_envelope; original
consolidation: /root,2026-09-06. Characteristic is arbitrary.

## 1. Compose on entire normalizations

Use the finite set F of distinct joint images in the statement, and
put R=disjoint_union_(Gamma in F) R_Gamma. A connected component P
of composable arrows is smooth and integral. Its outer endpoints
map dominantly to an image Gamma in F, so normalization gives a
UNIQUE factorization P->R_Gamma. This holds even when the first map
has degree>1 and at collisions of image branches:
[Stacks, Lemma29.55.5(4)](https://stacks.math.columbia.edu/tag/035E).
It is finite etale, being a map over C between finite etale C-schemes.

These maps define composition. On each component of composable triples,
both parenthesizations have the same outer endpoints, hence the same
integral joint image. Normalization uniqueness makes them equal.
Transposition and the diagonal similarly give inverse and identity.
Distinct normalized images, rather than repeated path sources, ensure
that two components of R cannot represent the same generic arrow.

## 2. Quotient, properness and effectivity

The finite etale groupoid has quotient S=[C/R], with atlas C and
relation C x_S C=R:
[Stacks, Theorem97.17.2](https://stacks.math.columbia.edu/tag/06FI).
The atlas is representable finite etale by base change. Thus S is
smooth and one-dimensional, and

    deg(C/S)=sum_Gamma deg(R_Gamma/C).

The anchor R->C x C is finite, giving finite diagonal. The quotient
is finite type and universally closed: after any base change, the
inverse image of a closed subset in the proper surjective cover C
is closed and has the same image in the base. Thus S is proper DM.

Every nondiagonal joint image meets the diagonal only finitely often.
Away from these projections there is no nonidentity stabilizer, so
generic inertia is trivial. A local stabilizer inducing the identity
formal germ would have a branch contained in the diagonal; its integral
image would be the diagonal, whose normalization has only the identity
arrow. This is faithful action on FORMAL GERMS, not on tangent spaces.

For a disconnected C the construction is componentwise; its quotient
is connected precisely when the relation connects the components.

## 3. Universal property

If an effective atlas C->T has self-relation H=C x_T C a subunion of R,
normalization uniqueness makes its inclusion respect composition and
gives T=[C/H]->[C/R]=S. Any competing factorization over the given
atlas has the same arrow map H->R, again by normalization uniqueness;
this is uniqueness up to unique2-isomorphism.

After base change by C->S, this map is the scheme of H-cosets in R,
with fixed target and precomposition by H. Cancellation makes the
action free. Etale-locally this is a quotient of finite sets, so it is
representable finite etale, of degree deg(R/C)/deg(H/C). Enlarging the
relation makes the quotient smaller, in this direction.

## 4. Automorphisms of a hyperbolic-atlas quotient

If g(C)>=2, then Aut(S) is finite even with wild inertia. The group
pi1(S) contains the finitely generated open subgroup pi1(C), so is
finitely generated. It has finitely many connected covers of degree
n=deg(C/S), and Aut(S) acts on that finite set. The stabilizer of the
isomorphism class of C consists of automorphisms lifting to C; it is
a quotient of a subgroup of the finite Aut(C). Hence Aut(S) is finite.
Effectivity makes2-isomorphisms between automorphisms unique when they exist.

Finiteness of F is a HYPOTHESIS, not a consequence of finite generation
by a few correspondence seeds. The contact theorem supplies it in the
marked application; no arbitrary simultaneous Galois closure is inferred.
