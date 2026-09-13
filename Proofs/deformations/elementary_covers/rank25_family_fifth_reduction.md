# Actual fifth comparison, filtered support and calibration

[Statement](../../../Theorems/deformations/elementary_covers/rank25_family_fifth_reduction.md).
This proof consolidates the accepted relative, fixed-point, curve, surface
and universal-trace arguments. The geometric support and finite identities
have separate independent audits listed in §8. The original evidence is
retained. This is prose and exact computation, not Lean verification.

## 1. Relative variation and the complete quotient

Use the original marking, flat line, regular frames and full matrices of
[the fourth-locus proof](rank25_fourth_locus.md). The accepted fourth
numerator includes ordinary and coefficient-Frobenius carries and the
ordered mixed expression

    z*(A11_i*U_j-O_i*A22_j)+z*Dz*O_i*U_j.

For integral parameter lifts X,Y=Phi(X), replacing X by X+5*beta changes
Y by5*Phi(beta). The first Hodge graph, at flat order5, acquires the
order25 repair. At flat precision625 its two cross terms with the old
first repair survive, whereas its square is zero. These cross terms are
the arithmetic polarization of the previous quadratic expression,
including the factor2 on squares. The divided linear carry gives the
linear part of J=dE/dy; the ordinary source response is Lambda*N*beta=0.
Consequently the entire new response is J(x^[5])*beta^[5].

For each actual nu_i, the primary cochain A_C*nu_i^5 is split into an
affine polynomial and z^2 times a WHOLE regular formal function. These
are the two genuine relative Hodge repairs. The preceding oper scalar
is needed modulo25 and does not change at that precision under a new
order25 repair. There is no extra coefficient Frobenius. The inherited
weight bounds also kill the relative variations of higher source/Taylor
terms, although their absolute terms are needed below. Unit pivots and
Wronskians congruent to1 leave no excluded beta chart.

Changing the actual fourth reference adds J*gamma^[5]. A final smooth
fifth digit adds -M*chi^[5] before projection; changes of regular frame
lifts add normal coboundaries. Frobenius is surjective on geometric
coefficients, so solving the quotient equations is sufficient as well
as necessary for an actual fifth lift.

The four rows in(2) of the statement annihilate J. On s!=0, its minor
with rows(1,2,3,7,8), columns(1,2,5,7,8) equals

    t^3*det(D)*det(Ktop)*s^4 !=0.

Thus the four independent rows give the entire cokernel. On every
boundary, the nonzero (E1,E2)/(y3,y4) and Btop minors give the analogous
criterion(3), with all three boundary variables free. The new critical-
Hessian argument explains the uniform rank and quotient geometrically;
these original transverse blocks specify its concrete coordinates.

The fourth-digit trace identity is an exact adjoint calculation. The
fixed row ell satisfies ell*M=lambda0^[5] and, on the complete candidate
plane, ell*R4=2031*E1+1230*E2. Its ordinary-X coefficients vanish.
For any compatible digit M*zeta^[5]=R4, this says
(lambda0*zeta)^5=0. Injectivity of Frobenius proves lambda0*zeta=0
uniformly, rather than by checking particular fourth solves.

## 2. The absolute comparison and its required precision

Absolute fifth constants are computed over
R5=(Z/3125)[T]/(T^4+4T^3+T^2+4T+3), with Witt Frobenius

    Phi(T)=122+1363*T+2775*T^2+2385*T^3.

Simultaneous Hensel lifting transports affine generators, horizontal
branches and Phi(H). The source exponential retains orders1 through5;
the fourth and fifth terms in the fixed first displacement both have
weight625/24. Form the fifth numerator before dividing by5.
The actual repaired oper P_prev is reconstructed modulo25. For

    A_U=((0,-g),(-25*P_prev*g,0)),
    K0=I, K_(j+1)=5*partial_z(K_j)+A_U*K_j,

the weighted Taylor sum keeps K_j/j! through j=5, with
K5/5!=(K5/5)/24. The bounds v5(K_j)>=j-1 and
j-1-v5(j!)>=4 for j>=6 justify the flat625 truncation. The surviving
source/Taylor terms of orders4 and5 use only the fixed first digit;
they contribute to the constant and are not discarded.

First repaired frames are lifted as actual affine functions through625.
In the fourth repaired frames the normal class is the upper-right entry
of z*(I3O^-1*G4*tau(I3U))/125 modulo5. A separate original-frame check
uses the Riccati numerator

    N01+N00*tau(lambdaU)-lambdaO*N11-lambdaO*N10*tau(lambdaU),
    lambda_i=5*a_i+25*b_i.

This retains both mixed Hodge corrections and their product. Formal
primitives are whole regular quotients after exact pole cancellation;
finite Laurent windows certify required coefficients, not infinite
regularity on their own. These are the same filtered/graded operations
used in the actual W4 construction.

## 3. Filtered regular primitives and integral trace

Let F_d be total AS degree<=d in w1,w2. Chart transitions are translations
by base functions, so each associated graded piece is a trivial bundle.
After tensoring with T_C, of degree-2, the quotient has no global section.
Therefore H1(F_d⊗T_C) injects into H1(h_*O_T⊗T_C). An exact normal cochain
of degree<=d consequently has actual affine and regular formal primitives
of degree<=d. Apply this to the COMBINED normal cochain before choosing
its primitives; the primitives admit regular integral lifts on each patch.

The integral horizontal algebra is
R5[s1,s2]/(s_i^5-sum_j Htilde_ij*s_j). Multiplication-matrix traces give

    Tr(1)=25, Tr(s_i^4)=20*Htilde_ii,
    Tr(s1^4*s2^4)=16*Htilde11*Htilde22+24*Htilde12*Htilde21,
    Tr(F3)⊂25R5, Tr(F7)⊂5R5.

Modulo5 only s1^4*s2^4 contributes, with trace det(H)=4. But the divided
traces (Tr(s1^4)/5,Tr(s2^4)/5) reduce to(3410,4010), both nonzero.
Ordinary degree bounds cannot be applied after integral division.

At the first higher digit, the horizontal Frobenius defect has degree5
and constant invertible reduced Jacobian. Its first correction raises
AS degree by at most4. The same bound holds for chart conversion and
differentiation. At one extra digit only one correction is inserted, so

    first carry of F_d lies in Ftilde_d+5*Ftilde_(d+4) modulo25.

For d<=3 its trace is divisible by25. Multiplied by flat weight25 this
vanishes modulo625, before the final division by125. A final-weight125
term of residue degree<8 has zero trace as well. Two-carry first terms
are kept separately; this lemma makes no claim about them.

## 4. Complete support and the matched ordinary channels

On the complete candidate plane, write the full75-coordinate fourth
normal polynomial as

    n4(X,Y)=sum_(i=0)^6 X_i*nu_i+W(Y), deg W<=2, Y=Phi(X).

There are fixed linear preimages M*e_i=nu_i in AS degrees
(0,1,1,2,2,3,3). Choose a linear right inverse R on im(M), extended to
the normal space, with R*nu_i=e_i. Use
Z=Phi(zeta)=sum X_i*e_i+R*W(Y); lift this polynomial preserving its sums
and apply the actual inverse Witt Frobenius to the WHOLE vector.
No power such as x^125 is used as inverse Frobenius on arbitrary
geometric parameters.

The ordinary X_i source and its chosen fourth solve have combined
normal class zero. Section3 supplies their actual regular primitive in
degree d_i. Their flat weight25 sector and first carry have trace zero
modulo625; a final-weight125 product with one first repair has degree
at most d_i+3<=6<8 and also has trace zero.

The earliest moving weights are Y at5, ordinary X and Phi(zeta) at25,
and ordinary zeta and Phi(P1) at125, where P_prev=P+5P1. First repairs
are affine in Y; combined second repairs are linear in X,Phi(zeta)
and quadratic in Y. Regular-frame multiplication/inversion through125
uses linear, quadratic and cubic first repairs, linear second repairs
and first–second products. This gives C3(Y)+sum X_i*L_i(Y), with degrees
at most3 and1, before the direct ordinary fourth digit is added.
The moving actual P1 has AS degree<=3 at final weight; the full primary
cokernel annihilates this filtration (the nodal scalar block has
J_AS^5 in its image). Higher source/Taylor terms retain the constant
specified in §2.

There is one possible nonpolynomial carry. The fixed splitting leaves
QW=(I-MR)W=sum_a f_a(Y)*r_a, with f_a of degree<=2 vanishing on the
fourth locus. On the candidate plane, the normal projections of the r_a
lie in the FIXED target plane H0=<e1,e2>. On q!=0, columns1,2 of J span
H0 with determinant4303*Y6^2; on the boundary, columns3,4 span it by
the four nonzero center minors. Hence H0⊂im(J) everywhere.
The integral residual is25*sum f_a_tilde(Y)*sigma_tilde(r_a).
After division by125 its scalar coefficients may be arbitrary arithmetic
functions, but its target stays in H0 and disappears in the ACTUAL
relative quotient. Multiplication by another first repair is beyond
precision. For the trace there is also a direct two-factor argument:
each lifted f_a is divisible by5 at an admissible parameter and each
lifted trace of sigma(r_a) is divisible by5. Their weight25 product is
therefore zero modulo625.

Keep separately the coefficientwise discrepancy125*E_corr(X,Y) between
the actual integral cochain and that fixed lifted splitting. Division
here occurs coefficientwise BEFORE specialization and preserves support.
Its pure-Y part remains cubic; its ordinary mixed part remains in the
computed channels. For the trace the latter is killed by the combined
low-degree argument. No pointwise fourth equation divided by5 is silently
replaced by a polynomial or discarded.

Finally solve the exact adjoint equation ell_all*M=Lambda^[5]. On the
seven moving directions ell_all*nu_i=0, so

    (Lambda*zeta)^[5]=ell_all*W(Y).

Inverse Frobenius on coefficients gives the direct term P2(X), of
degree<=2, in ALL nine rows. Its first row is zero on S_x by §1. This
proves the full support(4); trace alone has pure cubic Frobenius support.

The ordinary mixed terms and P2 are computed in the SAME regular gauge
and origin x=(2130,0,0,3003,0314,0,0,0,0). The engine keeps transferred
and source terms modulo25 before division, both diagonal/mixed graph
terms, and the derivative of the affine first primitive under source
displacement. Fresh precision1000/1400 runs, with changed regular affine
Frobenius in the latter, agree on every ordinary, mixed and direct-fourth
coefficient. An independent Sage check matches all seven linear columns
to J, all28 quadratic normal coefficients, and the independently known
coefficient[lambda^5]Omega*C5=1101. The implementation is
[compute_rank25_ordinary_channels.py](../../../scripts/deformations/rank25/compute_rank25_ordinary_channels.py);
the two full receipts retain all75 normal vectors and actual primitives.
These are coefficient checks within the proved support, not samples
used to infer it.

## 5. Independent actual calibration values

**The fixed W4 witness.** The fifth engine's reconstructed Xi*,rho4 and
zeta_* agree with the original W4 data in all75 coordinates. Both use
the same integral coordinate-function section and source exponential;
the specified Hensel lift is unique, and the new curve reduces to the
old one modulo625. Hodge uniqueness identifies the full tuple, so the
reference shift gamma is ZERO. The computed full c* is therefore the
constant in the original reference, not an unidentified translate.

At x*, J has rank5 and image {v:v0=v7=v8=0,v4=2v3}, giving(7) of the
statement. The independent Riccati trace splits as2340+0220=2010.
The normalized separating row has only entries72,73,74 nonzero,
(1410,0403,1441); it annihilates M and evaluates to1 on the full fifth
normal vector. Two full comparisons at workspaces3600/4200, with changed
affine Frobenius, give identical75-vectors and nine projections, with
certified exclusive normal precisions730/1308.

**The calibration curve and its scalar.** For lambda!=0 put q=lambda^5,

    x=(2130+q^-2,4331*q,2234*q,3003,0314,3112*q,q,0,0),
    Omega(c)=c4-2*c3-4014*c7-0320*c8.

The fourth polynomial vanishes coefficientwise, and an actual particular
fourth digit solves all75 normal coordinates. Its normal q-exponents
are(-20,-10,-5,-2,0,1,5,10); after q=lambda^5 and one inverse Frobenius,
the digit has these integer exponents in lambda. The first affine
primitive has exponents(-50,0,25). These are Laurent identities valid
for every nonzero geometric lambda. Also Omega*J=0 identically.

At lambda=1, an actual regular-frame/Riccati comparison gives the FULL
relative quotient

    (0,2010,2213,3134).

Thus L(1)=Omega*C5=2010 despite zero first trace. This point is
x=(3130,4331,2234,3003,0314,3112,1000,0,0).
The complete scalar calculation gives

    L(lambda)=1003*lambda^-75+1101*lambda^5
              +3322*lambda^25+2144*lambda^75.           (8)

Its support is {-75,-25,5,25,75}. The marked involution lambda↦-lambda
makes L odd. Weight125 permits first–second and cubic first products,
but no square of the new second repair. The potential exponents-45,15
have final AS degree<=3 and zero Omega projection; at-5,1 only a direct
fourth-digit row occurs, also with zero Omega projection. The actual
preceding oper has variable-sector degrees0,2,3 and is retained before
its final Omega projection. Higher source/Taylor terms and the moving
weighted-jet/source cancellation are treated with §2's precision.

Four coefficients are evaluated by full regular comparison:

| Exponent | Coefficient | Retained contributions |
| --- | --- | --- |
| -75 | 1003 | Mixed first/second; cubic part zero |
| -25 | 0000 | Integral carry cancels the mixed/cubic sum |
| 5 | 1101 | Integral carry, direct/mixed terms and source derivative |
| 75 | 2144 | Mixed and cubic terms |

The raw fourth-reference sector is reconciled by an explicit M-image
of AS degree3, after which all75 residuals vanish; its Omega response
is zero. This is a coordinate adjustment, not a kernel vector. The
remaining coefficient3322 follows from the established L(1)=2010.
Thus the checkpoint's use is explicit and acyclic.

Set

    G(X)=4314+3323*X^16+0121*X^20+1242*X^30.

Exact coefficient Frobenius gives lambda^75*L=G(lambda)^5. Since
G'=3323*X^15 and G(0)!=0, G has30 simple nonzero roots, each of
multiplicity5 in L. Its irreducible degrees over k0 are1,1,2,2,8,8,8;
the k0-roots are±3222 and the splitting degree is8. Factor products,
Rabin irreducibility, the Frobenius identity and embeddings have an
independent finite audit.

**Both actual CRT residuals.** At the positive k0-root the full quotient
is(0,0,0422,3044). One quadratic and two octic representatives have actual
fourth reconstructions and fifth regular-frame comparisons over W5(F5^8)
and W5(F5^32), with fixed embeddings h^2=t and h^8=t. The original model,
marking, twist, basis and coefficient Frobenius are transported together.
At each, all75 fourth normal coordinates vanish; independent original-
frame Riccati calculations agree in all nine fifth coordinates. The
first two quotient components are zero and the other two are nonzero.
The full comparisons certify normal precision873; the separate Riccati
check with inputs cut at2000 certifies1539.

F625 Frobenius fixes the model and marking. The marked involution
(v,w1,w2,z)↦(-v,-w1,-w2,-z) fixes nu0 and the constant point
xi_*+2130*nu0+3003*nu3+0314*nu4, and negates the curve direction.
Its dual-row signs are(+,+,+,-,-,+,+,-,-). The last two
quotient residuals R5,R6 are even: their top numerator rows and the
pivot lambda^25*Ktop transform with the corresponding signs. Hence
Frobenius and sign transport VALUES modulo im(J), regardless of chosen
fourth reference. The four representatives cover2+4+16+8=30 roots.

In the finite étale algebra k0[X]/(G), those actual values are

    R5=343+509*X^6+330*X^10+380*X^16
           +542*X^20+364*X^22+583*X^26,
    R6=247+56*X^6+224*X^10+75*X^16
           +289*X^20+26*X^22+518*X^26.                 (9)

ONLY in(9), integers are base-five FIELD CODES sum a_i*5^i for sum a_i*t^i;
they are not prime-field integers. The retained
[CRT certificate](../../../Research/computations/rank25_one_parameter_full_exclusion.json)
contains both functions and an exact identity A*G_monic+B*R5=1. The
independent finite audit checks all seven restrictions, evenness and
that identity. It uses the actual comparisons above as input. The later
whole-locus proof needs BOTH functions' values, not merely nonvanishing.

## 6. The surface trace from support and three calibrations

Replace the coefficient q^-2 of nu0 by an independent s^5:

    x=(2130+s^5,4331*lambda^5,2234*lambda^5,
       3003,0314,3112*lambda^5,lambda^5,0,0).

Every point has an actual W4 extension; the primary/fourth identities
and particular digit are polynomials valid also at lambda=0. Write
x=s^5,y=lambda^5,a=s^25,b=lambda^25 just within this paragraph's degree
ledger. The first primitives have monomials1,a,b of AS degrees2,0,3.
The combined second primitives have bounds

| Monomial | 1 | x | y | a | b | a^2 | ab | b^2 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| AS degree | 6 | 0 | 3 | 4 | 7 | 2 | 5 | 8 |

The a^2 bound uses a checked degree2 replacement of the fourth source
digit. The lambda^10 fourth-source coefficient has degree8; its trace
vanishes by lambda0*zeta=0, not a low-degree argument. Section3 gives
these bounds for actual regular generators and their first carries.
The marked involution preserves the trace and makes it even in lambda;
its integral determinant-one spin lift is epsilon*diag(1,-1),
epsilon^2=-1, epsilon mod5=2.

Combining degree, parity and weights gives the COMPLETE trace support:
linear first terms (including two carries) allow1,a; linear second allows
1,a,b^2; quadratic first allows1,b^2; first–second products allow1,b^2,ab^2;
cubic first terms allow b^2. Thus

    c0=C0+C1*a+C2*b^2+kappa*a*b^2.

Only first-a times second-b^2 (degrees0+8) and first-b times second-ab
(degrees3+5) can contribute ab^2; the cubic a,b,b sector has degree6.
No divided lower carry, source or preceding-oper term adds that monomial.
The independently checked mixed-sector sum is therefore the FULL
coefficient kappa=3040.

Three earlier ACTUAL trace-zero comparisons on s=lambda^-2 use
lambda=1, lambda=3222, and a root of X^2+1241*X+0200. Their values
Q=lambda^50 are pairwise distinct, checked by exact field differences.
Substitution gives C2*Q^2+(C0+kappa)*Q+C1=0 at three distinct points.
Hence C1=C2=0, C0=-kappa=2010, proving

    c0=3040*(s^25*lambda^50-1)
       =3040*(s*lambda^2-1)^25.                        (10)

This derivation uses only the three actual traces, not a later exclusion
of the surface. At lambda=0 it gives the same nonzero constant2010.
In(U,q) coordinates(10) is3040*((U-2130)^5*q^10-1).

## 7. The universal trace by finite symmetry

Section4 and its two-factor residual argument show that the trace is
C3(Y), an ordinary cubic in Y=Phi(X). Taking inverse Frobenius only on
coefficients gives c0=theta(x)^5 for a cubic theta in actual x. The
actual finite deck group acts on the marked lifting torsor, and naturality
plus fourth-choice independence make the trace invariant. Frobenius
injectivity makes theta invariant too. The chosen right inverse need
not be equivariant; changing it changes a fourth choice, with zero
relative trace.

The complete marked action is obtained from translation of the actual
tangent vectors, including the affine offset of xi_*. In particular

    q'=q, (A',B')=(A,B)+q*L*(s1,s2),
    L=((0033,3112),(2100,1000)), det(L)=0321,
    (s1,s2)^[5]=H*(s1,s2).

Put V1=x1-4331*q,V2=x2-2234*q. The two fourth equations express
q*V1,q*V2 as quadratics in A,B. The84 monomials of degree<=3 in
(U,V1,V2,A,B,q) span70 functions on q!=0. Their finite-deck differences
have rank65; adjoining restriction to A=B=0 gives rank70. Thus the
invariant space has dimension5 and restriction to the established
surface is injective. These coefficient calculations reduce ONLY the
deck variables by s^[5]=H*s; no finite-field relation is imposed on
geometric parameters and unrestricted translations are not presumed
to act on the cover.

On that surface, the coefficient fifth root of(10) is
3440+2110*(U-2130)*q^2. Invariance and this restriction reconstruct
exactly the twelve coefficients of Theta in(5). The resulting invariant
basis is1,q,q^2,q^3,Theta. The candidate is checked after reconstruction;
its coefficients are not assumptions in the support proof.

The reduced fourth locus is smooth and geometrically irreducible by
the critical-locus theorem. The polynomial identity on its dense q-open
therefore extends to every boundary, giving traces2010,4140,1330,3120
in the stated order. The unit derivative partial_U(Theta)=2110*q^2
gives the trace-zero graph(6). The final theorem uses the remaining
cotangent components on this graph.

## 8. Evidence and audit access

All original source returns and actual comparison receipts remain under
../litt3-computation-data. The following links are the compact access
points; their manifests locate and hash the complete originals.

| Input or argument | Receipt / independent audit |
| --- | --- |
| Fixed-reference fifth comparison and gamma=0 | [full replay](../../../Research/computations/rank25_w5_fresh_replays_20260911.json), [audit](../../../Research/audits/RANK25_FIFTH_LIFT_AUDIT_2026_09_11.md) |
| Relative J, adjoint digit and quotient rows | [exact checks](../../../Research/computations/rank25_two_family_returns_checks.json), [geometric audit](../../../Research/audits/RANK25_FAMILY_RELATIVE_AUDIT_2026_09_12.md) |
| Actual scalar and its support | [finite checks](../../../Research/computations/rank25_one_parameter_return_checks.json), [audit](../../../Research/audits/RANK25_ONE_PARAMETER_RETURN_AUDIT_2026_09_12.md) |
| Extension-field values and both CRT residuals | [representatives](../../../Research/computations/rank25_local_root_receipts.json), [finite audit](../../../Research/computations/rank25_one_parameter_exclusion_finite_audit.json), [geometric audit](../../../Research/audits/RANK25_LOCAL_HOUR_2026_09_12.md) |
| Integral surface support and calibration | [return checks](../../../Research/computations/rank25_surface_return_checks.json), [support audit](../../../Research/audits/RANK25_SURFACE_RETURN_AUDIT_2026_09_12.md) |
| Universal trace and finite marked action | [return checks](../../../Research/computations/rank25_universal_trace_return_checks.json), [independent audit](../../../Research/audits/RANK25_UNIVERSAL_TRACE_INDEPENDENT_2026_09_13.md) |
| Full support, ordinary mixed and direct P2 | [finite audit](../../../Research/computations/rank25_ordinary_channel_finite_audit.json), [digit projections](../../../Research/computations/rank25_fourth_digit_projections.json), [support audit](../../../Research/audits/RANK25_FULL_FIFTH_SUPPORT_AUDIT_2026_09_13.md) |

The complete source returns for the surface and universal trace replay
their finite verifiers byte for byte in separate directories. Their
geometric scope comes from the arguments above and the independent
audits, not from the final JSON values alone. The whole original marked
height4 conclusion is proved in the next pair; the unmarked common-cover
problem remains unsolved.
