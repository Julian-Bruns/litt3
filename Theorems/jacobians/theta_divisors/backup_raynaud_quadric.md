# The explicit Raynaud quadric for the small genus-two backup

Let C:v^2=F(u)=u(u-1)(u-2)(u-3)(u-alpha), alpha^3+alpha+1=0,
over bar(F5), with infinity O. Write J=Pic^0(C), J1=Pic^0(C^(1)),
Fr:J->J1 for relative Frobenius and V:J1->J for Verschiebung.

For a degree-two Mumford divisor (U,V0), put U=u^2-sigma*u+pi and
V0=v0+v1*u. In the standard Kummer coordinates associated to |2Theta_O|,

    kappa(m)=[1,sigma,pi,w],
    w=v1^2-f2-f3*sigma-f4*sigma^2-f5*sigma*(sigma^2-pi),

where F=sum f_i*u^i. These formulas extend to repeated U by polynomial
continuation; the projective Kummer map also covers the theta boundary.

Define Q=sum_(0<=i<=j<=3) q_ij*K_i*K_j by the following coefficient list,
in order 00,01,02,03,11,12,13,22,23,33:

    1, 1+3alpha+4alpha^2, 4+alpha+3alpha^2, 2+3alpha+4alpha^2,
    4+3alpha^2, 2+4alpha+4alpha^2, 3+alpha, 2alpha,
    2+4alpha+3alpha^2, 4+4alpha+4alpha^2.

Then, for EVERY m in J(k),

    H^0(C^(1),B_C tensor Fr(m)) != 0  <=>  Q(kappa(m))=0.

This is the coefficient-untwisted Raynaud theta equation: on J1 its
coefficients and the defining curve coefficients are raised to the fifth
power. In particular the singleton root test is exactly

    Q(kappa(m))=0,  [5]m=2[P-O],  m of order prime to5,

with P non-Weierstrass. The residual divisor of length16 is on the
ETALE V-pullback, not on the potentially nonreduced [5]-pullback.

More generally, for any ordinary genus-two curve in characteristic5,
Raynaud theta descends to a quadric on its Kummer surface. If evaluation
on the twelve nonzero V-kernel Kummer points has rank9, those points
determine the entire quadric, not only its restriction to the torsion.

Version1,2026-09-08. AUTHOR proof and exact executed linear-algebra
certificate; no independent audit. This does not enumerate or exclude
the singleton residual points and does not prove a common-cover claim.
[Proof](../../../Proofs/jacobians/theta_divisors/backup_raynaud_quadric.md).
