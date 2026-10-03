# Proof: the actual jet torsor determines the reduced group

[Statement](../../Theorems/cartier_and_spin/first_cartier_full_monodromy.md).
We use the actual common Tannakian category and its
[full algebra orbit](common_cartier_monodromy_height.md).
The argument proves the broader statement without a genus-two
rank calculation. The [proper-subbundle criterion](cartier_witt_oper_subbundle.md)
identifies the additional intrinsic oper detector in characteristic
five. A positive canonical
power has no nonzero common section, since its zero divisor would
be a clump. All torsors and reductions below retain the specified
identification on the original source.

## 1. The Frobenius quotient is a coordinate-jet torsor

Fix $r\ge1$, put $q=p^r$ and $A_q=k[t]/t^q$.
The full algebra-coordinate group is
\[
\mathcal G_r=\operatorname{Spec}
k[a_0,a_1,a_1^{-1},a_2,\ldots,a_{q-1}]/(a_0^q).
\]
Its reduced subgroup $J_r$ consists of order-$(q-1)$ coordinate jets
$t\mapsto a_1t+\cdots+a_{q-1}t^{q-1}$.
The rth Frobenius has scheme-theoretic image $J_r^{(r)}$, with
coefficient map $a_i\mapsto a_i^q$ for $i\ge1$, and kernel
$\mathcal G_r[F^r]$. This morphism is faithfully flat.

For a smooth curve $C$, let
\[
\mathscr P_{r,C}=\operatorname{Isom}_{\mathrm{alg}}
(A_q\otimes\mathcal O_{C^{(r)}},F_*^{[r]}\mathcal O_C).
\]
This is the actual fppf frame torsor of the algebra, not a chosen
jet model. Its quotient by $\mathcal G_r[F^r]$ is the order-$(q-1)$
coordinate-jet torsor of $C^{(r)}$, with the coefficient twist
in the group $J_r^{(r)}$ retained.

Here is a coordinate verification of this identification. Write
$x=u^q$ on an etale coordinate neighborhood of $C^{(r)}$ and
adjoin a center $a$ with $a^q=x$. A frame is $t\mapsto u-a$.
For another coordinate $v=h(u)$, and a center $b$ for $v$, the
transition is the truncated Hasse expansion
\[
h(a)-b+\sum_{j=1}^{q-1}D^{(j)}h(a)t^j.
\]
Its constant term has qth power zero. The qth powers of its
other coefficients are exactly
$D^{(j)}h^{(q)}(x)$, where $h^{(q)}$ includes coefficient
Frobenius and $v^q=h^{(q)}(x)$. These are the usual coordinate
jet transitions on $C^{(r)}$. Hasse expansion, rather than division
by factorials, is essential when $j\ge p$. The calculation is valid for etale
coordinate changes and commutes with both original etale maps.

Evaluation of the common tensor category on either endpoint gives
an $H_r$-torsor reducing $\mathscr P_{r,C}$. Consequently the image of
$H_r$ in $J_r^{(r)}$ reduces this actual jet torsor. Applying further
Frobenius powers reduces the corresponding Frobenius pullbacks
of that jet torsor. This is also the usual tensor Frobenius
construction, so these reductions remain in the common category.

## 2. Two affine quotients of the reduced jet group

Only the first three coefficients are needed. Write
\[
\phi(t)=a\bigl(t+x t^2+(y+x^2)t^3+\cdots\bigr).
\tag{1}
\]
For \(\psi=A(t+Xt^2+(Y+X^2)t^3+\cdots)\), the first coefficients
of \((aA)^{-1}\phi\circ\psi\) are
\[
t+(X+Ax)t^2+
\bigl(Y+X^2+2AxX+A^2(y+x^2)\bigr)t^3.
\]
Completing the square gives the two affine cocycles directly:
\[
x(\phi\circ\psi)=X+Ax,\qquad
y(\phi\circ\psi)=Y+A^2y.
\tag{2}
\]
The scaling torus has weights1 and2 on these two translations
(up to reversing both weights with the action convention).
This calculation is valid in every coefficient ring and for every
jet order at least three; no characteristic-five group table is needed.

The first affine action is, up to the invertible scalar $2$, the
transformation of a connection coefficient on $\omega$.
The second is, up to the invertible scalar $6$, the
Schwarzian transformation of a projective connection. Indeed
\[
\frac{\phi''(0)}{\phi'(0)}=2x,\qquad
\{\phi,t\}(0)=6y.
\tag{3}
\]
Thus $x=0$ and $y=0$ are respectively stabilizers of zero in
these affine representations. The associated bundles of the
actual jet torsor are the connection torsor of $\omega$ and the
projective-connection torsor. Their translation lines are
$\omega$ and $\omega^2$, respectively.

We will use the following elementary subgroup consequence.
Write $J=J_r$ for this section. If a proper smooth closed subgroup
$D\subset J$ has surjective
projection to the scaling torus, then, after conjugation, it fixes
a point of at least one of the two affine actions in (2).

To see this, a maximal torus of $D$ can be conjugated to the
diagonal torus of $J$. Its projection is the whole scaling torus.
The Lie algebra of $J$ has basis
\[
e_i=t^{i+1}\partial_t\quad(0\le i\le q-2),\qquad
[e_i,e_j]=(j-i)e_{i+j},
\]
with out-of-range terms zero. The torus acts with distinct INTEGER
weights on these lines, so $\operatorname{Lie}D$ is their direct sum
for a subset of indices containing zero. If it contains $e_1$ and
$e_2$, it contains all indices through $q-2$. Inductively, for
$n\ge3$ use $[e_1,e_{n-1}]=(n-2)e_n$ when $n\not\equiv2\pmod p$.
In the remaining case use
$[e_2,e_{n-2}]=(n-4)e_n=-2e_n$; its two inputs have already
occurred and $2$ is invertible. Thus the characteristic-p resonances
do not interrupt generation. Smoothness and connectedness of $J$
would then force $D=J$.

Thus $e_1$ or $e_2$ is absent. For the corresponding affine action
in (2), the differential of $D$ has image exactly the toral line:
only $e_1$, respectively $e_2$, supplies its translation direction.
This Lie image is normalized by every point of $D$. In the affine
group, translation by a nonzero amount does not normalize the
toral Lie line, since its weight is $1$ or $2$, nonzero in $k$.
Therefore the entire reduced group $D$ fixes zero in that affine
action. This argument also handles disconnected $D$ and does not
replace a possibly inseparable group homomorphism by its differential.

## 3. Frobenius cannot hide a common affine section

Let $\mathscr T$ be either of these actual affine torsors, with
translation line $\omega^d$, $d=1$ or $2$. Suppose a finite
Frobenius pullback $F^{s*}\mathscr T$ has a common section.
For $s>0$ the affine bundle has its canonical Cartier connection.
The derivative of that section is a common section of
\[
\omega^{dp^s+1}.
\]
It vanishes by the no-clump hypothesis. The section is horizontal,
and Cartier descent gives a section one twist later. Repetition
gives a common section of $\mathscr T$ itself. This argument can
be made entirely with vector bundles by presenting the affine
torsor as the inverse image of $1$ in an extension of $\mathcal O$
by its translation line. All relative and coefficient twists are
retained.

For $d=1$ such a section is impossible already on the endpoint $C$
with $p\nmid g(C)-1$: its canonical line has degree nonzero in $k$
and therefore has no algebraic connection. This is the scalar Atiyah obstruction and
its Frobenius persistence in the
[all-height proof](common_atiyah_jet_obstruction.md).
For $d=2$ it gives an actual common regular projective connection.
Such a connection is dormant in the no-clump case in every
characteristic $p\ge5$. Indeed its trace-free projective p-curvature,
contracted from the oper line to its quotient, is an intrinsic
common section of $\omega^{p-1}$. If that section vanishes,
p-curvature preserves the oper line. Horizontality and the oper
second fundamental isomorphism then force p-curvature to be zero:
in an adapted rank-two frame, the lower-left horizontality equation
first kills its diagonal entry, and the diagonal equation kills
the remaining upper-right entry. The factors $2$ are invertible.
The construction does not require a common spin lift.

The torsor in Section1 is on the rth
twisted span. Existence of such a common connection transfers to
the original span by inverse COEFFICIENT twist; this is not an
identification with its relative Frobenius pullback.

## 4. The no-oper branch has the entire group at every height

Fix $r$, and abbreviate $H=H_r$, $J=J_r$.
Let $H_{\mathrm{red}}$ be the reduced subgroup of $H$. Over the
perfect field $k$ it is smooth. For sufficiently large $s$ the
scheme-theoretic Frobenius image of $H$ is the corresponding twist
of $H_{\mathrm{red}}$: a sufficiently large power kills its finite
nilpotent ideal. By Section1 it supplies a reduction of a finite
Frobenius pullback of the actual jet torsor.

The scaling character on that torsor is a positive Frobenius
power of the canonical line. Its restriction to $H_{\mathrm{red}}$
has infinite image: finite image would make some tensor power of
that line trivial, contradicting its positive endpoint degree.
Thus $H_{\mathrm{red}}$ projects onto the scaling torus.

If $H_{\mathrm{red}}$ were proper in $J$, Section2 would supply
a section of one of the two pulled-back affine torsors. Section3
either contradicts the degree of $\omega_C$ on the chosen endpoint or constructs a common
projective connection. In the no-oper branch both are impossible.
Therefore $H_{\mathrm{red}}=J$.

It remains to retain the entire nilpotent translation thickness,
not just its first Lie algebra. Since $J\subset H$, every
$R$-point $h$ of $H$ factors uniquely as
\[
h(t)=b+j(t),\qquad b=h(0),\quad j\in J(R).
\]
The translation $t\mapsto t+b$ therefore belongs to $H(R)$.
Put $T_H=H\cap\alpha_q$, using the translation subgroup. The
factorization gives an isomorphism of schemes
\[
T_H\times J\xrightarrow{\sim}H.
\tag{4}
\]
A closed subscheme of $\alpha_q$ has coordinate ring $k[b]/(b^d)$
for some $d\le q$. The full-orbit injection
$A_q\hookrightarrow k[H]$ sends $t$ to this same coefficient $b$
and has $b^{q-1}\ne0$. Consequently $d=q$, so $T_H=\alpha_q$.
Together with (4), this proves $H_r=\mathcal G_r$ as group schemes.
No extrapolation from the first Frobenius kernel is involved.

For \(1\le s\le r\), the actual intermediate algebra is
\[
A_{p^s}\hookrightarrow A_{p^r},\qquad
u\longmapsto t^{p^{r-s}}.
\]
Writing \(h(t)=\sum_i a_it^i\), its restriction is therefore
\[
u\longmapsto\sum_{i=0}^{p^s-1}a_i^{p^{r-s}}u^i.
\tag{5}
\]
The target coefficient twist is retained. These formulas identify
the actual Frobenius-subalgebra restrictions throughout the tower.

## 5. The common-oper branch has the projective normalizer

In this section set $r=1$ and write $H=H_1$, $\mathcal G=\mathcal G_1$.
For the common dormant oper let $K$ be its adjoint subbundle in
$\mathcal W$. On the infinitesimal fiber, a horizontal basis of
the rank-two dormant system gives a projective coordinate with
nonzero first derivative, by the oper condition. In that coordinate
the complementary Bol operator is the third derivative. Its kernel
identifies $K$ with
\[
K_0=\langle\partial_t,t\partial_t,t^2\partial_t\rangle.
\]
Thus $H\subset\operatorname{Norm}_{\mathcal G}(K_0)$.

This normalizer is precisely the group $\mathcal N$ of fractional
linear substitutions
\[
t\longmapsto\frac{at+b}{ct+d},\qquad b^p=0,
\tag{6}
\]
where matrices are taken projectively and their determinant is
invertible. The condition makes $d$ a unit locally, and (6)
defines an automorphism of $A_p$.

There is a direct proof over arbitrary coefficient algebras.
Translations by $b$ with $b^p=0$, and unit scalings, preserve $K_0$.
Use these to normalize a putative normalizer to
\[
h=t+c_2t^2+\cdots+c_{p-1}t^{p-1}.
\]
The pullback of $t\partial_t$ has coefficient $h/h'$. Membership
in $K_0$ forces this coefficient to be $t-c_2t^2$, because its
first two coefficients already have those values. Thus
$h'(t-c_2t^2)=h$ modulo $t^p$. The coefficient of $t^n$ gives
\[
(n-1)(c_n-c_2c_{n-1})=0\qquad(2\le n\le p-1),
\]
where $c_1=1$. Every factor $n-1$ is invertible. Hence
$c_n=c_2^{n-1}$ and $h=t/(1-c_2t)$ modulo $t^p$.
Undoing the normalization gives exactly (6).
Conversely put \(\Delta=ad-bc\). For \(h=(at+b)/(ct+d)\),
\[
h'=\frac{\Delta}{(ct+d)^2},\qquad
\frac1{h'}=\frac{(ct+d)^2}{\Delta},\quad
\frac h{h'}=\frac{(at+b)(ct+d)}{\Delta},\quad
\frac{h^2}{h'}=\frac{(at+b)^2}{\Delta}.
\]
These coefficients are quadratic over every coefficient ring, so
they preserve \(K_0\). Modulo \(t^p\),
\(h^p=b^p/d^p\), proving exactly the truncation condition. This establishes the full scheme normalizer, including
nilpotent coefficient directions, without classifying Lie algebra
automorphisms. Equivalently
\[
\mathcal N=F_{\mathrm{PGL}_2}^{-1}(B^{(1)}).
\]

Its reduction is the projective Borel $B$, whose first jet coefficients
in (1) have $y=0$; the remaining jet coefficients
are fixed by its fractional-linear form. The scaling character again has
infinite image. If $H_{\mathrm{red}}$ were proper in $B$, it would
be a conjugate of its scaling torus; a nonzero reduced unipotent
subgroup stable under that torus is the entire root line. After
killing any infinitesimal thickening by a finite Frobenius power,
this torus reduction would supply a section of the connection
torsor in Section2. Section3 excludes it. Hence
$H_{\mathrm{red}}=B$. The full algebra orbit again makes $H$
nonreduced. Its dimension is two, so its tangent dimension is at
least three. Since it is contained in $\mathcal N$, that dimension
is exactly three, and the height-one equivalence gives
$\mathcal N[F]\subset H$.

Finally $\mathcal N[F]$ and $B$ generate $\mathcal N$ fppf,
because $B\to B^{(1)}$ is faithfully flat. Therefore $H=\mathcal N$.

## Scope

The cocycles are coefficient identities, the all-height Lie
generation handles every resonance, and the normalizer calculation
holds over arbitrary coefficient rings. The bounded polynomial
checker is therefore unnecessary and has been deleted completely.
Its original executed receipt and source hash remain in
[the external provenance record](../../../litt3-computation-data/jet_monodromy_before_hindsight/provenance.json).

This proof uses the actual endpoint coordinate-jet torsors to
determine the reduced monodromy, and the full orbit to recover the
ENTIRE infinitesimal thickness at every height. It still supplies
no contradiction in the full coordinate-group case. In the projective case it supplies only the
first dormant oper, not its second common Cartier descent. Neither
original unmarked common-cover candidate is resolved.
