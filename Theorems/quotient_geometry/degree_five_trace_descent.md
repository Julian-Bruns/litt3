# Low-degree norms and degree-five trace constrain actual endpoint maps

Version2,21September2026. Let $k$ be algebraically closed of
characteristic five. Let $X:y^3=P(x)$ be a smooth cyclic trigonal
curve with $P$ squarefree of degree ten. In particular this includes
the fixed genus-nine endpoint of both candidate pairs.

Let $\pi:T\to C$ be a connected finite etale cover of smooth proper
connected curves of degree FIVE, and let $h:T\to X$ be a nonconstant
separable map. The first map need not be Galois. Then
\[
\boxed{\quad
\operatorname{Tr}_\pi h^*H^0(X,\omega_X)=0
\quad\Longleftrightarrow\quad
h=h_0\circ\pi\text{ for a map }h_0:C\to X.
\quad}
\tag{1}
\]
The descended map is finite separable. If $h$ is etale, so is $h_0$.
This is the trace of ALL canonical forms, not just the three exact
forms. No simultaneous Galois closure, ordinary endpoint, clump,
Jacobian simplicity, or lift is assumed.

The actual norm homomorphism
$h_*\pi^*:J(C)\to J(X)$ is always nonzero. Consequently no such
degree-five cover of a curve $C$ with
$\operatorname{Hom}(J(C),J(X))=0$ admits a separable map to $X$.
This last consequence alone is weaker than the actual-map criterion.

There is also a low-degree norm exclusion. If $\pi:T\to C$ has
degree $m\in\{2,4,5\}$ and
$\operatorname{Hom}(J(C),J(X))=0$, then no nonconstant separable
map $T\to X$ exists. This uses the vanishing of the actual norm
homomorphism; for $m=2,4$ no zero-trace descent equivalence is asserted.

The omitted degree THREE has an exact geometric description. If
$\deg\pi=3$ and $\operatorname{Hom}(J(C),J(X))=0$, an actual
separable $h:T\to X$ forces a map $a:C\to\mathbf P^1$ with
\[
x\circ h=a\circ\pi.
\]
Moreover $T$ is the normalization of the ACTUAL fiber product
$C\times_{\mathbf P^1}X$, and $\pi$ is necessarily cyclic Galois.
Its generator acts under $h$ by one of the two generators of
$y\mapsto\zeta_3y$. If $h$ is etale, $a$ is unramified away from
the eleven branch points of $x$, and EVERY point above each of them
has ramification index exactly three.

## An unbounded family of actual cover groups is excluded

Now take the FIXED genus-nine $X$ of the candidate pairs and any
genus-two curve $Y$. Suppose an actual common bi-etale span exists,
and let $G$ be the Galois-closure group of its $Y$-leg. Then
\[
\boxed{|[G,G]|\notin\{1,2,4,5\}.}
\tag{4}
\]
More generally, $G$ has no normal subgroup $N$ of order two, four,
or five whose quotient cover has no $J(X)$ isogeny factor. A
sufficient representation-theoretic test for the latter condition
is the already established endomorphism-packet test for $G/N$.

If instead $[G,G]\simeq C_3$, the same argument supplies this
uniform eleven-fiber atlas on the abelian etale cover $W/[G,G]\to Y$,
where $W$ is the original leg's Galois closure. This is a reduction,
NOT an exclusion: a core after replacing an endpoint does not imply
a core of the original span.

The exclusion has NO degree bound. A concrete new family is
$G=\mathsf H\times C_m$, with $\gcd(m,20)=1$, where
\[
\mathsf H=(\mathbf Z/4)^2\times(\mathbf Z/4)^2\times\mathbf Z/4,
\quad(a,b,c)(a',b',c')=(a+a',b+b',c+c'+a\cdot b').
\tag{5}
\]
Here $|\mathsf H|=1024$, its derived subgroup has order four,
and it has a faithful irreducible complex representation of degree
sixteen. These groups ACTUALLY occur as etale Galois-cover groups of
every genus-two curve in characteristic five. The old character
inequality permits them, but none of these covers can admit a
separable map to the fixed $X$. Neither a Galois original leg nor
an ordinary $Y$ is needed for the general exclusion (4).

For an actual finite etale Galois cover $T\to C_0$, let $E$ be
the span in $H^0(T,\omega_T)$ of the pullbacks of the complete
canonical spaces under a deck-stable family of etale maps $T\to X$.
If an order-five deck element $\sigma$ acts nontrivially on $E$, then
\[
(\sigma-1)^4E\ne0.
\tag{2}
\]
Thus its action has a Jordan block of length five, or equivalently
a regular $k[C_5]$ direct summand. For any individual map $h$, the
stronger test is
\[
(1+\sigma+\cdots+\sigma^4)h^*H^0(X,\omega_X)=0
\quad\Longleftrightarrow\quad h\circ\sigma=h.
\tag{3}
\]

The proof uses the actual divisor of the five endpoint images and
the differential of its Abel map. It retains inseparable norm maps:
one must not replace vanishing differential by constancy of that map.
It gives a criterion for an existing trace to vanish; it does not
make the trace vanish along an alternating cover tower. In particular
the remaining Galois groups are not excluded, and neither unrestricted
common-cover candidate is settled.

[Proof](../../Proofs/quotient_geometry/degree_five_trace_descent.md).
