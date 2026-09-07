# Socle and p-refinement tests for restricted Raynaud theta

Origin-socle criterion and section-dimension gap: user-supplied GPT6Pro
argument, focused check PASS by /root/gluing_cohomology_rigidity2026-09-05.
That agent also checked/wrote the multipoint and projective-nilpotent
equivalence. There was NO independent audit of the whole original note.
Section6 retains the separate AUTHOR proof by /root/canonical_trace_algebra
and /root of2026-09-05. Consolidation2026-09-07 does not extend audit scope.

## 1. Setup and origin criterion

In Sections1–5 let k=bar(F_p) and q:W→C be an actual connected finite
etale Galois cover of smooth projective curves of genus≥2, with group G.
No restriction p∤|G| is imposed. Write q_1 for its Frobenius twist and

    B_C=coker(O_C^(1)→F_C*O_C),
    D(L)=H⁰(W^(1),B_W⊗q_1^*L),   L∈J(C^(1)),
    a(W)=dim D(O),   δ_q=dim D(L) generically.

Here a(W) is the Jacobian a-number. Neither δ_q nor a(W) is in general
the p-rank defect Δ(W)=g(W)−f_W.

If the SOCLE of D(O) has only one-dimensional simple constituents, then
D(L)=0 on a nonempty open subset. Thus q_1^*J(C^(1)) is not contained
in Θ_W. The hypothesis concerns simple SUBMODULES of this actual
section module, not all its composition factors or all simple kG-modules.

## 2. Modular-safe descent proves the criterion

For each simple kG-module S, etale torsor descent gives the bundle

    E_S=(q_1*O_W^(1)⊗S^∨)^G,   rank E_S=dim S,
    Hom_kG(S,D(L))=H⁰(C^(1),B_C⊗L⊗E_S).                    (1)

Indeed B_W=q_1^*B_C by the Cartesian etale Frobenius square.
Apply projection formula, tensor by S^∨, and take invariants.
Global sections commute with the invariants kernel, as does tensor
by the trivial-action locally free bundle B_C⊗L. No exactness of
arbitrary modular invariants, or averaging by |G|, is asserted.

For a character χ, E_χ is a torsion line of prime-to-p order. Its
nonvanishing locus in(1) is the inverse translate of the proper
Raynaud divisor Θ_C by E_χ. This uses
[Raynaud, Theorem4.1.1](https://www.numdam.org/article/BSMF_1982__110__103_0.pdf).
For each higher-dimensional simple S, the origin hypothesis makes
(1) zero at O, hence on a nonempty open by semicontinuity.
Intersect these finitely many opens with the character complements.
Irreducibility of the Jacobian makes the intersection nonempty.
There D(L) has no simple submodule and is therefore zero.

## 3. Translated, multipoint and dimension tests

The following are equivalent:

1. δ_q=0, or restricted theta is proper.
2. At SOME L_0, the socle of D(L_0) has only character simples.
3. For EACH simple S of dimension>1 there is an L_S, possibly depending
   on S, with Hom_kG(S,D(L_S))=0.

The first implies the others at a zero section space. The third implies
the first by the same finite intersection of semicontinuity opens.
More generally, generic higher-dimensional socle support is contained
in the intersection of the supports at any finite collection of test
points. No simultaneous test point need be guessed beforehand.

Put m_p(G)=min{dim S>1:S simple}, or infinity if there is no such S.
Characters are always absent from the generic socle, so

    δ_q=0   OR   m_p(G)≤δ_q≤a(W).                          (2)

The upper bound is semicontinuity at O. Thus a(W)<m_p(G) suffices;
translated section dimensions or surviving higher-dimensional supports
can sharpen the test. This says nothing about Δ(W), and introduces
no Frobenius endomorphism on an individual nontrivially twisted D(L).

## 4. Exact projective-nilpotent equivalence

Let V_W=H¹(W,O_W), with semilinear absolute Frobenius F, and
N_W=⋃_r ker F^r. The
[projective-defect theorem](PROJECTIVE_FROBENIUS_DEFECT_AND_NONGALOIS_QUOTIENT_TESTS.md)
gives N_W=⊕_S P(S)^(m_S), even when p divides |G|.
Then the origin hypothesis is EQUIVALENT to

    m_S=0 whenever dim S>1.                                (3)

The Raynaud sequence identifies D(O), up to scalar Frobenius twist,
with ker F; labels of simples may twist but dimensions are preserved.
Because ker F⊂N_W,

    soc(ker F)=soc(N_W)∩ker F.

Let U be the sum of higher-dimensional socle isotypes of N_W. On a
simple submodule F is either zero or injective with simple image
a Frobenius twist of the same dimension. Perfection of k makes that
image a k-subspace, so F(U)⊂U. If U≠0, nilpotence gives a nonzero
kernel on this semisimple higher-dimensional module, hence a
higher-dimensional simple in soc(ker F). The converse is immediate.
Finally kG is symmetric, so soc(P(S))≅S, proving(3).

It is N_W, NOT ker F, whose projectivity is used. Also P(χ) may have
higher-dimensional composition factors; (3) does not give a character
filtration of N_W.

## 5. Intermediates and the actual second leg

For H≤G, put Z=W/H and f:Z→C. Ordinary torsor descent gives

    H⁰(Z^(1),B_Z⊗f^(1)*L)=D(L)^H,                          (4)

without averaging by |H|. Thus properness on W implies it on every
actual intermediate Z. If g:Z→Y is another actual finite etale map,
the mixed locus for f^(1)*L⊗g^(1)*M is proper because its M=O axis is.
Both original maps remain; properness of that axis is only sufficient.

The [character-filtration criterion](RESTRICTED_RAYNAUD_THETA_SUFFICIENT_CONDITIONS_AND_STABILITY_BOUNDARY.md),
Section1, assumes all simple G-modules are characters. The present
test is weaker but does NOT supply that criterion's exact divisor
formula. Neither a second leg, joint minimality nor Hom-zero forces
the needed socle support. A small a(Z) does not bound a(W):
the actual pullback injection gives the opposite inequality a(Z)≤a(W).

## 6. P-refinements: support, multiplicity and normal-p reduction

The following author proof works over ANY algebraically closed field
of characteristic p, for smooth proper connected curves.
Let h:W'→W be actual finite etale Galois with p-group P, d=|P|.
For any vector bundle V on W,

    h⁰(W,V)≤h⁰(W',h^*V)≤d h⁰(W,V).                        (5)

The regular kP-module has d trivial composition factors, so h_*O_W'
has a vector-subbundle filtration with d quotients O_W. Tensoring by V
and the cohomology sequences give the upper bound; faithful flatness
gives the lower. Thus vanishing is equivalent, without χ(V)=0.
If χ(V)=0, acyclicity is equivalent too. Iterate for a sequence of
Galois p-refinements; a cover of merely p-power degree is NOT enough.

For a vector-bundle family V on W×S, S integral, with χ(V_s)=0,
the same filtration gives

    det Rπ'_*V' ≅ (det Rπ_*V)^d.

If the families are generically acyclic, use inverse determinant lines
for theta sections. Their sections multiply along the filtration, so

    θ_V'=θ_V^d up to a unit,   Θ_V'=d Θ_V.                  (6)

One can realize each theta section by a two-term equal-rank bundle
complex using a positive auxiliary divisor. If generic acyclicity
fails, both sections are identically zero: do NOT call this an effective
Cartier divisor or pull back a divisor containing the whole parameter space.

For Raynaud families V=B_W⊗N on W^(1), with arbitrary degree-zero
N parametrized by an abelian variety, χ(V_s)=0 and
h^(1)*B_W=B_W'. Hence bad-section supports agree, whether proper or
not; when proper their theta divisors differ by d. The parameter map
need not be injective or separable. This applies in particular to
N_(L,M)=f^(1)*L⊗g^(1)*M: actual source p-refinement preserves BOTH
legs and their mixed-theta properness, without minimality.
Section dimensions need not be equal.

Now let P be NORMAL in G for the original Galois cover q, and put
Wbar=W/P, Q=G/P. Descent gives

    D_W(L)^P=D_Wbar(L)
    Hom_kG(Inf S,D_W(L))=Hom_kQ(S,D_Wbar(L)).                (7)

Every simple kG-module is killed by P: its nonzero P-invariants form
a G-submodule. Thus inflation identifies all simples, and(7) identifies
their socles, including multiplicities. Every origin, translated and
multipoint test above is EXACTLY equivalent on this quotient.
In particular, in the setting of Sections1–5,

    a(Wbar)<m_p(Q)=m_p(G)

is sufficient; a(Wbar)≤1 suffices. Only character socle support is
needed, irrespective of dimensions contributed by characters.
The generic dimensions satisfy
δ_qbar≤δ_q≤|P|δ_qbar, not asserted equality; the same holds for a-numbers.
Their first-axis supports agree, and proper divisors differ by |P|.

This uses a SMALLER ACTUAL quotient for the sufficient test, then(4)
returns to the given intermediate Z and its original second map.
That second map need not descend to Wbar. Normal-p reduction therefore
does NOT replace the common source, identify arbitrary mixed twists
with descended twists, or justify replacing H by HP in a non-Galois
intermediate. Apply it only to a descended family, such as this axis.

## 7. Character-orbit and non-Galois strengthening

This section works over ANY algebraically closed field of characteristic p
for the same actual Galois-cover setup. These author arguments of /root
2026-09-05 retain the separate focused checks of character orbits and
direct products by /root/gluing_cohomology_rigidity. The non-Galois
refinements were NOT separately checked. This is not a new audit.

Let Xchar=Hom(G,k*) act on simples by tensoring; its finite characters
have prime-to-p order. For simple S put

    a_S=dim Hom_kG(S,D(O)),   ν_S=min_L dim Hom_kG(S,D(L)).

The descent identity(1) gives simultaneous minima on a nonempty open.
For the associated character line L_χ, with a consistent sign convention,

    D(L⊗L_χ)≅D(L)⊗χ.

Reversing all characters leaves the conclusions unchanged.
Translation in the parameter Jacobian therefore makes ν_S constant
on each character orbit O, with

    0≤ν_O≤min_(S∈O) a_S;   ν_S=0 for characters.             (8)

The second assertion is Raynaud's proper translated theta divisor.
Thus a SINGLE missing member of a nonlinear orbit in soc D(O)
removes the WHOLE orbit from the generic socle. If every nonlinear
orbit misses a member, generic D(L)=0.
This is a strictly weaker representation-theoretic hypothesis than
having no nonlinear simples at origin; no realized strict curve
example is claimed.

Let b_p(G)=min_(O nonlinear)|O|dim S_O, with empty minimum infinity.
If generic D(L)≠0, its socle contains every member of some nonlinear
orbit. Hence

    δ_q=0  OR  b_p(G)≤δ_q≤a(W).                            (9)

This concerns generic twisted section dimension, not the stable
defect g(W)−f_W.

For the actual intermediate Z=W/H let M_H=k[G/H] and I_H its
Jordan–Hölder support. Descent gives
H⁰(B_Z⊗f^(1)*L)=D(L)^H=Hom_kG(M_H,D(L)).
It suffices that every nonlinear orbit MEETING I_H miss a member in
soc D(O). Indeed(8) removes those simples generically, while characters
are always absent. The image of a nonzero M_H→D(L) would have a
simple submodule in I_H, a contradiction.
This argument is modular-safe: neither semisimplification of D(L)
nor exactness of arbitrary invariants is used.

Thus failure for this specified non-Galois cover forces a complete
nonlinear orbit in soc D(O) meeting I_H. In particular

    a(W)<b_p(G,H):=min_(O nonlinear,O∩I_H≠∅)|O|dim S_O

is sufficient for properness on Z. It is a bound on a(W), NOT a(Z).
Orbits invisible to the actual permutation module need not be excluded.

ONLY when p∤|G|, Maschke permits the exact generic formula

    w_H(O)=∑_(S∈O)dim S^H,
    δ_f=∑_(O nonlinear)ν_O w_H(O).

Consequently δ_f=0 or min_(w_H(O)>0)w_H(O)≤δ_f≤a(Z).
The lower bound can be1, so a(Z)≤1 does not imply vanishing.
This formula is not asserted for modular representations.

Finally suppose G=A×Q with A finite abelian and the ACTUAL quotient
W/A ordinary. Every simple has a central A-character by Schur;
its p-part is trivial and that character extends to G. Twisting its
inverse gives an A-trivial member in every character orbit. But
D(O)^A=H⁰((W/A)^(1),B_(W/A))=0 by descent and ordinarity. Each nonlinear orbit
therefore misses that member, proving generic D(L)=0 and properness
for every intermediate. Characteristic-divisible factors are allowed.
A general normal abelian subgroup cannot replace this direct factor
without proving the required character-extension property.

These tests retain the actual stabilizer H and can be combined with
Section3's separate translated points. A second etale leg or joint
minimality does not supply their hypotheses. Perfect groups have
no nontrivial character twists, so the orbit method adds nothing there.
No common-cover exclusion or cofinal-tower construction is asserted.
