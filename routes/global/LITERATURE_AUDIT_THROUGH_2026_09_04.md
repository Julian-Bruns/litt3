# Literature audit through 4 September 2026

## Status

**Status: literature report, not a proof of visibility or nonexistence.**

I found no theorem that decides whether two arbitrary smooth projective
curves over an algebraic closure of a finite field have a common finite
etale cover, and no post-May-2026 paper that proves the ambient-extension
statement needed in the present root-stack route.

Two items are genuinely new and close enough to the active reductions to
be useful:

1. Minamide--Sawada--Tsujimura (2 August 2026) prove inner rigidity for
   *families-preserving* isomorphisms between closed subgroups of almost
   surface groups. This gives a precise conditional ambient-extension
   theorem. Its missing hypothesis in our setting is much stronger than
   preservation of the three peripheral inertia groups: it quantifies
   over every procyclic closed subgroup. There is also no automatic common
   almost-prime-to-\(5\) quotient for the two legs.
2. Hippold (17 June 2026) proves smoothness and an exact dimension formula
   for strata of exact meromorphic differentials in characteristic \(p\).
   Applied to our \(30^{2M},(-32)^M\) profile, the divisor stratum has
   dimension \(22M-1\), hence codimension \(23M+1\) in the moduli of
   \(3M\)-pointed genus-\(14M+1\) curves. This is a sharp incidence input,
   but it does not by itself control the discrete etale Hurwitz locus over
   the fixed curve \(X\).

Three other results are valuable mainly because they rule out tempting
coarse strategies:

- Landesman--Litt construct etale covers over \(\mathbf C\) for which every
  fiber divisor moves, so “many moving fibers” alone is not an
  obstruction.
- Qiu proves over every infinite field, including
  \(\overline{\mathbf F}_5\), that a prescribed abelian variety occurs as a
  Jacobian isogeny factor with an arbitrarily large absolutely simple
  complement. Bare Jacobian-factor occurrence is therefore far too weak.
- The sharp bound for two-torsion points on a theta divisor is
  \(4^g-3^g\). It is applicable in characteristic \(5\), but is vastly too
  weak for the 32 effective square roots in file 44.

The search included exact-title searches, the June--4 September 2026 arXiv
feed in the relevant algebraic-geometry, number-theory, and geometric-
topology topics, and backward/forward citation checks for the May 2026
Ulam note and Bogomolov--Tschinkel. Bibliometric forward-citation counts
can lag; the mathematical conclusions below are based on the primary
papers, not on those counts.

## 1. The exact status of common-cover results

### 1.1 Tamagawa proves the affine theorem, not the proper theorem

Tamagawa defines two curves to be isogenous when they admit a common
finite etale cover. His main theorem says that **any two affine, smooth,
connected curves over the algebraic closure of a finite field are
isogenous**. The word “affine” is part of the theorem. The proof belongs
to the unramified Skolem/arithmetic Bertini circle; it does not yield the
proper statement by filling the punctures, because ramification at those
punctures is exactly what must be removed in the proper problem.

Primary source: A. Tamagawa, *Correspondences on curves in positive
characteristic*, Contemp. Math. 767 (2021), 97--114,
[DOI 10.1090/conm/767/15400](https://doi.org/10.1090/conm/767/15400).
The publisher abstract contains the exact affine theorem. Its main
backward proof sources include Tamagawa's
[*Unramified Skolem problems and unramified arithmetic Bertini theorems in
positive characteristic*](https://ems.press/books/dms/250/4908),
Doc. Math., Extra Volume Kato (2003), 789--831,
[DOI 10.4171/DMS/3/22](https://doi.org/10.4171/DMS/3/22), Raynaud's vector-bundle
theorem, and Tango's Frobenius theorem. I found no subsequent paper that
removes the affine hypothesis.

This item was already conceptually present in the project. The citation
audit adds no proper-case bridge.

### 1.2 Bogomolov--Tschinkel give one-sided virtual domination

Bogomolov--Tschinkel call \(C\) universal if, for every projective curve
\(C'\), some finite etale cover \(\widetilde C\to C\) admits a surjective
regular map \(\widetilde C\to C'\). Their Theorem 1.7 says that, for
\(p\geq5\), every hyperelliptic curve of genus at least two over
\(\overline{\mathbf F}_p\) is universal. Proposition 1.8 says, in
characteristic different from \(2,3\), that every hyperelliptic curve has
a finite etale cover dominating the fixed genus-two curve
\(C_0:\sqrt[6]{z(1-z)}\).

The map to \(C'\) or \(C_0\) is not asserted to be etale. Thus this is
one-sided virtual domination, not a common finite etale cover.

Primary source: F. Bogomolov and Y. Tschinkel,
[*Unramified correspondences*](https://arxiv.org/abs/math/0202223), in
Contemp. Math. 300 (2002),
[DOI 10.1090/conm/300/05141](https://doi.org/10.1090/conm/300/05141).

The most relevant forward references do not strengthen this to our
proper positive-characteristic problem:

- Poonen's Theorem 1.7 gives further sufficient hypotheses for a curve
  that is a tame Galois cover of a curve of genus at most two to virtually
  dominate a hyperelliptic curve. The conclusion is again one-sided.
  See B. Poonen, [*Unramified covers of Galois covers of low genus
  curves*](https://math.mit.edu/~poonen/papers/etale.pdf), Math. Res. Lett.
  12 (2005), 475--481,
  [DOI 10.4310/MRL.2005.v12.n4.a3](https://doi.org/10.4310/MRL.2005.v12.n4.a3).
- Markovic translates universality questions over \(\mathbf C\) into
  virtual properties of mapping class groups. This is a complex
  topological reformulation, not a characteristic-\(5\) bi-etale theorem.
  See [DOI 10.1112/blms.12696](https://doi.org/10.1112/blms.12696).
- Markovic--Tosic and Klukowski study higher Prym representations and
  homology of unbranched surface covers over the complex/topological
  setting. Their conclusions do not constrain a fixed positive-
  characteristic etale tower. See
  [DOI 10.1112/topo.12322](https://doi.org/10.1112/topo.12322) and
  [DOI 10.1112/topo.70023](https://doi.org/10.1112/topo.70023).

No forward reference located in this search proves a common finite etale
cover theorem for smooth proper curves over \(\overline{\mathbf F}_p\).

### 1.3 The May 2026 Ulam note

Chojecki's research note explicitly says that it does not solve the
problem. It introduces a ramification gradient and a stable cyclic-Prym
\(p\)-rank profile, then isolates two conjectural routes: a uniform Prym
gap for a fixed etale tower (negative route) and virtual tame-orbifold
uniformization (positive route).

Primary source: P. Chojecki,
[*Finite-etale tower profiles, ramification gradients, and cyclic Prym
p-ranks over \(\overline{\mathbf F}_q\)*](https://www.ulam.ai/research/litt-3.pdf),
research-note draft dated 24 May 2026.

Its mathematical references are Bogomolov--Tschinkel; Celik--Elias--
Gunes--Newton--Ozman--Pries--Thomas; Mochizuki; Nakajima; Ozman--Pries;
Raynaud; Saidi--Tamagawa; Tamagawa's fundamental-group finiteness theorem;
Tamagawa's 2021 affine correspondence theorem; and two papers of Y. Yang
on averaged generalized Hasse--Witt invariants and Raynaud--Tamagawa theta
divisors. Those sources support the note's reductions, but none supplies
the missing fixed-tower uniform gap. Exact-title and indexed-citation
searches found no forward paper building on this May note as of the date
of this audit.

## 2. New ambient rigidity: exact hypotheses and exact gap

### 2.1 Minamide--Sawada--Tsujimura, Theorem 3.11(iii)

The closest new result is A. Minamide, K. Sawada, and S. Tsujimura,
[*Families preserving isomorphisms via techniques in anabelian geometry:
with an application to a generalized Neukirch--Uchida theorem*](https://arxiv.org/abs/2608.01417),
submitted 2 August 2026.

Their terminology is precise (page references below are to arXiv v1):

- A **full-formation** \(\mathcal C\) is a family of finite groups containing
  the trivial group and closed under subgroups, quotients, and extensions
  (notation on p. 8).
- An isomorphism \(\alpha:H\xrightarrow{\sim}H'\) between closed subgroups
  of a profinite group \(G\) is **families preserving in \(G\)** if, for
  every procyclic closed subgroup \(I\subseteq H\), there is a
  \(g_I\in G\) such that

  \[
       \alpha(I)=g_I I g_I^{-1}.
  \]

  This quantifies over every procyclic subgroup, not merely inertia or
  decomposition subgroups selected by geometry. It includes finite and
  infinite procyclic groups and does not require \(I\) to be maximal or
  geometrically distinguished (Definition 2.7(ii), pp. 14--15).
- An almost pro-\(\mathcal C\)-maximal quotient is a quotient \(Q\) of a
  profinite group \(P\) for which there is a normal open
  \(N\triangleleft P\) such that

  \[
    \ker(P\to Q)=\ker(N\to N^{\mathcal C}).
  \]

  An almost pro-\(\mathcal C\) surface group is such a quotient of the
  etale fundamental group of a hyperbolic curve over an algebraically
  closed field of characteristic zero.

Theorem 3.11 (pp. 21--22) fixes an auxiliary prime \(p\), assumes that
\(\mathcal C\) is a full-formation containing
\(\mathbf Z/p\mathbf Z\), and assumes that \(G\) is one of:

1. an almost pro-\(\mathcal C\)-maximal quotient, or an almost symmetric
   pro-\(p\)-maximal quotient, of a free profinite group of rank at least
   two;
2. an almost pro-\(\mathcal C\) surface group, or an almost symmetric
   pro-\(p\)-maximal quotient of a profinite surface group; or
3. a pro-\(p\) Demushkin group of rank at least three.

Its part (iii) then assumes that the closed subgroups \(H,H'\subseteq G\)
each contain a nontrivial closed subgroup normal in \(G\). Every
families-preserving continuous isomorphism \(H\simeq H'\) in \(G\) is the
restriction of an **inner** automorphism of \(G\). There is no openness
hypothesis on \(H,H'\). For open \(H,H'\) in an infinite \(G\), however,
the normal-subgroup condition is automatic: each contains its nontrivial
normal open core (Remark 3.6.1(i), p. 20).

For open \(H,H'\) in an infinite surface group, the normal-subgroup
hypothesis is harmless: their cores are nontrivial normal open subgroups.
The hard hypothesis is families preservation.

The proof-level use of families preservation is essential, not decorative.
Theorem 3.11(i) produces free pro-\(p\) normal subgroups in suitable finite
layers, and (ii) proves strong subnormal internal indecomposability. The
proof of (iii) refers back to the proof of Theorem 3.6(ii), which applies
Theorem 2.6 and ultimately Theorems 2.3--2.4. Families preservation supplies
both of the inputs used there:

- by Remark 2.7.1(ii), it makes \(\alpha\) **normal**, hence fixes every
  ambient-normal closed subgroup lying in \(H\cap H'\);
- by Definition 2.7(ii) and Remark 2.7.1(iii), it gives, in every finite
  layer and for every relevant normal open subgroup of the free
  pro-\(p\) subgroup, ambient conjugacy for every primitive procyclic
  subgroup required in the third bullet of Theorem 2.3.

The second input is used explicitly on pp. 12--13. It makes each compact
set \(B_N\) in Claim 2.3.A nonempty; compactness then produces one pair
\((b,g)\) compatible through all normal-open levels. Lemma 2.2 turns the
resulting mod-\(p\) abelianized equalities into equality of procyclic
subgroups, and intersecting their normalizers forces the automorphism to
be conjugation by \(g\). Peripheral inertia data cannot substitute at this
step: the cyclic groups used range through arbitrary primitive elements of
the auxiliary free pro-\(p\) normal subgroups.

Remark 2.4.1(iii), p. 14, asks whether the **third bullet of Theorem 2.3**
can be dropped when the preceding normality hypothesis is retained, and
says this is unknown. Thus even the authors do not know how to replace the
cyclic-family input by normality, let alone by preservation of three
peripheral classes.

### 2.2 The \(S_3\) normalization

The theorem itself has no \(S_3\) or outer-automorphism alternative: its
conclusion is inner conjugation in the given ambient group. There is an
immediate normalized variant. For a known automorphism
\(\sigma\in S_3=\operatorname{Aut}(S)\), if
\(\sigma_*^{-1}\alpha\) is families preserving, the theorem gives

\[
       \alpha=\sigma_*\circ\operatorname{Ad}(g)
\]

on its domain. Equivalently, one may ask that \(\alpha(I)\) be conjugate
to \(\sigma_*(I)\) for every procyclic \(I\). This normalization is not
cosmetic: a nontrivial visible \(S_3\)-automorphism need not send an
arbitrary procyclic subgroup to a conjugate of itself.

Thus the exact conditional bridge suggested by this paper is:

> Find one common almost-surface quotient to which the two leg embeddings
> and their partial isomorphism descend, and prove that the normalized
> descended isomorphism preserves the ambient conjugacy class of every
> procyclic subgroup.

Then Theorem 3.11 supplies the desired ambient extension.

For the **unquotiented** root-stack group this hypothesis is already
stronger than what the project needs. Families preservation implies
normality by Remark 2.7.1(ii). If

\[
 A=i(H),\qquad B=\sigma_*^{-1}j(H),\qquad
 N=\operatorname{Core}_G(A)\cap\operatorname{Core}_G(B),
\]

then \(N\triangleleft G\) is open and lies in \(A\cap B\). A
families-preserving \(\sigma_*^{-1}ji^{-1}:A\to B\) must fix \(N\).
Its inverse image in the common source is therefore an admissible subgroup
in the sense of file 21. The simultaneous-envelope criterion already gives
visibility; Theorem 3.11 is unnecessary. This is an important circularity
check on the proposed application.

### 2.3 What algebraicity actually preserves

Write \(\alpha=ji^{-1}:i(H)\to j(H)\) for the isomorphism supplied by an
algebraic self-correspondence. For a procyclic \(J\subseteq H\), algebraicity
gives the tautological equality

\[
       \alpha(i(J))=j(J).
\]

It gives no ambient conjugator between \(i(J)\) and \(j(J)\). The following
are the precise distinguished cases.

1. If \(J=I_t\simeq C_{31}\) is stabilizer inertia at a stacky point of
   the source, then \(i(J)\) and \(j(J)\) lie in the inertia classes at
   the two branch labels \(u(t),v(t)\in\{0,1,\infty\}\). Representable
   etaleness preserves the order and local injection. After a fixed
   \(\sigma\in S_3\), these two subgroups are ambient-conjugate exactly
   when \(v(t)=\sigma(u(t))\). Algebraicity does not say that one
   permutation \(\sigma\) works for every source stacky point; that is
   precisely the missing alignment of the two three-part partitions.
2. After descent to a finite field, the arithmetic enhancement sends the
   decomposition group of a source point to the decomposition groups of
   its two images. Those two ambient decomposition groups are conjugate
   only when the target closed points agree (after the chosen \(S_3\)
   normalization). Thus point-theoretic families preservation would
   already force equality of the two maps on closed points. Frobenius
   equivariance up to the two independent inner path ambiguities in file
   25 does not supply this equality.
3. A general procyclic subgroup of the geometric surface group is neither
   inertia nor a point-decomposition group. The construction of the
   correspondence imposes no conjugacy relation on it. In particular,
   passing to the smooth atlas removes rather than enlarges the automatic
   peripheral family: the atlas is proper and has no cuspidal inertia.

At the level of open subgroups, algebraicity says that an open subgroup
and its image under \(\alpha\) describe the same abstract source cover.
Turning abstract isomorphism of the two total curves into conjugacy of the
two subgroups in \(G\) would say that the covers are isomorphic **over the
target**. This is the analogue of the extra weak Neukirch--Uchida input in
Proposition 3.10 of the paper, and in this setting it is essentially the
visibility assertion rather than a formal consequence of algebraicity.

### 2.4 Prime-to-\(5\) quotients: what is canonical and what descends

Let \(\mathcal C_{5'}\) be all finite groups of order prime to \(5\). It is
a full-formation and contains \(\mathbf Z/\ell\mathbf Z\) for every
\(\ell\ne5\). A smooth proper curve in characteristic \(5\) has a
canonical maximal pro-\(5'\) quotient, and by prime-to-characteristic
specialization this is a pro-\(5'\) surface group.

For the root stack there are two failures of the **canonical** quotient.

1. The canonical pro-\(5'\) quotient of
   \(S=\mathbf P^1(31,31,31)\) is a triangle-orbifold group: its order-31
   inertia survives. It is not an almost pro-\(\mathcal C_{5'}\) surface
   group in the paper's sense. Indeed, a torsion-free index-31 atlas has genus
   \(15\), so

   \[
      \chi_{\rm virt}=\frac{2-2\cdot15}{31}=-\frac{28}{31},
   \]

   whereas multiplicativity gives an integral virtual Euler
   characteristic for every almost pro-\(\mathcal C_{5'}\) quotient of a
   smooth hyperbolic curve. One can restrict to a torsion-free normal
   atlas, but then one must also restrict both legs to a common source
   cover.
2. For an open subgroup \(H\subset G\), the map
   \(H^{(5')}\to G^{(5')}\) need not be injective. The full pro-\(5'\)
   topology is induced from \(G\) only under an appropriate
   \(\mathcal C_{5'}\)-openness condition, not merely because the coset
   degree is prime to \(5\). In the alternating range of file 26, the
   core quotient is \(A_d\), whose order is divisible by \(5\). Hence the
   leg subgroup is not \(\mathcal C_{5'}\)-open: every normal subgroup of
   \(G\) contained in it lies in its core, and the corresponding quotient
   still surjects onto \(A_d\).

There is a useful noncanonical repair for a **single chosen finite
layer**. Let \(\Gamma\) be the full fundamental group of a smooth proper
atlas curve in characteristic \(5\), let \(A,B\subseteq\Gamma\) be the
two restricted open leg images, and choose a normal open
\(N\triangleleft\Gamma\) with \(N\subseteq A\cap B\). Put

\[
 R_N=\ker(N\longrightarrow N^{(5')}),\qquad Q_N=\Gamma/R_N.
\]

The subgroup \(R_N\) is normal in \(\Gamma\). A lift of the atlas curve to
characteristic zero exists, and its finite etale Galois cover belonging to
\(N\) lifts uniquely. Prime-to-5 specialization on that lifted cover then
identifies \(Q_N\) with the almost pro-\(\mathcal C_{5'}\) surface quotient
of the characteristic-zero surface group associated to the lifted
\(N\). Thus \(Q_N\) is in the category of Theorem 3.11 even when
\(\Gamma/N\) has order divisible by \(5\).

The obstruction is descent of the **partial isomorphism**. It descends to
an isomorphism of the images of \(A,B\) in \(Q_N\) if and only if

\[
                      \alpha(R_N)=R_N.                 \tag{2.1}
\]

Abstract functoriality only gives
\(\alpha(R_N)=\ker(\alpha(N)\to\alpha(N)^{(5')})\); it does not give
(2.1) unless \(N\) is itself aligned. Choosing the two leg cores separately
therefore produces two different kernels. This is the same core-alignment
issue as files 21 and 26, now expressed at a characteristic kernel.

There is nevertheless a clean conditional consequence worth recording.

> **Conditional extension to characteristic \(5\).** Let \(C\) be a smooth
> proper curve of genus at least two over an algebraically closed field of
> characteristic \(5\), \(\Gamma=\pi_1(C)\), and \(A,B\subseteq\Gamma\)
> open. Every families-preserving isomorphism \(A\simeq B\) in \(\Gamma\)
> is induced by an inner automorphism of \(\Gamma\).

Indeed, take the directed family of normal open
\(N\subseteq A\cap B\). Families preservation implies normality, so it
fixes every \(R_N\), and Remark 2.7.1(iii) makes the induced isomorphism in
each \(Q_N\) families preserving. Theorem 3.11(iii) makes it inner there.
The groups \(R_N\) are directed downward and
\(\bigcap_NR_N\subseteq\bigcap_NN=1\); Lemma 2.5 then makes the original
isomorphism inner. This removes the quotient-construction issue **under
the full families-preserving hypothesis**, but it does not make that
hypothesis follow from a correspondence.

### 2.5 Decision: existing hypothesis versus a weaker algebraic one

Route (A), proving the paper's existing families-preserving hypothesis,
does not offer a weaker intermediate goal. In the original root-stack
group its formal consequence “normal” already gives an admissible common
core and hence visibility, as shown in section 2.2. Proving it on every
cofinal almost-surface quotient likewise requires the kernel equalities
(2.1), which are core alignment in another form.

Route (B) cannot be a routine weakening of their proof. The proof uses
arbitrary primitive procyclic subgroups in auxiliary free pro-\(p\) normal
groups, at every normal-open level. Original peripheral inertia neither
contains nor detects those groups. A purely group-theoretic replacement by
peripheral preservation is false in general: non-inner mapping classes of
a surface preserve its peripheral conjugacy classes (and for a proper
surface there are no peripheral classes at all). After passage to our
proper atlas the proposed weak hypothesis is therefore vacuous.

The only viable version of (B) would add the full **algebraic and
arithmetic realizability** of the partial isomorphism and prove a new
pointwise rigidity theorem from it. Neither the argument of Theorem 3.11
nor any cited result supplies such a step. Accordingly, this paper is a
precise near-miss, not presently a promising way to close the problem.

### 2.6 Other recent anabelian papers

Hoshi's 2026 theorem is directly adjacent but has the ambient/open-subgroup
direction reversed from what we need. For the split tripod
\(T=\mathbf P^1_{\mathbf F_p}\setminus\{0,1,\infty\}\), let \(\Pi_T\)
be its arithmetic geometrically pro-\(\ell\) fundamental group. Theorem B
says that

\[
 \operatorname{Aut}(T)\longrightarrow
 \operatorname{Out}_{\Gamma_{\mathbf F_p}}(\Pi_T)
\]

is an isomorphism if either the closed subgroup generated by \(p\) is all
of \(\mathbf Z_\ell^\times\), or it does not contain \(-1\). For
\((p,\ell)=(5,31)\), reduction modulo 31 gives
\(\langle5\rangle=\{1,5,25\}\), so the second condition holds.

Primary source: Y. Hoshi, [*Tripod-Degrees*](https://ems.press/content/serial-article-files/52257),
Publ. RIMS 62 (2026), 177--200, published 17 February 2026,
[DOI 10.4171/PRIMS/62-1-5](https://doi.org/10.4171/PRIMS/62-1-5).

This classifies automorphisms of the **entire** arithmetic tripod group.
Our map begins as an isomorphism between two open subgroups, so invoking
Hoshi would already require the missing ambient extension. Moreover his
group is geometrically pro-31 for the affine tripod, whereas ours is the
full etale group of the proper order-31 root stack. Passing to the former
forgets the positive-characteristic monodromy groups, while passing from
the affine tripod to the root stack imposes finite order on peripheral
inertia. The theorem therefore verifies the final six-automorphism
classification after extension; it does not supply the extension.

- Holzschuh--Schmidt--Stix,
  [*Anabelian Geometry in Families*](https://arxiv.org/abs/2608.21232),
  submitted 21 August 2026, reconstruct relative hyperbolic curves over a
  normal finite-type base over a sub-\(p\)-adic field from open maps of
  etale homotopy types. The hypotheses are characteristic zero and the
  maps concern the full relative objects; this does not extend a partial
  open-subgroup isomorphism inside our characteristic-\(5\) root-stack
  group.
- Collas--Philip--Yamaguchi,
  [*Anabelian geometry for Deligne--Mumford curves*](https://arxiv.org/abs/2605.02577),
  submitted 4 May 2026, treats Deligne--Mumford curves in characteristic
  zero. It does not cover the full characteristic-\(5\) group or the
  open-subgroup ambient-extension step.
- Wang--Xu,
  [*Profinite rigidity of simple closed curves in surface groups*](https://arxiv.org/abs/2607.16147),
  submitted 17 July 2026, recognizes discrete simple closed curves from
  their behavior in all finite quotients. Our correspondence supplies no
  equality of those finite-quotient data for arbitrary simple curves;
  moreover their pro-\(p\) analogue fails. This is caution against relying
  on one pro-\(\ell\) shadow, not a bridge.
- Yang's earlier almost-open Hom theorem remains the closest
  positive-characteristic anabelian reconstruction result. It requires a
  special \(\Sigma\)-genus condition and reconstructs the common source
  from its arithmetic group; it does not extend its two embeddings to the
  ambient target. See Y. Yang,
  [*Group-theoretic characterizations of almost open immersions of
  curves*](http://www.kurims.kyoto-u.ac.jp/~yuyang/papersandpreprints/GCAO.pdf),
  J. Algebra 530 (2019), 290--325,
  [DOI 10.1016/j.jalgebra.2019.04.016](https://doi.org/10.1016/j.jalgebra.2019.04.016).

## 3. Exact differentials, Tango lines, and \(B^1\)

### 3.1 A new exact-stratum dimension formula

Hippold fixes an integer partition
\(\mathbf m=(m_1,\ldots,m_n)\) of \(2g-2\). Nonemptiness of the exact
differential stratum forces \(p\nmid m_i+1\). If nonempty, his Theorem
4.7 and Corollary 4.8 say that the stack including the nonzero exact form
and the stack remembering only its divisor are smooth of dimensions

\[
 \begin{aligned}
 \dim \Gamma\mathcal M^{\rm ex,\mathbf m}_{g,n}
   &=g-1+n+\sum_i\left\lfloor\frac{m_i}{p}\right\rfloor,\\
 \dim \mathcal M^{\rm ex,\mathbf m}_{g,n}
   &=g-2+n+\sum_i\left\lfloor\frac{m_i}{p}\right\rfloor.
 \end{aligned}
\]

Primary source: M. Hippold,
[*The Moduli Space of Twisted Exact Differential Forms on Curves in
Positive Characteristic*](https://arxiv.org/abs/2606.19241), submitted
17 June 2026.

For our seven-diamond profile,

\[
 g=14M+1,\qquad n=3M,\qquad
 \mathbf m=(30^{\,2M},(-32)^{\,M}).
\]

Both local conditions hold because \(31\) and \(-31\) are nonzero modulo
\(5\), and

\[
 \sum_i\left\lfloor\frac{m_i}{5}\right\rfloor
 =2M\cdot6+M\cdot(-7)=5M.
\]

Consequently

\[
 \dim\mathcal M^{\rm ex,\mathbf m}_{g,3M}=22M-1,
 \qquad
 \dim\Gamma\mathcal M^{\rm ex,\mathbf m}_{g,3M}=22M.
\]

Since \(\dim\mathcal M_{g,3M}=3g-3+3M=45M\), the divisor stratum has
codimension \(23M+1\). The result is local-global at first order and
proves smoothness at every existing point. It neither proves emptiness on
the fixed etale Hurwitz locus over \(X\) nor treats the simultaneous
incidence of the two exact forms. In fact a fixed-degree etale cover of
the fixed \(X\) is rigid over \(X\), so a tangent-space transversality
argument alone cannot exclude an isolated intersection. Any use here must
extract pointwise equations from Hippold's Cartier/local-global
description, or place the two-map data in a nontrivial deformation family
and prove more than failure to persist.

### 3.2 What is already known about Tango structures

Schroeer--Takayama Theorem 5.1 proves that a pre-Tango structure pulls
back under every finite, generically etale surjection between integral
smooth projective schemes. This independently confirms the monotonicity
proved in file 28; it supplies no converse or fixed-tower upper bound.
Their Theorem 4.1 says that, for a proper scheme over an adic noetherian
base, restriction of finite etale covers to the closed fiber is an
equivalence. It lifts a cover after the base is lifted; it does not make
two independently obtained lifts of the same source coincide.

Primary source: S. Schroeer and Y. Takayama,
[*On equivariant formal deformation theory*](https://arxiv.org/abs/1704.01725),
Rend. Circ. Mat. Palermo 67 (2018), 409--419,
[DOI 10.1007/s12215-017-0322-x](https://doi.org/10.1007/s12215-017-0322-x).

The classical references still give exactly the limits recorded in files
22 and 28: Tango's invariant and the Mukai--Sakai/Takeda--Yokogawa lower
bound, Joshi's stability of \(B_C^1\) for \(g\geq2\), Raynaud's theta
divisor, Tong's theta-divisor analysis, and Sun's Frobenius filtration.
The audit found no theorem controlling low-rank subbundles of the explicit
\(B_X^1\) after arbitrary etale pushdown, no stable-Tango invariant with a
known uniform gap on one fixed tower, and no result forcing an orbit of an
exact-differential line to have deficient span.

This negative finding agrees with file 43's explicit rank-three
degree-four subbundle and its generic full-rank orbit construction.

Yang's generalized Hasse--Witt existence theorems concern sufficiently
large prime-to-\(p\) cyclic covers and generic/maximal invariants; they do
not give a uniform inequality over every cover in a fixed etale tower.
See Y. Yang,
[*Generalized Hasse--Witt invariants for coverings with prescribed
ramifications*](https://www.kurims.kyoto-u.ac.jp/~yuyang/papersandpreprints/GHFD.pdf),
manuscript dated 9 March 2023.

## 4. Jacobians, Pryms, and effective torsion configurations

### 4.1 Prescribed Jacobian factors are flexible over
\(\overline{\mathbf F}_5\)

Qiu's Theorem 1 says: if \(k\) is any infinite field and \(A/k\) is an
abelian variety of dimension at least two, then for every \(N>0\) there is
a smooth projective curve \(C/k\), contained in \(A\), such that \(A\) is
an isogeny factor of \(J(C)\) and its complementary isogeny factor is
absolutely simple of dimension \(>N\). The proof separately handles
fields algebraic over finite fields by specializing at closed points whose
residue fields lie in the given infinite algebraic extension.

Primary source: C. Qiu,
[*A Note on Jacobians with Prescribed Factors*](https://arxiv.org/abs/2606.04344),
submitted 3 June 2026.

This does not construct an etale cover or prescribe the induced
polarization. It shows, however, that the occurrence of \(J(X)\) or
\(J(Y)\) as an unpolarized isogeny factor of some Jacobian cannot by itself
be exceptional over \(\overline{\mathbf F}_5\).

### 4.2 The new all-characteristic Prym classification has the wrong scope

Achter--Casalaina-Martin work over an arbitrary connected base and include
characteristic \(2\). For a finite fiberwise separable map
\(f:C\to C'\) of smooth proper curves with \(g(C)>g(C')\geq1\), they
construct the canonical complementary Prym. Their Theorem A classifies
when the polarization induced on the **entire complementary Prym** is an
integer multiple of a principal polarization. The cases are:

- degree-two etale;
- degree two with ramification divisor of degree two;
- degree-three noncyclic etale over a genus-two base; or
- \(g(C)=2,g(C')=1\).

Primary source: J. Achter and S. Casalaina-Martin,
[*Putting the p Back in Prym*](https://arxiv.org/abs/2312.13263), submitted
20 December 2023, revised 19 December 2024.

In our situation \(q^*J(Y)\) is only one subfactor inside a much larger
Prym. The theorem does not classify arbitrary subfactors or the two
Rosati projectors of files 40--42, so none of its four cases yields a
contradiction.

Classical cyclic-cover decompositions point in the same no-go direction.
For etale cyclic covers of hyperelliptic curves, Lange--Ortega identify
the Prym, up to an explicit isogeny and in several degrees up to
isomorphism, with products of Jacobians. Thus Jacobian factors inside
Pryms are common when extra symmetry is present. See H. Lange and A.
Ortega, *Prym varieties of etale covers of hyperelliptic curves*, Ann. Sc.
Norm. Sup. Pisa XVIII (2018), 467--482,
[DOI 10.2422/2036-2145.201606_001](https://doi.org/10.2422/2036-2145.201606_001),
[arXiv:1601.04082](https://arxiv.org/abs/1601.04082).

Recent Prym papers do not cover the fixed factor in an arbitrary etale
tower:

- Valdebenito Sepulveda,
  [arXiv:2608.04298](https://arxiv.org/abs/2608.04298), 5 August 2026,
  treats intermediate covers of \((\mathbf Z/p)^2\)-Galois covers and gets
  Prym--Tyurin varieties precisely in an elliptic-base case and an
  isotropic etale genus-two case.
- Jensen, [arXiv:2607.01173](https://arxiv.org/abs/2607.01173), 1 July
  2026, studies Prym--Brill--Noether loci for etale double covers of
  \(k\)-gonal curves via tropical methods.
- Shatsila, [arXiv:2608.18000](https://arxiv.org/abs/2608.18000), 18
  August 2026, studies pseudoreflections and smooth quotients for Pryms of
  etale double covers.
- Zhong, [arXiv:2608.29351](https://arxiv.org/abs/2608.29351), 29 August
  2026, proves complex mapping-class and period-map rigidity for moduli of
  unbranched triple covers in a low-dimensional range.

Each requires a special Galois degree, a generic/moduli hypothesis, or
characteristic zero. None constrains \(J(Y)\subset P(V/X)\) for an
arbitrary cover in our characteristic-\(5\) tower.

### 4.3 Effective square roots and theta bounds

Pareschi--Salvati Manni prove algebraically in characteristic different
from \(2\) that a divisor representing a principal polarization on a
dimension-\(g\) abelian variety contains at most

\[
                         4^g-3^g
\]

two-torsion points, with equality precisely for a product of elliptic
curves with its symmetric product theta divisor.

Primary source: G. Pareschi and R. Salvati Manni,
[*2-torsion points on theta divisors*](https://arxiv.org/abs/1907.07084),
IMRN 2021, no. 19, 14616--14628,
[DOI 10.1093/imrn/rnz282](https://doi.org/10.1093/imrn/rnz282).

The 32 classes in file 44 lie in an effective locus \(W_M(C)\), not
naturally in a fixed principal theta divisor of the same small dimension.
After translating/adding a divisor one can place them in a theta divisor
of \(J(C)\), but \(g(C)=2M+1\) makes the bound enormously larger than 32.
It cannot force coincidences or descent.

Care is needed with the older Marcucci--Pirola paper: it has a published
erratum. See
[DOI 10.4171/RLM/630](https://doi.org/10.4171/RLM/630) and
[DOI 10.4171/RLM/733](https://doi.org/10.4171/RLM/733). The later sharp
theorem above is the safe bound to use.

Over \(\overline{\mathbf F}_5\), every geometric point of an abelian
variety is torsion. Consequently characteristic-zero torsion-packet and
Manin--Mumford arguments do not constrain the 32 points in file 44. The
audit found no theorem classifying 32 effective two-torsion translates in
\(W_M(C)\), no canonical \(n\)-spin/root-pencil theorem that forces their
map from \(J(Y)[2]\) to descend, and no result turning the relation
\(L^{14}\simeq\omega_C^7\) into visibility.

### 4.4 Moving fiber divisors are not exceptional in etale towers

Landesman--Litt solve Prill's problem over \(\mathbf C\): for every
genus-two curve \(Y\), they construct a connected degree-36 finite etale
cover \(f:X\to Y\) for which every fiber divisor \(f^{-1}(y)\) moves in a
pencil. The construction uses a family from the Hesse pencil, and the
key passage from a constant Jacobian factor to failure of generic global
generation uses rational variations of Hodge structure.

Primary source: A. Landesman and D. Litt,
[*Prill's problem*](https://arxiv.org/abs/2209.12958), Algebraic Geometry
11 (2024), 290--295,
[DOI 10.14231/AG-2024-009](https://doi.org/10.14231/AG-2024-009).

The proof does not automatically specialize to characteristic \(5\), but
the example is enough to invalidate any purely formal claim that an
etale-cover fiber cannot move. A successful use of file 44 must retain
the simultaneous 32 squares, the degree-at-most-seven norm-polynomial
curve, and the fixed hyperelliptic origin; one moving pencil is too weak.

## 5. Lifting does not synchronize the two legs

Grothendieck existence for finite etale covers, in the precise form of
Schroeer--Takayama Theorem 4.1 above, says that once a proper base is
lifted over an adic noetherian ring, its finite etale covers lift uniquely
and algebraize. Standard tame equivariant deformation theory similarly
lifts a curve with a fixed finite tame group action when its local action
data lift.

Neither statement supplies what the correspondence needs. Lifting \(X\)
first produces a lift of \(V\to X\); lifting \(Y\) first produces a lift of
\(V\to Y\). There is no reason that the two resulting lifts of \(V\) are
isomorphic. Nor may one silently replace a common cover by a finite cover
simultaneously Galois over both targets: equality of the two iterated core
towers is exactly the missing finite-envelope problem of file 21.

Recent lifting papers remain local or one-action results:

- Chakraborty--Majumder,
  [*Artin--Schreier Root Stacks and lifts of group actions*](https://arxiv.org/abs/2606.14110),
  12 June 2026, concerns wild root stacks and individual group actions.
- Shimada,
  [*Arithmetic Kodaira--Spencer Class and Frobenius Liftings via
  Frobenius--Witt Cotangent Complex*](https://arxiv.org/abs/2608.21772),
  22 August 2026, develops an obstruction to Frobenius-compatible lifts,
  not a simultaneous lift of two finite covering maps.
- Dang--Vasiu,
  [*On lifting representations and actions on curves of the metacyclic
  groups \(C_{p^s}\rtimes C_m\)*](https://arxiv.org/abs/2609.03191),
  2 September 2026, treats special wild metacyclic local/global actions.

No source found in the scan turns two separately liftable etale maps with
a common special-fiber source into one simultaneous characteristic-zero
correspondence.

## 6. Other June--September 2026 near-misses

The following papers were inspected because their titles or abstracts
overlap one of the active routes. None supplies a currently usable lemma:

- Y. Luo,
  [*On the Finiteness of Geometric Representations for Varieties over
  Finite Fields*](https://arxiv.org/abs/2606.31341), 30 June 2026:
  bounded-rank/ramification finiteness for semisimple mod-\(\ell\)
  geometric representations; no ambient extension of an open-subgroup
  isomorphism.
- M. Kumar and P. Mandal,
  [*The minimum genus of Galois covers of curves*](https://arxiv.org/abs/2606.10638),
  9 June 2026: minimum-genus realization for specified Galois groups;
  no common-cover synchronization.
- H. Spencer,
  [*Simply branched covers of curves and wild conductor exponents*](https://arxiv.org/abs/2607.24454),
  27 July 2026: \(p\)-adic/ramification behavior of simply branched covers,
  not etale towers over the fixed characteristic-\(5\) curves.
- R. Cheng and E. A. Ozavci,
  [*Frobenius--Tschirnhausen ampleness*](https://arxiv.org/abs/2608.11304),
  11 August 2026: positivity questions not controlling \(B_X^1\)'s special
  subbundles.
- X. Lin and M. Sheng,
  [*Uniformization as Tannakian Reconstruction*](https://arxiv.org/abs/2605.25468),
  submitted 25 May and revised 29 July 2026: complex logarithmic-orbifold
  uniformization, not characteristic-\(5\) finite-etale
  commensurability.

## 7. Recommended use of the literature

The two most concrete new research tasks are now the following.

1. **Exact-stratum equations, not dimension alone.** Pull Hippold's local
   Cartier equations back to a parameter space retaining the map to the
   fixed \(X\), the second exact form, and the norm-divisor data. One needs
   a pointwise incompatibility. A codimension or transversality count
   cannot exclude an isolated cover of the fixed \(X\).
2. **Normalized families preservation on a common almost quotient.** Do
   not ask a black-box anabelian theorem merely to reconstruct the common
   source. The exact needed lemma is: after one \(\sigma\in S_3\), find a
   single almost-surface quotient containing both leg images and prove
   that every procyclic subgroup is sent to its ambient conjugacy class.
   Minamide--Sawada--Tsujimura would then finish ambient extension. At
   present both halves of this lemma are open, and the first is entangled
   with the existing core-tower obstruction.

The literature gives strong reasons not to spend the next effort on bare
Jacobian factors, the number of effective roots alone, a single moving
pencil, raw \(p\)-rank, or separate liftability. Each of those invariants
is either known to be highly flexible or loses precisely the simultaneous
embedding data that distinguishes visibility.
