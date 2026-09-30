# Proof of quadratic trace noncollapse and the quartic bounds

Put a4=[13]. At an unramified point over t=0, the two identities give
\[
u=\alpha+at+O(t^2),\quad v=\epsilon Bt^{-3}+O(t^{-2}),\quad
A(\alpha)=0,\quad a=a_4B^4/A'(\alpha),
\]
\[
B^{29}=H(\alpha):=3P(\alpha)^2A'(\alpha)^3/a_4^3.
\]
All displayed nonconstant leading coefficients are nonzero.

The returned exact arithmetic proves these finite facts. In F_(25^4),
the four29th roots b_i of the four H-values form a normal basis over
F25 (determinant[23]). The four values I(alpha)=A'(alpha)^20/P(alpha)^6
are distinct. In F_(25^7), all435 unordered sums of two29th roots of
unity are distinct and nonzero. Coprime extension degrees preserve the
normal basis in the compositum. Consequently the116 constants
b_i mu_29 have distinct unordered pair sums, including repeated entries;
each determines its root alpha uniquely. A redundant direct check of
all6786 sums passed. The source retains Rabin and Bezout certificates,
not just a point search.

Suppose U=u+sigma(u) and V=v+sigma(v) are rational in t. An involution
fixing an unramified point over0 acts trivially on its completion and
hence on L; therefore a nontrivial sigma pairs all endpoint branches.
Let Bsum=t^3 V/epsilon. Equality of the leading pair sums implies that
all pairs have the same unordered labels b,c.

For a branch near alpha, write W=t^3v/epsilon. The polynomial identity
is A(u)=t F(W,t), where
\[
F(W,t)=a_4W^4+a_3\epsilon^{-1}t^3W^3+
 a_2\epsilon^{-2}t^6W^2+a_1\epsilon^{-3}t^9W+
 a_0\epsilon^{-4}t^{12}.
\]
Its conjugate is A(U-u)=t F(Bsum-W,t). The first equation solves u
uniquely as a formal function of t,W since A'(alpha)!=0. Substitute
in the second and divide its residual by t. At t=0 its polynomial,
up to a unit, is
\[
G(W)=W^4/A'(\alpha)+(b+c-W)^4/A'(\beta)-U_1/a_4.
\]
If b!=c, a multiple root at b would give
(c/b)^3=A'(beta)/A'(alpha). The29th-power identities then imply
I(alpha)=I(beta). Distinct I-values exclude different roots; for equal
roots, gcd(3,29)=1 forces b=c. Thus b and c are simple roots and there
is at most one formal branch of each label.

If b=c, all labels alpha agree. Replacing W by b+Z changes G by
(2b^2 Z^2+2Z^4)/A'(alpha), so the root has multiplicity exactly2.
In either case there can be at most two distinct branches in total.
For the root-count assertion, divide a formal power series by Z-z(t)
for each root z(t) in t k[[t]]. Each division lowers its nonzero special
fiber multiplicity by one, and distinct roots remain roots of the
quotient. A unit cannot have another root. This requires neither an
analytic approximation nor a finite-field restriction.

Because L=k(t,u), its distinct embeddings in the endpoint completions
have distinct u-series. The number of branches is [L:k(t)], proving
the arbitrary-degree bound. The returned proof stated degree4; nothing
in this argument uses that number until comparing it with2.

For the quartic consequences, put U=u+sigma(u), V=v+sigma(v). At least
one generates the actual quadratic field k(C)/k(t). The common-pole
orbits obey
\[
n-12=f_1+3f_3+a_1+2a_2+3b_1+6b_2.
\]
The function u-sigma(u) is nonzero. At each fixed finite point it has
a zero; fixed poles have odd order1 or3. At a pair of simple common
poles, the previously proved reciprocal contact>=4 makes the difference
have at least two zeros at each member. Comparing poles and zeros gives
\[
\#\operatorname{Fix}(\sigma)\le2n-12-2f_3-8a_2-6b_2,
\quad g(S)\le2g(C)+n-7-f_3-4a_2-3b_2.
\]
The trace generator on C has total common-pole order at most
Cpol=f3+a1+a2+3b1+3b2. Its two endpoint poles have orders<=3; their
intersection in the birational (trace,t) image subtracts the smaller
order. The bidegree genus formula gives g(C)<=Cpol+2. If the other
trace descends, equality of its leading pair labels forces the trace
generator's two expansions to agree through degree2 at the opposite
end, subtracting a further3. Indeed the next coefficients are
\[
c=Ba\left(P'(\alpha)/P(\alpha)-A''(\alpha)/A'(\alpha)\right),
\quad e=\left(4a_4B^3c-(A''(\alpha)/2)a^2\right)/A'(\alpha).
\]
Substitute the pole identity to obtain both asserted bounds for g(S).
For V4 the quotient genera sum to g(S). Its three involutions give all
three matchings of an unramified four-point fiber. Summing their Cpol
bounds contributes3s-binomial(s,2) for s simple poles,7 for one triple,
and8 for two triples. This proves the stated V4 estimate.

For the residue restriction, at c with ell=epsilon c^4!=1, the simple
pole residue is C_c=c[22](ell^-1-1), while a ramified triple branch
contributes3C_c to its quadratic trace. At an unramified lower fiber,
each upper block has weight0..3. Equal residues force equal integer
weights, not just congruence modulo5. At a ramified lower fiber a lone
triple gives an odd pole and cannot descend. Thus only weights0,2,4,6
remain. The sole possible exceptional fiber has epsilon c^4=1 and
c^29=1, proving the odd-n consequence.

The formulas for r and t follow by direct substitution and
3*48-11*13=1. They retain both actual functions. The upper involution
need not lift through y^3=P(u): lifting requires sigma([P(u)]) to be
[P(u)] or its square in L*/L*3. Even a lift cannot be presumed to
normalize an endpoint field. These distinctions remain open conditions.

Original proofs and exact arithmetic are retained in the
[returned report](../../../litt3-computation-data/geometric_bottleneck_replies_20260925/extracted/imprimitive_quartic/imprimitive_quartic_partial/REPORT.md),
with [sources](../../scripts/arithmetic/pro_geometric_bottlenecks_20260925/quartic/src/verify.py)
and [successful replay](../../../litt3-computation-data/geometric_bottleneck_replies_20260925/local_checks/quartic.log).
The arbitrary-degree extension above received focused author review;
no global common-cover conclusion is drawn.
