# Proof: a complete actual dihedral-five neutral playground

[Statement](../../../Theorems/deformations/cyclic_descent/explicit_non_galois_neutral_five.md).
Author construction with independent audit PASS,2026-09-11,
/root/audit_backup_cored_completion. The audit has no higher-Witt scope.

## Actual covers

For each of the fifteen branch pairs put R and S as in the statement.
The double D→C is the usual unramified branch-subset double. The other
quotient E:ell²=S has genus one. All fifteen Hasse coefficients are
nonzero, checked exactly over F625. On D the anti-invariant part of
H1_et(D,F5) is therefore one-dimensional, identified with H1_et(E,F5).

Choose chi=lambda*ell/u, with lambda satisfying H*lambda^4=1, where
H is the coefficient of ell/u in the exact cohomology reduction of
(ell/u)^5. Split exactly

    chi^5-chi=f_U-f_O

into affine and infinity-regular parts. Then

    w_U^5-w_U=f_U, w_O=w_U-chi, w_O^5-w_O=f_O

defines the actual connected cyclic-five torsor W→D. Its nonzero
Artin--Schreier class proves connectedness; both equations have
derivative -1 and the gluing identity proves global etaleness.

All chi,f_U,f_O are odd for the original double involution. Thus

    sigma(w)=w+1,
    tau(kappa,ell,w)=(-kappa,-ell,-w)

act on W and satisfy tau*sigma*tau=sigma^(-1). The involution tau is
free because its action on D is free. The quotient T=W/<tau> is the
actual degree-five etale cover of C. Its Galois closure is W and its
group is D10, since the order-two point stabilizer is not normal.
Riemann--Hurwitz gives g(D)=3,g(W)=11,g(T)=6.

Conversely, the quadratic resolvent of any D10 degree-five cover is
one of these fifteen doubles. Its cyclic direction lies in the
one-dimensional anti-invariant Artin--Schreier space; all nonzero
directions define the same geometric cover up to the group marking.
This proves the stated fifteen-class completeness, not completeness
for all degree-five monodromy groups.

## Exact actual Hodge matrices

Use Laurent polynomials in u with components 1,kappa,ell,v and tangent
frame eta^(-1), eta=du/v. Their exact base cohomology gaps are

    (v/u,v/u²,v/u³,ell/u,kappa/u,ell/u²).

The infinity tangent bounds are respectively exponent<=-1,-2,-3,-4
in those four components; these bounds hold for deg R=1 or2. Together
with affine nonnegative exponents they give an exact two-affine
cohomology reduction, with no series cutoff.

Triangular Artin--Schreier gluing gives the thirty classes b_i*w^j,
0<=j<=4. The actual map before cohomology is A*f^5, inherited from
the specified active pair. Computing it on these thirty classes and
reducing the infinity terms downward gives the 30-by-30 matrix.

The tangent frame eta is fixed by tau. Its sign on the four coefficient
components is (1,-1,-1,1), multiplied by (-1)^j on w^j. The positive
block has dimension15 and is precisely Psi_T by degree-two descent.
All matrices commute with sigma and tau, and both group identities
hold. Exact ranks give the table in the statement.

The independent verifier does not call the producer's Laurent algebra
or descending reducer. It constructs the finite Laurent-cochain
quotient by all infinity boundaries. All13,500 entries match, and an
enlarged quotient window gives identical answers. It also directly
checks the cyclic cokernel Smith lengths: [2] on each neutral row and
[4,4] on the exceptional row.

For Fitting types, if M is the displayed linearized matrix, use
M*M^[5]*...*M^[5^(j-1)], not M^j. Independent reconstruction and
composition agree. The neutral quotient ranks are
15,14,13,12,11,10,9,9; the base ranks are3,2,1,1. This proves the
length-six and length-two assertions. No simple-zero hypothesis is
inferred from a corank-one matrix.

## The actual first Witt repair and its limitation

For W→D, the audited cyclic obstruction theorem identifies the rank
of pullback on the primary cokernel with the number of free cyclic
group-ring summands. Smith lengths2 and4,4 are all strictly below5.
Thus pullback O_D→O_W is zero on every row, including the exceptional
one. The composite O_C→O_W is therefore zero.

Pullback O_T→O_W is injective because W→T has degree two. Naturality
then gives epsilon_T=0 for all fifteen T. The defining torsor-variation
formula rho(S+xi)=rho(S)-Psi_T(xi) supplies a compatible T3, with the
original pulled-back data. For the fourteen neutral rows the general
neutral degree-five theorem independently gives O_C→O_T=0.

If any such compatible T3 extended the original map to C3, naturality
of the full higher inverse-Cartier construction would give

    0=rho_T(T3)=h*rho_C(C3).

Pullback on negative tangent H1 is injective for this individual
finite etale map, regardless of degree. Hence rho_C(C3)=0, contrary
to the established nonzero epsilon_C. This proves the source-only
statement. It does not constrain the next obstruction on T3.

## Reproduction

    sage -python scripts/deformations/cyclic/explicit_nonordinary_dihedral5.py --output Research/computations/explicit_nonordinary_dihedral5.json
    sage -python scripts/deformations/cyclic/analyze_dihedral5_hodge.py --input Research/computations/explicit_nonordinary_dihedral5.json --output Research/computations/explicit_nonordinary_dihedral5_fitting.json

Producer:7.40s for all fifteen covers. Independent first and enlarged
window replays, including semilinear diagnostics:8.03s and8.28s. Receipts are
`explicit_nonordinary_dihedral5_audit.json` and
`explicit_nonordinary_dihedral5_audit_window24.json` in
Research/computations. The independent script is
scripts/deformations/cyclic/audit_explicit_nonordinary_dihedral5.py.

All finite-field coefficients, branch resolvents, AS equations and
Hodge matrices are retained in the producer receipt. The field
F_(5^16) is a common coefficient field for the displayed generators,
not a restriction of the theorem to rational covers over that field.

## Explicit selected cover and next-step input

For R=u(u-1), a bounded independent follow-up audit also PASSed the
same-cover hyperelliptic model and particular primary repair. Report:
Research/audits/NEUTRAL5_HYPERELLIPTIC_PRIMARY_AUDIT_2026_09_11.md,
auditor /root/audit_backup_cored_completion,2026-09-11. This does not
add a higher-Witt assertion to the theorem.

Write H=t²+2 and factor the elliptic multiplication-by-five map through
relative Frobenius, q=N/D, D=d². The saved degree5/degree4 polynomials
and square root J satisfy J²S5=N³-tN²D+ND²-tD³, where
S5=s³-t^5s²+s-t^5. Then the SAME cover and differential are

    T:Y²=N(N-D)S5, u=q(s), v=JY/d^5,
    h*(du/v)=-H D ds/Y.

The sign is fixed by the saved J. Direct AS identification, without
relying on the multiplication-map black box, is given on y²=S5 by

    B0=(2+3t+3t²+2t³)s+(3+t+2t²),
    w=lambda*y*B0/d, ell=J*y/d³.

Put kC=v/u+4v/u²+(4+t+3t²)v/u³ and a=2+2t+4t³. The particular
tau-invariant first repair is

    xi=(4+4t+t³)v/u+(1+3t³)v/u²
       +(t+2)lambda³(kappa/u)w+lambda²*a*w²*kC.

It satisfies the actual equation Psi_T(xi)=h*rho_C(C3ref). The entire
compatible marked T3 family is T3ref+xi+b*h*kC, b in k. The repair
and kernel are hyperelliptic-invariant. All six displayed nonzero
coefficients and the marking were checked independently.

Root additionally converted this equation to the15dimensional basis
Y/s^i,i1..11, and1/s^i,i1..4. Its multiplier is the degree19 polynomial

    A_T=H^4 D(N-tD)(N-h0D)²/mu.

The blocks have entries [s^(5j-i)]A_T*G² and[s^(5j-i)]A_T and ranks
10and4. Exact rational principal parts at the N-poles transport rho,
xi and h*kC, with Psi(xi)=rho checked in all11coordinates. This
preparation is in scripts/deformations/cyclic/neutral5_hyperelliptic_hodge.py and
Research/computations/neutral5_hyperelliptic_hodge.json. It computes
the first repair only, not the obstruction to its fourth extension.
