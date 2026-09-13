# Proof: relative splitting and one monomial count

[Statement](../../Theorems/deformations/frobenius_truncated_hypersurfaces.md).

## 1. Coordinate changes compatible with the powers

The ideal (x₁^Q,x₂^q₂,…,x_d^q_d) is preserved by every invertible
change of x₁ that fixes the other variables, provided Q≥q_i.
Indeed, the Q-th power of each positive monomial lies in that ideal;
apply the inverse change for equality. Likewise (x^Q,y^Q,z^R), Q≥R,
allows arbitrary changes of x,y with z fixed and invertible univariate
changes of z. When all exponents equal Q, every formal change preserves
the intrinsic Frobenius power ideal m^[Q]. Units multiplying f do not
change its quotient.

If f has a nonzero x₁² coefficient, solve ∂f/∂x₁=0 formally for
x₁=c(x₂,…,x_d), shift by c, and complete the square by a unit square
root. This relative formal splitting uses only that 2 is invertible;
it gives f=x₁²+g, with g∈(x₂,…,x_d)², after a permissible change
and unit scaling. Over A=k[[x₂,…,x_d]]/(x₂^q₂,…,x_d^q_d), the quotient
by this equation is free with basis 1,x₁. Since Q is odd,

    x₁^Q=(−g)^((Q−1)/2)x₁.

The coefficient has total degree at least Q−1, above A's maximal
surviving degree Σ(q_i−1). Thus the extra relation x₁^Q is redundant
and the length is 2 dim_k A. If Q is uniquely largest, Q≥p max q_i;
for d−1≤p this gives the required strict inequality.

In two variables a nondegenerate quadratic splits formally as xy.
Balanced Frobenius powers survive that change; the quotient has basis
1,x,…,x^(Q−1),y,…,y^(Q−1), of length 2Q−1. The unequal case is
Part 1 with d=2, so needs no separate branch-coordinate argument.

## 2. Two equal largest exponents

For a nondegenerate quadratic restriction on the x,y plane, the same
relative splitting with z fixed gives xy+h(z). If h has order s
prime to p, an invertible univariate change absorbs the unit in h,
giving xy−z^s. These changes preserve (x^Q,y^Q,z^R).

Straightening xy=z^s gives the following independent standard monomials:

    z^c,                    0≤c<R;
    x^i z^c and y^i z^c,    1≤i<Q, 0≤c<min(R,s(Q−i)).

The extra cutoffs come from multiplying x^Q or y^Q by opposite powers.
For independence, embed the hypersurface in k[[a,b]] by
x=a^s, y=b^s, z=ab. Its monomials have distinct exponent pairs
with equal residues modulo s. The displayed bounds are exactly those
not divisible, within this semigroup, by x^Q,y^Q or z^R.
Here R≤Q≤sQ also ensures that the constant z-string has length R.
The count is therefore R+2Σ_(j=1)^(Q−1) min(R,sj).

For R=sm+r, 0≤r<s, split the sum at m. It becomes
2QR−sm²−r(2m+1), including r=0. When R≡1 mod s this is
2QR−(R²+s−1)/s. At Q=R arbitrary formal changes are allowed,
so the formal hypersurface type alone suffices.

If the plane restriction has rank one, choose its nondegenerate
x direction and split only x. The result is x²+g(y,z), where
g∈(y³,yz,z²). Give y weight 1 and z weight 2. Then g has weight
at least 3, whereas k[[y,z]]/(y^Q,z^R) has maximum weight
Q−1+2(R−1). The condition Q+3>4R is precisely

    3(Q−1)/2 > Q−1+2(R−1).

Thus g^((Q−1)/2)=0 and the length is 2QR. This needs no assumption
on uncomputed cubic or higher terms. For p≥5, Q>R implies Q≥5R
and hence the displayed inequality.

The [bounded audit](../../Research/audits/FROBENIUS_TRUNCATION_LENGTHS_AUDIT_2026_09_13.md)
checks the dimension-independent bound, monomial count and weighted
inequality. The original three-variable applications retain their
separate actual-cover and finite-jet evidence.
