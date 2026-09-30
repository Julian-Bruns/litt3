# The skew kernel determines multiplication

30 September2026.
[Statement](../../Theorems/cartier_and_spin/quartic_scalar_graph_skew_recovery.md).
Write e=pi(epsilon). Multiplication by epsilon is self-adjoint for
the trace pairing on L. Since K is orthogonal to V, its compression
A_epsilon(v)=pi(epsilon v) is self-adjoint on V. The proposed graph
therefore has
\[
M=A_\epsilon+e\otimes a,
\quad M-M^*=e\otimes a-a^\sharp\otimes e^\flat,
\]
where sharp and flat are the trace-pairing identifications.

If this skew map is nonzero, e and a-sharp are independent. Its
kernel consists exactly of the vectors k with a(k)=<e,k>=0.
It has dimension one. For such k,
\[
M(k)=\pi(\epsilon k),\qquad p_0(\epsilon k)=\langle e,k\rangle=0.
\]
Thus M(k)=epsilon k in the field L, which proves the formula.
The quotient is defined because a nonzero vector k is a nonzero
field element. Rescaling k cancels from the ratio.

Conversely, if this candidate is outside K, then pi(epsilon)!=0.
The three specified membership tests define unique scalars a(v_i).
Extending a linearly gives the graph on V. The constant shift in
the original equation epsilon(v+a(v))=M(v)+b(v) is
b(v)=p0(epsilon v)+a(v)p0(epsilon). Therefore nothing is lost by
testing only the displayed nonconstant membership condition.

Multiplying that original equation by k gives
\[
kM(v)-M(k)v=a(v)M(k)-b(v)k.
\]
When k,M(k) are independent, membership in their span is both
necessary and sufficient, with the two coefficients recovering a,b.
This gives the denominator-free version. An independent condition
on the four original rows remains necessary when the first three
span them only after projecting out constants.

In the Kummer basis the pairing matrix is m times the reverse
identity. The alternating matrix H M-M^T H therefore has entries
M32-M21, M33-M11 and M23-M12 above its diagonal, up to the
common nonzero scalar m. Its standard three-dimensional kernel
vector gives the stated k. This is a direct linear calculation.

On the self-adjoint boundary e and a-sharp are dependent, so
a(v)=kappa<e,v>. Compression of multiplication by
a+b t+c t2+d t3 is the first displayed matrix. The row of e-flat
is m(d,c,b), and its rank-one product with e gives the second
matrix. This covers kappa=0 and every zero coordinate of e;
the condition epsilon outside K still requires e!=0. It is an
exact boundary parameterization, not an existence assertion for
the genuine phase-pair incidence.

The incoming nine-by-six linear scalar-graph theorem already
establishes uniqueness without this case split. The present result
adds a direct formula on the open skew locus and an explicit
self-adjoint parameterization. It does not replace the genuine
phase data or the shared-moment completion by arbitrary matrices.
