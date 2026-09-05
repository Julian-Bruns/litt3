# Frobenius on the conductor quotient of a bi-etale joint image

Date: 2026-09-05.
Author: `/root/x_elliptic_quotient_maps`.
Status: proved and self-checked.

This note continues
[the ordered-collision description](BIETALE_JOINT_IMAGE_COLLISION_DIVISOR_AND_NORMAL_LINE.md).
It computes exactly which part of the cohomology of a singular joint image
comes from gluing its normalization branches.  The computation preserves
arbitrary contact multiplicities in characteristic `p`.

## 1. Setup

Let `k` be an algebraically closed field of characteristic `p>0`.  Let
`C` be a reduced integral projective curve whose normalization

\[
                         \nu:Z\longrightarrow C             \tag{1.1}
\]

is smooth.  Assume every completed branch of `C` is smooth.  This applies
in particular when `C` is the birational joint image of two finite etale
maps from `Z` to smooth curves.

Put

\[
 \mathcal Q=\nu_*\mathcal O_Z/\mathcal O_C,
 \qquad \delta_P=\operatorname{length}\mathcal Q_P,
 \qquad \delta=\sum_P\delta_P.                            \tag{1.2}
\]

Let `r_P` be the number of normalization branches over `P`, and define

\[
 b(C)=\sum_P(r_P-1),\qquad
 u(C)=\delta-b(C).                                        \tag{1.3}
\]

The integers `b(C)` and `u(C)` are respectively the toric gluing rank and
the non-seminormal, or unipotent, gluing length.

Absolute Frobenius preserves both terms in

\[
 0\longrightarrow\mathcal O_C\longrightarrow
 \nu_*\mathcal O_Z\longrightarrow\mathcal Q\longrightarrow0. \tag{1.4}
\]

For a finite-dimensional vector space with a Frobenius-semilinear map,
write `V_st` for its eventual image, on which Frobenius is bijective, and
`V_nil` for its eventual kernel.

## 2. The local stable and nilpotent pieces

**Theorem 2.1.**  At every singular point `P`, Frobenius on
`Q_P=H^0(P,mathcal Q_P)` has

\[
 \boxed{\quad
   \dim (Q_P)_{\rm st}=r_P-1,
   \qquad
   \dim (Q_P)_{\rm nil}=\delta_P-r_P+1.
 \quad}                                                     \tag{2.1}
\]

Consequently

\[
 \boxed{\quad
   \dim H^0(C,\mathcal Q)_{\rm st}=b(C),
   \qquad
   \dim H^0(C,\mathcal Q)_{\rm nil}=u(C).
 \quad}                                                     \tag{2.2}
\]

**Proof.**  Write the completed normalization at `P` as

\[
             \widetilde A=\prod_{i=1}^{r_P} k[[t_i]],
             \qquad A=\widehat{\mathcal O}_{C,P}.
\]

Taking branch residues gives an exact sequence

\[
 0\longrightarrow Q_P^0\longrightarrow \widetilde A/A
   \longrightarrow k^{r_P}/k\cdot(1,\ldots,1)
   \longrightarrow0.                                     \tag{2.3}
\]

Surjectivity follows by choosing arbitrary constants on the normalization
branches; an element of the local ring has the same residue on all
branches.  Frobenius is bijective on the right side because `k` is
perfect.

After subtracting a diagonal constant, every class in `Q_P^0` has a
representative whose component on every branch has positive valuation.
The conductor contains

\[
                     \prod_i t_i^{c_i}k[[t_i]]
\]

for suitable `c_i`.  Repeated `p`-th powers multiply every positive
valuation by powers of `p`, so some Frobenius iterate carries the
representative into the conductor and hence to zero in `Q_P`.  Thus
Frobenius is nilpotent on `Q_P^0`.  Its dimension is
`delta_P-(r_P-1)`, proving (2.1).  Direct summation over the finite
singular support proves (2.2).  \(\square\)

For a bi-etale joint image, the preceding note identifies

\[
 \delta_P=\sum_{i<j}m_{ij},\qquad
 m_{ij}=I_P(C_i,C_j).                                    \tag{2.4}
\]

It follows that

\[
 u_P=\sum_{i<j}m_{ij}-(r_P-1).                            \tag{2.5}
\]

Because every `m_ij>=1`, this is zero exactly for a smooth point or an
ordinary double node.  A transverse triple point already contributes one
nilpotent dimension.

### Exact double-contact filtration

If `P` has two graph branches of contact order `m`, then

\[
                         Q_P\simeq k[[x]]/(x^m),           \tag{2.6}
\]

and Frobenius sends a power series class to its `p`-th power.  Therefore,
for every `a>=0`,

\[
 \boxed{\quad
 \dim\ker(F^a\mid Q_P)=m-\left\lceil\frac{m}{p^a}\right\rceil,
 \qquad
 \operatorname{rank}(F^a\mid Q_P)
       =\left\lceil\frac{m}{p^a}\right\rceil.
 \quad}                                                     \tag{2.7}
\]

Indeed, the surviving monomials are
`1,x,...,x^floor((m-1)/p^a)`.  The stable dimension is one and the
nilpotent dimension is `m-1`.  The nilpotence exponent on the nonconstant
part is the least positive `a` for which `p^a>=m`.  In particular a
contact of order `p^s` has exponent `s`, despite the two branches having
identical first derivatives.

Pairwise contact orders do **not** determine all the intermediate ranks
of Frobenius when at least three branches meet.  In characteristic five,
consider the two completed branch triples

\[
\begin{array}{lll}
 y=x,&y=x+x^5,&y=x+2x^5,\\
 y=x,&y=x+x^5,&y=x+2x^5+x^6.
\end{array}                                                \tag{2.8}
\]

Every pair has contact five in both triples.  Thus both have
`delta_P=15`, conductor exponent ten on every branch, stable rank two,
and nilpotent rank thirteen.  Nevertheless the rank of the first
Frobenius on `Q_P` is respectively three and four.

Here is a direct check.  Work modulo the conductor `x^10` on each of the
three normalization branches.  Fifth powers are spanned by the branch
constant vectors and the three vectors `x^5e_i`.  Constants contribute
rank two modulo the diagonal.  For the first triple, the degree-five
part of the local ring contains both `(1,1,1)x^5` and `(0,1,2)x^5`, so
the `x^5e_i` contribute one further quotient dimension.  For the second
triple, the `x^6` term prevents `(0,1,2)x^5` from occurring without a
higher term; only the diagonal pure degree-five vector occurs, and the
three `x^5e_i` contribute two dimensions.  This proves the ranks claimed.
Thus (2.1) is an exact eventual decomposition, while finite Frobenius
kernel dimensions for multibranch points retain higher jet information.

## 3. Exact genus and Frobenius-rank relation

Since `C` and `Z` are connected, the first two terms on global sections
of (1.4) are both `k` and the map between them is an isomorphism.  Hence
there is a Frobenius-equivariant exact sequence

\[
 0\longrightarrow H^0(C,\mathcal Q)\longrightarrow H^1(C,\mathcal O_C)
 \longrightarrow H^1(Z,\mathcal O_Z)\longrightarrow0.     \tag{3.1}
\]

Stable dimensions are additive in a short exact sequence of finite
Frobenius-semilinear spaces: use the Fitting decomposition into the
bijective and nilpotent subcategories.  If

\[
 f_F(D)=\dim H^1(D,\mathcal O_D)_{\rm st}
\]

denotes Frobenius rank (the usual stable-curve `p`-rank convention for
singular `D`), then Theorem 2.1 gives

\[
 \boxed{\quad
   f_F(C)=f(Z)+b(C),
   \qquad
   p_a(C)-f_F(C)=\bigl(g(Z)-f(Z)\bigr)+u(C).
 \quad}                                                     \tag{3.2}
\]

Thus normalization removes exactly the forced singular Frobenius defect
`u(C)`.  Ordinary nodes add stable toric directions but no defect; higher
contacts and all points with at least three branches add nilpotent
directions.

## 4. Prime-to-p torsion twists and Frobenius orbits

Let `mathcal L` be a line bundle on a Frobenius twist of `C`, of finite
order `n` prime to `p`.  Frobenius does not ordinarily act on the single
space `H^0(mathcal Q tensor mathcal L)`: it moves the label through

\[
             \mathcal L,\mathcal L^p,\mathcal L^{p^2},\ldots. \tag{4.1}
\]

Let `e` be the length of this orbit.  The direct sum over (4.1) is
Frobenius-stable.  After choosing local frames, every transition map on
the factor supported at `P` is

\[
                         q\longmapsto u q^p               \tag{4.2}
\]

for a unit `u`.  Multiplication by a unit does not change kernels or
valuations.  Consequently the orbit sum has

\[
 \boxed{\quad
 \dim(\text{stable part})=e(r_P-1),\qquad
 \dim(\text{nilpotent part})=e(\delta_P-r_P+1)
 \quad}                                                     \tag{4.3}
\]

at `P`.  Equivalently, the return map `F^e` on any one label has stable
rank `r_P-1`.  At a double contact of order `m`, its kernel has dimension

\[
                         m-\left\lceil m/p^e\right\rceil.  \tag{4.4}
\]

Repeated returns kill precisely the remaining `m-1` dimensions.

This applies directly to the old two-leg labels.  If

\[
 \mathcal L=(A\boxtimes B)|_{C^{(1)}}
\]

for prime-to-`p` torsion points
`(A,B) in J(X^{(1)}) times J(Y^{(1)})`, then

\[
 \nu^{(1)*}\mathcal L
      =f^{(1)*}A\otimes g^{(1)*}B,                         \tag{4.5}
\]

and twisting the normalization sequence gives the Frobenius-compatible
long exact sequence along the whole label orbit

\[
\begin{aligned}
0&\to H^0(C,\mathcal L)\to H^0(Z,\nu^*\mathcal L)
 \to H^0(C,\mathcal Q\otimes\mathcal L)\\
 &\to H^1(C,\mathcal L)\to H^1(Z,\nu^*\mathcal L)\to0.
                                                               \tag{4.6}
\end{aligned}
\]

Relative Frobenius twists are suppressed in (4.6); each arrow goes from
one label in (4.1) to the next.  This formulation is essential: an
arbitrary torsion label is not itself Frobenius-fixed.

Away from the finite kernel of the pullback in (4.5), both degree-zero
line bundles have no global sections, and (4.6) reduces to

\[
 0\to H^0(C,\mathcal Q\otimes\mathcal L)
 \to H^1(C,\mathcal L)
 \to H^1(Z,\nu^*\mathcal L)\to0.                           \tag{4.7}
\]

At exceptional labels for which `nu^*mathcal L` is trivial, the
`H^0` terms in (4.6) must be retained; no dimension is silently assigned
to the normalization quotient there.

There is a useful refinement at these exceptional labels.  If
`mathcal L` has order prime to `p`, its class in the affine kernel of
`Pic(C)->Pic(Z)` lies in the toric part: the principal-unit unipotent
part has no prime-to-`p` torsion.  After changing the normalization
trivialization, the image of `H^0(Z,nu^*mathcal L)` in
`H^0(mathcal Q tensor mathcal L)` is therefore represented by branch
constants.  It lies in the stable quotient (2.3), not in the nilpotent
kernel.  Hence all `u(C)` nilpotent conductor directions still inject
into `H^1(C,mathcal L)` for every prime-to-`p` torsion label, including
the exceptional pullback-kernel labels.

## 5. Consequence and exact limitation for restricted Raynaud theta

For a degree-zero line bundle `N` on `Z^{(1)}`, membership in Raynaud's
theta divisor is

\[
 H^0\bigl(Z^{(1)},\mathcal B_Z\otimes N\bigr)\ne0,
 \qquad
 \mathcal B_Z=F_{Z/k*}\mathcal O_Z/\mathcal O_{Z^{(1)}}.  \tag{5.1}
\]

Equivalently, it measures failure of injectivity in the Frobenius
cohomology sequence for `N`, with the usual `H^0` terms retained at the
trivial label.

If `u(C)>0`, Theorem 2.1 shows that Frobenius on the singular curve has a
forced nilpotent conductor subspace for **every** prime-to-`p` label
orbit.  Thus a determinant or theta test performed on `C` is identically
singular for a reason which disappears after normalization.  Sequence
(4.7) identifies that spurious subspace exactly: it is the nilpotent part
of `H^0(mathcal Q tensor mathcal L)`, of dimension `u(C)` per label.

Consequently the collision computation does not by itself prove that the
restricted theta locus on `J(X) times J(Y)` is proper.  To prove
properness one must find an old two-leg label for which Frobenius becomes
injective on the **quotient**

\[
                         H^1(Z,\nu^*\mathcal L),           \tag{5.2}
\]

after removing the conductor contribution in (4.6).  The numbers
`delta_P`, `r_P`, and the complete double-contact filtration (2.7)
determine the discarded contribution, but they do not determine the
extension class in (4.6) or Frobenius on (5.2).

The useful reduction is therefore exact: higher contacts account for
`u(C)=delta-sum_P(r_P-1)` universally bad singular directions, while any
remaining failure of properness is genuinely a Frobenius phenomenon on
the smooth normalization and cannot be inferred from conductor length
alone.
