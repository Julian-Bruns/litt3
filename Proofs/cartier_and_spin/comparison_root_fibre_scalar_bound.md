# Proof: use the full norm before taking a cubic quotient

[Statement](../../Theorems/cartier_and_spin/comparison_root_fibre_scalar_bound.md).
The received quintic proof supplies the root-fibre idea. The extension
here replaces its minimal polynomial by the full actual norm, allowing
the argument before simultaneous cubic descent.

## The actual monic norm and its fibres

Set
\[
F(U,Z)=\operatorname{Nm}_{k(T)/k(u)}(Z-t).
\]
Since t has no poles off the fibre u=infinity, it is integral over k[u].
Hence F belongs to k[U,Z] and is monic of degree3n in Z. It need not be
irreducible or the minimal equation of t. None of the following uses
either property.

The map u:T->P1 is etale over every A-root, because h1 is etale and P,A
are coprime. Consequently its entire3n-point fibre gives
\[
F(\alpha_i,Z)=\prod_{p:u(p)=\alpha_i}(Z-t(p)).
\]
Repeated t-values remain as integer multiplicities. There is no pole of
t in this fibre. Its zero values are precisely the M_i chosen points.

At a nonzero value t=c, the quartic identity forces v=alpha_j. The other
actual map is also etale there. Comparing linear terms and then the
two-map differential identity gives
\[
\frac{dv}{du}(p)=\epsilon^4c^{-13}
 \frac{A'(\alpha_i)}{A'(\alpha_j)},\qquad
c^{87}=\epsilon^{29}c_{\alpha_i}/c_{\alpha_j}.
\tag{4}
\]
Let b_i be the unique29th root of c_alpha_i in E8. They are the four
25-Frobenius conjugates of b0. With beta_i=b0^((25^i-1)/3), one has
(beta_i/beta_j)^87=c_alpha_i/c_alpha_j. For gamma^3=epsilon, every
nonzero c/gamma therefore belongs to(beta_i/beta_j)mu87, a subset of H.

## Lowest products retain the integer multiplicities

Put G(U,z)=gamma^(-3n)F(U,gamma z), R_i=G(alpha_i,z), and lambda=gamma^-1.
All nonzero roots of each monic R_i lie in H. Its first nonzero
coefficient rho_i=[z^M_i]R_i thus belongs to H. Also
\[
G(U,0)=C\prod_i(U-\alpha_i)^{M_i},\qquad C\ne0.
\]
At a zero of t the quartic identity gives the actual local expansion
u=alpha_i+a_p t+O(t^2), with
\[
a_p=A_4(b_i\zeta^{j_p})^4/A'(\alpha_i)\in H.
\]
This calculation only requires a simple t-zero and the actual pole of v;
it is independent of the total number of endpoints or cubic descent.
Factoring the monic norm over the complete etale u-fibre and comparing
the lowest homogeneous terms gives
\[
\rho_i\lambda^{M_i}=B_iC,
\quad B_i=(-1)^{M_i}\prod_{p:t(p)=0,u(p)=\alpha_i}a_p
                  \prod_{j\ne i}(\alpha_i-\alpha_j)^{M_j}\in H.
\tag{5}
\]
For M_i=0 this is simply R_i(0)=B_i C and is included without exception.

Dividing(5) for i and0 gives lambda^(M_i-M_0) in H. An integer Bezout
combination proves lambda^g in H whenever g>0. Fifth powers act bijectively
on H and have unique geometric roots, so powers of five can be removed
from g. H has order29(5^8-1), divisible by three, and epsilon=lambda^-3;
the bound(1) follows. Equal multiplicities give no nonzero exponent and
must remain an explicit exceptional case.

## Pole eighteen, without assuming descent

The [supported-norm theorem](marked_divisor_relation_lattice.md) says that
Nm_(T/X1)(t) is a degree6 polynomial in u with A-supported roots. Write
their multiplicities m_i, with sum m_i=6. Its norm through the cubic
extension k(X1)/k(u) is its cube, proving M_i=3m_i in the full norm above.

For g_m=gcd_i(m_i-m_0), one always has g_m>0 and g_m divides6. If a root
is absent this gcd is the gcd of the positive multiplicities, so divides6.
If all four occur the only unordered partitions are3,1,1,1 and2,2,1,1,
with gcd2 and1 respectively. Thus(5) implies lambda^18 in H, equivalently
epsilon^6 in H. The latter is the group mu_(6*29*(5^8-1)).

Since29 is coprime to6(5^8-1), rescale t by a29th root and epsilon by its
inverse fourth power to remove the mu29 factor. The normalized scalar
then lies in mu_(6*(5^8-1)). With q=5^8, q is1 modulo6 and
6(q-1) divides q^6-1. This proves epsilon in F_(5^48), with the stronger
sixth-power restriction retained.

If the cubic quotient exists, use its full norm over k(u). Its endpoint
multiplicities are m_i, giving lambda^6 in H and epsilon^2 in H. The same
normalization places epsilon in mu_(2*(5^8-1)), contained in F_(5^16).
This last improvement is conditional on descent, not a proof of it.

The local product proof uses all actual fibre points and remains valid
for a reducible norm polynomial. It does not turn finite scalar choices
into an enumeration of curves or provide a missing second map.
