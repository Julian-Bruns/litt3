# Ordinary-preserving covers need not have an ordinary-preserving common refinement

Date: 2026-09-05. Author: /root.
Status: direct proof and exact F5 scalar computation; no separate audit.
This is an intrinsic characteristic-five cover-structure result, not a
lifting assertion.

Fix X:y²=x⁵−x, η=dx/y, and

    A=(x⁴+x³+3x+4)η⁴.

For a connected finite étale cover π:C→X, call it good when the
semilinear operator

    T_(π*A): H⁰(C,ω_C²) → H⁰(C,ω_C²),  q ↦ C_1((π*A)q)

is invertible. For this normalized quartic this is equivalent to the
ordinary indigenous condition, but that interpretation is not needed
for the theorem below.

## Theorem

The connected étale double covers of X defined by adjoining

    sqrt(x(x−1))       and       sqrt(x−1)

are both good. Their connected degree-four fiber product is not good,
and no further connected étale refinement of that fiber product is
good. Thus these two good covers have no good connected common
refinement over X.

Equivalently, the good finite-monodromy coefficient modules for T_A
form a Serre subcategory but need not be closed under tensor products.
Consequently goodness is not, in general, the condition of factoring
through a quotient of the étale fundamental group.

## 1. Exact double-cover test

Let F(x)=a+bx+cx²+dx³+ex⁴ and consider the standard connected étale
double cover

    T:v²=u⁸−1 → X,       x=u², y=uv,    ρ=du/v.

The pulled-back quartic is F(u²)ρ⁴, because η pulls back to 2ρ.
The invariant subspace of H⁰(T,ω_T²) is the pullback of H⁰(X,ω_X²).
The anti-invariant subspace has basis

    uρ², u³ρ², vρ².

These are regular by the finite-branch and infinity valuations.
For the first two vectors the Cartier block before inverse Frobenius
is

    M = [e−2a    d  ],
        [  b    a−2e]

and the last vector has scalar block c. Indeed the polynomial block
is obtained by selecting coefficients in degrees 4 modulo 5 of
F(u²)(u⁸−1)² times u or u³. For vρ² the expression is
ρ C(F(u²)du). Therefore the additional subspace is ordinary exactly
when

    c ≠ 0,        det(M)=3(a²+e²)−bd ≠ 0.

The operator on X for A is invertible, as established in the
[square certificate and audited destruction theorem](FINITE_ETALE_COVER_DESTROYS_ALL_ORDINARY_INDIGENOUS_DATA_ON_ONE_CURVE.md).

For a matrix γ=(a b;c d) in GL₂(F₅), the corresponding transformation
x↦(ax+b)/(cx+d) lifts to an automorphism of X over k. The quartic
coefficient transforms by

    F^γ(x) = det(γ)² Σ_i F_i (ax+b)^i(cx+d)^(4−i).

Thus composing the standard double with γ tests the double class
represented by the branch pair {γ(0),γ(∞)}.

For F=x⁴+x³+3x+4 the needed exact computations are:

| Branch pair | Matrix γ | Coefficients of F^γ, increasing degree | c | det(M) |
|---|---|---|---|---|
| {0,1} | (1 0;1 1) | (4,4,3,1,4) | 3 | 2 |
| {1,∞} | (1 1;0 1) | (4,0,4,0,1) | 4 | 1 |
| {0,∞} | identity | (4,3,0,1,1) | 0 | 3 |

All entries are in F₅, and follow by expanding the displayed degree-four
formula. The first two covers are good; the third is not.

## 2. The actual common refinement

The branch pairs {0,1} and {1,∞} represent independent nonzero
elements of Pic(X)[2]. Their fiber product is consequently connected,
Galois of degree four, and étale. Its function field contains

    sqrt(x(x−1))/sqrt(x−1) = sqrt(x).

It therefore dominates the bad standard double T→X. On T an
explicit nonzero regular kernel vector is vρ²:

    T_(A|T)(vρ²)=ρ C((u⁸+u⁶+3u²+4)du)=0.

Étale pullback preserves both this equation and nonvanishing of the
quadratic. The degree-four fiber product and every further connected
étale cover of it are bad.

Any connected common refinement over X of the two specified double
covers factors through their fiber product. It must therefore be bad.
This is about compatibility as covers of the specified X.

## 3. The representation-theoretic meaning

Let G=C₂×C₂ be the group of the degree-four cover, and let χ₁,χ₂ be
the two characters defining its two good double quotients. The
[exact coefficient-module theorem](TWISTED_CARTIER_ETALE_COVERS_AND_SIMPLE_MONODROMY_FACTORS.md)
identifies their quadratic operators with coefficient modules
1⊕χ₁ and 1⊕χ₂. Hence T_A is invertible for 1, χ₁ and χ₂.

The product character χ₁χ₂ defines the bad quotient adjoining
sqrt(x), so its coefficient operator is not invertible. Thus two
good rank-one coefficient modules can have a bad tensor product.
Exactness still gives closure under subquotients and extensions;
it does not give tensor closure.

## Scope

This gives an explicit limitation on attempts to organize all good
covers into a Galois category or a directed subsystem of covers.
It retains the actual fiber product and étale maps throughout.
It does not obstruct the existence of common covers without the
additional good-operator condition. In particular the two good
curves here have the displayed common étale cover.
