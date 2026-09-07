# Genus-two inversion towers: finite targets and uniform a-number bounds

Author proofs /root/canonical_trace_algebra,2026-09-05, consolidated2026-09-07.
Focused PASS /root/gluing_cohomology_rigidity2026-09-05 covers the
odd-character4/5 a-number refinement and, separately, the fixed-exponent
existence construction. The combined inversion theorem is NOT independently
audited; the even-character28 bound remains author-only.

Work over k=bar(F5), with smooth projective connected curves. The
finite-target statements require hyperbolic T with NO ordinary simple
isogeny factor in J(T), not merely a nonordinary whole Jacobian.
The a-number bounds below have NO such target restriction.

## 1. Exact odd and even scopes

Fix ordinary genus-two Y and an ACTUAL connected etale double
a:U→Y, with involution τ and defining nonzero ε∈J(Y)[2].
On scalar Frobenius twists put

    J=J(U^(1)), P=(ker Nm_a^(1))^0, K=ker(1+τ^(1)*).

P is elliptic. For a finite prime-to-five subgroup Λ⊂J(k), let
W_Λ→U be its connected etale character cover, constructed first
on U^(1) and transported by etale Frobenius base change.
Choose compatible basepoints, so W_(Λ+Λ′) dominates both covers.

For EVERY ordinary Y, take Γ=P(k)_((10)′), all torsion of order
prime to10, with NO fixed finite odd-prime support. Then:

* There is one finite Λ₀⊂Γ such that W_Λ/W_Λ₀ has ordinary Prym
  whenever Λ⊃Λ₀. Every morphism to every allowed T descends
  uniquely to W_Λ₀, retaining etaleness if present.
* Only finitely many such T occur as etale targets of any W_Λ
  or ACTUAL intermediate Z of W_Λ→Y, simultaneously for all15
  double quotients U→Y. Each such two-map span factors through
  an actual bi-etale quotient D with deg(D/Y)≤2|Λ₀|.
* a(W_Λ)≤4 if U is ordinary and≤5 otherwise. Every etale target
  of W_Λ or an intermediate therefore has a(T)≤5.

These are exactly the actual generalized-dihedral covers with abelian
ODD prime-to-five kernel, and their intermediates; Section3 proves
the group interface rather than assuming simultaneous Galoisness.

For EVEN characters impose the additional explicit hypothesis

    (H4)  Θ_Y(k)∩J(Y^(1))[4](k)=∅, INCLUDING the origin.

Equivalently, the maximal abelian etale exponent4 cover of Y is
ordinary, by character decomposition. H4 is NOT asserted for every
ordinary Y. Under H4 use Γ=K(k)_(5′); the same finite-level,
finite-target and actual quotient conclusions hold, and a(W_Λ)≤28.
This includes every ACTUAL inversion extension

    1→A→G→C₂→1, 5∤|A|, A abelian, quotient acting by−1,

whether split or nonsplit. No five-primary kernel is covered.
Bases satisfying H4 exist by Section6; no explicit equation is supplied.

## 2. The precise anti-invariant components

Before scalar twisting, ker a^*={0,ε} scheme-theoretically:
projection formula gives h⁰(U,a^*L)=h⁰(Y,L)+h⁰(Y,Lε), and the
kernel lies in the etale J(Y)[2] by Nm_a a^*=[2].
Norm is smooth surjective, also on tangent spaces. Factor it as

    J(U)→B=J(U)/P --β→J(Y).

Under principal polarizations the dual of norm is a^*, so deg β=2
and ker β=C₂. Riemann–Hurwitz gives g(U)=3. Thus

    (ker Nm_a)/P=C₂,   J(U)/P ordinary.

Since a^*Nm_a=1+τ^*, the induced h=a^*β:B→J(U) has kernel of
order4. The image of τ^*−1 is connected in ker norm, hence in P.
Consequently, for the quotient π:J(U)→B, πτ^*=π and πh=[2].
Therefore ker h is killed by2, and

    K^0=P,   K/P=C₂².                                      (1)

All component groups are etale. In particular every odd-order
anti-invariant subgroup lies in P. These identities persist on twists.

For the even case define
S_ε={M∈J(Y^(1))[4]:2M∈{0,ε^(1)}}. Its size is32, and
a^(1)*S_ε=`K[2](k)` has16 points. Indeed pullback has kernel of order2;
each image is two-torsion and anti-invariant. Conversely every one
of the four components in(1) has a two-torsion representative:
subtract y∈P with2y=2x from a point x of that component.
Each has exactly |P[2]|=4 such points, proving the assertion.

For t=a^(1)*M in this16-point set, H4 and projection formula give

    h⁰(B_U⊗t)=h⁰(B_Y⊗M)+h⁰(B_Y⊗Mε^(1))=0.               (2)

Thus EVERY elliptic component of K contains a good point, so its
theta restriction is proper and finite. Also U and P are ordinary.
For a fixed U it suffices to avoid S_ε; the union of S_ε over all15
nonzero ε is all J(Y^(1))[4], giving the stated uniform H4.

## 3. The actual group interface, with nonsplit extensions retained

On P, τ^*=−1, and on all of K the same holds. For finite Λ⊂K(k)_(5′),
this makes its character-cover kernel in π₁(U) invariant under
π₁(Y). Thus W_Λ→Y is Galois with A=Λ^dual as abelian subgroup
and quotient C₂ acting by inversion. For any lift s of that quotient,

    sas⁻¹=a⁻¹,   s²∈A[2].                                (3)

For odd A, s²=1, proving the split generalized-dihedral assertion.
For even A it need not vanish: replacing s by as does NOT change
s² under inversion. No splitting is presumed.

Conversely an ACTUAL inversion cover gives U=W/A and a prime-to-five
anti-invariant character subgroup in K. Oddness places it in P by(1).
This proves coverage of exactly the stated geometric classes, not
realization of every abstract inversion group. The other target map
and actual intermediate sources need not be Galois.

## 4. Finite bad characters and the4/5/28 bounds

The [genus-two theta geometry, Section1](GENUS_TWO_DOUBLE_COVER_THETA_FIBERS.md)
proves, with its original characteristic5 checks retained, that

    D=Θ_U|P is nonzero of degree8.                         (4)

The principal polarization restricts to line degree2 on P; Raynaud's
class is4 times principal theta. Noncontainment follows because
J(U)/P is ordinary, via the checked ordinary-complement/Dirac
criterion. Proper theta on this ELLIPTIC direction is finite;
properness in higher dimension would not suffice.

For each α∈P, a local square cohomology matrix over the DVR of P
is generically invertible. Its determinant has valuation at least
its special-fiber corank, so

    h⁰(B_U⊗α)≤mult_α D.                                   (5)

Etale character decomposition gives the a-number identity

    a(W_Λ)=Σ_(α∈Λ)h⁰(B_U⊗α).                              (6)

This is NOT a stable-defect formula.

For ordinary P, its four nonzero geometric ker(V_P) points lie
in D but not in Γ, since they have order5. The Frobenius sequence
injects k into their B_U sections. Removing this compulsory degree
from8 and applying(5)–(6) gives a(W_Λ)≤4.
For supersingular P, the connected Verschiebung kernel of J equals
ker V_P of length5: J is prime-to-five isogenous to P×J(Y).
Tong's Dirac property on k[t]/(t⁵) makes D have EXACT multiplicity4
at0, while a(U)=1. Hence a(W_Λ)≤1+8−4=5.
These are the separately focused checked refinements; they retain
both reduced and nonreduced Verschiebung cases.

Under H4 all four components of K have proper theta divisors of
degree8 by(2) and translation invariance of degree. Apply(5) on
each component: the total budget is32. P is ordinary, so the same
four nonzero ker V_P points are excluded from Γ. Therefore
a(W_Λ)≤32−4=28. This even-component refinement remains author-only.

For ANY actual etale map W_Λ→T, etale functoriality injects
H⁰(B_T) into H⁰(B_W_Λ). Thus every target or target of an intermediate
has the stated a-number bound, regardless of ordinary factors.
Neither these budgets nor finiteness bounds the bad torsion orders.

## 5. One finite level, all targets, and the SAME-source quotient

In either case Θ_U(k)∩Γ is finite by Section4 or(2). Set

    Λ₀=⟨Θ_U(k)∩Γ⟩.

The [general finite-bad-character theorem](FINITE_RESTRICTED_THETA_CHARACTERS_FORCE_UNIFORM_ETALE_TARGET_DESCENT.md)
applies directly. It proves ordinary new Pryms by an invariant
Frobenius block decomposition, then exact actual target descent
using whole-Jacobian orthogonality. It does NOT replace the a-number
with g−f or assume the finite bad set itself is5-power invariant:
its generated group contains all5-power character orbits.

For Λ not containing Λ₀, use the actual W^+=W_(Λ+Λ₀).
If Z is an intermediate of W_Λ→Y and r:Z→T is etale, the pulled-up
map descends to W₀=W_Λ₀. INSIDE k(W^+) this gives

    k(D)=k(Y) r^*k(T) ⊂ k(Z)∩k(W₀), deg(D/Y)≤2|Λ₀|.       (7)

Normalization gives actual etale Z→D→Y and D→T, with r factoring
through D. Both are intermediate maps of the original etale legs;
neither Z nor W_Λ is assumed to contain W₀.

The same general theorem proves that each fixed hyperbolic W₀ has
finitely many hyperbolic etale quotients, by bounded outgoing degrees,
finite generation of proper π₁ and finite automorphism groups.
There are only15 choices of U. Their finite union proves the uniform
target statement, and their maximum in(7) bounds all actual quotients.
Every cofinal nested sequence eventually contains its Λ₀ and has
ordinary successive and composite Pryms.

## 6. A fixed-exponent existence proof for H4

For EACH fixed m prime to5 there is a smooth genus-two curve over k
whose maximal abelian exponent-m cover is ordinary. This is the
separately checked construction, not an infinite intersection claim.

Take ordinary elliptic E₁,E₂ and glue origins to C₀=E₁∪E₂.
For example y²=x³+x over F5 is smooth with nonzero Hasse coefficient2.
Set `A_i=E_i[m](k)`≅(Z/m)² and A=A₁×A₂. Take an E₁-copy for each
b∈A₂ and an E₂-copy for each a∈A₁, mapping by[m]. Glue point a
on copy b to point b on copy a. Translations and copy-label
translations give an A-action, and W₀→C₀ is a finite etale
A-torsor: at each node[m] is a completed-branch isomorphism, so
also an isomorphism of the completed nodal local rings.

The dual graph is connected K_(m²,m²), with b₁=m⁴−2m²+1 and
p_a(W₀)=2m²+b₁=m⁴+1. The normalization sequence is Frobenius-compatible:

    0→k^b₁→H¹(W₀,O)→⊕_(2m² elliptic components) H¹(E_i,O)→0.

Frobenius is bijective on both ends, hence in the middle. This is
coherent cohomology, not a claim about geometric p-torsion of a torus.

[Stacks Lemma93.17.6](https://stacks.math.columbia.edu/tag/0E7S)
smooths proper nodal C₀ projectively over k[[t]].
[Stacks Lemma58.9.1](https://stacks.math.columbia.edu/tag/0A48)
lifts W₀ uniquely as a finite etale cover of that proper family;
full faithfulness lifts the A-action and torsor identity. It applies
to nodal special fibers. Generic fibers are smooth and geometrically
connected: special h⁰=1 and semicontinuity give this after every
finite fraction-field extension. Constant arithmetic genus makes
H¹(O) locally free with base change. The Frobenius linearization
has determinant a unit at the special fiber, so the generic cover
is ordinary.

Its connected A-torsor has degree m⁴ and exponent m, exactly the
maximal exponent-m abelian quotient(Z/m)^4 of a genus-two π₁.
On a finite-type pointed genus-two moduli chart, add level structure
if necessary and pull[m] on the universal Jacobian back along the
Abel map. This gives the family of those maximal covers. Its ordinary
locus is open by the Hasse determinant; the constructed geometric
generic example makes it nonempty, hence it has a k-point.
Taking m=4 gives H4.

Only ONE fixed m and one finite-type open are used, not infinitely
many opens over the countable k. No specific equation or assertion
that every ordinary Y satisfies H4 follows. Raynaud's
[introduction/Rappel2](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/16AB72912D3CE32BFC5D012B1025A8E4/S0010437X00000440a.pdf/revetements-des-courbes-en-caracteristique-pandgt0-et-ordinarite.pdf)
attributes a stronger generic theorem to Nakajima; the proof here
does not rely on an uninspected proof of that stronger statement.

## 7. Remaining boundary

Finite-target descent excludes ordinary SIMPLE factors in J(T);
the4/5/28 a-number obstruction does not. Neither controls stable
defect or forces one particular factor to grow. Arbitrary solvable
groups, iterated nonabelian depth and five-primary characters are
not included. The [bounded-index packet result](96_NONABELIAN_PACKET_SCHUR_INDEX_DOMINATION_BOUND.md)
already treats the fixed genus9 target in overlapping cases; no new
fixed-pair exclusion is claimed. Both original etale legs remain
actual throughout, and the unmarked common-cover problem is unsolved.
