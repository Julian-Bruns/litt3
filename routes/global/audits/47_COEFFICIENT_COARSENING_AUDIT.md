# Audit: coefficient-field coarsening

**Verdict:** PASS WITH ONE MINOR WORDING CORRECTION.  The correction does
not change any displayed identity, numerical profile, or deduction.

**Auditor and date:** `/root/coefficient_coarsening_audit`, 2026-09-04.

**Non-breaking suggestions or objections:**

- Item 5 of Theorem 47.3 originally said that every ramification index over
  \(\mathcal A\) was two.  Read literally, that is impossible in a fiber of
  odd degree nine.  The proof had the correct assertion, namely that the
  indices belong to \(\{1,2\}\).  The theorem statement has been corrected
  accordingly.
- Proposition 47.1 could make its linear-disjointness step more explicit:
  the surjection
  \(k(C)\otimes_{k(B)}k(E)\to k(V)\) has equal source and target dimension
  seven over \(k(C)\), hence is an isomorphism.  The stated intersection,
  degree, and normalized-fiber-product conclusions are correct.
- In item 5, citing the tame quadratic base-change form of Abhyankar's lemma
  would make the characteristic-five edge case maximally explicit.  It
  shows that a possible wild index (for example index five) on
  \(E\to\mathbf P^1\) could not disappear after pullback to \(Y\), so
  etaleness of \(V\to Y\) really leaves only indices one and two.
- In the cyclic case, the splitting field of \(P\) can be the degree-seven
  field \(k(E)\), rather than all of \(k(V)\).  The proof already handles
  this correctly: adjoining the independent quadratic Galois field
  \(k(C)\) makes \(k(V)/k(B)\) Galois.  Thus “degree-fourteen closure” in
  the section title should not be read as saying that \(k(V)\) is always
  the splitting field of \(P\).

## Checks performed

- The coefficient ratios generate \(k(B)\), irreducibility persists on
  passing from \(k(C)\) down to \(k(B)\), and the compositum has the asserted
  degrees.  This verifies \(ed=2M\), \([E:B]=7\), \([E:k(t)]=d\), and the
  normalized spectral square without a hidden extra component.
- The alternatives \(z\in k(E)\) and \(z\notin k(E)\) give exactly the
  displayed field intersections and degrees.  Every curve lying between
  \(k(Y)\) and the unramified extension \(k(V)\) is again unramified, so no
  normality hypothesis is missing from the etaleness claims.
- For \(M=9\), the Castelnuovo bounds are
  \(\pi(18,7)=16<g(C)=19\) and \(\pi(9,7)=2\), forcing \(e=2\) and
  \(g(B)\le2\).
- The seven roots of \(P\) lie in \(k(V)\).  Its splitting field inside the
  degree-fourteen compositum has degree seven or fourteen.  In either case
  \(k(V)/k(B)\) is Galois; a group of order fourteen with the normal deck
  subgroup \(C_7\) is \(C_{14}\) or \(D_{14}\).  The order-two root
  stabilizer fixes \(t\), negates \(z\), and is exactly the asserted lift of
  the hyperelliptic involution.
- Since the \(C_7\)-extension \(k(V)/k(C)\) is etale, inertia in
  \(k(V)/k(B)\) is trivial or order two.  The branch count
  \(40-4g(B)\), the cyclic formula \(g(E)=7g(B)-6\), and the dihedral
  formula \(g(E)=g(B)+54\) all check.  Castelnuovo--Severi gives
  \(g(E)\le7g(B)+48\), excluding \(g(B)=0\) also in the dihedral case.
- Finally, \(\deg\operatorname{Diff}(t)=2g(E)+16\) gives respectively
  \(18,32,126,128\).  Each of the 32 allowed fibers contributes at most
  four, so total 128 forces type \(2^4 1\) in every such fiber, exactly as
  claimed.

**Audited revision (SHA-256):**
`b671f8d0f4a296ea2ccb3d35538c29888dfbc51961919ceeb02f6b4bbe530ce1`.
