# Unbounded double-zero etale leaves on one fixed genus-seventeen curve

Author: /root, 2026-09-06. Status: independently audited PASS relative
to the retained audited Igusa construction; auditor
/root/genus17_unbounded_hecke_boundary_audit, 2026-09-06.
[Audit record](audits/GENUS17_UNBOUNDED_HECKE_BOUNDARY_AUDIT_2026_09_06.md).
This is a robustness counterexample to a UNIVERSAL degree-bound strategy,
not a counterexample to Litt and not a realization on the fixed g9/g25 pair.

## Statement

Over the algebraic closure of F5 there is a fixed genus-seventeen curve P
with a regular Cartier-fixed form alpha whose divisor is 2D, D reduced,
and jointly minimal coreless finite etale correspondences

    P <-f_n- W_n -g_n-> P,       n>=1,
    deg f_n=deg g_n=12*11^(n-1),
    g(W_n)=16*(12*11^(n-1))+1,
    f_n^*alpha=g_n^*alpha.

Consequently neither uniform double zeros, fixed endpoints, joint
minimality, corelessness, nor fixed prime support in the degrees suffices
for a universal degree bound. This directly tests the double-zero quotient
surface construction, rather than merely excluding the original Igusa
example's genus or zero order.

## 1. A partial Igusa quotient gives double zeros

Use the [audited quaternionic Igusa construction](IGUSA_TANGO_COUNTEREXAMPLE_AND_RETAINED_SECTION_BOUNDARY.md):
C is the discriminant-six, tame-level V1(7) curve, of genus five. Its
full level-one Igusa cover I->C has group F5^*, degree four, and total
tame ramification four at sixteen supersingular points. Its regular
form eta=dlog q is Cartier-fixed and has divisor 5S, with S reduced.

For the diamond transformation taking the Igusa generator to c times
it, the canonical Hodge section sigma transforms by c (or its inverse
under the inverse diamond convention). Thus eta, obtained from sigma^2
by the polarized Kodaira--Spencer map, transforms by c^2. In particular,
eta is fixed by the order-two subgroup {1,-1}.

Put P=I/{1,-1}. The map I->P has degree two and ramifies precisely at
S, with index two. The invariant rational form eta descends to alpha
on P. Tame differential pullback gives, at every ramification point,

    5=2 ord(alpha)+1,

so alpha has zero order two. Elsewhere the quotient is etale and eta
has no zeros or poles. Therefore div(alpha)=2D, with D consisting of
sixteen points. Cartier commutes with separable pullback and is injectively
tested upstairs, so C(alpha)=alpha. Riemann--Hurwitz for P->C gives

    2g(P)-2=2*(2g(C)-2)+16=32,

and hence g(P)=17.

## 2. All powers of the same Hecke prime

For n>=1 let H_n be the fine quaternionic curve of tame level
V1(7) intersect V0(11^n). It parametrizes cyclic false-degree-11^n
isogenies. Its two maps a_n,b_n to C are finite etale of degree

    d_n=#P^1(Z/11^n Z)=12*11^(n-1).

These are the same etale change-of-level and geometric-connectedness
facts used in the audited construction, now at prime-power level;
see [Buzzard, Theorem2.1 and Propositions2.4--2.5](https://www.ma.imperial.ac.uk/~buzzard/maths/research/papers/shimura.pdf).
The target map uses dual isogenies and the induced adjustment of tame
level, so has the same etaleness and degree.

A prime-to-five isogeny transports the Igusa generator modulo sign over
the entire compact curve. Thus

    W_n=H_n x_(a_n,C) P = H_n x_(b_n,C) P.

It is connected: over any supersingular point of H_n the degree-two
cover has a single underlying point with total ramification two.
Every component of a finite flat cover of a connected smooth curve
dominates the base, so that fiber rules out multiple components.
Both maps to P are finite etale. Since 11^n=1 modulo five, the isogeny
identifies the framed five-torsion Kummer classes on full Igusa covers,
as in the audited case n=1. Their logarithmic forms therefore agree.
Descending the sign quotient gives f_n^*alpha=g_n^*alpha on W_n.

## 3. Joint minimality and corelessness

The audited construction proves End^0_(O_D)(A)=Q for the geometric
generic false elliptic curve. If two cyclic false-degree-11^n isogenies
between the same two marked objects existed, their ratio would be a
rational scalar. Equal degrees force this scalar to be 1 or -1.
The latter cannot carry the same level-seven generator to the same
target generator. Hence the isogeny is unique. The generic joint map
H_n->C times C, and likewise W_n->P times P, is therefore injective.
The joint map is also generically separable, since either projection
is etale. Thus generic injectivity implies birationality, and
k(W_n)=f_n^*k(P)g_n^*k(P): the span is jointly minimal.

The same endomorphism argument makes the targets of distinct cyclic
false-degree-11^(mn) quotients distinct. Decomposing such a quotient
into an EVEN number m of cyclic 11^n steps produces unbounded endpoint
sets in one alternating correspondence component. On a reversed block
psi, label its new vertex using (psi^t)^(-1)=11^(-n)psi on tame torsion.
The labels are valid level-seven generators; the underlying targets
are unchanged and remain distinct. On five-torsion, 11^n=1 makes the
reversed Igusa transport compatible as well.
A common nonconstant function would confine those sets to finite fibers.
Thus the two fields of C in k(H_n) intersect only in k.

Both Cartesian pullbacks defining W_n are connected fields of degree
two over k(H_n). The full Cartesian field lemma in the audited note
therefore transfers corelessness to the two P fields in k(W_n).
Finally etale Riemann--Hurwitz gives g(W_n)=16d_n+1. QED.

## Consequence for the quotient-surface route

Apply the [double-zero quotient construction](DOUBLE_ZERO_PCLOSED_QUOTIENT_DISCREPANCY_AND_KLT_MODEL.md)
to the FIXED pair (P,alpha),(P,alpha). It produces a single fixed klt
surface Q' with ample K. The images Gamma_n of the above leaves have

    K_Q'.Gamma_n=(17/5)*16d_n,
    2g(Gamma_n^nu)-2=32d_n.

Their degrees are unbounded. Hence the computed klt singularities,
ampleness, volume, and genus/degree ratio cannot alone give the desired
bound. The example does not impose Hom(JX,JY)=0, distinct endpoints,
or the arithmetic properties of the proposed g9/g25 pair. Any further
argument using those hypotheses must identify where they enter.

## A second, one-endpoint stress test (root computation, not in the audit)

Uniform double zeros and nonzero Cartier eigenvalue do NOT by themselves
force an elliptic quotient, even on an ordinary curve. For example,

    C0: y^2=x^5+x^3+2x+2

over F5 has genus two, absolutely simple Jacobian, and alpha=dx/y with
div(alpha)=2P_infinity. Its Cartier matrix, in the basis dx/y,x dx/y, is

    [4 4; 0 2].

Thus the curve is ordinary and C(alpha)=4alpha; over the algebraic closure
one can rescale alpha to be Cartier-fixed. There is no nonconstant map
from C0 to an elliptic curve, since such a map would give an elliptic
factor of its Jacobian.

Here is an exact certificate for the simplicity assertion. The defining
quintic is squarefree, and its square is

    x^10+2x^8+4x^5+4x^4+4x^3+4x^2+3x+4.

Point counts are #C0(F5)=5 and #C0(F25)=31; over F25 the quintic takes
zero, nonzero-square, and nonsquare values 0,15,10 times. Consequently
the Weil polynomial is

    P(T)=T^4-T^3+3T^2-5T+25.

It is irreducible modulo two (Phi_5), hence over Q. Direct resultant
calculation gives

    Res_T(P(T),P(zT))
     =390625 (z-1)^4
       (z^4+z^3+(49/25)z^2+z+1)
       (z^4+(7/5)z^3+z^2+(7/5)z+1)^2.

Both nontrivial quartic factors are irreducible: clearing denominators
gives primitive polynomials reducing to Phi_5 modulo two. Their monic
forms have nonintegral coefficients, so neither is cyclotomic. Thus
no ratio of distinct Frobenius roots is a root of unity. For every n,
the four conjugates of a root pi have distinct n-th powers, so
[Q(pi^n):Q]=4 and the Frobenius polynomial over F_(5^n) stays irreducible.
The Jacobian is therefore simple over every finite extension, hence
absolutely simple over the algebraic closure.

The point counts, matrix, and resultant were computed exactly in Sage;
the displayed identities supply a short reproducible certificate rather
than sampling over extension fields. This is only a ONE-ENDPOINT test:
no second etale leg on C0 is asserted. It prevents repairing the failed
universal bound by declaring every double-zero eigenform elliptic in origin.
