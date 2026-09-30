# Proof: two good models and a degree prime to the residue characteristic

[Statement](../../../Theorems/quotient_geometry/tame_covers/auxiliary_atlas_good_reduction.md).
This is local continuation of the returned prime-to-five-monodromy
specialization argument. It replaces a condition on the original
monodromy by an actual auxiliary atlas and retains both maps on
the fiber product. Author proof; no independent whole-proof audit.

## An elementary map-extension lemma

Let $D,H$ have smooth proper models over $R$, with $g(H)\ge1$,
and let $u:D_K\to H_K$ be finite etale of degree $m$ prime to $p$.
After finite extension choose a section of $\mathscr H$ and embed
it into its relative Jacobian. The latter is an abelian scheme,
hence is its generic fiber's Neron model. Its mapping property
extends the composite from the smooth scheme $\mathscr D$.
The image lies in $\mathscr H$: its defining ideal vanishes on the
dense generic fiber and $\mathscr D$ is flat. Thus $u$ extends.
This also follows directly from the Neron-model theorem for
[proper curves of positive genus](https://arxiv.org/abs/1312.4822).

Pullback of an ample line bundle on $\mathscr H$ has constant degree
on the fibers of $\mathscr D$. The special map is therefore
nonconstant and has the SAME degree $m$. It is separable, because
its inseparable degree is a power of $p$ dividing $m$.
Riemann--Hurwitz and constancy of both genera give
\[
2g(D)-2=m(2g(H)-2)
\]
on both fibers. The special different is zero, so the special map
is etale. The extended proper quasi-finite map is finite; the two
smooth fibers and their etaleness give a finite etale map over $R$.

The assumption on $m$ is essential here. Good reduction of both
curves alone does not prevent an inseparable special-fiber map.

## Pull back the auxiliary atlas

Take the ACTUAL generic fiber product
\[
D=C\times_{\mathscr S_K}\mathscr H_K.
\]
The projection $D\to C$ is a finite etale $G$-torsor. Prime-to-$p$
specialization for the good proper curve $C$ extends it after finite
base extension to a finite etale $G$-torsor
$\mathscr D\to\mathscr C$. In particular every connected component
of $\mathscr D$ has good reduction. This is the prime-to-$p$
essential-surjectivity statement in
[SGA1 X3.8](https://grothendiecksga.com/read/sga1/en/X.html), also
[Stacks, Theorem58.30.3](https://stacks.math.columbia.edu/tag/0C0R).

The other generic projection $D\to\mathscr H_K$ is finite etale
of degree $n$. The group $G$ permutes the connected components of
$D$ transitively. If there are $q$ components, each projection to
$\mathscr H_K$ has degree $n/q$; this is an integer dividing $n$,
hence prime to $p$. Each is surjective, being a nonempty finite
etale map of proper connected curves.

The preceding extension lemma now extends every component map to
an etale $\mathscr D\to\mathscr H$. Its $G$-equivariance extends
from the generic fiber by separatedness and flatness. Descent of
this map along the actual $G$-torsor gives
\[
\mathscr C\longrightarrow[\mathscr H/G]=\mathscr S.
\]
After base change by $\mathscr H$ it is precisely the just-proved
finite etale map. Representability, finiteness and etaleness descend.
It extends the specified original map, not a replacement atlas.

## The two explicit auxiliary triangle covers

In $\mathrm{SL}_2(\mathbf F_3)$ take
\[
A=\begin{pmatrix}1&1\\0&1\end{pmatrix},\qquad
B=\begin{pmatrix}1&0\\1&1\end{pmatrix}.
\]
They generate the group of order24, have orders three, and $AB$
has order four. The regular permutation action therefore gives a
connected Galois three-point cover with inertia $(3,3,4)$ and genus
two. Its group order is prime to five.

In $\mathrm{PSL}_2(\mathbf F_7)$ use the images of
\[
A=\begin{pmatrix}0&-1\\1&0\end{pmatrix},\qquad
B=\begin{pmatrix}0&-1\\1&1\end{pmatrix}.
\]
Their orders are two and three, and $AB$ is projectively a nontrivial
unipotent of order seven. They generate the group of order168.
The regular action gives a Galois cover of profile $(2,3,7)$ and
genus three.

Riemann existence gives these covers over $\overline{\mathbf Q}$.
Prime-to-five tame specialization for the marked line
$(\mathbf P^1;0,1,\infty)$ extends each as a tame Galois cover
with smooth source and unchanged indices after finite extension.
This is the marked-curve version of the prime-to-$p$ specialization
theorem (SGA1, ExposeXIII, Corollaire2.12). Equivalently the resulting
root orbifold has the required finite etale $G$-atlas.
The small [matrix certificate](../../../scripts/orbifolds/auxiliary_triangle_groups.py)
checks the two groups and exact inertia orders.

The degrees of genus-two uniform atlases of these profiles are24
and84, respectively. Both are prime to five. If their source has
good reduction $Y$, the theorem thus produces the SAME complete
uniform tame profile on $Y$, contrary to
[the backup tame-atlas theorem](../../../Theorems/quotient_geometry/endpoint_exclusions/backup_tame_uniform_atlases.md).
This does not assume that an arbitrary cover of degree prime to
five has prime-to-five Galois closure.
