# Proof: reconstructing the actual cubic ordinary base

[Statement](../../Theorems/deformations/cubic_ordinary_base_reference.md).
Version1,2026-09-14. The bounded
[independent audit](../../Research/audits/RANK125_CANONICAL_BASE_REFERENCE_AUDIT_2026_09_14.md)
checks the geometric dictionary, flat-line descent, integral recurrence,
previous/new tuple slots and canonical scope. The execution and its
additional precision, Frobenius-gauge and connection checks are retained
in the [certificate](../../../litt3-computation-data/rank125_reference_20260914/certificates/cubic_ordinary_base_reference.json).

The [storage relocation record](../../../litt3-computation-data/rank125_reference_20260914/provenance/relocation.json)
maps the receipts' historical paths to their current external locations.
It preserves the original bytes and generating checker, whose hash is
recorded in the certificate. The current checker uses the new paths;
only path and checker-hash metadata differ on a rerun.

## 1. Reference choices and the full initial dictionary

All notation and coefficient lifts are as in the statement. The affine
product lift is v^2=F=P(u)(u-T). At infinity put s=1/u; the unique solution
of s=z^2*reverse(F)(s), s=z^2+O(z^4), defines u,v and

    g=du/(v dz)=-z*s',   D=g^-1*d/dz.

The divisor of u-t is2W_t-2infinity. Its half is a nontrivial two-torsion
class: a principal W_t-infinity would give a degree-one map to P1.
Consequently the square-root notation must retain the actual flat line.
The columns a,b and c,d below are anti-invariant on its etale double;
all scalar source and repair data are invariant and descend to Y.

Direct differentiation gives Da=b and Db=Ra, including integrally for
the displayed product lift. Modulo5 the polynomial R has coefficient
codes21,19,20,2 in increasing u degree. Write A2=a^2 and B2=b^2, which are
coprime polynomials. An affine Bezout identity A2*p+B2*q=1 is lifted
integrally by multiplying an initial residue solution by the finite
inverse of its determinant1+5E. Then

    c=-b*q, d=a*p,   S_U=[[a,mu*c],[b,mu*d]], det S_U=mu.

At infinity a_O=z^4*a is a unit. The residue
b_O=z^5*(z*b-Dz*a) is regular. Choose its coefficientwise REGULAR formal
lift; the naive integral expression may have a nilpotent polar part.
The valid complement here is

    S_O=[[a_O,0],[b_O,mu/a_O]].

For J=[[z^-1,0],[-Dz,z]], direct multiplication gives
z^5*(S_O^-1*J*S_U)_12=mu*c/a modulo5. Thus f_target=c/a. This is the
actual changed complement, not the complement from the different
rank25 base used as the source of the arithmetic method.

A regular affine Frobenius has Phi(u)=fu(u), Phi(v)=v*bv(u), satisfying
the EXACT polynomial identity

    F^sigma(fu)=F*bv^2 modulo3125.

Starting at fu=u^5,bv=F^2, correct each digit using an inverse of F'^5
modulo F^3. The alternative tested gauge adds F^3 to the first correction
of fu and solves the accompanying bv correction. True Witt Frobenius is
used: sigma(T)=(2871,571,2744) in the basis1,T,T^2 modulo3125; sigma^3=1.
Let fuz=Phi(z)=fu^2/(v*bv), delta_ref=(fuz-z^5)/5 and

    f_ref=-g^Phi*delta_ref modulo5.

Here h^Phi means sigma on coefficients and z->z^5, in distinction to
the regular affine Phi(h). These agree only to the needed first order
when that distinction is explicitly removed.

The initial extension quotient has the ELEVEN normal exponents
-3,-1,1,...,9. Affine u^j eliminates every even pole, affine v*u^j every
odd pole at most-5, and the formal boundary is z^10*k[[z]]. In this full
quotient solve

    mu*f_target=f_ref+xi^5,
    xi in span(z^-3,z^-1,z).

The four-column system has rank4 and solution
mu=1, xi^[5]=(103,22,104), hence xi=(118,113,119). Let q_U be the affine
part of mu*f_target-f_ref-xi^5. The ENTIRE formal primitive is

    q_O=-(mu*f_target-f_ref-xi^5-q_U)/z^10 modulo5.       (1)

All forbidden coefficients vanish, so q_O is regular. Set
M_U=[[1,q_U],[0,1]], M_O=[[1,q_O],[0,1]] and I_i=M_i*S_i^-1.
The full first transition satisfies

    I_O^-1*[[z^-5,z^-5*(f_ref+xi^5)],[0,z^5]]*I_U=J.

The connection identity is mu*beta-dq_U+zeta=0 modulo5, with
beta=(d*D(c)-c*D(d)-d^2+R*c^2)*eta and
zeta=dPhi(u)/(5*Phi(v)). It identifies the filtered active oper, rather
than just an extension class. The symbolic identities for the horizontal
column and the constant determinant fix the remaining connection entries.

## 2. Complete normal solves and canonical uniqueness

The subsequent normal quotient has basis(z^-3,z^-1,z)D: the formal
boundary is now z^2*k[[z]]. The same affine elimination computes the
whole class, not a chosen short jet. Multiplication by A after Frobenius
gives the matrix M in the statement; an independent finite-field
calculation gives det M=3t. Thus the oper is ordinary.

The higher inverse-Cartier construction uses the previous filtered object
and its graded identification. Its next Hodge obstruction varies by
-Psi(n) under a next source displacement n. The pertinent input and
canonical finite-level comparison are recorded in
[canonical endpoint necessity, Sections1--2](forced_canonical_witt_endpoint.md).
The construction and variation are supplied by
[Lan--Sheng--Yang--Zuo, Section5](https://arxiv.org/html/1404.0538#S5).
Since Psi is bijective, exactly one next source class kills the
obstruction above an identified canonical truncation. Its lifted Hodge
line is unique because H0(Y,T_Y)=0, and its graded identification is
unique projectively. The two-torsion lift and flat connection remain
part of the input. This inductively identifies the calculated curve
with the ordinary oper's canonical lift; it does not assert existence
of any two-leg diagram.

For clarity about exactness, if f is an entire normal cochain, elimination
produces

    f=f_aff+f_normal+z^2*f_formal modulo5.                (2)

Here f_aff is an actual finite polynomial in u,v. Lift that polynomial
on the affine product chart. The formal lift is coefficientwise applied
to the WHOLE quotient in(2). It is not the finite list of its first30
coefficients saved as a diagnostic. With f_normal=0, the Hodge graph
corrections have signs -f_aff on U and +f_formal at infinity.

## 3. The integral recurrence and the preceding filtered object

Put ell=xi-5n3-25n4-125n5 and tau=exp(5ell D). Terms through order5
suffice modulo3125; the order4 and order5 coefficients are BOTH625/24.
Let tz=tau(z) and

    A_z=tau(g)*(tz)'/g,   q_z=z*sqrt(A_z),
    delta=(tau(fuz)-(tz)^Phi)/5.

The ordinary and p-connection jet transitions are respectively

    J_tau=[[q_z^-1,0],[-D(q_z)/A_z,q_z]],
    J_tilde^Phi=[[q_z^-1,0],[-5D(q_z)/A_z,q_z]]^Phi.

All divisions take place before reduction to the needed coefficient
modulus. In particular delta must be formed at source modulus3125 for
the fifth comparison at flat modulus625. The square root can be cut
after the cubic term: its quartic coefficient -5/128 makes that term
zero modulo3125.

For a given preceding potential Pprev, set

    A_U=[[0,-g],[-25*Pprev*g,0]],
    K_0=I,   K_(j+1)=5*K_j'+A_U*K_j,
    G=J_tilde^Phi * sum_(j=0)^5 tau(K_j/j!)^Phi*delta^j. (3)

The division at j=5 is (K_5/5)/24, using the whole K_5. A word with d
derivatives and r off-diagonal factors in K_j, d+r=j, has valuation at
least d+2floor(r/2)>=j-1. Hence K_j/j! vanishes modulo625 for j>=6.
This proves the truncation; it does not omit the fifth Taylor sector.

At stages3,4,5 the flat moduli are25,125,625 and the divided normal
weights are5,25,125. From the previously repaired frames G_U,G_O form

    rho=z*(G_O^-1*G*tau(G_U))_12 / 5^(stage-2) modulo5. (4)

Solve M*n_stage^[5]=normal(rho), insert that source digit, and RECOMPUTE
the entire cochain(4) before the split(2). The inverse coefficient
Frobenius is exponent25 only because these constants lie in F125.

The potential in(3) is0 at stage3, R at stage4, and the ACTUAL preceding
P2_U modulo25 at stage5. Recover P2_i from the full repaired stage3
frame(c,h), using its connection:

    nabla_D h=-c, nabla_D c=-P2*h, det(c,h)=mu^-1.

The code verifies P2_U=R and P2_O=z^4*R-z^3*D(Dz) modulo5. It retains
P2 modulo25; replacing it by its residue in the fifth comparison is
not justified. In fact the entire affine potential simplifies to

    P2_U=(11+19T)+(14+8T)u+(5+4T+15T^2)u^2
         +(7+10T+5T^2)u^3+(10+20T)u^4 modulo25.           (5)

Here the coefficients are integral ring elements, not field codes.
The normalized frames, connection and covariant derivatives are regular
on the actual affine chart, so P2_U belongs to its coordinate ring.
Its finite polar part at the product infinity starts at z^-8. Subtract
the polynomial(5): all poles and the constant term vanish modulo25.
For each residue digit the difference is then a global regular function
on the projective product curve, vanishing at infinity, so it is zero.
The same argument after division by5 proves the full identity modulo25.
An independent small power-series computation in the cubic ring checks
every retained coefficient through exponent29, for both Frobenius gauges.
Thus(5) specifies the whole affine function, not an approximation by a
short window.

The old upper connection matrices, as coefficients of dz, are

    B2_U=[[0,-zeta_U],[0,0]], B2_O=[[0,-zeta_O],[0,0]],
    zeta_U=(Phi(u))'/(5*Phi(v)), zeta_O=z^4*(g/z^2)^Phi.

The subsequent local flat connections are

    B4_U=[[0,-zeta_U],[-25*Phi(P2_U)*zeta_U,0]],
    B4_O=[[0,-zeta_O],[-25*P2_O^Phi*zeta_O,0]].

The affine Phi(P2_U) modulo25 includes
(fuz-z^5)*(P2_U')^Phi in addition to P2_U^Phi. Thus the affine lift is
regular on its actual chart, not replaced by formal coefficient
Frobenius. The use of P2 in B4 is one step before its use in(3); these
are different slots of the higher construction.

For a graph correction q with weight e, let h=I_2+e*q*I_1 and
c=-nabla_D h (use D_O=z^2D at infinity). Normalize both columns by the
factor (mu*det(c,h))^-1/2, then recompute c as -nabla_D h. This fixes the
determinant and the full graded jet. With epsilon=mu*det(c,h)-1, the
factor1-epsilon/2+3epsilon^2/8 suffices modulo625: its cubic coefficient
is already divisible by5. This constructs the actual next frames used
in the following stage, including the old second tuple.

## 4. Finite evidence, complete tails and reproducibility

The [first dictionary source](../../scripts/deformations/rank125/reconstruct_base_reference.py),
[full tower source](../../scripts/deformations/rank125/reconstruct_base_tower.py)
and [cubic arithmetic](../../scripts/deformations/rank125/witt_cubic.py)
are retained. The [independent certificate checker](../../scripts/deformations/rank125/certify_cubic_base_reference.py)
uses separate pure-Python cubic-ring arithmetic for the field systems,
source equations, Witt Frobenius and polynomial(5). Run it after the
two tower executions to reconstruct the retained certificate.
The method was adapted from the independently executed
rank25 engine, whose original source and provenance remain in
`../litt3-computation-data/rank25-w5-fresh-replay-20260911-j8b7nf2m/`
`rank25_fifth_certificate/reconstruction/`. None of that different
base's numerical or marking data is imported.

Reproduce a full calculation with

```sh
LITT3_REFERENCE_MODULUS=3125 LITT3_REFERENCE_PRECISION=3200 python3 scripts/deformations/rank125/reconstruct_base_tower.py --output ../litt3-computation-data/rank125_reference_20260914/computations/rank125_base_tower_w5_final.json
```

Use precision3600 and `--frobenius-variant 1` for the second gauge,
writing `../litt3-computation-data/rank125_reference_20260914/computations/rank125_base_tower_w5_final_other_frobenius.json`.
The arithmetic propagates absolute EXCLUSIVE Laurent precision and
checks integer divisibility before every division by5. It never treats
unknown positive coefficients as zero. The smallest retained normal
precision is1825, far above the largest needed normal exponent9.
All low coefficients used to eliminate poles and compute the three
normal coordinates are therefore determined exactly.

The formal expressions have finite lower bounds: source displacements
are nilpotent, only finitely many Taylor terms survive, and inversion
separates a genuine unit from its nilpotent polar part. After all
forbidden powers are removed, the whole quotient is regular. Thus the
proof of the normal vanishing and Hodge existence uses complete polar
cancellation and the formulas(1)--(4). It does not infer an identity
of arbitrary formal series from agreement through order20 or30.

As additional checks on the chosen formulas and transports, the execution
tests the full source differential identity, the preceding potential
transform, all four entries of

    B_O*G-G*tau(B_U)*(tz)'+G'=0,

and all four corrected graded jet entries at flat moduli25,125,625.
The last two checks run through exclusive Laurent precision20. The
exact polynomial Frobenius and affine Bezout identities, full finite
normal eliminations, source digits, actual affine primitive records,
whole formal quotient conventions and source hashes are retained in the
certificate. The independent audit and the changed Frobenius/precision
execution check different possible failure modes.

## 5. Transfer to the later rank125 comparisons

Finite etale covers lift uniquely over nilpotent thickenings. The higher
construction, its Hodge line and the graded identification pull back
along that actual lifted map; the local Frobenius maps can be lifted
by etaleness. No division by the cover degree or assumed Galois closure
enters this transfer. Consequently this supplies a concrete canonical
ordinary-base reference for each specified cover of this Y, including
the original rank125 cover through its genus-three intermediate curve.

The subsequent [integral reference theorem](elementary_covers/rank125_integral_reference.md)
now expresses that pulled reference on the ORIGINAL integral etale
charts. The [actual fourth-reference theorem](elementary_covers/rank125_actual_fourth_reference.md)
evaluates alpha,beta,omega there, and the
[whole fifth theorem](elementary_covers/rank125_fixed_line_fifth.md)
uses the combined old/mixed second repairs before dividing the whole
fifth numerator by125 and applying the two-trace functional.
The base digits above supply the reference; they are not themselves
those later coordinates or the affine fifth value. Both global
common-cover gaps remain.
