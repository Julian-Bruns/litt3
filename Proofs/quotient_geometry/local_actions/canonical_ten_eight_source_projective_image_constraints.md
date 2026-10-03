# Proof: nonsolvable eight-source images and actual almost-simple GramFOUR sources

Version1, 3 October2026. Proof of the [statement](../../../Theorems/quotient_geometry/local_actions/canonical_ten_eight_source_projective_image_constraints.md). The general solvable-group theorem is independent of the actual GramFOUR almost-simple argument. Both new arguments are reproduced inline from separately audited frozen notes, without repeating numerical evidence or relying on finite-group classification.

## Original scope and accepted inputs

Both ACTUAL finite étale maps $h:T\to X$ and $q:T\to Y$ remain on their SAME smooth projective source. Only the specified actual projectively irreducible $V_8$ is used. The faithful canonical carrier supplies the no-prime-to-five-quotient input from [its accepted theorem](../../../Theorems/cartier_and_spin/canonical_degree_ten_prime_to_five_quotients.md). That quotient assertion does not require the full four-dimensional positive trace specialization appearing later in that record.

The almost-simple part additionally retains precisely the original GramFOUR multiplier, integral-row and local-generator antecedents of [eight-source scalar and wild constraints](../../../Theorems/quotient_geometry/local_actions/canonical_ten_eight_source_scalar_and_wild_constraints.md). Its SAME original product-one generators have orders five, five and two; its no-block and no-tensor inputs explicitly include permutations of tensor factors. No choice between the two allowed wild types is imposed. No arbitrary matrix tuple or native flag replaces these original-source hypotheses.

## Part I: the general solvable-group obstruction

## Solvable permutation actions of the needed small degrees

**Lemma 1.** A solvable transitive permutation group of degree
$r\in\{1,2,3,4,6,8\}$ has order prime to five.

Degrees at most four are immediate from $S_4$. A faithful primitive
solvable permutation group has prime-power degree. Indeed a minimal
nontrivial normal subgroup is elementary abelian; its orbits are
blocks, so it is transitive. A faithful abelian transitive subgroup
is regular, since an element fixing one point fixes every point
by commutation. Its order is therefore the degree.

Consequently a degree-six action is imprimitive. Its nontrivial
block system has two blocks of size three or three blocks of size
two. The group on the blocks and the kernel inside the product
of the groups on the blocks both have order prime to five.

The same argument handles imprimitive degree eight: two blocks of
size four or four of size two. For primitive degree eight, the
regular elementary abelian normal subgroup is $\mathbf F_2^3$.
The point stabilizer embeds in $GL_3(\mathbf F_2)$, because the
centralizer of the regular abelian subgroup in $S_8$ is itself.
The group order divides $8\cdot168$, again prime to five.

Thus if a group satisfying the quotient condition of the theorem
has any of these transitive permutation images, that image is
trivial. This last assertion uses the image as an actual quotient;
it does not exclude an unrelated subgroup of prime-to-five order.

## The normal elementary projective block

We record the exact elementary Clifford-theoretic package used below.
Let $\kappa$ be algebraically closed of characteristic $p$, let
$D$ be finite solvable with no nontrivial prime-to-five quotient,
and let $V$ be an irreducible projective $D$ module of dimension
$n\in\{2,3,6,8\}$. Replace $D$ by its faithful finite projective
image if needed; all group hypotheses are retained. This image
cannot be trivial when $n>1$.

Choose a minimal nontrivial normal subgroup $E$ of that image.
Solvability makes $E$ elementary abelian of some prime exponent
$\ell$. If $\ell=p$, the normal $p$-subgroup acts projectively
trivially, contradicting the faithful projective image.
To recall the projective version of this standard fact: on a
$p$-group the projective cocycle splits since $\kappa^*$ is
uniquely $p$-divisible and positive-degree finite-group cohomology
is killed by the group order. The resulting ordinary fixed space
is nonzero. Normality and the absence of $p$-group characters
make it invariant under the entire projective action; irreducibility
makes it all of $V$.

Thus $\ell\ne p$ and the restricted twisted group algebra
$\kappa^\alpha[E]$ is semisimple. Let $b$ be its commutator
pairing and $E_0=\operatorname{rad}(b)$. Its simple blocks
all have dimension
\[
d=\ell^a,\qquad d^2=|E/E_0|.
\]
For example split the nondegenerate alternating quotient into
paired cyclic factors; the twisted algebra for each pair is a
full matrix algebra. The radical supplies the center and the
different simple central characters, so all block dimensions
are equal.

Projective Clifford theory gives one transitive orbit of restriction
constituents with equal multiplicity $m$. Its orbit size $r$ satisfies
\[
n=rmd.
\]
Every divisor $r$ of any indicated $n$ belongs to the list in
Lemma 1. The permutation image is solvable and has order prime to
five, so it is trivial. Hence $r=1$ and the restriction is isotypic.

For this single block the image of the restricted twisted algebra
is $\operatorname{End}(W)\otimes1$ under $V=W\otimes L$,
with $\dim W=d$, $\dim L=m$ and $dm=n$.
If $d=1$, all of $E$ acts projectively as scalars, contrary to
faithfulness. Thus $d>1$. In the same way $E_0$ acts scalarly;
faithfulness gives $E_0=1$, and
\[
E\simeq\mathbf F_\ell^{2a},\qquad |E|=d^2.
\]
Conjugation by $D$ on the nondegenerate commutator pairing gives
an actual homomorphism
\[
D\longrightarrow Sp_{2a}(\mathbf F_\ell).
\]

Skolem--Noether applied to the normalized matrix algebra supplies
an irreducible projective $D$ action on $W$ and an irreducible
projective $D/E$ action on its multiplicity space $L$.
Explicitly choose matrices $W_g$ implementing conjugation of
$\operatorname{End}(W)$; then the original matrix is
$W_g\otimes L_g$. The ambiguities are scalar, making both
factors projective. Elements of $E$ act as scalars on $L$.
Irreducibility of $V$ excludes a proper invariant subspace of
$L$, while $E$ already acts irreducibly on $W$.

We also need the following fixed-operator observation. When $m=1$
the nondegenerate elementary $E$ gives a basis of
$\operatorname{End}(V)$ consisting of its projective operator
lines $\kappa T_e$, one for each $e\in E$.
If some $e\ne0$ is fixed under the actual conjugation action of
$D$ on $E$, then
\[
V_gT_eV_g^{-1}=\chi_e(g)T_e
\]
defines an honest character. Since $T_e^\ell$ is scalar,
$\chi_e^\ell=1$. Whenever $\ell\ne5$, the absence of
prime-to-five quotients forces $\chi_e=1$. Schur's lemma then
makes $T_e$ scalar, contradicting faithfulness and $e\ne0$.
This argument uses the order bound on the character; in
characteristic two it does not assert that every character
of $D$ is trivial.

## Small projective degrees over algebraic characteristic two

**Lemma 2.** A solvable group with no nontrivial prime-to-five
quotient has no irreducible projective module of dimension
two, three, or six over $\overline{\mathbf F}_2$.

Apply the preceding package to a faithful projective image.
In characteristic two the elementary prime $\ell$ is odd,
and $d=\ell^a>1$ divides $n$.

For $n=2$ there is no such odd prime power $d$, so the module
is impossible. For $n=3$, the only possibility is $d=3,m=1$,
with $E=\mathbf F_3^2$. The actual pairing action has image
in $Sp_2(\mathbf F_3)$, of order twenty-four. It is a
prime-to-five quotient and is therefore trivial. Every nonzero
$e\in E$ is fixed, and the fixed-operator observation, with
$\ell=3$, gives a contradiction.

For $n=6$, the only odd prime power $d>1$ dividing $n$ is
three. The multiplicity space then has dimension two and is
an irreducible projective module of the solvable quotient
$D/E$, with the same quotient condition. The dimension-two
case just proved excludes it. This proves Lemma 2.

## No simple six-dimensional module over the actual field of two elements

**Lemma 3.** A solvable group with no nontrivial prime-to-five
quotient has no irreducible ordinary module of dimension six
over $\mathbf F_2$.

Let $V$ be such a simple module. Its commuting division ring is
a finite field $\mathbf F_{2^e}$, and the density theorem makes
the image algebra a full matrix algebra over that field.
Writing $6=en$, scalar extension to $\overline{\mathbf F}_2$
therefore decomposes into $e$ conjugate absolutely irreducible
modules of dimension $n$. This is the finite-field form of
Schur's lemma and Wedderburn's theorem; the finite field is
separable, so the extension is semisimple even though the
whole modular group algebra need not be.

The divisors $n$ of six are one, two, three, and six. The last
three are excluded even projectively by Lemma 2. If $n=1$,
then $e=6$ and the actual group image lies in
$\mathbf F_{64}^*$, of order sixty-three. It is a
prime-to-five quotient, so it is trivial, which cannot be
irreducible on a six-dimensional $\mathbf F_2$ space.
This proves Lemma 3.

## Every solvable symplectic action on six binary dimensions has a fixed vector

**Lemma 4.** Suppose a solvable group $D$ with no nontrivial
prime-to-five quotient acts on a nondegenerate alternating
six-dimensional $\mathbf F_2$ space $Q$. Then $Q^D\ne0$.

Choose a simple nonzero $\mathbf F_2[D]$ submodule $S\subset Q$.
If $\dim S=1$, it is trivial because $GL_1(\mathbf F_2)=1$,
so it gives a fixed vector. If $\dim S=2$ or three, its image
lies in $GL_2(\mathbf F_2)$ or $GL_3(\mathbf F_2)$, of
orders six and 168. These are prime-to-five quotients, hence
trivial, again giving fixed vectors.

If $\dim S=4$, the radical of the restricted alternating form
is a $D$-submodule and is zero or all of $S$. The latter
would make $S$ an isotropic four-space, impossible in a
nondegenerate alternating six-space. Thus $S$ is nondegenerate,
and $Q=S\oplus S^\perp$, with $\dim S^\perp=2$.
The actual image on $S^\perp$ is a subgroup of
$Sp_2(\mathbf F_2)$, of order six, and therefore trivial.
Its nonzero vectors are fixed.

If $\dim S=5$, an alternating form on $S$ has nonzero radical.
Simplicity makes that radical all of $S$, giving an impossible
isotropic five-space. Finally $\dim S=6$ is excluded by
Lemma 3. These cases prove Lemma 4. No complete reducibility
of the original six-dimensional modular representation was assumed.

## Characteristic-five projective degree two

**Lemma 5.** A solvable group with no nontrivial prime-to-five
quotient has no irreducible projective module of dimension two
over an algebraically closed field of characteristic five.

Use the normal elementary package with $n=2$, $p=5$.
The only possible $d>1$ is $d=2,m=1$, and its elementary
normal subgroup is $E=\mathbf F_2^2$. The actual pairing
action lands in $Sp_2(\mathbf F_2)$, of order six, and
is therefore trivial. The fixed-operator observation with
$\ell=2$ gives a contradiction. This avoids the classification
of finite subgroups of $PGL_2$.

## Characteristic-five projective degree eight

Now suppose the group of the theorem has an irreducible projective
eight-module in characteristic five. Apply the normal elementary
package with $n=8$, $p=5$. The possibilities for $d>1$ are
two, four, and eight.

For $d=2$, the projective $D$ action on its irreducible block
$W$ has dimension two, contrary to Lemma 5. For $d=4$,
the irreducible projective multiplicity module of $D/E$ has
dimension two, again contrary to Lemma 5.

For $d=8,m=1$, the elementary normal subgroup is
$E=\mathbf F_2^6$ with its nondegenerate commutator pairing.
Its actual conjugation action is a solvable symplectic binary
six-dimensional action of a group with no prime-to-five
quotient. Lemma 4 supplies a nonzero fixed $e\in E$.
The fixed-operator observation, with $\ell=2$, contradicts
the irreducibility and faithful projective image.

All cases are impossible. This proves the general solvable-group
theorem and its necessary original-source applications.


## Actual original image and further kernels

The quotient condition passes from $G$ to its actual finite projective image $P$: any prime-to-five quotient of $P$ would be such a quotient of $G$. The defining projective module of $P$ is still the actual irreducible $V_8$. Part I therefore excludes solvability of $P$, and consequently of $G$.

For the further-kernel corollaries retain the ACTUAL quotients themselves: $R=2_-^{1+4}\rtimes C_5$ or $\widehat R=\mathbf F_5^4\rtimes R$. Both are solvable by their displayed extensions. In the original [finite Raynaud source choices](../../../Theorems/cartier_and_spin/canonical_ten_self_dual_four_finite_raynaud_source_choices.md) application, all that record's EXTRA hypotheses, including self-duality and nonzero cohomology on the SAME evaluating four-source, are retained when invoking its quotient construction. If either corresponding actual kernel were solvable, $G$ would be an extension of a solvable group by a solvable group and would be solvable, contradicting Part I. Hence these exact further kernels are nonsolvable. This does not exclude the remaining nonsolvable kernels.

## Part II: the actual GramFOUR almost-simple image

Put $P=\operatorname{im}(G\to PGL(V_8))$, faithful by definition. Its no-prime-to-five-quotient condition, block and tensor exclusions, and actual product-one generators are inherited from the SAME original source. The binary conjugation action below is honest, so its tuple relations retain no projective scalar ambiguity.

## The binary six-space Scott lemma

**Lemma.** Let a group be generated by $a,b,c$ with $abc=1$,
$a^5=b^5=c^2=1$. If it acts on a nondegenerate alternating
six-dimensional $\mathbf F_2$ space $Q$, then $Q^G\ne0$.

An order-five action over $\mathbf F_2$ is semisimple. Its
only irreducible dimensions are one and four, because
$X^4+X^3+X^2+X+1$ is irreducible over $\mathbf F_2$.
On a six-space it has at most one nontrivial four-dimensional
constituent. Thus
\[
\operatorname{rank}(a-1)\le4,\qquad
\operatorname{rank}(b-1)\le4.
\]
In characteristic two, $(c-1)^2=0$, so
$\operatorname{rank}(c-1)\le3$.

Here the required Scott inequality has a direct elementary proof.
Put $g_1=a,g_2=b,g_3=c$, and consider
\[
\Phi:\bigoplus_{i=1}^3\operatorname{Im}(g_i-1)\to Q,
\qquad(v_1,v_2,v_3)\mapsto
v_1+g_1v_2+g_1g_2v_3.
\]
A functional annihilating its image is fixed by $g_1$, then
by $g_2$, then by $g_3$. Because these are the SAME generating
tuple, the image has dimension $\dim Q-\dim(Q^*)^G$.
The map
\[
x\mapsto((g_1-1)x,(g_2-1)x,(g_3-1)x)
\]
has kernel $Q^G$ and lands in $\ker\Phi$, by telescoping
and $g_1g_2g_3=1$. Consequently
\[
\operatorname{rank}(a-1)+\operatorname{rank}(b-1)
+\operatorname{rank}(c-1)
\ge2\dim Q-\dim Q^G-\dim(Q^*)^G.
\]
The perfect invariant alternating form identifies $Q$ with
$Q^*$, including their invariant spaces. Writing
$h=\dim Q^G$, the inequality and the rank bounds give
$11\ge12-2h$, hence $h\ge1$. This proof does not assume
that the full modular group action is semisimple, solvable,
or faithful. An element acting trivially only improves a
rank bound.

## A normal abelian subgroup would supply a fixed projective operator

Suppose $A\triangleleft P$ is abelian and nontrivial. Its
characteristic five-primary subgroup is a normal five-group
and acts projectively trivially on the irreducible module,
so faithfulness makes it trivial. Recall the projective
normal-five fact: the restricted cocycle splits because
$k^*$ is uniquely five-divisible; the resulting nonzero
ordinary fixed space is invariant under the full projective
action by normality and the absence of five-group characters.
Irreducibility makes that fixed space the whole module.

Thus $A$ has order prime to five. Its twisted restriction
algebra is semisimple. Projective Clifford theory supplies
one orbit of simple constituents. More than one isotypic
component would give a prohibited direct-sum block system.
Therefore
\[
V_8=W\otimes L,\qquad dm=8,
\quad d=\dim W,\quad m=\dim L,
\]
with the restricted algebra image
$\operatorname{End}(W)\otimes1$. Its normalization by
$P$ and Skolem--Noether give projective actions on $W,L$.
When $d,m>1$ this is a prohibited tensor decomposition.
The only possibilities are therefore $d=1$ or eight.
$d=1$ makes $A$ projectively scalar, contrary to faithfulness.

For $d=8$ the projective $A$ action is irreducible. Let $b_A$
be its commutator pairing. Its radical consists precisely
of scalar operators: a radical operator commutes with the
whole irreducible restriction, so Schur's lemma applies.
Faithfulness makes that radical trivial. The nondegenerate
twisted algebra now gives
\[
|A|=8^2=64.
\]
For each $e\in A$ choose its nonzero matrix $T_e$. These
sixty-four projective operator lines form a basis of
$\operatorname{End}(V_8)$; conjugation by $P$ permutes them
and preserves $b_A$.

A finite abelian group with a nondegenerate alternating pairing
has paired cyclic factors. To see this, choose $x$ of maximal
order $n$, then $y$ for which $b_A(x,y)$ is primitive of order
$n$. Their nondegenerate subgroup is $C_n^2$ and splits off
orthogonally; induction gives the assertion. The only order64
types are
\[
A=C_8^2,\qquad C_4^2\times C_2^2,
\qquad\text{or }\mathbf F_2^6.
\]

The first two automorphism groups have order prime to five.
For $C_8^2$, reduction modulo two has image inside
$GL_2(\mathbf F_2)$ and two-group kernel. For
$C_4^2\times C_2^2$, the characteristic two-step filtration
of $A/2A$ by $A[2]/2A$ has two two-dimensional graded
pieces. Its automorphism image has diagonal part in
$GL_2(\mathbf F_2)^2$ and two-group off-diagonal kernel.
The congruence kernel of automorphisms trivial modulo two
is a two-group as well. Thus the actual $P$ action on
either such $A$ is a prime-to-five quotient and is trivial.
Every nonzero $e\in A$ is then fixed.

If $A=\mathbf F_2^6$, its commutator pairing is a perfect
binary alternating form, with the value $-1$ identified
with the nonzero element of $\mathbf F_2$. The actual
conjugation action of the SAME original $a,b,c$ preserves
this form and satisfies their original relation. The Scott
lemma above therefore supplies $e\ne0$ fixed by the full
$P$ action. No actual weak-five cover for an auxiliary
group is being presumed; this is the homomorphic action
of the retained original generators.

In all cases a nonzero projective operator line is fixed:
\[
V_gT_eV_g^{-1}=\chi_e(g)T_e.
\]
The scalar defines an honest character of $P$, as projective
scalars cancel in conjugation. If $e$ has order $2^t$, then
$T_e^{2^t}$ is scalar and $\chi_e^{2^t}=1$.
Its image is a prime-to-five quotient of $P$, hence of
$G$, so it is trivial. Thus $T_e$ commutes with the entire
irreducible projective module and is scalar by Schur's
lemma. This contradicts $e\ne0$ in the faithful projective
subgroup $A$. Therefore $P$ has no nontrivial normal
abelian subgroup.

## The socle and almost-simple conclusion

A nontrivial solvable radical would have a last nontrivial
derived subgroup abelian and characteristic in the radical,
hence normal in $P$. Therefore the solvable radical is
trivial. The finite nontrivial group $P$ has socle a direct
product
\[
S=S_1\times\cdots\times S_t
\]
of nonabelian simple groups.

Projective modular Clifford theory applies to this normal
socle: the restricted module has a nonzero socle, preserved
by conjugation by $P$, and thus is semisimple. Its isotypic
components form a block system, so the original no-block
condition makes the restriction isotypic. Write it
$W^{\oplus m}$. If $\dim W,m>1$, the normalized image
algebra gives a prohibited projective tensor decomposition
by Skolem--Noether. If $\dim W=1$, the socle is scalar,
contrary to faithfulness. Hence $m=1$ and $V_8|_S$ is
projectively irreducible.

The projective commutator between two distinct commuting
simple factors is a bicharacter. Perfectness of each simple
factor makes it trivial. Their full matrix images therefore
commute, and the irreducible socle module is a tensor product
of irreducible projective modules for $S_i$. Each factor
has dimension greater than one by faithfulness. Conjugation
by $P$ permutes the factors' matrix algebras exactly as it
permutes the simple socle factors. If $t>1$, this yields a
tensor decomposition preserved with possible factor
permutations, explicitly prohibited by the original input.
Thus $t=1$ and the socle is nonabelian simple.

Its centralizer $C_P(S)$ is normal. If nontrivial, it would
contain a minimal normal subgroup, necessarily contained
in the now simple socle. This is impossible since
$C_P(S)\cap S=Z(S)=1$. Thus $C_P(S)=1$, and conjugation
embeds $P$ between $S$ and $\operatorname{Aut}(S)$.

## Remaining source gap

Both statements treat BOTH original wild types. The earlier separately audited $J_5\oplus J_3$ centralizer-count proof is preserved in its source note; the present binary Scott argument closes the normal-abelian image possibility without that extra type choice. The common original actual-module, carrier and tuple hypotheses remain mandatory.

The simple socle is not classified or realized on an actual curve. The original $G$ may have a nontrivial kernel over $P$. Neither a projective image quotient nor the genuine-four linear or affine quotient is asserted to inherit the original $X$-leg. The exact genuine net class $e_J$, the positive-source lifting obstruction, and an annihilator's Cartier lifting class remain distinct. No marking, scalar-root identification, trace preservation or horizontal original lift is supplied. Both original finite étale endpoint maps remain on their SAME original source, and the unmarked common-cover problem remains open.

## Frozen inputs and review provenance

The source notes and their audits below are preserved unchanged. Pending-review wording in the historical author notes is superseded by the listed independent PASS audit, which binds its exact source hash. The accepted canonical dependencies are used only at the scoped portions stated above. Canonical extraction fidelity is a separate review of the present statement/proof pair.

| Frozen input | SHA256 |
|---|---|
| [solvable_original_eight_source_exclusion.md](../../../Research/notes/oct03_ten_hour/solvable_original_eight_source_exclusion.md) | `1052d8fe4e88fd89a26d4a79ffd72a33760eaea0747d8f48f8d234cd956644e5` |
| [solvable_original_eight_source_exclusion_audit.md](../../../Research/notes/oct03_ten_hour/solvable_original_eight_source_exclusion_audit.md) | `c09dfcfcf4c7bb8be6dc65da17386ba3780dc7697df979b413dd6160fd131771` |
| [canonical_degree_ten_prime_to_five_quotients.md](../../../Theorems/cartier_and_spin/canonical_degree_ten_prime_to_five_quotients.md) | `e9eb0d7b7c471ac98cfb9fafe5eb9135e7369c5634828cf6c84548c0e1684a92` |
| [canonical_degree_ten_prime_to_five_quotients.md](../../../Proofs/cartier_and_spin/canonical_degree_ten_prime_to_five_quotients.md) | `645d460c303e48bffb9b0dc1b0bdb55f825d31292a73eaaa81a7f0f99d704150` |
| [canonical_ten_eight_source_scalar_and_wild_constraints.md](../../../Theorems/quotient_geometry/local_actions/canonical_ten_eight_source_scalar_and_wild_constraints.md) | `1f254a3fe20b5afa9c392dc6ac4f760f972be796e916eb59ed1f8d94151f975b` |
| [canonical_ten_eight_source_scalar_and_wild_constraints.md](../../../Proofs/quotient_geometry/local_actions/canonical_ten_eight_source_scalar_and_wild_constraints.md) | `d7b490e947acde27753089effa2ea3a215237f348c3b8c4dce4255ab373dd589` |
| [canonical_ten_self_dual_four_finite_raynaud_source_choices.md](../../../Theorems/cartier_and_spin/canonical_ten_self_dual_four_finite_raynaud_source_choices.md) | `ab03fbe5c319056d0085ca35318b101980d2b2bf78d155e0049812d85ccebc1c` |
| [canonical_ten_self_dual_four_finite_raynaud_source_choices.md](../../../Proofs/cartier_and_spin/canonical_ten_self_dual_four_finite_raynaud_source_choices.md) | `351fd489c38c433aeda275e7ddd80fa9e34fd471550772624b99399488ad3708` |
| [original_eight_scott_binary_almost_simple_image.md](../../../Research/notes/oct03_ten_hour/original_eight_scott_binary_almost_simple_image.md) | `6929c4dfd30bd5a8c3aae8846e73d33f9d28be5be1485f5f2b4d37b192ec6735` |
| [original_eight_scott_binary_almost_simple_image_audit.md](../../../Research/notes/oct03_ten_hour/original_eight_scott_binary_almost_simple_image_audit.md) | `a335e9117ee86a30fe045d42f0d0e5c23743f107778852cd85cace299f9c2930` |

No mathematical computation was run for this proof or its extraction.
