# Proof: saturated divisor relations and invariant Picard degree

[Statement](../../Theorems/shared_tensors/saturated_divisor_relations.md).
The invariant Picard finiteness and one-clump inputs are
[Krishnamoorthy, Lemma8.9 and Theorem9.6](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf).
They apply to coreless actual étale spans over any algebraically
closed field. Their use does not impose joint minimality, Hom-zero
or a characteristic restriction. The Picard assertion concerns a
finite group scheme; we use only its finite group of k-points.

## 1. Integral saturation of the actual fiber graph

Use the bipartite multigraph with vertices X(k) and Y(k) and with
one edge z joining f(z) to g(z). It is locally finite. The coefficient
of z in f*A-g*B is A(f(z))-B(g(z)), because the two ramification
indices are one.

Suppose rD=f*A-g*B, where all three divisors have finite support.
Modulo r the vertex coefficients of A and B agree along every edge,
so they are constant on each connected component. On an infinite
component that constant is zero, because the coefficients have finite
support. Only finitely many finite components can have a nonzero
constant: each contains a vertex in the finite support of A or B.
On each of these components subtract an integral lift of the constant
from every vertex coefficient. This preserves finite support and
changes no edge difference. All adjusted vertex coefficients are
divisible by r, and division now writes D as an integral edge
difference. Therefore D is torsion-free.

Divisors of endpoint functions vanish in D, so the map Q->D is
well-defined. Its kernel is R. The embedding Q/R->D proves saturation,
including the precise equality R intersect Q^r=R^r.

## 2. The invariant Picard exact sequence

For a triple in P choose rational sections s_X,s_Y and write
\[
\phi(f^*s_X)=q\,g^*s_Y.
\]
Then div(q)=f*div(s_X)-g*div(s_Y). Changing rational sections changes
q by endpoint functions, so its class gives a homomorphism P->R.
Conversely, a divisor relation for q defines the required isomorphism
f*O(A)~g*O(B). This proves surjectivity.

The kernel consists of triples with rational sections agreeing after
pullback, hence of invariant divisor pairs. If an invariant pair
(A,B) gives the trivial triple, write A=div(a), B=div(b). Their actual
pullbacks have equal divisors, so a/b is a nonzero constant in E.
Corelessness F intersect G=k then forces a,b constant. Thus A=B=0,
proving injectivity and the asserted exact sequence.

An isomorphism between two fixed pullback line bundles is unique up
to a scalar, and that scalar is absorbed by an automorphism of one
endpoint bundle. There is therefore no additional k* term in P or T.

Every invariant triple satisfies
\[
(\deg f)\deg L_X=(\deg g)\deg L_Y.
\]
Thus the kernel of its Y-degree map is T, finite by invariant Picard
finiteness. The canonical invariant triple has Y-degree h_Y>0.
Its image is consequently eZ with e>0 dividing h_Y. An extension of
Z by a finite abelian group splits as an abstract group, giving finite
generation and rank one. No choice of splitting is needed later.

## 3. Clumps and all torsion in Q

An invariant divisor pair gives a finitely supported integer function
on the vertex set that is constant on every connected component.
Its nonzero support must consist of finite components. A finite
component gives a clump of edges; conversely every clump is a union
of finite components. The one-clump theorem permits at most one
finite component. In its presence its reduced endpoint divisor pair
generates A; in its absence A=0.

With no clump, P=R, its torsion is T, and the normalized degree sends
the canonical class xi to h_Y/e. If xi=q^r in Q, saturation places q
in R; applying this homomorphism forces r to divide h_Y/e.

With a clump, its generator has Y-degree s=|g(S)|>0. Quotienting P
by that infinite-order element gives finite R, and
\[
0\longrightarrow T\longrightarrow R
\longrightarrow e\mathbf Z/s\mathbf Z\longrightarrow0.
\]
This proves |R|=(s/e)|T|. Finally Q/R is torsion-free, so every torsion
element of Q lies in R, giving the asserted complete torsion description.

## 4. Characteristic-primary torsion is logarithmic

Assume char(k)=p. For [c] in Q[p], choose c^p=ab with a in F*, b in G*.
Define
\[
[c]\longmapsto \alpha=d\log a=-d\log b.
\]
Replacing c by an endpoint product changes a,b by endpoint pth powers.
Another factorization of the same c^p changes them by reciprocal
constants, by corelessness. Thus alpha is well-defined. It is a
Cartier-fixed common rational form.

If alpha=0, the differential-kernel identity in the actual endpoint
fields gives a=a_0^p, b=b_0^p. Frobenius injectivity then gives
c=a_0b_0, so [c]=0. Conversely, for a Cartier-fixed common rational
form, the rational logarithmic Cartier criterion on F and G gives
a,b with alpha=dlog(a)=-dlog(b). Since dlog(ab)=0 in E, there is
c in E with c^p=ab. This constructs the inverse. All operations are
in the actual fields; no inseparable extension is introduced.

The rational logarithmic criterion is proved in Section8 below.
Section4 of the
[canonical-intersection proof](matched_section_rings.md) also proves
that every positive-weight shared rational
canonical tensor is regular: a pole would create a second clump.
The invariant-section space in weight one has k-dimension at most one.
Cartier preserves it. If it is zero, or Cartier is zero on it, the
fixed space is zero. Otherwise for a generator s one has C(s)=a s
with a nonzero; rescaling over algebraically closed k gives a fixed
generator. Its fixed multiples are exactly F_p. This proves the
dimension assertion and the criterion for nontrivial Q[p].

The torsion subgroup of Q is already finite. A finite abelian p-group
whose p-torsion has dimension at most one over F_p is cyclic.

If there is no shared one-form, Q[p]=0, so the finite torsion T or R
has order prime to p. In the no-clump case reduction of R=T plus Z
modulo p leaves exactly one F_p-line. If p does not divide h_Y,
its canonical coefficient h_Y/e is nonzero on that line. In the
clump case the finite group R has bijective pth-power map. Saturation
gives injectivity into Q/Q^p in both cases. Finally |R|=(s/e)|T| and
e dividing h_Y show p does not divide s in the clump case.

These deductions restrict the entire relation subgroup. They do not
eliminate its rank-one alternative or give a finite fiber component.

For the exact height assertion, without a clump there is no nonzero
shared one-form, so the finite group T has order prime to p. Choose
an abstract splitting R=T plus Z of the degree exact sequence. Its
canonical element has free coordinate h_Y/e. Multiplication by p^a
is an automorphism on T, and on Z its image is p^a Z. Saturation
therefore gives exactly the stated divisibility condition. With a
clump the canonical class has order equal to the primitive tensor
weight, prime to p by the canonical-intersection proof. All its
p-power roots already lie in that finite cyclic subgroup.

For the fixed-power corollary, the X-degree image of P likewise has
positive generator \(e_X\), and the canonical triple has the same
integer coordinate \(n=h_X/e_X=h_Y/e\) in the rank-one quotient.
If there is no clump and \(\xi\in Q^{p^a}\), the exact-height
calculation gives \(p^a\mid n\), hence \(p^a\) divides both \(h_X\)
and \(h_Y\). Under the stated degree condition this is impossible.
With a clump, \(\xi\) has \(p^a\)-roots for every \(a\).
The function factorization is precisely the definition of membership
in \(Q^{p^a}\), with all functions in their actual fields.

## 5. Retain the finite group scheme, not only its points

Set \(A_0=J(X)\times J(Y)\), let \(i=f^*-g^*:A_0\to J(Z)\),
and let B be its image abelian subvariety. Factor i as the isogeny
\(u:A_0\to B\), of kernel \(\mathscr T\), followed by the inclusion j.
Dualizing with the canonical principal polarizations gives the actual
norm map
\[
r=(\operatorname{Nm}_f,-\operatorname{Nm}_g)
=u^\vee j^\vee:J(Z)\longrightarrow A_0.
\]
The map \(j^\vee\) is a smooth quotient by the dual of J(Z)/B.
The isogeny \(u^\vee\) has kernel \(\mathscr T^D\). These are
the dual exact-sequence and dual-isogeny kernel statements in
[van der Geer--Moonen, Chapter7](https://www.math.ru.nl/~bmoonen/BookAV/DualAV2.pdf).
The cotangent map of r is the difference of the actual pullbacks
of regular differentials. Its kernel identifies with V. Since the
tangent map of \(j^\vee\) is surjective and \(u^\vee\) has equal
source and target dimensions,
\[
\dim V=\dim\operatorname{coker}(dr)
=\dim\ker(d u^\vee)=\dim\operatorname{Lie}(\mathscr T^D).
\tag{5.1}
\]
The finite group \(\mathscr T^D\) is étale exactly when its Lie
algebra is zero. Cartier duality therefore makes \(\mathscr T\)
of multiplicative type exactly when V=0. Over algebraically closed k
such a finite group is diagonalizable. This uses its full scheme
structure, not the abstract group T. The elementary duality convention
is also recalled in
[Chai--Oort, Section10.4](https://cims.nyu.edu/~tschinke/books/cmi-chai-oort/chai-oort-num.pdf#page=84).

## 6. Exact forms detect every nilpotent mixed direction

For any smooth proper connected C, the relative Frobenius sequence
\[
0\longrightarrow\mathcal O_{C^{(1)}}
\longrightarrow F_{C/k*}\mathcal O_C
\longrightarrow B_C\longrightarrow0
\]
identifies \(H^0(C^{(1)},B_C)\) with the kernel of Frobenius on
\(H^1(C,\mathcal O_C)\), with the domain scalar twist understood.
The differential identifies its sections with regular Cartier-killed
one-forms on C. Both identifications are natural under étale pullback.
Taking the kernels of the two-leg pullback maps consequently gives
an identification, with those same twists,
\[
\ker(F|K)\simeq\ker(C|V).
\tag{6.1}
\]
This is a kernel identity for the actual Frobenius sequences. It does
not identify a cotangent kernel with the dual of K by dimension alone.

We also need the one-leg fact in arbitrary cover degree. If
\(h:C'\to C\) is connected finite étale, then
\(B_{C'}\simeq h^{(1)*}B_C\). Faithfully flat pullback is injective
on global sections. By the natural connecting-map identification
above, the H1(O) pullback kernel meets ker(F_C) trivially.
It is Frobenius-stable, so its Frobenius is bijective. In particular
one-leg pullback is injective on the nilpotent Frobenius subspace.

Split K into its bijective and nilpotent Frobenius parts. By (6.1),
the latter is zero unless V is a line killed by Cartier. In that case
its Frobenius kernel has dimension one. The elementary Jordan-chain
argument, valid for a semilinear operator over a perfect field, makes
it one block of length ell. Its two projections to the endpoint
nilpotent subspaces are injective by the one-leg fact. This proves
the length bound and \(\dim\ker(F^a|K)=\min\{a,\ell\}\).
The identical connecting-map argument for the a-fold Frobenius
sequence proves the statement about the B_(a,C) section kernels.

When Frobenius on K is bijective, K lies in the direct sum of the
endpoint bijective parts. Their dimensions are the two p-ranks,
giving the asserted bound. An ordinary endpoint makes Cartier
injective on V by injectivity of differential pullback. No source
ordinariness, degree condition or Hom-zero assumption was used.

## 7. The three group-scheme types

The Frobenius on Picard tangent spaces is the differential of
Verschiebung. Thus its restriction to K is the differential of
\(V_{\mathscr T}:\mathscr T^{(1)}\to\mathscr T\).
If that differential is bijective, its restriction to the connected
part has kernel with zero Lie algebra. This kernel is finite étale,
but is a subgroup of a finite connected group scheme, so is trivial.
The connected source and target have the same length. Their
Verschiebung is therefore an isomorphism. Duality says precisely that
\(\mathscr T^0\) is of multiplicative type. Conversely multiplicative
groups have invertible Verschiebung. This proves the equivalence
between bijectivity on K and multiplicativity of the connected part.

Over the perfect field k, the reduced subgroup splits the connected-
étale sequence of a finite commutative group scheme. In the case
\(\dim V=1\) and C nonzero, (6.1) therefore writes the p-primary
part as a multiplicative factor times a constant p-group A_p.
Equation (5.1) says that the Lie algebra of its dual has dimension
one. The dual of the multiplicative factor is étale, while
\(\dim\operatorname{Lie}D(A_p)=\dim_{\mathbf F_p}(A_p/pA_p)\).
Consequently A_p is nontrivial and cyclic, as asserted.

If C kills V, Section4 gives Q[p]=0. Since T injects into R and
hence into Q, T has no nonzero p-torsion points. Thus the entire
finite group scheme \(\mathscr T_p\) is connected. Its connected
part cannot be multiplicative, by (6.1). The usual decomposition of
a finite commutative group over a perfect field into étale,
multiplicative and local-local factors therefore gives a nonzero
local-local factor. No classification of its order or higher
Dieudonné module is asserted by the single Jordan-block statement.

This completes the scheme-theoretic refinement. In the no-clump case
it gives a multiplicative kernel, not a missing positive-degree
invariant divisor. In particular it cannot replace the canonical-root
existence assertion.

## 8. Differential description of the first-power condition

Write \(h=f^*\theta_X/g^*\theta_Y\). A factorization
\(h=c^p v/u\) immediately gives
\(d\log h=d\log v-d\log u\). Conversely, suppose
\(d\log h=\beta-\alpha\) for rational endpoint forms.
Cartier fixes \(d\log h\) and commutes with the two actual étale
pullbacks. Hence
\[
\delta=C\alpha-\alpha=C\beta-\beta
\]
is a shared rational form. It belongs to the at-most-one-dimensional
space \(V\), and is regular by the canonical-intersection proof.

The additive map \(C-1:V\to V\) is surjective. This is immediate
when \(V=0\) or \(C=0\). Otherwise write \(V=k s\), \(C(s)=a s\)
with \(a\ne0\). The scalar equation
\(a t^{1/p}-t=b\) is equivalent to
\(t^p-a^p t=-b^p\), which has a solution over algebraically closed
\(k\). Choose \(\gamma\in V\) with \(C\gamma-\gamma=-\delta\).
Adding \(\gamma\) to both \(\alpha\) and \(\beta\) preserves their
difference and makes each Cartier-fixed. The rational logarithmic
criterion then gives \(u\in F^*,v\in G^*\) with
\(\alpha=d\log u,\beta=d\log v\). Consequently
\(d\log(hu/v)=0\), so \(hu/v=c^p\) in \(E\).

For completeness, choose a separating variable \(z\) in an endpoint
field \(F_0\), write \(D=d/dz\) and \(\alpha=A\,dz\).
The condition \(C\alpha=\alpha\) is
\(D^{p-1}A=-A^p\). As \(D^p=0\), the differential-operator
identity gives
\((D-A)^p=-(D^{p-1}A+A^p)=0\) on the
\(p\)-dimensional \(F_0^p\)-space \(F_0\).
A nonzero vector \(u\) in its kernel satisfies
\(du/u=\alpha\). Thus the logarithm is obtained in the endpoint
field itself.

Any two additive decompositions differ by the same form in \(V\)
on the two endpoints. Two logarithmic decompositions differ by
\(V^{C=1}\). If \(C=0\), this group is zero; otherwise rescale a
generator to be Cartier-fixed and its fixed multiples are exactly
\(\mathbf F_p\). When \(A_1=0\), \(V=0\), so both decompositions are
unique. The injection \(Q[p]\hookrightarrow V^{C=1}\) proved in
Section4 also gives \(Q[p]=0\) in that case.
