# Proof: two normalized coefficient tables retain all zero boundaries

Version1,3 October2026. Frozen pending independent review; see the [statement](../../Theorems/cartier_and_spin/actual_q0_tensor_degree_six_nonreal_involution_zero_boundary_exclusion.md).

In the actual [signed elliptic reduction](actual_q0_tensor_degree_six_one_uniform_elliptic_reduction.md), put u0=a+a^-1,v0=a−a^-1,h=v0/u0,α=h². For the FOUR nonreal r choices both u0,v0 are nonzero. Since a²r=ONE, u_r=r^-1−r=u0v0 and
\[
\alpha\in\{2,3\},\quad U=u_0^2=4/(1-\alpha),\quad
u_r=Uh,\quad u_r^2=2.
\]
Changing a to its other root scales the map by minus ONE and leaves every norm-square condition unchanged. No r sign is discarded. Up to its nonzero scalar u0/TWO, the actual second map is
\[
f=(ht-1)L+(t+h)Y,\quad L=\lambda(t^2-1)+\mu t,
\quad \Phi=A(t^4+1)+B(t^3-t)+Ct^2,
\]
with ℓ=λ²,m=μ²,A=ℓ+ONE,B=TWO λμ−Uh,C=m−TWO ℓ+THREE. The source Hasse condition is exactly
\[
I=(\lambda^2-\mu^2)^2+(u_r\lambda-\mu)^2+2=0.
\]
The own-pole open is K=ONE+(ONE−α)ℓ≠ZERO, while ordinary ZERO/infinity require A≠ZERO. The necessary derivative norm is
\[
N=D^2-(E')^2\Phi,\quad
E'=h\lambda(3t^2-1)+(2h\mu-2\lambda)t-\mu,
\]
\[
D=3At^4+2hAt^3+(2C+4hB)t^2+(B+hC)t+(A+2hB),
\quad n_8=4AK\ne0.
\]
As in the other signed proofs this polynomial must be a square because the actual map has only finite indices ONE orTHREE.

If λ=ZERO, the source condition is m²+m+TWO=ZERO. Divide N by its leading coefficient FOUR and compare the top FOUR coefficients to obtain the unique monic square-root candidate t4+q3t3+q2t2+q1t+q0. Direct multiplication, using only m²=FOUR m+THREE, gives the following table.

| α | q3 | q2 | q1 | q0 | constant coefficient of N/n8 |
| --- | --- | --- | --- | --- | --- |
| TWO | FOUR h | THREE m+ONE | FOUR h | m+FOUR | ONE+m |
| THREE | FOUR h | ZERO | THREE mh | THREE m+THREE | ONE+m |

For α=TWO, q0²=TWO m+FOUR; its required equality to ONE+m forces m=TWO, which fails m²+m+TWO=ZERO. For α=THREE, q0²=FOUR m+ONE; the equality forces m=ZERO, also failing the source condition. Thus every λ=ZERO parameter is excluded, without requiring μ nonzero in advance.

If μ=ZERO, the source condition is ℓ²+TWO ℓ+TWO=ZERO, so ℓ=ONE orTWO. The α=TWO,ℓ=ONE case has K=ZERO and fails a genuine own-pole open. For the remaining THREE cases direct top-coefficient comparison gives

| α | ℓ | n8 | q3 | q2 | q1 | q0 | conflicting coefficient of N/n8 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| TWO | TWO | THREE | h | TWO | TWO h | ONE | constant THREE |
| THREE | ONE | TWO | TWO h | ONE | THREE h | ZERO | coefficient of t is h |
| THREE | TWO | FOUR | FOUR h | THREE | FOUR h | ZERO | constant THREE |

The first and last constants disagree with q0². In the middle row, the square's coefficient of t is TWO q1q0=ZERO whereas h≠ZERO. These contradictions retain both λ signs. The λ=μ=ZERO overlap already has I=TWO≠ZERO.

The tables use no fixed-P cube identity and no auxiliary discriminant saturation. They delete precisely the physical zero boundaries; the generic nonreal packets remain unexcluded.
