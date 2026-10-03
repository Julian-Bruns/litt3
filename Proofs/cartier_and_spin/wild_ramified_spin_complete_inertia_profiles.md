# Proof: specialize the local first-layer inequalities to area one

Version1. [Statement](../../Theorems/cartier_and_spin/wild_ramified_spin_complete_inertia_profiles.md). The actual two-value reduction is retained. No endpoint atlas is presumed. The proof uses only the LOCAL HKG estimates proved in [the first-layer theorem](../quotient_geometry/local_actions/wild_first_layer.md), not its global étale-atlas hypothesis.

Write q=|I1|, e=qt, c=Δ−e, g=gcd(t,m_original), t=gt0, m_original=gm. The accepted ledger n=lcm(e,m_original) and area gives
\[
cm-qt_0=1,\quad\gcd(m,t_0)=1,\quad t_0\mid m+1.
\]
The last divisibility follows from t|c+1, the tangent character of the local different. Also c≥q−2. The area ensures0<c<e. Set S=c−q+2=2g(H), where H is the auxiliary local HKG curve of the wild subgroup. It is not substituted for the common-cover source.

If q=5, reuse the nine-profile theorem. Assume q≥25. Let b be the first positive lower break, N=I_(b+1), |I1/N|=5^r, Q=5^ceil(r/2). The accepted local Swan congruence gives
\[
Q\mid 1+(b+1)m.
\]
The local first-layer estimate says: if0<S<4q/5, then b=1 and, writing v=|I2|, A=q/v=5^r, one has
\[
S\ge4vQ/5,\quad t_0\mid A-1,\quad Q\mid1+2m.
\]
These are local group-action statements and the numerical ledger; their proofs do not use an actual endpoint atlas.

## Non-large HKG actions are impossible

Suppose S≥4q/5. If m≥t0, then1=cm−qt0≥(c−q)m≥(4q/5−2)m≥18, impossible. If m<t0, divisibility t0|m+1 forces t0=m+1. Thus(c−q)m=q+1, whence
\[
m\le(q+1)/(4q/5-2)\le26/18<2.
\]
So m=1,t0=2,c=2q+1. The first-break bound b(q−1)≤c+1=2q+2 gives b≤2 for q≥25. But Q|b+2≤4, whereas Q≥5. Contradiction.

If S=0, the wild action has a single positive lower jump. The computation-free numerical single-jump bound from [the jump proof,Section2](../quotient_geometry/local_actions/wild_jump_atlas_bounds.md) applies to cm−qt0=1 and t|c+1, yielding q≤(1+2)²=9. Thus this case cannot have q≥25.

## Large HKG actions have exactly two first-layer dimensions

Now0<S<4q/5, so b=1 and v≥5. If m≥t0, then1≥S−2≥4Q−2≥18, impossible. Therefore t0=m+1 and(S−2)m=q+1. Put A=5^r and q=vA. The local estimate gives
\[
m\le(vA+1)/(4vQ/5-2)\le(5A+1)/(4Q-2).
\]
Since Q|1+2m, if r is odd then A=Q²/5 and
\[
1+2m\le1+2(Q²+1)/(4Q-2)<Q
\]
for Q≥5, contradiction. If r is even and r≥4, then A=Q²,Q≥25, and1+2m<3Q. This is an ODD positive multiple of Q, hence equals Q. Thus m=(Q−1)/2,t0=(Q+1)/2. The equation(S−2)m=q+1 makes m divide q+1=vQ²+1 and hence v+1. Write v=5^a,Q=5^s. Reducing a modulo s shows
\[
(5^s-1)/2\le5^{s-1}+1,
\]
which is impossible for s≥2. Therefore r=2,Q=5,A=25.

Now m≤(25v+1)/(4v−2)≤7 for v≥5, while5|1+2m forces m≡2 mod5. The only possibilities m=2or7 are considered. Every positive ramification-group order is1 modulo4, so c+1≡0 mod4. Since q≡1 mod4, c−q≡2 mod4. The equation(c−q)m=q+1≡2 mod4 forces m ODD. Thus m=7,t0=8.

The exact auxiliary genus is S=(25v+1)/7+2=(25v+15)/7. Its lower bound S≥4v forces v≤5; hence v=5,q=125 and c=143. The order-five second group has a unique final lower break j, and S=(j−1)(5−1)=20 gives j=6.

The tame first-layer character acts on a two-dimensional F5-space, so t divides25−1=24. Since t=8g, necessarily g=1or3. Thus m_original=7g,e=1000g,n=7000g and Δ=e+143, giving exactly the two displayed profiles.

Together with the cyclic-five list this proves the asserted ELEVEN necessary profiles without any bound on the original wild group. It does not assert that any profile is realized globally, nor that the original X is an atlas of the quotient.
