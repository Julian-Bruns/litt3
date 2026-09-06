# First-integral numerical discrepancy — reference only

- Verdict: identities PASS; initial failed assertion was a Sage zero-test bug.
- Auditor: /root/first_integral_numeric_discrepancy, GPT-6 Astra medium.
- Date: 2026-09-06.
- Scope: the rational-function first-integral/reconstruction test and a
  bounded scan of active scripts for the affected operation.
- Concrete issue: over F5(z), D(1/(z^15+4)) returns0/(z^15+4), but its
  truthiness is True and comparison with0 is False. The numerator is zero.
- Fix: test f.numerator().is_zero(); test equality using the difference.
- Recheck: all125 examples pass, comprising5 zero,8 singular-cubic and112
  smooth-cubic cases. The theorem's symbolic identity is unchanged.
- Prior impact: no concrete affected prior certificate found. In particular
  scalar_residual_rank.sage uses polynomial/Laurent/coefficient operations,
  not this rational-function derivative zero-test pattern.
- Non-breaking caveat: this is not a whole audit of the new global theorem.
