# Audit: elliptic character bounds and finite étale descent

Date: 2026-09-05.
Auditor: /root/gluing_cohomology_rigidity.
Verdict: **PASS**, with no breaking objections.

## Scope

The auditor read the following current proof notes:

- [Elliptic character directions and polarization-controlled a-numbers](../ELLIPTIC_CHARACTER_DIRECTIONS_AND_POLARIZATION_CONTROLLED_A_NUMBERS.md):
  the full note, with a new focused check of §3.2 for a supersingular
  elliptic subvariety without an ordinary-complement hypothesis.
- [Finite bad characters force uniform étale target descent](../FINITE_RESTRICTED_THETA_CHARACTERS_FORCE_UNIFORM_ETALE_TARGET_DESCENT.md):
  the finite-character/Frobenius argument and the actual common-enlargement,
  descent, and bounded joint-image interfaces.
- [Odd generalized-dihedral towers over ordinary genus two](../ODD_GENERALIZED_DIHEDRAL_TOWERS_OVER_ORDINARY_GENUS_TWO_HAVE_FINITE_NONORDINARY_TARGETS.md):
  the monodromy-family interface, polarization and four/five a-number
  calculations, and final actual-map classification/descent.

Some of the last two sets of interfaces and the ordinary-complement
specialization had already received focused checks from this auditor
during author discussion. This record consolidates those delivered checks
and the fresh general local-ring check; it is not a claim that those
earlier collaborative contributions were independently re-proved by
their author.

Previously audited whole-Jacobian descent, the Raynaud divisor class,
and the precise Tong Dirac property are inputs, not newly audited
primary foundations here.

## Principal mathematical checks

### 1. The new supersingular-subgroup argument

For \(E\subset J(C)\) supersingular, Verschiebung functoriality gives
\[
             H=\ker V_E\subset K=(\ker V_{J(C)})^0.
\]
The group \(H\) is connected of length \(p\). Its local ring, as a
subscheme of the smooth curve \(E^{(1)}\), is \(k[t]/(t^p)\).

The local ring \(\mathcal O_K\) is Artin local Gorenstein: an isogeny
between smooth abelian varieties is finite flat, and its local fiber
is a zero-dimensional complete intersection. Every nonzero ideal in
such a ring contains its one-dimensional socle. Indeed a last
nonzero term of the maximal-ideal filtration of the ideal is a
nonzero subspace of the socle.

Therefore, if \(H\ne K\), the nonzero kernel of
\(\mathcal O_K\to\mathcal O_H\) contains the Dirac socle generator.
The theta equation restricts to zero on \(H\), so its restriction
to \(E^{(1)}\) vanishes to order at least \(p\). If \(H=K\), its
restriction is a nonzero multiple of \(t^{p-1}\) modulo \(t^p\),
so the order is exactly \(p-1\).

Properness of the theta restriction ensures that this restricted
equation is not identically zero. In particular the note's weaker
uniform assertion \(\operatorname{mult}_0\ge p-1\), and its
subsequent a-number estimate, are correct. No ordinary complement
is needed for this local argument.

### 2. Degree, multiplicity, and a-number calculations

The scalar-twisted embedding \(E^{(1)}\subset J(C^{(1)})\) preserves
the polarization degree \(e\); it is not pullback along an isogeny
of degree \(p\). Hence the determinant restriction has degree
\((p-1)e\).

A generically acyclic, equal-rank two-term cohomology complex over
the DVR of \(E^{(1)}\) has special corank \(h^0(B_C\otimes\alpha)\).
Smith normal form gives determinant valuation at least that corank.
The prime-to-\(p\) character decomposition counts each label once.

For ordinary \(E\), its \(p-1\) nonzero Verschiebung-kernel points
lie on theta by the elementary Frobenius exact sequence. Their
order is \(p\), so none belongs to the permitted character subgroup.
This subtraction does not require \(C\) to be ordinary.

For supersingular \(E\), the zero character contributes \(a(C)\),
whereas the restricted theta multiplicity at zero is at least
\(p-1\). These facts prove precisely the two stated bounds.
Étale pullback on global sections of \(B\) is injective even in
characteristic-divisible degree, so every actual étale target
inherits the same bound.

If \(J(C)/E\) is ordinary, p-rank additivity gives defect zero or
one according as \(E\) is ordinary or supersingular. Thus \(a(C)\)
is respectively zero or one. This uses \(a\le g-f\), not
a-number invariance under a potentially p-divisible isogeny.

### 3. Finite characters control the entire new Frobenius block

The finite bad character set generates a finite subgroup
\(\Lambda_0\), even with unrestricted prime support. Multiplication
by \(p\) is an automorphism of every prime-to-\(p\) subgroup, so
\(\Lambda_0\) contains all forward and inverse character iterates
of the bad set; the bad set itself need not be invariant.

For \(\Lambda\supset\Lambda_0\), the complementary character block
has zero first Frobenius kernel and is Frobenius-stable. It therefore
has bijective Frobenius. The norm projector for the prime-to-\(p\)
relative deck group identifies this block with the relative Prym
cohomology. Consequently the relative Prym is ordinary. This is
control of the entire new block, not an inference from a bounded
first-kernel dimension to bounded stable nilpotence.

### 4. Common enlargement retains the original maps

For an arbitrary \(\Lambda\), the connected cover associated to
\(\Lambda+\Lambda_0\) dominates both \(W_\Lambda\) and \(W_{\Lambda_0}\)
by actual finite étale maps. After this pullback, whole-Jacobian
orthogonality gives descent to the fixed \(W_{\Lambda_0}\).
No arrow \(W_\Lambda\to W_{\Lambda_0}\) is assumed when their
character groups are not nested.

In a compatible Kummer field,
\[
 k(W_\Lambda)\cap k(W_{\Lambda_0})
                      =k(W_{\Lambda\cap\Lambda_0}).
\]
Thus a map originally defined on \(W_\Lambda\) even descends to
this actual common intermediate. For a general specified intermediate
\(Z/B\), the field
\[
                    k(B)\,r^*k(T)\subset k(Z)\cap k(W_{\Lambda_0})
\]
gives the bounded joint image asserted in the finite-character note.
Both maps out of its normalization remain intermediate factors of
the actual étale maps, and hence are étale.

The target condition is no ordinary simple Jacobian factor, not
merely that the whole target Jacobian is nonordinary. With that
condition the fixed finite cover works for all target genera.
Finiteness follows from bounded outgoing étale degrees from one
fixed hyperbolic curve and the bounded Galois-closure argument.

### 5. The generalized-dihedral family is genuinely covered

An odd prime-to-five generalized-dihedral closure has a connected
étale double quotient \(U/Y\). Its abelian character subgroup is
anti-invariant. The finite component ambiguity of the norm kernel
is two-primary, so odd anti-invariant characters lie in the elliptic
Prym itself. Conversely an allowed Prym subgroup gives the stated
inversion extension, which splits because an inversion lift has
square of order dividing two in an odd group.

Thus the directed character covers actually parametrize the stated
monodromy class. The fifteen nontrivial two-torsion characters of
the genus-two base give exactly fifteen doubles. Arbitrary actual
intermediate sources are handled by pulling their target maps up
to their Galois closure, not by replacing a second leg.

The induced Jacobian polarization has degree two on the elliptic
Prym. The displayed isogeny-degree computation gives its auxiliary
Prym decomposition degree eight, prime to five. The general bounds
therefore specialize to four in the ordinary-double case and five
otherwise. No bound on stable defect is inferred from these numbers.

## Nonbreaking observation

In the strict subgroup case \(H\subsetneq K\), §3.2 actually proves
\(\operatorname{mult}_0\ge p\), rather than only \(p-1\). The weaker
bound stated in the theorem is valid and needs no correction.

## Reviewed snapshots

SHA-256 values recorded before any subsequent status/link metadata edits:

- General elliptic note:
  `2a0322cbdd56db6e2fbb91396f7f358991a5ffd41da67b0531fa3f42d5f31f84`.
- Finite-character note:
  `ab7898da89618a6046bf0c90083f8578f783bb116f83f2eed9028b25f4487774`.
- Generalized-dihedral note:
  `8e0ce3a47bf660eebeee96d71bcca670da02671a945c0c89bfca0ee30ec90f2e`.

No theorem text was edited in this audit.
