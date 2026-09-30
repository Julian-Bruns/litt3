# Proof: the canonical Cartier extension is the sole common trace obstruction

[Statement](../../Theorems/cartier_and_spin/common_cartier_extension_trace.md).
Work with the actual common triples on the indicated Frobenius twist.
The no-clump hypothesis makes every common image saturated. Common
kernels and cokernels are therefore vector bundles, and extensions
are extensions of the given triples, including their comparisons on
the same source. No simultaneous Galois closure is used.

## 1. Common cohomology and negative lines

For any common bundle $M$, extension gluing gives the exact sequence
\[
\begin{split}
H^0(X,M_X)\oplus H^0(Y,M_Y)&\longrightarrow H^0(Z,M_Z)
\longrightarrow\operatorname{Ext}^1_{\rm common}(\mathcal O,M)\\
&\longrightarrow H^1(X,M_X)\oplus H^1(Y,M_Y)
\xrightarrow{f^*-g^*}H^1(Z,M_Z).
\end{split}
\tag{6}
\]
Indeed endpoint extensions are locally free, and their pullbacks
admit a comparison exactly when their classes agree on $Z$.
The choices of that comparison differ by a section of $M_Z$;
endpoint extension automorphisms account for the preceding map.

For a finite etale map $h:D\to C$, the bundle
$h_*\mathcal O_D/\mathcal O_C$ becomes a trivial vector bundle
on a finite etale normal closure over THIS ONE endpoint. The
constant diagonal line and its quotient remain vector spaces even
when five divides the degree. Hence if $L$ has negative degree,
\[
H^0\bigl(C,L\otimes(h_*\mathcal O_D/\mathcal O_C)\bigr)=0.
\]
The unit sequence and projection formula imply that
$H^1(C,L)\to H^1(D,h^*L)$ is injective.

Apply this to the negative canonical powers. Their $H^0$ spaces
vanish on all three curves. The established
[negative-extension theorem](../deformations/two_leg_negative_extensions.md)
says that the intersection of the two $H^1$ images is zero when
there is no clump. Thus
\[
\operatorname{Hom}_{\rm common}(\mathcal O,\omega^{-i})=0,
\qquad
\operatorname{Ext}^1_{\rm common}(\mathcal O,\omega^{-i})=0
\quad(i\ge1).
\tag{7}
\]
These vanishings apply on every relative twist of the original span.

## 2. Frobenius adjunction computes the entire extension group

Put $q=5^r$. The augmentation ideal of
$F^{[r]*}F_*^{[r]}\mathcal O$ is filtered by the powers of the
diagonal ideal, with grades $\omega^i$, $1\le i\le q-1$.
Evaluation splits off its constant summand. It follows that
$F^{[r]*}B_r^{\vee}$ has a common filtration with grades
\[
\omega^{-1},\omega^{-2},\ldots,\omega^{-(q-1)}.
\tag{8}
\]
This is the diagonal-ideal filtration for the ACTUAL $q$th
Frobenius, not an assumption about nonzero higher derivatives.
By induction using (7) and the extension long exact sequences,
\[
\operatorname{Hom}_{\rm common}(F^{[r]*}B_r,\mathcal O)=0,
\qquad
\operatorname{Ext}^1_{\rm common}(F^{[r]*}B_r,\mathcal O)=0.
\tag{9}
\]

Frobenius pullback and finite direct image are exact adjoint
functors on these common triples, by etale base change. In degree
one, their adjunction can be verified without any injective-object
assumption: pull back an extension and push out by the counit;
in the other direction push forward and pull back by the unit.
The triangle identities make these Yoneda constructions inverse.
Thus (9) gives
\[
\operatorname{Hom}_{\rm common}(B_r,A_r)=0,
\qquad
\operatorname{Ext}^1_{\rm common}(B_r,A_r)=0.
\tag{10}
\]
Apply $\operatorname{Hom}_{\rm common}(B_r,-)$ to (2).
The two vanishings in (10) show that its boundary map is an
isomorphism from $\operatorname{End}_{\rm common}(B_r)$ onto
$\operatorname{Ext}^1_{\rm common}(B_r,\mathcal O)$.

The [complete higher Cartier lattice](higher_cartier_common_filtration.md)
has subbundle ranks $0,5^j-1$ for $1\le j\le r$.
If a nonzero endomorphism of $B_r$ had a nonzero proper kernel
of rank $5^j-1$, its image would be a common saturated subbundle
of rank $5^r-5^j$. This is nonzero and divisible by five, whereas
every allowed nonzero subbundle rank is minus one modulo five.
That is impossible. Thus every nonzero endomorphism is invertible.
The endomorphism algebra is finite dimensional over the algebraically
closed field $k$, so it is $k$. The boundary of its identity is
nonzero by (10). This proves (1) and the nonsplitting of (2).

## 3. The actual joint trace hyperplane

On EACH endpoint and on $Z$, the negative line filtration (8)
shows $H^0(B_r^{\vee})=0$, since faithfully flat Frobenius
pullback injects global sections. The same holds after any finite
etale pullback, where the bundle is precisely the corresponding
Cartier bundle. The argument with $h_*\mathcal O/\mathcal O$
in Section1 therefore also makes $H^1(B_r^{\vee})$ inject under
finite etale pullback.

Using $M=B_r^{\vee}$ in (6), the first three $H^0$ spaces are
zero. Part2 identifies the remaining kernel with the line generated
by $(e_{r,X},e_{r,Y})$. Frobenius etale base change identifies
both pullbacks with $e_{r,Z}$. This proves (3), including the
specified comparisons rather than an abstract equality of dimensions.

Serre duality identifies the transpose of $f^*-g^*$ with
$(\operatorname{Tr}_f,-\operatorname{Tr}_g)$ on $B_r\omega$.
Its image annihilates exactly $(e_{r,X},e_{r,Y})$. This proves
the equality of hyperplanes in (4), with the stated sign.
The canonical class is nonsplit on each individual endpoint as
well: endpoint adjunction and (8) give
$\operatorname{Hom}(B_{r,C},F_*^{[r]}\mathcal O_C)=0$.
Thus both functionals $\lambda_{r,C}$ are nonzero.

Finally $\operatorname{rk}B_r=q-1$ and
$\deg B_{r,C}=(q-1)(g(C)-1)$. Riemann--Roch and
$H^0(B_{r,C}^{\vee})=0$ give
\[
h^0(C,B_{r,C}\omega_C)=2(q-1)(g(C)-1).
\tag{11}
\]
For endpoint genera nine and two the target of (4) consequently
has dimension $18(q-1)$ and rank one less.

## 4. Strongly semistable positive coefficients in every rank

Let $E$ be common and strongly semistable, with $\mu(E_Y)>0$.
The [finite-coefficient theorem](../shared_tensors/common_finite_coefficients.md)
gives $\operatorname{Hom}_{\rm common}(E,B_s)=0$ for every $s$.
Only its STRICTLY positive-slope assertion is needed here. It follows
already from the integral-slope constraint for an image in the
rank-four first Cartier bundle: a positive integer slope cannot
satisfy $5\mu\le2$. Higher direct images follow by adjunction.
Applying $\operatorname{Hom}(E,-)$ to the Frobenius unit sequence,
then using exact adjunction as in Section2, proves injectivity of
\[
F^{[s]*}:\operatorname{Ext}^1_{\rm common}(E,\mathcal O)
\longrightarrow
\operatorname{Ext}^1_{\rm common}(F^{[s]*}E,\mathcal O)
\quad(s\ge1).
\tag{12}
\]
All scalar twists are retained. Thus a nonzero extension cannot
disappear after any Frobenius pullback.

Suppose for contradiction that a nonzero class is represented by
\[
0\longrightarrow\mathcal O\longrightarrow M
\longrightarrow E\longrightarrow0.
\tag{13}
\]
After a common Frobenius pullback, both $\operatorname{End}(E_C)$
are finite-etale-trivial. Indeed they are strongly semistable of
degree zero, so the finite-field boundedness and Lange--Stuhler
argument in the finite-coefficient proof applies. Their algebra
operations become constant on proper connected trivializing covers.
Their monodromy therefore lies in
$\operatorname{Aut}(\operatorname{Mat}(V))=\operatorname{PGL}(V)$,
where $V$ is the fixed fiber of $E$ on the common source.

The two finite projective monodromy groups generate a finite group
$\Gamma\subset\operatorname{PGL}(V)$: choose one finite field
containing representatives of all their matrix entries. The actual
comparison of $E$ gives the specified projective identification on
$Z$, not merely an equality of the endpoint monodromy orders.
By (12), replacing (13) by this Frobenius pullback has not killed
its class.

Choose a finite $\Gamma$-invariant set $\Sigma\subset\mathbf P(V)$
of lines spanning $V$, for example the union of the orbits of a
basis. The associated finite etale schemes give a CARTESIAN common
cover diagram
\[
q_X:S_X\longrightarrow X,\qquad q_Y:S_Y\longrightarrow Y,
\qquad
S_Z=Z\times_XS_X\simeq Z\times_YS_Y.
\tag{14}
\]
The three schemes may be disconnected. Their tautological common
line $L\subset q^*E$ is an actual subbundle. On a further finite
etale projective-frame cover of each connected component
$D\subset S_C$, the pulled-back bundle is the pulled-back
$L_D$ tensored with $V$. Descending the degree equality gives
\[
\deg L_D=\deg(D/C)\,\mu(E_C)>0.
\tag{15}
\]
Restricting (13) to $L$ gives the common rank-two extensions
\[
0\longrightarrow\mathcal O\longrightarrow M_\Sigma
\longrightarrow L\longrightarrow0
\tag{16}
\]
on this entire diagram.

Retain only those connected components on which the class in (16)
survives EVERY Frobenius pullback. This is a compatible open-and-closed
subdiagram of (14): negative-line $H^1$ is injective under finite
etale maps by Section1, so vanishing at any fixed height is equivalent
on a component and on every component lying above it. Taking all
heights preserves that equivalence.

This retained subdiagram is nonempty. Otherwise the finitely many
components would all have zero classes by one common height $N$.
On a projective-frame trivializing cover the directions in $\Sigma$
span $V$, so all component restrictions vanishing imply that the
whole endpoint extension $F^{[N]*}(13)$ splits. Pullback of its
endpoint class under that finite etale cover is injective: use the
unit sequence as in Section1, now with the negative strongly
semistable bundle $(F^{[N]*}E_C)^\vee$ in place of the negative
line. Its tensor product with a finite-etale-trivial bundle has
no sections. Thus both endpoint extension classes vanish. The
common class vanishes too, because $H^0(Z,(F^{[N]*}E_Z)^\vee)=0$
in (6). This contradicts (12).

We continue to write $S_C,L,M_\Sigma$ for the retained subdiagram.
If some component of $M_\Sigma$ were not strongly semistable,
retain the components with that property. This is again a common
open-and-closed subdiagram, since semistability is preserved and
reflected by finite etale pullback. At one sufficiently large
common Frobenius height $N$, every retained rank-two bundle is
unstable. Its unique maximal HN line $K$ maps nontrivially to
$L^{5^N}$: its positive degree prevents its lying in the trivial
subline of (16). That line map cannot be an isomorphism, since
the retained extension is nonsplit at EVERY height. It therefore
has a nonempty effective zero divisor $D_C$ on each component.

HN filtrations commute with the actual finite etale maps in (14).
Consequently these divisors match on $S_Z$. Their finite pushforwards
are nonzero effective divisors on the ORIGINAL endpoints, and finite
flat base change gives
\[
f^*(q_{X*}D_X)=q_{Z*}(D_Z)=g^*(q_{Y*}D_Y).
\tag{17}
\]
If relative Frobenius notation is used, this equality is on the same
$N$th twists throughout; its clump is equivalent to one on the
original span. Positivity in (17) does not require division by the
degrees and cannot disappear in characteristic five. It contradicts
the no-clump hypothesis. This step DOES NOT assume that a single
chosen connected refined span has no clump.

All components of the surviving $M_\Sigma$ must therefore be
strongly semistable. Push (16) down by the finite etale maps $q_C$.
The resulting common bundle $q_*M_\Sigma$ is strongly semistable
of slope $\mu(E_C)/2>0$, and contains the actual common degree-zero
subbundle $q_*\mathcal O$. To check strong semistability, use a
normal closure over each endpoint separately: the pullback of the
direct image is a direct sum of conjugates, all of the same slope
by (15). This applies after every Frobenius pullback as well.
The [quotient rigidity theorem](../shared_tensors/common_finite_coefficients.md)
for the ORIGINAL coreless span forbids a common subbundle of a
different slope. This final contradiction proves the arbitrary-rank
vanishing (5) in the statement.

## 5. The complete answer through rank four in the no-oper branch

Suppose now that there is no common projective connection and that
$E$ is common semistable of positive degree and rank at most four.
The [small-rank theorem](low_rank_common_frobenius_instability.md)
and [rank-four classification](rank_four_common_frobenius_classification.md)
say that it is either strongly semistable, or $E=B_1\otimes L$
for a common line $L$. Section4 deals with the former possibility.

In the latter case $\deg L_Y\ge0$, because
$\deg E_Y=4(1+\deg L_Y)>0$. The common filtration of
$F^*E^\vee$ has graded lines
\[
\omega^{-i}\otimes F^*L^{-1},\qquad 1\le i\le4,
\tag{18}
\]
all of negative degree. The
[arbitrary-line extension theorem](../deformations/shared_line_extension_spectrum.md)
makes their common $H^1$ zero in the no-clump case. Their common
$H^0$ vanishes as well. Exact adjunction and the first Frobenius
unit sequence consequently give
\[
\operatorname{Ext}^1_{\rm common}(E,\mathcal O)
\simeq\operatorname{Hom}_{\rm common}(E,B_1).
\tag{19}
\]
Both $E$ and $B_1$ are common-simple. The right side of (19) is
therefore zero unless they are isomorphic as actual common bundles,
in which case it is the scalar line. Its boundary is precisely the
canonical extension (2). This proves (6) in the statement, with
no assertion about unrelated endpoint isomorphisms.

For every positive semistable coefficient under discussion,
$H^0(E^\vee)$ vanishes on the endpoints and source. Thus (6) of
this proof and Serre duality turn extension vanishing into full
surjectivity of the ACTUAL joint trace. The exceptional first
Cartier case has exactly the hyperplane already computed in Section3.

## 6. All ample coefficients reduce to a bounded Cartier height

Let $E$ be any common bundle ample on the endpoints. By
[Langer's strong HN theorem, Theorem5.1 for GL and the cited vector-bundle Theorem2.7](https://arxiv.org/pdf/math/0312260),
one common Frobenius pullback $F^{[a]*}E$ has strongly semistable
HN grades on both endpoints. These filtrations and grades are
common, since HN commutes with the two etale maps. The last grade
is a quotient of an ample bundle, hence has positive degree. All
earlier slopes are larger, so every grade has positive slope.
Section4 and the extension long exact sequences consequently give
\[
\operatorname{Ext}^1_{\rm common}(F^{[s]*}E,\mathcal O)=0
\quad\text{for every }s\ge a.
\tag{20}
\]
Also $\operatorname{Hom}(F^{[s]*}E,\mathcal O)=0$ on each
endpoint: a nonzero image would be a nonpositive line quotient
of an ample bundle. Fix the target span here and let the sources
of $F^{[s]}$ be its inverse relative twists. Exact adjunction and
the unit sequence then identify
\[
\operatorname{Hom}_{\rm common}(E,B_s)
\xrightarrow{\sim}\operatorname{Ext}^1_{\rm common}(E,\mathcal O)
\quad(s\ge a).
\tag{21}
\]

This height can be bounded by the RANK, without any effective bound
on Langer's exponent. Take $s$ at least both $a$ and
$h=\lfloor\log_5(\operatorname{rk}E+1)\rfloor$. The image of
any common map $E\to B_s$ is saturated and hence is precisely
one of the canonical $P_j\subset B_s$. Its rank is $5^j-1$,
so $j\le h$. On this fixed target $P_j$ IS the bundle $B_j$
from the corresponding inverse twist. The inverse image of $P_j$
in $A_s$ is exactly its intermediate subalgebra $A_j$. Thus the
boundary in (21) is the pullback of the canonical extension for
$B_j$, along the actual surjection $E\twoheadrightarrow B_j$.
It already comes from the boundary map at height $h$.

That boundary is injective, since
$\operatorname{Hom}(E,A_h)=\operatorname{Hom}(F^{[h]*}E,\mathcal O)=0$.
This proves (7), including the case $h=0$, where every map in
(21) must have zero image. Frobenius pullback by the indicated
height kills each canonical extension by evaluation; hence it kills
every extension class represented in (7).

If $E$ is common-simple and the class is nonzero, the map
$E\to B_s$ is injective as well. Its image $P_j$ can be simple
only for $j=1$. It follows that $E\simeq B_1$ with its actual
comparison. Conversely $B_1$ is ample: its first Frobenius
pullback is filtered by the positive lines $\omega,\ldots,\omega^4$,
and ampleness descends through finite surjective maps. Its canonical
extension is nonzero by Section2. This proves the final assertion.

## 7. A sharp rank bound for the actual joint trace defect

Let $E$ be common ample of rank $d$, and let $m_B(E)$ be the
multiplicity of the ACTUAL common simple bundle $B_1$ in a
Jordan--Holder series of $E$. Such a series exists: every proper
common subobject has strictly smaller positive rank. Its multiplicities
are intrinsic in this abelian finite-length category.

The canonical image lattice shows that $B_h$ has unique simple
socle $B_1$, with scalar endomorphisms. Thus for every common
simple $S$,
\[
\dim\operatorname{Hom}_{\rm common}(S,B_h)=
\begin{cases}1,&S\simeq B_1,\\0,&S\not\simeq B_1.\end{cases}
\tag{22}
\]
Apply the left-exact functor $\operatorname{Hom}(-,B_h)$
successively to a composition series. Section6 gives
\[
\dim\operatorname{Ext}^1_{\rm common}(E,\mathcal O)
\le m_B(E)\le\lfloor d/4\rfloor.
\tag{23}
\]
The case $h=0$ follows directly from (7) of the statement.

For an ample bundle, $H^0(E^\vee)$ vanishes after every finite
etale pullback. Using a one-endpoint normal closure to trivialize
$h_*\mathcal O/\mathcal O$, as in Section3, therefore proves
injectivity of each endpoint map on $H^1(E^\vee)$. The gluing
sequence (6) identifies the kernel of their difference with the
common extension group in (23). Serre duality then identifies
that dimension with the cokernel dimension of the ACTUAL joint
trace on $E\omega$.

The bound is sharp for every $d\ge1$. Write $d=4a+b$ with
$0\le b<4$, and take the common ample bundle
\[
E=B_1^{\oplus a}\oplus\omega^{\oplus b}.
\tag{24}
\]
Sections1--2 give $a$ independent canonical extension classes
and no contribution from the canonical-line summands. For $d=4a$,
equality in (23) characterizes $E\simeq B_1^{\oplus a}$.
Indeed equality forces all composition factors to be $B_1$;
then every map $E\to B_h$ has image contained in $B_1$, since
all the other canonical factors of $B_h$ have larger rank and
are different simple objects. Consequently equality means
$\dim\operatorname{Hom}(E,B_1)=a$. Successively choosing
independent quotient maps shows that $E\to B_1^{\oplus a}$
is surjective: a proper image would have a nonzero map from
the semisimple quotient to $B_1$, giving a linear dependence.
The ranks agree, so this is an isomorphism.

For the fixed endpoint genera nine and two, set $b_Y=\deg E_Y$.
Compatibility gives $\deg E_X=8b_Y$. Riemann--Roch and
$H^0(E^\vee)=0$ show that the target of the joint trace has
dimension $9(b_Y+d)$. Its rank is therefore at least
\[
9(b_Y+d)-\lfloor d/4\rfloor.
\tag{25}
\]
This bound concerns shared coefficients already supplied by the
span. It does not make the noncommon three-form evaluation
subbundle into a common coefficient.

## 8. Positive tensor powers of the first Cartier bundle

Fix $m\ge2$. Every quotient $E$ of $B_1^{\otimes m}$ is
ample: tensor products and quotient bundles preserve ampleness
on a proper curve. Section6 reduces its common extension group
to maps $E\to B_h$. If one of these is nonzero, its actual image
is some $B_j$, so it gives a common surjection
\[
B_1^{\otimes m}\twoheadrightarrow B_j,\qquad j\ge1.
\tag{26}
\]
Pull this surjection back through $j$ relative Frobenius steps.
The source has a filtration by canonical lines whose exponents
range from $m5^{j-1}$ to $4m5^{j-1}$. They are all at least
two. The target $F^{[j]*}B_j$ is the augmentation ideal of
the Frobenius diagonal algebra and has its canonical quotient
\[
F^{[j]*}B_j\twoheadrightarrow I/I^2\simeq\omega.
\tag{27}
\]
No source grade admits a nonzero morphism to $\omega$, even
on either endpoint separately, by positivity of the difference
of their degrees. A filtration induction therefore makes the
composite of (26) and (27) zero. That contradicts its being
surjective. Hence the common Hom group and the extension group
are zero. This establishes (9) without asserting that these
tensor powers are semistable; some are not.

The proof has been checked for exact adjunction, the common gluing
term, and the sign in Serre duality. The arbitrary-rank step keeps
the whole finite cover diagram, first discards precisely the classes
eventually killed by Frobenius, and then descends effective divisors
by finite pushforward. Sections4,6,7 passed an
[independent bounded audit](../../Research/audits/COMMON_AMPLE_EXTENSIONS_AUDIT_2026_09_21.md).
Section5 uses the separately recorded author rank-four input;
Section8 is a direct author filtration check.
