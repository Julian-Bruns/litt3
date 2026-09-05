# Audit: label rigidity in the cyclic genus-one coarsening

**Verdict:** **PASS.** No breaking mathematical objection found.

**Auditor and date:** `/root/x_elliptic_quotient_maps`, 2026-09-04,
with an independent corroborating check by
`/root/x_elliptic_quotient_maps/audit59_helper` on the same date.

## Checks performed

- In the cyclic row, the order-two and order-seven fixed fields form the
  stated normalized cartesian square. Thus the two quadratic extensions of
  \(k(E)\) agree, which gives (59.5) up to a square. The cyclic-row
  ramification profiles for both degree-nine maps meet the hypotheses of the
  normalization calculation (59.7): locally normalization removes one copy
  of each simple ramification divisor. This gives building bundles
  \(L_t^{14}\) and \(L_r^2\), hence (59.8).
- Pullback on two-torsion through the degree-seven isogeny is an isomorphism,
  so the class \(\eta\) in (59.6) exists uniquely. The identity
  \(\pi^*\operatorname{Nm}_\pi(L_t)=
  \bigotimes_{i=0}^6\tau^{i*}L_t\), together with
  \(\sum_{i=0}^6iQ=21Q=0\) for the order-seven translation point,
  verifies (59.6a) and the possible \(C_7\)-twist.
- Lemma 59.2 handles both eigenspaces correctly. An invariant function
  descends to \(B\) and therefore has even valuation at every ramification
  point after pullback. An anti-invariant function is \(wg\), with \(g\) on
  \(B\), and has odd valuation at every one of the 36 branch points. It
  would force \(U_\alpha\) and \(U_\beta\) to be complements, impossible
  because each has size at most nine. The reverse implication follows by
  pulling back a principal divisor on \(B\).
- For a fixed label and support, the square sections lie in the image of

  \[
  \operatorname{Sym}^2H^0(B,N)\longrightarrow H^0(B,N^2).
  \]

  Elliptic Riemann--Roch gives the upper dimensions \(8,6,3,1,1\).
  Full coefficient span makes the evaluation curve the degree-seven
  rational normal curve, so any at most eight evaluation points are
  independent. In support degree one, eight such sections would span the
  whole base-point-free coefficient system while sharing a base point. This
  verifies all five multiplicity caps in (59.3).
- For the spectral curve, adjunction gives
  \(\Gamma^2=126\), \(K\mathbin{\cdot}\Gamma=-18\),
  \(p_a(\Gamma)=55\), and \(\delta(\Gamma)=54\). Because \(\pi\) is
  etale, its local branches are smooth graphs; the conductor on the
  normalization is the sum of the six ordered coincidence divisors. Each
  has degree 18, giving exactly the 108-collision budget.
- At each \(b\in\Delta\), all seven sheets are branch points of \(V/E\).
  The normalized hyperelliptic pullback and the index-\(1/2\) restriction
  therefore make them index-one points of \(t\) above
  \(\mathcal A_Y\). Hence \(\sum_\alpha z_{\alpha,b}=7\), and the parity
  inequality in (59.25) gives \(\sum_\alpha w_\alpha\ge144\).
- Independently exhaustively enumerated the at-most-nine-class integer
  problem using the five support/capacity pairs. Its exact maximum total
  support for 32 labels is 138, attained by seven support-five classes of
  occupancy three and two support-three classes of occupancies five and
  six. Thus the ten-label conclusion is exhaustive, not merely a loose
  estimate.
- The Prym two-torsion quotient in (59.32) has the correct dimension 34;
  the radical of the restricted \(2\)-Weil pairing is \(q^*J(B)[2]\), and
  the quotient pairing is branch-set intersection parity. The two pullback
  classes have branch coordinates
  \(\Delta_\xi\mathbin{\triangle}\Delta_{\xi_0}\) and
  \(U_\alpha\mathbin{\triangle}U_\infty\). Orthogonality therefore forces
  all eight coordinates of \(\rho_\alpha+\rho_\infty\) to agree. Summing
  modulo two and using the odd sizes of the eight blocks verifies the final
  assertion that the number of complemented columns is odd.

## Non-breaking suggestions and objections

- Before applying (59.7), one could explicitly cite the cyclic rows of
  Theorems 47.3 and 53.3 to make clear that both maps have only simple
  index-two ramification over the respective hyperelliptic branch sets.
- In the last paragraph of Proposition 59.6, “counts the seven labels” is
  best read modulo two: collisions can merge values, but
  \(\sum_\alpha(z_{\alpha,b}\bmod2)\equiv7\pmod2\). Writing this congruence
  explicitly would avoid a possible literal misreading.
- Lemma 59.4 could mention that etaleness of \(\pi\) is what rules out
  singularities of an individual graph branch and makes the pairwise graph
  intersection formula for the conductor immediate.

**Audited revision SHA-256:**
`a33a64647add5cd03c97533c7103dba4cb96db8b23d15a580d2cc0232c7d926f`.
