# Ordinary principal p-torsion interpolation below p

**Status:** author proof, with the Fourier–Mukai, polarization-descent, and global-generation ingredients source-checked during the bounded task of 2026-09-05. This note has **not been independently audited**. The Raynaud application below explicitly states the standard determinant-theta properties it uses; that application did not receive an additional source search or independent audit.

## Statement and scope

Let (k) be an algebraically closed field of characteristic (p>0). Let (A/k) be an ordinary abelian variety of dimension (g\geq 1), and let (L) be an ample line bundle defining a principal polarization. Write

\[
H=A[p](k)
\]

also for the corresponding reduced subgroup scheme of (A[p]). Thus (H\cong(\mathbf Z/p\mathbf Z)^g) and has length (p^g). The notation (H) in this note does not mean the full, generally nonreduced, group scheme (A[p]).

**Theorem.** For every integer (1\leq m<p), the restriction map

\[
H^0(A,L^{\otimes m})\longrightarrow
H^0(H,L^{\otimes m}|_H)
\tag{1}
\]

is injective.

More generally, if (\mathcal T\equiv L^{\otimes m}) is any line bundle in the same numerical class and (a\in A(k)), then

\[
H^0(A,\mathcal T)\longrightarrow
H^0(a+H,\mathcal T|_{a+H})
\tag{2}
\]

is injective. In particular, an effective divisor in that class cannot contain all of the coset (a+H).

This theorem does not assert a sharper count of torsion points on a divisor. It does not assert noncontainment of (H\setminus\{0\}), nor the existence of a section supported only at the origin after restriction to (H). The strict inequality (m<p) is an essential hypothesis of this note.

## Source-checked ingredients

1. S. Mukai, *Duality between (D(X)) and (D(\widehat X)) with its application to Picard sheaves*, Nagoya Math. J. 81 (1981), 153–175: Theorem 2.2, Example 2.6, formula (3.4), and Proposition 3.11(1). These give Fourier equivalence, the transforms of the structure and skyscraper sheaves, compatibility with isogenies, and the line-bundle pullback formula. The ground field is arbitrary algebraically closed in the notation on p. 154. [Primary-source PDF](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/BDBEBAC584BE15236C2D62C383A34245/S002776300001922Xa.pdf/duality-between-d-x-and-with-its-application-to-picard-sheaves.pdf).

2. G. Pareschi and M. Popa, *Regularity on abelian varieties I*, Theorem 2.4: an M-regular coherent sheaf tensored with an M-regular line bundle is globally generated. IT\(_0\) implies M-regularity, and ample line bundles are IT\(_0\). The background convention on p. 5 allows any algebraically closed field; the separate characteristic-zero assumption in Section 5 concerns its later applications. [Primary-source PDF](https://people.math.harvard.edu/~mpopa/papers/abv1.pdf).

3. B. Moonen, *Abelian varieties*, Chapter XI, Proposition 11.25 and its proof: a polarization descends through an isogeny precisely when its kernel contains the isogeny's kernel as an isotropic subgroup. Proposition 11.8 gives the degree formula. These statements concern group schemes and include positive characteristic. [Proof in Chapter XI](https://www.math.ru.nl/~bmoonen/BookAV/PolWp.pdf).

The proof below uses explicit isogeny pullbacks to establish vanishing. It does not depend on extending a characteristic-zero classification of semihomogeneous bundles to inseparable pullbacks.

## Proof

### 1. The quotient and its principal polarization

Let

\[
v:A\longrightarrow Y=A/H.
\]

This is a finite étale isogeny of degree (p^g). The restriction to (H\times H) of the Weil pairing for (L) takes values in (\mu_p). Since its source is reduced and (\mu_p) has only the identity as a reduced point, this restriction is the trivial group-scheme morphism. Therefore (H) is isotropic for the polarization (p\lambda_L=\lambda_{L^{\otimes p}}).

Polarization descent gives a polarization (\lambda_M) on (Y) satisfying

\[
\widehat v\,\lambda_M v=p\lambda_L.
\tag{3}
\]

Its degree is

\[
\deg(\lambda_M)=\frac{p^{2g}}{(p^g)^2}=1.
\]

Over (k), choose an ample line bundle (M) representing this principal polarization. Then

\[
v^*M\equiv L^{\otimes p}.
\tag{4}
\]

Only numerical equivalence is needed. If desired, the representative can be adjusted to make (4) an isomorphism: pullback (v^*: \operatorname{Pic}^0(Y)(k)\to\operatorname{Pic}^0(A)(k)) is surjective, since the dual isogeny is surjective on geometric points.

Define principal line bundles on the dual varieties by

\[
N_A=(\lambda_L^{-1})^*L\quad\text{on }\widehat A,
\qquad
N_Y=(\lambda_M^{-1})^*M\quad\text{on }\widehat Y.
\]

Their polarization homomorphisms are (\lambda_L^{-1}) and (\lambda_M^{-1}). Equation (3), together with surjectivity of (v), gives

\[
v\lambda_L^{-1}\widehat v=p\lambda_M^{-1}.
\]

Consequently,

\[
\widehat v^*N_A\equiv N_Y^{\otimes p}.
\tag{5}
\]

No symmetry assumption on the chosen representatives (L,M,N_A,N_Y) is required.

### 2. The pushforward and its Fourier transform

Put (E=v_*L^{\otimes m}). It is a vector bundle of rank (p^g). For every (\alpha\in\operatorname{Pic}^0(Y)), the projection formula and finiteness of (v) give

\[
H^i(Y,E\otimes\alpha)
=H^i(A,L^{\otimes m}\otimes v^*\alpha)=0
\quad(i>0).
\]

The last equality is the index theorem for ample line bundles on abelian varieties, valid in arbitrary characteristic. Thus (E) is IT\(_0\), and its normalized Poincaré transform

\[
F=\Phi_Y(E)
\]

is a vector bundle of rank (\chi(E)=m^g). Define

\[
Q=F^\vee,
\qquad
Q_m=\Phi_A(L^{\otimes m})^\vee.
\]

Mukai's isogeny compatibility gives

\[
F\cong\widehat v^*\Phi_A(L^{\otimes m}),
\qquad
Q\cong\widehat v^*Q_m.
\tag{6}
\]

This compatibility applies to the possibly inseparable isogeny (\widehat v).

### 3. Explicit splitting after multiplication by m

Let (W=H^0(A,L^{\otimes m})^\vee), a vector space of dimension (m^g). Mukai's line-bundle formula says

\[
\phi_{L^{\otimes m}}^*Q_m\cong W\otimes_k L^{\otimes m}.
\]

Since (\phi_{L^{\otimes m}}=[m]_{\widehat A}\circ\lambda_L), it follows that

\[
[m]_{\widehat A}^*Q_m\cong W\otimes_k N_A^{\otimes m}.
\]

Constant one-dimensional factors coming from rigidifications can be absorbed in the displayed vector space and do not affect any assertion. Pulling back by (\widehat v) and using its commutation with multiplication gives the explicit splitting

\[
[m]_{\widehat Y}^*Q
\cong W\otimes_k\widehat v^*N_A^{\otimes m}.
\tag{7}
\]

In particular,

\[
[m]^*(Q\otimes N_Y^{-1})\cong W\otimes_k R,
\qquad
R=\widehat v^*N_A^{\otimes m}\otimes[m]^*N_Y^{-1}.
\]

Equation (5) and the action of ([m]^*) on the Néron–Severi group give

\[
c_1(R)=\bigl(mp-m^2\bigr)c_1(N_Y)
=m(p-m)c_1(N_Y).
\tag{8}
\]

Thus (R) is ample for (1\leq m<p).

### 4. IT0 descent and global generation

Write (G=Q\otimes N_Y^{-1}). For every (\beta\in\operatorname{Pic}^0(\widehat Y)), equation (7) gives

\[
[m]^*(G\otimes\beta)
\cong W\otimes_k\bigl(R\otimes[m]^*\beta\bigr).
\]

The line bundle on the right is ample, so this pullback has no higher cohomology.

Since (m<p), the degree (m^{2g}) of ([m]) is invertible in (k). The unit followed by trace

\[
\mathcal O_{\widehat Y}\longrightarrow[m]_*\mathcal O_{\widehat Y}
\longrightarrow\mathcal O_{\widehat Y}
\]

is multiplication by (m^{2g}). After rescaling trace, the unit splits. The projection formula therefore makes (G\otimes\beta) a direct summand of ([m]_*[m]^*(G\otimes\beta)). Finiteness of ([m]) then yields

\[
H^i(\widehat Y,G\otimes\beta)=0
\quad\text{for all }i>0\text{ and all }\beta.
\]

Hence (G) is IT\(_0\). Both (G) and the ample line bundle (N_Y) are M-regular. Pareschi–Popa's Theorem 2.4 consequently implies that

\[
Q=G\otimes N_Y
\]

is globally generated. This step is valid in characteristic (p).

### 5. Fourier duality of evaluation: full argument

We record the precise evaluation statement needed here. Let (Z) be an abelian variety, let (E_0) be an IT\(_0\) vector bundle on (Z), let (F_0=\Phi_Z(E_0)), and put (Q_0=F_0^\vee). Then evaluation

\[
H^0(Z,E_0)\longrightarrow (E_0)_0
\tag{9}
\]

has the same rank as the transpose of evaluation

\[
H^0(\widehat Z,Q_0)\longrightarrow(Q_0)_0.
\tag{10}
\]

Indeed, evaluation (9) is the pairing given by composition

\[
\operatorname{Hom}(\mathcal O_Z,E_0)
\otimes
\operatorname{Hom}(E_0,k(0))
\longrightarrow
\operatorname{Hom}(\mathcal O_Z,k(0))=k.
\tag{11}
\]

Here (\operatorname{Hom}(E_0,k(0))=(E_0)_0^\vee), so (11) really is fiber evaluation of global sections. Fourier full faithfulness preserves this composition pairing. The identities

\[
\Phi_Z(\mathcal O_Z)\cong k(0)[-g],
\qquad
\Phi_Z(k(0))\cong\mathcal O_{\widehat Z}
\]

transport (11) to

\[
\operatorname{Ext}^g(k(0),F_0)
\otimes
\operatorname{Hom}(F_0,\mathcal O_{\widehat Z})
\longrightarrow
\operatorname{Ext}^g(k(0),\mathcal O_{\widehat Z}).
\tag{12}
\]

Let (D=\operatorname{Ext}^g(k(0),\mathcal O_{\widehat Z})), a one-dimensional vector space. Local freeness of (F_0), or a Koszul resolution at the origin, gives natural identifications

\[
\operatorname{Ext}^g(k(0),F_0)\cong(F_0)_0\otimes D,
\qquad
\operatorname{Hom}(F_0,\mathcal O_{\widehat Z})=H^0(\widehat Z,Q_0).
\]

Under these identifications (12) sends ((u\otimes d,s)) to (s(0)(u)d). This is exactly the pairing for (10), tensored with (D). Choosing a nonzero element of (D) identifies the two transposed evaluation maps up to an irrelevant scalar. In particular, global generation of (Q_0) implies injectivity of (9).

Apply this with (Z=Y), (E_0=E), and (Q_0=Q). Section 4 gives the required global generation, so

\[
H^0(Y,E)\longrightarrow E_0
\]

is injective. Finally, finite base change and the definition of (E) identify this map with (1):

\[
H^0(Y,E)=H^0(A,L^{\otimes m}),
\qquad
E_0=H^0(v^{-1}(0),L^{\otimes m}|_{v^{-1}(0)})
=H^0(H,L^{\otimes m}|_H).
\]

This proves the main statement.

### 6. Numerical twists, translates, and cosets

On an abelian variety, a numerically trivial line bundle belongs to (\operatorname{Pic}^0). Write

\[
\mathcal T\cong L^{\otimes m}\otimes\alpha,
\qquad\alpha\in\operatorname{Pic}^0(A)(k).
\]

Multiplication by (m) on (\operatorname{Pic}^0(A)) is surjective on (k)-points, so choose (\beta) with (\beta^{\otimes m}\cong\alpha). Then

\[
\mathcal T\cong (L\otimes\beta)^{\otimes m},
\]

and (L\otimes\beta) is again a principal ample line bundle. Moreover, principality makes (\lambda_L) an isomorphism, so (L\otimes\beta\cong t_b^*L) for a suitable (b\in A(k)). Thus every such twist can be absorbed into the principal line bundle, equivalently into a translate.

Apply the proved result to (t_a^*\mathcal T). Translation identifies its restriction to (H) with the restriction of (\mathcal T) to (a+H). This proves (2).

## Checked structural properties of the proposed bundle

These properties are consistent with, but are not substitutes for, the explicit proof above.

- (E=v_*L^{\otimes m}) has rank (p^g), Euler characteristic (m^g), is IT\(_0\), and has slope (c_1(E)/\operatorname{rk}(E)=(m/p)c_1(M)). To compute the slope, pull back the identity (v^*E\cong\bigoplus_{h\in H}t_h^*L^{\otimes m}), and use injectivity of (v^*) on rational numerical classes.
- (E) is semihomogeneous: for (y=v(x)), the bundle (t_y^*E) is the pushforward of (L^{\otimes m}) tensored with an algebraically trivial line bundle on (A); that line bundle lifts from (Y), by surjectivity of the dual isogeny on (k)-points.
- In fact (E) is simple. Adjunction and the displayed decomposition of (v^*E) identify its endomorphisms with the sum of the spaces (\operatorname{Hom}(t_h^*L^{\otimes m},L^{\otimes m})). For (h\ne0), the relative degree-zero line bundle is nontrivial because (\phi_{L^{\otimes m}}(h)=\lambda_L(mh)\ne0); its space of sections is zero. The (h=0) term is (k).
- Fourier equivalence and dualization show that (Q) is also simple. It is semihomogeneous by (6), since (Q_m) is semihomogeneous and pullback along an isogeny preserves the defining translation property. Equation (7) gives its rank (m^g) and slope ((p/m)c_1(N_Y)). The same prime-to-(p) trace argument applied to (7), without the negative twist, proves (Q) is IT\(_0\). Fourier full faithfulness gives (H^0(Q)=\operatorname{Hom}(E,k(0))=E_0^\vee), and hence (\chi(Q)=p^g).

Thus no non-simple Frobenius-pullback assertion is needed: the particular bundles in this proof are simple, and their vanishing is established explicitly.

## Sections vanishing away from one point

Let (\mathcal T\equiv L^{\otimes m}) with (1\leq m<p), let (C=a+H), and fix (x\in C(k)). Define

\[
V_{C,x}(\mathcal T)=
\{s\in H^0(A,\mathcal T):s(y)=0\text{ for every }y\in C(k)\setminus\{x\}\}.
\]

By (2), restriction to (C) is injective. Its image on this subspace lies in the single one-dimensional summand (\mathcal T_x\subset H^0(C,\mathcal T|_C)). Therefore

\[
\dim_k V_{C,x}(\mathcal T)\leq1.
\tag{13}
\]

Equivalently, evaluation at (x) is injective on (V_{C,x}(\mathcal T)). If a nonzero section in this space exists, it does not vanish at (x), and every other section with the same vanishing condition is a scalar multiple of it.

In particular, for (m=p-1), sections of (\mathcal T\equiv(p-1)L) vanishing at every point of (H\setminus\{0\}) form a space of dimension at most one. This is an upper bound and a conditional uniqueness statement. It asserts neither existence on an arbitrary ordinary principally polarized abelian variety nor impossibility of that vanishing condition.

## Conditional application to the Raynaud determinant section

Let (X/k) be an ordinary smooth projective connected curve of genus (g\geq1), and work on the Jacobian (J) on which its usual Raynaud determinant theta section is defined (with the Frobenius twist understood in the conventional construction). Let (B) denote the Raynaud bundle and write

\[
s_B\in H^0(J,\mathscr L_B)
\]

for its determinant theta section. The standard Raynaud properties used in this application are exactly:

\[
\mathscr L_B\equiv(p-1)\Theta,
\qquad
s_B(0)\ne0,
\qquad
s_B(h)=0\quad\text{for every }0\ne h\in J[p](k).
\tag{14}
\]

Here (\Theta) is the principal polarization class, (\mathscr L_B) is a fixed determinant line bundle, and the zero divisor of (s_B) is the Raynaud divisor. The nonzero value at the origin in (14) in particular ensures that this is a nonzero section.

To apply (13), choose a principal line bundle (L_\Theta) representing (\Theta). The numerical assertion in (14) means

\[
\mathscr L_B\cong L_\Theta^{\otimes(p-1)}\otimes\alpha
\quad\text{for some }\alpha\in\operatorname{Pic}^0(J)(k).
\]

Since (k) is algebraically closed, choose (\beta\in\operatorname{Pic}^0(J)(k)) satisfying (\beta^{\otimes(p-1)}\cong\alpha). Then

\[
\mathscr L_B\cong(L_\Theta\otimes\beta)^{\otimes(p-1)}.
\]

The line bundle (L_\Theta\otimes\beta) is principal and is a translate of (L_\Theta). Thus the Picard twist is fully accommodated by the theorem; no identification of the fixed determinant line bundle with a preselected power (L_\Theta^{\otimes(p-1)}) is being assumed.

Now (13), with (A=J), (m=p-1), (C=J[p](k)), and (x=0), combines with (14) to give

\[
\{s\in H^0(J,\mathscr L_B):
s(h)=0\text{ for every }0\ne h\in J[p](k)\}
=k\,s_B.
\tag{15}
\]

Therefore the Raynaud section is unique up to scalar among sections of its fixed determinant line bundle satisfying the mandatory nonzero-(p)-torsion vanishing condition. Equivalently, its divisor is the unique member of that fixed complete linear system containing (J[p](k)\setminus\{0\}).

This corollary uses the existing Raynaud section to supply existence. No analogous existence statement for arbitrary ordinary principally polarized abelian varieties follows from interpolation alone.

## Boundary of the argument

The proof relies on both the positive class (m(p-m)N_Y) in (8) and the invertibility of (m^{2g}) in the trace argument. These are available throughout (1\leq m<p). At (m=p), the displayed class becomes zero and multiplication by (m) has noninvertible degree; the proof gives no extension to that boundary. All statements and applications in this note retain (m<p), including the specialization (m=p-1).
