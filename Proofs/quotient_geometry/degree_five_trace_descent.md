# Proof: degree-five trace and actual endpoint descent

[Statement](../../Theorems/quotient_geometry/degree_five_trace_descent.md).

## Low-degree divisors on the trigonal curve

For the cyclic map $x:X\to\mathbf P^1$, the integral functions
$1,y,y^2$ on the affine line and their orders at infinity give
\[
x_*\mathcal O_X=\mathcal O\oplus\mathcal O(-4)
                         \oplus\mathcal O(-7).
\tag{4}
\]
The [pencil separation theorem](../jacobians/torsion/reduced_divisor_rigidity.md)
therefore says that every function of degree at most six belongs to
$k(x)$. The degree-three extension has no intermediate field, so
the theorem applies to every function outside $k(x)$. Both the
splitting and the argument persist after any algebraically closed
extension of constants.

In particular, suppose an effective divisor $D$ of degree five has
$h^0(X,\mathcal O_X(D))\ge2$. A nonconstant section, viewed as a
rational function, has pole divisor bounded by $D$ and degree at most
five. It is a function of $x$. Its nonzero pole divisor therefore
contains a COMPLETE scheme fiber of $x$, of degree three.
There is at most one complete fiber contained in $D$, since two
different fibers would have degree six. Thus the complete cubic
fiber in $D$ is uniquely determined by $D$.

## The actual generic incidence divisor

Assume $h$ does not descend through $\pi$. Put $K=k(C)$ and
$L=k(T)$, with both endpoint fields embedded by the given maps.
Since $[L:K]=5$ is prime,
\[
K\,h^*k(X)=L.
\tag{5}
\]
The map $(\pi,h):T\to C\times X$ is consequently birational onto
its image. Over the generic point of $C$, that image is a separable
closed point of $X_K$ of degree five. Denote its associated divisor
by $D_K$. After passage to a separable closure of $K$, its five
points are DISTINCT and the absolute Galois group acts transitively
on them. The distinction of these points uses (5); it is not true
when $h$ already descends.

We claim that the geometric generic divisor has
\[
h^0(\mathcal O(D_K))=1.
\tag{6}
\]
Otherwise the preceding low-degree argument supplies its unique
complete cubic fiber. That fiber is preserved by every automorphism
of an algebraic closure of $K$ fixing $K$. Since $D_K$ is reduced,
the fiber consists of three distinct points, forming a proper
Galois-stable subset of its five points. This contradicts transitivity.
This proof also rules out a fiber defined only after a purely
inseparable extension: its three points are among the separable
points of $D_K$, so their $x$-value is separable over $K$.

## The Abel differential retains the trace

On a nonempty open subset of $C$, the fiber images under $h$ define
a morphism
\[
d:C\longrightarrow\operatorname{Sym}^5X,
\qquad c\longmapsto\sum_{t\in\pi^{-1}(c)}h(t).
\tag{7}
\]
They are distinct there. Over an etale neighborhood splitting
$\pi$, this is the unordered tuple of the five local maps $h_i$.
Its differential is their tuple $(dh_1,\ldots,dh_5)$. Each local
map is generically separable, because $h$ is separable and $\pi$
is etale. Hence $d$ has NONZERO differential at the generic point.
No division by five is involved in this calculation.

Let $a:\operatorname{Sym}^5X\to\operatorname{Pic}^5X$ be the Abel
map. Its tangent map at an effective divisor $D$ is the connecting
map in
\[
0\to\mathcal O_X\to\mathcal O_X(D)
\to\mathcal O_D(D)\to0.
\tag{8}
\]
Indeed $T_D\operatorname{Sym}^5X=H^0(\mathcal O_D(D))$, and the
first-order change of the associated line bundle is that connecting
class in $H^1(\mathcal O_X)$. Its kernel is
$H^0(\mathcal O_X(D))/k$. By (6), $da$ is injective at the
geometric generic divisor. Consequently
\[
d(a\circ d)\ne0.
\tag{9}
\]

After choosing an origin on $\operatorname{Pic}^5X$, its invariant
one-forms identify with $H^0(X,\omega_X)$. Locally the Abel image
in (7) is the sum of the five point Abel images. Differentiating
this sum gives, for every $\omega\in H^0(X,\omega_X)$,
\[
(a\circ d)^*\omega
 =\sum_{i=1}^5h_i^*\omega
 =\operatorname{Tr}_\pi(h^*\omega).
\tag{10}
\]
Invariant forms span the cotangent bundle of the Picard variety.
Equation (9) therefore proves that the trace in (10) is not
identically zero whenever $h$ does not descend. This proves the
forward implication in (1), including the case in which the
abstract norm homomorphism might have had an inseparable part.

Conversely, if $h=h_0\pi$, the trace of every pulled-back form is
$5h_0^*\omega=0$. The factorization of function fields extends to
a finite map of the smooth proper models. Separability and, when
applicable, etaleness follow from multiplicativity in the tower.

## The Jacobian and deck consequences

The homomorphism underlying the Abel map in (10) is
$\Phi=h_*\pi^*:J(C)\to J(X)$. If it were zero, (10) would vanish,
so $h=h_0\pi$. But then
\[
\Phi=[5]\circ(h_0)_*\ne0.
\tag{11}
\]
Here $(h_0)_*$ is surjective: composing it with pullback is
multiplication by $\deg h_0$ on $J(X)$. Multiplication by five is
a nonzero isogeny, even though its differential is zero. This proves
the asserted nonvanishing of the actual norm homomorphism.

For the additional norm exclusion let $\deg\pi=m\in\{2,4,5\}$
and assume $\operatorname{Hom}(J(C),J(X))=0$. Replace $T$ by the
joint normalization $T'$ of the two fields and write
$e=[k(T'):k(C)]$, $\delta=[k(T):k(T')]$, so $m=e\delta$.
The generic incidence divisor on $X$ is now a reduced transitive
degree-$e$ divisor $D$, and its norm from $T$ is $\delta D$.
The class of $\delta D$ is constant because the actual norm
homomorphism is zero. Multiplication by $\delta$ on the Picard
variety is finite, including when five divides $\delta$. Thus
the class of $D$ itself is constant: a connected reduced curve
cannot have nonconstant image in a finite fiber.

The family of divisors $D$ is nonconstant, since $h$ is nonconstant.
Therefore its fixed complete linear system has at least two sections.
Since $e\le5$, (4) and pencil separation supply a unique complete
cubic fiber in $D$. As above, transitivity makes this fiber all of
$D$, so $e=3$. This is impossible because $e$ divides one of
$2,4,5$. This proves the low-degree norm exclusion. This paragraph
uses CONSTANCY of the norm class from the zero homomorphism; the
earlier degree-five trace argument required the stronger tangent
analysis because its homomorphism need not have been zero.

Finally let $\sigma$ be an order-five deck transformation as in
the statement. Its action on $T$ is free, so the quotient
$\pi:T\to T/\langle\sigma\rangle$ is finite etale of degree five.
Pulling the trace back to $T$ gives
\[
\pi^*\operatorname{Tr}_\pi
 =1+\sigma+\cdots+\sigma^4=(\sigma-1)^4.
\tag{12}
\]
If $\sigma$ acts nontrivially on $E$, it acts nontrivially on the
pulled-back canonical space of some map in the specified family.
That map cannot factor through the quotient. Applying (1) and (12)
proves (2) and (3). For a representation of a cyclic group of order
five in characteristic five, (2) is exactly the occurrence of a
Jordan block of length five. It says nothing analogous about the
smaller three-dimensional Cartier-kernel spaces alone.

## The degree-three case forces actual cubic equivariance

Let $\deg\pi=3$ and $\operatorname{Hom}(J(C),J(X))=0$. The map
$h$ cannot descend through $\pi$: a descended nonconstant map
$C\to X$ would induce a surjective Jacobian norm. Prime degree
therefore makes the joint field $k(C)h^*k(X)$ equal to $k(T)$.
Its incidence divisor $D$ is reduced, transitive and of degree three.

The zero norm homomorphism makes the class of $D$ constant. The
divisors themselves move, so their fixed linear system has at least
two sections. The low-degree pencil statement above makes each
generic $D$ a COMPLETE fiber of $x$. Its $x$-value is invariant under
the absolute Galois group of $k(C)$, hence belongs to $k(C)$; the
points of $D$ are separable, so no purely inseparable issue occurs.
This proves $xh=a\pi$ in the actual source field. The rational map
$a$ extends to a finite separable map of smooth proper curves.

The extension $k(X)/k(x)$ is cyclic Galois of degree three. Its
compositum with $k(C)$, of degree three by joint minimality, is
$k(T)$. Thus the normalization of the actual fiber product is $T$
and $\pi$ is Galois. Restricting its deck generator to the embedded
$k(X)$ gives a generator of $\operatorname{Gal}(k(X)/k(x))$.
This proves the asserted equivariance of the ACTUAL map $h$.

If $h$ is etale, multiplicativity of local ramification indices in
$xh=a\pi$ gives $e_a(\pi(t))=e_x(h(t))$, because both $h$ and
$\pi$ are etale. The right side is three at the eleven branch
fibers and one elsewhere. This proves the complete uniform atlas
statement, including the absence of additional ramification.

For $N=[G,G]\simeq C_3$, the actual quotient $W/N$ is an abelian
etale cover of $Y$, so its Jacobian has no fixed-$J(X)$ factor by
the packet theorem. Apply this argument to $W\to W/N$ and the
original composed map $W\to X$. No compatibility with the remaining
deck transformations is asserted. In particular the resulting common
field $k(\mathbf P^1)$ for $X$ and $W/N$ is not assumed to descend
to a common field for the ORIGINAL endpoints $X,Y$.

## The original genus-two leg and its finite Galois closure

Let $W\to Y$ be the actual Galois closure of the given $Y$-leg,
with group $G$. It is a finite etale cover, and the original
second map supplies an actual finite etale map $W\to X$.
No simultaneous Galois source over both endpoints is presumed.

The [endomorphism-packet theorem](../jacobians/isogeny_sieves/etale_endomorphism_packets.md)
for the fixed $X$ says that no etale abelian cover of ANY genus-two
curve has $J(X)$ as an isogeny factor. Equivalently its Jacobian
has no nonzero homomorphism to $J(X)$, since $J(X)$ is simple.
If $G$ is abelian this already rules out the actual map $W\to X$.

Otherwise suppose $N=[G,G]$ has order two, four, or five. The
actual quotient $C=W/N$ is an etale abelian cover of $Y$, so
$\operatorname{Hom}(J(C),J(X))=0$. The finite etale map
$W\to C$ has degree $|N|$. The preceding low-degree exclusion
contradicts the actual map $W\to X$. The same proof works for any
normal $N$ of one of these orders once its quotient Jacobian is
known to have no $J(X)$ factor. The cited packet test supplies a
sufficient test involving only $G/N$.

For a concrete family not already eliminated by the small-character
bound, use the group $\mathsf H$ in (5) of the statement. Its
commutator is
\[
[(a,b,c),(a',b',c')]=(0,0,a\cdot b'-a'\cdot b),
\]
so both its center and its derived group are the last $C_4$.
Let $x_i=(e_i,0,0)$ and $y_i=(0,e_i,0)$. The four elements
$x_1,y_1,x_2,y_2^{-1}$ generate $\mathsf H$ and satisfy
\[
[x_1,y_1][x_2,y_2^{-1}]=1.
\tag{13}
\]
Thus $\mathsf H$ is a quotient of the genus-two surface group.
Its order is prime to five. Prime-to-five specialization of the
smooth proper curve fundamental group consequently realizes it as
an etale Galois-cover group of every genus-two curve over $k$;
this is [SGA1, ExposeX, Corollary3.9](https://grothendiecksga.com/read/sga1/en/X-3.html).
For $\gcd(m,20)=1$, replace $x_1$ in (13) by $(x_1,c_m)$.
The same relation holds and the four elements generate
$\mathsf H\times C_m$, since $(x_1,c_m)^4$ generates its $C_m$
factor. This gives actual covers of unbounded degree $1024m$.

The usual translation and character-multiplication operators on
functions on $(\mathbf Z/4)^2$ give a degree-sixteen representation
of $\mathsf H$ over $\mathbf Q(i)$. Its central generator acts
by $i$. The sixteen different character eigenspaces are permuted
transitively by the translations, proving irreducibility. The
representation is faithful and has Schur index one. Since the
fixed $K$ has maximal abelian subfield $\mathbf Q(\zeta_3)$,
its intersection with $\mathbf Q(i)$ is $\mathbf Q$; the old
packet inequality is just $9\le16$, which is satisfied. Tensoring
by a faithful character of the odd cyclic factor retains faithfulness
and this degree, with intersection degree at most two. These are
therefore genuine additional group exclusions, not groups ruled out
by the four-generator constraint alone.

By contrast, arbitrarily large extraspecial two-groups are not a
useful example of additional actual genus-two cases: they need too
many generators. The new theorem also excludes them abstractly,
but that fact is not counted as new geometric coverage here.
The proof supplies no comparable exclusion when the derived
subgroup has order eight, twenty-five, or arbitrary larger order;
its generic norm divisor then admits other pencils.

This boundary is concrete. For three distinct finite branch roots
$a,b,c$ of $P$, the function
\[
\frac{y}{(x-a)(x-b)(x-c)}
\tag{14}
\]
has poles of order two at the three corresponding branch points
and order one at infinity, so has degree SEVEN and does not belong
to $k(x)$. For two distinct branch roots $a,b$, the three functions
\[
1,\quad x,\quad\frac{y}{(x-a)(x-b)}
\tag{15}
\]
generate a base-point-free degree-eight linear series with divisor
$4O+2P_a+2P_b$. They recover $x,y$ and give a birational plane
model. Hence degree-eight norm divisors can genuinely move in a
plane; the preceding low-degree proof cannot be extended to that
degree merely by restating pencil separation.

## Why this does not close the alternating tower

At a degree-five intermediate quotient, the trace of the complete
canonical packet now detects whether the actual map is new. There
is no available reason for that trace to vanish. The composite
trace all the way to the genus-two endpoint is zero, but the first
nonzero trace can be killed at a later stage. Once a trace has been
taken, its resulting forms are not automatically the canonical
space of an actual map to $X$, so (1) cannot simply be iterated on
them. These are the specific limits of the new criterion.
