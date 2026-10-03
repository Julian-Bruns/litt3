# Proof: determinant kernels, fixed evaluations and Frobenius slope

[Statement](../../../Theorems/jacobians/theta_divisors/raynaud_rank_one_dimension.md).
The [earlier audit](../../../Research/audits/RAYNAUD_RANK_ONE_DIMENSION_AUDIT_2026_09_15.md)
checks the Fourier, slope, trace and Wronskian inputs.
The [Version3 review](../../../Research/audits/RAYNAUD_ALL_DEFECT_DIMENSION_2026_10_03.md)
checks the fixed-evaluation extension and its consequences.
The inverse-Fourier slope method originated in the user-supplied
Pro reply of 15 September2026. Fixed evaluations now remove its
rank-one hypothesis; the sharper Wronskian construction is optional.

## 1. Fixed evaluations reduce every positive defect to a line map

Write \(\theta=i^*[\Theta_J]\), and normalize the Poincaré family
\(\mathscr P\) on \(C^{(1)}\times A\) at \(c_0\). Put
\[
\mathcal C_\pm=R\pi_*(B_C\otimes L_0^{\pm1}\otimes\mathscr P),
\qquad
\mathscr K_\pm=\mathcal H^0(\mathcal C_\pm),\quad
Q_\pm=\mathcal H^1(\mathcal C_\pm).
\tag{5}
\]
These are square perfect complexes of amplitude \([0,1]\), with
derived base change. The self-duality
\(B_C^\vee\otimes\omega_{C^{(1)}}\simeq B_C\) and Serre duality
give equal generic ranks \(s>0\) on the opposite families.
This includes \(p=2\), when \(B_C\) is a theta characteristic.

A kernel between locally free sheaves is reflexive: its image is
torsion-free, and the depth lemma gives Serre's second condition.
Thus each \(\mathscr K=\mathscr K_\pm\) is reflexive of rank \(s\);
\(\det\mathscr K=(\bigwedge^s\mathscr K)^{**}\) is a line bundle.

Over \(k(A)\), evaluations of the generic global sections at fixed
\(k\)-points of the curve, followed by fixed fiber covectors,
span their dual vector space. Indeed, a nonzero section cannot
vanish at the infinitely many such points of the generic curve.
Choose \(s-1\) independent evaluation covectors. They give a global
map
\[
e:\mathscr K\longrightarrow
\bigoplus_{j=1}^{s-1}\mathscr P_{c_j}
\]
of generic rank \(s-1\). Points may repeat if their fiber covectors
differ. Put \(Q=\bigotimes_j\mathscr P_{c_j}\in\operatorname{Pic}^0(A)\).
Alternating cofactor contraction gives
\[
\det\mathscr K\longrightarrow\mathscr K\otimes Q.
\tag{6}
\]
On the locally free locus this is the usual vector of maximal minors:
if \(e=[I_{s-1}\;0]\), its last component is one. In particular it
is nonzero in every characteristic. Reflexivity of the target
extends it across the complement of codimension at least two.
For \(s=1\), take \(Q=\mathcal O_A\) and the identity map.

We have therefore obtained an actual nonzero morphism
\[
N:=\det\mathscr K\otimes Q^{-1}
\longrightarrow\mathscr K\longrightarrow\mathcal C.
\tag{7}
\]
It remains nonzero on degree-zero cohomology. No independence
over the curve's function field has been used.

Write \(M=(\det\mathscr K)^\vee\). Universal evaluation of (7)
at a general \(c\) implies
\(H^0(A,M\otimes Q\otimes\mathscr P_c)\ne0\).
Closedness of the section-support locus shows that
\(V^0(M\otimes Q)\) contains the entire Abel image
\[
j(C^{(1)})\subset\widehat A,\qquad
j=\widehat i\circ a_C,\quad j(c_0)=0.
\]
This curve generates \(\widehat A\): its dual map is the inclusion
\(i\). Thus \(M\otimes Q\) is effective and ample. For completeness,
if an effective line were nonample, the positive-dimensional
connected reduced kernel of its polarization would force \(V^0\)
into one proper coset of its annihilator. Restriction to a general
kernel coset proves this: a degree-zero line with a section is
trivial. Such a coset cannot contain a generating curve through zero.
Since \(Q\) is algebraically trivial, \(M\) is ample too.

This determinant version subsumes the rank-one kernel argument in
[the jump-divisor proof, Section7](raynaud_jump_divisor.md).
It makes no assertion about kernel base change at every parameter.

## 2. The two determinant polarizations share one budget

Let \(\iota=[-1]_A\). Relative duality gives
\[
R\mathcal Hom(\mathcal C_+,\mathcal O_A)
\simeq\iota^*\mathcal C_-[1],
\qquad Q_+^\vee\simeq\iota^*\mathscr K_-.
\tag{8}
\]
This identity holds in every generic rank, as is also clear by
dualizing a two-term locally free presentation. If \(D\) is the
divisorial torsion cycle of \(Q_+\), determinants yield
\[
\det(\mathcal C_+)^{-1}
\simeq\mathscr M_+\otimes\iota^*\mathscr M_-\otimes\mathcal O_A(D).
\tag{9}
\]
The torsion-free cokernel's reflexive hull supplies the second
factor; codimension-two defects do not alter the determinant.

GRR for the Poincaré family gives
\(c_1(\det(\mathcal C_+)^{-1})=(p-1)\theta\).
The fixed degree-zero twist changes no numerical class, and
inversion acts trivially on divisor classes. This proves (2).
An effective divisor on an abelian variety is nef; if nonzero,
its intersection with \(\theta^{d-1}\) is positive.

## 3. Inverse Fourier transform gives the Frobenius slope bound

The complex \(\mathcal C_\pm\) is the Fourier transform of
\(j_*(B_C\otimes L_0^{\pm1})\). Since \(N^{-1}=M\otimes Q\)
is ample, its antiample dual \(N\) has cohomology only in degree
\(d\). The shift in the inverse equivalence cancels that degree,
giving a vector bundle \(R\) on \(\widehat A\).

Use [Mukai, Theorem2.2 and Proposition3.11(1)](https://doi.org/10.1017/S002776300001922X)
for the equivalence and isogeny formula, over an algebraically
closed field of any characteristic. In the normalized convention,
the inverse functor is \((-1)^*\Phi[d]\), and
\[
\phi_{M\otimes Q}^*R
\simeq H^d(A,N)\otimes(M\otimes Q).
\tag{10}
\]
The positive line on the right is essential: applying the formula
to \(N\) gives \(\phi_N=-\phi_M\), and the inverse functor supplies
the extra inversion. No separability of this isogeny is required.
Consequently, with \(\beta=c_1(R)/\operatorname{rk}R\),
\[
\phi_\beta=\phi_M^{-1}\quad\text{in }\operatorname{Hom}^0(\widehat A,A).
\tag{11}
\]
The Picard-zero correction \(Q\) has changed neither polarization.

The nonzero map (7) becomes an actual nonzero sheaf morphism
\(R\to j_*(B_C\otimes L_0^{\pm1})\), hence
\(V=j^*R\to B_C\otimes L_0^{\pm1}\) by adjunction.
Here \(j\) is finite onto its image, so its pushforward is exact.
This preserves the actual cohomology map, rather than just its
determinant class.

Pull (10) back to the curve and normalize a reduced component of
the resulting finite cover dominating it. There \(V\) is a sum of
copies of one line bundle, as is every Frobenius pullback.
A destabilizing subbundle would remain destabilizing on this cover,
since slopes multiply by its degree. Thus \(V\) is strongly
semistable, also when the cover is inseparable.

The inclusion \(B_C\hookrightarrow F_{C/k*}\omega_C\), projection
formula and Frobenius adjunction give a nonzero map
\[
F_{C/k}^*V\longrightarrow
\omega_C\otimes F_{C/k}^*L_0^{\pm1}.
\]
Its image has degree at most \(2G-2\). Therefore
\[
\deg j^*\beta=\mu(V)\le\frac{2(G-1)}p.
\tag{12}
\]

## 4. One trace calculation proves all dimension bounds

Put
\[
a_\pm=\phi_\theta^{-1}\phi_{\mathscr M_\pm},\qquad
\operatorname{tr}(u)=\tfrac12\operatorname{Tr}
(u\mid H^1_{\rm et}(A,\mathbf Q_\ell)),\quad\ell\ne p.
\]
The Abel-curve class
\([a_C(C^{(1)})]=[\Theta_{\widehat J}]^{G-1}/(G-1)!\)
and cyclicity of trace give
\[
\deg j^*\beta_\pm
=\tfrac12\operatorname{Tr}(\phi_{\beta_\pm}\phi_\theta)
=\operatorname{tr}(a_\pm^{-1}).
\tag{13}
\]
Indeed, pullback along \(\widehat i\) has polarization
\(i\phi_\beta\widehat i\), and
\(\widehat i\phi_{\Theta_J}i=\phi_\theta\).
This uses the actual induced polarization, which need not be
principal. When \(A=J\) and \(M\equiv t\Theta_J\), (13) is \(G/t\).

The \(a_\pm\) are positive and self-adjoint for Rosati. Its positive
trace form gives, by Cauchy--Schwarz on \(a^{1/2},a^{-1/2}\),
\[
\operatorname{tr}(a)\operatorname{tr}(a^{-1})\ge d^2.
\tag{14}
\]
See [Milne, Abelian Varieties, I.14](https://www.jmilne.org/math/CourseNotes/AV.pdf)
for Rosati positivity. This is a real semisimple-algebra argument;
no complex uniformization or characteristic-zero lift is involved.

Set \(x_\pm=\operatorname{tr}(a_\pm)\),
\(\lambda_\pm=\operatorname{tr}(a_\pm^{-1})\), and \(b=(G-1)/p\).
Taking trace in (2) gives \(x_++x_-\le(p-1)d\), strictly if \(D\ne0\).
If \(\lambda_\pm\le b c_\pm\), then (14) gives
\[
(p-1)d\ \ge\ x_++x_-
\ \ge\ \frac{d^2}{b}
\left(\frac1{c_+}+\frac1{c_-}\right).
\tag{15}
\]
This is exactly (3), including strictness. Equation (12) supplies
\(c_+=c_-=2\) without any section-independence hypothesis, proving (1).

## 5. Optional Wronskians improve either sign independently

Suppose the \(s\) generic global sections on one opposite family
are independent over the generic curve's function field. Then
\(s\le p-1\), and there is a canonical morphism
\[
W_s:\bigwedge^s B_C\longrightarrow F_{C/k*}\omega_C^q,
\qquad q=s(s+1)/2.
\tag{16}
\]
Locally, for exact differentials \(a_i(t)\,dt\), it is
\[
\det(\partial_t^{\,j-1}a_i(t))_{1\le j,i\le s}\,(dt)^q.
\]
Derivatives kill scalars from \(C^{(1)}\). Coordinate changes act
triangularly on the rows with diagonal weights \(1,\ldots,s\),
so this formula is regular and global.

The Wronskian is nonzero precisely for independence over the
derivation's constant field. To see this, divide the columns by
a nonzero first function, leaving first column \(1\); reduce to
the derivatives of the remaining ratios and induct. A constant
linear combination of those derivatives equal to zero gives a
constant linear relation among the original functions.
Over \(k(A)\), the constant field is the relative Frobenius
subfield \(k(A)(C^{(1)})\subset k(A)(C)\), not necessarily all
\(p\)-th powers of the latter. No factorial division is needed.

Determinant evaluation followed by (16) yields an actual nonzero map
\[
\det\mathscr K_\pm\longrightarrow
R\pi_*(F_*\omega_C^q\otimes L_0^{\pm s}\otimes\mathscr P^s).
\tag{17}
\]
It extends from the locally free locus across codimension two,
as a map from a line into a vector bundle on the smooth product.
Its Fourier curve map is now \([s]j\). The same inverse-transform
and semistability argument gives slope
\(s^2\operatorname{tr}(a_\pm^{-1})\); adjunction bounds it by
\(2q(G-1)/p\). Thus
\[
\lambda_\pm\le \frac{s+1}{s}\frac{G-1}{p}.
\tag{18}
\]
Use this improved value on whichever signs satisfy independence
in (15). Both signs give (4); one gives the stated intermediate
bound. Equal generic section counts do not imply equal evaluation
ranks. Dependent sections use the fixed-evaluation argument instead.

## 6. Consequences and exact scope

Since \(G-1>(p-1)(G-1)/p\), no translated abelian divisor can be
contained in \(\Theta_{B_C}\). More generally every coset above
the dimension threshold has generic defect zero, with no quotient
a-number restriction. In genus two this covers every proper
positive-dimensional abelian subvariety; the full Jacobian is
already covered by the same inequality.

Tong [Remark5.10(C1)](https://arxiv.org/pdf/0712.2046) posed the
all-characteristic absence of abelian components. The argument here
supplies that conclusion; no claim about its current literature
novelty is made. The earlier genus-limited and small-characteristic
codimension-one arguments are therefore unnecessary.

For the actual mixed family \(d=11\), \(G-1=8n\), (1) requires
\(11\le32n/5\), strictly with its nonzero jump divisor, at every
positive generic defect. It still permits every \(n\ge2\).
Neither the actual two-map nonannihilation problem nor the unmarked
common-cover problem is resolved.
