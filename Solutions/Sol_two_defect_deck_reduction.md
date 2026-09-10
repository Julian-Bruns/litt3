# Proof: two-section deck groups and actual defect carriers

[Statement](../Theorems/Thm_two_defect_deck_reduction.md).
2026-09-10. Sections1--5 and their stated application passed a focused
medium audit /root/audit_two_defect_monodromy. The additional Section6
also passed a separate scoped check by the same auditor. This is a
structural reduction of actual covers, not a common-cover exclusion.
The ready Pro request remains the separate higher-Witt descent task.

## Statement

Let k=bar(F5), let q:Z→Y be an ACTUAL connected finite etale Galois
cover of smooth projective connected curves of genus at least two,
with group G, and let E on Y have a perfect omega_Y-valued
alternating form. Suppose

    H0(Y,E)=0,  U=H0(Z,q*E),  dim U=2.

Write rho:G→GL(U), Gamma=rho(G). Assume some five-element acts
nontrivially on U, equivalently 5 divides |Gamma|. Then:

1. The Sylow5 subgroups of G are cyclic, of order5^a for some a>=1.
2. Up to a basis change, Gamma is one of C10, D10, C2×D10, where
   D10 denotes the dihedral group of ORDER10. In particular |Gamma|<=20.
3. There is a normal subgroup K of G, of order prime to5, acting
   trivially on U, such that

       G/K ≅ C_(2*5^a), D_(2*5^a), or C2×D_(2*5^a),

   respectively. Here D_(2*5^a) has ORDER2*5^a.
4. The actual intermediate T_a=Z/K has the same two sections. Its
   quotient Y'=T_a/P by the normal cyclic Sylow subgroup is an
   elementary abelian2 cover of Y of degree2 or4 and has ONE section.
   The character of that section gives a degree-two intermediate
   C→Y with one section; Y'→C has degree1 or2 and adds no section.

For the actual indigenous tangent bundle E=E_r, these are defect
statements because it has the required canonical-valued alternating
form. The prime-to5 map Z→T_a preserves defect and therefore descends
every already compatible Witt tower by the audited descent theorem.
If g(Y)=2, g(Y') is3 or5 and g(T_a) is2*5^a+1 or4*5^a+1.

The remaining cyclic exponent a is UNBOUNDED. When a=1 the carrier
has genus11 or21. The C10 case is exactly a bad double followed by
a degree-five cover pulled from Y, as in the ready Pro prompt. The
dihedral cases allow anti-invariant Artin--Schreier directions and
are not silently included in that prompt.

## 1. The actual Sylow subgroup is cyclic

Let P be a Sylow5 subgroup with nontrivial image. On the two-dimensional
U its fixed space has dimension one: a five-group has invariants, and
two invariants would make its action trivial. Galois descent gives

    h0(Z/P,E_(Z/P))=dim U^P=1.

The first-socle-layer theorem in
[symplectic defect growth, Section2](../Solutions/Sol_symplectic_p_cover_section_growth.md)
gives 2>=1+d(P), where d(P)=dim_F5 Hom(P,F5). Thus d(P)=1, and P is
cyclic by the Burnside basis theorem. Its nontrivial two-dimensional
unipotent image has order exactly5. In particular the projective image
also has Sylow order5.

## 2. A normalizer character must be quadratic

Put N=N_G(P). The original cover Z/P→Z/N is etale Galois with group
N/P of order prime to5. Its one-dimensional section space U^P has a
character chi. The corresponding character line L on Z/N satisfies
h0(E_(Z/N) tensor L)=1. Canonical-valued self-duality and Riemann--Roch
give the SAME dimension for L^-1. Both spaces pull back to the same
one-dimensional space on Z/P. Therefore chi=chi^-1.

This also covers the trivial character; no ordinariness assertion on
Z/N is needed. Thus EVERY normalizer element acts on U^P by +1 or-1.

Normalizer images are not lost in passing to Gamma. The map

    N_G(P)→N_Gamma(rho(P))

is surjective. Indeed, in the preimage of the latter normalizer,
rho^-1(rho(P)) is normal and contains P as a Sylow subgroup. Frattini's
argument gives the whole preimage as rho^-1(rho(P))*N_G(P); its first
factor has image rho(P), already in the normalizer image.

Consequently the Sylow-normalizer character on its unique fixed line
inside the FAITHFUL Gamma-module U also has order at most two.

## 3. Self-duality rules out the irreducible five-monodromy case

For every prime-to5 cyclic subgroup H of G, decompose the pushforward
of O_Z for Z→Z/H into character lines. Duality and chi(E tensor L)=0
show that each character and its inverse have equal multiplicity in
U|_H. Hence the Brauer characters of U and U^dual agree. Their
semisimplifications are isomorphic. This uses only actual etale
character-line descent, not a presumed k-valued symplectic form on U.

If U were irreducible, it would be self-dual. Its invariant nondegenerate
bilinear form is symmetric or alternating by Schur's lemma and 2!=0.
In the symmetric case Gamma lies in O2(k), whose identity component is
k* and component group is C2. Such a finite group has no five-torsion.
Thus the alternating case is forced: Gamma lies in SL2(k).

Use [Faber, TheoremB and Remark2.3](https://arxiv.org/pdf/1112.1999).
In characteristic5, a finite p-irregular projective subgroup with
Sylow order5 and without a fixed point is conjugate to PSL2(F5) or
PGL2(F5). The semi-elementary alternative has a fixed point and would
make U reducible. The characteristic5 A5 case is PSL2(F5).

Both remaining projective groups contain the standard PSL2(F5).
The preimage of that subgroup inside Gamma⊂SL2(k) is the full SL2(F5).
To see why the central involution cannot be missing, SL2(k) has only
one nonidentity involution, -I, whereas A5 has many; a subgroup mapping
isomorphically to A5 is impossible. A subgroup surjecting onto A5
and containing -I is the full order120 preimage.

After arranging its Sylow subgroup as upper unitriangular matrices,
this preimage contains diag(2,3). That element normalizes the Sylow
subgroup and acts on its fixed line with order FOUR. Section2 excludes
it. Therefore U is reducible.

## 4. The three faithful images

The unique P-fixed line L is now Gamma-stable: any invariant line
must be fixed by the nontrivial unipotent P. Write its character chi
and the quotient character psi. The Sylow image is normal in the
triangular group, so the normalizer-surjectivity argument in Section2
shows chi²=1 on ALL Gamma. Reciprocity of the semisimplified characters
then gives psi²=1 as well.

The unipotent subgroup has order5. A prime-to5 complement can be
diagonalized, so Gamma is conjugate to a subgroup generated by

    J=[[1,1],[0,1]] and a subgroup D of {diag(e1,e2): e_i=+/-1}.

The character e1 is nontrivial on D because U^Gamma=H0(Y,E)=0.
There are just three such diagonal subgroups:

    D=<-I>, D=<diag(-1,1)>, D={diag(+/-1,+/-1)}.

They give C10, D10, and C2×D10 respectively. Notice that the second
representation is NONsplit: its invariant line has the nontrivial
quadratic character and its quotient is trivial. It must not be
discarded just because the semisimplification has a trivial factor.

## 5. Remove a normal prime-to-five subgroup of the ACTUAL G

Let G0=rho^-1(<J>), normal in G with quotient D of order2 or4.
Its Sylow subgroup P is still cyclic. Every n in N_(G0)(P) acts
trivially on rho(P), because rho(G0)=<J> is abelian. Its conjugation
automorphism on P=C_(5^a) is therefore congruent to1 modulo5.
But N_(G0)(P)/C_(G0)(P) has order prime to5: P is abelian and is a
Sylow subgroup of the normalizer. The kernel of Aut(C_(5^a))→Aut(C5)
is a five-group. Thus this conjugation automorphism is trivial.

We have P⊂Z(N_(G0)(P)). The
[Burnside normal-complement theorem, Theorem1.11](https://web.mat.bham.ac.uk/D.A.Craven/docs/lectures/finitegroups2010.pdf)
supplies the unique normal prime-to5 complement K in G0. It is
characteristic in G0, hence normal in G. Since rho(G0) is a five-group,
rho(K)=1. The quotient G/K has normal P and quotient D. Schur--Zassenhaus
(same source, Theorem2.1) splits it; the conjugation action on P is
the unique order-two or trivial lift of e1/e2 in Aut(C5). This proves
the three group shapes in the statement, with no order bound on K.

All intermediate curves are actual quotients of Z by freely acting
subgroups, hence all their maps are everywhere etale. K acts trivially
on U, so the intermediate T_a has exactly the same two sections.
The normal P-fixed section space has dimension one and its diagonal
character is e1. Its kernel in D gives C of degree two over Y, with
one section. The remaining Y'→C has degree at most two and preserves
that section space. Hurwitz gives the displayed genera.

## 6. The complementary branch: five-torsion acts trivially

This extension has a separate PASS in the same audit record.

In fact EVERY Sylow5 subgroup P of an actual source with two sections
is cyclic, even if its action on U is trivial. In the latter case the
quotient S=Z/P has two sections. Apply the first-socle-layer bundle

    0→O_S→F_P→O_S^d(P)→0

to E_S. Its connecting map has domain dimension2d(P) and target
dimension2. Thus h0(E_S tensor F_P)>=2d(P). Pullback has only two
sections, so d(P)<=1. A nontrivial P is cyclic. The nontrivial-action
case was already proved in Section1.

Now suppose rho(P)=1. Put H=ker rho, so H contains P and Gamma=G/H
has order prime to5. Let S=Z/P and let alpha in H1(S,O_S) be the
Artin--Schreier class of the UNIQUE degree-five intermediate in the
cyclic5^a cover Z→S. There are no new sections even on that first
cover. Its first-socle-layer sequence consequently makes

    alpha cup - : H0(S,E_S)→H1(S,E_S)

an isomorphism. Under canonical-valued duality this is a NONZERO
alternating form B_alpha on the two-dimensional space U.

For n in N_G(P), let c in F5* be its conjugation exponent on P/5P.
Transport of the AS torsor gives n(alpha)=c^-1 alpha (switching both
action conventions reverses both occurrences). Naturality of the
Serre trace gives

    B_(n alpha)(ns,nt)=B_alpha(s,t).

Since B_alpha is alternating and nonzero, this says

    det(rho(n))=c.                                      (6.1)

The character reciprocity in Section3 implies det(rho(n))²=1, so
c=+/-1. In particular n in N_H(P) has c=1. As in Section5, the
prime-to5 normalizer action on the cyclic P cannot have a nontrivial
lift congruent to1 modulo5. Therefore P⊂Z(N_H(P)).

Burnside's theorem supplies the unique normal prime-to5 complement
K of H. It is characteristic in H and hence normal in G. We have
K⊂ker rho, so Z→Z/K preserves both sections and has prime-to5 degree.
Writing P also for H/K, the resulting group is

    G/K ≅ P ⋊ Gamma,   P=C_(5^a),

where Gamma has order prime to5 and acts on P by its determinant
character, interpreted as +1 or inversion. Indeed Frattini's argument
makes N_G(P)→Gamma surjective, (6.1) determines the action modulo5,
and the prime-to5 part of Aut(C_(5^a)) lifts it uniquely. The extension
splits by Schur--Zassenhaus. The case P=1 simply takes K=ker rho.

Here Gamma acts faithfully and semisimply on U, has U^Gamma=0, and
its representation is self-dual. No bound on |Gamma| follows: reciprocal
characters and dihedral representations still allow arbitrarily large
orders. This is why the result does not yet give a bounded-genus
carrier in the complementary branch.

Combining both branches: up to a normal prime-to5 cover preserving
the two defect directions, arbitrary actual Galois covers with source
defect two have a CYCLIC Sylow5 subgroup. If that subgroup acts
nontrivially, only the three tower types in the statement remain. If
it acts trivially, the residual prime-to5 group is exactly a faithful
self-dual two-dimensional representation group, with determinant
controlling its action on the cyclic five-part. This is a reduction
of actual monodromy, not just of a representation chosen after the fact.

## Scope for Litt3 and remaining work

For the selected ordinary (Y_t,r_t), C is necessarily one of the ten
known bad doubles. If a common source has an ordinary opposite
connection, its full canonical X-source descends through Z→T_a by
the existing prime-to5 theorem. It does NOT yet descend through the
remaining cyclic5^a tower. Neither the Y-leg nor a simultaneous Galois
closure is invented. The original source and both maps are retained.

This reduces arbitrary finite groups in BOTH two-defect branches.
When five-torsion acts nontrivially, the remaining groups have one of
three cyclic/dihedral tower shapes. When it acts trivially, Section6
leaves a possibly unbounded prime-to5 two-dimensional image. Neither
case bounds the remaining cyclic exponent or descends through it.
The application does not cover a nonordinary opposite endpoint or a
non-Galois Y-leg. Those distinctions are needed before invoking a
bounded-genus partner count.

The spin-neutral group theorem already proves a different normal-
complement statement when NO spin sections are added. It does not
imply this result: here the actual omega-symplectic tangent bundle
goes from zero sections to two, and the quadratic/normalizer character
is essential to excluding irreducible five-monodromy.
