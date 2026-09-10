# Uniform cyclic25 descent with a genuine auxiliary oper

Version1,2026-09-10. The returned Pro argument has focused independent
audit PASS by /root/audit_d25_auxiliary_comparison. The reduction-compatible
local identification noted in that audit is explicit below. This is a
prose proof, not formal verification. The original unmarked common-cover
problem remains unsolved.

Use exactly the hypotheses and marking of
[the statement](../Theorems/Thm_cyclic_twentyfive_delayed_descent.md).
The n2 case is the separately audited
[initial theorem](Sol_cyclic_twentyfive_initial_descent.md). Its Section0
also derives the actual free cohomology modules and integral equivariant
Cech primitives from the actual-cover/simple-defect hypotheses. The
[mixed additive norm theorem](Sol_cyclic_power_additive_norm.md) is an
independent algebraic input, not a substitute for the comparison below.

Put p=5, R3=W3(k)[e]/((1+e)^25-1), sigma=1+e and
N=sum_(i=0)^24 sigma^i. Source and target Frobenius twists are retained;
coefficient Witt Frobenius fixes the abstract deck algebra.

## 1. Genuine auxiliary data and the primary equation

Fix n>=3, m=n-1 and the GIVEN compatible upper extension T_(n+3).
Choose a smooth C_(n+1)^a over the given compatible C_n. Normalize its
Hodge obstruction by changing bijective deformation coordinates, leaving
only the simple-zero coordinate eta0. Extend its UNDERLYING curve to
C_(n+3)^a and lift the ORIGINAL cyclic25 cover to T_(n+3)^a.
Smooth curves have unobstructed deformations, and finite etale covers
and their maps lift uniquely across nilpotent thickenings.

There are genuine auxiliary projective filtered opers on this curve,
extending the given preceding filtered object through W_m. At each
square-zero extension, local projective scalar lifts differ by omega²;
their gluing obstruction lies in H1(C,omega²)=H0(C,omega^-1)^vee=0.
Extend successively through W_(m+3). Retain the spin and actual flat
two-torsion line: their lifts have no infinitesimal two-torsion ambiguity
since2 is invertible. Extend the prescribed projective grading through
the maximal Higgs identification.

This auxiliary system P^a is NOT assumed inverse-Cartier compatible.
Nevertheless it is a legitimate higher inverse-Cartier input: the
construction needs a preceding filtered flat object, a new graded Higgs
object and their graded identification, not the next periodicity equation.
The auxiliary objects and their inverse-Cartier outputs genuinely glue.
All their pullbacks to T^a have their actual deck actions. No Hodge line
has been invented inside an incompatible inverse-Cartier output.

On the pulled-back two-affine cover, the negative normal line has

    0→Cech0 --delta→ Cech1 --pi→ M→0.

Choose an integral deck-linear section of pi; let P be its normal
primitive, so P delta=1 and delta P=1-section*pi. It preserves
augmentation images BEFORE division. The maximal Higgs field identifies
the auxiliary normal line with the tangent line. Its H1 lattice M and
the curve lattice V are free rank r=3g(C)-3 over R3. Freeness follows
by lifting special-fiber deck bases, Nakayama and equal Witt ranks, as
in the initial theorem. These statements apply to genuine auxiliary
opers; they do not require the omitted compatibility equation.

Since 5^n/5^(n+3) is square-zero for n>=3, the marked curve difference
between T_(n+3) and T_(n+3)^a is one element X of V. Its reduction is
the deformation of the GIVEN T_(n+1). Primary compatibility gives

    Xbar=c e22+d e23+b e24, c^5=eta0,                  (1)

with bijective component zero. This is the one-digit Hodge variation,
whose sign is rho(S+xi)=rho(S)-Psi(xi).

## 2. The first preceding-oper scalar change

In a determinant-horizontal oper frame, write nabla_partial=partial+A,
A=((0,r),(1,0)). Change the connection by tau*((alpha,beta),(gamma,-alpha))
and the Hodge generator projectively by ell+tau*s*m, tau²=0.
The maximal-Higgs determinant normalization gives

    ell_new=(1-tau*(gamma+s')/2)ell+tau*s*m,
    m_new=nabla_partial ell_new.

Differentiation gives the actual scalar change

    delta r=beta+alpha'+r gamma-gamma''/2
             +r's+2rs'-s'''/2.                         (2)

Thus D_r(s)=r's+2rs'-s'''/2 is additive. The fixed first connection
discrepancy v^a=beta+alpha'+r gamma-gamma''/2 is the discrepancy between
the auxiliary oper and its inverse-Cartier output.

Identify the affine curve rings and choose identical local Frobenius
lifts, putting the curve deformation in overlap maps. Then v^a is
descended. If r1 denotes the first differing preceding scalar digit,

    r1_actual-r1_aux=v^a+D_(r0)(s0).                    (3)

Other affine identifications add an additive curve-cochain term, which
is included in the curve operator below.

Choose local module identifications COMPATIBLY UNDER REDUCTION. The
GIVEN compatible upper tuple identifies its preceding oper with the
reduction of its next inverse-Cartier object. Consequently the first
graph coefficient s0 in (3) is exactly the same ubar used in the final
normal graph in Section3. This is not an independently chosen repair
or an assertion that the non-descended H3 already descends. It uses
the reduction compatibility of the actual functor and the specified
upper tuple. This clarification is the point requested by the audit.

For coordinate change f with lambda²=f', the genuine oper jet and
corrected filtered/graded tilde construction are

    J=epsilon [[lambda,lambda'/f'],[0,lambda^-1]],
    Jtilde=epsilon [[lambda,5lambda'/f'],[0,lambda^-1]],
    nablatilde_partial=5partial+B_r,
    B_r=[[0,25r],[1,0]].                                (4)

The diagonal is the NEW prescribed graded map; the upper entry uses
the PREVIOUS filtered map. epsilon is the actual flat periodicity
line; it cancels only in the normal coefficient line. The jet transition
has no scalar-r dependence, and scalar feedback enters through25r.

Let K0=I and K_(j+1)=5partial K_j+B_r K_j. If delta r=5^s a,
the Taylor scalar response is

    sum_j (K_j(r+delta r)-K_j(r))z^j/j!
      =5^(s+2)a [[z²/2,z],[z³/6,z²/2]] mod5^(s+3).      (5)

Afterward apply the prescribed coefficient Frobenius. This includes
all factorial denominators. If Q0=I, Q_(j+1)=partial Q_j+A Q_j, then

    K_j=[[5^j Q11,5^(j+1)Q12],[5^(j-1)Q21,5^j Q22]],
    (K5)21=5^4(r²+3r'').                                (6)

These formulas prove v5(K_j)>=j-1 and show that no j>=4 term changes
the coefficient in (5). The non-descended first scalar digit therefore
produces an additive LAST-digit correction in the first Hodge repair,
not an arbitrary non-descended coefficient of subsequent repairs.

## 3. The actual three-digit normal equation

Write upper local Hodge graphs as s_i=5^m u_i, u in Cech0 over W3.
Auxiliary inverse-Cartier and auxiliary oper objects agree through W_m.
Choose local determinant-one MODULE identifications extending that
agreement, compatibly with reductions as above. They need not be
horizontal beyond W_m and are only comparison frames, not artificial
filtered-flat morphisms supplied to the tilde functor.

A curve-overlap change 5^(m+1)D changes divided Frobenius displacement
by 5^m(F_jD-DF_i). Take the additive normal part of the COMPLETE
corrected jet/Taylor construction with auxiliary scalar fixed. Together
with the chosen source Cech section, this defines B:V→Cech1, additive
over Z/125 and deck-equivariant, with

    pi Bbar=Psi_T.                                     (7)

It retains Witt Frobenius on coefficients, rather than differentiating
the characteristic-five map a↦a^5 as an ordinary polynomial.

For exactly l changed displacement factors in Taylor degree j, the
valuation is at least

    lm+j-1-v5(l!)-v5((j-l)!).

For j>=l>=2 the last three terms are at least1. Thus nonlinear
displacement terms start at2m+1 and vanish modulo5^(m+3). For l=1,
j>=4 also vanishes since j-1-v5((j-1)!)>=3. The binomial numerator
is included; no denominator5 is treated as a unit.

For G=((a,b),(c,d)) the exact normal graph equation is

    c+d s_j-s_i(a+b s_j)=0.

First graph squares have order2m. They survive only at m2 (n3), at
the last digit; first-times-second terms have order2m+1 and vanish.
Using (2)--(7), the full normal comparison over W3 is

    delta u+E-BX+25 K(ubar)
           +1_(n3)*25 Q(Xbar,ubar)=0.                   (8)

E is the DESCENDED full auxiliary compatibility error, including v^a.
K is additive/deck-equivariant on reduced cochains. It includes scalar
feedback (3)--(5) and fixed auxiliary-discrepancy coefficients times
the first repair. Q is an ORDINARY quadratic expression in variable
first cochains.

Explicitly at n3, take G=Goper+25G1+125G2+625G3 and
s_i=25u_i0+125u_i1+625u_i2. The additional625 coefficient is

    (G1)22 u_j0-(G1)11 u_i0-boper u_i0 u_j0.             (9)

Fixed G1 parts belong to K; variable parts are additive in Xbar and
give Q. Nonlinear scalar normalization gains the extra25 of (4),
nonlinear displacement vanishes by the valuation bound, and changes
of graded jets start a digit after the first Hodge graph. These are
all channels at the stated precision.

For n>=4 the relevant fixed W3 data are already in the descended
common tuple. For n3 they are supplied by the genuine auxiliary oper;
the possibly non-descended25-digit of actual H3 enters ONLY through
25K(ubar), by (3). It has not been inserted into fixed coefficients.

## 4. Eliminate repair feedback before using the norm theorem

Modulo5, primary compatibility and (8) give

    ubar=Pbar(Bbar Xbar-Ebar).

Ebar is invariant, hence lies in e24 of the torsor function algebra;
Xbar is in e22 by (1). All reference maps and P preserve augmentation,
so ubar and the variable first matrix coefficients lie in e22 at
COCHAIN level. Actual torsor functions satisfy

    (e22 A)(e22 A)⊂e20 A.

This follows in the binomial-function basis after etale trivialization,
and descends, including pulled-back bundle contractions. Thus
pi Q belongs to e20 Mbar. There is NO division of this ordinary product.

Apply pi to (8) and substitute its first-graph equation into K. Set

    Lscript=pi B-25pi K Pbar Bbar,
    E'=pi E-25pi K Pbar Ebar.

Then

    Lscript X=E'+1_(n3)*25q, q in e20 Mbar.              (10)

Lscript is additive/deck-equivariant and reduces to Psi_T. E' is
invariant, so freeness of the integral target gives E'=N boldeta.
This error was formed downstairs and pulled back BEFORE taking an
obstruction quotient or dividing. It is not inferred from the zero
special-fiber map on cokernels.

Lift the Fitting decompositions. The bijective block of Lscript has
an additive inverse obtained digit by digit; it commutes with deck
action. Its Schur complement preserves augmentation and norm terms.
On the remaining rank-one block,

    L(Xnil)=N eta+1_(n3)*25qnil,
    L mod5=e²Phi, qnil in e20 R, eta mod5=eta0.           (11)

Since e20 R⊂im(e²Phi), choose z with e²Phi(zbar)=qnil.
Replacing Xnil by Xnil-1_(n3)*25z changes no GIVEN first truncation
and yields the exact integral equation

    L(Xnil')=N eta.                                    (12)

No division by5 has been commuted with an augmentation ideal.
Alternatively, K(ubar) itself projects into e22 Mbar⊂im Psi_T and
therefore disappears directly in the last cokernel; its fixed part
is the retained norm error. This independently checks the n3 feedback.

## 5. Norm coordinate, secondary residue and original-map descent

The mixed-additive norm theorem gives

    coker(L Phi^-1)=W3(k)⊕e W2(k), [N eta]=(25eta,0).

Solubility of (12) forces eta in5W3(k), hence eta0=c=0. The reductions
of ALL its solutions are exactly k e24, hence d=0 as well. Therefore
the GIVEN T_(n+1) difference is b e24.

Once eta0=0, all later lower-reference errors are higher norms5Neta1
or25Neta2, which are zero in this integral cokernel. They have not been
dropped before the comparison. A particular solution removing them
has leading term in k e24 and cannot change the e23 coordinate.
The repaired second divided LINEAR residue for d e23+b e24 is -d^5e;
the normal sign is opposite. Thus the later relative secondary class is

    Theta_n^rel(d,b)=d^5e, n>=3.                        (13)

The ordinary quadratic contribution in (10) is zero there. There is
one coefficient Frobenius, not d^25. Free terminal curve digits give
Psi-images; first repair choices have the same linear residue; auxiliary
choices change only the additive operator and retained norm. This
also proves the stated independence.

The first intervening repair in the kernel case exists: for X0 in
e23, L(X0) lies in e23M∩5M. Its divided reduction is in e5 Mbar by
the controlled colon lemma of the initial proof, hence in im Psi.
The next norm error reduces into e24, also an image. The quadratic
term has not yet appeared at that digit.

Now C_(n+1)^a is compatible because its normalized obstruction eta0
is zero. Change it by b e_C in ker Psi_C. Its ORIGINAL lifted cover
has exactly the given deformation b e24, so it is isomorphic to the
GIVEN T_(n+1), with its marking. Transport the finite etale cover map
through this marked isomorphism. This proves descent along h, not
replacement by an unrelated upper curve.

Functoriality identifies the higher flat objects; uniqueness of the
Hodge line (negative normal H0) identifies the given filtration. A
maximal rank-two graded Higgs automorphism is scalar, hence projectively
trivial, so the prescribed grading agrees. The original flat square-
trivial line has its unique nilpotent lift and remains a pullback.
This proves all n>=3. The initial theorem supplies n2.

## 6. Full towers and algebraization

A GIVEN full upper tower contains T5, which descends its given T3 by
the initial theorem. Having obtained T_n→C_n, apply the n-th case to
the GIVEN T_(n+3), descending its GIVEN T_(n+1) and extending the map.
Lower marked descents are unique by injectivity of etale pullback on
H1(Tangent). Marked maps and source identifications are unique because
H0(T,h*T_C)=H0(T,T_T)=0. Filtrations and projective gradings are unique
as above. Hence these are an actual compatible inverse system of maps.

W(k) is a complete noetherian DVR. Compatible relative canonical line
bundles are ample, so Grothendieck algebraization gives smooth projective
curves over W(k). The compatible finite locally free algebras
(h_j)_*O_(T_j), with multiplication, unit and deck action, algebraize by
Grothendieck existence. They give the desired rank25 finite locally free
map. Its non-etale locus is closed and proper over W(k), with empty
formal completion along the special fiber, hence empty. The algebraized
map and deck action reduce to the ORIGINAL marked h.

## 7. Same-parameter main consequence for actual five-part25

This additional application has its own scoped audit PASS. In the
ordinary-X/source-defect-two/Galois-Y main branch with nontrivial
five-action and ACTUAL Sylow-five order25,
[the deck reduction](Sol_two_defect_deck_reduction.md) supplies original
intermediate maps

    Z → T →h Y' →j C → Y.

The first map has prime-to5 degree and preserves the two defects;
h is cyclic25; Y' has genus3 or5 and defect1; C is one of the known
bad doubles of Y, genus3; j has degree1 or2 and preserves defect.
The reduced groups are C50, D50 or C2×D50 (Dn has order n).

The bad double's Psi has a single zero and a five-dimensional bijective
part. For degree2 j, normalized trace splits that Psi subspace; the
complement has no kernel because the defect remains1. Thus Psi_Y'
has the precise simple-zero form, with eleven bijective dimensions
in genus5. The canonical ordinary Y tower lifts these ACTUAL covers,
providing the initial compatible reference required by D25.

Lift the original X-leg to the fixed canonical ordinary X tower. Its
GIVEN source tower has the same canonical W2 marking by the established
two-leg theorem. Descend it through Z→T by prime-to5 defect-preserving
descent, through h by D25, and through j by prime-to5 defect-preserving
descent. After algebraization this yields the ACTUAL same-source span

    X^can ← Z^can → C^lift.

Both maps start on the same smooth projective curve and remain finite
etale. No lift of the original C→Y has been assumed or obtained.

The count in [cyclic-five descent, Section6](Sol_cyclic_five_delayed_descent.md)
applies unchanged: at most5^24 ordinary X-connections, fewer than
2^80000000 genus-three characteristic-zero partners per fixed canonical
X, and at most80640 family parameters per special-fiber bad double.
Stable-model uniqueness and Frobenius stability give fewer than
2^80000073<K exceptional parameters, excluding this whole stratum for
the SAME main parameter. The genus-five intermediate requires no new
partner count, because the original neutral j descends further to C.

Actual five-part125 and higher, trivial-five-action carriers,
nonordinary-X trace-zero cases, higher source defects and non-Galois
Y-legs remain. This is not the unmarked common-cover theorem.

## Evidence and sources

The supplied [d25_checks.py](../scripts/d25_checks.py) was inspected and
replayed unchanged with `sage -python scripts/d25_checks.py` (the system
Python lacks SymPy; no package was installed). All assertions passed:
general oper variation and independent Schwarzian check; companion
recurrence and scalar response; n3 graph equation;625 torsor products;
exact /25 residues and higher norm identity; nontrivial F25 coefficient
transport. These are local algebra checks, not the global proof.

The pure identities include

    X1=e3+2e8+2e13+e18,
    [e²(e23+5X1)/25]=-e in R/e²,
    e²(5e22+25(e2+2e7+2e12+e17))=5N mod125.

The functor and its genuine filtered/graded input are in
[LSZ, Sections4--5, especially Lemmas4.7/4.10](https://arxiv.org/html/1311.6424v4).
The Hodge-obstruction derivative is
[LSYZ, current v2 Section6, equation6.0.1](https://arxiv.org/html/1404.0538v2).
Curve lifting uses [smoothness of curve moduli](https://stacks.math.columbia.edu/tag/0DZY);
cover lifting uses [nilpotent invariance](https://stacks.math.columbia.edu/tag/0BQB).
The final effectivity is [Grothendieck algebraization](https://stacks.math.columbia.edu/tag/089A)
and [existence](https://stacks.math.columbia.edu/tag/088E).

[Focused audit](../Research/audits/CYCLIC25_UNIFORM_COMPARISON_AUDIT_2026_09_10.md).
