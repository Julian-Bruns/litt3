# Pole orders reduce critical descent to210 quartic twists

29 September2026. [Statement](../../Theorems/cartier_and_spin/degree140_root9_critical_nondescent.md).
All coordinates and coefficients refer to the actual source in the
[critical-cover proof](degree140_root9_critical_scale_budget.md).
Write
\[
\Delta=\delta_0(x)+\delta_1(x)y+\delta_2(x)y^2,
\quad \deg(\delta_0,\delta_1,\delta_2)\le(10,7,4).
\]
The coefficient B of x4 in delta2 is a fixed nonzero constant. Delta
is regular on affine X and has exact pole32 at O. The earlier compact
identity proves that delta1 squared minus4 delta0 delta2 is never the
zero polynomial at an allowed ratio.

## An arbitrary descended square class

Suppose Delta=f*g2, with f a downstairs square class. Since k is
algebraically closed, represent that class by a monic squarefree
polynomial f in k[x]. Put ell=deg f. At O, the identity of valuations
gives ell even and
\[
-\operatorname{ord}_O(g)=d=(32-3\ell)/2.
\]
Let F be the product of the common roots of f and P, and m=deg F.
At an unramified finite point, regularity of Delta forces g to be
regular. At a cubic branch point in F, g may have a simple pole;
at all other finite points it is regular. The allowed pole divisor is
cubic-invariant. Decomposing g into its three characters therefore gives
\[
g=a(x)+b(x)y+c(x)y^2/F(x),
\]
where a,b,c are polynomials. Their infinity orders are in distinct
residue classes modulo three, so
\[
3\deg a\le d,\quad 3\deg b+10\le d,
\quad 3\deg c+20-3m\le d.
\]
No cancellation between characters is possible.

If b=0, coefficient comparison gives P*delta2 squared=4 delta0 delta1.
The left side has exact degree18, while the right side has degree at
most17, a contradiction. If c=0, it gives delta1 squared=4 delta0
delta2, excluded by the existing exact identity. Thus b and c are both
nonzero. The two remaining degree inequalities imply
\[
\ell\le4,\qquad6m-3\ell\ge8,\qquad m\le\ell.
\]
With ell even, these force ell=m=4. Hence f=F is a monic quartic
divisor of P, b and c are nonzero constants, and deg a<=3. There are
exactly binomial(10,4)=210 choices, all defined over the supplied field K.
This includes every geometric downstairs square class.

## The finite coefficient equations

Put C=c/b and R=delta2-B*f. Then b2=B, deg R<=3, and the other two
coefficients of Delta=f*g2 are equivalent to
\[
C\delta_1=fR+B(P/f)C^3,
\qquad4BC^2\delta_0=fR^2+3B^2PC^3.
\]
They are exact polynomial identities in x, not just conditions on a
chosen set of points. The x7 coefficient of the first is
\[
C\delta_{1,7}=\delta_{2,3}-Bf_3.
\]

For efficient elimination use H=h/w, q=w3, and normalize
delta0=w2*d0, delta1=w*d1, delta2=d2. These identities follow term by
term from the actual source. Set k=w*C and M=d1[7]. M is a nonzero
linear polynomial in H only. The equations become
\[
qk d_1=qfR+B(P/f)k^3,
\qquad4Bqk^2d_0=qfR^2+3B^2Pk^3,
\]
with k*M=N=d2[3]-B*f3. Each of the210 choices is treated on two charts:

- If M is nonzero, substitute k=N/M and impose q*M*N nonzero. N is
  required nonzero because C is. Clear the original rational-function
  denominators and coefficient powers of q; the resulting ideal,
  including inv*q*M*N-1, contains1.
- If M=0, specialize H to its exact single K-value and retain k as an
  independent nonzero variable. Use every coefficient of the two
  displayed identities and inv*q*k-1. Each resulting ideal also
  contains1. In particular the x7 coefficient retains N=0; no leading
  coefficient was silently inverted on this boundary.

All420 ideals have explicit polynomial combinations equal to1. The
[construction](../../scripts/arithmetic/root9_critical_descent_20260929.sage)
retains the original equations, quartic, multipliers and arithmetic
outcome separately for each chart. The
[literal checker](../../scripts/arithmetic/verify_root9_critical_descent_20260929.sage)
multiplies the saved identities without running elimination. Evidence
and execution receipts are in the
[external data directory](../../../litt3-computation-data/conceptual_continuation_20260929/root9_critical/descent/).
The accepted source reconstruction is not replayed. The new coordinate
normalization and all coefficient identities are computed exactly.

## The consequence for the scale norm

If the square class of Delta were cubic-invariant, its norm would be a
downstairs representative of that same class: the product of the three
conjugate classes equals its cube, hence itself. Thus nondescent is
equivalent here to a nontrivial cubic orbit of the class.

The discriminant of the actual quadratic scale polynomial is Delta
times a square, whenever nonzero. Its monic quadratic therefore cannot
be fixed by the cubic action. The three conjugate irreducible quadratics
are distinct; their product is irreducible over k(x), being the minimal
polynomial of a root in the degree-six composite extension. Removing
fixed x-content does not alter this field or its smooth normalization.

This argument removes a previous primitivity assumption from
irreducibility of the nonvertical component. It does not remove the
fixed content itself and does not exclude a specialized square norm.
