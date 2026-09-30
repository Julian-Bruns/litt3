# Character Frobenius, normalizers and the remaining rank-three types

This proves the [rank-three restriction](../../Theorems/cartier_and_spin/rank_three_projective_monodromy.md).
Every nonzero map from an irreducible rank-three finite coefficient
to K is surjective, by the accepted finite-image argument. Use the
[low-degree semi-invariant exclusion](../../Theorems/cartier_and_spin/low_degree_twist_vanishing.md),
the [first projective-return exclusion](../../Theorems/cartier_and_spin/shifted_first_frobenius_vanishing.md),
and the [Frobenius-dual exclusion](../../Theorems/cartier_and_spin/frobenius_dual_coefficient_exclusion.md).

## The exceptional triple covers

The primary character data are the published5-Brauer tables of
[3.A6](https://www.math.rwth-aachen.de/homes/Thomas.Breuer/ctbllib/ctbltoc/data/3.A6.html)
and [3.A7](https://www.math.rwth-aachen.de/homes/Thomas.Breuer/ctbllib/ctbltoc/data/3.A7.html).
Each has exactly two absolutely irreducible characters of degree three.
For each of these four characters chi,
\[
\chi^{(5)}=\chi^\vee,
\]
where the left side applies the fifth-power Galois action to the
prime-to-five eigenvalues, and the right side inverts those eigenvalues.

This identity includes the whole table, not only generators or selected
classes. The [GAP-table verifier](../../scripts/arithmetic/exceptional_rank3_brauer_pairing.py)
retains every irreducible degree, the two degree-three rows and their
cyclotomic coefficients. The [independent integer-polynomial checker](../../scripts/arithmetic/verify_exceptional_rank3_brauer.py)
replays all62 value identities modulo Phi21 using ordinary integer
arithmetic. No numerical complex approximation or reduction of Brauer
values modulo five is used. The completeness of the published tables
is the input; the scripts do not re-prove it.

One can also see the identity directly from their character fields.
For 3.A6 the degree-three values lie in Q(zeta3), where5=-1 modulo3.
For 3.A7 the additional values are built from
zeta7+zeta7^2+zeta7^4 and its conjugate. Both exponent5 and exponent-1
interchange these two sums. The central zeta3 factors transform in
the same way. The published decomposition matrices
for [A6 and its covers](https://www.math.rwth-aachen.de/~MOC/decomposition/tex/A6/A6mod5.pdf)
and [A7 and its covers](https://www.math.rwth-aachen.de/~MOC/decomposition/tex/A7/A7mod5.pdf)
also show the two degree-three simple constituents.

Irreducible modules in characteristic five are determined by their
Brauer characters. Therefore every degree-three irreducible module W
of these covers satisfies W^(5)=W^vee. Its invariant nondegenerate
pairing is unique up to scalar by Schur's lemma. No semisimplicity
of representations of the whole finite group is assumed.

## Why every actual projective lift is covered

For a projective subgroup H isomorphic to A6 or A7, let Hhat be its
inverse image in SL3(k). Its kernel is the scalar group mu3.
The alternating groups in question are perfect with Schur multiplier
of order six, as recorded on the primary ATLAS pages
for [A6](https://brauer.maths.qmul.ac.uk/Atlas/alt/A6/)
and [A7](https://brauer.maths.qmul.ac.uk/Atlas/alt/A7/).
Thus the central extension is either split or the perfect triple cover.
The split possibility would give an actual faithful three-dimensional
linear representation of A6 or A7. Their characteristic-five tables
have no nontrivial simple modules of dimension at most three. A
three-dimensional representation with only trivial composition factors
has unipotent, hence solvable, image; perfection makes that image trivial.
This is incompatible with the given projective embedding. Hence Hhat
is the perfect triple cover.

Its three-dimensional representation is irreducible. Indeed the complete
triple-cover tables have no simple degree two, and their only degree-one
simple is trivial. Reducibility would again give only trivial composition
factors in dimension three and a trivial perfect-group image.

Choose the pairing matrix B, so
\[
h^{(5)t}Bh=B\qquad(h\in\widehat H).
\]
Every finite scalar lift of H then acts by similitudes of B: a scalar
lambda changes the multiplier by lambda^6. This yields an actual finite
character T and F*R=R^vee tensor T, without choosing away the scalar
character or changing the target K. The Frobenius-dual exclusion applies.

The same conclusion holds for any finite projective normalizer of H.
For a lifted normalizing matrix g, conjugation preserves Hhat. Therefore
(g^-1)^(5)t B g^-1 is another Hhat-invariant pairing. Its uniqueness
makes this a nonzero scalar multiple of B. Equivalently g^(5)t B g
is a scalar multiple of B. These multipliers are multiplicative, so
the entire actual finite lift still has the required character-valued
pairing. In particular this excludes the A6 index-two exceptional type;
an index-two subgroup is normal. It excludes A7 directly as well.

This normalizer argument does not identify abstractly isomorphic
projective subgroups without checking their representations. The
complete degree-three Brauer-table argument covers every representation
of each relevant triple cover, so no geometric conjugacy assumption is
missing here.

## Removing the other small types

Apply [Dolgachev--Martin, Theorem2.6](https://sites.lsa.umich.edu/idolga/wp-content/uploads/sites/1334/2024/08/autodelPezzoOdd.pdf).
The actual geometric interpretation of its parabolic item13 is recorded
in the [tame-source proof](tame_rank_three_second_projective_return.md),
using the original classification and the paper's proof of Theorem4.4.
That interpretation remains valid for wild groups; an abstract GL2
quotient alone would not justify this step.

- The conic PSL2/PGL2 types preserve a nondegenerate quadratic form,
  up to character. The low-degree theorem excludes them, in all q.
- PSL2(7) preserves the Klein quartic. Apply the classification to
  the dual as necessary to obtain the required symmetric semi-invariant;
  the accepted quartic exclusion applies in characteristic five.
- The normal diagonal types preserve a proper eigenspace or permute
  three lines, hence are reducible or imprimitive. The parabolic types
  preserve a proper linear subspace. Irreducibility and the accepted
  imprimitive exclusion remove them. This retains the case of a trivial
  normal p-subgroup, which cannot be dismissed just from its abstract
  quotient description.
- The Hessian types have the already verified fifth-power dual pairing
  and are excluded. The alternating exceptional types were settled above.

Only the linear and unitary families, and their stated index-three
normal overgroups, remain.

For q=5 in the linear case, matrices in any actual finite scalar lift
have the form lambda_g B_g with B_g over F5. Thus A_g^(5)=lambda_g^4 A_g.
The multipliers are independent of the F5 scalar representative and
form a character. This supplies F*R=R tensor M, which the first
projective-return theorem excludes. The classification's associated
index-three case requires3 dividing q-1 and cannot occur at q=5.

For q=5 in the unitary case, the natural nondegenerate fifth-power
pairing gives F*R=R^vee tensor T. Its invariant pairing under the
perfect special unitary subgroup is unique because the natural
representation is absolutely irreducible. The same normalizer argument
therefore covers the listed index-three overgroups, retaining their
finite scalar characters. The Frobenius-dual exclusion removes them.

Thus every remaining linear or unitary parameter satisfies q=5^a,a>=2.
No assertion is made about those larger groups, arbitrary coefficient
ranks, or a coefficient attached to every actual common cover.

## Reproduction and evidence

Run the GAP-table script with Sage and its `--output` argument, then
run the elementary checker on that JSON with its own `--output`.
The completed receipts `exceptional_rank3_brauer_pairing.json` and
`verified_exceptional_rank3_brauer.json` are in
[the external evidence directory](../../../litt3-computation-data/overnight_three_replies_20260926/).
They include GAP and Character Table Library versions, the full degree
lists and retained exact values. The arithmetic check supports the
explicit character identities; the primary character tables and the
finite-projective-subgroup classification remain named literature inputs.
