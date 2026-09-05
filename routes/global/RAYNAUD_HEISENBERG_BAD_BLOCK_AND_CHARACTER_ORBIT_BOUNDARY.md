# Raynaud's bad Heisenberg block: monomiality, character orbits, and faithful quotients

Date: 2026-09-05. Author: `/root/canonical_trace_algebra`.
Status: primary-proof comparison and author proofs of the representation
lemmas below; not independently audited. No novelty claim.

This directly tests the
[character-orbit and non-Galois criterion](CHARACTER_ORBITS_AND_NONGALOIS_RESTRICTED_THETA_TESTS.md).
The bad block is monomial, has a singleton character orbit at the
Heisenberg stage, and occurs in every faithful permutation quotient
there. After a cyclic precover, all constituents of the induced witness
are bad. They form one complete orbit under **cyclic-quotient characters**
and lie in a single full deck-character orbit. Equality of those two
orbits is not needed or asserted here.

## 1. Primary input and its exact scope

Michel Raynaud, *Revêtements des courbes en caractéristique p>0 et
ordinarité*, Compositio Math. 123 (2000), 73--88:

- [Accessible primary PDF](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/16AB72912D3CE32BFC5D012B1025A8E4/S0010437X00000440a.pdf/revetements-des-courbes-en-caracteristique-pandgt0-et-ordinarite.pdf).
- [DOI landing page](https://doi.org/10.1023/A:1001840726893).

The checked passage is Section 3, printed pp. 83--86, PDF pages 11--14:
the construction on pp. 83--84, Lemma 16/Theorem 17/Corollary 18 on
p. 85, and cyclic induction on pp. 85--86. Proposition 1(3)--(5),
printed pp. 74--75, supplies the associated-bundle induction formalism.

Let U have genus g>=2 over an algebraically closed field of
characteristic p. A principal polarization on J(U), of degree d on the
Abel curve, and an integer n satisfying

\[
 p\nmid n,\qquad n\mid d,\qquad
             \delta=d/n\le(g-1)/(p-1)                       \tag{1.1}
\]

give, by Theorem 17, an actual etale Heisenberg cover and an irreducible
finite representation of rank n^g without theta. The construction
produces a bundle E having sections after every degree-delta line
twist. Lemma 16 supplies a degree-delta line subsheaf of B_U; tensoring
its inclusion by E and any degree-zero line proves nonvanishing for
every such twist. Corollary 18 uses the canonical polarization, d=g.

This input imposes no ordinarity hypothesis on U. The arguments below
are representation-theoretic deductions, with the actual covers kept
throughout, not additional claims extracted from Raynaud's theorem.

We call a finite representation **bad** if its associated bundle E
satisfies

\[
 H^0(U^{(1)},B_U\otimes E\otimes L)\ne0
                       \quad\hbox{for every }L\in J(U^{(1)}).
                                                               \tag{1.2}
\]

Generic nonvanishing is equivalent to (1.2) by upper semicontinuity.
Representation labels may be dualized to match the convention
E_S=(q_*O tensor S^vee)^G in the linked criterion. Dualizing preserves
all ranks, monomiality, selftwists, and fixed-vector dimensions used
below. We use that convention when referring to a block in the section
module D(L).

## 2. The faithful-central Heisenberg representation

Assume n>1, and consider a finite group extension

\[
 1\longrightarrow Z\simeq C_n\longrightarrow H
      \longrightarrow A\simeq(\mathbf Z/n)^{2g}
      \longrightarrow1,                                   \tag{2.1}
\]

whose commutator pairing A x A -> Z is perfect. Thus Z is both the
center and the commutator subgroup. The group has order n^(2g+1),
prime to p. The representation in Section 1 has a faithful character
zeta:Z -> k^* on its center.

### Lemma 2.1: uniqueness, rank, and monomiality

There is exactly one irreducible rho_zeta with central character zeta.
It has rank r=n^g, is faithful, and is induced from a character of an
abelian subgroup of index r.

**Proof.** Let e_zeta be the central idempotent for zeta. The algebra
kH e_zeta is semisimple and has dimension |A|=n^(2g). Its center is k:
for any noncentral h, perfection supplies x with zeta([x,h])!=1, and
conjugation by x multiplies h e_zeta by that nontrivial scalar.
In the basis indexed by A this excludes every nonidentity coset from
a central element. Thus kH e_zeta is the matrix algebra M_(n^g)(k).
This proves uniqueness and rank.

Let B<=A be a Lagrangian of order n^g, and I its inverse image in H.
Then I is abelian and |I|=n^(g+1). The character zeta extends to a
character lambda of I: characters of finite abelian subgroups extend
to the ambient finite abelian group over an algebraically closed field
of characteristic prime to its order. The induction Ind_I^H lambda
has central character zeta and rank n^g, so uniqueness and semisimplicity
show that it is exactly rho_zeta.

Finally ker(rho_zeta) meets Z trivially. A normal subgroup K of H
with K cap Z=1 has [K,H]<=K cap Z=1, hence K<=Z and K=1. Thus the
representation is faithful. \(\square\)

### Lemma 2.2: the full character orbit is a singleton

For every character chi:H -> k^*,

\[
                         \rho_\zeta\otimes\chi\simeq\rho_\zeta.
                                                               \tag{2.2}
\]

**Proof.** Every character kills [H,H]=Z. The twist has the same
faithful central character, and Lemma 2.1 gives uniqueness.
\(\square\)

Thus the new character-orbit criterion cannot remove this block by
finding a different member of its orbit: there is no different member.
This is a statement about the actual bad irreducible, not an assertion
that all irreducibles of an arbitrary solvable group behave this way.

## 3. Every faithful non-Galois quotient sees this block

### Theorem 3.1

For a subgroup K<=H, the following are equivalent:

1. K is core-free in H.
2. K cap Z=1.
3. rho_zeta^K is nonzero.

When these conditions hold,

\[
             \dim \rho_\zeta^K=\frac{n^g}{|K|},\qquad
             [H:K]\ge n^{g+1}.                              \tag{3.1}
\]

**Proof.** The central subgroup K cap Z is contained in the core of K,
so 1 implies 2. Conversely apply the normal-subgroup argument in
Lemma 2.1 to core_H(K). If K cap Z is nontrivial, its faithful scalar
action makes rho_zeta^K zero, so 3 implies 2.

Suppose now K cap Z=1. Its commutators vanish, so K is abelian and
embeds as an isotropic subgroup of A. Decompose rho_zeta into K-weight
spaces. For x in H, conjugation by rho_zeta(x) changes the weight by
the character

\[
                         k\longmapsto\zeta([x,k]).
\]

These characters exhaust Hom(K,k^*): extend any character of K to A
and use the perfect pairing on A. Hence conjugation permutes all
K-weight spaces transitively. Their dimensions are equal, giving
dim rho_zeta^K=r/|K|>0. This proves 2 implies 3 and the first formula.
An isotropic subgroup of the perfect finite pairing satisfies
|K|^2<=|A|, so |K|<=n^g, proving the degree bound.

This argument uses weight spaces, not an equality of numerical
dimensions deduced only modulo p from traces. \(\square\)

Let W -> U now be the actual cover of Section 1. For every core-free K,
the actual curve W/K -> U has improper restricted theta. Indeed its
permutation module k[H/K] contains rho_zeta with multiplicity
dim rho_zeta^K; equivalently, the generic section module's bad block
has nonzero K-invariants. Since p does not divide |H|, this is ordinary
semisimple multiplicity and torsor descent of sections. In particular
the generic section dimension on W/K is at least n^g/|K|.

For a non-core-free subgroup, the particular faithful-central block
is invisible. We make no conclusion from that fact about its other
blocks or restricted theta.

### An actual quotient attaining the degree bound in the odd-n construction

For odd n, the symmetric choice in Raynaud's construction yields an
order-n character lambda on the Lagrangian intermediate V=W/I. In
his notation the corresponding line is

\[
 \widehat L=\widehat M|_V\otimes\gamma^*P^{-1}.
\]

The identities Mhat^n=gamma^*N and P^n=N|_U give Lhat^n=O. Its
pullback to the A-cover has exact order n, so Lhat itself has exact
order n. This also identifies its faithful restriction to Z.

Consequently K=ker(lambda:I -> mu_n) has order n^g and meets Z trivially.
The actual cover

\[
             W/K\longrightarrow W/I\longrightarrow U
\]

has successive degrees n and n^g. Its first map is cyclic etale; its
total degree is n^(g+1), and rho_zeta occurs once in k[H/K]. The cover
W/K -> U is non-Galois: its nontrivial core-free subgroup K cannot be
normal. Its Galois closure is precisely W -> U.

Thus monomiality is a genuine geometric failure mechanism. Projection
formula identifies its bad sections with those of B_V twisted by
Lhat and pulled-back degree-zero lines from U. The translated theta
on the full J(V^(1)) is proper, but contains the whole pulled-back
J(U^(1)). Induction does not preserve proper theta without excluding
exactly that containment.

## 4. Cyclic precovers: all induced constituents are bad

Let U -> C be an actual connected cyclic etale cover of degree m,
with p not dividing m. Start with the actual H-cover W -> U above.
Take its actual Galois closure Wtilde -> C, with group G, and let
N=Gal(Wtilde/U). Then G/N=C_m. The map N -> H attached to W is
surjective; inflate rho_zeta to an irreducible N-module rho.

One must not assume N=H. It is a subdirect product of the conjugate
H-groups. Taking this closure keeps its order prime to p, and produces
a solvable group; for instance its construction embeds it in the
appropriate wreath product H wr C_m.

Set R=Ind_N^G rho. Transitivity of induction makes R monomial, because
rho_zeta was induced from a character. Let J be the inertia subgroup
of the irreducible N-module rho in G, and put

\[
                 t=[J:N],\qquad d_0=[G:J]=m/t.
\]

### Theorem 4.1: precise Clifford decomposition

There are exactly t pairwise nonisomorphic irreducibles sigma_psi with

\[
 R=\bigoplus_{\psi\in\widehat{J/N}}\sigma_\psi,
 \qquad \dim\sigma_\psi=d_0 n^g.                            \tag{4.1}
\]

They form a single complete orbit under the characters inflated from
G/N=C_m. Every sigma_psi is bad on C. They lie in a single full
G-character orbit, every member of which is also bad.

**Proof.** The invariant irreducible rho extends to J because J/N is
cyclic and k is algebraically closed. Explicitly, choose an intertwiner
for a lift x of a generator of J/N. Its t-th power differs from
rho(x^t) by a scalar, by Schur's lemma. Rescale the intertwiner using
a t-th root of that scalar to obtain an extension rho_tilde.

Then

\[
 \operatorname{Ind}_N^J\rho
       =\widetilde\rho\otimes k[J/N]
       =\bigoplus_{\psi\in\widehat{J/N}}\widetilde\rho\otimes\psi.
\]

Inducing to G gives (4.1). Mackey's formula shows that these induced
representations are irreducible and pairwise nonisomorphic: outside
J the underlying conjugates of rho are inequivalent; inside J the
distinct extensions have distinct quotient characters. All dimensions
are [G:J] dim rho. Restriction of characters from the cyclic group
G/N onto its subgroup J/N is surjective, so these quotient-character
twists act transitively on precisely the t displayed constituents.

The associated bundle of R is the finite pushforward of that of rho
along U -> C. Since rho is bad for every degree-zero twist on U,
projection formula and etale functoriality of B show that R is bad
on C. At least one constituent sigma_psi is bad: otherwise intersect
their finitely many nonempty generic-vanishing opens. Twisting by a
finite character corresponds to translation of J(C^(1)) by a torsion
line bundle, and therefore preserves badness. Transitivity makes
every displayed constituent bad. The same translation argument
applies to the full character group of G. \(\square\)

We do not assert that the individual sigma_psi are monomial, nor that
the displayed constituents exhaust their full G-character orbit.
Proving the latter equality would require controlling restrictions
of all G-characters to N, beyond the inflated cyclic characters used
in the proof. No actual larger-orbit example is asserted here.

The explicit cover W/K of Section 3, viewed over C, has degree
m n^(g+1) and remains actual and etale. Let Ktilde be the inverse image
of K under N -> H. Then Wtilde/Ktilde=W/K, and its permutation module is

\[
 k[G/\widetilde K]
    =\operatorname{Ind}_N^G\operatorname{Inf}_H^N k[H/K]
    \ \supset\ \operatorname{Ind}_N^G\rho=R.                \tag{4.2}
\]

Here inclusion means a direct summand, since the group order is prime
to p. Hence all t constituents in (4.1) occur in its permutation module,
each with multiplicity at least one. The non-Galois character-orbit
criterion therefore does not remove this witness by discarding
invisible constituents.

## 5. An ordinary genus-two base in characteristic five

Let C be any ordinary genus-two curve over Fbar_5. Direct application
of Theorem 17 on C is impossible for **every** principal polarization:
d/n is a positive integer, while (g(C)-1)/(p-1)=1/4.

A concrete canonical-polarization example after a precover is

\[
          m=6,\qquad g(U)=1+m=7,\qquad n=7,\qquad d=7.
\]

The numerical condition is 1<=6/4. A connected cyclic degree-six
etale cover exists by prime-to-five torsion in J(C). No assumption on
the ordinarity of that chosen precover is needed. The resulting
construction has

| Quantity | Value |
| --- | ---: |
| Heisenberg irreducible rank | 7^7 = 823543 |
| Induced monomial witness rank over C | 6 times 7^7 = 4941258 |
| Explicit non-Galois cover degree over C | 6 times 7^8 = 34588806 |

These are construction-specific values, not a lower bound for all
bad finite representations on C. This example uses prime support
{2,3,7}. Raynaud's convenient uniform choice m=8, g(U)=9, n=9 instead
retains the previously recorded support {2,3}; nothing in the earlier
fixed-support notes is being replaced.

For noncanonical principal polarizations on an auxiliary U, the
condition is n|d, not n|g(U). They can permit other values of n; no
classification or minimum over such polarizations is asserted here.

## 6. Exact limit of the new criteria

At the Heisenberg stage the bad nonlinear character orbit is already
a singleton. Every core-free quotient sees it. At the genus-two stage
the displayed Clifford constituents fill their cyclic-quotient
character orbit, all are bad, and the explicit permutation quotient
contains them. Their full character orbit is likewise bad, whether
or not all its members occur in that particular induced witness.

Thus neither monomiality nor the existence of many characters forces
generic vanishing. The additional input needed for a monomial approach
is control of translated theta on the **actual inducing curve** along
the pulled-back base Jacobian. Merely knowing that its full theta is
proper is insufficient. No generic-stability-to-theta implication,
second target, minimal two-leg counterexample, or common-cover
exclusion is supplied by this construction.
