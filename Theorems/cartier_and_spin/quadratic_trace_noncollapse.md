# Quadratic traces cannot both collapse to the parameter field

Version1, 25 September2026. Use the fixed P,A over F25 from the
[quartic comparison](quartic_trace_obstruction.md). Let k be algebraically
closed of characteristic5, L=k(S), and let t,u,v be separating functions.
Assume L=k(t,u), that every point above t=0 is unramified for t, that u
is regular and v has pole exactly3 there, and that for epsilon in k*,
\[
A(v)=\epsilon^4t^{-13}A(u),\qquad
(dv/du)^3P(u)^2=\epsilon^{-17}t^{48}P(v)^2.
\]
If an involution sigma of L fixes t and both u+sigma(u) and v+sigma(v)
belong to k(t), then [L:k(t)]<=2. Thus for any even parameter degree
at least4 these two traces cannot both descend. There is no bound on
the degree of u and no simultaneous-Galois-closure assumption.

The arbitrary-degree formulation is a local continuation of the returned
quartic argument. Its explicit local hypotheses are essential; they have
not been proved for every higher comparison-pole branch.

For an actual imprimitive quartic comparison at n=14..184, let C be the
upper-involution quotient and use the orbit counts f1,f3,a1,a2,b1,b2:
fixed simple/triple common poles, nonfixed pairs with one/two simple
common poles, and nonfixed pairs with one/two triple common poles.
The divisor need not be invariant. Then
\[
g(S)\le3n-27-2f_1-5f_3-6a_2-9b_2.
\]
If exactly one trace is rational in t, replace27 by33. In the V4 case,
with s_c simple common poles over c, and j1,j2 fibers with one/two
triple common poles,
\[
g(S)\le3n-30-\sum_c\binom{s_c}{2}-2j_1-10j_2.
\]
If one trace descends, every nonexceptional residue weight is in
{0,2,4,6}; odd n then requires epsilon^29=1. Neither trace theorem nor
genus bounds exclude every remaining quartic comparison.

The full differential identity already reconstructs the cubic ratio:
if B=dv/du, F=P(v)/P(u), and kappa^3=epsilon^-17, then
r=kappa t^16 F/B satisfies r^3=F. Together the identities recover
\[
t=\frac{\epsilon^7(dv/du)^9P(u)^6A(v)^{11}}
{P(v)^6A(u)^{11}}\in k(u,v).
\]
The noncube condition on P(u) is still required for the connected cubic
cover. No actual simultaneous model or original common cover is supplied.

[Proof and evidence](../../Proofs/cartier_and_spin/quadratic_trace_noncollapse.md).
