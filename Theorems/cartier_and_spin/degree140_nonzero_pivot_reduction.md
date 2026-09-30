# Nonzero-pivot degree140 squares: finite scales and finite constant-case ratios

Version1, 25 September2026. Retain the full lower boundary U=V=0 of
[degree-ten square boundaries](degree_ten_square_boundaries.md), its
eleven choices v=1 or v=x-r with P(r)=0, and ALL defining equations
and open pole conditions. The
[exceptional-pivot locus](degree140_exceptional_square_exclusion.md)
is already empty.

On the nonzero-pivot chart set q=w^3 and mu=kappa^{-1}/w. Set H=h*w
for v=1, and H=h/w for linear v. In the exact cube-free chart let
d_v(q) be its Cramer denominator and Psi_v(H,q) the numerator with
F6=Psi_v/(q*d_v^2). The open set is
\[
Hq\,d_v(q)\,\Psi_v(H,q)\,\mu\ne0.
\]
The following results hold with arbitrary geometric parameters.

1. Allowing mu=0 as an auxiliary boundary, the square locus is finite
   over its two-dimensional ratio base (H,q). Each ratio pair has
   at most75 square scales for constant v, or104 for linear v.
   Its ratio image is closed and lies on a proper necessary curve.
   The full square locus has dimension at most one.
2. Every boundary on which the highest H-coefficient of Psi_v vanishes
   is empty, for all eleven v choices. No additional H or scaling
   restriction is imposed. The excluded nonzero q-values are, in the
   exact K-code below:
   constant15383; linear cases in the root order
   (9,14,2514,7367,20130,104315,139659,154113,281660,364472):
   (10149,287131,206388,98115,363438,222658,366267,256870,262368,151691).
3. Locally beyond the returned results: the entire constant-v fiber
   q=1 is empty, with every geometric H and mu retained.
4. More strongly, for constant v the set of q-coordinates of square
   points is finite. A nonzero rational elimination function D(q)
   is specified by exact determinant circuits in the proof, and every
   allowed square satisfies D(q)=0. Its only possible coefficient
   denominators occur at q=0 or at the already excluded highest-
   coefficient boundary.

The coefficient field is K=F25(alpha), with F25 as in the fixed
curve convention and alpha^4+[7]alpha^3+[6]alpha^2+[2]alpha+[5]=0.
The code c0+25c1+625c2+15625c3 denotes
[c0]+[c1]alpha+[c2]alpha^2+[c3]alpha^3.

The function D(q) has not been expanded or factored. Its finite
necessary q-set has not been enumerated, and the remaining fibers
are not excluded. In particular, statement4 does NOT assert that
the entire square locus is finite: curves over exceptional fixed
q-values remain possible. No degree140 square witness or actual
etale common cover is supplied. Degrees142/144 remain separate.

[Proof and reproducible evidence](../../Proofs/cartier_and_spin/degree140_nonzero_pivot_reduction.md).
