# Proof: the actual corrected Hodge frames give a nonzero fourth obstruction

[Statement](../../../Theorems/deformations/cyclic_descent/neutral_five_fourth_obstruction.md).
Returned Pro calculation, integrated2026-09-11 by /root. Bounded
independent audit PASS by /root/audit_neutral5_returned_w4.

## 1. Original cover and marking

The already audited model is T:Y²=G(s), with G squarefree of degree13,
and the ORIGINAL map is u=N(s)/D(s), v=J(s)Y/d(s)^5, D=d².
Its Hodge input and ordinary target row are in
[the small-model data](../../../Research/computations/neutral5_hyperelliptic_hodge.json).
Set omega=ds/Y=e(z)dz, z=s^6/Y, partial=Y*d/ds and j=z^5.
The original differential frame is

    h*(du/v)=f omega,       f=-(t²+2)D.

In this frame the actual pulled-back potential is

    P_T=f²P_C(N/D)-partial²(f)/(2f)+3partial(f)²/(4f²).

It is a polynomial of degree10. Factor N-tD=n5(s-t^5)b2² and put

    w_*²=s-t^5,  K=d*b2*(N-h0D),  a_*=w_*K, b_*=partial(a_*),
    mu_*=mu/(n5(t²+2)^4)=1+t+3t²+4t³.

Then partial(b_*)=P_T*a_* and a_*²/mu_*=A_T, the established Hodge
multiplier. The equality

    sqrt(u-t)=sqrt(n5)*b2*w_*/d

identifies the actual periodicity double. Its anti-invariant frames are
retained; no global trivialization of the two-torsion line is made.

The coefficientwise curve G over W4 is only an auxiliary chart. A
regular affine Frobenius is constructed by three polynomial Hensel
corrections, while the formal-chart Frobenius sends z to z^5. Coefficients
are transported by the UNRAMIFIED automorphism, with

    Phi(T)=(122,113,275,510) modulo625.

This is not fifth powering modulo25 or625. The first comparison solves
the actual flat extension equation, not merely a Hodge-projected equation.
It gives the original marking exp(5xi1*partial). The full first-extension
map H1(T_T)→H1(T_T^5) has rank15. Its injectivity, the flat comparison,
and functoriality identify this reconstructed marked T2 with the original
pullback of C2. The independent auditor rebuilt this entire comparison
using exact rational functions and independent coefficient arithmetic.

## 2. Corrected preceding Hodge object

Solve the actual primary equation on the reconstructed T2 to obtain
xi2. The chosen third curve, and a smooth fourth reference, use

    tau=exp((5xi1-25xi2)partial) modulo625,

with the cubic exponential term retained. The two eleven-coordinate
digits are serialized in each fresh run. The chosen third origin need
not be the old T3ref: it is SOME point of the original complete T3(b)
line. The independently proved parameter-independence theorem applies
to that line and is the reason this is sufficient.

Let I_U,I_O be the original flat-comparison matrices. The primary
normal cochain rho2=j*(Gamma2)_12/5 is an actual coboundary, and the
calculation solves

    rho2+u_U-j²u_O=0.

Here u_U is a genuine affine function, not a truncated principal part;
u_O is regular on the formal chart. Set

    h_i=I_i(e2+5u_i e1),
    W_i=det(-nabla_(partial_i)h_i,h_i),
    m_i=(mu_*W_i)^(-1/2),
    I_i^(2)=[-nabla_(partial_i)(m_i h_i), m_i h_i].

These are the corrected PRECEDING filtered frames. Their determinant
is1/mu_*. The complete W2 jet transition, including the new prescribed
grading, is checked. Independently, the auditor reconstructed all four
affine entries as polynomials in the actual double algebra over W2 and
checked determinant, covariant-derivative normalization and the repaired
Hodge line exactly. The formal-chart normalization was independently
checked through exponent180.

Thus the higher construction below uses a genuine compatible preceding
filtered object, rather than an unglued graph or the mod-five Higgs
bundle alone. This is the full-input construction in
[LSZ Theorem4.1 and Lemma4.10](https://arxiv.org/html/1311.6424v4#S4);
the normal obstruction is the one in
[LSYZ Theorem6.2](https://arxiv.org/html/1404.0538v2#S6).

## 3. Actual fourth normal cocycle

The preceding scalar's first unknown higher digit is killed by its
factor25 at the precision used here. The rescaled connection is

    5d-omega E12-25P_T omega E21 modulo125.

Put a=tau*omega/omega, q=j*sqrt(a) and

    Jtilde = [[q^-1,0],[-5a^-1 partial(q),q]],
    Delta=(tau F_U(z)-F_O tau(z))/5,
    E_i=F_O tau(d^i e/dz^i), Pi=F_O tau(P_T).

The full Taylor matrix modulo125 is

    [[1+25 Pi E0² Delta²/2,
      -E0 Delta-5 E1 Delta²/2-25(E2+Pi E0³)Delta³/6],
     [-25 Pi E0 Delta, 1+25 Pi E0² Delta²/2]].

All omitted terms have valuation at least3 because
n-1-v5(n!)>=3 for n>=4. The matrix is also reconstructed by independent
iteration of the p-connection within each full run. Form

    G3=F_O(Jtilde)*Taylor,
    Gamma3=(I_O^(2))^-1 G3 tau(I_U^(2)),
    rho4=j*(Gamma3)_12/25 modulo5.

Every division is checked for integrality. The actual next flat
connection glues modulo125. The final cochain has certified absolute
precision779 in the standard run and1051 in the changed-Frobenius run;
the residue only needs exponents through9.

## 4. Value and its meaning

In the ordered eleven positive tangent coordinates Y/s^i, the reduced
normal representative, with coefficients in (1,t,t²,t³), is

    (1,3,1,3), (0,2,0,2), (0,2,1,4), (1,0,2,4),
    (3,3,4,3), (4,2,1,4), (4,2,4,1), (3,1,4,4),
    (2,3,4,4), (1,3,1,0), (1,0,2,1).

Its ordinary pairing with the SAVED obstruction_dual row is
(1,0,0,3). Independently the unreduced residue

    Res_(z=0) rho4 * (-1/2 sum_(i=1)^11 Lambda_i s^(i-1))*omega

has the same value. There is no additional coefficient Frobenius in
this pairing. The inverse identity

    (1+3t³)(2+4t²+4t³)=1

proves nonvanishing over the algebraic closure.

The full cochain decomposition in these frames has scalars

| Contribution | Scalar |
| --- | --- |
| Divided linear carry | 3+t |
| Quadratic first-frame repairs | 4t+t²+2t³ |
| Weighted jet entry | 4t+4t²+t³ |
| Cubic Taylor derivative | 3+t |
| Preceding potential | 0 |

Their sum is1+3t³. The preceding-potential COHOMOLOGY VECTOR is not
zero; it is its pairing that vanishes. The quadratic contribution is
nonzero and cannot be discarded by the degree-one repair argument.
Individual summands are frame-dependent; their total class is not.

The parameter-independence theorem gives this same obstruction for
EVERY compatible third lift of the original marked T2. By the actual
curve-variation formula, changing a smooth fourth digit only changes
rho4 by a Psi image. Hence its nonzero cokernel class excludes every
compatible fourth extension, and therefore every full tower.

## Reproducibility and independent scope

The original returned archive SHA256 is
aef014da9e4dce4eb151cb1ff856cdc25dc27ec81e76c928bbddcb2330224057.
It is retained at
`/Users/julian/Documents/litt3-computation-data/neutral5-w4-returned-20260911-XhB3sN`.
Its86-file manifest was checked without modifying the shipped files.
The complete source compute_neutral5_w4.py has SHA256
aaeb904425e3bce90e7b4bd23ebb6e665e2fa1baf595691834ac523689ed88fb.

Root read the producer and arithmetic modules completely, then executed
FOUR fresh full comparisons: baseline3500 (43.25s), changed affine
Frobenius3800 (45.31s), nonzero kernel shift t (45.48s), and coefficient
conjugation (45.06s). All pass. The first two give the same entire vector;
the kernel shift changes the vector but preserves the scalar. Conjugation
gives exactly(1+3t³)^5=3t+2t²+t³.

Fresh outputs, source hashes and comparison assertions are recorded in
[the replay receipt](../../../Research/computations/neutral5_w4_fresh_replays_20260911.json),
verified by scripts/deformations/cyclic/record_neutral5_w4_replays.py. This is a comparison
of fresh full executions, not a substitute for generating their cocycles.
The separate auditor's independent coefficient, first-marking, jet and
corrected-frame computations and precise scope are recorded in
[the audit](../../../Research/audits/RETURNED_NEUTRAL5_W4_AUDIT_2026_09_11.md).
No claim of a second independent full higher-transform implementation
or Lean verification is made.
