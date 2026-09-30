# The pole budget does not grow with the covering degree

30 September2026.
[Statement](../../Theorems/cartier_and_spin/uniform_admissible_source_energy.md).
Use the uniform norm theorem, the constant-remainder lemma and
the twisted-square identity, all at their stated scopes. The argument
below keeps the actual connected etale map and its split completed
local algebras. It is not an arbitrary separable-source argument.

The remainder has zero quartic coefficient. Therefore Qsharp is
unchanged by b -> b+c, f -> f-c^5 for any rational base function c.
This permits regular primitive frames locally without altering the
global differential. Also phi=varphi on the source is unchanged.
Its source expression is
\[
\mathcal Q^\sharp=
\operatorname{Tr}\frac{(dw+3w\,dq/\varphi)^2}{\varphi}
\]
in every such frame.

The supports of E and G are disjoint. At a finite point of E, a
positive G multiplicity would make ord(varphi)=3-5g and
ord(dvarphi)=2-5g, contradicting ord(h*df)=2. At a point of E over
O the corresponding orders are -7-5g and -8-5g, again contradicting
ord(h*df)=-8. These comparisons use etaleness and coefficients not
divisible by five.

## Finite points

At every affine point there is a base translation making q regular.
At an ordinary point the original f is regular. At a cubic branch
point the established polynomial B0 satisfies Q-B0^5 divisible by
P^2, so the frame w=b+B0/y and q=(Q-B0^5)/y^5 is regular there.
It is only a change of primitive, not a change of the actual map.

At a root of varphi, the divisor hypothesis makes its order exactly
three. Such a point lies over R_X. At a finite marked point, df has
order two. Subtracting the constant part of q then makes q have
order exactly three. A source root contributing a zero of varphi
must reduce to zero, and the twisted-square lemma gives at most a
simple pole for its summand.

An integral source root with varphi a unit contributes a regular
summand. A pole of a source root in a regular q-frame has some order
m>=1 and makes varphi=w^5+q have pole5m. The term dw has pole at
most m+1, whereas 3w dq/varphi is regular. Consequently the source
summand has order at least 3m-2>=1. These statements also cover
fibers containing both selected zeros and poles on different sheets.

Taking traces is summation in the etale completed algebra, so it
adds no poles or denominators. Qsharp therefore has only simple
finite poles, all at the finite support of h_*E. The polynomial A,
or the smaller t in the statement, removes them.

## Infinity

Use the short primitive frame q=(Q-L0^5)/y^5, which has pole seven
at O. Put u=x^3/y, a uniformizer at O. If a source point belongs to
E, the divisor of varphi gives pole seven, so w has pole at most
one. At any other source point above O, varphi has pole10+5g for
some g>=0, forcing w to have pole m=2+g>=2.

For a large root of pole m>=2, varphi has pole5m, and dq has pole
at most eight. The term w dq/varphi has order at least4m-8, while
dw has pole at most m+1. Thus its energy summand has order at least
3m-2>=4.

For the remaining roots write w_i=c_i u^-1+O(1), and put
q=q_-7 u^-7+O(u^-6). The universal identity Tr(w^2/varphi)=0 has
coefficient at u^5 equal to q_-7^-1 sum c_i^2: every large root
starts at order at least six. Hence sum c_i^2=0. For each small
root, dw+3w dq/varphi has leading coefficient3c_i u^-2 du, because
-1+3*(-7)=3 in characteristic five. The order-three coefficient
of its squared energy is therefore 9c_i^2/q_-7. Summation cancels
it. The small-root sum has order at least four as well.

This proves ord_O(Qsharp)>=4, independently of how many small or
large roots occur. Since A has pole twelve, A Qsharp has pole at
most eight at O. More generally t has pole3d and leaves pole at
most3d-4. The finite-point analysis proves the claimed global section.

Finally div(omega0)=16O. Division by omega0^2 changes the pole
bound8 to40. The displayed monomials have pole orders3i+10j<=40,
and their three ranges have14+11+7=32 elements, giving the usual
Riemann--Roch basis on the cubic curve.

The proof does not show that the quartic remainder coefficient is
zero on every admissible cover, or that Qsharp is nonzero. Either
would be an additional theorem. It also does not extract the
admissible primitive from an arbitrary two-map common cover.
