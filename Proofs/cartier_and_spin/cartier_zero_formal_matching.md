# Proof: an Euler equation gives the whole formal stabilizer

[Statement](../../Theorems/cartier_and_spin/cartier_zero_formal_matching.md).
Author /root,2026-09-08. Only formal series and characteristic-p
differentiation enter the argument.

## Normalization

Choose b=a^(1/d) in k[[x]]^*, and put q=(rd-1)/p. In a rational
dx-frame, the coefficient of s^r is

    x^(er) a^r = x^(er) b*(b^q)^p.

The Cartier product rule shows that its generalized Cartier image
vanishes exactly when C(x^(er)b dx)=0. Thus, writing b=sum b_j x^j,

    b_j=0 whenever e*r+j=-1 mod p,
    equivalently whenever n+d*j=0 mod p, n=e+d.       (1)

Since b_0!=0, (1) forces p not to divide n. Define the unit U by

    U_j=n*b_j/(n+d*j) if n+d*j!=0 mod p,
    U_j=0 otherwise.

It satisfies the ordinary linear Euler equation

    x U'+(n/d)U=(n/d)b.                              (2)

Choose any constant v_0 with v_0^n=b_0^d, take the unique unit root
v^n=U^d with v(0)=v_0, and put w=U/v. Then w^d=v^e and v*w=U.
Differentiating U=v*w gives U'=(n/d)w v'. Equation (2) becomes

    w(v+xv')=b.

For t=xv this proves

    t^e(t')^d=x^e v^e(v+xv')^d=x^e b^d=x^e a.

Conversely t^e(dt)^d has Cartier-zero eligible power whenever
p does not divide e+d: the monomial coefficient t^(er) has no
Cartier-surviving exponent. Formal coordinate invariance of Cartier
proves the converse. If p divides e+d, the leading coefficient
survives, so normalization to a Cartier-zero model cannot occur.

## All automorphisms

Let h(t)=lambda*t*v(t), v(0)=1. Comparing leading coefficients in
h^e(h')^d=t^e gives lambda^n=1. The unique unit d-th root of that
equation then gives

    v^(e/d)*(v+t v')=1.

For U=v^(n/d), with all unit roots normalized to constant1, this is

    t U'=-(n/d)(U-1).

Therefore U-1 has coefficients only in positive degrees j satisfying
n+dj=0 mod p. Since k is perfect, it is uniquely t^m B(t)^p, for
B in k[[t]] and the stated m. Conversely every such U solves the
equation. Taking v=U^(d/n) proves the claimed exhaustive formula.

For two branches with the same lambda, the difference of their U's
is t^m(B_1-B_2)^p. A unit power with exponent prime to p preserves
the order of a difference (factor the difference of n-th/d-th powers).
Thus their contact is 1+m+p*ord(B_1-B_2). Distinct slopes have contact1.
There are exactly n slopes since p does not divide n.

## Exact sharpness

Partition N branches among these n slopes. The lower bound is
binom(N,2)+m*sum binom(N_i,2). It is minimized by balancing the N_i:
if N_i>=N_j+2, moving one branch from i to j lowers that sum.
For each slope choose N_i distinct constants for B. All same-slope
contacts are then exactly m+1, attaining the bound simultaneously.
The branches satisfy the algebraic equation

    (h/(lambda*t))^n=(1+B^p*t^m)^d,

whose unit root is separable. This establishes algebraicity of these
model branches, not their extension to projective bi-etale maps.

For the notation of contact_degree_bound, its least same-slope contact
is m+1. Its Cauchy--Schwarz estimate can be rounded using the balanced
integer sizes above, but the leading quadratic coefficient cannot be
increased using further local tensor/Cartier identities alone.

A one-core independent series check covered176 profiles with
p=3,5,7, 1<=d<=9, 0<=e<=9 and p not dividing d(e+d), at precision36.
It checked the original tensor identity, Euler normalization, Cartier
coefficients and sharp first contact, and passed in0.131s. This is a
sanity check of the formulas, not the proof or a global cover computation.
