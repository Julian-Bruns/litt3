# Ordinary genus-two curves have uniformly bounded effective orbifold quotients

**Status:** independently audited **PASS**, 2026-09-05; no breaking
objection. [Audit record](audits/ORDINARY_GENUS_TWO_UNIFORM_ORBIFOLD_DEGREE_BOUND_AUDIT.md).
**Argument:** `/root`.
**Verification and written proof:** `/root/canonical_trace_algebra`.

The inputs are the already audited rational-coarse local classification
and bounded-atlas finiteness theorem. This note does not re-audit their
entire proofs, construct a simultaneous Galois envelope for an arbitrary
correspondence, or address coreless common covers.

## Theorem

Let $k=\overline{\mathbf F}_5$, and let $C/k$ be any ordinary smooth
projective connected curve of genus two. Suppose

$$
 f:C\longrightarrow S
$$

is a representable finite étale atlas of a smooth proper connected
effective Deligne–Mumford orbifold curve. Then

$$
 \boxed{\deg(C/S)\le42000.}
$$

More precisely:

- If the coarse curve of $S$ is rational, $\deg(C/S)\le42000$.
- If its coarse genus is one, $\deg(C/S)\le4$.
- If its coarse genus is at least two, then $S\simeq C$ and $f$ is
  an isomorphism.

No Jacobian simplicity, special equation, automorphism-group condition,
or auxiliary cover-ordinarity hypothesis is required.

## Proof for rational coarse space

Choose a class of exact order eight in $J(C)[8]$.
Such classes exist because eight is prime to five and
$J(C)[8](k)\simeq(\mathbf Z/8\mathbf Z)^4$.
Kummer theory produces a connected cyclic étale cover

$$
 \pi:U\longrightarrow C,\qquad \deg\pi=8.
$$

For example, an exact-order-eight line bundle with a trivialization of
its eighth power gives the corresponding $\mu_8$-torsor.
Exact order guarantees connectedness, since over algebraically closed
$k$ its Kummer character has image of order eight.
Riemann–Hurwitz gives

$$
 2g(U)-2=8(2g(C)-2)=16,\qquad g(U)=9.
$$

The composite $U\to S$ is still representable finite étale.
The rational-coarse local classification audited in
[the all-degree audit](audits/ALL_DEGREE_COMMON_ORBIFOLD_BOUND_AND_LOGARITHMIC_TORSION_AUDIT.md)
uses only a genus-nine atlas and the existence of an ordinary atlas
of the same orbifold once rationality of the coarse curve is given.
Thus it applies to the two actual atlases $U\to S$ and $C\to S$.

In particular, neither ordinarity nor Jacobian simplicity is assumed
for $U$. No Hom-zero hypothesis is being applied to these two atlases:
$\operatorname{Hom}(J(U),J(C))$ is in fact nonzero, by norm.
The Hom-zero hypothesis in the earlier global application served only
to force rational coarse space, which is assumed in this part of the
present proof.

Put $n_U=\deg(U/S)$. The local classification gives

$$
 n_U\le336000
$$

unless there are precisely two stacky points with data

$$
 e_{\rm wild}=3tP,\qquad
 d_{\rm wild}=3tP-1+(3P+9),\qquad
 e_{\rm tame}=t,\qquad d_{\rm tame}=t-1,
$$

where $P=5^q$, $q\ge3$, and $t\in\{2,4,8\}$, subject to the stated
parity condition when $t=8$.

In such an exceptional row, let $E_C$ be the reduced wild fiber of
the original atlas $C\to S$. Uniformity of its local étale charts
and Riemann–Hurwitz give

$$
 \begin{aligned}
 2g(C)-2
 &=\deg(C/S)\left[
 -2+\frac{3tP-1+3P+9}{3tP}+\frac{t-1}{t}
 \right]\\
 &=\deg(C/S)\frac8{3tP}
 =8\deg E_C.
 \end{aligned}
$$

This would give $\deg E_C=1/4$, impossible for a reduced divisor.
Equivalently, the local inertia order $3tP$ could not divide
$\deg(C/S)$. Therefore no exceptional row occurs.

Finally, $n_U=8\deg(C/S)$, so

$$
 \deg(C/S)\le336000/8=42000.
$$

This argument does not need the logarithmic Kummer-cover obstruction:
integrality of the original genus-two wild fiber already suffices.

## Proof for positive coarse genus

Let $B$ be the coarse curve, write $b=g(B)$, and put
$n=\deg(C/S)$. Effectivity makes the generic inertia trivial, so $n$
also equals the degree of the coarse map $C\to B$.
Uniform local chart data give

$$
 2=n\left(2b-2+\sum_i\frac{d_i}{e_i}\right).              \tag{1}
$$

Every nontrivial inertia group has $e_i\ge2$, and its different satisfies

$$
 d_i=(e_i-1)+\sum_{j\ge1}(|G_j|-1)\ge e_i-1.
$$

Consequently every stacky point, including a wild one, contributes

$$
 \frac{d_i}{e_i}\ge1-\frac1{e_i}\ge\frac12.              \tag{2}
$$

If $b=1$, there must be a stacky point: otherwise the right side of
(1) is zero. Hence (2) implies $2\ge n/2$, or $n\le4$.

If $b\ge2$, equation (1) gives $n\le1$. Thus $n=1$, $b=2$, and every
different contribution vanishes. There are no nontrivial inertia
groups by (2), so $S=B$ is a smooth genus-two curve. A finite étale
map of degree one is an isomorphism. This finishes the theorem.

## Corollary: finitely many ordinary genus-two orbifold partners

Fix any smooth projective connected $X/k$ of genus $g_X\ge2$.
There are only finitely many isomorphism classes of ordinary genus-two
curves $Y/k$ admitting a common effective orbifold $S$ with actual
representable finite étale atlases from $X$ and $Y$.

Indeed, equality of the orbifold canonical degree gives

$$
 \deg(X/S)=(g_X-1)\deg(Y/S)\le42000(g_X-1).
$$

Apply the independently audited
[bounded-atlas finiteness theorem](BOUNDED_ATLAS_DEGREE_GIVES_FINITE_ORBIFOLD_PARTNERS.md)
with $B=42000(g_X-1)$ and target genus two.
That theorem takes a Galois closure only over the orbifold already
assumed to exist; wild inertia and non-Galois atlases are allowed.

The corollary places no restriction on $J(X)$ or the $p$-rank of $X$.
Its conclusion concerns common finite effective orbifolds only.
It does not assert finiteness of partners joined to $X$ by a coreless
bi-étale correspondence.
