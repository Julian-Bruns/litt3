# Proof: a deck translate detects the missing lower obstruction

2026-09-10. The Pro-returned W5 comparison and the root's extension
of that LOCAL comparison to all n>=3 passed a focused medium audit,
/root/audit_secondary_deck_transfer. The proof below combines it with
the earlier audited initial and compatible-reference cases, then
records the actual full-tower induction and scoped main-pair consequence;
these latter sections also passed a separate scoped review by the same
auditor. Version2 adds Sections7--9: the actual AS-product initial
step, general simple-defect input verification, and all three reduced
five-part-exactly-five groups. Those sections have fresh medium audit
PASS /root/audit_dihedral_initial_as_product, with Sections8--9 reviewed
separately. No audit is Lean verification.
[Statement](../Theorems/Thm_cyclic_five_delayed_descent.md).

## 1. Keep the original data and the two integral lattices

Use the actual C,T,h and full previous filtered data specified in
[the compatible-reference theorem](Sol_cyclic_five_compatible_reference_descent.md).
Write R=k[e]/e^5 and R2=W2(k)[sigma]/(sigma^5-1). Normalize the
source and target nilpotent bases to Psi_nil=e²Frob. Coefficient
Frobenius fixes e. Its kernel is e³R and its cokernel D is R/e².

Whenever T_n→C_n has descended, the complete previous tuple through
W_(n-1) is deck-equivariant. For n>=3 it contains in particular the
ACTUAL W2 tuple. Its tangent and normal obstruction lattices M2,P2
are free of rank six over R2, with lower pullback equal to the norm
submodules. The two-affine Cech splitting and primitive are R2-linear:

    0→Cech0→partial Cech1→cl H1→0,
    Q=partial^-1(1-s cl).

Thus an exact e³ cochain has its normal primitive in e³, integrally
as well as after reduction. This is the established cochain lemma,
not a claim about dividing arbitrary cochains by5.

## 2. Relative comparison between genuinely compatible upper lifts

Fix n>=3. Let A_(n+1),B_(n+1) be compatible marked lifts of the SAME
T_n and full previous tuple. Neither is required to descend. Suppose

    nu=[B_(n+1)]-[A_(n+1)]=a e³+b e^4.

The relative formula is

    epsilon(B_(n+1))-epsilon(A_(n+1))=a^5 e in D.       (1)

Here epsilon is the obstruction to the NEXT compatible lift, modulo
the image of Psi, using rho(S+xi)=rho(S)-Psi(xi).

### 2.1 The prescribed filtered-and-graded construction

In frames adapted to the actual preceding H_n and aligned with its
graded identification, write the filtered overlaps and connection
as triangular M_n and [[alpha_n,beta_n],[gamma_n,-alpha_n]]. The
local weight-one object modulo5^(n+1) has matrices

    Mtilde=[[a_(n+1),5*btilde_n],[0,d_(n+1)]],
    nablatilde=5d+[[5*alphatilde_n,25*betatilde_n],
                  [gamma_(n+1),-5*alphatilde_n]].        (2)

The diagonal transition entries and gamma_(n+1) are the prescribed
GRADED Higgs data. The other entries lift H_n coefficients with the
displayed extra factors. This follows directly from
[Lan--Sheng--Zuo, Lemmas4.6,4.7,4.10 and Proposition4.11](https://arxiv.org/pdf/1311.6424).
Lemma4.10 constructs the morphism from the previous filtered morphism
AND the higher graded morphism. In particular its lower transition
entry is zero before rescaling; it is not an arbitrary lifted raw
graph matrix conjugated by diag(1,5).

For n3 this corrects the entire raw lower entry5L+125Q. The discarded
raw term is not asserted to have zero cohomology on its own. This
construction is legitimate because BOTH previous Hodge lines glue;
no Hodge line on an incompatible lower reference is constructed.

Set m=n-1. The H_n changes are5^m times first cochains; prescribed
graded changes are5^(m+1). By(2), previous-tuple changes enter the
intermediate object at5^(m+1), additively; the upper connection entry
gains two factors. The final graph and leading Taylor differences
have order5^m, and their products vanish modulo5^(m+2), since
2m>=m+2 for m>=2. Thus the n3 case is the limiting equality; later
levels introduce no new quadratic term at this precision.

The weight-one Taylor valuation j-1-v5(j!) controls all higher terms;
the first term is kept explicitly. The Taylor functor, its reduction
identification and the original flat twist are those of
[Lan--Sheng--Yang--Zuo, Section5, especially(5.5.1)](https://arxiv.org/pdf/1404.0538).
The flat twist cancels between filtration and quotient in the normal
line but remains in the actual preceding flat bundle and gluing.

### 2.2 Why the comparison is deck-equivariant without a fixed upper reference

A_(n+1) need not be deck-fixed. The LEADING two-digit comparison
coefficient is multiplied by5^m, and therefore sees only the common
W2 tuple, which IS pulled back from C_n. A non-descended coefficient
change of order25 gives5^(m+2)=0 in the calculation. Contributions
already multiplied by5^(m+1) see only the special fiber. These facts
give actual deck-equivariance of the relevant operators; it is not
inferred from a nonexistent deck action on A_(n+1).

### 2.3 Integral primitive, surviving carry and sign

Choose smooth W_(n+2) extensions whose two-digit difference is
nutilde=atilde e³+btilde e^4 in M2. The square-zero ideal5^nW_(n+2)
is the coefficient module W2. A different final digit contributes a
Psi image and does not change epsilon.

The first normal Taylor comparison is an ACTUAL additive,
deck-equivariant lift reducing to Psi. On the nilpotent block it
has form e²varphi+5B, with B additive and deck-equivariant modulo5.
Represent its positive cochain by ztilde in e³Cech1(P2), and choose
qtilde=Qztilde in e³Cech0(P2). Reduction is the unique actual first
Hodge repair. Since Psi(nu)=0,

    ztilde-partial qtilde=s cl(ztilde)

is divisible by5. The actual normal obstruction difference has the
term -5^m(ztilde-partial qtilde), plus the additive5^(m+1) carries.
After division and projection to D, all those other carries vanish:
their inputs are e³ cochains and they are additive deck-equivariant.
Frobenius on such a primitive causes no exception, since it fixes e.

The divided integral term itself survives, with the sign

    epsilon(B)-epsilon(A)=-[e²varphi(nutilde)/5].         (3)

Using the integral deck identity

    e^5=-5e-10e²-10e³-5e^4,

one obtains [e²varphi(nutilde)/5]=-a^5e in R/e²; e^6/5 has zero
image there. The 5B correction also has zero image. Equation(3)
proves(1). This is why the obstruction orientation is POSITIVE even
though the divided Psi carry in the earlier proof was negative.

## 3. Deck equivariance computes the missing lower transfer

Choose a smooth lower reference C^0_(n+1) and normalize its Hodge
obstruction to eta0 on the zero line of V_C, by varying its bijective
component. Lift h as a CURVE cover to T^0_(n+1). Given compatibility
of T_(n+1), the first variation equation gives

    xi=[T_(n+1)]-[T^0_(n+1)]=c e²+d e³+b e^4,
    c^5=eta0.

The lifted curve cover makes T^0_(n+1) fixed in the marked
curve-lifting torsor, regardless of lower Hodge compatibility. Thus

    [sigma T_(n+1)]-[T_(n+1)]=e xi=c e³+d e^4.

Both upper objects are compatible and extend the same deck-equivariant
lower tuple. Formula(1) and naturality of epsilon for MARKED deck
translates imply

    e*epsilon(T_(n+1))=c^5 e.

Write epsilon=K+Le. Since e²=0 on D, K=c^5=eta0. No tau action on
C_n or the chosen upper lift is required. There is no additional
Frobenius on eta0. Changing d changes only L by the corresponding
fifth power; changing b leaves epsilon unchanged.

## 4. The given truncation descends, at every level

If T_(n+1) has the specified compatible T_(n+2), its epsilon is zero.
Section3 therefore gives eta0=0. The lower reference is now compatible
and c=0. The ALREADY proved compatible-reference theorem forces d=0,
and recovers the given T_(n+1) as the cover of C^0_(n+1)+beta, with
h*beta=b e^4. The isomorphism is marked and retains the original map
over W_n, not a replacement source or changed embedding.

At n2, use the earlier audited canonical-reference case, with its
legitimate tau cancellation. At n>=3 use Sections2--3. This proves
uniform D5 under the actual stated cohomological hypotheses.

## 5. Full towers and algebraization

Starting with canonical C2,T2, a supplied full compatible tower on T
contains every extra digit needed in Section4. First T4 recovers its
given T3→C3, then T5 recovers its given T4→C4, and so on. Each lower
lift extends the preceding marked one. Injectivity of the etale
curve-deformation pullback and H0(T_C)=0 give uniqueness at each stage;
the Hodge lines and graded identifications agree by their stated
uniqueness. The original flat periodicity line is retained throughout.

Hence the maps form a compatible formal finite etale cover. Smooth
proper curve algebraization and the proper henselian finite-etale
equivalence, as used in
[defect-preserving descent, Section4](Sol_defect_preserving_etale_descent.md),
give the actual cover over W(k). No lift of the unrelated C→Y map
has been required or produced.

## 6. Scoped consequence for the same main pair

Suppose an actual matched Galois-Y main-pair span has ordinary r_X,
two source defects, and its actual prime-to-five defect-neutral
quotient is the C10 carrier T=C×_Y Y1 of the stated type. Lift the
ORIGINAL X-cover Z→X to the full canonical ordinary lift of (X,r_X).
The already audited prime-to-five descent theorem descends that given
full compatible Z tower along Z→T. Its initial marking is the canonical
one induced by Y, by the existing two-leg W2 theorem.

Sections4--5 now descend it along the original T→C. Consequently

    X^can ← Z^can → C^lift

is an ACTUAL finite-etale span in mixed characteristic, with both maps
from the same smooth projective curve. The lifted C has genus3.
The original C→Y is not asserted to lift; that is not needed.

The quantitative argument in
[defect-preserving descent, Sections5--6](Sol_defect_preserving_etale_descent.md)
now applies verbatim to this span: at most5^24 choices of r_X, fewer
than2^80000000 genus3 characteristic-zero partners for each fixed X^can,
and at most80640 family parameters per special-fiber bad double.
Stable-model uniqueness and parameter Frobenius give a total
<2^80000073<K, for the SAME previously selected parameter. This
excludes the stated C10 carrier branch, not arbitrary cyclic/dihedral
towers or all source-defect-two spans.

All ten exceptional bad-double configurations in the family can be
transported to the displayed one by projectivities of P1(F5) fixing
the omitted rational point4. This group has order20 and acts
transitively on the ten pairs (exceptional Hasse class,bad twist).
The finite verification is in verify_bad_double_symmetry.py. Transport
also preserves the ACTUAL normalized quartic and its intrinsic active
connection: the scalar construction, canonical marked lift and full
filtered Higgs--de Rham tuple are functorial under these curve
isomorphisms. Thus the finite label calculation is not being used as
a substitute for identifying the operator. The cohomological hypotheses
for each transported C10 carrier remain explicit, not inferred just
from its abstract group name.

## 7. Initial descent by actual Artin--Schreier products, without an involution

NEW2026-09-10. This section has focused medium audit PASS by
/root/audit_dihedral_initial_as_product, including the generality under
the precise reference, Fitting, cochain and linear-comparison inputs.
The root's input verification and enlarged application in Sections8--9
have a separate scoped PASS from that auditor. The earlier
Sections1--6 remain the original proved special case and proof inputs.

Let h:T→C now be ANY actual cyclic-five etale torsor carrying the
pullback of the full projective filtered tuple and actual flat twist.
Assume the same simple-defect normal form, replacing rank six by
r=3g(C)-3: Psi_C has a bijective part and a single zero line;
V_T is free over k[C5], with bijective rank r-1 and nilpotent rank one,
Psi_nil=e²u(e)Frob. Retain a compatible reference C3^0 and its cover
T3^0 above the specified marked C2,T2. No involution is assumed.

Set q=log(sigma) in k[C5]. Choosing normalized source/target bases,
all compatible T3 have differences d q³+b q4 from T3^0. Their
next obstruction is

    epsilon(T3(d,b))=d^5 q in k[q]/q².                   (7)

The sign is the same obstruction orientation as in Section2.3; changing
the normalization changes its nonzero linear coefficient, not its zero
set. The linear divided carry and additive next-digit cancellation
from Section2.3 apply at this initial level as well. Only ordinary
quadratic corrections had previously required the commuting tau.

### 7.1 Multiplication of actual first repairs

On a pulled-back affine chart the torsor has AS algebra

    A=B[w]/(w^5-w-f), sigma(w)=w+1.

For its unique reduced polynomial representative of degree<=4, q acts
as d/dw. This statement is about the B-linear operator on that basis;
q is NOT claimed to be a derivation of the whole AS algebra. It gives

    q³A=B<1,w>=P1, q²A=B<1,w,w²>=P2, P1*P1⊂P2.         (8)

An AS chart change adds a base function to w, so these subsheaves are
intrinsic. Fifth powers and differential operators pulled from C
preserve P1: w^5=w+f and dw=-df. All reference bundle maps and flat
periodicity transitions have AS degree zero. The same assertions hold
after tensoring with any coefficient bundle pulled from C.

The equivariant Cech primitive puts the first normal Hodge repairs in
q³ at cochain level, not merely their cohomology classes. Thus first
matrix corrections and normal graph generators are all in P1. On the
two-affine complex, any normal product in P2 is a q² one-cochain;
its cohomology class lies in q²H1(T,N)⊂im Psi_T. The last inclusion
holds on the bijective part trivially and on the nilpotent part by its
specified elementary divisor e². This kills ordinary quadratic products.

### 7.2 No extra division of the quadratic products

Use the ACTUAL prescribed matrices(2), now modulo125 with previous
filtered data modulo25. First changes of that previous tuple are5
times first corrections. In the tilde matrices they enter additively
at order25; the upper connection entry gains two factors. The lower
connection entry and diagonal transitions come from the new GRADED
object. A raw graph quadratic that vanished modulo25 is not divided
back into existence by these prescribed morphisms.

For completeness the high-Taylor estimate can be made without
discarding factorials divisible by5. Write D for the tilde connection
operator, with D² divisible by5. For one insertion of25X in D^n,
the valuation after n! division is at least

    2+max(0,floor((n-2)/2))-v5(n!) >=2.

Two insertions give at least

    4+max(0,floor((n-4)/2))-v5(n!) >=3.

For EXACTLY TWO changed factors of a displacement5*zeta in the nth
Taylor term, the correct estimate is

    2+floor(n/2)-v5((n-2)!) >=3, n>=2.                  (9)

Here binomial(n,2)/n!=1/(2(n-2)!). This corrects the stronger but
incorrect estimate in the original returned wording. A mixed operator/
displacement insertion has valuation at least
3+max(0,floor((n-2)/2))-v5((n-1)!)>=3. Hence no such quadratic
Taylor change survives modulo125. The prescribed graded restoration
uses linear changes and divisions by2, not5.

The remaining final graph term is precisely an ORDINARY product.
For G=((A,B),(0,D0))+5K+25L and graph matrices I+5 ell_i E21,
its normal entry is

    5(K21+D0 ell_i-A ell_j)
     +25(L21+K22 ell_i-K11 ell_j-B ell_i ell_j).

The divided remainder of the first bracket is the retained LINEAR
integral carry; no augmentation assertion is made after dividing it.
Quadratic terms in the second bracket only use reduced P1 coefficients
after division by25, so (8) kills them in the obstruction cokernel.
The supplied additive terms also disappear there. This proves(7).
Sources for the functor are the same LSZ Lemmas4.7/4.10 and LSYZ§5
used in Section2, with the actual previous flat twist retained.

Consequently compatible W4 implies d=0, and the GIVEN T3 is exactly
the cover of C3^0+b e_C along the ORIGINAL h. Conversely d=0 makes
epsilon zero, so a smooth fourth digit can be corrected by Psi to give
a compatible W4 extension. There is no additional parameter exception.

## 8. Verifying the inputs on an arbitrary simple-defect base

NEW root extension, focused medium audit PASS. Suppose C has an actual
active admissible tuple, a compatible reference C3^0 above its marked
C2, and Psi_C has a bijective part of dimension3g(C)-4 plus a single
zero line. Let h:T→C be an actual cyclic-five etale cover such that
the pulled-back connection has defect TWO. These hypotheses imply the
module and cochain inputs used above; they are not being added as new
definitions of a cover.

Put r=3g(C)-3. The Cartan--Leray edge map, using H0(T,T_T)=0,
identifies V_C with V_T^C5. The latter has dimension r, whereas
dim V_T=5r. Every indecomposable k[C5] module has length at most5
and contributes one invariant dimension. Thus V_T is free of rank r.
The normal line is intrinsically T_T by the maximal Higgs map and has
the same argument. Over W2 lift module bases; Nakayama and equal
W2-ranks give free integral lattices over W2[C5]. Pullback identifies
the lower lattices with norm submodules, by reduction and Nakayama.

The actual Psi commutes with deck actions, with coefficient Frobenius
fixing their abstract algebra. Its semilinear Fitting summands are
deck-stable direct summands of V_T, hence free k[C5] modules. Taking
invariants commutes with that direct decomposition and with Psi; the
nilpotent invariants identify with the one-dimensional nilpotent part
of V_C. Therefore the nilpotent summand has module rank ONE. Its
kernel has dimension two, so its scalar multiplier has e-adic order
two: e²u(e)Frob. The other summand is bijective of rank r-1.
The inherited negative-normal two-affine Cech exact sequence has free
cohomology, so it has integral deck-equivariant sections and primitives.
These preserve every q^j image. This supplies the input actually used
in Section7, without any genus-specific ranks or double signs.

The geometric relative comparison of Sections2--3 uses exactly those
module/cochain hypotheses, the preceding actual deck-descended W2 tuple
and compatible upper objects. Its proof does not use rank six, genus3
or an involution. It therefore gives the same all-n>=3 secondary
transfer for these C,T. After eta0=0, compare with the actual compatible
pulled-back reference; its obstruction class is h*epsilon_C=0 in D_T.
Formula(1) then forces the e³ coefficient to vanish. Section7 supplies
n2. The original map/full-tuple descent and tower induction of
Sections4--5 consequently hold in this broader setting.

## 9. All nontrivial-action carriers with five-part exactly five

NEW root consequence, focused medium audit PASS. In the main-pair ordinary-X,
source-defect-two, Galois-Y branch, assume the ACTUAL cyclic Sylow5 has
order5 and acts nontrivially on the two defects. The already proved
two_defect_deck_reduction supplies a normal prime-to5 defect-neutral
quotient Z→T whose reduced group is C10, D10 or C2×D10. Let

    T →h Y' →j C → Y

be the ORIGINAL intermediate maps from that reduction. Here h is
cyclic5; Y' has genus3 or5 and defect1; C is a known bad double of
genus3; j has degree1 or2 and preserves defect.

The bad double's Psi has five bijective dimensions and a zero line.
If j has degree2, its trace splits the pulled-back Psi subspace. The
complement has no kernel, since both defects equal one; hence it is
bijective. Thus Y' has exactly the simple-defect Psi required in
Section8, with eleven bijective dimensions in genus5. The initial full
compatible reference is the lift of these actual covers to canonical
ordinary Y. No separate enumeration of AS directions is needed:
source defect two is the hypothesis on this actual witness.

Lift the original X-leg to the fixed canonical ordinary X lift. First
descend its GIVEN source tower through prime-to5 Z→T; then Section8
descends it through h:T→Y'; then prime-to5 defect-neutral descent
through j recovers a full tower on the genus3 C. All maps still start
from the same Z^can. The actual span is X^can←Z^can→C^lift.
The unchanged genus3 partner count in Section6 applies, so this ENTIRE
five-part-exactly-five/nontrivial-action/ordinary-X stratum is excluded
for the SAME main parameter. In particular the order20 case needs no
new genus5 partner count. The original map C→Y is not asserted to lift.

This still leaves five-part25 and higher, trivial five-action,
nonordinary-X residuals, higher defects and non-Galois sources. It is
not an exclusion of all common covers.
