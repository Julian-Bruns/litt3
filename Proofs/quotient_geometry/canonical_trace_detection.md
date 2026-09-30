# Proof: interpolation, primitive differentials and coefficient rank

[Statement](../../Theorems/quotient_geometry/canonical_trace_detection.md).
The user-supplied Pro reply of 16 September 2026 proves the genus-two
Raynaud-section case and its exceptional lower cutoff. The argument
below identifies the entire generic kernel for any coefficient
bundle and any hyperbolic target. It separates interpolation from
Frobenius cohomology and removes ordinariness, the a-number and
representation hypotheses from the detection statements.

## 1. The actual evaluation map and its trace dual

Put \(F=k(X)\), \(E=k(Z)\), and \(W_r=H^0(Y,\omega_Y^r)\).
The actual pullbacks define
\[
\beta_r:W_r\otimes\mathcal O_X\longrightarrow
\omega_X^r\otimes\mathcal A.
\tag{1}
\]
At the geometric generic point of X, the n distinct f-fiber
points have distinct images on Y. Indeed two F-embeddings of E
which agree on k(Y) agree on \(F k(Y)=E\) by joint minimality.
After splitting this fiber, (1) is evaluation at its reduced
image divisor D, with nonzero factors supplied by the two
étale differential maps.

Since \(r\ge2\), \(H^1(Y,\omega_Y^r)=0\). The divisor sequence
and Serre duality show that the cokernel of this evaluation has
dimension exactly
\[
h^1(\omega_Y^r(-D))=h^0(\omega_Y^{1-r}(D))=c_r.
\tag{2}
\]
The field trace pairing on E is nondegenerate. In fact the
finite étale algebra \(\mathcal A\) is globally identified with
its dual by trace, even when p divides n. Dualize (1), tensor
by \(V\otimes\omega_X^r\), and use this identification. The
result is precisely \(\mathcal D_r\), not an arbitrary operator
with the same target. Its generic kernel is V tensored with
the c_r-dimensional trace-annihilator of the evaluation image.
This proves the claimed exact rank.

If \((r-1)(2h-2)>n\), the line in the last expression of (2)
has negative degree. The generic kernel is then zero. A kernel
inside a vector bundle on the integral curve X is torsion-free,
so a generically injective map is injective as a sheaf map.
Taking global sections preserves this injection.

For a fixed section write \(\xi_F=\sum_i v_i\otimes e_i\)
in a basis \(v_i\) of \(V_F\). Trace annihilation is equivalent
to every coefficient \(e_i\) belonging to this same annihilator.
Their span therefore has dimension \(\rho\le c_r\). A change
of basis does not change that span. This proves the refined test.

## 2. Fixed divisor class, the pencil obstruction and exact small defects

Suppose \(g_*f^*=0\). The divisors \(D_x=g_*f^*(x)\) all have
the same class Q, because their Abel differences are the images
of \([x-x_0]\) under this zero Jacobian homomorphism. Their
family is nonconstant and has no fixed point. Otherwise either
g(Z) would be finite, or the finite set \(g^{-1}(y)\) of a fixed
point y would meet every f-fiber. Thus Q is globally generated
and has at least two independent sections.

If \(h^0(Q)=2\), its complete system gives a morphism
\(q:Y\to\mathbf P^1\). The nonconstant family \(x\mapsto D_x\)
in this same pencil gives \(h:X\to\mathbf P^1\). Every point
z lies in the divisor assigned to f(z), so
\(q\circ g=h\circ f\). This supplies a nonconstant common
function and contradicts corelessness. Hence \(h^0(Q)\ge3\).
On a genus-two curve no line bundle of degree at most three has
three sections, by Riemann--Roch and Clifford (or the canonical
degree-two pencil). Therefore n is at least four.

The class Q is defined over k, so base extension in (2) gives
\(c_r=h^0(Y,\omega_Y^{1-r}Q)\). For a genus-two target and
\(r=r_1=\lfloor n/2\rfloor+1\), the line has degree zero
if n is even and degree one if n is odd. Its section dimension
is at most one. It is nonzero exactly for the two classes in
the statement. Nonzero \(\xi\) has \(\rho\ge1\), so trace
vanishing forces \(\rho=1\) and that special class.

More generally, the exact residual degree is \(n+2-2r\).
For degree at least three its section dimension is
\(n+1-2r\); for degree two it is two only for \(\omega_Y\)
and one otherwise; for degrees one and zero it is as just
described. Negative degree gives zero. These formulas make the
rank-sensitive cutoff explicit without new geometric assumptions.

## 3. The canonical differential coefficients generate the source field

This part only uses finite separability of both maps. Let D_X
be the derivation dual to the rational frame \(\theta\). Its
unique extension to E preserves every intermediate field E'
between F and E. In fact, for a separable minimal polynomial
\(P(T)=\sum c_iT^i\) of z over F,
\[
D_Xz=-\frac{\sum(D_Xc_i)z^i}{P'(z)}\in F(z).
\tag{3}
\]
Let E' be generated over F by the coefficients
\(g^*\nu/f^*\theta\) of all regular canonical differentials
on Y. If Y is nonhyperelliptic, their ratios generate k(Y)
by its canonical embedding. Thus joint minimality gives E'=E.

If Y is hyperelliptic, odd characteristic gives a model
\(v^2=P(u)\) and regular canonical forms
\(du/v,u\,du/v,\ldots,u^{h-1}du/v\). Write the first two
coefficients as a,b. Then \(u=b/a\) belongs to E'. Formula
(3) makes \(D_Xu\in E'\), and the actual identity
\(du/v=a\theta\) gives \(v=D_Xu/a\in E'\).
Again E' contains k(Y), hence is E. The derivative step is
essential for recovering the quadratic field beyond k(u).

Distinct F-embeddings of E cannot agree on every canonical
coefficient. Therefore the coefficients on which any two
embeddings agree form a proper k-linear subspace of
\(H^0(Y,\omega_Y)\). Avoiding the finitely many such subspaces
makes \(\alpha=g^*\nu/f^*\theta\) have n distinct conjugates,
so \(F(\alpha)=E\). No Cartier property of \(\nu\) is needed.
The odd-characteristic qualification in the hyperelliptic case
is real: in characteristic two the canonical differential
coefficients need not recover its Artin--Schreier generator.

## 4. Strict Krylov growth detects the actual section

For the nonzero coefficient span W define
\(W_j=W+\alpha W+\cdots+\alpha^jW\). If
\(W_j=W_{j-1}\), then \(W_{j-1}\) is stable under \(\alpha\),
hence under \(F[\alpha]=E\). A nonzero E-submodule of the field
E is E itself. Thus the dimensions grow strictly until they
reach n, and \(W_{n-\rho}=E\).

If W lies in a proper d-dimensional subspace U, it cannot keep
all its first \(d-\rho+1\) multiples in U: their span would
have dimension at least d+1. This proves the stated escape
bound for the particular tensor \(\xi_F\).

If all traces of \(\alpha^j\xi_F\) vanished through
\(j=n-\rho\), the trace functional would vanish on
\(W_{n-\rho}=E\). A finite separable field extension has a
nonzero trace functional, regardless of the value of
\(\operatorname{Tr}(1)=n\). This contradiction proves the
moment bound, with j positive when the initial trace is zero.
Multiplication by \((g^*\nu)^j\) restores the rational frame
and gives the asserted global regular weighted trace.

For an orthogonal summand with self-adjoint projector e, the two
off-diagonal blocks of multiplication by \(\alpha\) are adjoint
under trace. Both are nonzero when the summand is proper and
nonzero; consequently \(\operatorname{rank}[e,m_\alpha]\)
is twice their common positive rank. This recovers the returned
representation statement, but the section-level bounds above
are stronger and need no projector or semisimplicity.

## 5. Relation to the existing reconstruction arguments

The general interpolation method already appears in the earlier
[pluricanonical realization proof](../../routes/global/PLURICANONICAL_REALIZATIONS_JOINTLY_DETECT_ACTUAL_BIETALE_CYCLES.md).
The new formulation identifies the exact generic kernel for an
arbitrary coefficient bundle and makes the particular section's
tensor rank visible. The primitive canonical differential improves
the tricanonical primitive multiplier in the earlier
[moment reconstruction](../../routes/global/SEPARABLE_NORM_RECOVERY_FROM_PLURICANONICAL_TRACE_MOMENTS.md).
Those reconstruction conclusions and their degree dependence remain
valid; they are not new common-cover obstructions.

On the Frobenius-twisted span take \(V=B_X\) and use étale base
change \(f^*B_X=B_Z\). In genus two, the canonical ring has
generators s,t in degree one and their bracket w in degree three,
with \(w^2=R(s,t)\). Thus for \(r\ge3\) the finite detecting
list consists of \(s^{r-i}t^i\), \(0\le i\le r\), and
\(ws^{r-3-i}t^i\), \(0\le i\le r-3\), as in the
[canonical-pencil theorem](../../Theorems/quotient_geometry/genus_two_etale_pencils.md).

These are nonzero sections of positive canonical twists on X.
No map identifying them with mixed Frobenius obstruction
coefficients has been constructed. The uniform degree in this
proof is an interpolation degree, not a Hasse-jet order.
