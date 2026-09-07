# A scalar model for nilpotent connections and their quartic tensors

Let C/k be smooth, projective and connected, with genus g>=2 over an
algebraically closed field of characteristic five. Use the
[projective-connection conventions](../Definitions/Def_projective_connections.md).
No congruence assumption on g is needed. Put N=3g−3.

1. After choosing one regular projective connection and a basis of
   H^0(C,omega^2), the nilpotent locus is defined by exactly N polynomials

       x_i^5 + terms of total degree at most4,  i=1,...,N.

   They are a Groebner basis for every degree-compatible monomial order.
   The nilpotent scheme has length exactly5^N, with standard monomials
   x_1^e1...x_N^eN, 0<=e_i<5. There are no solutions at infinity in this
   presentation. This is the characteristic-five scalar realization of
   Mochizuki's finite-flat nilpotent count, not a new general finiteness claim.

2. There is an etale-pullback-compatible bijection on geometric points
   between ACTIVE regular nilpotent connections and nonzero sections

       s in H^0(C,omega^4),   C_3(s^4)=s,

   whose zero orders are all0 or2 modulo5. In a separating parameter,
   the mutually inverse maps are

       r -> s=(r''−3r^2)(dt)^4/3,
       s=a(dt)^4 -> r=3a''/a+(a'/a)^2.

   This part is a pointwise dictionary, not a claimed scheme isomorphism
   between semilinear Cartier equations and the nilpotent scheme.

3. Let D be the collision divisor of the oper line and the saturated
   p-curvature kernel, and let S be the zero divisor of p-curvature.
   Then D is reduced, S=5R for an effective divisor R, and EXACTLY

       div(s)=2D+5R.

   This remains true when D and R overlap. Such a connection has
   nowhere-zero p-curvature (is admissible) iff every positive zero
   order of s is exactly2. Higher orders0/2mod5 cannot be replaced by2.

The divisor-factorization statement has a characteristic-independent
form: for an active regular nilpotent rank-two oper in any odd
characteristic p, its square-Hasse divisor is2D+pR, D reduced and R
effective, with degree(p−1)(2g−2). In particular EVERY active regular
nilpotent oper on a genus-two curve in odd characteristic is admissible.

For ANY actual coreless finite bi-etale span involving the fixed genus-nine
X and any hyperbolic partner, EVERY common regular ACTIVE nilpotent
connection is admissible, including on the same common source. No cover
degree, Galois, Hom-zero, or prior clump-existence hypothesis is needed.
Its quartic has32 double zeros on X. This says nothing about ordinariness
of that connection on the common source or existence of a common connection.

The length is125 for genus two and5^24 for genus nine. It is not the
dormant-oper count and need not be the number of distinct points. This
does not assert that two endpoint connections have compatible pullbacks,
nor that an arbitrary common cover preserves any connection.

Version3,2026-09-07: exact divisor decomposition allowing overlap, its
all-odd-characteristic genus-two consequence, and the fixed-X corollary.
Author scalar proof; classical finite-flat count
independently sourced. No independent audit of the assembled dictionary.
[Proof](../Solutions/Sol_nilpotent_scalar_model.md).
