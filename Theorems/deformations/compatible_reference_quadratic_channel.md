# The quadratic fourth-Hodge obstruction at a compatible reference

Version4,2026-09-13. The general quadratic formula and the additional
uniform nodal cancellation below have independent focused audits.
This concerns one homogeneous channel, not a fifth-lift theorem.

Work in characteristic5 relative to a GENUINE compatible marked third
Witt reference, with its actual preceding filtered object, prescribed
graded map and flat periodicity line. Choose any smooth fourth reference.
Suppose the actual normalized first comparison on the two patches has

    J=[[z^-1,0],[-D(z),z]],
    N=[[-B,A],[-C,B]], B=D(A)/2,
    M=J+5*J*N*n^5+25*L mod125.

Here N is the horizontal nilpotent Cartier-response endomorphism in
the reference output frame, not a matrix inferred from its upper entry
alone. D is regular on the affine patch and D_O=z^2*D is regular on the
formal patch. The normal coefficient line has transition z^2.

For an actual primary kernel direction n choose the regular first
Hodge primitives q_U,q_O satisfying the WHOLE Cech identity

    rho=A*n^5, rho+q_U-z^2*q_O=0.

Then the complete homogeneous quadratic part of the fourth obstruction,
in coefficient-Frobenius parameters, is the class in coker(Psi) of

    Q=-A*B*n^10-2*B*n^5*q_U+(D(z)/z)*(A*n^5+q_U)^2.

Already in ordinary normal H1 this has the simpler representative

    [Q]=(1/2)*[n^5*(A*D(q_U)-q_U*D(A))].

The remainder of the fourth-obstruction function is its reference
constant plus an additive divided comparison. The formula does not
evaluate that additive part. It does not imply Q is zero, or that a
zero class can be divided by5 at the following stage. In particular
q_U/A need not be a permitted regular primitive at the zeros of A.

For the actual genus3 family

    P=u(u-1)(u-2)(u-3), F=P(u-t),
    C:k(C)=k(u,v,kappa), v^2=F, kappa^2=u(u-3),
    A=(t+1)^2*P, eta=du/v, D=v*d/du,
    (t^5-t)(t^2+2t+3) != 0,

retain the compatible reference pulled from the ordinary genus2 endpoint,
its actual flat twist, and the ORIGINAL connected C5^2 torsor T->C.
If its scalar primary symbol is nodal as in
[nodal_first_repair_slice](nodal_first_repair_slice.md), then UNIFORMLY

    [Q(n)] belongs to im(Psi) for every n in ker(Psi).

There is no additional parameter or torsor exclusion. This does not
annihilate Q in ordinary normal H1 or evaluate a later divided carry.

On S=F1(V) intersect K there is a stronger filtered statement: every
polarized Q(n,m) has ZERO entire nil Schur coordinate, not just zero
class modulo(f). Its ordinary Schur source preimage and whole regular
normal boundary primitives can be chosen in F2. This is an ordinary
SCHUR block assertion; no identification with a separately chosen
canonical bijective Fitting summand is required.

More precisely, put S=h^-1({the eight points above u=0,1,2,3}). The
global function gamma_n=D(q_U)-(D(A)/A)*q_U has at most simple poles
on S. For every holomorphic quadratic differential b*eta^2,

    <[Q(n)],b*eta^2> = -sum_(P in S) q_U(P)^2*b(P).

The map n->gamma_n identifies K, fifth-power-semilinearly, with the
kernel of gamma->Cartier(gamma*eta/A)/eta on H0(O_T(S)). In particular
every nonzero n has q_U(P)!=0 at some P in S: q_U/A then has a genuine
double pole. Uniform cancellation follows from the actual polarized
residue tensor, not by declaring these meromorphic primitives regular.

## Maximal elementary rank125 cover: filtration, not full cancellation

For the SAME genus3 family and compatible reference, now take its
original maximal G=C5^3 cover X->C. Put R=k[G], J=augmentation,
F_d=Ann(J^(d+1))=J^(12-d), and K=ker(Psi). Assume the actual scalar
Schur germ has type uv+w4, so dim K=43 and J8 subset(f). The full
source/dual symbol and whole-primitive hypotheses above are retained.
For 0<=a,b<=7, the entire nil Schur coordinate satisfies

    pi_nil Q(F_a intersect K,F_b intersect K) subset F_(a+b-3),

where F_d=0 for d<0. Hence its obstruction projection vanishes if
a+b<=7. If a+b<=6, an actual source preimage and WHOLE regular normal
primitive can be chosen in F_(a+b). In particular Q on the16-dimensional
F3 intersect K admits repairs in F6. This controls one homogeneous
channel only, not its next integral carry or the fourth-admissible locus.

Full cancellation on K is FALSE for this rank125 cover. At t3+t+1=0
there exist genuine kernel directions n_s and a genuine holomorphic
quadratic differential gamma_R in the primary annihilator with

    <Q(n_s),gamma_R>=(4+t+3t2)*s2 !=0 for s!=0.

Here s is AFTER coefficient-Frobenius transport; scaling an original
source by c instead gives c10 dependence. The proof specifies the
original AS basis, kernel jet and dual test. It also records a nonzero
jet which passes the COMPLETE fourth-obstruction quotient modulo
(f)+J5, using the actual additive comparison, marked involution and
audited degree-four cross map. Its25 kernel completions must still
kill18 remaining obstruction coordinates. No complete W4 lift,
W5/W6 lift, rank125 bootstrap or geometric counterexample is asserted.

[Proof and evidence](../../Solutions/deformations/compatible_reference_quadratic_channel.md).
