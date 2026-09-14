# Proof: count homology covers and their quotients

[Statement](../../Theorems/curve_arithmetic/low_genus_arithmetic_bounds.md).
The same argument treats h=2 and h=3.

## 1. A common bound for the norm-one groups

Let Γ be an arithmetic surface group of genus h. Its square subgroup
Δ is the kernel of abelianization modulo2, so Γ/Δ=(Z/2)^(2h)
and Δ uniformizes a curve of genus G=1+2^(2h)(h−1).
By [Takeuchi, Section3, final remark, p.609](https://www.jstage.jst.go.jp/article/jmath1948/27/4/27_4_600/_pdf/-char/en),
Δ lies in a maximal-order norm-one group Λ. Apply the result to the
inverse image of Γ in SL₂(R); its square subgroup projects to Δ.
For h≤3, area(Λ)≤4π(G−1)≤512π.

Let F be its totally real center, n=[F:Q], d=disc(F), and
P=∏_(𝔭|D_B)(N𝔭−1). The covolume formula
[Macasieb, Section2.2, equation3](https://arxiv.org/pdf/0803.1519) gives

    d^(3/2) P ≤64(4π²)^n.

The unconditional estimate [Odlyzko, Theorem1(5), p.210](https://www.jstage.jst.go.jp/article/tmj1949/29/2/29_2_209/_pdf/-char/en)
implies d≥50^n exp(−70). Since 50^(3/2)/(4π²)>8 and
3^5<2^8, one obtains 8^n<64e^105<2^174. The convenient bounds

    n≤64,       d≤2^260,       P≤2^390                 (1)

therefore work for both genera.

Minkowski's second theorem gives n independent integral elements
whose real conjugates have absolute value≤√d: the product of the
successive minima of the sup-norm cube is≤√d, and each minimum is≥1
by the nonzero integral norm. For n>1, avoid the binom(n,2) equality
hyperplanes of distinct embeddings in the coefficient grid
{0,…,binom(n,2)}^n. The resulting primitive integral element has all
conjugates bounded by n³√d≤2^148. Its minimal-polynomial
coefficients are bounded by2^(64+64·148)<2^10000. Including F=Q,
there are fewer than2^700000 possible fields.

For every such field, the number of integral ideals of norm≤M is

    A_F(M)≤M²ζ_F(2)<2^n M².

There are at most n norm-two primes, and q≤(q−1)² for q≥3;
hence N(D_B)≤2^n P²≤2^844. The possible finite quaternion
discriminants number fewer than2^1800. Allow64 choices of the split
real place. By [Macasieb, Section2.3, equations4–5](https://arxiv.org/pdf/0803.1519),
the number of maximal-order types is at most h_F^+≤2^n h_F.
Minkowski supplies ideal-class representatives of norm≤√d, so this
is less than2^(2n)d≤2^388<2^400. Including the two orientations,

    number of relevant Λ <2^710000.                    (2)

## 2. Count subgroups, then recover the original surfaces

Set a=84(G−1). The minimum orientable orbifold area π/21 gives
[Λ:Δ]≤a. If Λ has compact signature(h₀;m₁,…,m_s), its area
bound gives4h₀+s≤4G; thus4G generators suffice. Counting coset
actions bounds all its subgroups of index at most a by a(a!)^(4G).

Each torsion-free Δ of genus G gives a curve with at most a
automorphisms. The original curve is its quotient by Γ/Δ.
Even counting every subset of its automorphism group gives at most
2^a choices. This includes original groups Γ outside Λ and all
noncongruence subgroups. Therefore

    |S_h| <2^710000 a(a!)^(4G) 2^a.

Using b=ceil(log₂a) gives the following strict bounds:

| h | G | a | 4G | 710000+b+4Gab+a |
| --- | --- | --- | --- | --- |
| 2 | 17 | 1344 | 68 | 1716667<2000000 |
| 3 | 129 | 10752 | 516 | 78393214<80000000 |

## 3. A fixed place accounts for every good reduction

The set S_h is Galois-stable. Indeed an arithmetic curve has a
finite etale span with a torsion-free congruence Shimura curve T;
taking a core in its group makes the common cover Galois over the
original curve. The cover descends to Q̄ by
[Stacks, Lemma58.9.3](https://stacks.math.columbia.edu/tag/0A49);
its finite deck group and quotient do too. Galois conjugates of T
are again quaternionic congruence Shimura curves by
[Kucharczyk, Proposition5.3 and Theorem5.4, pp.228–229](https://content.algebraicgeometry.nl/2018-2/2018-2-007.pdf).
Conjugating the span therefore preserves arithmeticity and genus,
including for noncongruence curves.

Fix Q̄→Q̄_p and a geometric residue identification. Potential good
reduction defines a partial map red_p on S_h. Every place of every
number-field model is obtained by precomposing this embedding with
a global Galois automorphism, so its reduction belongs to red_p(S_h).
Residue conjugates add no classes: residue automorphisms lift through
the unramified local Galois quotient, preserve the elements algebraic
over Q, and restrict to global Galois automorphisms. Twists and
extensions used to obtain good reduction have the same geometric
fiber by [stable-model uniqueness, Stacks109.24.2](https://stacks.math.columbia.edu/tag/0E8C).
Hence |E_(h,p)|≤|S_h| for every p.

## 4. Genus-three partners of a fixed characteristic-zero curve

If A is arithmetic, so is every curve sharing a finite etale cover
with it, and the preceding genus-three count applies.

Otherwise its commensurator Λ is discrete and contains every partner
lattice after conjugation:
[Mochizuki, Sections2–3, Proposition3.2](https://www.kurims.kyoto-u.ac.jp/~motizuki/Correspondences%20on%20Hyperbolic%20Curves.pdf).
A genus-three partner has area8π, so [Λ:Γ]≤168 and Λ has at
most12 generators. The number of partners is therefore at most

    168(168!)^12 <2^(8+12·168·8)<2^17000.

For any algebraically closed characteristic-zero field, descend a
finite collection of proposed partners, A and their witnessing maps
to a finitely generated field and embed it in C. The complex bound
applies to every finite collection, hence to the whole set.
