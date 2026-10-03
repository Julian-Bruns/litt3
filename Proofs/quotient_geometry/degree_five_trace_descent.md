# Proof: degree-five trace and actual endpoint descent

[Statement](../../Theorems/quotient_geometry/degree_five_trace_descent.md).
Version3 mathematical consolidation,2026-10-03. The general criterion
below subsumes the three old incidence arguments and adds degree six.
The original focused check covers Version2.

## 1. Transitive divisors and a separated pencil

Use the general criterion's notation. A reduced degree-e divisor D
over a field K, with separable points transitively permuted by its
absolute Galois group, has this dichotomy when \(e\le B\):
\[
h^0(\mathcal O_X(D))=1
\quad\text{or}\quad
D\text{ is a union of complete fibers of }x.                 \tag{4}
\]
Indeed a nonconstant section has degree at most e and therefore
belongs to \(\overline K(x)\). Its pole divisor contains a complete
scheme fiber of x. The union of ALL complete fibers contained in D
is nonempty and Galois stable, so transitivity makes it all of D.
Reducedness makes these fibers unramified and disjoint; thus \(d\mid e\).
Their x-values are separable over K because the points of D are
separable. No uniqueness of a contained fiber is needed.

For the given maps put \(K=k(C)\), \(L=k(T)\) and
\(L'=K\,h^*k(X)\). The joint normalization T' has degree
\(e=[L':K]\); its generic incidence divisor \(D_K\) on \(X_K\)
is reduced, separable and transitive of degree e. The full norm
divisor from T is \(\delta D_K\), with \(\delta=[L:L']\).
Both fields and the divisor come from the ACTUAL maps.

## 2. Prime characteristic degree and the Abel differential

Suppose \(\deg\pi=p=\operatorname{char}(k)\le B\) and \(d\nmid p\).
If h does not descend, prime degree gives \(L'=L\) and e=p.
The dichotomy (4) implies \(h^0(\mathcal O_X(D_K))=1\).

On a nonempty open subset where pi is etale, its fiber images give
\[
d_C:C\longrightarrow\operatorname{Sym}^pX,\qquad
c\longmapsto\sum_{t\in\pi^{-1}(c)}h(t).                       \tag{7}
\]
Over a splitting etale neighborhood these distinct images are the
local maps \(h_i\). Their differential tuple is nonzero because h
is separable. Thus \(d_C\) has nonzero generic differential.

For the Abel map \(a:\operatorname{Sym}^pX\to\operatorname{Pic}^pX\),
its differential is the connecting map of
\[
0\to\mathcal O_X\to\mathcal O_X(D)
\to\mathcal O_D(D)\to0.
\]
Its kernel is \(H^0(\mathcal O_X(D))/k\), hence is zero at the
generic incidence divisor. Therefore \(d(a\circ d_C)\ne0\).
Invariant forms on the Picard variety identify with the full
canonical space, and differentiating the sum of point Abel images gives
\[
(a\circ d_C)^*\omega
=\sum_i h_i^*\omega
=\operatorname{Tr}_\pi(h^*\omega).                          \tag{10}
\]
They span the Picard cotangent bundle, so this trace is nonzero.
This argument retains an inseparable part of the abstract norm;
it does not infer constancy from its differential.

Conversely, \(h=h_0\pi\) makes the trace \(p h_0^*\omega=0\).
The field factorization extends to smooth proper models. Separability,
and etaleness when both original maps are etale, follow in the tower.

The actual norm \(\Phi=h_*\pi^*\) cannot be zero: otherwise the
trace criterion gives h descended, and then
\[
\Phi=[p](h_0)_*\ne0.
\]
Indeed \((h_0)_*\) is surjective and multiplication by p is a nonzero
isogeny, although its differential vanishes.

## 3. The norm criterion and the actual fiber product

Now assume \(e\le B\) and the actual norm is zero. Its joint-source
norm is also zero: the original norm is its multiple by delta, and
a homomorphism of abelian varieties with finite image is zero.
The Abel class of \(D_K\) is therefore constant. The divisor moves
because h is nonconstant, so its fixed complete system has at least
two sections. By (4), it is a union of complete x-fibers.

Their e/d distinct x-values form a transitive separable orbit. Hence
\[
K'=K(x\circ h),\qquad [K':K]=e/d,\qquad [L':K']=d.
\]
Let C' be the smooth proper model of K'. The compositum
\(K'k(X)=L'\) has the FULL degree d over K', so it is the function
field of the actual fiber product \(C'\times_{\mathbf P^1}X\).
Its normalization is T'. A cyclic x makes \(T'\to C'\) cyclic.

If pi is etale, all intermediate covers in its field tower are
etale. If h is etale, so is \(h':T'\to X\). The full fiber product
is integral, and its normalization covers every pair of points over
the same target point. Multiplicativity of local indices in
\(xh'=a\pi'\) then gives \(e_x(P)=e_a(Q)\) for EVERY such pair.
Thus every fiber of x is uniform, and a has exactly its ramification
indices. All these are actual maps.

For the unrestricted pencil form, a base divisor of the fixed complete
incidence system would give a Galois-stable subset of the generic
transitive divisor. It cannot be the whole moving divisor, so it is
empty. When the system has two sections it gives a degree-e map u;
its reduced generic incidence member makes u separable. That member
is a complete fiber, whose value is K-rational by transitivity.
Thus \(uh'=a\pi_0\) for an actual map \(a:C\to\mathbf P^1\).
The joint degree e is the full degree of u, so the fiber product is
integral with normalization T'. The same local-index argument gives
uniformity when both original maps are etale.

## 4. Trigonal specialization and deck consequences

For \(x:X\to\mathbf P^1\) on \(y^3=P(x)\), the affine integral basis
\(1,y,y^2\) and its infinity orders give
\[
x_*\mathcal O_X=\mathcal O\oplus\mathcal O(-4)\oplus\mathcal O(-7).
\]
The [pencil separation theorem](../jacobians/torsion/reduced_divisor_rigidity.md)
therefore gives the criterion with d=3 and B=6, over all algebraically
closed constant extensions. The cubic extension has no intermediate
field. Prime degree five gives the trace theorem. A zero norm in
degree at most six forces e=3 or6, excluding degrees2,4,5 and giving
the stated C' and T' at degrees3 and6. The cyclic action is the actual
cubic action on X. When h is etale, x's eleven totally ramified
fibers give the complete uniform atlas for a.

For an order-five deck transformation sigma, the actual quotient
\(\pi:T\to T/\langle\sigma\rangle\) is etale of degree five, and
\[
\pi^*\operatorname{Tr}_\pi
=1+\sigma+\cdots+\sigma^4=(\sigma-1)^4.
\]
The trace criterion makes this operator nonzero on the canonical
space of a map h exactly when \(h\circ\sigma\ne h\). If sigma acts
nontrivially on the deck-stable space E in the statement, some
generating map does not descend. Thus \((\sigma-1)^4E\ne0\), giving
a full length-five Jordan block and a regular cyclic summand.
This says nothing analogous about just the three exact forms.

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

For $N=[G,G]\simeq C_3$, its quotient C is still an abelian etale
cover of Y with zero Hom to J(X). Section4 gives the full eleven-fiber
atlas on C. This is a reduction: the resulting common rational field
for X and C is not asserted to descend to the ORIGINAL endpoints X,Y.

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
