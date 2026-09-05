# Heisenberg central twists and the order-125 residual case

**Status:** author-checked local theorem and application, 2026-09-05.
**Author:** `/root/canonical_trace_algebra`.
**Boundary:** this excludes the specified order-125 local filtration. It
does not exclude the remaining family in higher orders, construct a global
cover, or alter the fixed curves. The Artin–Schreier and central
embedding-problem ingredients are standard; no novelty claim is made.

## 1. A central-twist ramification lemma

Let $k$ be algebraically closed of odd characteristic $p$, and put

$$
 K=k((t)),\qquad M=K(X),\qquad X^{p^2}-X=t^{-1}.
$$

Identify $E=\operatorname{Gal}(M/K)$ with the additive group of
$\mathbf F_{p^2}$, acting by $X\mapsto X+a$. Suppose $L/K$ is a
Galois extension with $M\subset L$, whose group is the nonabelian
exponent-$p$ group of order $p^3$, with center

$$
 H=\operatorname{Gal}(L/M)\simeq C_p.
$$

Then the single lower ramification break of $L/M$ is either

$$
 \boxed{p+1}
 \quad\text{or}\quad
 \boxed{p^2n-p^2+1\quad(n\ge2,\ p\nmid n)}.                 \tag{1}
$$

This is a statement about this **fixed normalized weak quotient**. It is
not asserted for an arbitrary weak elementary-abelian quotient without
the normalization proved in Section 2 below.

### A baseline Heisenberg solution

Choose $0\ne\theta\in\mathbf F_{p^2}$ with
$\theta^p=-\theta$. The extension

$$
 L_0=M(Y),\qquad Y^p-Y=\theta X^{p+1}                       \tag{2}
$$

has relative break $p+1$. Indeed, $X^{-1}$ is a uniformizer of $M$:
its equation over $K$ is the Eisenstein equation

$$
 U^{p^2}+tU^{p^2-1}-t=0.
$$

For every $a\in\mathbf F_{p^2}$, choose $B_a\in k$ satisfying
$B_a^p-B_a=\theta a^{p+1}$. The substitutions

$$
 X\longmapsto X+a,\qquad
 Y\longmapsto Y-\theta a^pX+B_a                            \tag{3}
$$

preserve (2). This follows by expanding $(X+a)^{p+1}$ and using
$(-\theta a^p)^p=\theta a$. Together with $Y\mapsto Y+j$,
$j\in\mathbf F_p$, they give all $p^3$ automorphisms over $K$.
The commutator pairing, up to the convention for commutators, is

$$
 (a,b)\longmapsto\theta(a^pb-ab^p)\in\mathbf F_p.           \tag{4}
$$

It is nonzero alternating. Every lift (3) has order $p$, because
$pB_a=0$ and $\sum_{i=0}^{p-1}i=0$ in characteristic $p$.
Thus (2) is an exponent-$p$ Heisenberg solution.

### Why all solutions differ by a base-field character

An exponent-$p$ central extension of a two-dimensional
$\mathbf F_p$-space by $\mathbf F_p$, with nonzero commutator,
is determined by its alternating commutator pairing. Explicitly, after
choosing lifts of a basis, its presentation is

$$
 u^p=v^p=z^p=1,\quad z\text{ central},\quad [u,v]=z^d,
 \qquad d\in\mathbf F_p^*.
$$

Rescaling the center identifies its pairing with (4), without changing
the identified quotient $E$. There is no further power-map component
in an exponent-$p$ extension.

Fix this central extension $G\to E$ and the quotient homomorphism
$\psi:G_K\to E$ defining $M/K$. If
$\phi,\phi_0:G_K\to G$ are two lifts of the same $\psi$, then

$$
 \chi(\sigma)=\phi(\sigma)\phi_0(\sigma)^{-1}\in\mathbf F_p
$$

is a continuous homomorphism: centrality proves multiplicativity
directly. Conversely multiplication by such a character gives another
lift. Therefore labeled solutions differ by $H^1(K,\mathbf F_p)$.
This is not a claim that its action on unlabeled isomorphism classes of
fields is free. Restricting the two homomorphisms to $G_M$ shows that
the relative Artin–Schreier class has the form

$$
 [\theta X^{p+1}+f(t)]\in M/\wp(M),\qquad f(t)\in K,
 \quad\wp(z)=z^p-z.                                      \tag{5}
$$

All such lifts remain surjective: a subgroup of this Heisenberg group
surjecting onto $E$ contains lifts of two independent elements, hence
their nonzero commutator and the full center. No tame-equivariance
condition is imposed on the twists; allowing all twists only enlarges
the possible solutions and is sufficient for a necessary condition.

### Exact conductor of a restricted base character

Every class in $K/\wp(K)$ has a unique reduced polar representative

$$
 f(t)=\sum_{n>0,\ p\nmid n} a_n t^{-n}.
$$

The sum is finite; constants and power-series terms are in
$\wp(k[[t]])$. Suppose its largest pole is $n\ge2$, with coefficient
$a_n=a\ne0$. Under $t^{-1}=X^{p^2}-X$, its leading term expands as

$$
 a(X^{p^2}-X)^n
 =aX^{p^2n}-naX^{p^2n-p^2+1}
   +\text{terms of smaller degree}.                      \tag{6}
$$

The first monomial reduces modulo $\wp(M)$ to
$a^{1/p^2}X^n$. The possible intermediate degree $pn$ is strictly
less than $p^2n-p^2+1$ for odd $p$ and $n\ge2$. The second
displayed monomial has nonzero coefficient and exponent

$$
 b=p^2n-p^2+1\equiv1\pmod p.
$$

It survives reduction. Every other term in (6) has smaller degree, as
does every monomial coming from a smaller pole of $f$: their degrees
are at most $p^2(n-1)<b$. Artin–Schreier reduction only lowers degrees.
Consequently the restricted character has break exactly $b$.

For a pole of order one, the exact reduction is

$$
 a(X^{p^2}-X)\equiv(a^{1/p^2}-a)X\pmod{\wp(M)}.
$$

Its break is therefore one or the character is zero. It vanishes
precisely for $a\in\mathbf F_{p^2}$. Thus a restricted base character
has break one, is zero, or has break $p^2n-p^2+1\ge p^2+1$.
None has break $p+1$. Adding it to the baseline class in (5) cannot
cancel the baseline leading term: unequal positive breaks combine by
taking their maximum. This proves (1).

## 2. Why the tame cubic action supplies the normalization

Now let $p=5$. Suppose $M/K$ is weakly ramified with group
$E\simeq C_5^2$, and an order-three tame automorphism acts on the
tower $M/K$, acting faithfully on $K$.

A tame finite-order automorphism of $k((t))$ can be linearized by
averaging a uniformizer. Thus take $\tau(t)=\rho t$, where $\rho$
is a primitive cube root of unity. Artin–Schreier theory represents
$M/K$ by a two-dimensional $\mathbf F_5$-subspace of
$K/\wp(K)$. Since every nonzero character has conductor one, this
subspace is

$$
 \{a/t:a\in A\},\qquad A\subset k,\quad\dim_{\mathbf F_5}A=2.
$$

The tower action makes $A$ stable under multiplication by
$\rho^{-1}$. Since $\mathbf F_5(\rho)=\mathbf F_{25}$, it follows
that $A=\lambda\mathbf F_{25}$ for some $\lambda\ne0$.
Replacing $t$ by $t/\lambda$, the character space is
$\mathbf F_{25}/t$. This is exactly the extension

$$
 X^{25}-X=t^{-1}.
$$

Indeed, for $a\in\mathbf F_{25}$, the element
$U_a=aX+a^5X^5$ satisfies $U_a^5-U_a=a/t$, and the additive
equation has degree 25 by the Eisenstein argument above. This proves
the normalization from the given tame symmetry; it does not assume a
primitive or distinguished generator of a general weak quotient.

## 3. Exclusion of the residual order-125 filtration

Consider a local inertia group $I=P\rtimes C_m$ in characteristic
five, where

$$
 |P|=125,\quad |P/G_2|=25,\quad
 \epsilon=\sum_{i\ge1}(|G_i|-1)=384,
 \quad m\in\{6,12,24\}.
$$

These are the $q=3$ instances of the rows in
[the finite first-break filter](NONWEAK_TWO_POINT_FIRST_BREAK_FINITE_FILTER.md).
The following proof is conditional only on this displayed local data;
it does not use the unproved tail inequality used to obtain that filter.

Put $H=G_2$. Its order is five, so it is central in $P$, since a
$5$-group acts trivially on $\operatorname{Aut}(C_5)=C_4$.
The remaining filtration is $H$ through a single last index $r$.
The different contribution gives

$$
 384=(125-1)+(r-1)(5-1),\qquad r=66.                       \tag{7}
$$

For the $P$-extension the last upper jump is

$$
 1+\frac{66-1}{25}=\frac{18}{5}.                          \tag{8}
$$

By compatibility of upper ramification groups with quotients, $P/H$
has its sole jump at one. It is therefore the weak quotient $E$ of
Section 2.

Take the subgroup $C_3\subset C_m$. On the first graded quotient
$E=G_1/G_2$, its action is irreducible over $\mathbf F_5$: the
leading-coefficient embedding of this quotient into the residue field
intertwines conjugation with multiplication by a primitive cubic root
(or its inverse), whose minimal polynomial has degree two over
$\mathbf F_5$. Its action on $H=C_5$ is trivial.

Since $P/H$ is abelian and $H$ is central, $P$ has class at most
two. Its fifth-power map

$$
 E\longrightarrow H,\qquad \bar u\longmapsto u^5
$$

is well-defined and $\mathbf F_5$-linear: $H$ has exponent five,
and the commutator correction in $(uv)^5$ has exponent
$\binom52=10$. It is also $C_3$-equivariant. There is no nonzero
equivariant map from the irreducible two-dimensional module $E$ to
the trivial one-dimensional module $H$. Hence $P$ has exponent five.
This explicitly eliminates the possible fifth-power component of the
central extension class.

If $P$ were abelian, it would be $C_5^3$. Its upper jumps would be
integers, since its Artin–Schreier characters have integer conductors
(equivalently, by Hasse–Arf). This contradicts (8). Thus $P$ is
nonabelian; its nonzero alternating commutator pairing makes it the
exponent-five Heisenberg group.

Let $L$ be the top local field, $K=L^P$, and $M=L^H$. The chosen
tame $C_3$ acts faithfully on $K$: otherwise its generator would
belong to $\operatorname{Gal}(L/K)=P$. Section 2 applies, and Section 1
therefore forces the break of $L/M$ to be

$$
 6\quad\text{or}\quad25n-24\quad(n\ge2,\ 5\nmid n).         \tag{9}
$$

Lower ramification groups are compatible with subgroups, so this same
relative break is the index $r=66$ in (7). But $66\ne6$ and
$66\equiv16\pmod{25}$, whereas every second value in (9) is
congruent to one. This is a contradiction.

**Conclusion:** none of the three specified $q=3$ rows admits a local
inertia action. This argument alone says nothing about $q\ge4$.

As an independent check, the first graded quotient has tame eigenvalues
$\zeta^{-1},\zeta^{-5}$ for a primitive $m$-th root $\zeta$,
whereas $H$ has character $\zeta^{-66}$. Equivariance of the nonzero
commutator gives $m\mid66-6=60$, already excluding $m=24$.
The central-twist argument is needed for $m=6,12$.

## 4. Primary-source context

The reduced Artin–Schreier pole and ramification facts used above are
stated for perfect residue fields in Lara Thomas,
[Ramification groups in Artin–Schreier–Witt extensions](https://www.numdam.org/item/JTNB_2005__17_2_689_0.pdf),
Proposition 2.1 (printed pp. 694–695); quotient compatibility is recalled
immediately before it. The proof here specializes these standard facts
and computes the restricted polar term explicitly.

Victor Abrashkin,
[A ramification filtration of the Galois group of a local field](https://archive.mpim-bonn.mpg.de/1271/1/preprint_1993_11.pdf),
MPI/93-11, the example on printed p. 14 (PDF p. 16), gives explicit
nonabelian order-$p^3$ Artin–Schreier equations via the three-dimensional
Heisenberg Lie algebra. That is a primary near-match for the general
construction, not a cited exact statement of (1). The elementary proof
above supplies the fixed-quotient twisting and conductor calculation in
full; no exact literature-novelty assertion is made.
