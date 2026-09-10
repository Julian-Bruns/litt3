# Next target selection: the initial dihedral quadratic carry

2026-09-10,15:24CEST. New bounded research, not an asserted higher
descent theorem. The preceding C10/full D5 result is already proved
and audited. No Pro request is outstanding yet.

## 1. Why this target is different and useful

The compatible-object relative comparison at n>=3 uses only cyclic-five
deck data, the actual simple-zero base, full previous tuple and integral
cochain freeness. Its proof does not use the commuting double involution.
The INITIAL n2 comparison does use that involution: in the C10 case all
first defects are odd and the quadratic correction is even, hence its
projection vanishes. In a D10 carrier the two signs differ. There is an
actual new quadratic coefficient to evaluate, not the former W5 lower-
reference transfer renamed. A vanishing result could provide the missing
initial step for the next carrier shape; a nonzero coefficient would
produce surviving initial lifts and show exactly where the mechanism
breaks. Neither is a common-cover verdict.

## 2. An actual simple equation for the whole D10 family

Over k of characteristic5 put

    R=u(u-3), S=(u-1)(u-2)(u-t), F=RS,
    H=t²+2t+3,
    C:k(u,kappa,gamma), kappa²=R, gamma²=S,
    Y:v²=F, v=kappa*gamma.

Let E:gamma²=S. It is ordinary when H!=0. Set

    T:k(u,kappa,gamma,w),
    w^5-H*w=gamma*(u+4-2t).                              (1)

This is the pullback of E's etale degree-five Verschiebung cover.
To check the etale assertion directly, use z=u/gamma at E's infinity.
The affine RHS is the affine part of z^-5-H*z^-1; its remainder has
positive valuation because H=[u^4]S². Thus w_O=w_U-z^-1 has a regular
AS equation at infinity. On the affine patch the derivative is -H.
The H1(O_E) class z^-1 is nonzero, so the cover is connected; over kbar
choose lambda^4=H to normalize its translations to w→w+lambda.
The ramified quadratic extension C/E and this degree-five extension
are linearly disjoint. Hence T→C is connected finite etale, g(T)=11.

The free involution tau:(kappa,gamma,w)→(-kappa,-gamma,-w)
acts over Y and reverses those translations. Thus T→Y is ACTUAL
etale D10, not the C10 AS pullback from Y previously computed.
The commuting involution j:kappa→-kappa is the ramified elliptic
quotient involution. Its use to split cohomology does not replace
either etale map.

The pulled active connection is the established exceptional one:

    G=u(u-1)(u-2)(u-3), A=(t+1)²G, a=A/F²,
    r=3a''/a+(a'/a)², eta=du/v.

The original flat square-trivial periodicity line is O_Y(W_t-O),
and remains part of the full previous filtered tuple.

## 3. Executed characteristic-five cohomology test

scripts/bad_double_dihedral5_defect.sage implements the actual two-
chart AS gluing. In the D0=eta^-1 frame, the j-odd scalar module is
O_E and its local lattice is z²; Cech representatives z^-1,z.
In the kappa*D0 frame, the j-even scalar module is O_E and the local
lattice is z^4; representatives z^-1,z,z²,z³. Together these give
the six dimensions of H1(T_C), and five AS powers give30 upstairs.
The Psi multipliers are A and A*R² respectively. The local reduction
retains w_O=w_U-z^-1 and w_U^5=H*w_U+gamma*(u+4-2t).

Exact generic computation over F5(t), Laurent precision160, gives:

| frame | size | rank Psi | ranks Psi²,Psi³,Psi4 | tau signs on kernel |
|---|---:|---:|---|---|
| D0 |10|10|10,10,10|none|
| kappa D0 |20|18|16,15,15|one plus, one minus|

Deck-fixed kernel dimension is1. Free cyclic module ranks and actual
semilinear deck commutation were checked through the translation
operator delta: delta*Psi=H*Psi*delta. Geometric deck translations are
exp(lambda*delta), lambda^4=H, so this is the correctly twisted identity.

Rank certificates have polynomial entries and selected nonzero minors:

    det(10-block)=(t+3)^5(t+4)^5(t+1)^20 H^20,
    minor18(20-block)=2*t^8(t+2)^8(t+3)^8(t+4)^8
                     *(t+1)^43*(t²+2t+4)*H^32.

Consequently source defect is exactly2 on the explicit open set
t(t-1)(t-2)(t-3)(t+1)*H*(t²+2t+4)!=0. All larger minors vanish
identically, and the displayed18-minor is nonzero there. This excludes
only parameters of degree<=2 beyond the usual F5 points, so covers
the existing high-degree main family. Iterated-rank specialization is
also governed by the established simple-zero cyclic-cover theorem.

The generic run took3.28s. The F625 debugging specialization at
t4+4t3+t2+4t+3=0 took0.36s/0.41s at precisions160/200, with identical
matrices. The generic receipt is
computations/bad_double_dihedral5_defect_generic.json. This is exact
arithmetic and an author mathematical identification, not Lean or a
fresh audit of the new diagnostic.

## 4. The actual remaining unknown, not yet computed

Write q=log(sigma) in k[C5], so tau*q*tau=-q. Use tau-odd generators
of the source/target nilpotent blocks and normalize Psi_nil=q²Frob.
Then ker Psi_T=k q³+k q4, h*ker Psi_C=k q4, and D_T=R/q² with
tau signs(-,+) on its constant/q coordinates. Compatible W3 lifts
of canonical T2 differ from the canonical cover reference by
d q³+b q4. Thus tau sends(d,b)→(d,-b), while sigma sends(d,b)→(d,b+d).

The linear integral carry predicts d^5*q in the NEXT obstruction
epsilon_T(T3). First normal Hodge repairs are linear in d^5,b^5,
not in d,b; a quadratic carry would therefore have degree10 in d,b.
The exact small test verify_dihedral_initial_equivariance.py shows:
assuming the actual residual has total degree<=2 in U=d^5,V=b^5,
deck/tau equivariance and vanishing at d=0 leave precisely

    epsilon_T(T3)=(a*U+B*U²)q.

The integral comparison fixes a=1 in the matching obstruction
orientation. The unknown is the GEOMETRIC B, including all corrected
filtered/graded, Hodge-repair, Taylor and flat-twist contributions.
The degree assertion and that evaluated coefficient still need the
actual higher comparison; a formal equivariant polynomial is not a
certificate. Do not silently treat B as zero by the C10 sign argument.

If B=0, compatibility at W4 forces d=0 and first descent along h.
If B!=0, d^5=-1/B gives a nonzero surviving class (arbitrary b),
assuming the displayed actual formula has been proved. This yields
an actual initial delayed-descent failure, not a full compatible
non-descending tower or a common-cover counterexample.

There is also a smaller quotient interpretation: T/<tau> has genus6,
its active defect is1 and its Psi zero block has length2. A tau-fixed
d-direction lifts this genus6 quotient, but its degree-five map to Y
is non-Galois. It is not the already excluded Galois one-defect case.
