# Fourth lifts, a cubic potential and the complete critical scheme

[Statement](../../../Theorems/deformations/elementary_covers/rank25_fourth_locus.md).
The original geometric W4 construction and full replay are audited PASS;
the new critical-scheme argument has an independent
[audit](../../../Research/audits/RANK25_CRITICAL_LOCUS_CONSOLIDATION_AUDIT_2026_09_13.md).
These are prose and exact algebra certificates, not Lean verification.

## 1. Fixed marked data and the actual fourth obstruction

Use the original (C,r,xi_C) of
[the genus-two example](../explicit_genus_two_witt_obstruction.md), including
its nonsplit flat spin line. Put eta=du/v and z=u^2/v. The reference
hyperelliptic polynomial is the PRODUCT of the lifted factors
u(u-1)(u-2)(u-3)(u-T). All subsequent references retain that convention
and the original second marking, rather than a new lift of the expanded
residue equation.

The coupled equations w_i^5-sum_j H_ij*w_j=v*Q_i(u), with

    H=((2140,3031),(3300,1040)), det(H)=4,
    Q0=(0110,3330,1430,3410,3300,1000) in increasing u powers,
    Q1=1,

have the full H1(C,O) basis as shift classes. They define the actual
maximal connected cover with geometric group(Z/5)^2. Its horizontal
branch algebra has equations s^[5]=H*s and invertible Jacobian -H;
simultaneous Hensel lifting transports all25 branches and coefficient
Frobenius. At EACH infinity point the theta transition is z, not z^25.

The normal basis is z^e*w1^i*w2^j*eta^-1, lexicographic(i,j), with
0<=i,j<=4 and e=-3,-1,1. In these75 coordinates the primary map is
Psi(v)=M*v^[5], rank(M)=66. The actual tangent columns N=(nu0,...,nu8)
and obstruction rows Lambda satisfy

    M*N^[5]=0, Lambda*M=0, Lambda*N=0,
    AS degrees of nu_i=(0,1,1,2,2,3,3,4,4).

The nine independent columns therefore give every compatible third
choice Xi(x)=xi_*+N*x. The full matrices and original marking are in the
[primary input](../../../Research/computations/rank25_small_field_fourth_inputs.json).
The [complete fourth data](../../../Research/pro_inputs/rank25_all_fifth_lifts_inputs.zip)
retain the full nine-variable E and all75 coordinates of normal4 on
the candidate plane x7=x8=0, including ordinary-x terms. Section2 proves
that every W4 point lies in that plane. Neither input is replaced by the
shorter zero equations: transverse columns7,8 of the FULL J remain needed.

For the smooth fourth reference, the overlap is

    tau=exp((5xi_C-25Xi)D) modulo625, D=eta^-1.

The triangular two-variable AS reducer splits the entire first normal
cochain as rho2+uU-z^2*uO=0, with genuine affine and regular formal
primitives. The corrected generators I_i(e2+5u_i*e1), after Wronskian
normalization, give the actual next comparison frames I_i^(2). Retain
both order25 diagonal terms, the lower potential, cubic upper entry
and weighted jet. The resulting normal class is

    rho4=z*((I_O^(2))^-1*G3*tau(I_U^(2)))_12/25 modulo5.

This is the filtered/graded inverse Cartier operation of
[LSZ §4](https://arxiv.org/html/1311.6424v4#S4), followed by the normal
obstruction of [LSYZ §6](https://arxiv.org/html/1404.0538v2#S6).
The actual first primitives are affine in y=x^[5]; surviving products
are quadratic. Structural expansion gives

    Lambda*rho4=E(y)=C+sum_i L_i*y_i+sum_(i<=j) Q_ij*y_i*y_j.

Every projected ordinary-x coefficient is zero. This is a universal
coefficient identity, not finite-field interpolation. Changing chosen
integral parameter lifts changes only a top smooth digit, whose image
under M disappears in the quotient; no additive Witt section is assumed.
Thus E(x^[5])=0 is necessary and sufficient for a compatible W4 tuple.
The full polynomial is retained in universal2100.json under the original
W4 data root identified in §5.

## 2. The cubic potential and its complete support

Use the auxiliary coordinates of the statement, writing the top pair
as z=(z1,z2) only in §§2–3; this is distinct from the curve parameter
z=u^2/v in the geometric construction. The exact
[potential certificate](../../../Research/computations/rank25_critical_potential.json)
checks ∇V=P*E in all nine original coordinates, with det(P)=1401, and

    V=1011*h^2+z^T*K*f_s
        +h*z^T*(L*m+alpha*h+beta*s)+Q(U,a,b;z)+R3(z),
    K=((3202,1411),(2422,0034)), det(K)=0031,
    L=((1000,0004),(0202,0440)),
    alpha=(0311,2323), beta=(4120,0324).

Here Q is quadratic in z with coefficients affine in1,U,a,b, and R3 is
cubic in z. Their full coefficient arrays and P are in the certificate;
these terms require no additional special property in the argument.
The identity retains every coefficient of the original E, including
its transverse derivatives.

To exclude other critical support, use just three of the original rows:

    E0=4423*z1^2+1101*z1*z2+2224*z2^2.

A nonzero top pair has z1!=0 and slope z2/z1 equal to3404 or4343.
On those two lines, respectively, exact coefficient subtraction gives

    E6-0334*E5=2112*z1,   E6-0202*E5=3412*z1.

Both constants are nonzero. Every geometric zero of E therefore has
z=0. At z=0, differentiation of V forces h=0 and then K*f_s=0;
conversely these equations kill every derivative. This proves equality
of supports over the algebraic closure, including all boundaries.

The center F=G=0 has monic b-resultant

    a^4+4444*a^3+1233*a^2+2310*a+3221.

It is squarefree with four k0-roots; the gcd in b at each root is linear.
The resulting (a,b) points are those in the statement. Their determinants
det d(F,G)/d(a,b), in the listed order, are3343,4110,3003,1141, all units.
This proves that the center is an étale four-point scheme, rather than
merely four points found by search. For s!=0 the m-Jacobian of f_s is
s*D, with det(D)=4303. At s=0 the center Jacobian is invertible. Hence
f_s=0 is smooth of codimension2 in the six-dimensional base(U,m,a,b,s).

## 3. One normal-Hessian argument proves the scheme and quotient claims

The following elementary lemma is useful beyond this example. Let B be
smooth over a field of characteristic different from2, and let f:B→A^r
have smooth zero scheme of codimension r. On B×A^(r+1) with coordinates
(z,h), suppose

    W=z^T*K*f+kappa*h^2+h*z^T*b+(1/2)z^T*A*z+R,

where K is invertible, kappa is a unit, A is symmetric, b,A,kappa are
functions on B, and R belongs to(h,z)^3. Along S={f=h=z=0}, choose f
as part of étale local coordinates on B. The normal Hessian, in order
(f,z,h), is

    [ 0  K^T    0     ]
    [ K   A     b     ]
    [ 0  b^T  2kappa  ].

Its determinant is(-1)^r*det(K)^2*2kappa, independently of A,b. The
critical ideal C is contained in I=(f,h,z), and its gradients span I/I^2.
Nakayama applied to I/C gives C=I near S. If every geometric critical
point is in S, there is no remaining support where the ideals can differ,
so equality is global. The Hessian has kernel T_S and rank2r+1.

Apply this with r=2 to §2. It proves the full ideal identity(1), rank5
and smoothness. It also explains the obstruction quotient: P*J is the
symmetric Hessian, whose image is the annihilator of T_S. Multiplication
by P followed by restriction of covectors gives coker(J)≅Omega^1_S.
Under a source coordinate change y=T*w the pairing becomes T^T*P;
the target convention E remains the original one.

For the geometric model set n=-D*m-s*c. Then f_s=0 becomes
(F,G)=s*n. The algebra k0[a,b,s,n]/(F-s*n1,G-s*n2) is smooth of dimension3;
its s=0 locus is four affine planes, so no component is contained there.
It is reduced and s is a nonzerodivisor. After inverting s it is
k0[a,b,s,s^-1], proving its identification with

    k0[a,b][s,F/s,G/s] ⊂ k0[a,b,s,s^-1].

This is the deformation to the normal cone of the regular four-point
center; its normal cone is its normal bundle, as in the
[standard definition](https://stacks.math.columbia.edu/tag/062Z).
Restoring the free U factor gives the stated open chart and four
three-dimensional boundary families. Every component meets the same
irreducible open A^3×Gm, so the whole scheme is geometrically irreducible.

Finally, inverse Frobenius on coefficients gives a smooth reduced locus
S_x whose ideal I_x satisfies (E(x^[5]))=I_x^[5]. This is the ideal
generated by fifth powers, not the ordinary fifth ideal power. The
relative Frobenius F:S_x→S_y pulls the quotient back to F^*Omega^1_S_y.
Pointwise inverse Frobenius on a class AND on P is semilinear transport
to a cotangent covector on S_x, not dF. No global fifth root of C5 or
absolute gradient property is inferred; the next proof supplies the
actual relative comparison and its support.

## 4. The actual W4 witness and pullback lower bound

At x*=(0,0,0,3003,0314,0,0,0,0), its fifth-power coordinates have
(a,b)=(2321,2003). Substitution into F,G vanishes exactly. In the
original polynomial ring before reduction by f(t)=t^4+4t^3+t^2+4t+3,
the two values are f(t)*(4t^4+3t^3+4t^2+2) and f(t)*(2t^3+t^2+2t).
The cancellation includes the quadratic product of degree-two Hodge
repairs; omitting it leaves a nonzero pair.

Exact row reduction supplies a full75-vector y with M*y=rho4. Over k0,
put zeta_*=y^[125], so M*zeta_*^[5]=rho4 in all75 coordinates. This
finite-field inverse is used only on the stated k0-valued witness.
The curve overlap

    exp((5xi_C-25Xi_*-125zeta_*)D) modulo625

has zero normal cohomology by direct recomputation. Its actual affine
primitive vU and whole regular quotient vO=(rho4+vU)/z^2 give the Hodge
generators I_i^(2)(e2+25v_i*e1). Their normalized frames agree with the
previous ones modulo25 and have the required full jet modulo125.
The negative normal line gives uniqueness; the original flat line and
prescribed graded identification are retained. This constructs the
compatible W4 tuple, not just its normal digit.

The AS shift has pole cost at most16 per passage, with conservative
cost32 in the reducer. The z^100 reduction window therefore cannot
change normal exponents-3,-1,1. The two final recomputations certify
normal-cochain precision980 and1276. Formal tails exist as whole regular
quotients after exact pole cancellation; finite diagnostic windows are
not substituted for that argument.

Pullback along any further actual finite étale cover, with its unique
nilpotent lifting, preserves this entire tuple. Every rank-two abelian
5-group cover of C dominates T by
[abelian_p_defect_node](../abelian_covers/abelian_p_defect_node.md). This proves the
stronger lower bound for refinements without inferring any upper bound
for them from the later marked height4 theorem.

## 5. Verification access

The immutable original data root is

    ../litt3-computation-data/rank25-w4-returned-20260911-bpG6EM/
      rank25_fourth_lift_certificate/

It retains the original source, universal2100.json, point_and_fourth_digit.json,
and all69 manifest files. The separate full replay rebuilt branch caches,
the witness, both full fourth comparisons, changed-Frobenius coefficients
and all nine-variable equations; all38 final field checks agree. Its
[receipt](../../../Research/computations/rank25_w4_fresh_replays_20260911.json)
distinguishes added diagnostics from unchanged mathematical values.
The [original geometric audit](../../../Research/audits/RANK25_FOURTH_LIFT_AUDIT_2026_09_11.md)
covers marking, twist, full frames, precision and universal degree bounds.

The [critical-potential checker](../../../scripts/deformations/rank25/check_rank25_critical_potential.py)
verifies ∇V=P*E, the factorization, both top-slope contradictions and the
complete étale center by coefficient identities. Its small receipt binds
all three inputs. The older independent
[locus receipt](../../../Research/computations/rank25_w5_return_and_global_w4_locus_checks.json)
retains explicit open and boundary transverse minors, and the new
critical-locus audit checks the scheme and Frobenius reasoning. These
finite checks support the stated constructions; none supplies an
unmarked common-cover conclusion.
