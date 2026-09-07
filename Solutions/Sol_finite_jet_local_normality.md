# Proof: controlled determinacy and finite local Galois tests

[Statement and audit metadata](../Theorems/Thm_finite_jet_local_normality.md).
Write v for z-adic order, e=v(f), δ=v(f′),
N=max(δ+2,2δ−e+3) and q=N−δ≥2.

## 1. Correction with controlled order and uniqueness

Hasse derivatives satisfy v(f^[j])≥max(0,e−j).
For v(x)=1 and v(u)=r≥2 this gives

    v(f(x+u)−f(x)−f′(x)u)≥e−2+2r.                         (1)

For2≤j≤e use e−j+jr≥e−2+2r; for j>e use jr≥e−2+2r.
The latter also handles e=1; zero derivatives cause no difficulty.

Start x_0=z. If the error has finite order n_i≥N, put
u_i=(g−f(x_i))/f′(x_i) and x_(i+1)=x_i+u_i.
Substitution by a uniformizer preserves v(f′)=δ, so
r_i=n_i−δ≥q and (1) gives n_(i+1)≥e−2+2(n_i−δ)≥n_i+1.
Thus x_i converges to φ=z+O(z^q) with f(φ)=g.

For two such solutions differing first in order r≥q, the linear
difference has order δ+r, strictly below every nonlinear term
because q>δ−e+2. It cannot vanish. This proves uniqueness and also
that an exact f-preserving automorphism trivial modulo z^q is the
identity. This is formal convergence in the given characteristic,
with no root extraction; the correction works over any coefficient field.

## 2. Approximate jets recover exactly the automorphism group

For ψ∈A_N(f)(k), take its polynomial representative and apply Section1
to F=f∘ψ and g=f. The orders of F,F′ are e,δ by the chain rule.
It gives η≡id mod z^q with F∘η=f; thus ρ=ψ∘η is an exact
k((f))-automorphism with the same(q−1)-jet as ψ.

Conversely every exact automorphism supplies such a jet, and two exact
automorphisms with the same truncation are equal by uniqueness.
Truncation respects composition. Hence the image modulo z^q of
A_N(f)(k), not all of A_N, is precisely the actual automorphism group.

The extension k((z))/k((f)) is separable of degree e: k[[z]] is free
of rank e over k[[f]], and f′≠0 is separability. Its automorphism
group has size≤e, with equality exactly for a Galois extension.
Count distinct geometric points, not scheme length or the possibly
positive-dimensional high-jet fibers of A_N.

The same correction applied to f∘ψ proves that f(ψ)=g modulo z^N
is equivalent to an exact fixed-base isomorphism. Only coefficients
below N occur; ψ′(0)≠0 is encoded by an inverse variable.
Elimination and reduced zero-dimensional point counting on the
truncation image give a finite algebraic test, with no small-runtime claim.

## 3. Target tails and the determinacy reference

For h(t)=t+O(t²), v(h(f)−f)≥2e, so correction applies if2e≥N.
As δ≥e−1, the sufficient condition3e>2δ+2 bounds both terms of N
by2e. It gives N=1289,3289 and q=146 for the stated two examples.
A target scaling h(t)=at, a≠1, is NOT absorbed; comparing several
extensions still requires the SAME fixed target field.

The bound2δ−e+2 for right determinacy is Boubakri–Greuel–Markwig's,
recalled in [Nguyen, Remark2.6(c), p.240](https://www.journalofsing.org/volume10/nguyen.pdf).
A d-jet includes degree d, so N=d+1. Nguyen's Definition2.1 and
Proposition2.8 give a sharper support-dependent bound; its upper-bound
proof on p.241 successively removes coefficients by source changes.
The controlled proof here additionally gives the correction order and
uniqueness needed for the Galois certificate. Matching different
exponents alone never proves local normality or an actual atlas.
