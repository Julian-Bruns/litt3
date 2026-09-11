# Proof: degree240 is excluded by the twisted primitive equations

Version1,2026-09-10. Root derivation and exact30-chart calculation,
about44s on one core. Fresh focused audit PASS by
/root/audit_backup_wild240_twist. Main candidate unchanged.
[Statement](../Theorems/Thm_backup_wild240_atlas_exclusion.md).
The global primitive and fixed-base local coefficient are those proved
in [degree120](Sol_backup_wild120_atlas_exclusion.md); this proof checks
their actual double-cover transfer and every nontrivial twist.

## Actual double and parity

Suppose the backup C has an actual orbifold atlas of coarse degree240,
wild(e,delta)=(40,47) over infinity, tame6 over0. If f is its coarse
function, adjoining z=sqrt(f) gives an ACTUAL etale double pi:T->C:
div(f)=6D0-40Dw is even. If the double splits, a component gives the
already excluded degree120 atlas. If connected, T has genus3 and z
has the same local atlas data(20,27;3), now with degree240. The tame
quadratic base change divides40 by2 and subtracts the tame different,
giving the wild different27 upstairs. The completions remain common
fixed-base Galois extensions, not merely numerical ramification profiles.

The section (dz)^3/z² is anti-invariant under z->-z. The explicit
primitive construction used for120 gives S and B anti-invariant with
DB=S^7, while R=(B-lambda*(DS)^5)/S^5 is invariant. Thus R is a function
on C in L(15O), and the necessary equations remain

    DR=S²,
    R*(DS)^5=lambda*(D²S)^5 at finite zeros of S.

The fixed-base Artin--Schreier coefficient still has common fourth
power; replacing z by-z changes its square root by a fourth root of
unity and does not change lambda. Pole estimates are computed at the
two unramified points above O.

## Every nontrivial two-torsion line

Write C:v²=F(u), F=u(u-1)(u-2)(u-3)(u-alpha). Every nontrivial class
of J(C)[2] is represented by E, the product of one or two of the five
finite branch factors:5+10=15 choices. Set J=F/E. On the actual double
take w1²=E,w2²=J,v=w1*w2. Both w1,w2 change sign under its deck map.

The complete anti-invariant cubic-section space has basis described by

    S=w1*A(u)+w2*B(u),        deg A<=2, deg B<=1.

Indeed at finite branch points the factors w1 and w2 account for the
required allowed square-root behavior; their pole orders at O are
deg E and5-deg E. The degree bounds impose pole<=6. There are five
coefficients, as Riemann--Roch for omega_C³ tensor a nontrivial
degree-zero line requires.

Write R=P+vQ, deg P<=7, deg Q<=5. Its differential equation is

    P'=2AB,
    FQ'+(F'/2)Q=E A²+J B².                         (1)

Integrate the degree<=3 polynomial2AB, retaining the two free kernel
terms r0+r1*u^5 in P. The same constant9-by6 matrix as in120 solves Q
and leaves three quadratic consistency equations. Use GENERIC finite-
field matrices and verify the inverse entrywise in the polynomial ring.

## Local equation in the norm quotient

Since D=v*d/du,

    D w1=(E'/2)w2,      D w2=(J'/2)w1.

Define

    C1=J B'+(J'/2)B,    G1=E A'+(E'/2)A,
    C2=J G1'+(J'/2)G1,  G2=E C1'+(E'/2)C1.

Then DS=w1*C1+w2*G1 and D²S=w1*C2+w2*G2. The local residual is
w1*L1+w2*L2, where

    L1=P*E²*C1^5 + J³*Q*G1^5 -lambda*E²*C2^5,
    L2=P*J²*G1^5 + E³*Q*C1^5 -lambda*J²*G2^5.

Put N=E A²-J B². Dividing by S formally gives

    (w1 L1+w2 L2)/S
      =[E A L1-J B L2 + v*(A L2-B L1)]/N.

The necessary polynomial conditions are BOTH

    E A L1-J B L2 =0 mod N,
    A L2-B L1 =0 mod N.                            (2)

Here is a direct scheme-theoretic justification, including common
roots and Weierstrass points. The residual w1L1+w2L2 vanishes at
EVERY finite zero of the actual simple-zero section S. Hence its
quotient by S is regular on the affine double. Both numerator and
denominator are anti-invariant, so the quotient is invariant and
descends to the affine ring k[u,v]/(v²-F). That ring is free with
basis1,v over k[u]. Uniqueness in k(u)+v*k(u) then forces EACH
displayed numerator to be divisible by N, with its full multiplicities.
No assertion that N is squarefree or has disjoint branch support is
needed. This scheme-theoretic step was checked in the focused audit.

## Two exhaustive normalization charts per E

Let m=deg E. In the generic chart S has pole6, and the coefficient of
the forbidden pole45 of B_primitive=S^5 R+lambda*(DS)^5 gives
lambda=3Q5, just as in120. In the boundary chart S has pole5, O is a
simple zero of its cubic differential, and lambda is free. Omitting
the local infinity constraint only enlarges the necessary system.

- m=1: generic B1=1; boundary B1=0,A2=1.
- m=2: generic A2=1; boundary A2=0,B1=1.

In each case N is monic up to a fixed sign and has degree6 or5.
If both leading coefficients vanish, S has pole<=4 and its cubic
differential has a multiple zero at O, so cannot be an atlas section.

This gives30 small exact charts, plus the split case already handled
by120. [Replay](../scripts/verify_backup_wild240.sage), using
`sage scripts/verify_backup_wild240.sage --all`. Full run outcome:

- ALL15 generic charts have basis[1], each about2.7--4s.
- Fourteen infinity charts have basis[1], each about0.03s.
- E=u-alpha, infinity has the exact basis

      b0²,
      r0-r1+(alpha+2)b0,
      a0+alpha,
      a1+(alpha-1),
      a2-1,
      b1,
      lambda.

  Thus every residual point has lambda=0, contrary to the actual local
  invariant lambda=3/a^4!=0. This last chart is excluded on its required
  geometric open; its UNSATURATED ideal is not the unit ideal. The script
  checks lambda membership exactly and reports this distinction.

These exact ideals over F125 control all algebraic-closure solutions,
not just F125 points. The audit independently replayed the exceptional
chart and a generic chart, and checked the geometric necessity of the
full system. No unlocalized unit ideal is claimed for the exceptional
chart, and no explicit unit-multiplier file is claimed.

[Audit](../Research/audits/BACKUP_WILD240_TWIST_AUDIT_2026_09_10.md).
