# Proof: bounded effective atlases give finitely many partners

[Statement](../../Theorems/quotient_geometry/bounded_atlas_partner_finiteness.md).

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

A genus-g projective curve in any characteristic has at most
2g topological fundamental-group generators by the same full specialization
surjection above. Thus the possible W->X of degrees at most D number
at most D*(D!)^(2g), and their genera are between2 and G.

For every smooth projective genus-γ curve C, γ≥2,

    |Aut(C)| < 81γ⁴ < 3^(4γ²).

In characteristic zero this follows from the Hurwitz bound. In positive
characteristic, Stichtenoth's bound is |Aut(C)|≤16γ⁴ except for the
Hermitian curve H_q; see [Montanucci–Zini, Section1](https://arxiv.org/pdf/1804.03398),
which also records γ=q(q−1)/2 and Aut(H_q)=PGU(3,q). For q≥3,
q²≤3γ and |PGU(3,q)|=q³(q³+1)(q²−1)<q⁸≤81γ⁴.
Thus |Aut(W)|<3^(4G²), including wild automorphisms.

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
[`cored_orbifold_bridge`](../../Theorems/quotient_geometry/cored_orbifold_bridge.md)
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

The [affine branch-family invariant](../curve_arithmetic/prime_field_branch_family.md)
identifies the moduli orbit of Y_t with that of
I_t=((1/(t−4))^5−1/(t−4))^4. A prime parameter degree r>5 gives
full moduli orbit length r. Since K≥3^64, choosing r>K excludes
Y_t from the Frobenius-stable partner set. It also puts t outside F5,
so smoothness and ordinarity hold. Irreducible polynomials of every
positive degree exist over a finite field; the deterministic prescription
in the statement terminates.

This proves no restriction on coreless spans and no simplicity assertion
for J(Y_t).

## Fixed quotients and the selected Hermitian avoidance

For \(\mathcal S=[D/G]\), the actual torsor \(D\to\mathcal S\)
is finite étale of degree \(|G|\), even if the action has fixed
points or \(p\mid|G|\). Hence
\(\deg\omega_\mathcal S=(2d-2)/|G|\), and a genus-\(h\)
étale atlas has degree \(n=(h-1)|G|/(d-1)\). The fundamental-group
sequence for this GIVEN quotient is
\(1\to\pi_1(D)\to\pi_1(\mathcal S)\to G\to1\).
As above, \(\pi_1(D)\) has at most \(2d\) generators. The
subgroup-doubling argument gives \(G\) at most
\(\lfloor\log_2|G|\rfloor\) generators; lifts together with the
curve generators generate the extension, whether or not it splits.
Every connected degree-\(n\) cover is counted by a transitive
homomorphism to \(S_n\), so \((n!)^a\) bounds the number of
isomorphism classes of its source curves. Frobenius permutes the
finite set because the quotient is defined over \(\mathbf F_q\).
The prime-degree parameter argument above, with the additional
fiber bound \(c\), proves avoidance for a finite list of targets.

For the Hermitian sextic, the standard genus and group-order
formulas give \(d=10\) and
\(|\operatorname{PGU}_3(5)|=5^3(5^3+1)(5^2-1)=378000\)
([Montanucci--Zini, Sections 1--2](https://arxiv.org/pdf/1804.03398)).
Thus \(n=42000\) and \(a=20+18=38\), also with wild unitary
stabilizers. The established [branch-family theorem](../curve_arithmetic/prime_field_branch_family.md)
makes the moduli orbit of a prime-degree parameter \(t\) have full
length once that degree exceeds five. In the displayed \(K\), the
exponent \(2G+L\) on \(42000!\) exceeds 38; hence the already
selected \(r>K\) excludes every atlas to \([H/G]\). For a subgroup
\(G'\le G\), the quotient map \([H/G']\to[H/G]\) is representable
finite étale by pulling it back to \(H\), where it is the constant
coset cover. Composing gives the same exclusion for all \(G'\).
This uses an atlas on \(Y_t\) itself; an atlas upstairs on a
further cover need not descend.
