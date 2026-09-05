# Audit: impossibility of the dihedral genus-one coarsening

**Verdict:** **PASS.** No breaking mathematical objection found.

**Auditor and date:** `/root/x_elliptic_quotient_maps`, 2026-09-04.

## Checks performed

- A reflection of \(D_{14}\) has cycle type \(2^3 1\) on the seven cosets
  of a reflection subgroup. Over each \(b\in\Delta\), this gives three
  index-two points and one index-one point \(e_b\) of \(E/B\). The inertia
  calculation in the tower \(V\to E\to B\) shows that \(V/E\) ramifies
  exactly at \(e_b\).
- In the normalized pullback of the hyperelliptic cover of \(Y\), the local
  equation is \(z^2=u^e\). Since all allowed indices of \(t\) are one or
  two, precisely the index-one points above \(\mathcal A_Y\) ramify in
  \(V/E\). In the norm divisor, the other three sheets contribute even
  terms whenever they map to \(\mathcal A_Y\), while \(e_b\) contributes
  one to a unique value. This proves the disjoint partition
  \(\coprod U_\alpha=\Delta\), including the homogeneous fiber at infinity.
- Riemann--Hurwitz gives total different 126 for the degree-nine map from
  the genus-55 curve \(E\). All ramification is tame, simple, and over the
  32 branch values. Writing a fiber as \(1^{a_\alpha}2^{b_\alpha}\)
  yields a total deficiency \(\sum(4-b_\alpha)=2\), whose only
  distributions are \(2\) and \(1+1\). Consequently 31 or 30 of the
  supports are singletons, respectively.
- For the degree-nine map \(r:B\to\mathbf P^1_x\), the index-one points
  above the eight hyperelliptic branch values are exactly \(\Delta\).
  Hence the sets \(\Delta_\xi\) partition \(\Delta\), including the fiber
  at infinity, and each has odd size between one and nine.
- The Prym two-torsion formula (61.17) has dimensions \(36-2=34\) on the
  left after quotienting by \(q^*J(B)[2]\), and \(35-1=34\) on the
  even-subset side. Its pairing is branch-set intersection parity. The sign
  calculation \(\delta^*p_*a^*=-p_*a^*\), together with
  \(c\delta=\iota_Xc\), puts both relevant images in the Prym;
  \(c_*p_*a^*=0\) makes them orthogonal.
- The branch coordinates are exactly
  \(\Delta_\xi\mathbin{\triangle}\Delta_{\xi_0}\) for pulled-back
  Weierstrass two-torsion of \(X\), and
  \(U_\alpha\mathbin{\triangle}U_\infty\) for the label classes. Their
  vanishing intersection pairing forces
  \(\rho_\alpha+\rho_\infty\in\{0,{\bf1}\}\).
- A singleton support has a standard-basis parity vector. Among two
  complementary vectors of length eight, at most one has weight one;
  therefore all at least 30 singleton supports lie in the same block
  \(\Delta_{\xi_0}\). The supports are distinct by the partition lemma,
  contradicting \(|\Delta_{\xi_0}|\le9\). This argument remains valid if
  \(U_\infty\) itself is a singleton.

## Non-breaking suggestions and objections

- After (61.10), it could help to note explicitly that divisor pushforward
  in a norm uses residue degree, not the ramification index of \(\pi\).
  Thus each ramified sheet contributes the even \(t\)-multiplicity two,
  exactly as the parity argument requires.
- In Lemma 61.3, one sentence identifying \(q^*J(B)[2]\) as the radical of
  the restricted \(2\)-Weil pairing would make the passage to the quotient
  pairing fully explicit.
- The theorem already handles infinity correctly through homogeneous
  sections. Keeping that sentence near both the partition and deficiency
  calculations is useful, since omitting that fiber would invalidate the
  numerical contradiction.

**Audited revision SHA-256:**
`62dcf6c6410fb0842953b6c906bf3211008ec94730b0d4b0c2d1f392e2e48fd6`.
