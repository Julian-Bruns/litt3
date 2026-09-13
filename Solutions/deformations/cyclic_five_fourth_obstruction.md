# Proof and evidence for the selected cyclic-five fourth obstruction

[Statement](../../Theorems/deformations/cyclic_five_fourth_obstruction.md).

## 1. Original cover, marking, and complete first plane

The AS equation and shift in the statement have a regular infinity
remainder. Its exact rational numerator/denominator, the full15x15
Hodge matrix, and all first-lift vectors are in
[the primary inputs](../../Research/computations/cyclic5_small_field_fourth_inputs.json).
Their two independent Laurent precisions220/300 agree. The coefficient
field is F625; geometric deck translations split over F_(5^8). The
five formal branches are represented without choosing roots by the
finite etale algebra W4(F625)[s]/(s^5-Hs). Its Hensel Frobenius has
Phi^4(s)=-s and Phi^8(s)=s. The coefficient Frobenius is

    Phi(T)=(122,113,275,510) mod625,

not the fifth power of T. The nonzero AS class gives the connected
degree-five etale cover, hence genus six. The actual Hodge matrix has
rank13 and Smith factors (1,1,e²); ordinary trace kills the AS degrees
below four and sends w_U^4 to -H.

The first marked curve digit is the original xi_C from the standalone
base calculation. For Xi=xi_*+d nu_d+b nu_b, use the smooth fourth chart

    tau=exp((5xi_C-25Xi)D) mod625,       D=eta^-1.

The minus sign agrees with rho(S+xi)=rho(S)-Psi(xi). The original
nonsplit flat double w_spin²=u-T is retained; its comparison matrices
are anti-invariant on that double. In particular the twist is not
replaced by a trivial line. The first flat comparison explicitly
recovers the prescribed xi_C, so the coefficientwise reference curve
is not silently used as the original marked second lift.

## 2. Corrected preceding Hodge object and actual fourth cochain

Write eta=g(z)dz. At Xi=xi_*, the complete15-coordinate reducer gives
genuine affine/formal primitives rho2+u_U-z²u_O=0. With the original
flat matrices I_U,I_O, put

    h_i=I_i(e2+5u_i e1),
    W_i=det(-nabla_(D_i)h_i,h_i), m_i=(mu W_i)^(-1/2),
    I_i^(2)=[-nabla_(D_i)(m_i h_i), m_i h_i].

These actual corrected Hodge frames are the input of the next step.
For A=tau*eta/eta, q=z sqrt(A), f=F_O tau and
Delta=(tau F_U(z)-F_O tau(z))/5, the weight-one jet transition is

    Jtilde=[[q^-1,0],[-5A^-1 Dq,q]].

The entire Taylor matrix mod125 is

    [[1+25 f(Pg²)Delta²/2,
      -f(g)Delta-5 f(g')Delta²/2-25 f(g''+Pg³)Delta³/6],
     [-25 f(Pg)Delta,1+25 f(Pg²)Delta²/2]].

The recurrence K_(j+1)=5K_j'+B0 K_j, B0=-[[0,g],[25Pg,0]], supplies
these terms. All omitted j≥4 terms have valuation at least3 even
after division by j!. This is the actual filtered/graded construction
of [LSZ Section4](https://arxiv.org/html/1311.6424v4#S4), followed by
the [LSYZ normal obstruction](https://arxiv.org/html/1404.0538v2#S6).

Set G3=F_O(Jtilde)*Taylor and Gamma3=(I_O^(2))^-1 G3 tau(I_U^(2)).
The full preceding jet transition is checked mod25, not merely its
Hodge entry. The next normal representative is

    rho4=z*(Gamma3)_12/25 mod5.

An independent graph expression separates its cohomology class into

    (z*(N3)_12/5+tau(u_U)-z²u_O)/5
       + z(a11*u_U-u_O*a22) + z*(Dz)*u_O*u_U,

where N3=I_O^-1 G3 tau(I_U), a11=((N3)_11-z^-1)/5 and
a22=((N3)_22-z)/5. It follows by expanding the exact upper-right
overlap in the unnormalized repaired line frames. Normalization adds
a boundary. Both constructions are evaluated in both obstruction rows.

## 3. Evaluation and all-parameter conclusion

Only the AS-degree-four part is seen by ordinary trace. Its three
coordinates, in z^-3,z^-1,z, are

    (1+2t²+4t³, t+4t²+3t³, 3+4t+2t³).

Contracting with -H*Lambda_C gives (4,2,2,4). Independently the unreduced
residue with Q_Lambda=u²+(t+3)u+2t²+4 gives the same value. In the fixed
comparison frames, the trace contributions are

    divided carry: 1/mu=(3,4,4,3),
    mixed first repair: (0,3,3,0),
    first-repair product: (1,0,0,1).

Their sum is3/mu=(4,2,2,4). The repair contribution2/mu is nonzero and
must not be dropped. Individual contributions depend on frames, while
their sum in the normalized obstruction quotient does not.

The separately audited
[secondary-trace constancy lemma](cyclic_five_secondary_trace.md)
applies: first repairs have AS degree≤2, kernel differences degree≤1;
relative quadratic products have degree≤3 and relative divided linear
carry remains in e after integral saturation. Hence E0(d,b)=E0(0,0)
for ALL geometric parameters. Six sample executions alone would not
prove this quantifier. The exact identity

    (4+2t+2t²+4t³)(3+3t)=1

excludes every fourth lift. The returned equation with this nonzero
scalar equal to0 is the defining impossible locus equation, not a
contradictory field identity or a coefficient typo.

## 4. Exact finite heights

The given first source has compatible third lifts but no fourth, so
H(T_1)=3. Every cyclic5-power refinement has defect two by
abelian_p_defect_node. Each degree-five step T_a→T_(a-1), a≥2, is
therefore Galois and defect-neutral. Pullback on the actual next
obstruction cokernel is zero: equivalently its nonunit cyclic Smith
factors have length one. Naturality allows one extra repaired upper
digit above a maximal lower lift, giving H(T_a)≥H(T_(a-1))+1.

Conversely, neutral_galois_witt_descent recovers the preceding GIVEN
upper truncation from one additional compatible digit. Iterating from
the original marked W2 data rules out length H(T_(a-1))+2 upstairs.
Thus H(T_a)=H(T_(a-1))+1=a+2. This upper-bound argument concerns every
upper repair, not only those chosen by pullback.

## Provenance and independent verification

Returned archive SHA256:
f161629a84a5d3d7e456b131b3847219f1df69a501c1d897e8e50e6ef7bcd48c.
Immutable source directory:
`/Users/julian/Documents/litt3-computation-data/cyclic5-w4-returned-20260911-JsDjLw/cyclic5_fourth_certificate`.
Its manifest checks26 files; the primary JSON is byte-for-byte identical
to the original submitted input. compute_fourth.py SHA256:
81799befe2c277f876ed1fa9ae66d862cdbae2348073fa2f5c62a2971f72c1b1.

Root read the complete source, ran all six cases into a separate fresh
directory, and compared every algebraic receipt field to the shipped
receipt. Precision1200/1500/1800, changed affine Frobenius, (d,b)=(t,t²),
and a fourth-digit sign test all PASS, in31.0s total using two workers.
Certified rho precisions were59/359/659/355/359/319 respectively.
The second coordinate changes to(1,2,4,4) at(t,t²), as expected; only
the first is asserted constant. Original source and receipts remained
unchanged. Root independently checked the field contraction, inverse,
and decomposition sum using standard-library arithmetic.

[Fresh replay receipt](../../Research/computations/cyclic5_w4_fresh_replays_20260911.json),
produced by scripts/deformations/cyclic/record_cyclic5_w4_replays.py, separates computational
scope from the [independent geometric audit](../../Research/audits/CYCLIC5_FOURTH_LIFT_AUDIT_2026_09_11.md).
The latter covers the actual AS model/marking/twist, all-parameter
comparison, and height consequence; it did not duplicate the six
full numerical runs. No independent second full engine is claimed.
