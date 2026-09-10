# Focused audit: two-defect five-monodromy

Verdict: PASS, in the smooth projective curve setting of the workspace.
Auditor: /root/audit_two_defect_monodromy.
Date: 2026-09-10.
Target: Solutions/Sol_two_defect_deck_reduction.md, Sections1--5 and stated
actual-intermediate consequences. This is a prose audit, not Lean
verification. No new computation, exploration, or subagents were used.

The first-socle growth bound and supplied canonical-valued symplectic
bundle facts are inputs, not freshly audited results. The existing
defect-preserving Witt descent theorem is also an input; this audit
checks that the proposed intermediate map satisfies its degree and
defect hypotheses, not its proof again.

## Checked argument

For a Sylow5 subgroup P of the actual G, its nontrivial two-dimensional
image has one invariant. Descent therefore gives one section on Z/P.
The supplied first-socle bound yields d(P)<=1, hence actual cyclicity
by the Burnside basis theorem. This correctly restricts G itself,
not merely its image. The image is C5 because a nonidentity unipotent
matrix of dimension two in characteristic five has order five.

The quadratic normalizer character argument is valid even when N/P
is nonabelian. Its particular one-dimensional character defines an
associated torsion line bundle on Z/N. For any degree-zero torsion
line L, canonical-valued self-duality gives
h1(E tensor L)=h0(E tensor L^-1), while Riemann--Roch gives Euler
characteristic zero. Distinct inverse characters would thus supply
two independent sections upstairs, contrary to the one-dimensional
invariant space. There is no assumption of ordinary Z/N here.

Normalizer surjectivity is valid. In H=rho^-1(N_Gamma(rho(P))),
the subgroup M=rho^-1(rho(P)) is normal and P is a Sylow subgroup of
M. Frattini gives H=M N_G(P). Since rho(M)=rho(P), the normalizer
image is the entire desired normalizer. A representation kernel
containing five-torsion does not invalidate this argument.

For each five-regular element of G, restriction to its cyclic group
splits into torsion-character line bundles on the actual quotient
curve. The same duality/Riemann--Roch equality matches inverse
eigencharacters, with their integer multiplicities. It therefore gives
equality of Brauer characters, not merely equality of traces in k.
The usual independence of irreducible Brauer characters identifies
the semisimplifications. If U is irreducible, this gives an actual
self-duality. Schur's lemma in odd characteristic makes its unique
bilinear form symmetric or alternating. A finite subgroup of O2(k)
has no five-torsion; the alternating alternative lies in SL2(k).

The cited Faber classification has precisely the needed scope: in
characteristic five, Sylow order five reduces the projective groups
without a common fixed point to PSL2(F5) or PGL2(F5). The characteristic
five A5 case is the former. Their standard PSL2(F5) subgroup has full
SL2(F5) preimage inside the proposed Gamma: otherwise a copy of A5
would embed in SL2(k), impossible because the latter has just one
nonidentity involution. After conjugacy, diag(2,3) normalizes the
chosen upper-unipotent C5 and has fixed-line eigenvalue of order four.
Since that C5 is also Sylow in Gamma, this contradicts the proved
normalizer-character restriction. Reducibility follows.

In the triangular case the unipotent kernel is the normal Sylow C5.
Normalizer surjectivity makes the invariant-line character quadratic
on all Gamma. Reciprocal semisimplification then makes the other
character quadratic. A prime-to-five complement is diagonalizable;
its possible diagonal characters lie in {+1,-1}². The first character
must be nontrivial because U^G=0. This gives exactly the three listed
images, including the nonsplit D10 representation with trivial
quotient character. No erroneous inference from a trivial composition
factor to a global invariant is made.

For G0=rho^-1(C5), conjugation by its Sylow normalizer is trivial
modulo five on cyclic P. Its conjugation image also has order prime
to five, since P is contained in its centralizer. Thus that image is
trivial. Burnside's normal-complement theorem applies to G0. Its
normal prime-to-five complement is unique: the product of two such
normal Hall subgroups would again have prime-to-five order. Hence it
is characteristic in G0, normal in G, and killed by rho. Modulo it,
Schur--Zassenhaus splits the normal cyclic Sylow from D. The only
order-at-most-two lifts of the mod-five conjugation action are +1
and -1. The three claimed abstract quotient groups follow.

## Actual geometry and limits

All quotients use subgroups of the given freely acting G, so the
intermediate curves and their etale maps are actual. The section
spaces on T_a and Y' are respectively U and U^P. The kernel of the
nontrivial quadratic D-character defines the stated double C/Y;
Y'/C has degree at most two and preserves the one section. Hurwitz
gives the displayed genera. In the C10 case at a=1 the commuting
coprime subgroups identify T_1 with the fiber product of its double
and cyclic-five quotients over Y, as required for the comparison
with the existing prompt.

The application retains the original source and opposite map while
descending its compatible tower along Z/T_a. It does not assert that
T_a/Y lifts, descend through the cyclic-five-power part, or create a
simultaneous Galois closure. The unbounded exponent and remaining
trivial-five-action branch are explicitly retained. No common-cover
exclusion follows from this result alone.

Minor presentation suggestions, not proof gaps: explicitly say that
Z and Y are smooth projective connected curves in the statement;
write the Sylow subgroup of G/K as PK/K when first identifying it
with P, to separate the actual subgroup from its quotient image.

## Source checks

[Faber, Theorem B and Remark2.3](https://arxiv.org/pdf/1112.1999),
checked directly, supplies the cited projective classification and
characteristic-five identification of A5.
[Craven, Theorems1.11 and2.1](https://web.mat.bham.ac.uk/D.A.Craven/docs/lectures/finitegroups2010.pdf),
checked directly, supplies the normal-complement and splitting
theorems. The elementary cyclic Sylow and character calculations
above were checked independently in this audit.

## Separate extension audit: NEW Section6

Verdict: PASS. Auditor: /root/audit_two_defect_monodromy.
Date: 2026-09-10. Scope: only the newly added complementary branch
where Sylow5 acts trivially on U, using the earlier audit and supplied
first-socle construction. No earlier verdict is broadened to a
common-cover exclusion. No computations or further agents were used.

The first-layer argument extends correctly to two invariant sections:
its long exact sequence gives
h0(E_S tensor F_P)=2+2d(P)-rank(delta)>=2d(P), since h1(E_S)=2.
Its inclusion in the actual pushforward with just two sections forces
d(P)<=1. Thus the actual nontrivial Sylow P is cyclic in this branch
as well. This does not assume that trivial section action means a
prime-to-five cover.

The first degree-five intermediate Z/(5P) over S=Z/P is an actual
connected etale C5 torsor. Choosing a generator identifies its class
in H1_et(S,F5); the Artin--Schreier map to H1(S,O_S) gives alpha.
Over the algebraically closed constant field that map is injective,
so this is a nonzero class, not a formal arbitrary cohomology vector.
The intermediate has exactly two sections by injection from S and
into Z. Its rank-two first-layer bundle therefore has no extra
sections, which forces alpha cup - to be injective and hence an
isomorphism between the two-dimensional spaces. The inherited
canonical-valued alternating pairing identifies this map with a
nondegenerate alternating form B_alpha on U.

Every n in N_G(P) induces compatible automorphisms of the actual
quotient torsor and S. Its action on the quotient character of P
is the contragredient of conjugation, so the AS class transforms
by c^-1 with the indicated convention. The pairing is pulled from
Y and is equivariant for these automorphisms. Serre trace on the
smooth projective curve S is invariant under automorphisms, yielding
B_(n alpha)(ns,nt)=B_alpha(s,t). The determinant of rho(n) therefore
equals c in this convention. Reversing the action convention can
invert c; the result used below is unchanged because the inherited
Brauer reciprocity makes det(rho(n))²=1. There is no division by the
degree of a five-cover in this argument.

For H=ker rho, P is Sylow in H and every element of N_H(P) has
conjugation exponent one modulo five. Since P is cyclic, it is
contained in C_H(P), and N_H(P)/C_H(P) has order prime to five. Its
image cannot meet the five-group kernel of
Aut(C_(5^a))->Aut(C5) nontrivially. Burnside applies and supplies a
normal Hall prime-to-five complement K in H. Uniqueness, as in the
earlier audit, makes K characteristic in H and normal in G. It lies
in ker rho, as required for section preservation on the actual
quotient Z/K.

Frattini gives G=H N_G(P), so this normalizer surjects onto Gamma.
The quotient H/K is cyclic of the full Sylow order. In G/K it is
normal, with prime-to-five quotient Gamma. Schur--Zassenhaus splits
this extension, and its action on H/K factors through Gamma because
H/K is abelian. This action has prime-to-five image. The modulo-five
determinant computation and the cyclic automorphism group identify
it uniquely with the determinant, acting as identity or inversion.
Thus G/K=C_(5^a) semidirect Gamma with the asserted action.
If P=1, K=ker rho has prime-to-five order, so the separately stated
degenerate case is also correct.

Since Gamma has prime-to-five order, Maschke and the earlier
reciprocal Brauer-character equality give an actually semisimple,
self-dual faithful two-dimensional module with no invariants.
This step does not supply a bound on Gamma. The proof correctly
retains that limitation and gives no descent through the remaining
five-part or new two-leg exclusion.

Editorial follow-up: the older final scope paragraph still says the
trivial-five-action branch is untreated. Replace that sentence with
the more precise current limitation: Section6 structurally treats
this branch but does not bound the prime-to-five image or give a
bounded-genus carrier. This is stale scope wording, not a gap in
the new argument.
