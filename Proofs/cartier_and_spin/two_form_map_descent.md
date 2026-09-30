# Proof: one regular form descends the actual map

[Statement](../../Theorems/cartier_and_spin/two_form_map_descent.md).
This integrates the returned Pro argument of21September2026 and adds
the precise projective deck kernel. The arithmetic is independently
reproducible; no covering degree is assumed prime to five.

Version3 adds the one-form argument below, with independent
[global](../../Research/audits/ONE_FORM_GLOBAL_INDEPENDENT_2026_09_22.md) and
[local](../../Research/audits/ONE_FORM_LOCAL_INDEPENDENT_2026_09_22.md) audits.
The intrinsic two-form reconstruction is retained separately.

## One form, including the exact case

Suppose h^*omega=pi^*eta is nonzero. The
[fixed-X orbifold theorem](../quotient_geometry/local_actions/fixed_x_orbifold_bound.md)
excludes a coreless span with a shared regular one-form. Use its
actual cored Galois refinement and common effective orbifold S.
The shared form is invariant under both deck groups, hence descends
to a rational one-form on the coarse curve of S, regular on its atlases.

The [one-form quotient theorem](../quotient_geometry/local_actions/fixed_x_one_form_atlases.md)
now says the X-atlas X->S has degree one. Thus S=X, and the other
atlas gives the actual map h0:W->X through which h factors. Equivalently,
the ACTUAL embedded X-field is contained in the W-field. The maps
are finite etale throughout; no simultaneous Galois cover was presumed
until the cored property had been established.

For two X-maps on the same source, a shared nonzero form therefore
gives equality of their embedded fields. The intervening automorphism
of X is a cubic deck automorphism. None of its nonidentity elements
fixes a nonzero regular form, since the two character sectors have
eigenvalues zeta3 and zeta3^2.

For the field-saturated spaces, a nonzero jump smaller than3,6,or9
would make each new generating space meet the old one nontrivially.
The map then descends, so its ENTIRE generating space was already
present. This contradiction proves the new minimum jumps.

At least two distinct X-fields occur in the first Y-Galois orbit:
otherwise the X-field is G-stable and its finite-group invariant
subfield gives a nonconstant core. Their three-, six-, and nine-spaces
are now disjoint, proving(3). If a deck element has deviation rank
smaller than the corresponding original space, it fixes a nonzero
member of every conjugate original space. The preceding paragraph
makes it fix every X-field pointwise. Joint minimality then makes
it the identity on k(W)=k(Y)(all conjugate X-fields). This proves(4)
and the all-or-zero invariant intersections. The stronger ordinary
projective faithfulness and exact projective kernel below are unchanged.

## The intrinsic operation and the exact calculation

For $\omega=dA$ and $\eta$ exact, changing $A$ by $b^5$ changes
$C(A\eta)$ by $bC(\eta)=0$. Local regular primitives show regularity.
The identity $C(d(AB))=0$ gives alternation. These arguments commute
with etale pullback and retain the inverse-Frobenius coefficient action.

Let $\mathscr C$ extract polynomial coefficients in degrees $5m+4$
and take their fifth roots. Choose $Q_i$ with $Q_i'=h_iP$, setting
all its coefficients in degrees divisible by five to zero. Then
\[
d(Q_i/y^5)=\omega_i,\quad
b_{ij}=\mathscr C(Q_i h_jP),\quad t_{ij}=\mathscr C(b_{ij}P).
\]
The three $b_{ij}$ in the ordered pairs01,02,12 have ascending rows
\[
(4,16,3,18,21,0),\quad(10,13,0,10,6,0),\quad(15,3,3,18,18,4).
\]
Applying Cartier gives the matrix in the statement, of determinant
$[13]$. Thus $\tau$ maps $\bigwedge^2V$ semilinearly isomorphically
onto $\langle dx/y,x\,dx/y,x^2dx/y\rangle$.
In particular $\tau(\omega,\eta)\ne0$ for every independent pair.
The determinant obtained by stacking the three $h_i$ with these
three $b_{ij}$ is $[7]\ne0$; together these give the full six-dimensional
$dx/y^2$ sector. This last calculation is consistent with the
[already audited Petri calculation](cartier_petri_excess_one.md).

The [standalone certificate](../../scripts/arithmetic/cartier_two_form_certificate.py)
also checks squarefreeness of $P$, the primitives, every alternating
identity, and $\gcd(h_0,h_1)=\gcd(h_0,h_2)=1$.
It was rerun successfully; its output is byte-for-byte equal to the
supplied output. Original evidence, verification log and source hash are
retained [outside the workspace](../../../litt3-computation-data/cartier_two_form_20260921/provenance.json).
This finite calculation certifies identities, not existence of a span.

## Reconstruction of the embedded field

Write
\[
\omega=h(x)dx/y^2,\quad\eta=\ell(x)dx/y^2,\quad
\tau(\omega,\eta)=c(x)dx/y,\qquad c\ne0.
\]
Set $r=\ell/h$, $s=cy/h$, and $D=k(r,s)\subset k(X)$.
The [generic rank-three evaluation](cartier_kernel_generated_subbundle.md)
implies that two independent members of $V$ cannot be proportional over
$k(X)^5$. Hence $dr\ne0$ and $k(X)/D$ is separable. The rational
function $r$ has degree at most five as a map from the $x$-line.

The cubic deck automorphism $\gamma:y\mapsto\zeta_3y$ preserves
$D$, fixes $r$, and sends $s$ to $\zeta_3s$. Thus it acts faithfully
on $D$. Put $L=D^{\langle\gamma\rangle}=D\cap k(x)$.
Since $k(x)D=k(X)$, the tower degrees give
\[
[k(X):D]=[k(x):L]=d\le[k(x):k(r)]\le5.
\]
In particular $k(X)/k(x)$ is the actual compositum, hence the base
change, of the cyclic cubic extension $D/L$.

If the smooth curve of $D$ were rational, its cyclic tame cubic
quotient would be rational and would have exactly two branch points,
by Riemann--Hurwitz. After base change along the degree-$d$ map
with function fields $k(x)/L$, ramification can occur only over these
two points. There would be at most $2d\le10$ branch points on the
$x$-line. In fact $y^3=P(x)$ has eleven: the ten simple roots and
infinity. This excludes the rational case.

Now the nonconstant separable map $X\to C_D$ has positive-genus
target. Its Jacobian pullback has finite kernel since norm composed
with pullback is multiplication by $d$; this remains true if $5\mid d$.
Geometric simplicity of $J(X)$ therefore gives $g(C_D)=9$.
Riemann--Hurwitz reads $16=16d+\deg\operatorname{Diff}$ and forces
$d=1$. This proves the field identity for every independent pair.

## The exact projective kernel and ordinary projective faithfulness

The one-form argument above already proves faithfulness and the minimum
ranks in(4). Suppose sigma acts on E_ex by a scalar lambda. It preserves
every conjugate three-space. Two-form reconstruction(2) makes it preserve
every associated X-field. Its induced automorphism belongs to Aut(X)=C3,
so lambda has order dividing three. Faithfulness makes the projective
kernel a central cyclic subgroup of order dividing three. This conclusion
uses actual deck actions on global forms, not infinitesimal fiber actions.

Every conjugate U_X is Cartier-bijective, so its sum E_ord is too. The
Cartier-fixed vectors give an F5-form whose scalar extension is E_ord;
all deck actions commute with Cartier and preserve this form. A scalar
lambda acting on E_ord therefore lies in F5*. It preserves each original
six-space, hence each X-field by(1). Its induced automorphism of X belongs
to C3, so lambda has order dividing both three and four. It is one, and
faithfulness makes sigma the identity.

For clarity, the established arithmetic Aut(X)=C3 follows from the
[CM endomorphism field](../jacobians/isogeny_sieves/etale_endomorphism_packets.md):
its roots of unity are mu6 and the automorphism action on J(X) is faithful.
An involution acting by minus one would make X hyperelliptic, whereas X
is trigonal of genus nine. The evident cubic group therefore exhausts
Aut(X). Its two characters on the regular nine-space are both nontrivial,
as used in the fixed-vector argument above.

## Comparison with the rational Jacobian information

For clarity, the p-rank jump is not a new numerical sieve.
Let B=h^*J(X) and A=pi^*J(W) inside J(T). If B is contained
in A, the Rosati projector e_pi=(deg pi)^(-1)pi^*pi_* is the
identity on B. For u=pi_*h^*, this gives
\[
u^\dagger u=(\deg\pi)(\deg h)\,\mathrm{id}_{J(X)}.
\]
The [actual Rosati factorization theorem](../jacobians/isogeny_sieves/etale_rosati_factorization.md)
already descends h in this case. Otherwise simplicity of J(X)
makes B intersect A in a finite subgroup, so A+B is isogenous
to J(W) times J(X). It follows that g(T)>=g(W)+9 and
f(T)>=f(W)+6. Rational isogeny decompositions, however, do not
by themselves imply the modulo-five intersection or faithful
ordinary differential representation established above.

The source genus, p-rank and ordinary deck span can all increase
without bound. Neither their jump restrictions nor the absence
of low-rank deck deviations proves stabilization of the actual
fields. The common-cover problem remains open.
