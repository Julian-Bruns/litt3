# Initial two-digit descent along an actual cyclic-twenty-five cover

Version1,2026-09-10. Proved; focused medium audit PASS for the geometric
comparison and separately for the general simple-defect scope below.
Auditor /root/audit_cyclic25_initial_comparison. The returned Pro proof
was completed by the explicit oper normalization and integral-product
lifting argument below. Exact checks are evidence for the algebra,
not formal verification of the geometry.

Let h:T→C be an actual connected finite etale cyclic25 cover, g(C)>=2,
with the full active admissible projective filtered tuple, prescribed
graded identification and actual flat square-trivial periodicity line.
Assume Psi_C has a bijective part of dimension3g(C)-4 and one zero
line, and the pulled-back connection on T has defect2. Fix a GIVEN
compatible reference C5^0 and its lifted cover T5^0. Compatibility at
W_j means the full preceding tuple extends through W_(j-1).

In normalized nil-block bases the actual initial obstruction is
Theta(d,b)=d^5e in D=k[e]/e². Thus compatible W5 forces the GIVEN
marked T3=T3^0+d e23+b e24 to descend along original h:T→C.
This requires the stated reference; it does not assert its existence
for an arbitrary pair. No all-level/full-tower cyclic25 conclusion.

The explicit family in
[the original question](../Research/PRO_CYCLIC25_INITIAL_TWO_DIGIT_REQUEST.md)
has this reference by pullback from its ordinary genus-two endpoint.
It satisfies the hypotheses on
Delta=(t5-t)(t²+2t+3)(t²+2t+4)!=0, with no further exclusions.

## 0. General simple-defect inputs

Put R=k[e]/e25, e=sigma-1, r=3g(C)-3. The negative tangent and
normal lines have no H0. For the actual etale cover, Cartan--Leray
identifies V_T^G with V_C and gives H^i(G,V_T)=0 for i>0: the
only nonzero row for the negative line is H1, and coherent cohomology
on the base vanishes above1. The finite k[G]-module V_T is therefore
projective and hence free of rankr over the local algebra R.

Take the semilinear Fitting decomposition of the actual Psi_T. Its
summands are R-linear direct summands, hence free. FIRST identify
the operator on invariants with Psi_C by naturality and Cartan--Leray.
For a free R-module, the norm gives a canonical isomorphism from its
augmentation coinvariants to its invariants. It commutes with Psi
(coefficient Frobenius fixes the deck algebra). This transfers the
base operator to the augmentation quotient; the quotient is not
silently identified with the base without the norm map.

The base simple zero forces one free nilpotent block and r-1 free
bijective blocks. A semilinear map on the free rank-one block is
multiplication by e^j u(e), followed by coefficient Frobenius. Source
defect2 forces j=2. Normalize the unit using the separate source and
target bases. Thus

    Psi_nil=e²Phi, ker Psi_T=e23R, D_T=R/e²,
    h*(ker Psi_C)=k e24, h*:coker Psi_C→D_T is zero.

Over the GIVEN compatible reference through W3, the tangent and
normal H1 lattices are free over W3(k), by negative H0, duality and
base change. Lift an R-basis and use Nakayama and equality of W3-ranks
to get free rankr modules over W3(k)[G]. Their pulled-back two-affine
Cech complexes have exact sequences 0→Cech0→Cech1→H1→0. Freeness
splits the last surjection deck-linearly; injectivity of the first
map gives the normal primitive on boundaries. These integral choices
preserve augmentation images BEFORE division.

These arguments derive the cochain inputs from the geometric
hypotheses. They use neither the explicit parameter nor an involution.

## 1. Actual jet/Taylor construction

Put p=5. The oper frames can be chosen without division by p. Start
in a determinant-horizontal local frame and choose a Hodge generator
ell. Maximality of the Higgs field makes det(ell,nabla_partial ell)
a unit. Rescale ell by its inverse square root and put
m=nabla_partial ell. The determinant is now1, so trace zero gives
nabla_partial m=r ell. Lifting this normalization and aligning the
prescribed new graded map use only units and square roots (2 is
invertible). Their first variations are linear in the original
correction cochains. This justifies the augmentation assertion for
r1 below; it is not raw rescaling of an arbitrary graph matrix.

For coordinate change z_j=f(z_i),
lambda²=f', the filtered transition and corrected tilde data are

    J=epsilon [[lambda,lambda'/f'],[0,lambda^-1]],
    tilde nabla=p partial + B, B=[[0,p²r],[1,0]],
    tilde J=epsilon [[lambda,p lambda'/f'],[0,lambda^-1]].

The diagonal uses the NEW prescribed graded transition, the upper
entry p times the PRECEDING filtered map. It is not raw graph
rescaling. epsilon is the actual flat periodicity twist and cancels
only in the normal line. Write K0=I, K_(n+1)=p partial K_n+B K_n.
Taylor gluing is sum K_n z_ij^n/n!, modulo p4 for the H4 term. Then

    v_p(K_n)>=n-1,
    K1=B,
    K2=[[p²r,p³r'],[0,p²r]],
    K3=[[p³r',p4(r''+r²)],[p²r,2p³r']],
    (K5)_21=p4(r²+3r'').

For exactly j changed displacement factors with delta z in pA,
valuation>=j+n-1-v5(j!)-v5((n-j)!). Fifth terms must be kept; n>=6
vanishes modulo p4. If preceding scalar is r0+p r1+p²r2, its r1
effect starts at p³ and r2 has no effect modulo p4. Moreover r1 is
in e23 A1: first connection/gauge/oper restoration is linear in
e23 first corrections, using reference derivatives and unit divisions.

Let actual output transition in fixed reference Hodge frames be M.
For graph s_i=p a_i+p² b_i+p³ c_i its exact normal mismatch is

    E_ij=m21+m22 s_i-s_j(m11+m12 s_i).                  (12)

Compatibility through W4 gives E divisible by p³; the next normal
cochain is E/p³ mod p. Changes in c_i give a boundary. The issue is
to control every surviving term through this last division.

## 2. New integral product and colon identities

For the lifted regular torsor function algebra A2 modulo25,

    (e23 A2)^2 ⊂ e22 A2+5 e² A2.                       (7)

Etale locally set B_j(i)=binomial(i,j), 0<=i,j<=24. Cyclic wrap gives
eB_j=B_(j-1)-binomial(25,j)B24 for j>=1, and eB0=0. Only j=5,10,15,20
give nonzero wraps modulo25, each divisible by5; two wraps vanish.
With P_r the binomial span through degree r this implies

    e23 A2⊂P1+5P21, e22 A2⊂P2+5P22.                  (14)

Products lie in P2+5P22. To deduce(7), match their reduction in P2
using e22B22,e22B23,e22B24. Each such lift has support in P2+5P22;
the difference is5P22, and P22 mod5=e²A1. This lifting sentence
spells out the step implicit in the paste and explicit in its script.
Membership descends by faithful flatness and allows pulled-back bundle
coefficients/reference contractions.

For any free integral deck module M, also

    ((e^r M ∩5M)/5) mod5⊂e5(M/5M), 5<=r<=24.          (15)

If e^r x is divisible by5 then x=e^(25-r)y+5z. Divide e25y+5e^rz,
using e25/5 mod5=-e5-2e10-2e15-e20. The r20 case is needed below.

## 3. Geometric reduction to a second linear carry

Write curve displacement p²X, X modulo p³, and graph s=pS. Define P
as MINUS the additive-in-X normal part of the reference jet/Taylor
expression with preceding scalar frozen at its reference value. Its
actual r1 variation is retained separately. Integral Cech sections
and projection, followed by additive Schur complement of the r-1
bijective blocks, give a nil-block operator L reducing to e²Phi.
It is additive/deck-equivariant, not assumed to have one semilinearity.

The normal expansion modulo p³ is

    E/p=delta S-P(X)+p Q(X,S)+p² R.                   (17)

No nonlinear CURVE term occurs before p³ in E: a quadratic p² curve
gluing starts in p4, loses at most one p in Frobenius discrepancy;
quadratic Taylor variation starts at p³ and the new graded jet adds
no division. The earlier quadratic NORMAL graph term is

    Q=Mlin22(X) S_i-Mlin11(X) S_j-m12^0 S_i S_j,        (18)

where Mlin is the additive transition variation after its first p.

Take integral X0 in e23 lifting d e23+b e24 and first repair A in
e23. The linear error delta A-P(X0) is divisible by p, integrally
in e23. By(15) its divided reduction is in e5. Cancel its cohomology
with a next curve digit X1 in e³ and normal primitive B_lin in e³.

Separately Q(X0,A) mod p is in e22. Cancel its class using a curve
digit Y in e20 and normal primitive B_quad in e20. Thus choose

    X=X0+pX1+pY, S=A+pB_lin+pB_quad.

By(7), modulo p² write Q=Qsharp+pQ', Qsharp integrally in e22,
Q' mod p in e². Then Z=delta B_quad-P(Y)+Qsharp is divisible by p
and lies in e20, so Z/p mod p is in e5 by(15). Both this divided
quadratic carry and Q' vanish in D. Other final normal contributions,
WITHOUT any further division, are in these images:

    first*second: e23 A1 * e³ A1⊂e² A1;
    cubic firsts: e21 A1;
    quadratic curve/Taylor: e22 A1;
    preceding scalar change: e23 A1;
    two second repairs: absent modulo p4.

Reference operators/Frobenius preserve these images. Consequently

    Theta_t(d,b)=-[L(X0+5X1)/25] in D.                 (19)

The p²R remainder includes the preceding scalar, graded-restoration,
coordinate and Taylor contributions just bounded. The prescribed
filtered/graded morphism has no lower-left division of a raw graph
error; its construction and the oper normalization account for all
previous-tuple terms. This is the geometric content beyond the
finite-ring tests.

## 4. Exact linear residue

Put Atilde=L Phi^-1=e²I+5C, C arbitrary additive deck-equivariant.
Write (1+e)^25-1=e25+5Q(e)+25P(e), with
Q mod5=e5+2e10+2e15+e20, P(0)=0, [e]P=1. For D=Phi(dhat),
B=Phi(bhat), set y0=D e23+B e24 and

    y1=(D+B e)Q/e²-e21 C(D)-e22 C(B).

Then y1 is in e³ and exact substitution gives

    Atilde(y0+5y1)=25(-(D+B e)P+C(y1)).                (23)

C(y1) is in e³, so the last two coordinates after division are
(0,-d5). By(19), Theta=(0,d5). One coefficient Frobenius occurs on
d; X1=Phi^-1(y1) does not add another in the residue. Parameter
dependence occurs only in discarded corrections. Free compatible
fourth digits give once-divided e23 carry in e5, hence do not change
Theta; free fifth smooth digits give Psi-images. Theta(0,0)=0.

## 5. Checks and finite-level consequence

The supplied script was inspected and rerun locally:625 integral
product pairs,25 pure leading digits with all free fourth digits,
and200 mixed-additive W3(F25) cases PASS. Its quadratic coefficient
ring is (Z/125)[a]/(a²-2), Phi(a)=-a, distinguishing d5 from d25.
The supplied script contains no jet-recursion test. The independent
standard-library script verify_cyclic25_jet_precision.py checks K2,K3,
the K5 entry, r1/r2 precision and factorial-tail bounds through20000.
It also passes; these checks concern the universal jet polynomials,
not the global normal-gluing argument of Sections1--3.

By(19), Theta=0 iff d=0. Every compatible third lift has a compatible
fourth extension: its first linear divided carry lies in e5 and its
ordinary quadratic products in e22, both killed in D. The next class
is independent of the free compatible fourth digit as noted above.
Thus Theta=0 is exactly existence of a compatible fifth extension.
The cover of C3^0+b e_C along the
original h pulls back to GIVEN T3(0,b), since h*e_C=e24. This is
third-truncation descent from compatible W5, not fifth-truncation or
all-level descent. Uniqueness of Hodge lines matches the full tuple;
the marked finite-etale cover is transported through the isomorphism
of curve lifts, not replaced by another map. Section0 proves the
stated genus-independent scope.

## Sources and evidence

The local filtered/graded construction is
[LSZ Lemmas4.7,4.10 and Proposition4.11](https://arxiv.org/html/1311.6424v4).
The higher Taylor gluing and obstruction construction are in
[LSYZ, current v2 Section6](https://arxiv.org/html/1404.0538v2),
including formula(6.0.1); earlier versions use Section5 numbering.
The new integral-product and geometric cancellation argument is
Sections1--3 here, not a quoted theorem of those papers.

[Statement](../Theorems/Thm_cyclic_twentyfive_initial_descent.md) ·
[Focused audit](../Research/audits/CYCLIC25_INITIAL_COMPARISON_AUDIT_2026_09_10.md) ·
[Supplied exact certificate](../scripts/check_hodge25.py) ·
[Independent jet check](../scripts/verify_cyclic25_jet_precision.py).
