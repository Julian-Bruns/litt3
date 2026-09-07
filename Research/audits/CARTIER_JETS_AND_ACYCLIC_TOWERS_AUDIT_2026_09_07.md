# Cartier jets and acyclic atlas covers — bounded audit

Verdict: PASS. Auditor: `/root/cartier_jet_and_atlas_towers_audit`.
Date: 2026-09-07. Independent prose audit, not formal verification.

Scope: [tensor surjectivity](../../Theorems/Thm_cartier_jet_tensor_surjectivity.md)
and its [proof](../../Solutions/Sol_cartier_jet_tensor_surjectivity.md);
[acyclic atlas covers](../../Theorems/Thm_acyclic_atlas_towers.md)
and its [proof](../../Solutions/Sol_acyclic_atlas_towers.md).
The previously audited intrinsic incidence construction is an accepted
dependency. The actual genus-two quotient and acyclicity argument were
read directly; its unrelated five-oper computation was not reaudited.

No substantive objections.

- Serre duality gives the annihilator bundle `V tensor K^vee tensor omega`.
  Contracting with a section of `V^vee M`, then precomposing with `j^-1`,
  gives exactly an `F^*V`-valued differential. The dual Frobenius map is
  coefficientwise Cartier in pulled-back frames, with inverse Frobenius
  scalar action. The stated residue identity and Frobenius twist account
  for this action; a possible dual-extension sign cannot affect rank.
- A global section congruent to `t^(p-1)e_i modulo t^p` makes the Cartier
  value at the point equal to the pth roots of the i-th coefficient row
  of the annihilator. Higher terms cannot contribute to that value.
  Invertibility of the bundle identifications then forces the annihilator
  to vanish on the dense open. This proves actual tensor surjectivity.
- The evaluation obstruction is dual to `H0(V^vee(pP))`. Stability and
  slope `p-(g-1)<=0` give its vanishing, including slope zero because the
  rank is two. Hence the genus-nine conclusion applies to every candidate
  and every cubic twist, independently of existence of an atlas.
- On the Jacobian surface, the bad section locus is closed and proper
  since it misses the origin. An effective ample divisor containing it
  exists by a sufficiently high ample twist of its ideal. Etale local
  degree one at each torsion point makes the multiplicity of `[ell]_*D`
  at zero the sum of the source multiplicities. Intersecting with a
  general very ample divisor through zero yields the uniform bound
  `#(D intersect J[ell]) <= (D.H) ell^2`. This is smaller than the number
  `ell^3+ell^2+ell+1` of cyclic lines for all sufficiently large primes.
  Each bad nonzero point marks at most one line. No countable avoidance
  assertion is used, and whether the containing divisor meets zero is
  irrelevant to the argument.
- Exact-order torsion gives a connected cyclic etale cover; its character
  decomposition proves acyclicity of the actual pulled-back bundle.
  Composition with the existing map to the Hermitian quotient stack
  preserves the actual atlas. The clock-and-shift calculation supplies
  `H0(V)=0` by exact invariants of the endomorphism quotient.
- A putative nonnegative-degree line in the pulled-back dormant descent
  has horizontal Frobenius pullback. It cannot generically coincide with
  the oper line, whose second fundamental map stays nonzero under etale
  pullback. Its nonzero projection to the degree `-ell` quotient gives
  `5 deg A <= -ell`, proving stability. The canonical extension stays
  nonsplit since pullback followed by trace multiplies its class by
  `ell != 0` in characteristic five. Genus is `ell+1`, so the jet theorem
  applies for all sufficiently large primes and gives output rank
  `12ell`.

These are structural positive examples and a limitation of the constant
annihilator method. They do not exclude a fixed genus-nine candidate or
solve the unmarked common-cover problem.
