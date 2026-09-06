# Degree-four regularization of shared Cartier-zero equations

Date: 2026-09-05. Direct algebraic proof; streamlined on the same date
to reference the equation theorem instead of repeating its calculations.
No lifting or corelessness assertion is used.

## Theorem

Let k be algebraically closed of characteristic five, and let
X <-f- Z -g-> Y be an actual finite etale span of smooth connected
projective curves of genus at least two. Suppose nonzero rational
d-pluriforms, with d>0 prime to five, satisfy

    f*s_X=g*s_Y,       C_h(s_C^r)=0,

where 1<=r<=4, rd=5h+1. Cartier zero on one endpoint implies it on
the other by separable pullback and injectivity. Set

    B_C={P : ord_P(s_C)/d is 1 or 2 modulo five},  C=X,Y.

There are connected covers pi_C:P_C->C of degree at most four such that:

- If B_C is empty, pi_C is the identity. Otherwise its degree is four,
  its index is exactly two above B_C, and it is unramified elsewhere.
- The equation of pi_C*s_C defines a regular dormant PGL2-oper.
- Every connected component W of the normalized reduced fiber product
  P_X x_X Z x_Y P_Y has finite etale surjective maps to BOTH P_X and
  P_Y. Their oper pullbacks and distinguished horizontal Borels agree.
- For nonempty B_C,
  g(P_C)-1=4(g(C)-1)+|B_C|.

The degree bound is independent of d; the endpoint choices and their
genera depend on B_C. Rational forms with poles are allowed.

## Proof

We use the [equation theorem](EXPLICIT_SECOND_ORDER_EQUATION_FOR_CARTIER_ZERO_PLURIFORMS.md).
For s=a(dt)^d it defines ell=a'/(da), Q=ell'-ell^2/2 and
y''+(Q/2)y=0. In the Cartier-zero branch the allowed local residues
E=ord(s)/d are 0,1,2,3; Q is regular exactly for E=0,3.
Under tame ramification of index n,

    ord(pi*s)=n ord(s)+d(n-1),       E'=n(E+1)-1.

Thus index two changes the bad residues 1,2 into the good residues
3,0. Cartier zero survives separable pullback, including ramified
pullback: for t=t(z), a_z=a(t)(t')^d and
a_z^r dz=(t')^(5h) pi*(a^r dt). Ordinary Cartier commutes with the
one-form pullback and extracts the fifth-power factor. This also
proves that a nonzero Cartier output cannot become zero.

For a curve C and nonempty reduced B, choose a nontrivial element of
Pic^0(C)[2], giving a connected etale double T->C. The reduced divisor
D above B has even degree 2|B|. Choose L with L^2=O_T(D), using
surjectivity of multiplication by two on Pic^0(T). The cyclic double
P->T defined by the section with divisor D is smooth and connected:
locally at D its equation is w^2=t times a unit, and the odd valuation
also proves that its generic quadratic algebra is a field. It is
ramified precisely over D. The composite has the required degree and
branching. Twice applying Riemann--Hurwitz gives the genus formula.
For empty B take the identity.

Since the original legs are etale and the forms are actually shared,

    f*B_X=g*B_Y.

The fiber product is finite flat over each smooth endpoint and
generically a product of separable fields. Its irreducible components
dominate both endpoints (flatness excludes vertical components).
Normalizing and choosing a component therefore gives a smooth
connected projective W with finite separable surjections to both P_C.

Check ramification at a point z of Z. The original etale maps identify
the three completed local fields with k((t)). Off the common bad set,
all endpoint extensions are locally trivial. On that set both selected
endpoint extensions are the UNIQUE tame quadratic extension
k((sqrt(t))): units have square roots by Hensel's lemma and k is
algebraically closed. Their compositum is the same field. Every
normalized local branch therefore has relative degree one over either
endpoint completion. The two maps from W are etale. Normalization is
essential; the unnormalized fiber product may be singular.

The pullback order calculation proves regularity. The equation
theorem supplies a rational horizontal fundamental system of
Wronskian one, hence zero p-curvature, extending everywhere by
regularity. This gives the dormant projective oper. The shared
pluriform identity and the Schwarzian pullback law identify the two
opers on the actual W.

Finally the Riccati solution y'/y=-ell/2 specifies a natural rational
horizontal projective line. It extends on each regular endpoint by
saturation, or by properness of the associated projective-line bundle.
Its second fundamental map is generically zero and regular, so the
extension remains horizontal. Equality on W follows from generic
equality and uniqueness of extension. This reduction is additional
to the oper Borel; the two may meet. This proves the theorem.

## Scope

This uniform degree-four result needs neither corelessness nor uniform
zero multiplicities. It does NOT preserve corelessness in general.
The [core-preserving transverse reduction](CORE_PRESERVING_TAME_REDUCTION_TO_TRANSVERSE_DORMANT_MIURA_DATA.md)
retains corelessness and removes the remaining collisions under stronger
hypotheses, at the price of larger endpoint degrees. Thus neither
statement replaces the other. Neither is a fixed-endpoint obstruction.
