# Proof: companion cancellation and distinct-root incidence

[Statement](../../Theorems/cartier_and_spin/klein_four_companion_constraints.md).
The original argument and complete finite-root arithmetic are preserved in
[the incoming report](../../../litt3-computation-data/overnight_three_replies_20260926/klein/klein_four_further/REPORT.md),
sections2 and5 and the predecessor report sections4--5. The obsolete
n=26 and n=91 actual-cover profile conclusions are omitted. The present
arguments use only the explicit polynomial and formal-germ hypotheses.

## Polynomial minors and formal companion cancellation

Direct substitution gives
\[
U_jV_k-U_kV_j=E M_i,\qquad
\epsilon t^7M_i=V_jT_k-V_kT_j.
\]
The first proves nonvanishing and the second the degree bound. The
specified unit/ratio condition makes M_i vanish at every root of J_i;
squarefreeness gives divisibility. Sum the three degree bounds.

Here is the local pattern behind that ratio condition, with its assumptions
separate from any global character construction. Let t-c=s^2, c!=0,
and suppose E,C_j,C_k have exact s-order2 while z_j,z_k have order1.
Assume formal Laurent functions are represented by
\[
w_a=T_a z_a/(t^3C_a),\qquad
u_a/w_a=t^3U_a/(E T_a),\quad a=j,k.
\]
If w_j,w_k have nonzero opposite leading s^-1 coefficients, and
u_j,u_k nonzero opposite leading s^-3 coefficients, then all four
U_j(c),U_k(c),T_j(c),T_k(c) are nonzero. Comparing leading ratios
u_a/w_a gives the same U_a(c)/T_a(c) at j and k. This proves the
needed minor zero. Opposite polar coefficients are substantive hypotheses:
they are not inferred from a formal rank condition or a fictitious
regular point. In the original V4 application they arose from actual
character projectors at a regular companion to a unique triple pole.
The lemma itself assumes neither that global application nor its existence.

## Diagonal local incidence

The fixed arithmetic gives P'(alpha)A(alpha)A'(alpha)!=0 at every
root alpha of P. Raise the differential identity to the thirteenth
power and multiply by the forty-eighth power of the A-identity to obtain
\[
(dv/du)^{39}P(u)^{26}A(v)^{48}
=\epsilon^{-29}A(u)^{48}P(v)^{26}. \tag{1}
\]
If gamma=alpha, use s=u-alpha as uniformizer. The A-identity, its first
derivative, and ord(t-b)=2 give v=alpha+s+B s^2+O(s^3), B!=0.
Indeed A(v)-A(u) has the order of v-u, and the nonzero exponent13
makes that order equal to ord(t-b). The constant unit coefficient of
(1) forces epsilon^29=1. Its first-order coefficient then gives
(39*2-26)B=2B=0, a contradiction. Here dv/du=1+2Bs+O(s^2),
P(v)/P(u)=1+Bs+O(s^2), and A(v)/A(u)=1+O(s^2).

## Exact off-diagonal spectrum

For general roots alpha,gamma put lambda=(dv/du)(0). The value and
first derivative of the A-identity give
epsilon^4 b^-13=R and lambda=R A'(alpha)/A'(gamma).
The leading differential identity gives
lambda P'(alpha)^2=epsilon^-17 b^48 P'(gamma)^2.
Thus epsilon^17 b^-48=h. Raising this to13 and dividing by the
forty-eighth power of epsilon^4 b^-13=R gives epsilon^29=h^13/R^48,
the K_* ratio. The integer identity3*48-11*13=1 then gives the
displayed b and both remaining ratios in the statement.

The retained complete splitting-field calculation covers all ten roots
of P and all100 ordered pairs. It proves that the ten K_* values are
nonzero and distinct and the ninety off-diagonal ratios pairwise distinct.
It also proves that H(x)^4/A(x)^17 and H(x)/A(x)^4 each have ten
distinct values. Consequently b^29 and epsilon b^4 are1 only on the
diagonal, already excluded. This is exact finite-root arithmetic, not
a bounded search for curves or germs. The original eleven archive
verification commands passed locally; no settled computation was rerun.

The formal diagonal argument and polynomial-minor generalization were
reviewed during the 30 September2026 cleanup. No automatic application
to another comparison pole is asserted.
