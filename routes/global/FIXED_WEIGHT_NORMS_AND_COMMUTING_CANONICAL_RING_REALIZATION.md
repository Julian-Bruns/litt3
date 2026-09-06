# Fixed-weight norms and a commuting canonical-ring realization

Date: 2026-09-05. Author: root. Status: independently audited PASS.
Auditor: /root/fixed_weight_norm_encoding_check, GPT-6 Astra medium,
2026-09-05. No repairs required.
[Audit record](audits/FIXED_WEIGHT_NORMS_AND_COMMUTING_CANONICAL_RING_REALIZATION_AUDIT_2026_09_05.md).
These are reconstruction and packaging results, not a
nonexistence theorem for common covers. No historical novelty is claimed
for the norm or spectral constructions.

Let \(k\) be algebraically closed, of arbitrary characteristic. Curves
are smooth, projective, connected, and have genus at least two. A
joint-minimal bi-etale correspondence \(\Gamma\) from \(X\) to \(Y\) is
the normalization \(C\) of its integral image in \(X\times Y\), with both
projections \(f:C\to X\), \(g:C\to Y\) finite etale. Write \(b=\deg g\).
The two differentials supply the canonical isomorphism
\[
 \kappa:f^*\omega_X\xrightarrow{\sim}g^*\omega_Y.
\]
The linear operators \(T_m=\operatorname{Tr}_g\kappa^m f^*\) are defined
in [the pluricanonical trace note](PLURICANONICAL_REALIZATIONS_JOINTLY_DETECT_ACTUAL_BIETALE_CYCLES.md).

## 1. Norms retain the branches which traces can cancel

For \(s\in H^0(X,\omega_X^m)\), define
\[
 \mathcal N_{\Gamma,m}(s)=
   \operatorname{Nm}_g\bigl(\kappa^m f^*s\bigr)
       \in H^0(Y,\omega_Y^{mb}).                         \tag{1}
\]
This is a homogeneous polynomial map of degree \(b\), not a linear map.
More precisely it is the polynomial law obtained by applying the
finite-locally-free norm to the universal section. It can therefore be
recorded as an element
\[
 \operatorname{Sym}^b H^0(X,\omega_X^m)^\vee
              \otimes H^0(Y,\omega_Y^{mb}).              \tag{2}
\]
Here \(\operatorname{Sym}^b(V^\vee)\) denotes polynomial functions on
the vector space \(V\), not a multilinear polarization obtained by
dividing by \(b!\).

For completeness, locally trivialize \(\omega_Y^m\). The section in
(1) is then an element of \(g_*\mathcal O_C\), whose multiplication
matrix has entries linear in the coordinates of \(s\). Its determinant
has degree \(b\). Changing the trivialization scales the determinant
by the \(b\)-th power of the transition function, so the local
determinants glue to the indicated target line bundle. This construction
also proves compatibility with arbitrary scalar extension.

The general determinant norm and norm on sections are the standard
constructions in [Stacks, Norms](https://stacks.math.columbia.edu/tag/0BCX),
especially [Tag 0BD2](https://stacks.math.columbia.edu/tag/0BD2).
No averaging or division by a cover degree is used.

## 2. A faithful nonlinear encoding in input weight three

**Theorem 1.** The polynomial \(\mathcal N_{\Gamma,3}\) determines the
joint-minimal correspondence \(\Gamma\). More generally, for an effective
integral cycle \(\alpha=\sum_i n_i\Gamma_i\), its product norm
\[
 \mathcal N_{\alpha,3}=\prod_i\mathcal N_{\Gamma_i,3}^{\,n_i},
 \qquad
 B=\sum_i n_i\deg(C_i/Y),                               \tag{3}
\]
viewed as a homogeneous polynomial of degree \(B\) with values in
\(H^0(Y,\omega_Y^{3B})\), determines \(\alpha\), including its
ordinary integer multiplicities. This remains true if the
characteristic divides \(B\) or some \(n_i\).

**Proof.** The line bundle \(\omega_X^3\) is very ample. One elementary
verification is that
\(\deg\omega_X^3=6g(X)-6\ge 2g(X)+1\). A line bundle of degree at
least \(2g+1\) separates every length-two subscheme by the divisor
exact sequence and Serre duality, and is consequently very ample.

Let \(\Omega\) be an algebraic closure of \(k(Y)\), and choose a nonzero
basis of the geometric generic fiber of \(\omega_Y^3\). Splitting the
etale fiber of \(g\) turns the polynomial (1) into
\[
 \mathcal N_{\Gamma,3}(s)(y)
      =\prod_{c\in C_y}\ell_c(s),                       \tag{4}
\]
where \(\ell_c\) is a nonzero linear functional on
\(H^0(X,\omega_X^3)\otimes_k\Omega\). Its projective class is exactly
the image of \(f(c)\) in the tricanonical embedding of \(X_\Omega\).
The nonzero scalar multiplying evaluation is supplied by \(\kappa^3\).

The points \(f(c)\) for \(c\in C_y\) are distinct: a normalization is
an isomorphism away from finitely many points of its image, and the
generic point \(y\) avoids their projections. For different integral
images \(\Gamma_i,\Gamma_j\), their generic fibers are disjoint, since
the images meet in only finitely many points. Thus the linear factors
in (4), across distinct basis images as well, are pairwise
nonproportional.

Unique factorization in the polynomial ring over \(\Omega\) recovers
all projective classes \([\ell_c]\), and very ampleness recovers all
the points \(f(c)\). In (3), the multiplicity of each linear factor
is the integer \(n_i\), read as a factorization exponent, not as an
element of \(k\). These data are exactly the geometric generic fiber
cycle in \(X_\Omega\). A cycle on \(X\times Y\) whose components
dominate \(Y\) is determined by this generic fiber, by taking closures.
This proves both assertions. \(\square\)

The proof actually requires only a very ample input power
\(\omega_X^m\); weight three is a uniform choice for all the curves
under discussion. Equality of the generic polynomial up to a nonzero
scalar already suffices to reconstruct the cycle. The canonical norm
records also that scalar.

In particular a refinement \(W\to C\) of degree \(e\) has norm
\(\mathcal N_{W,m}=\mathcal N_{\Gamma,m}^{e}\). When \(p\mid e\),
the linear trace realization of that integral cycle may vanish,
but the norm polynomial still records exponent \(e\).

## 3. Operations on actual correspondences

**Proposition 2.** Norms turn disjoint addition of effective cycles into
multiplication, and retain composition on all input weights:
for composable bi-etale spans \(\Gamma:X\to Y\) and
\(\Lambda:Y\to Z\), of right degrees \(b,d\), respectively,
\[
 \mathcal N_{\Lambda\circ\Gamma,m}(s)
     =\mathcal N_{\Lambda,mb}
          \bigl(\mathcal N_{\Gamma,m}(s)\bigr).            \tag{5}
\]
The same statement holds for effective cycles, with total degrees.

**Proof.** After an etale base change splitting the covers, the
left side is a product over all pairs of successive sheets. The
right side takes the same product in two stages. The differential
identifications agree by their compatibility with composition.
Descent gives (5). A disjoint union gives the product over its
components. If a fiber-product component refines its minimal image
with degree \(e\), norm transitivity contributes the \(e\)-th power,
which is precisely its integral cycle multiplicity. \(\square\)

Although weight three alone reconstructs any one effective cycle,
formula (5) uses the norm on the second span at input weight \(3b\).
We do not claim that composition is a fixed-dimensional polynomial
operation on the weight-three tensors.

## 4. Higher traces are moments of commuting multiplication operators

Put \(\mathcal E=g_*\mathcal O_C\), a finite etale algebra of rank \(b\)
on \(Y\). Each \(s\in H^0(X,\omega_X^m)\) gives, by multiplication by
\(\kappa^m f^*s\), an operator
\[
 M_s:\mathcal E\longrightarrow\mathcal E\otimes\omega_Y^m.
                                                               \tag{6}
\]
These are twisted commuting operators:
\[
 M_{st}=M_sM_t,\qquad M_{s+t}=M_s+M_t
 \quad\hbox{when the displayed sum has one weight}.        \tag{7}
\]
After trivializing the line bundles, they are ordinary commuting
matrices. Their traces and determinants are
\[
       T_m(s)=\operatorname{tr}(M_s),\qquad
       \mathcal N_{\Gamma,m}(s)=\det(M_s).                \tag{8}
\]

Equivalently, the canonical ring of \(X\) acts on the graded bundle
\(\bigoplus_{n\ge0}\mathcal E\otimes\omega_Y^n\), increasing weight
by the degree of the acting element. Polynomial relations in that
canonical ring remain actual matrix relations before taking trace.
Taking traces forgets most of this multiplicative information:
\(\operatorname{tr}(AB)\) is not determined in general by
\(\operatorname{tr}(A)\) and \(\operatorname{tr}(B)\).

All these matrices become diagonal after an etale local splitting of
the algebra \(\mathcal E\); their simultaneous entries are the pullbacks
along the individual sheets. This is not a global direct-sum
decomposition of \(\mathcal E\) into line bundles. Its global monodromy
may be nonabelian, including groups of order divisible by \(p\).

## 5. Exact recurrences, and the characteristic-p information loss

Choose a nonzero rational differential \(\eta\) on \(Y\). For a fixed
section \(s\) of weight \(m\), trivialize (6) by \(\eta^m\), obtaining
a matrix \(A_s\) over \(k(Y)\). Define
\[
 Q_s(t)=\det(1-tA_s)=\prod_{c\in C_y}(1-t\lambda_c).
\]
Then the formal identity
\[
 -t\,\frac{Q_s'(t)}{Q_s(t)}
   =\sum_{j\ge1}\operatorname{tr}(A_s^j)t^j
   =\sum_{j\ge1}\frac{T_{jm}(s^j)}{\eta^{jm}}t^j          \tag{9}
\]
holds in every characteristic. It follows by differentiating the
product, or by formal expansion after splitting the etale algebra.
Consequently the diagonal higher traces satisfy the characteristic
polynomial recurrence of length at most \(b\).

For generic linear combinations of a basis of \(H^0(X,\omega_X^3)\),
the eigenvalues \(\lambda_c\) are distinct and nonzero over an
extension of \(k(Y)\): avoid the finitely many hyperplanes
\(\ell_c=0\) and \(\ell_c-\ell_{c'}=0\). The latter equations are
nonzero because the projective evaluation functionals are distinct.
Thus the generic characteristic polynomial is separable, even when
the characteristic divides \(b\).

Equation (9) also pinpoints a loss: multiplication of \(Q_s\) by a
\(p\)-th power does not change its logarithmic derivative. Integer
cycle multiplicities divisible by \(p\) disappear from all trace
moments, but not from the norm. Newton identities in characteristic
\(p\) cannot be inverted by silently dividing by indices divisible
by \(p\).

## 6. What this improves, and what is still missing

The linear trace construction detects any fixed nonzero \(k\)-cycle
in a sufficiently high input weight, with a support-dependent bound.
The norm construction instead uses one uniformly bounded input
weight and even retains integral positive multiplicities. It also
packages the higher differential operators as mixed moments of
commuting matrices on the same finite etale algebra.

The cost has not disappeared: the norm has degree \(b\), its output
has weight \(3b\), and the algebra \(\mathcal E\) has rank \(b\).
All of these can grow without bound. A faithful encoding is not a
bound on the encoded objects.

In particular, we have not proved that the canonical equations and
the two etale maps make these matrix systems impossible for the
chosen pair, or force a common function-field quotient. A useful
next obstruction must exploit the relations and differential
compatibility of the matrices, not just their traces, rank, or
existence as commuting matrices.
