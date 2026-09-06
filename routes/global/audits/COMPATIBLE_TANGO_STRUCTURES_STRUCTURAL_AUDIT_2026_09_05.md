# Independent structural audit of the compatible Tango count

Date: 2026-09-05. Auditor: `/root/tango_count_structural_audit`.

Audited: [Compatible Tango structures: zero, one, or p−1](../COMPATIBLE_TANGO_STRUCTURES_SINGLETON_OR_QUARTET.md), read completely, together with its linked canonical-intersection proof and Tango-equivalence note. No previous audit was used. The theorem file was not edited.

**Verdict:** the proof is correct for the stated actual finite étale coreless span over an algebraically closed field of odd characteristic. It counts geometric embedded Tango structures, equivalently the specified regular connections; it does not assert a scheme-length count. I found no additional twist, descent, or regularity hypothesis needed. The singleton criterion is conditional on existence of a compatible Tango pair, exactly as stated.

## Checks of the sensitive points

1. **Tango lines and connections really have the same equality relation.** Cartier descent takes a regular dormant connection on the fixed bundle \(\omega_C\) to the embedded horizontal line \(M\subset F_*\omega_C\), with the adjunction isomorphism \(F^*M\simeq\omega_C\). Requiring every horizontal section to have zero Cartier image is exactly \(M\subset B_C\). Conversely that embedded line, through the adjunction isomorphism, supplies the canonical descended connection on \(\omega_C\). These constructions are inverse. Rescaling an isomorphism by a constant does not alter the connection. Thus the proof does not accidentally count extra framings or identify different embedded lines. Étale Frobenius base change and \(f^*\omega_C\simeq\omega_Z\) make these constructions commute with the actual pullbacks.

2. **Rational horizontal frames and logarithmic differences are valid.** At the generic point Cartier descent gives a one-dimensional horizontal space over \(K^p\), hence a nonzero horizontal rational frame. If \(\alpha_1=h\alpha_2\) are horizontal for two connections, their difference is a signed \(d\log h\). It is therefore Cartier-fixed. Conversely a Cartier-fixed rational differential is logarithmic, so the rational connection \(d+\beta\) is dormant. Extension to a regular connection has zero p-curvature everywhere because p-curvature is a regular bundle morphism vanishing generically.

3. **The scalar calculation uses the right semilinearity.** Once two pairs give a shared nonzero \(\eta\) with \(C\eta=\eta\), the intersection theorem yields \(A=k[\eta]\). A compatible connection therefore satisfies \(\nabla\eta=c\eta^2\). Its rational connection form is \(c\eta\), so dormancy says \(c^{1/p}\eta=c\eta\), equivalently \(c\in\mathbf F_p\). For \(c=0\), the rational horizontal form \(\eta\) is Cartier-nonzero, violating the Tango condition. This is a condition on the horizontal sheaf also: a rational horizontal form can locally be cleared of poles by a p-th-power multiplier, and Cartier scales by its p-th root.

4. **Regularity is exactly p-divisibility of the zero divisor.** In a completed local parameter write \(\eta=t^m u\,dt\), with \(u\) a unit and \(m\ge0\). The connection coefficient in the regular frame \(dt\) is
   \[
   c t^m u\,dt-m\,dt/t-du/u.
   \]
   The only possible polar term is \(-m\,dt/t\); it vanishes exactly when \(p\mid m\). There are no hidden higher poles or cancellation conditions. Étaleness preserves each order and the maps are surjective, so the divisor condition is equivalent on the two endpoints and upstairs.

5. **Every claimed nonzero scalar actually supplies a Tango structure.** Given \(\eta_C=d\log q_C\), the frame \(q_C^{-c}\eta_C=-c^{-1}d(q_C^{-c})\) is nonzero, exact, and horizontal for (1). Every rational horizontal frame is its \(K_C^p\)-multiple, so every such form is Cartier-zero. The preceding local check supplies regularity. The formula for the connection depends only on \(\eta_C\), so the two actual pullbacks agree irrespective of the choices of \(q_C\). Distinct \(c\)'s give distinct connections.

6. **The p-th-root argument respects the bundles.** For \(d=pm\), the canonical connection on \(\omega_C^{pm}\) is the connection on the Frobenius pullback of the corresponding line on \(C^{(1)}\). In a local frame \(e\) of \(\omega_C^m\), horizontality of \(a e^p\) means \(da=0\), hence \(a=b^p\). Its unique root \(be\) glues: uniqueness in the function field forces compatibility of the local roots. The root is regular since its p-th power is regular. Equality of the endpoint p-th powers upstairs forces equality of their roots upstairs. Thus \(p\mid d\) would really give a shared regular section of weight \(d/p\), contradicting primitive weight; no choice of a Frobenius identification creates an obstruction.

7. **Twisted Cartier has the correct powers and functoriality.** The displayed \(C_n\) is the usual projection-formula Cartier map, written as a p-inverse-semilinear map on the original curve over perfect \(k\). Changing a rational differential frame \(\alpha\) to \(u\alpha\) preserves the formula: ordinary Cartier extracts the p-th-power factor \(u^{-pn}\) arising from the change of frame. In particular, for \(s=b^p\alpha^d\) and \(rd=pn+1\),
   \[
   C_n(s^r)=b^r\alpha^n C(\alpha),
   \]
   exactly as used. The map sends regular sections to regular sections and commutes with étale pullback. In fully relative notation its target is on \(C^{(1)}\); the perfect-field semilinear notation in the theorem is consistent and its vanishing is unambiguous.

8. **The uniqueness equivalence is exhaustive.** If \(d>1\), \(A_{d+1}=0\), so a compatible connection makes \(s\) horizontal under its d-th tensor power. In a horizontal Tango frame \(\alpha\), the coefficient of \(s\) has zero differential and is a p-th power. This proves (2). Two different compatible pairs would force \(d=1\), so the existing pair is unique. If \(d=1\), then \(r=1,n=0\); writing \(\nabla s=a s^2\), the branch \(a=0\) gives \(C(s)=0\), while \(a\ne0\) gives the Cartier-fixed \(a s\), its p-divisible zero divisor, and exactly \(p-1\) pairs. Odd characteristic ensures \(p-1>1\), so these branches distinguish uniqueness as claimed.

## Optional precision improvements

- In (2), explicitly say that \(r\) is the unique integer in \(\{1,\ldots,p-1\}\) satisfying \(rd\equiv1\pmod p\), and set \(n=(rd-1)/p\ge0\). The proof establishes \(p\nmid d\); making this choice explicit removes a possible ambiguity in the displayed quantifiers.
- Add “using the perfect-field semilinear convention” to the definition of \(C_n\), or give the relative Frobenius target once. This is a notation improvement, not a repair.
- In the final paragraph, write \(s=u\alpha^d\), then \(du=0\), hence \(u=b^p\), to expose the short Cartier-descent step already implicit there.

The theorem neither proves existence of a compatible pair from a shared Cartier-zero pluriform nor produces an example realizing every numerical alternative; its stated qualifications correctly preserve those limits.
