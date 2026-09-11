# Cyclic-power nonlinear absorption: focused algebra audit

Verdict: PASS for the intended perfect field k of characteristic5.
Auditor: /root/audit_uniform_nonlinear_absorption.
Date: 2026-09-10.
Scope: Sections1--5 and statements(I),(II) of
[the canonical proof](../../Solutions/Sol_cyclic_power_nonlinear_absorption.md).
Input: canonical cyclic_power_additive_norm v1, exact statement and
proof inspected. No geometric comparison or common-cover conclusion
is audited here. This is a prose audit, not formal verification.

Statement clarification: explicitly retain the perfect-field hypothesis
on k from the additive norm input. Freeness of W_(a+1)(k) over the
integer coefficient ring and its reduction modulo5 are used. Apart
from this clarification there is no blocking objection.

## Checked points

1. The cyclic wrap identity and valuation are exact. At weight j,
   degree D<5^j implies every wrap coefficient has valuation at least
   a+1-j, so it vanishes after multiplication by5^j. At the corresponding
   quotient precision P_D is the indicated kernel: the remaining
   finite-difference matrix has unit pivots. Thus arbitrary additive
   deck maps preserve it. Division of A-e² by5 defines an additive
   equivariant map at precision5^a; using a regular-module lift is also
   legitimate and does not presume equivariant division on a general
   nonfree module.

2. Section2 does not need equivariance of the individual d-additive
   presentations. Expand Q_d(sigma^s v) using additivity and integer
   binomial orbit coordinates, sum all terms, and only then use
   Q_d(sigma^s v)=sigma^s Q_d(v). Evaluation at sheet0 yields actual
   polynomial functions with the stated weighted degrees. Products
   of integer-valued binomial polynomials have integral binomial
   coefficients; there is no division by d!, even for d>=5.
   Cross terms themselves are never asserted equivariant.

3. For the combined input in(I), degree3i+1<5^(i+1) implies its
   weight-i wrap has valuation at least a. Consequently the whole
   input orbit expansion is valid modulo5^a, exactly enough for every
   nonlinear term because its outer weight is at least1. In(II) the
   input is needed only modulo5^(a+1-m), and degree2i+2 obeys the same
   wrap bound. This verifies the precision implicit in Section2;
   unweighted integral polynomial preservation was not used.

4. During the digit inductions all known linear e² wraps occur at
   valuation at least a. The induction in(I) stops at digit a-1,
   and in(II) at digit a-m. Polynomial-module saturation therefore
   justifies the residual division. The nonlinear degree estimates
   give respectively3j-1 and2j+4-2m; the additive correction and norm
   digit give the stated bounds as well. Double integration yields
   the claimed combined input spaces. It does not constrain the
   unused final digit before applying the norm theorem.

5. For both F spaces, double integration stays below the exact wrap
   threshold. The correction5M raises the weight and stays in F:
   for(I),3j+1<=3(j+1)-1, and for(II) the two degree bounds agree.
   The finite additive geometric correction thus produces an exact
   preimage in E. The sums defining F and E cause no well-definedness
   problem for integration: these are weighted binomial-coordinate
   submodules, so the coordinate shift is a linear map on their sums.

6. Subtracting that exact preimage leaves the original reduction and
   gives A(y-z)=0 or A(y-z)=N eta. Under the regular representation
   identification a constant function eta is precisely N eta.
   The established integral norm theorem yields the claimed invariant
   reduction and, in(II), eta in5O. The cases a=1 and a<m are included;
   the latter has no nonlinear term.

The geometric paragraph is correctly conditional. In particular the
existence and integral homogeneous form of actual high-degree terms
remain separate obligations.
