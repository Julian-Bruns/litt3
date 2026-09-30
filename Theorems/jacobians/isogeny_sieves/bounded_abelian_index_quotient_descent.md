# Ordinary quotients above an abelian subgroup of bounded index

Version2,24 September2026. The sharper abelian case retains its
separate character calculation. Author proof with focused local checks.

Let X/F25 be the fixed genus-nine curve, and let
\[
X\xleftarrow f Z\xrightarrow gY
\]
be ACTUAL finite etale maps from the SAME smooth proper connected
curve, where Y is ordinary of genus two. Let W->X be the Galois
closure of f, with group G of order N. Suppose G has an abelian
subgroup A of index at most D. Neither A nor either original leg
is required to be normal or Galois, respectively. J(Y) need not
be simple, and |A| is unrestricted.

Put
\[
M_D=16D+2,\qquad
L_D=\max\{D(D!)^{18},\ 5^{M_D},\ 4M_D^2+1,\ 13\}.
\tag{1}
\]
Let m_Y be the F25-Frobenius orbit length of the geometric
isomorphism class of Y. If a prime r>L_D divides m_Y, then some
prime ell dividing N, with ell!=5, satisfies
\[
\boxed{\quad \ell=r\quad\text{or}\quad
\operatorname{ord}_r(\ell)\le M_D.\quad}
\tag{2}
\]
In particular ell>r^(1/M_D).

When $D=1$, so the ORIGINAL $X$-leg is Galois abelian of order
$N=|G|$, the sharper character calculation gives the same alternative
for EVERY prime $r>1025$ dividing $m_Y$, with exponent $18$:
\[
\ell\mid N,\quad\ell\ne5,\qquad
\ell=r\quad\text{or}\quad\operatorname{ord}_r(\ell)\le18.
\tag{2a}
\]
In particular the main partner has no such abelian $X$-leg with
$N=2^a3^b5^c$, for any nonnegative $a,b,c$.

For the MAIN selected partner, set D0=335999!. Its prescribed
moduli prime r is already large enough for the following exclusion:
\[
\boxed{\quad
\begin{gathered}
G\text{ has an abelian subgroup of index at most }D_0,\\
\text{every prime divisor of }|G|\text{ is at most }D_0
\end{gathered}
\quad\Longrightarrow\quad
\text{no such actual common cover exists}.
\quad}
\tag{3}
\]
Both the abelian subgroup order and the TOTAL cover degree remain
unbounded. This extends the abelian-cover exclusion to nonabelian
mixed-prime groups with bounded abelian index. It does not supply
such an index bound for every possible common-cover group.

The proof needs only the genus and finite-field model of X with
its rational point, not the geometric simplicity of its Jacobian.
The backup's moduli degree three does not meet the large-prime
condition, and both unrestricted common-cover problems remain open.

[Proof](../../../Proofs/jacobians/isogeny_sieves/bounded_abelian_index_quotient_descent.md).
