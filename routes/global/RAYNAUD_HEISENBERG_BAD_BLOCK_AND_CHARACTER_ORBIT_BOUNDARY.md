# Raynaud's bad Heisenberg block and its character-orbit boundary

Author primary-proof comparison and representation arguments by
/root/canonical_trace_algebra2026-09-05; not independently audited.
This retains actual bad covers, not a common-cover exclusion.
It tests the [socle/character-orbit criterion, Section7](SOCLE_CRITERION_FOR_RESTRICTED_RAYNAUD_THETA.md).

## 1. Exact primary input

Raynaud, *Revêtements des courbes en caractéristique p>0 et ordinarité*,
[§3, Theorem17/Corollary18, pp.83–86](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/16AB72912D3CE32BFC5D012B1025A8E4/S0010437X00000440a.pdf/revetements-des-courbes-en-caracteristique-pandgt0-et-ordinarite.pdf),
with induction formalism in Proposition1(3)–(5), supplies the following.

For U of genus g≥2, let d be the degree on its Abel curve of a
principal polarization on J(U). If

    p∤n, n|d, δ=d/n≤(g−1)/(p−1),

there is an ACTUAL etale Heisenberg cover with an irreducible rank n^g
representation bad for Raynaud theta. The construction has sections
after every degree-δ line twist; Lemma16 supplies a degree-δ line
subsheaf of B_U, yielding nonvanishing after every degree-zero twist.
No ordinarity of U is required. The canonical polarization has d=g.

Call a representation bad when its associated bundle E satisfies
H⁰(U^(1),B_U⊗E⊗L)≠0 for EVERY L∈J(U^(1)); generic nonvanishing
is equivalent by semicontinuity. Fix the associated-bundle convention
to match E_S=(q_*O⊗S^∨)^G in the socle criterion. The representation
arguments below are author deductions, not further claims from Raynaud.

## 2. Unique faithful-central block and all faithful quotients

Let n>1 and 1→Z=C_n→H→A=(Z/n)^(2g)→1 have perfect commutator
pairing. Then Z=Z(H)=[H,H], and |H|=n^(2g+1) is prime to p.
For a faithful central character ζ, there is a UNIQUE irreducible
ρ_ζ, of rank r=n^g; it is faithful and monomial.

Indeed kH e_ζ is semisimple of dimension n^(2g) with center k:
conjugation multiplies each noncentral coset basis vector by a
nontrivial scalar ζ([x,h]) for some x. Hence it is M_r(k).
For a Lagrangian B⊂A of order n^g, its preimage I is abelian.
Extend ζ to a character λ of I; Ind_I^H λ has central character ζ
and rank r, so equals ρ_ζ. Finally any normal K with K∩Z=1 has
[K,H]⊂K∩Z=1, hence K⊂Z and K=1, proving faithfulness.

Every H-character kills Z, so uniqueness gives ρ_ζ⊗χ≅ρ_ζ.
Its FULL character orbit is a singleton: monomiality and many
characters do not let the orbit criterion remove this bad block.

For any subgroup K≤H, the following are equivalent:

    K core-free;   K∩Z=1;   ρ_ζ^K≠0.

Central K∩Z lies in the core, and the preceding normal-subgroup
argument gives the converse. Nontrivial K∩Z acts by a faithful
nontrivial scalar, forbidding invariants. When K∩Z=1, K is abelian
and isotropic in A. Conjugation by x∈H changes a K-weight by
k↦ζ([x,k]); perfection and character extension make these ALL
K-characters. Hence weight spaces have equal dimension, giving

    dim ρ_ζ^K=n^g/|K|>0,   |K|≤n^g,   [H:K]≥n^(g+1).       (1)

This is a weight-space proof, not dimension recovery from traces
only modulo p. Semisimplicity makes ρ_ζ occur in k[H/K] with this
multiplicity. Thus EVERY core-free actual quotient W/K→U has
improper restricted theta and generic section dimension≥n^g/|K|.
For non-core-free K this block is invisible; other blocks may remain.

For ODD n, Raynaud's symmetric construction realizes equality.
On the Lagrangian intermediate V=W/I the character line is
Lhat=Mhat|V⊗γ^*P^(-1), with Mhat^n=γ^*N and P^n=N|U.
Thus Lhat^n=O; its pullback to the A-cover has exact order n,
so it too has exact order n and faithful restriction to Z.
Then K=ker λ has order n^g, K∩Z=1, and the ACTUAL tower
W/K→W/I→U has degrees n,n^g. Its total degree is n^(g+1),
ρ_ζ occurs once, and it is non-Galois with Galois closure W→U.

Projection formula identifies the bad sections on this monomial
witness with B_V twisted by Lhat and pulled-back base lines.
The full translated theta on J(V^(1)) is proper, yet contains the
entire pulled-back J(U^(1)). Induction requires exclusion of THAT
containment, not just properness on the inducing curve.

## 3. Cyclic precovers and precise Clifford orbits

Take actual cyclic etale U→C of degree m, p∤m. The Galois closure
Wtilde→C has G, N=Gal(Wtilde/U), and G/N=C_m.
N surjects onto H but need NOT equal H: it is a subdirect product
of conjugate H-groups. The closure embeds in H wr C_m, so its
order remains prime to p and its group solvable.
Inflate ρ_ζ to irreducible ρ of N; R=Ind_N^Gρ is monomial.

Let J be its inertia subgroup, t=[J:N], d_0=[G:J]=m/t.
Then R has precisely t pairwise nonisomorphic irreducible constituents
σ_ψ, each of dimension d_0 n^g, indexed by characters ψ of J/N.
To prove this, extend ρ to J: an intertwiner for a lifted cyclic
generator has t-th power differing from ρ(x^t) by a scalar;
rescale using a t-th root. Then

    Ind_N^Jρ=ρtilde⊗k[J/N]=⊕_ψ ρtilde⊗ψ.

Induction to G is irreducible and pairwise distinct by Mackey:
outside J conjugates of ρ differ; inside it the quotient characters
distinguish extensions. Characters of cyclic G/N restrict
surjectively to J/N, so the t constituents form ONE complete orbit
under CYCLIC-QUOTIENT characters.

The associated bundle of R is the pushforward of the bad bundle
on U. Etale functoriality/projection formula makes R bad on C.
At least one σ_ψ is bad, or their finitely many generic-vanishing
opens would intersect. Character twists translate the parameter
Jacobian and preserve badness; transitivity makes ALL t bad.
Their full G-character orbit is likewise bad, but may be larger.

No individual σ_ψ is asserted monomial, and no equality between
this cyclic-quotient orbit and the full deck-character orbit is
assumed. Controlling restrictions of ALL G-characters to N would
be needed for the latter; no larger-orbit example is claimed.

For the odd-n witness K of Section2, let Ktilde be its inverse
image under N→H. Then Wtilde/Ktilde=W/K is actual etale over C,
of degree m n^(g+1), and

    k[G/Ktilde]=Ind_N^G Inf_H^N k[H/K] contains R

as a direct summand. Thus every displayed bad constituent occurs
in this actual permutation quotient; the non-Galois orbit test
cannot discard them as invisible.

## 4. Concrete scale over an ordinary genus-two base

Let C be ANY ordinary genus-two curve over bar(F5). Direct Raynaud
construction on C is impossible for every principal polarization:
d/n is a positive integer but(g−1)/(p−1)=1/4.
After an actual cyclic degree-six precover, use

    m=6, g(U)=7, n=d=7, δ=1≤6/4.

Such a connected precover exists via prime-to-five torsion of J(C);
it need not be ordinary. This gives rank7^7=823543 at the Heisenberg
stage, induced rank4941258 on C, and non-Galois cover degree34588806.
These are construction-specific, NOT minimality bounds for all bad
representations. The prime support is{2,3,7}; the previous uniform
choice m=8,g(U)=n=d=9 instead retains support{2,3}.
For noncanonical polarizations the requirement is n|d, not n|g(U).

The actual obstruction to a monomial strategy is restricted theta
on its ACTUAL inducing curve, not monomiality or a count of character
twists. This supplies neither a second target, a jointly minimal
two-leg counterexample, generic-stability-to-theta implication,
nor a common-cover exclusion.
