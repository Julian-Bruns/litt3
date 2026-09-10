# Proof: retaining the jet extension produces a nonzero higher obstruction

[Statement](../Theorems/Thm_explicit_genus_two_witt_obstruction.md).
User-supplied Pro construction,2026-09-10; root replay and integration.
Scoped medium audit PASS /root/audit_explicit_w3_obstruction,
2026-09-10, no blockers. Audit is reference-only at
Research/audits/EXPLICIT_GENUS_TWO_W3_OBSTRUCTION_AUDIT_2026_09_10.md.
Finite-field admissibility and tangent inputs are inherited from
genus_two_active_critical_quartics v2, not re-proved here.

## 1. Geometric dictionary and the first lift

The [higher inverse-Cartier construction, LSYZ Section5](https://arxiv.org/html/1404.0538#S5)
uses the entire tuple after Definition5.5, first forms the weight-rescaled
p-connection, then uses local Frobenius pullback and Taylor gluing.
The underlying weight-rescaling construction is in
[LSZ Section5](https://arxiv.org/pdf/1311.6424v2), pp30--35.
We use this construction, not a naive lift of the nilpotence equations.

Put D=v d/du, h=4t+3, S=u(u-1)(u-2)(u-3), H=u-h,
B=(3u-2t-h)/2. On the ACTUAL canonical double write

    w^2=u-t, y=v/w, a=wH, b=yB.

The pair has companion connection d-[[0,1],[P,0]]eta. Here Da=b,
Db=Pa. Take the degree-bounded Bezout solution

    (u-t)H^2 p0 + S B^2 q0=1, deg p0<=5, deg q0<=2,
    c=-b q0, d=a p0.

Then ad-bc=1. Put mu=4+4t. The comparison frames are

    SU=[[a,mu*c],[b,mu*d]],
    aO=z^4 a, bO=z^5(zb-(Dz)a),
    SO=[[aO,-mu/bO],[bO,0]].

All columns are anti-invariant under w->-w. SU is invertible on the
whole affine double, SO near infinity. H1 is the jet realization
twisted by kappa=O(W_t-O). The PREVIOUS object H1 tensor kappa used
by the higher functor is therefore the untwisted jet realization.
This explains the later jet matrix without splitting kappa on C.

Use A3=(Z/125)[T]/(T^4+4T^3+T^2+4T+3), with its actual Witt automorphism

    sigma(T)=122+113T+25T^2+10T^3.

The reference curve has the same displayed equation with T in place
of t. On its affine patch construct a regular sigma-semilinear
Frobenius FU by two Hensel corrections, starting at FU(u)=u^5,
FU(v)=vF^2. At order 5^j solve

    Ej=(F^sigma(FU(u))-FU(v)^2)/5^j mod5,
    Ej+(F')^5 Aj=0 mod F^3,
    Bj=(Ej+(F')^5 Aj)/(2F^3),

and add 5^j Aj,5^j v Bj to the two images, j=1,2. Coprimality of
F,F' makes this polynomial recipe valid. At infinity use FO(z)=z^5.

Write eta=e(z)dz. The first extension representatives are

    fref=-e(z)^5(FU(z)-z^5)/5 mod5,
    fop=(zd-(Dz)c)/(zb-(Dz)a).

Reducing in k((z))/(k[u,v]+z^10 k[[z]]) gives the uniquely determined
scale mu and deformation coefficient

    xi=(2+4t+t^2+3t^3)z^-3+(3+3t+t^3)z^-1+(4+3t^3)z.

The script constructs the actual affine coboundary xU and regular xO
with mu*fop-fref-xi^5=xU-z^10*xO. Crucially it also verifies flatness:

    mu*beta-dxU=-dFU(u)/(5FU(v)) mod5,

where beta=d*dc-c*dd+(-d^2+Pc^2)eta. Thus the selected first curve
lift is identified through the FL CONNECTION, not only its bundle.
All coefficient transport is sigma-semilinear. A reference C3 above
this canonical C2 is obtained by overlap gluing

    tau=exp(5xi D)=1+5xi D+(25/2)(xi D)^2 mod125.

Formal patching at O computes the coherent obstruction and this marked
nilpotent curve deformation. No analytic algebraization assumption is used.

## 2. The higher matrix: the order-five jet entry cannot be dropped

The original jet-coordinate transition is J=[[z^-1,0],[-Dz,z]]. Put

    A=tau*eta/eta=1+5Dxi+(25/2)D(xi Dxi), q=z sqrt(A).

The weight-rescaled connection and transition modulo25 are

    tilde(nabla)=5d-eta E12,
    Jtilde=[[q^-1,0],[-5A^-1 Dq,q]].

The oper potential occurs with factor25 and disappears, but the jet
extension occurs with factor5 and SURVIVES. The transition can also
be verified directly by p-connection compatibility: q^2=z^2 A makes
its diagonal derivative terms cancel; differentiation of its bottom
entry contributes25. The O-chart Higgs coefficient is eta/z^2.

Set alpha=tau FU, beta0=FO tau, Delta=(alpha(z)-beta0(z))/5. Taylor
gluing gives the upper entry

    m=-beta0(e)Delta-(5/2)beta0(e')Delta^2 mod25.

The nth iterated p-connection has divisibility at least5^(n-1) on
the weight-one vector. For n>=3, n-1-v5(n!)>=2, so no omitted higher
Taylor term survives. Put

    j11=FO(q^-1), j21=-5FO(A^-1 Dq), j22=FO(q),
    G=[[j11,j11*m],[j21,j21*m+j22]].

Lift IU=[[1,xU],[0,1]]SU^-1 and IO=[[1,xO],[0,1]]SO^-1 on their
respective charts. xU MUST be lifted as an actual affine polynomial,
not a coefficientwise Laurent lift. The script does so. Then

    Gamma=IO^-1 G tau(IU), Gamma mod5=J.

The original Hodge line is the second coordinate. Its local correction
equation is Gamma12/5+z^-1 uU-z uO=0. Hence the obstruction in the
tangent frame eta^-1 is exactly rho=z Gamma12/5 mod5, modulo
k[u,v]+z^2 k[[z]]. Both anti-invariant comparison factors cancel;
rho descends from the nonsplit double.

## 3. Exact value and a useful cancellation

The reduced coefficients of rho in z^-3,z^-1,z are

    (1+4t+2t^2, 1+t+t^3, t+2t^2+2t^3).

Pairing with the inherited Serre weights (3t^2+t+1,3t+4,3) gives

    lambda=3+4t+4t^2+3t^3, (4+4t)lambda=1.

For interpretation, let calB=(IO)12 mod5. Its needed jets are
3+4t z^2+(4+4t+3t^2)z^4. The portion proportional to j21 is

    rho_jet=mu z^7(Dz)^5 calB^2.

Its reduced coefficient vector is

    (2+2t, 2t+2t^2, 2+4t+4t^2+2t^3).

The rest is (4+2t+2t^2,1+4t+3t^2+t^3,3+2t+3t^2) and has total
phi-residue ZERO. This does not mean the quadratic Taylor term alone
has zero residue: deleting only it changes the answer. The decomposition
depends on frames and Frobenius lifts; the total cokernel class does not.

## 4. Reproduction and evidence scope

The original attachment is preserved byte-for-byte as
[compute_genus2_w3_obstruction.py](../scripts/compute_genus2_w3_obstruction.py).
SHA256:35974221c69c86a843af87afcb4e225f9cdb35a4397c17e7b69b20a8a057d9e9.
It uses NumPy integer arithmetic, no numerical approximation or network.

    OPENBLAS_NUM_THREADS=1 python3 scripts/compute_genus2_w3_obstruction.py --precision 500
    OPENBLAS_NUM_THREADS=1 python3 scripts/compute_genus2_w3_obstruction.py --precision 800 --frobenius-variant 1

Both local replays passed. Obstruction computation after startup took
0.67s and1.56s respectively; these are not full replay wall times.
The fresh auditor independently replayed precision500 in2.57s wall time.
Certified absolute rho precision is71. Checks include regular affine
Frobenius, flat first-lift identification, reduction to J, independent
unreduced residue, three reference-C3 basis variations and local affine
Frobenius changes. The two main runs give identical reduced rho and
lambda despite changing the affine Frobenius lift.

The proof depends on the geometric construction in Sections1--2, not
only on a final expected-value assertion. This is exact arithmetic plus
prose audit, not formal proof-assistant verification.

## 5. Transfer to actual finite etale covers

Lift h:T->C to an arbitrary reference C3 above its canonical C2. First
FL functoriality and higher inverse-Cartier naturality identify the
upstairs construction and give epsilon(T,h*r)=h*epsilon(C,r).

Trace commutes with Psi. Pass to a Galois closure of this ONE leg;
there pullback of trace is the sum over embeddings. Psi is additive
and commutes with each. Individual negative-H1 pullback injectivity
then descends the equality. This uses no averaging by the closure's
order and no presumed simultaneous Galois closure.

When 5 does not divide deg(h), trace divided by deg(h) splits pullback
on the two-term Psi complexes, hence on their cokernels. Therefore a
nonzero epsilon persists. If the other actual leg matches an ordinary
connection, lifting that leg to its canonical B3 gives a compatible
upstairs Hodge lift and epsilon(T)=0. This forces5|deg(h).

For degree divisible by5 the trace is not a splitting. No persistence
claim is made there. Nor does epsilon=0 imply that two endpoint lifts
match on their common source. The independent source-kernel obstruction
of forced_canonical_witt_endpoint is retained.
