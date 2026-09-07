# Proof: bounded effective atlases give finitely many partners

Canonical [statement](../Theorems/Thm_bounded_atlas_partner_finiteness.md).
Audited PASS, /root/x_elliptic_quotient_maps, 2026-09-05; metadata is
in the registry. The equivalent proof was shortened on 2026-09-06.

The etale fundamental group of a smooth projective curve over an
algebraically closed field is topologically finitely generated. In
positive characteristic this follows from a lift and the surjective
[specialization map](https://stacks.math.columbia.edu/tag/0C0P).
Consequently a fixed curve has finitely many connected etale covers
of bounded degree: use its finitely many homomorphisms to each S_d.

Given X -> S of degree n<=B, take its Galois closure W -> S in the
finite-etale covering category. Then W -> X is a connected etale
curve cover of degree at most (n-1)! <= (B-1)!, the order of a point
stabilizer in the permutation group. Thus there are finitely many W.
Since g(W)>=2, Aut(W) is finite. Effectivity makes the action of the
Galois group G on W faithful, so S=[W/G] for one of finitely many
subgroups of Aut(W). This proves finiteness of S.

For any one S, pi_1(S) contains the finitely generated pi_1(W) as an
open subgroup and is therefore finitely generated. Its canonical degree
delta=(2g(X)-2)/n is positive. A genus-h curve atlas Y -> S must have
the single degree (2h-2)/delta=(h-1)n/(g(X)-1), or none exists if this
is not integral. There are finitely many such covers of S, proving
the partner assertion.

A uniform bound B in a positive-dimensional family of varying genus-h
curves therefore leaves only finitely many common-orbifold partners.
Removing a finite set from such a family still leaves geometric points
even over an algebraic closure of a finite field. This does not remove
a merely countable union.

The Galois closure above is over an orbifold ALREADY given. No step
constructs a simultaneous Galois envelope for an arbitrary coreless
span, and no bound B is supplied by this lemma.

## Explicit count

Now assume characteristic five. A genus-g projective curve has at most
2g topological fundamental-group generators by the same full specialization
surjection above. Thus the possible W->X of degrees at most D number
at most D*(D!)^(2g), and their genera are between2 and G.

For any such W, Aut(W) embeds into GL_(2g(W))(F3), including wild
automorphisms. Indeed its action on H^1_et(W,Q3) is faithful: a finite
cyclic subgroup acting trivially would give a quotient of the same
genus, by the pullback/norm identities and invariant cohomology. This
contradicts separable Riemann--Hurwitz for a nontrivial group. Finally
the principal congruence kernel of GL_n(Z3)->GL_n(F3) is torsion-free.
For I+3^s A, s>=1 and A nonzero modulo3, a prime-to-three power
preserves the first nonzero valuation and cubing raises it exactly by
one. Hence a finite-order element in the kernel is the identity.
Consequently |Aut(W)|<3^(4G^2).

The Galois group H of W->S embeds in S_n, so |H|<=B!. A subgroup of
that order has at most floor(log_2(B!))<=B^2=L generators. Padding by
identities bounds the possibilities for H inside Aut(W) by 3^(4G^2 L).
Effectivity identifies S with [W/H]. From

    1 -> pi_1(W) -> pi_1(S) -> H -> 1

one gets at most 2G+L generators for pi_1(S), without assuming a split
extension. A genus-h atlas has ONE possible degree m for a fixed S,
as shown above; m<=M. Thus its connected covering objects number at
most (M!)^(2G+L), with no additional sum over m. Multiplication gives K.
Counting extra objects or presentations merely overcounts.

When all orbifold degrees of X obey B, the
[`cored_orbifold_bridge`](../Theorems/Thm_cored_orbifold_bridge.md)
gives both actual atlases from every cored bi-etale span. The count
therefore includes every cored partner; it does not require the
original two legs to be Galois.

## A parameter avoiding every cored partner

Let X/F_q and h=2 be as in the statement. The finite partner set is
stable under coefficient q-Frobenius, so every geometric moduli orbit
in that set has length at most K.

The family Y_t is smooth for t outside{0,1,2,3}. It is ordinary for
t!=4: its Hasse--Witt matrix has entries

    [-2t^2-t+1   -2t^2-2t]
    [  -2t-2      t^2-t-2],      determinant=3(t+1)^4.

Every geometric isomorphism class contains at most120 parameter values.
An isomorphism of genus-two curves induces a Mobius transformation of
their six hyperelliptic branch points. Fix one branch set. The ordered
preimages of infinity,0,1 have at most6*5*4 choices, each determining
the transformation. If its image contains infinity,0,1,2,3, the remaining
point determines t uniquely. Special automorphisms only reduce this bound.

Choose t of prime degree r>max(K,120) over F_q. The q-Frobenius moduli
orbit of Y_t has length dividing r. Length one would put all r distinct
conjugates of t in one isomorphism-class fiber, contradicting the bound120.
Thus its length is r>K, and Y_t is not a cored partner. The parameter
lies outside F_q, hence outside F5, so smoothness and ordinarity hold.
Irreducible polynomials of every positive degree over a finite field
exist; the deterministic prescription in the statement terminates.

This proves no restriction on coreless spans and no simplicity assertion
for J(Y_t). The count and parameter argument were independently audited
PASS by /root/audit_effective_cored_partner_bound,2026-09-07.
