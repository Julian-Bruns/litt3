# Independent audit: ordinary cyclic triples have finitely many bad fibers

Date: 2026-09-05.
Auditor: `/root/ordinary_triple_finite_bad_fibers_check`.
Verdict: **PASS, with two nonblocking notation clarifications.** No breaking
flaw or additional mathematical hypothesis was found in Theorem 2.1 or
its stated generic-defect consequence.

Scope: a fresh complete reading of
`Solutions/Sol_ordinary_cyclic_triple_finite_bad_cosets.md`,
and an independent check of the algebraic Prym input in Section 1 of
`CYCLIC_TRIPLE_GENUS_TWO_PRYM_AND_BAD_AXIS_COMPONENT_BOUNDARY.md` and its
relevant component statements. No previous audit transcript was used.

## Checks supporting the verdict

1. **The algebraic Prym input works in characteristic five.** The lifted
   hyperelliptic involution has six fixed points, so its quotient has
   genus one. Pullback from that ramified double quotient is injective.
   Its norm to Y vanishes because the hyperelliptic involution acts as
   minus one on J(Y). The adjoint calculation gives b=b^dagger and
   2+b+b^dagger=0, hence b=-1. The pulled-back polarization H has degree
   nine. Complementarity with A gives the same degree for L_P, so the
   resulting E^2 -> P isogeny has degree one. The quotient identification
   Q=P^vee then gives psi=H and R=S^(-T), with the stated signs. This does
   not require transporting a complex-analytic decomposition to
   characteristic five.

2. **Using the entire divisorial bad locus is legitimate.** B is closed
   by smooth openness of pi. A curve component D has irreducible reduced
   inverse image under pi, since the fibers are geometrically connected
   abelian varieties. It is therefore a divisor component of Theta_U.
   Summing all such components with their actual multiplicities gives
   an R-invariant and inversion-invariant divisor D_Q. Ordinary U gives
   0 outside Theta_U, so P is not contained in any component of Theta_U.
   Restricting the effective residual divisor on J consequently gives
   the actual effective divisor D_P in equation (1); numerical
   subtraction alone is not being mistaken for effectivity.

3. **The matrix and nef constraints check out.** Invariance gives equal
   diagonal entries a and b+b^dagger=a. Direct multiplication yields
   diagonal entries 8-3a and off-diagonal entry 3a-4-3b for N. Effective
   divisors on an abelian surface are nef, hence both Hermitian matrices
   are positive semidefinite. Nonzero effective D_Q has a>0, and
   8-3a>=0 leaves a=1 or 2. For a=1, positivity gives deg(b)=1 and
   b^2-b+1=0. In particular b^2 is a nontrivial order-three automorphism.
   In characteristic five this forces j(E)=0; the coefficient of x^4
   in (x^3+c)^2 is zero, so E is supersingular, contradicting ordinary U.
   For a=2, u=b-1 has u^dagger=-u; the residual off-diagonal norm is
   1+9deg(u)<=4, forcing u=0. Thus the exact numerical classes in (4)
   follow. No assumption End(E)=Z is hidden here.

4. **The component classification is exhaustive.** An elliptic translate
   has L_Q-degree at least two, with equality exactly for the two
   coordinate directions and the anti-diagonal. A nonelliptic curve has
   self-intersection at least two, so Hodge index gives degree at least
   four. An R-invariant such curve has degree divisible by three, hence
   at least six. There is no R-stable elliptic subgroup: R-1 is an
   isogeny, so its restriction would supply a nontrivial order-three
   automorphism on an elliptic curve isogenous to ordinary E. The total
   L_Q-degree six therefore allows precisely the two cases stated,
   each with multiplicity one. Inversion fixes every member of an
   elliptic three-orbit because its permutation commutes with a
   three-cycle and has order dividing two. The translate constants are
   nonzero two-torsion, so these curves contain no five-torsion points.

5. **The 24-versus-23 count is valid for supports, including reducible
   residual divisors.** Intrinsically the grid is P[5](k), of order 25.
   Its nonzero elements lie in ker(F_U^*) because Frobenius pullback on
   the Jacobian is Verschiebung. For a nontrivial degree-zero alpha,
   H^0(alpha)=0, so the displayed injection from H^0(O_U) follows from
   the Frobenius exact sequence. H permutes this grid since its
   determinant is three. An irreducible nonelliptic D_Q of class L_Q
   meets the grid in at most ten points. An effective D_P of class H
   contains at most one vertical fiber, counted with multiplicity:
   otherwise subtracting two leaves horizontal degree zero and
   nonzero off-diagonal class, which is impossible. Its grid support
   therefore has at most 5+4*2=13 points. Pullback by psi preserves the
   first count on the grid. Neither multiplicities nor different grid
   parameterizations enlarge the union beyond 23. Thus B has no curve
   component; being proper and closed in Q, it is finite.

6. **Section 6 has the claimed, limited consequence.** The generic
   minimum delta_alpha is positive exactly over psi^(-1)(B), a finite
   set. For each finite prime-to-five character subgroup, etale
   functoriality gives B_W=b^(1)*B_U, and projection formula gives the
   character sum. The finitely many generic minima for that subgroup
   occur on a common nonempty open subset of J(Y^(1)). The sum is
   bounded by the sum over the finite exceptional prime-to-five set
   and attains that same constant whenever Lambda contains Lambda_0.
   This is valid for arbitrarily large finite Lambda. It gives neither
   an a-number bound nor a single parameter good simultaneously for
   infinitely many covers, and does not prove the finite exceptional
   set empty.

## Nonblocking clarifications

- Since E already denotes the scalar-twisted elliptic curve, write
  `S=E[5](k)=ker(V:E -> E^(-1))(k)`, or specify the domain of V_E.
  This removes a possible extra-Frobenius-twist reading. The point
  argument itself is correct and only needs S=E[5](k).
- For Section 6, specify that W_Lambda^(1) -> U^(1) is the cover whose
  character line bundles are Lambda, and obtain W_Lambda -> U by
  inverse scalar twist. Equivalently, specify the eigensheaf identity
  `(b_Lambda^(1))_*O = direct_sum_(alpha in Lambda) alpha` (inverses
  give the same subgroup). This makes equation (5) conventionally
  unambiguous; every subgroup in the statement admits this cover.

The Raynaud inputs were also checked against
[Tong, Sections 1.1.1, 1.2.1, and 1.2.3](https://arxiv.org/pdf/0712.2046):
the Frobenius exact sequence, theta support, symmetry as a divisor,
and numerical class are as used. The classical product Prym statement
agrees with [Lange--Ortega, Theorem 2.1(a)](https://arxiv.org/pdf/1601.04082);
the local algebraic proof supplies the needed characteristic-five
justification independently.
