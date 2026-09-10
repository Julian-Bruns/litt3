# Returned W4 defect formula: evidence and geometric comparison

2026-09-10. Pro returned a positive calculation, not a failed run.
The original prompt is PRO_DEFECT_LINE_NEXT_WITT_REQUEST.md. Its
mathematical contents and normalizations remain unchanged. A focused
medium geometric audit returned GAPS, not a counterexample:
[audit verdict](audits/W4_DEFECT_COMPARISON_AUDIT_2026_09_10.md).
The algebraic certificate has independently replayed. The polynomial
remains a CANDIDATE, not a proved higher inverse-Cartier obstruction.
The missing point is the linear order25 carry from correcting the
Hodge generators: it can contribute to z^5 and is not eliminated by
oddness. Identifying the actual lifted dual normal line and its Serre
trace could justify cancellation, but that comparison is not supplied.
The canonical reference's claimed flat identification also needs proof.

## Result and scope

For the bad double C→Y in the prompt, put q=(t+1)² and let beta be the
unique fifth root of

    R(t)=3(t+1)^10+2(t+1)^8+1.

The CONDITIONAL claimed obstruction, up to a nonzero scalar depending only on t,
is P_t(z)=z-beta*z^5. Its derivative is1. On t^5-t!=0 it has only the
root0 at the eight roots of

    E=t^8+3t^7+t^6+4t^5+2t^4+4t^3+3t²+1,

and otherwise has the five simple roots alpha*F5, alpha^4=beta^-1.
The certificate verifies R=3(t-1)(t-2)E and irreducibility of E.
Thus the MAIN high-degree parameter is in the five-root case.

The four nonzero roots permit a filtration-compatible W4 step, if the
geometric comparison is correct. Their continuation to W5 or a full
tower has NOT been proved. Nor do they construct a common cover or
contradict the independently proved main-pair Galois-defect1 exclusion.

## Replayed evidence

Source: scripts/w4_defect_algebra_certificate.py, copied BYTE-IDENTICALLY
from the user attachment. SHA256:
cfca259964b3608749e5d3adc92cb815b1fcaf3da94b757a7c29e60ee3ad5366.

    sage -python scripts/w4_defect_algebra_certificate.py

All checks PASS in about0.58s including startup, one process. System
python3 lacks SymPy; the installed Sage Python has it. No installation
or repeated numerical sampling was needed. The source uses exact
SymPy arithmetic and explicitly limits its certification to algebra.

At t^4+4t^3+t²+4t+3=0 it verifies

    beta=3t²+t+2, alpha=2t³+t²+1, beta*alpha^4=1.

## Geometric construction claimed in the answer

Change coordinates x=kappa/u, y=gamma*(1-x²)². Then y²=D with

    D=(1-x²)(x²+2)(2x²+1)(t*x²+3-t),
    a_x*D²=3q(x^6+x²)=S,
    v0=2(y/x)*partial_x, phi=4(dx)²/y.

The two points above x=0 give the normalized Serre residue1. Retain the
full previous filtered tuple and its lifted flat order-two twist.
In an oper frame with e2=nabla_(partial_x)e1,

    nabla=d+[[0,r_x],[1,0]]dx,
    tilde_nabla=5d+[[0,25r_x],[1,0]]dx.

The reference local inverse-Cartier connection modulo25 is asserted to
be d+N*x^4 dx, N=[[0,0],[1,0]]. Its comparison with the oper frame is

    J=[[f,f'],[g,g'+x^4*f]], det J=1,
    J'=J*A_oper-x^4*N*J.

Represent the W3 displacement by x_U=x_D+25*Z*v. Coefficient
Frobenius is sigma(Z)=Z^5. The divided Frobenius difference modulo125 is

    Delta=25*Z*x^4*v-5*Z^5*F_x(v).

The jet correction includes (25*Z^5/2)*diag(1,-1)*F_x(v'). Conjugating
the Taylor/jet matrix by J gives the lower-left normal cocycle

    25*Z*v-5*Z^5*(f²*F_x(v)+5*f*g*F_x(v')) mod125.       (1)

The certificate checks this MATRIX IDENTITY with independent formal
variables; it does not itself construct J or the reference flow.

The preceding scalar oper's 5*Z^5 change is multiplied by25 in the
weight-rescaled connection and so disappears modulo125. For divided
Taylor order j>=4, j-1-v5(j!)>=3; the remaining denominators are units.
The lower order-five cocycle is a coboundary because Psi(v0)=0.
The required local Hodge corrections are proportional to5*Z^5;
their products can produce only Z^10 in addition to Z and Z^5.
The actual involution makes the scalar odd and eliminates Z^10.
These precision and input-comparison claims are essential audit points.

Writing F_y=F_x(y), the resulting finite-jet formula is

    beta=([x^4](f²*F_y/y)/5 mod5)-[x^9](f*g*D²).        (2)

The coefficient2 in v0, coefficient4 in phi and both poles contribute
the factor16=1. F_y²=tilde_D^sigma(x^5); coefficient Frobenius must
not be suppressed.

## Reference digits and finite jets

Normalize branch lifts0,1,infinity, and write b=2+5b1, c=3+5c1,
tau=t mod5. In the u-Frobenius frame the Hodge vector is f(1,h),
with h'=1/a-u^4, deg h<=7, h(0)=h(1)=0. The unique h has

    h(2)=-2t/q, h(3)=-(2t²+1)/q,
    b1^5=(t²+1)/q, c1^5=(t²+t+2)/q.                   (3)

The latter equations use the integer Fermat quotients1,3 of2,3 and
cancellation at the lifted branch centers. With tilde_G=u(u-1)(u-b)(u-c),
tilde_F=tilde_G*(u-tau), the claimed canonical reference oper mod25 is

    R2=tilde_F''/(4tilde_F)-3/16*(tilde_F'/tilde_F)²+P2/tilde_F,
    P2=-3/4*(u-tau)*tilde_G''+7/8*tilde_G'+5*(u³+Q),
    Q=(t³+t²+2t+1)/(3q)+(2t³-t)/(3q)*u+2t*u².

To identify it, set f0=tilde_G^(-1/2)*(u-tau)^(-1) and require a
horizontal scalar solution f2=f0*(1+5d). The exact identity is

    (R2-f0''/f0)/5 mod5
      =(u³+Q)/F+2*(G'/G)²+3/(u-t)².

The five residue equations uniquely determine Q. The certificate
checks all five and a3x3 minor

    2(t+1)²(t+2)/(t^4(t-1)^4(t-2)^4),

which is a unit on the full parameter domain. Whether these equations
indeed identify the specified canonical reference, with all Frobenius
and previous-flow normalizations, is part of the geometric check.

At x=0 the required divided first jet is

    [x^4](f²*F_y/y)/5=3q*L,
    L=2+3b1+4c1+(1+4Q(3))/(3-t),
    3qL=q(4b1+2c1)+2t²+t.

For the second jet, (g/f)'=1/a_x-x^4 and f*g*D²=S*(g/f). Thus

    [x^9](f*g*D²)=3E8-E4+E0=2(t+1),
    E0=-t²+t+1, E4=2t²-2, E8=t²+2t-2.

Substitution in(2) gives beta=q(4b1+2c1)+2q+1, and(3) gives exactly
beta^5=R(t). All displayed rational identities and specializations
are checked by the attached/replayed code.

## Potential next leverage, not yet a theorem

The affine-additive form suggests using a mixed-characteristic
Bockstein on the defect space, rather than computing one more digit
on the same double. A cyclic5 cover with defect2 has a nontrivial
deck-module relation; its integral carry can constrain which W3
displacements survive to W4. The next target must test this geometry,
not assume that a characteristic-five module automatically defines
the higher obstruction. See the subsequent target-selection record.
