# Proof: elliptic intermediate quotients and the integral icosahedron identity

Author /root, version2, 2026-09-09. No independent audit or Lean claim.

## 1. Exact monodromy inputs

One-cover tame lifting supplies the characteristic-zero branch-cycle
classification for an actual characteristic-five cover, preserving its
group. See the source-checked [tame-lifting argument](Sol_triangle344_frobenius_obstruction.md#1-complete-finite-census-and-its-characteristic-five-use).
There is no simultaneous-lifting assertion about two unrelated etale maps.

The complete ordered branch-cycle classes have the following monodromy
and deck-group sizes:

| Profile | Monodromy | Classes | Deck order |
|---|---|---:|---:|
|2233, degree6|C6 regular|1|6|
|2233, degree6|S3 regular|2|6|
|2233, degree6|S4/C4|6|2|
|2223, degree12|regular order12|3|12|
|2223, degree12|order48|18|4|
|2223, degree12|A5/C5|9|2|
|2223, degree12|order96|9|4|

Here S4/C4 and A5/C5 denote their transitive coset actions, not quotient
groups. The complete [GAP generator](../scripts/genus_two_quadrangular_monodromy.sage)
checks every inertia CYCLE LENGTH. Its counts agree with
[Hulpke--Kuusalo--Naatanen--Rosenberger, p3](https://www.math.colostate.edu/~hulpke/paper/revista.pdf),
which includes nonnormal subgroups. Receipts are
[2233](../Research/computations/genus_two_quadrangular_2233.json) and
[2223](../Research/computations/genus_two_quadrangular_2223.json).

The deck group is N_G(H)/H, equivalently the permutation centralizer.
Aut(C)=C2 leaves only S4/C4 and A5/C5. The independent
[standard-library checker](../scripts/verify_quadrangular_quotients.py)
recomputes the groups, centralizers, and following finite identities for
EVERY retained row. It does not replace the separate completeness proof.

## 2. Degree six: a bielliptic involution, not character arithmetic

Let W be the actual Galois closure and H=C4 in G=S4. Its normalizer J
is D8, so [J:H]=2. The quotient C=W/H -> E=W/J is an actual double
cover. The degree-three quotient E->P1 is the action of S4 on the three
partitions of four letters into pairs. The two transposition inertias
act with cycles (2,1), and the two 3-cycles act with cycle (3).
Thus 2g(E)-2=-6+1+1+2+2=0. The double-cover involution is not
hyperelliptic, since its quotient has genus one. This contradicts Aut(C)=C2.

## 3. Degree twelve: actual correspondences from the four double cosets

Here G=A5, H=C5, C=W/H, and g(W)=6 by Hurwitz. All point stabilizers
of W->P1 have order2 or3. Consequently EVERY order-five subgroup acts
freely on W. Its quotient map is finite etale, even in characteristic5.

Identify G/H with the twelve vertices of an icosahedron. There are four
H-orbits: the chosen vertex, its antipode, its five neighbors, and the
five antipodes of those neighbors. The antipodal permutation commutes
with G and is the nontrivial deck element N_G(H)/H=C2. On C it is
therefore precisely the hyperelliptic involution iota.

Let A and B be the two reduced off-diagonal correspondence cycles in
C x_(P1) C corresponding to those size-five orbits. Their normalizations
are W: the stabilizers of two nonantipodal vertices are distinct C5's,
with trivial intersection. BOTH maps W->C are the actual free C5
quotients just described, and both degrees are5. The cycles are symmetric,
and B is obtained from A by applying iota on its second factor.
Both maps followed by the original C->P1 give the same W->P1, so this
constructed self-span has an actual nonconstant common quotient P1.
No coreless self-correspondence is being constructed here.

## 4. The cycle identity holds at branch fibers as well

In an icosahedron a vertex has five neighbors; adjacent vertices have
two common neighbors, as do distance-two vertices; antipodal vertices
have none. Counting length-two paths therefore gives

                    A composed with A = 5 Delta + 2A + 2B.       (1)

These are integer multiplicities, NOT coefficients in k. One can verify
the count without a drawing by closing any of the supplied A5 permutation
groups, finding its H-orbits, and checking the twelve-by-twelve integer
adjacency identity. The checker does so for BOTH choices of the
five-valent relation in ALL nine A5 rows.

To justify (1) globally, compute first over the open subset of P1 away
from the four branch values, where it is precisely the finite-set path
count. Composition is defined by fiber product of the two etale legs
and proper pushforward to C x C. Every component is a curve finite and
surjective over C. Thus no extra one-dimensional component can be supported
over a branch fiber; equality over the open subset extends by taking
closures with their generic multiplicities. This establishes (1) as
actual global correspondence cycles, not just as an abstract Hecke table.

Let T be the induced homomorphism of J(C). It is integral because it is
the norm-pullback of the actual degree-five span. Transposing a curve
correspondence gives its Rosati adjoint, so symmetry makes T^dagger=T.
Since iota induces [-1] on J(C), B induces -T. Applying the correspondence
action to (1) gives

                         T^2=[5]+2T-2T=[5].

The correspondence/Jacobian dictionary and its compatibility with the
canonical principal polarization follow from
[Milne, Jacobian Varieties, Section6](https://www.jmilne.org/math/xnotes/JVs.pdf),
especially Cor6.3 and autoduality. Equivalently use adjunction of norm
and pullback. The endomorphism [5] is nonzero in characteristic5;
its differential being zero has no bearing on this integral identity.

## 5. Backup arithmetic and reproduction

For C_alpha the retained exact [arithmetic certificate](../scripts/backup_genus_two_prepare.sage)
gives an ordinary geometrically simple Jacobian with

    P(z)=z^4-8z^3+182z^2-1000z+15625.

The root-ratio check ensures that its geometric endomorphism algebra is
the same commutative quartic CM field K=Q(pi) as over F125. Rosati is
complex conjugation. With theta=pi+125/pi, its fixed real field satisfies

    theta^2-8theta-68=0,   hence K^+=Q(sqrt21).

T^2=[5] and T^dagger=T would put a root of z^2-5 in K^+, impossible.
The elementary Aut(C_alpha)=C2 proof is in the
[triangle application](Sol_triangle344_frobenius_obstruction.md#4-the-backup-needs-no-jacobian-arithmetic-for-this-exclusion).
This arithmetic input is author-checked, not included in the separate
backup atlas audit; no broader audit claim is made.

Run python3 scripts/verify_quadrangular_quotients.py from the repository
root. All48 rows, six elliptic quotients, and eighteen adjacency identities
passed in0.013 seconds. If independently regenerating the complete
censuses, use the shared Sage script with --profile 2233 and --profile 2223;
their recorded run times are about0.27s and5.83s excluding startup.

The old Pro prompt was RESOLVED LOCALLY. For the current remainder use
BACKUP_CANDIDATE; the later degree24 theorem also uses this result.
No endpoint pivot follows.
