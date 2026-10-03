# Proof of the singleton cyclic triple exclusion

ID: `first_trace_cyclic_triple_exclusion`. Version1,2 October2026.
[Statement](../../Theorems/cartier_and_spin/first_trace_cyclic_triple_exclusion.md).

Suppose B_Y/J is cyclic of length three at P. With local parameter
tau and a primitive covector ell, write
J={v:ell(v) belongs to tau³R}; its fibre image is W=ker(ell mod tau).
The inclusion of every original source image I_i in J is integral.

At a cubic branch the source U_i/I_i is killed by tau. Therefore
tau U_i is contained in J, and the fibre U_i equals W. In its
primitive parameter t this fibre is spanned by [t],[t²],[t⁴].
It has no vector of primitive order three. At an infinity sheet the
three original primitive columns have orders2,8,11. Dividing the
order-eight column by tau gives primitive order three. Its inclusion
in J would put that divided fibre in W, a contradiction. Thus the
presence of a branch sheet forbids all infinity sheets above P.
Regular sheets are allowed and have I_i=U_i.

On the original source let L=h*U intersect g*J, and let t be its
contact loss in h*U. The line g*J/L is a quotient of the actual
finite-coefficient-generated first trace, hence has nonnegative
degree. Its degree is t-5n, so t>=5n. All contact is over P in
the singleton case. At a branch its loss is at most one; at infinity
at most three; at an ordinary sheet it is zero. Since the original
infinity fibre has n points, absence of branch sheets would give
t<=3n. A branch sheet must therefore occur, excluding all infinity
sheets by the preceding paragraph.

Now every sheet above P has source U/I killed by tau. Etale trace
and its module linearity imply tau H is contained in J at P.
Away from P, J=B_Y and therefore H=B_Y. Thus H/J is supported
at P and killed by tau. However J is contained in H and
deg H>=3 by the accepted saturated trace bound. H/J has length at
least two and is a submodule of the cyclic length-three B_Y/J.
Every such submodule is cyclic; length at least two prevents it
from being killed by tau. This contradiction proves the assertion.

The original local lattice and primitive-order inputs are given in
[the first saturated trace proof](first_saturated_cartier_trace.md).
The preceding author derivation also records the complete-fibre
radical-evaluation consequence:
[original derivation](../../Research/experiments/oct02_global_extraction/CYCLIC_FIRST_TRACE_DEFECT.md).
That extra containment is not needed for the contradiction and is
not promoted to a clump or equality of embedded fields.
