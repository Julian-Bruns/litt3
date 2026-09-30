# A degree-independent local-jet criterion for primitive norms

Version 1, 24 September2026. Let k be algebraically closed of
characteristic p>2, X a smooth proper connected curve, f in k(X)
with df nonzero, and Sigma a finite reduced divisor. Choose a subset
Z of Sigma. At P in Z fix a parameter t_P and assume
ord_P(df)=r_P-1 with 1<=r_P<p. Let
f_P=sum_(i=r_P)^(p-1) a_i t_P^i be the non-p-power Taylor truncation
of f there, after removal of its local p-power principal part and
constant; a_(r_P) is nonzero. Put
\[
J_P=\min(r_P-2,p-r_P-2),\qquad
d\log f_P=r_P\,dt_P/t_P+\sum_{j\ge0}c_{P,j}t_P^jdt_P.
\]

Define V inside H0(X,omega_X(Sigma)) by the linear conditions
r_P[t_P^jdt_P]alpha=c_(P,j) Res_P(alpha), for0<=j<=J_P.
A negative J_P imposes no regular-jet condition.

Let S be a smooth proper connected curve and h:S->X any finite separable
map unramified over Sigma. Take b in k(S) and
q=h^*f+b^p nonzero. Suppose div(q) has multiplicities divisible by p
outside h^-1(Sigma). At points over P in Z require either ord(q)=r_P,
or ord(q)<=0. Then
\[
\beta=d\log\operatorname{Nm}_h(q)\in V,\qquad C\beta=\beta.
\]
Consequently, if V has no nonzero Cartier-fixed vector, Nm_h(q)
is a p-th power. One may intersect V with additional linear jet
conditions separately known for every local q-germ; the same conclusion
holds. Neither degree, monodromy, selected-sheet counts nor a torsion
assumption enters the criterion.

Global etaleness is unnecessary for this norm criterion: unramifiedness
over Sigma suffices. It is a criterion on a specified actual primitive,
not a construction of shared data from an arbitrary span or a replacement
of that problem's everywhere-etale requirement.
In characteristic five with r_P=3 it uses exactly the first regular
logarithmic coefficient. Together with the infinity condition on the
fixed cubic curve it gives [unrestricted norm vanishing](uniform_admissible_norm.md).

[Proof](../../Proofs/cartier_and_spin/primitive_trace_jet_criterion.md).
