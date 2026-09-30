# Proof: what extends to quintic parameter maps

[Statement](../../Theorems/cartier_and_spin/pole_fifteen_quotient_constraints.md).
This is a local continuation beyond the completed Pro cubic-descent
theorem. A focused independent audit checked both extensions and
rejected the tempting but false inference that all moments vanish.

## Common poles remain tame despite parameter degree five

The local identities in
[the universal trace proof](quartic_trace_obstruction.md) use the
actual equations, not the quartic degree. At a common pole put
u=z^-e, v=ell z^-e/h, t=cq, with h(0)=q(0)=1. Here e=1 or3
because both endpoint maps reconstruct etale maps to the cubic X.
The identities give q_e=4P9(1-ell^-1). If e=3, they also give
h1=q1=0 and q2=3h2. If ell=1, the first nonconstant order j
satisfies j=-e modulo five. Such an order exists: otherwise t
would be constant on a completed neighborhood and hence globally.

Now j<=deg t=5. Thus ell=1 permits only j=4 for e=1, and only
j=2 for e=3. For ell!=1 the stated nonzero first coefficients
give j=1 for e=1, or j=2 or3 for e=3. This proves the table,
including the absence of a wild index five at a common pole.

Since e/j<=3/2, a degree-five fiber has total common pole weight
at most7. At ell=1 an e=1 point consumes four sheets and an e=3
point two; the only total weights within five sheets are0,1,3,6.
The possible parameter value is unique because c->c^4 permutes
mu29. Tame Laurent traces give the same residues as before:
\[
\operatorname{res}_c\operatorname{Tr}(u)
 =[22]d_c(\epsilon^{-1}c^{-3}-c),\qquad
\operatorname{res}_c\operatorname{Tr}(v)
 =[22]d_c(c-\epsilon c^5).
\tag{1}
\]
At other places u,v are integral, so their traces are integral
even if t is wildly ramified there. Hence the old partial-fraction
derivation of all four trace equations remains valid. Local endpoint
jets are independent of the number of branches and of the free
resonant coefficient through the fourth coefficient.

## Fully concentrated endpoints force large singularity defects

Because k(S)=k(u,t), the normalization of the image in
P1_u times P1_t is S. Its bidegree has arithmetic genus4(n-1).
The five points over t=0 are unramified for t. If they have a
common alpha and phase, their u-graphs have pairwise difference
order at least three, by the resonance equation in the cubic-descent
proof. They are distinct because u,t generate the function field.
Thus their one image point contributes delta at least
binomial(5,2)*3=30.

At infinity set w=1/t and V=w^3u. The five normalized V-branches
have the same leading value and pairwise difference order at least
two. Therefore
\[
\frac1{u_i}-\frac1{u_j}
 =w^3\frac{V_j-V_i}{V_iV_j}
\]
has order at least five. The five smooth branches at the common
image(infinity,infinity) contribute delta at least50. The two
points are distinct, and all further singularity contributions
are nonnegative. Hence g(S)<=4(n-1)-30-50=4n-84 and n>=21.
No genericity of the resonant coefficients is assumed.

## Vanishing endpoint sums are not vanishing common-pole moments

Five copies of one label contribute zero in characteristic five
to each of C,E,U,V. Put K=F_(5^14), bar(a)=a^(5^7),
x=S2=sum d_c c^2 and y=S6=sum d_c c^6. The resulting homogeneous
trace equations are only
\[
x=\epsilon y,\qquad \bar y=\epsilon\bar x,\qquad
\epsilon x^{625}=\bar y^5,\qquad
\bar x^{625}=\epsilon y^5.
\tag{2}
\]
If y!=0 they imply epsilon in K and epsilon*bar(epsilon)=1,
not a contradiction. For epsilon=1,x=y=1 every equation holds.
A weight residue concentrated at c=1 supplies these moments;
the exceptional common value has zero trace residue in(1).
If y=0, x=0 and no scalar field bound follows from(2).
Thus neither universal moment vanishing nor a finite field bound
on epsilon may be imposed on this whole stratum. The remaining
problem requires information that survives fivefold cancellation.
