# Unbounded odd abelian quotients above a two-group are excluded

Version2,3 October2026. Let $X/\mathbf F_{25}$ be the fixed
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

## Even normal closures

Let D->Y be an actual finite etale Galois cover, with its full
deck group Q constant over F_(25^c), where 19 does not divide c.
Suppose its rational group algebra has decomposition
\[
\mathbf Q_2[Q]\simeq\mathbf Q_2\times
\prod_i M_{e_i}(E_i),
\]
where the nontrivial factors are split matrix algebras over
finite extensions E_i/Q2. Let f_i be their residue degrees.
If every pair (e_i,f_i) satisfies (4), then no cover of ANY
quotient D/H with two-group Galois closure has J(X) as a factor.

This permits even Q: no semisimplicity modulo two or integral
H-projector is assumed. The split-algebra and constant-deck
hypotheses are explicit inputs. In particular Q=C11 and Q=D22
(the dihedral group of order22) satisfy the criterion; their
nontrivial blocks have (e,f)=(1,10), or (1,1) and (2,5).

All conclusions exclude specified monodromy classes only.
General mixed-prime groups, and both unrestricted common-cover
problems, remain open.

[Proof](../../../Proofs/jacobians/isogeny_sieves/two_by_abelian_frobenius_exclusion.md).
