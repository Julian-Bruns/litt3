# Proof: finite-abelian late descent

Version2, 2026-09-13. Author /root; independent consolidation audit PASS
by /root/audit_late_consolidation, with no outstanding objections.
[Statement](../../../Theorems/deformations/abelian_covers/abelian_power_late_descent.md).
The three earlier audits and original returned nodal proof remain
retained; this is prose verification, not Lean verification.

## A reusable image lemma

Let q be a power of the characteristic and
R_q=k[x1,...,xr]/(x1^q,...,xr^q), over an infinite field. If f has
multiplicity d<q, then

    J^(d+(r-1)(q-1)) subset(f).                       (I)

Choose a linear direction with nonzero degree-d coefficient and apply
formal Weierstrass preparation in that direction u. Dividing by a unit
gives u^d+a_(d-1)(v)u^(d-1)+...+a0(v), where ord(a_i)>=d-i.
The ideal of qth powers is preserved by every formal coordinate change.
Reduction to u-exponent<d never lowers total degree; the remaining
monomials have degree at most d-1+(r-1)(q-1). Reduction terminates
because the other exponents strictly increase and are truncated at q.
This proves (I). For d=2,q=5,r=2 it gives F2=J6 subset(f); for q>=25
it gives F4 subset(f), independently of the rank or quadratic type.

For r=3,q=5 and f=uv+w^s, 2<=s<=4, use uv=-w^s. A monomial of
degree>=8 with both u,v present reduces without lowering degree until
one is absent or w^5 divides it. A surviving monomial with one absent
would have to be u4w4 or v4w4 (all larger degrees already vanish).
But u4w^s=v4w^s=0, since multiplying f by u4 or v4 kills the uv term;
hence these monomials vanish too. Thus J8 subset(f). For s>=5 the
pure-node quotient has u4w4 nonzero, so this boundary cannot be dropped.

## One norm argument for every finite abelian group

For any additive deck-equivariant L:O[G]->O[G] reducing to f Phi,
transport Phi once and write L=M_F+5D with F an augmentation-zero lift.
Extend coefficient maps only over Z/5^(A+1)[zeta_(5^bmax)], so they
commute with character values and preserve valuation; do not assume
commutation with arbitrary Witt coefficients.

For a character of exact order 5^c, epsilon_c=vp(zeta_(5^c)-1)<=1/4.
The least-valuation generator differences have ratios in F5, not all
zero. Thus vp(F(chi))=2 epsilon_c. The ordered perturbation inverse has
positive gain 1-2 epsilon_c. Consequently, for 1<=s<=A+1,

    Lx=Neta mod5^s => vp(xhat(chi))>=s-2 epsilon_c
    for every nontrivial chi.                         (N0)

Undivided Fourier inversion is |G| x(g)=Tr(x)+sum_(chi!=1)chi(g)^-1
xhat(chi). At s=A, (N0) and unramified valuation discreteness put
Tr(x) in5^A O. Three augmentation differences add at least
3 epsilon_c in each character, giving 5^A J3x valuation>A; hence
xbar in F2. At s=A+1, one difference gives valuation>A, hence
xbar in kN. The induced trace operator L_tr reduces to zero, so
L_tr(5^A O)=0 in O. Tracing the full equation gives etabar=0. Therefore

    Lx=Neta mod5^A => xbar inF2 and Tr(x) in5^A O;
    Lx=Neta mod5^(A+1) => xbar in kN and etabar=0.      (N)

These bounds concern the full integral repair and require no common
lower bound on epsilon_c as conductors grow. The perfect top-degree
pairing gives F_d=J^(S-d). For POINTWISE products, each deck difference
satisfies (g-1)(ab)=((g-1)a)b+a((g-1)b)+((g-1)a)((g-1)b).
After i+j+1 differences, every summand has more than i differences on
the first factor or more than j on the second. Hence F_i F_j subset
F_(i+j). This proof works for every group here and separates pointwise
torsor multiplication from multiplication in the group algebra.

## The binary homogeneous improvement

For G=C5^2, Lx=Neta mod25 and etabar=0 force xbar inF1. Both Bockstein
calculations below use the original rational-direction coefficients; an
arbitrary formal coordinate change does not preserve rationality.

Preparation and square completion are performed inside the ORIGINAL
group ring. If f=v0*f_prepared for a unit v0, multiply the integral
target operator by a lifted v0^(-1). Since aN=aug(a)N, its norm right
side becomes N*aug(v0^(-1))*eta. This rescales eta by a unit and preserves
etabar=0. It preserves additivity and deck equivariance, and all higher
corrections remain allowed. A formal coordinate substitution is an
expression in the original ring, not a new rational deck action.

If Q is nonsingular, take f=uv in formal coordinates. The possible
leading terms in J6 intersect Ann(f) are u4v2,u2v4,u4v3,u3v4,u4v4.
For u=alpha e1+beta e2+O(J2), v=gamma e1+delta e2+O(J2), Delta!=0,
the transverse coefficients of U5/5 and V5/5 are
b*=(alpha5 beta-alpha beta5)/Delta and
c*=(gamma delta5-gamma5 delta)/Delta. Both are nonzero by irrationality
of the two tangent branches. Divide the genuine equation by5 and
project modulo uv. Free first repairs and arbitrary additive corrections
vanish there. The first two coefficients give independent v4,u4 terms,
forcing them to zero. Also R/(uv) has J5=0, retaining nodal F3 subset(f).

If Q has rank one, square completion gives f=u2+g(v), ord(g)>=3.
The possible leading terms are Au3v3+Bu4v2+Cu3v4+Du4v3+Eu4v4.
Write U5/5=a u+b v+O(J2) modulo5. Here the same original-deck
formula gives b=(alpha5 beta-alpha beta5)/Delta!=0. Projection of the
divided equation has degree-four part bA v4+(aA+bB)uv3. These two
classes are independent in gr4(R/(u2+g(v))), so A=B=0. Terms of g
start in degree9 before division; a single carry drops degree by at
most4, hence they enter only in degree>=5. Free repairs, divided higher
norm and additive corrections lie in J6 subset(f), by (I). This proves
the same F1 conclusion without a discriminant assumption.

## The common geometric mechanism

Put m=n-1>=A. Choose a smooth auxiliary lower curve through W_(n+A+1),
lift the ORIGINAL cover and extend its genuine input oper; keep its
compatibility error. The source difference 5^(m+1)/5^(m+A+2) is
square-zero. Graph changes start at5^m; compare the actual output modulo
5^(m+A+1). The required all-digit comparison is Sections1–5 of the
retained cyclic-power proof, whose precision, scalar, regular-section
and Schur arguments use only these group-independent hypotheses.

Explicitly retain every linear Taylor degree j with
j-1-v5((j-1)!)<=A. Second displacement variations start at2m+1 and
vanish at this precision. Nonlinear scalar normalization gains25.
Write r_actual-r_aux=5^m R. The preceding scalar is solved modulo
5^(A-1) from the SAME-graph ordered recurrence
R=V+A(X)+D(u)+K_r(R), with K_r gaining25, through every required digit.
Integral boundary elimination and ordinary-block Schur elimination are
performed before taking the obstruction quotient. Thus the last equation is

    Lx=Neta+1_(m=A)5^A B_actual mod5^(A+1),           (G)

where Lbar=f Phi and etabar is the actual lower next obstruction.
The first source, Hodge, frame and scalar repairs lie in F_i whenever
xbar does: use deck-linear sections, the boundary equation and negative
H0. Hence their actual quadratic pointwise products lie in F_(2i).

If m>A, apply (N) directly. If m=A and F4 subset(f), reduction of (G)
mod5^A first gives F2; its quadratic is F4 and is absorbed by a terminal
5^A source correction. This preserves the given leading digit, and the
full (N) applies.

For the exceptional binary boundary A=m=2, first get F2 and integral
trace25. F4 has zero pointwise trace, so tracing (G) gives etabar=0.
The homogeneous Bockstein then gives F1, whose quadratic is F2 subset(f)
by (I). Absorb it at the terminal digit and use the full norm again.

All leading coordinates are invariant and thus are pullbacks of a
unique lower tangent vector. Its ordinary equations and etabar=0 give
a compatible lower next curve. The genuine global Hodge line and fixed
grading/twist extend full periodicity: the scalar correction starts at
5^m and changes inverse Cartier only at5^(m+2), beyond W_(m+1).
Finite-etale lifting and negative tangent H0 identify the lifted original
cover with the GIVEN upper truncation, including its full marked tuple.
Induction uses further given levels, so a full tower descends once its
specified initial lower stage has descended. No earlier stage is supplied.

## Actual covers and evidence

The actual A1/A3 germs and every cyclic quotient defect2 are established
by [abelian flags](abelian_defect_flags.md),
[the parameterized A3 germ](bad_double_abelian_a3_family.md), and
[the backup germs](backup_active_double_germs.md). These give the
stated31-plane, rank125 and balanced-power applications for all ten
main branch and twelve backup bad doubles. Rank125 uses s=2 or4 and
n>=4; balanced powers use (I) and n>=rb+1; every binary plane uses
n>=3. Defect2 in every ORIGINAL cyclic direction verifies Q(v)!=0:
otherwise the restricted scalar order and cyclic defect would be at
least3. Formal coordinates verify only the image condition.
Integral regularity lifts from actual negative cohomology by finite-level
Nakayama; a free cohomology quotient admits a deck-linear section.

The common all-digit comparison is
[the cyclic-power proof, Sections1–5](../cyclic_descent/cyclic_power_descent.md).
The invariant recovery uses the actual reference complex before taking
its obstruction quotient, retaining all maps, markings and tuple data.

Independent audits:

- [Unified proof and new image lemma](../../../Research/audits/LATE_DESCENT_CONSOLIDATION_AUDIT_2026_09_13.md).
- [Original nodal comparison](../../../Research/audits/NODAL25_LATE_DESCENT_AUDIT_2026_09_13.md).
- [Elementary extension](../../../Research/audits/ELEMENTARY_ABELIAN_LATE_EXTENSION_AUDIT_2026_09_13.md).
- [Doubled tangent and balanced powers](../../../Research/audits/DEGENERATE_QUADRATIC_AND_BALANCED_LATE_AUDIT_2026_09_13.md).

The original nodal return is unchanged in
`../litt3-computation-data/nodal25-descent-return-20260913-8elkxl/nodal25_output`.
Its [return receipt](../../../Research/computations/nodal25_return_replays_20260913.json)
records the attachment hash, all9 manifest checks and both exact replays:
24 mixed-additive models, symbolic identities,380 branch tests and Taylor
inequalities. The [elementary checks](../../../Research/computations/elementary_abelian_late_extension_checks.json)
and [48 doubled-tangent checks](../../../Research/computations/degenerate_quadratic_late_checks.json)
remain original evidence. The new audit independently checks s=3 and
the s=5 boundary. Finite models support the arguments; they do not
replace the uniform proof or the genuine geometric comparison.
