# Proof of the degree-six double-cover reduction

Use the established comparison normal form, simultaneous cubic quotient,
and complete pole-degree-three exclusion. No finite Galois closure over
both X-fields is introduced.

## Necessity

Let h_1,h_2:T->X be a jointly minimal degree-six counterexample to
new-line recognition. The positive nongap d=deg z is at most six,
so it is three or six. The first case is now excluded. Thus d=6
and the reduced divisors h_1^*O and h_2^*O are disjoint. The
simultaneous quotient field is
N=k(x_1,x_2)=k(x_1,z)=k(x_2,z), and k(T)/N is cyclic of degree
three. Its smooth proper model S has genus at most two. The
function s=z gives a degree-two separable map S->P1.

On T, z has simple zeros and poles. Ramification indices multiply
in T->S->P1, so both maps are unramified above zero and infinity.
There are two S-points over each. Since x has pole order three at
O on X, the pole divisors of x_1 and x_2 on S are three times
the fibers of s over infinity and zero, respectively.

A quadratic extension of k(s), unramified above zero and infinity,
has an equation w^2=B(s), where B is monic squarefree of even
degree 2g+2 and B(0)!=0. The affine coordinate ring is
k[s] plus k[s]w, and w has pole order g+1 at both infinity points.
The involution w->-w preserves the allowed pole divisors. Taking
the two eigenspaces therefore gives
x_1=a+bw and s^3x_2=c+dw with the bounds in the statement.
Neither b nor d is zero, because each x_i together with s generates
N. The two displayed nonvanishing conditions are exactly the
absence of a leading-term cancellation at either pole.

The normal form gives A(x_2)=kappa^6s^-13 A(x_1) and
theta_2=nu theta_1, nu=kappa^-7s^16. Homogenizing the former gives
the quartic identity. If r=y_2/y_1, then r^3=P(x_2)/P(x_1)
and Q/r^2=nu. Eliminating r gives the second identity. The
ramification comparison in the cubic diagrams gives the stated
indices one or three and the eleven allowed branch values for x_1.

## Sufficiency and the two actual maps

Start with any of the models in the statement. Both x_i have
degree six, hence are separating in characteristic five. Let t
be the number of index-three points of x_1. Tame Riemann--Hurwitz
gives 2g-2=-12+2t, hence t=g+5. The fibers over the eleven
specified values have total multiplicity66. Apart from those t
triple points they contain
\[
u=66-3t=51-3g
\]
unramified points. Infinity consists of two triple points, so these
u points lie over finite roots of P. At them P(x_1) has valuation
one. At the other finite points above roots it has valuation three,
and its two poles have order30. Consequently P(x_1) is not a cube,
and its cubic Kummer cover is connected, with exactly u tame branch
points. Its smooth normalization T satisfies
\[
2g(T)-2=3(2g-2)+2u=96.
\]
Thus g(T)=49.

The second identity says Q^3 P(x_1)^2=nu^3 P(x_2)^2. For
r=nu P(x_2)/(QP(x_1)) it gives both
\[
r^3=P(x_2)/P(x_1),\qquad r^2=Q/nu.
\]
Hence y_2=r y_1 satisfies y_2^3=P(x_2). Each pair (x_i,y_i)
defines an inclusion of the fixed X-field into k(T), hence a map
between smooth proper curves. Its degree is 18/3=6 and so it is
separable. Riemann--Hurwitz now has zero different degree:
96-6(2g(X)-2)=96-96=0. Effectivity of the different proves
that BOTH maps are everywhere etale, including all infinity and
Kummer branch points.

Their theta ratio is Q/r^2=nu. The quartic identity therefore gives
\[
(A(x_2)/A(x_1))^{16}(theta_2/theta_1)^{13}
=\kappa^{96-91}s^{-208+208}=\kappa^5.
\]
Thus the tensor, equivalently the actual saturated Cartier line,
is shared with the specified constant proportionality.

## Joint minimality and distinct fields

Let N'=k(x_1,x_2). The function x_1 is separating in k(S), hence
also in N'; the derivative ratio Q belongs to N'. The identities
give s^13 and s^48 in N', and
s=(s^48)^3/(s^13)^11. Since b!=0, w=(x_1-a(s))/b(s) also belongs
to N'. Thus N'=k(S), and adjoining y_1 gives all of k(T). The
two actual X-fields jointly generate the source.

If those fields were equal, the two maps would differ by an
automorphism of X. The supplied Aut(X)=C3 makes their theta
pullbacks proportional by a constant. This contradicts
theta_2/theta_1=kappa^-7s^16. Hence the fields differ. The established
cored recognition theorem then implies that any such realization
would be coreless. This last inference does not assume a
simultaneous Galois envelope.

All steps are reversible under the listed open and ramification
conditions. The subsequent
[two-end certificate](degree_six_tensor_exclusion.md) proves that these
models have no geometric point in any of the three genera. The present
reconstruction remains useful: it identifies exactly which two-map
problem that emptiness result decides. No geometric component has been
discarded by a finite-field search.
