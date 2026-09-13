# Proof: a full-lattice norm carry and relative quadratic filtration

[Statement](../../../Theorems/deformations/cyclic_descent/neutral_five_fourth_parameter_independence.md).
Author /root with bounded independent audit PASS,2026-09-11,
/root/audit_backup_cored_completion. The audit replaced an optional
Smith-coordinate shortcut by the full regular-lattice norm calculation
below. No numerical coefficient was changed or evaluated.

## Actual input objects and first cochains

Compare TWO compatible upper W3 tuples W3(b),W3(b'), not a supposed
compatible lower D3. Their canonical W2 truncation is the same. Choose
a descended smooth reference through W4 and a genuine auxiliary global
filtered oper through W2 extending the original input. Such oper
extensions exist because H1(omega²)=0. Retain the actual flat
square-trivial line and prescribed grading. The reference need not
be inverse-Cartier compatible; its error is retained as a descended
cochain. The actual preceding H2(b) IS global and filtered.

On the actual AS algebra w5-w=f put Pj=polynomials of degree at most j
in w. Translation by sigma(w)=w+1 gives

    P2=e²A, P0=e^4A, P2*P0 subset P2, P0*P0 subset P0.

These identities hold on both charts wO=wU-chi. Differentiation of
the AS equation, coefficient Frobenius and every descended reference
operator preserve these spaces. No claim is made about dividing an
integral augmentation image by5.

The particular tangent repair xi is P2-valued. Its change with b is
P0-valued, pulled back from ker(Psi_C), hence from ker(Psi_D).
The reference error is P0. The first normal comparison is additive
and deck-equivariant, so its exact errors are P2, with P0 differences.

Negative tangent/normal H0 vanishes. The integral Cech H1 is free over
W2[C5], so the integral deck-linear cohomology section supplies a
deck-linear boundary primitive. The unique first Hodge-generator
repairs ell_b consequently satisfy

    ell_b in P2, ell_b'-ell_b in P0.

Restoring the prescribed maximal-Higgs grading uses linear expressions
in ell and its derivative, inverses of units and division by2.
All reduced first frame/scalar corrections have the same filtration.
The periodicity line cancels only in the normal Hom line; its actual
flat transitions remain in the input.

## The complete relative comparison modulo125

The weight-one filtered-and-graded construction has matrices

    Mtilde=[[a_new,5*b_old],[0,d_new]],
    nablatilde=5d+[[5alpha_old,25beta_old],[gamma_new,5delta_old]].

The new graded entries are prescribed, not obtained by dividing a raw
lower-left graph entry. Old data are known modulo25; their first
changes are5 times reduced cochains. Their surviving changes in the
displayed matrices are additive of order25; the beta change is125.
Products of two first old-input changes vanished in the old input
and are not resurrected by this construction. This is the gluing
rule in [LSZ, Theorem4.1 and Lemmas4.7--4.10](https://arxiv.org/html/1311.6424v4).

There is no omitted divided Taylor contribution. In genuine local
oper frames,

    K_j=diag(5,1)*5^j*L_j*diag(5,1)^(-1),
    L_0=I, L_(j+1)=partial L_j+[[0,r],[1,0]]L_j.

Thus v5(K_j)>=j-1. A term with l>=2 changed displacement factors
5*zeta has valuation at least

    l+j-1-v5(l!)-v5((j-l)!) >=3.

It vanishes modulo125, including when a factorial is divisible by5.
Mixed changes with the order25 tilde variation also vanish. Nonlinear
coordinate changes begin at25² and, even after the single Frobenius
division, vanish modulo125. In normalized oper frames the previous
scalar occurs through25r, so its first change5*delta_r is invisible.
General frames can retain additive order25 terms; these are included.

The remaining terms are (i) the divided integral first linear carry,
(ii) additive last-digit filtered/graded changes, and (iii) ordinary
quadratic products of first frame/graph changes. For the latter, put
Ri=I+5ell_i E21 and G=G0+5K+25L. Its normal entry is

    5(K21+D ell_i-A ell_j)
      +25(L21+K22 ell_i-K11 ell_j-B ell_i ell_j) mod125.

The first bracket must be repaired BEFORE its remainder is divided.
In the quadratic bracket every relative term has a P0 difference
and at most one P2 first repair, hence lies in P2=e²A. The additive
relative terms have P0 inputs. Both vanish in the actual cokernel
k[e]/e². Descended reference errors are P0; their constant terms
cancel and their products obey the same estimate. Normal-frame and
graded-restoration changes introduce no further division by5.

## The divided carry on the full free lattices

Let A2 be the actual additive jet/Taylor normal response over W2,
using the descended auxiliary input and the integral Cech sections.
Its reduction is Psi_W; this first variation is the actual Hodge
projection in [LSYZ, Theorem6.2](https://arxiv.org/html/1404.0538v2).
The map A2 is additive and deck-equivariant on full regular lattices.
No Fitting simple-zero condition or unit-block identification is used.

Put N=1+sigma+...+sigma4. The invariant relative tangent class can
be lifted as N*alpha. Its coinvariant reduction is a lower kernel
vector. Consequently

    A2(alpha)=e*zeta+5v

for integral target vectors. Since Ne=0 INTEGRALLY,

    A2(Nalpha)=N A2(alpha)=5Nv.

Its divided reduction is e4*vbar, zero in coker(Psi_W)=R/e².
This is the actual Cech carry: if z is the first normal cochain
and q its integral primitive, z-dq=s cl(z), so the repaired divided
residual represents cl(z)/5. Its reduced primitive is the actual
repair by uniqueness. Changing its next digit adds a boundary;
changing the last curve digit adds a Psi image.

Every term in the relative next obstruction therefore vanishes.
Pullback through the actual degree-two W3(b)→T3(b) is injective on
the obstruction cokernel, so the same equality holds on T3(b).
The remaining scalar epsilon_T(T3(0)) has NOT been computed.

## Exact checks and scope

The focused audit checks the full actual comparison, including the
incompatible auxiliary reference, with no new hypothesis. The script
scripts/deformations/cyclic/audit_neutral5_parameter_independence.py independently verifies
the graph identity, relative AS products, integral norm identities
and124750 mixed Taylor inequalities throughj500. The all-order bound
is proved above, not inferred from that finite test. Its receipt is
Research/computations/neutral5_parameter_independence_audit.json.

The base Fitting nilpotent subspace has dimension2, despite defect1.
Nothing here imports the earlier simple-zero cyclic descent theorem.
This result reduces the remaining exact fourth-level calculation to
ONE scalar and supplies neither a higher lift nor a common span.
