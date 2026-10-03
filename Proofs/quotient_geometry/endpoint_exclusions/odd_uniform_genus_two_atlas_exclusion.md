# Proof: odd uniform degrees and the local first-layer bound

Version1. [Statement](../../../Theorems/quotient_geometry/endpoint_exclusions/odd_uniform_genus_two_atlas_exclusion.md). Interpret uniform local ramification via the actual quotient atlas supplied by the canonical-different extraction; more generally assume the Galois completed local extension TYPE, including the different and all ramification groups, is uniform throughout each branch fiber. The needed scope is this actual atlas, not arbitrary equal-index local extensions.

For d>1, the target has genus zero or one. An elliptic target has total different two. Wild ramification contributes at least four at a point, impossible; the remaining tame odd-degree elliptic case is already excluded by the selected endpoint elliptic-map arguments. The tame rational case is the accepted odd uniform-atlas exclusion. We handle the wild rational case.

Every inertia order divides the odd d. A wild contribution to the area is at least1+3/d; every other inertia has odd order at least three, contributing at least2/3. The genus-two area is2/d. Two wild values or one wild and two further values exceed that area. Thus there is one wild value and at most one other value.

If only one wild value exists, (d/e)Δ=2d+2. The odd integer d/e divides two, so e=d and Δ=2d+2. A coarse coordinate with its pole there has differential divisor2Q at the unique point above it. This is a nonzero REGULAR exact differential on the ordinary Y, impossible. Hence exactly one wild and one tame value remain.

Write the wild inertia qt with q=5^a and t odd prime to five, and the tame inertia gm with g=gcd(t,gm), t=gt0. The genus-two area gives
\[
cm-qt_0=D\mid2,\quad c=\Delta-qt,\quad d=(2/D)qgt_0m.
\]
Since d is odd, D=2. All g,t0,m are odd; gcd(m,t0)=1 and the local tame different character gives t0|m+2. Positive ramification groups give c+1≡0 mod4. Also0<c<qt because the other tame order is at least three and c/e=1/(gm)+2/d. The auxiliary local HKG genus is S=c−q+2.

## A single-jump wild action is impossible

For a single positive lower jump j, c=j(q−1)−1. The accepted purely numerical single-jump bound at D=2 gives q≤16, so q=5. Its tangent character gives t|4j. Since t is odd, j≥t. If g≥3 and m≥1, then
\[
2=cm-5t_0\ge(4gt_0-1)m-5t_0\ge(4g-5)t_0-1\ge6.
\]
If g=1 then the other tame order m≥3, and the same lower bound is at least7t0−3≥4. Contradiction. This includes S=0 and all q=5 actions.

## Non-large multi-jump actions are impossible

Assume q≥25 and S≥4q/5. If m≥t0, then2≥(c−q)m≥(4q/5−2)m≥18. If m<t0, the odd divisor t0 of m+2 must equal m+2. Thus(c−q)m=2(q+1), and
\[
m\le2(q+1)/(4q/5-2)\le52/18<3.
\]
As m is odd, m=1,t0=3,c=3q+2. Then c+1=3(q+1)≡2 mod4, contradicting its required divisibility by four.

## Large multi-jump actions are impossible

Now0<S<4q/5. Reuse the accepted LOCAL first-layer inequalities: b=1, v=|I2|≥5, A=q/v=5^r, Q=5^ceil(r/2),
\[
S\ge4vQ/5,\quad t_0\mid A-1,\quad Q\mid2+2m.
\]
If m≥t0, then2≥S−2≥4Q−2, impossible. Hence t0=m+2 and(S−2)m=2(q+1), so
\[
m\le2(5A+1)/(4Q-2),\qquad Q\mid m+1.
\]
If r is odd, A=Q²/5 and m+1≤1+2(Q²+1)/(4Q−2)<Q, contradiction. If r is even, A=Q². For Q≥25, m+1<3Q; since m+1 is even, it must be2Q. For Q=5 the same estimate gives m+1≤15; the only positive EVEN multiple of five is again10=2Q. Thus t0=2Q+1 divides A−1=Q²−1. Multiplication by four then shows2Q+1 divides THREE, impossible for Q≥5.

All local possibilities are exhausted. For the actual canonical-different extraction its odd upper degree has exactly such complete Galois uniform local fibers, so it must be one. No simultaneous Galois closure of the original endpoint maps was presumed.
