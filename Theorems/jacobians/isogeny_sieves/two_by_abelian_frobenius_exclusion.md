# Unbounded odd abelian quotients above a two-group are excluded

Version1,21September2026. Let $X/\mathbf F_{25}$ be the fixed
genus-nine curve and let $Y/\mathbf F_{25^b}$ be any genus-two
curve with $19\nmid b$. Let $n$ be odd and assume
\[
\begin{gathered}
\lambda\not\equiv0,1,-1\pmod {19}
\quad\text{for every prime }\lambda\mid n,\\
9\nmid\operatorname{ord}_n(2).
\end{gathered}
\tag{1}
\]
For $n=1$ the second condition means order one.

There is no actual finite etale span $X\leftarrow Z\to Y$ whose
$Y$-leg Galois-closure group fits into
\[
1\longrightarrow P\longrightarrow G\longrightarrow A
\longrightarrow1,\qquad
P\text{ a two-group},\quad A\text{ abelian of odd exponent dividing }n.
\tag{2}
\]
Neither order in (2) is bounded. The original legs need not be
Galois and the extension need not split.

In particular the exclusion applies when the exponent of $A$ divides
\[
3^a5^c7^d11^e13^f17^j,\qquad
0\le a\le2,\quad c,d,e,f,j\ge0,
\tag{3}
\]
with all five latter exponents unrestricted. It applies to both
selected partners. The covering degrees in this family are genuinely
unbounded in their ODD as well as their two-primary part.

More intrinsically, the first condition in (1) may be replaced by:
Frobenius on $H^1_{\rm et}(Y,\mathbf Z/n)$ has order prime to
nineteen. The second condition is a sufficient centralizer bound,
not a necessary condition for absence of a common cover.

## A nonabelian extension of the criterion

Suppose an actual odd-group Galois cover $C\to Y$ has a model,
with its entire deck group $A$ constant, over a field
$\mathbf F_{25^c}$ with $19\nmid c$. Write a nontrivial simple
factor of the semisimple group algebra as
$M_e(\mathbf F_{2^f})\subset\mathbf F_2[A]$. If EVERY such factor
satisfies
\[
18/\gcd(18,f)>2e,
\tag{4}
\]
then no pro-two cover of $C$ has the fixed $J(X)$ as a factor.
A constant-deck model of the required kind is automatic when
$A$ is a $\lambda$-group with
$\lambda\not\equiv0,\pm1\pmod {19}$, using the pro-primary model
lemma (and etale p-torsion if $\lambda=5$).

For example, (4) excludes a normal two-group kernel with odd
quotient the exponent-three Heisenberg group of order27, or its
products with elementary abelian three-groups, whenever those
groups occur as actual covers. Its absolute character degrees
are one and three, its nontrivial residue character fields have
degree two, and $9>6$.

All conclusions exclude specified monodromy classes only.
General mixed-prime groups, and both unrestricted common-cover
problems, remain open.

[Proof](../../../Proofs/jacobians/isogeny_sieves/two_by_abelian_frobenius_exclusion.md).
