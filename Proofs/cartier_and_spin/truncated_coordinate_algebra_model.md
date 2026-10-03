# Proof: the coordinate group and its primitive canonical character

[Statement](../../Theorems/cartier_and_spin/truncated_coordinate_algebra_model.md).
All subspaces below are subrepresentations of the GROUP SCHEME,
not merely invariant subspaces for its k-points.

## The group and its monomial weights

An automorphism over a k-algebra R sends t to
\[
a_0+a_1t+\cdots+a_{q-1}t^{q-1},\qquad a_0^q=0,
\quad a_1\in R^\times.
\]
These conditions are necessary and sufficient. After reduction at
any prime of R, the constant term vanishes and the linear term must
be nonzero. Conversely these conditions make the algebra map an
isomorphism after reduction at every prime, hence an isomorphism of
the finite free R-module R[t]/(t^q). This gives the stated coordinate
ring. Scaling t by lambda gives a copy of G_m whose distinct weights
on B_r are 1,...,q-1. Every subrepresentation is therefore spanned
by a subset of the monomials t^i, 1<=i<q.

Let W be a nonzero such subrepresentation, and let s be the least
p-adic valuation among the exponents it contains. Choose i in W
with v_p(i)=s. The infinitesimal translations
\[
t\longmapsto t+b,\qquad b^q=0,
\]
belong to G_r. In their coaction on t^i, the coefficient of
b^{i-p^s} is binom(i,p^s)t^{p^s}. Lucas' formula makes this binomial
coefficient nonzero modulo p. Therefore t^{p^s} belongs to W.

For 2<=m<q, use the automorphism t->t+a t^m with a an indeterminate.
It sends this last monomial to
\[
t^{p^s}+a^{p^s}t^{mp^s}.
\]
Consequently every t^{mp^s} with mp^s<q belongs to W. The minimality
of s excludes all remaining exponents. Thus W=k[t^{p^s}]/k.
Conversely these subspaces are stable under every automorphism,
by the p^s-power identity. This proves the complete lattice.

Subobjects of a quotient correspond to subobjects of B_r containing
its denominator. Hence the adjacent factors are simple. A splitting
of an adjacent two-factor extension would give another intermediate
subobject, contradicting the lattice just proved. This proves actual
nonsplitting, not only a statement about composition multiplicities.

## Characters remember the infinitesimal translations

Let G_{r,aug} denote the subgroup a_0=0. It is a semidirect product of
G_m and the successive additive coefficient groups of the t-adic
coordinate filtration. Thus every character of G_{r,aug} is a_1^n
for some integer n.

The translation subgroup alpha_q has no nontrivial character.
Indeed a character would be a polynomial h(b), of degree less than q,
with h(0)=1 and h(b+c)=h(b)h(c) in k[b,c]/(b^q,c^q).
If its highest nonzero degree were d>0, the right side would have
nonzero coefficient h_d^2 at b^d c^d; the left side has total degree
at most d. This is impossible. Thus h=1.

Every point of G_r factors into a translation and a zero-constant
coordinate change. A character of G_r must consequently be a_1^n
on the whole coordinate ring. Compose a translation by b with the
quadratic shear t->t+a t^2. Both have character one, but the resulting
linear coefficient is 1+2ab. Therefore
\[
(1+2ab)^n=1\quad\text{in }k[a,b]/(b^q).
\]
Since p is odd, this identity is equivalent to p^r dividing n. One
can see necessity from the first nonzero term of (1+z)^n in
characteristic p, at degree p^{v_p(n)}; negative n use the finite
inverse series. Conversely a_1^q is a character: in composition the
linear coefficient is a_1 times the derivative of the other change
at the nilpotent constant term. Its qth power kills all contributions
from that constant term. Hence X^*(G_r)=Z chi_r as asserted.

The determinant on B_r has scaling weight 1+...+(q-1)=q(q-1)/2.
The character calculation identifies it uniquely with
chi_r^{(q-1)/2}. In particular chi_r has no pth root as a character,
even though its underlying regular function is a pth power. The
putative root a_1^{q/p} fails the multiplication law in the nilpotent
directions; passing to reduced points would lose this obstruction.

Restriction to k[t^p] gives G_{r+1}->G_r. In coordinates it sends
the target coefficient b_i to a_i^p, 0<=i<p^r. This map is faithfully
flat: the nilpotent constant ring extension is free of rank p, the
other specified coefficients are polynomial or Laurent pth-root
extensions, and the remaining coefficients are free variables.
The pullback of chi_r is chi_{r+1}. A character of the affine inverse
limit factors through a finite stage, since G_m is of finite
presentation. Thus the inverse limit also has character group Z,
with the same non-p-divisible generator.

## Every simple factor has the same primitive-character pairing

For q=p^r the form
\[
b_q(\bar f,\bar g)=[t^{q-1}](f g')
\]
on A_r/k is well defined, since [t^(q-1)] of an exact derivative
is zero. It is alternating for odd p. In the monomial basis its
only nonzero entries have i+j=q and value j modulo p.
Its radical is exactly k[t^p]/k, so it is perfect on the top
simple factor P_r/P_(r-1).

This pairing has the required FULL group-scheme covariance.
Let phi=sum a_i t^i be the universal coordinate change. For
1<=i,j<q put n=i+j, and work first over the p-torsion-free
universal ring Z_(p)[a_0,...,a_(q-1),a_1^-1].
Differentiation gives the integral identity
\[
n[t^{q-1}]\bigl(\phi^{n-1}\phi'\bigr)
=q[t^q]\phi^n.
\]
If n!=q, then2<=n<=2q-2 implies v_p(n)<r. Cancel that
p-power in this universal ring; the left coefficient is
divisible by p and vanishes in characteristic p.
For n=q, cancelling q gives
[t^(q-1)]phi^(q-1)phi'=[t^q]phi^q=a_1^q modulo p.
Multiplication by j proves, for all monomial pairs and hence
all f,g,
\[
b_q(\phi^*f,\phi^*g)=a_1^q b_q(f,g).
\]
The identity survives a_0^q=0 and arbitrary base change. In
particular no infinitesimal translation has been discarded.

For P_j set u=t^(p^(r-j)). Its algebra is k[u]/(u^(p^j)),
and P_(j-1)=k[u^p]/k. The induced coefficient change has
b_i=a_i^(p^(r-j)). Applying the top-factor argument gives a
perfect alternating form on P_j/P_(j-1) with character
b_1^(p^j)=a_1^(p^r)=chi_r. Restriction to the Frobenius
subalgebra preserves this u and the coefficient formula, so
the pairings commute with the tower maps.

At p=5 and r=1, the Lie operators d/dt and t²d/dt connect
the four weights, giving the familiar alternative irreducibility
check. The reduced group instead fixes the entire t-adic flag.
The full covariance calculation keeps the nonreduced directions.

## Relation to the geometric problem

The geometric fiber of F_*^{[r]}O_C at a smooth point is precisely
A_r. Its Frobenius subalgebras give the displayed P_j. Thus this is
the relevant coordinate algebra, rather than an unrelated chosen
matrix representation. Nevertheless the calculation does NOT
realize any prescribed pair of projective curves or two maps between
them. In particular it does not account for the three actual global
Cartier-kernel forms on the selected X, their lattice, or the actual
two-leg traces. Those additional geometric restrictions remain the
possible source of a contradiction.

The later [general seed theorem](common_atiyah_jet_obstruction.md)
explains the same all-layer duality on actual common Cartier bundles.
The present algebra proof is independent of that geometric result.
It replaces the earlier bounded coaction and pairing checks; their
original receipt remains external provenance. The primitive character
is still not p-divisible, even after every pairing and every height
is retained. Actual global geometry remains additional input.
