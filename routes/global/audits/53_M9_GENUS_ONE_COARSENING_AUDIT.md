# Audit: genus-one degree-nine coarsening is hyperelliptic

**Verdict:** **PASS.**  No breaking mathematical objection found.

**Auditor and date:** `/root/audit_m9_hyperelliptic`, 2026-09-04.

## Checks performed

- Ran `sage routes/global/53_X_AUTOMORPHISM_CERTIFICATE.sage` successfully
  (SageMath 10.9).  It obtains the point counts `(8,30,134)`, reconstructs
  and factors the stated Weil polynomial, and exhaustively finds the trivial
  reduced branch-set stabilizer over the degree-six splitting field.
- The three quadratic factors have CM fields of discriminants `-11`, `-19`,
  and `-4`; they are ordinary and pairwise geometrically nonisogenous.
  Thus the displayed geometric rational endomorphism algebra and its
  Rosati-fixed subalgebra are correct.  The standard hyperelliptic descent
  identifies the resulting automorphism group as
  `\(\{1,\iota_X\}\)`.
- For `\(u=c_*\delta^*c^*\)`, Rosati positivity gives
  `\(-9\leq\lambda_i\leq9\)`, and the rank of
  `\(h^\dagger h=9+u\)` on elliptic `\(J(B)\)` forces at least two
  coordinates to equal `\(-9\)`.  The integrality assertion follows from
  rational algebraic-integral coordinates in the three CM factors.
- The diagonal formula is
  `\(Z\cdot\Delta=18-2\sum\lambda_i\)`.  Each of the 36 fixed points of
  the tame quotient involution gives a transverse local contribution one;
  projection formula retains that count even if image branches coincide.
  Proper intersection with the hyperelliptic graph gives
  `\(18+2\sum\lambda_i\geq0\)`.  Under the contrary hypothesis these
  inequalities give exactly `\((-9,-9,9)\)`.
- If `\(Z=e\Gamma\)`, etaleness of `\(c\)` makes both factors through the
  normalization of `\(\Gamma\)` etale.  Hence `\(e\mid9\)` and
  `\(g(\widetilde\Gamma)=1+18/e\)`.  The correspondence self-intersection
  is `\(162/e^2-486/e^2\)` and its canonical intersection is `\(72/e\)`;
  adjunction therefore gives
  `\(p_a(\Gamma)=1-162/e^2+36/e\)`.  The negative values for `\(e=1,3\)`
  exclude those cases, and `\(e=9\)` would yield an automorphism with
  cohomological signs `(-1,-1,1)`, impossible for either allowed
  automorphism of `\(X\)`.
- After `\(c\delta=\iota_Xc\)`, the invariant coordinate descends to
  `\(r:B\to\mathbf P^1\)`.  The tame local normalization of
  `\(w^2=r^7-r+1\)` shows that etaleness over `\(X\)` permits exactly
  indices one and two above the eight hyperelliptic branch points and no
  ramification elsewhere.  The 36 index-one points are precisely the
  quotient branch points; Riemann--Hurwitz for degree nine from an elliptic
  curve gives the 18 simple index-two points.  This verifies every equality
  in (53.12).

**Non-breaking presentation suggestion:** The phrase “each contributes
exactly one to `\(Z\cdot\Delta_X\)`” is correct by the projection formula,
but naming that formula there would make clear that coincident image branches
do not affect the count.

**Audited revision before audit-metadata insertion (SHA-256):**
`aef31c1b237c080e7c3f82cc7307e6e93df389a4b7487dcda2a002caab4fc9b3`.
