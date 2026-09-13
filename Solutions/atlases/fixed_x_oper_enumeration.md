# Proof: cubic symmetry and length exhaustion

[Statement](../../Theorems/atlases/fixed_x_oper_enumeration.md). Work over the
specified F25, and base change to its algebraic closure when counting
geometric points. The [scalar chart theorem](../../Theorems/connections/fixed_x_dormant_equations.md)
gives the independent total length29375. We construct disjoint finite
quotients of the local algebras whose lengths already sum to that value.
The [length-exhaustion lemma](../../Theorems/atlases/finite_algebra_completion_certificates.md)
then makes every quotient exact and excludes additional points.

## 1. The reduced open contribution

Substitute the recorded normalized coordinate polynomials modulo the
squarefree degree19290 polynomial P. Direct monic division verifies the
three original normalized differential identities. The coefficient-field
element h_zeta satisfies h_zeta^2+4h_zeta+2=0, the separator a9 is z, and
gcd(lambda,P)=1. Thus the specified F25 algebra has9645 distinct geometric
points. Adjoining t with t^3=lambda gives28935 distinct original opers:
C=t Chat, A=t^2 Ahat and c4=t!=0. Each contributes length at least1.
This construction assumes no prior completeness or length of the
normalized scheme, nor any description of c4=0.

The12 factors are checked by multiplication and irreducibility. An
irreducible F5 factor of degree2d, with the specified h_zeta embedding,
defines one F25 closed point of degree d. Counting all2d roots without
fixing h_zeta=a would double-count the coefficient-field conjugate.

## 2. Cubic symmetry gives the invariant local models

The2854-byte [center description](../../Research/computations/invariant_oper_centers.json)
contains a squarefree degree55 H(b), eight polynomials B_i(b) with B7=b,
and six irreducible factors of degrees1,1,2,9,19,23. Direct substitution
in all96 original quadrics verifies55 distinct centers(B0,0,0).
No claimed Groebner basis or old local length is used.

At each closed center, split the freshly computed Jacobian into its
B,C,A blocks. Their ranks are8,5,8; the total rank is21. Normalize an
A-block kernel basis so three free A coordinates are t0,t1,t2. Its
product with the original matrix is zero and its rank is3. Call the
corresponding linear polynomial A1(t).

The actual deck weights of(B,C,A) are(0,1,2). Give each t_i weight2.
This suggests the finite ansatz

    A=A1(t), C=C2(t), B=B0+B3(t), deg(A1,C2,B3)=(1,2,3).

Five independent C-block rows uniquely determine C2 from the quadratic
A1 source. The remaining quadratic equations span three independent
forms Q1,Q2,Q3. Their linear multiples have rank9 among the ten cubics;
their quadratic multiples have rank15 among all15 quartics. Consequently

    Q=(Q1,Q2,Q3) contains(t0,t1,t2)^4,
    Hilb(k[t]/Q)=(1,3,6-3,10-9)=(1,3,3,1).

The zero-dimensional ideal has three generators in three variables,
so it is a complete intersection. This is an exact homogeneous rank
calculation, independent of formal-elimination stabilization.

Eight independent B-block rows determine B3. Substitute all24 coordinates
(B0+B3,C2,A1) into EVERY original equation. Its constant and linear terms
vanish; its quadratic part lies in span(Q_i), and its cubic part lies in
span(t_j Q_i). Higher terms vanish because Q contains all quartics.
After geometric base change this defines a surjection from the actual
local oper algebra onto k[t]/Q: the three free A coordinates recover all
generators. Hence each of the55 geometric centers has local length at
least8. The map is equivariant for the actual deck action.

The verifier also checks c4=C2,4 explicitly. Adding this quadratic raises
the relation rank from3 to4 in degree2; its linear multiples raise rank9
to10 in degree3. Its principal ideal therefore has dimension2. These
checks read no saved formal coordinates, residual equations, exceptional
slice basis or local multiplicity table.

## 3. Exhaustion, the exceptional slice and the full quotient

The disjoint contributions have lower length

    28935+55*8=29375.

Equality with the independent total length excludes every additional
point and makes all lower bounds equalities. Each invariant local
surjection is an isomorphism; each non-invariant point is reduced.
Thus c4=0 has exactly the55 invariant points, each of slice length8-2=6,
and total length330. Setting A=C=0 kills the three free local parameters,
so the fixed-point scheme itself is reduced of length55.

At a fixed point, all three parameters have weight2 modulo3. The invariant
graded pieces are exactly degrees0 and3. The latter is one-dimensional
and square-zero, giving k[epsilon]/(epsilon^2). On c4!=0 the action is free,
and each orbit contains three reduced points. Since3 is invertible,
invariants commute with field extension. The full quotient therefore has
9645 simple points and55 double points:9700 points and length9755.

## 4. Monic reconstruction of the entire normalized chart

Use F and L_j from the scalar equation proof. The coefficient of x^28
in the third original numerator equation is2c4^2-2a10; hence a10=c4^2
over every parameter algebra. On c4!=0 set t=c4, C=t Chat, A=t^2 Ahat,
lambda=t^3. The two hatted polynomials are monic of degrees4 and10.
Put

    Nbase=2F''F+2(F')^2+2x^8F,
    T=(L_2(Ahat)-Nbase*Ahat-3F^2*Chat^2)/F,
    T=B*Ahat+e2, deg B<=7, deg e2<10,
    N0=Nbase+FB,
    W=F*(Chat*F)''-N0*Chat,
    lambda=2[x^20]W,
    e1=W-3lambda*Ahat^2,
    e0=(L_0(N0)-3N0^2)/F^2-lambda*Chat*Ahat.

The indicated divisions by F and F^2 are exact; leading terms cancel
so deg T<=17 and deg W<=20. Division by the monic Ahat defines B and
e2 uniquely, without any parameter inverse. Equating all coefficients
of e0,e1,e2 to zero gives44 equations of maximum degree16 in the14
lower coefficients of Chat,Ahat. The [generator](../../scripts/atlases/opers/normalized_oper_quotient.sage)
checks these universal identities by exact polynomial division.

Starting with an original solution, its third equation forces B and e2=0;
its second forces the displayed lambda and e1=0; its first is e0=0.
Conversely, these identities reconstruct every original equation after
adjoining an invertible t with t^3=lambda. All divisions are monic and
valid over parameter algebras, so this is scheme-level equivalence.

It remains to show lambda is a unit before adjoining an inverse. A
geometric zero with lambda=0 makes e0 the invariant dormant B equation.
The census just proved that this scheme consists of the55 reduced centers.
At each, e1 says that the homogeneous C-block kills Chat. Its rank is5
by the local verification, so Chat=0, contradicting its monic coefficient.
The Nullstellensatz gives(lambda,e0,e1,e2)=(1); lambda is therefore a unit
in the entire14-variable quotient, including its possible nilpotents.

Adjoining its cube root is finite etale of degree3. The established open
oper scheme thus identifies this entire quotient with its reduced
9645-point cubic quotient. The separator map to F5[z]/P is consequently
an isomorphism. Completeness is a conclusion here, not an input in Section1.

## 5. Exact enumeration and the18 atlas representatives

For a normalized closed factor f of F25 degree d, choose alpha with
f(alpha)=0 and h_zeta(alpha)=a, then beta^3=lambda(alpha). All its original
tuples are

    alpha_j=alpha^(25^j), t_(j,b)=rho^b beta^(25^j),
    (B,C,A)=(B(alpha_j),t_(j,b) Chat(alpha_j),t_(j,b)^2 Ahat(alpha_j)),
    0<=j<d, 0<=b<3.

Distinct j have distinct normalized a9; distinct b have distinct c4;
different factors are coprime. Changing alpha or beta permutes this same
list, whether the cubic root already lies in the residue field or not.
The [compact census](../../Research/computations/complete_oper_solutions_README.md)
specifies every index and multiplicity without repeated coordinate rows.

Both the curve and the untwisted atlas problem are defined over F25.
Frobenius connects the d conjugates; precomposition by y->rho*y connects
the three cubic branches. These operations preserve actual finite etale
maps, so12 normalized and six invariant representatives suffice. Every
quotient choice remains quantified. A torsion twist is transformed too;
it cannot silently be fixed. No other cored case or coreless branch is
excluded by this symmetry argument.

## Evidence and replay

Run `sage scripts/atlases/opers/verify_oper_census.sage --out NEW_DIRECTORY` with the
three usual BLAS/OpenMP thread variables set to1. The full2026-09-13 replay
passed in22.438seconds, including all factors and every local model;
receipts are in external `oper-census-quadratic-verification-20260913`.
The new [independent audit](../../Research/audits/OPER_CENSUS_CONSOLIDATION_AUDIT_2026_09_13.md)
also replayed the local construction and universal monic reconstruction.

The earlier [original-input audit](../../Research/audits/NORMALIZED_OPER_ENUMERATION_AUDIT_2026_09_07.md)
checked all43 retained normalized input polynomials independently of
the differential rewrite. Its original evidence remains unchanged.
The frozen normalized algebra file is hash-linked by later atlas
certificates; its old length-dependency metadata is historical. The
current verifier regenerates and compares P, all coordinates, B and
lambda byte-for-value, and uses only the acyclic exhaustion proof above.
The standalone parametrization producer now claims construction only.
No discovery basis is required and no software check is Lean verification.
