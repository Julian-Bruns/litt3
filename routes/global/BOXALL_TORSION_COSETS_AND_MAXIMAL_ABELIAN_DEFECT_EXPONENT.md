# Boxall torsion cosets and the maximal-abelian defect exponent

Date: 2026-09-05.
Authors: `/root` (proposed extension and growth argument) and
`/root/gluing_cohomology_rigidity` (derivation and proof checks).
Status: collaborative author proof; not independently audited.
This is a Boxall-method consequence, not a novelty claim.
The fixed curves and all earlier notes are unchanged.

The finite-field translation lemma used below was independently checked
in [the preceding torsion note](BOXALL_PRUFER_TORSION_AND_EVERY_CYCLIC_TOWER.md#11-the-elementary-finite-field-translation-lemma).
Its source discussion records the accessible primary literature without
claiming a verbatim reading of Boxall's full chapter.

## 1. Full prime-power torsion decomposition

Let \(k=\overline{\mathbf F}_p\), let \(A/k\) be an abelian variety, and
let \(\ell\ne p\) be prime. Write
\[
 T_\ell(A)=A[\ell^\infty](k).
\]
Here this notation denotes the torsion group, not the Tate module.

**Theorem 1.** For every closed subvariety \(D\subset A\), there are
finitely many abelian subvarieties \(B_i\subset A\), including possibly
\(B_i=0\), and points \(t_i\in T_\ell(A)\), such that
\[
 D(k)\cap T_\ell(A)
   =\bigcup_{i=1}^s\bigl(t_i+T_\ell(B_i)\bigr),
 \qquad t_i+B_i\subset D.                                  \tag{1.1}
\]
The union can be empty. For a nonreduced closed subscheme, the statement
concerns its support and its geometric points.

### 1.1. Lifting torsion cosets through a quotient

Let \(S\subset A\) be a reduced closed subgroup, possibly disconnected,
and let \(\pi:A\to A/S\) be the abelian quotient. Over the perfect field
\(k\), the group \(S\) is smooth and \(\pi\) is smooth. Equivalently, first
quotient by the connected abelian subvariety \(S^0\), and then by the
remaining finite étale subgroup.

Every point of an abelian variety over \(k\) is torsion. Consequently any
surjective homomorphism of abelian varieties is surjective on full
\(\ell\)-primary torsion: lift a torsion point and take the
\(\ell\)-primary part of the lift.

Suppose \(\bar t+\bar B\) is a torsion translate of an abelian subvariety
of \(A/S\), with \(\bar t\) \(\ell\)-primary. Choose an \(\ell\)-primary
lift \(t\in A(k)\). The inverse image
\[
 H=\pi^{-1}(\bar B)
\]
is a smooth closed subgroup. Its identity component \(B=H^0\) is an
abelian subvariety, and \(H/B\) is finite étale. The \(\ell\)-primary
points of \(H\) are exactly a finite union of cosets
\[
 \bigcup_j\bigl(h_j+T_\ell(B)\bigr),                       \tag{1.2}
\]
where the \(h_j\) are \(\ell\)-primary lifts of the \(\ell\)-primary
elements of \((H/B)(k)\). Such lifts exist by taking primary parts of
torsion representatives. Thus
\[
 \pi^{-1}\bigl(\bar t+T_\ell(\bar B)\bigr)\cap T_\ell(A)
  =\bigcup_j\bigl(t+h_j+T_\ell(B)\bigr).                  \tag{1.3}
\]
Every corresponding geometric coset \(t+h_j+B\) lies in
\(\pi^{-1}(\bar t+\bar B)\). Components of prime-to-\(\ell\) order in
\(H/B\) do not contribute to (1.2).

### 1.2. Dimension induction

Reduce to irreducible \(D\) and induct on \(\dim D\); dimension zero is
immediate. Let \(S\) be the full reduced translation stabilizer of
\(D\), and put \(\bar D=\pi(D)\). Set-theoretically,
\[
 \pi^{-1}(\bar D)=D.
\]
The reduced translation stabilizer of \(\bar D\) is trivial: a geometric
stabilizing point lifts to a translation preserving \(D\), hence lies
in \(S(k)\). All these objects descend to a finite field.

If \(\dim\bar D<\dim D\), apply induction and then (1.3). If dimensions
are equal, it remains to prove the theorem for \(\bar D\) with trivial
reduced stabilizer; its resulting cosets also lift by (1.3).

We may therefore assume that \(D\) has trivial reduced stabilizer.
Choose a field of definition \(\mathbf F_q\) over which Frobenius \(M\)
acts identically on \(A[\ell]\), and on \(A[4]\) if \(\ell=2\). The
finite-field translation lemma says that, for every
\(P\in T_\ell(A)\setminus A(\mathbf F_q)\), some Frobenius power sends
\(P\) to \(P+T_P\), with \(0\ne T_P\in A[\ell](k)\).
Since \(D\) is defined over \(\mathbf F_q\),
\[
 P\in D\quad\Longrightarrow\quad P\in D\cap(D-T_P).
\]
There are finitely many possible \(T_P\), and every such intersection
has dimension strictly smaller than \(D\). Induction decomposes their
torsion points into finitely many cosets contained in \(D\). The
remaining points in \(D\cap A(\mathbf F_q)\cap T_\ell(A)\) are individual
zero-dimensional cosets. This proves (1.1).

Nonreduced residual stabilizers do not obstruct the argument: a nonzero
geometric \(\ell\)-torsion translation cannot lie in a stabilizer with
trivial reduced subgroup. All containment claims above are statements
about supports.

## 2. The finite Frobenius-stable enlargement

Suppose the set in (1.1) is nonempty and put
\[
 b=\max_i\dim B_i.
\]
Each \(T_\ell(B_i)\) is Zariski dense in \(B_i\), so \(b\) is also the
dimension of the Zariski closure of \(D(k)\cap T_\ell(A)\); it does not
depend on the chosen finite decomposition. For example, density follows
by quotienting by the reduced closure of the torsion subgroup: a
positive-dimensional quotient would have nonzero \(\ell\)-primary
torsion, contradicting surjectivity on that torsion.

Let \(e_i\ge1\) be such that \([p]^{e_i}t_i=t_i\), and put
\[
 \Sigma=\bigcup_i\ \bigcup_{j=0}^{e_i-1}
       \bigl([p]^jt_i+T_\ell(B_i)\bigr),
 \qquad R=\sum_i e_i.                                     \tag{2.1}
\]
This is a finite union: every \(t_i\) has finite order prime to \(p\).
Multiplication by \(p\) permutes \(\Sigma\), since it permutes
\(T_\ell(B_i)\). In particular,
\[
 \#\bigl(\Sigma\cap A[\ell^n](k)\bigr)
    \le R\ell^{2bn}.                                     \tag{2.2}
\]
Indeed a nonempty intersection of one torsion coset with \(A[\ell^n]\)
is a coset of \(B_i[\ell^n]\). Once \(\ell^n\) kills a translation \(t_i\)
with \(\dim B_i=b\), one also has
\[
 \#\bigl(D(k)\cap A[\ell^n](k)\bigr)\ge\ell^{2bn}.        \tag{2.3}
\]
No invariance under arithmetic Frobenius is asserted or needed for
\(\Sigma\). The operation in (2.1) is scalar multiplication by \(p\).

## 3. Exact growth exponent in the maximal abelian tower

Let \(C/k\) be a smooth proper connected curve of genus \(g\ge2\).
Let \(C_n\to C\) be its connected maximal abelian exponent-\(\ell^n\)
étale cover, of degree \(\ell^{2gn}\). Choosing compatible geometric
base points makes these an actual nested tower. Put
\[
 A=J(C^{(1)}),\qquad
 \mathcal B_C=F_{C/k*}\mathcal O_C/\mathcal O_{C^{(1)}},
 \qquad D=\Theta_{\mathcal B_C}.
\]
Raynaud's theta theorem, and the relative-Frobenius character criterion,
are the inputs recorded in
[the earlier exact criterion](CYCLIC_TOWER_NEW_ORDINARITY_AND_FIXED_SUPPORT_BOUNDARY.md#2-exact-criterion-for-a-specified-cyclic-tower).
In particular \(D\) is a proper effective divisor and
\(L\in D\) exactly when \(H^0(\mathcal B_C\otimes L)\ne0\).

Write \(\Delta_n=g(C_n)-f(C_n)\). If
\(D(k)\cap T_\ell(A)=\varnothing\), then every \(C_n\) is ordinary.
Otherwise use Theorem 1 and define \(b,R\) as in Section 2.

**Theorem 2.** For all sufficiently large \(n\),
\[
 \ell^{2bn}\ \le\ \Delta_n\ \le\ gR\ell^{2bn}.            \tag{3.1}
\]
Consequently,
\[
 \Delta_n=\Theta(\ell^{2bn}),\qquad
 \lim_{n\to\infty}\frac{\log_\ell\Delta_n}{n}=2b,
 \qquad 0\le b\le g-1.                                   \tag{3.2}
\]
In particular \(b=0\) is exactly the bounded-defect case when the torsion
intersection is nonempty. The bounded integer sequence is then eventually
constant, and all sufficiently late new Jacobian factors are ordinary.

### Proof, including the whole nilpotent part

Character decomposition for the prime-to-\(p\) abelian cover gives
one eigenspace of dimension at most \(g\) for each point of
\(A[\ell^n](k)\). Nontrivial character spaces have dimension \(g-1\);
the trivial space has dimension \(g\).

Here is precise twist bookkeeping. If \(N_\chi\) is the character line
bundle on \(C\), label its cohomology eigenspace by
\(L=N_\chi^{(1)}\in J(C^{(1)})[\ell^n]\). All these labels occur.
Transporting a cover from \(C^{(1)}\) to \(C\) changes these labels by
multiplication by \(p\), since
\((F_{C/k}^*L)^{(1)}=L^p\); hence each prime-to-\(p\) character subgroup
is unchanged as a set.
Absolute Frobenius is semilinear and sends the \(\chi\)-eigenspace to
the \(\chi^p\)-eigenspace; in these labels this is \(L\mapsto L^p\).
The relative Frobenius sequence identifies its kernel on the source
space labelled \(L\) with, up to the scalar twist,
\[
 H^0(C^{(1)},\mathcal B_C\otimes L).                       \tag{3.3}
\]
Explicitly, tensor the Frobenius sequence by \(L\) to obtain
\(0\to L\to F_{C/k*}F_{C/k}^*L\to\mathcal B_C\otimes L\to0\),
and use \(F_{C/k}^*N_\chi^{(1)}=N_\chi^p\).
For nontrivial \(L\), the two preceding degree-zero section spaces
vanish. For \(L=\mathcal O\), the map on constant sections is an
isomorphism, so (3.3) holds there as well.

Since multiplication by \(p\) permutes
\(\Sigma\cap A[\ell^n]\), its complement is Frobenius-stable. On that
complement (3.3) vanishes, and Frobenius is injective, hence bijective.
Thus the entire Frobenius-nilpotent subspace is supported in the
\(\Sigma\)-block, not merely its first kernel. Its dimension is
\(\Delta_n\), giving
\[
 \Delta_n\le g\#(\Sigma\cap A[\ell^n])\le gR\ell^{2bn}.
\]
On the other hand, projection formula and étale pullback for
\(\mathcal B\) give
\[
 \begin{split}
 a(C_n)
 &=h^0(C_n^{(1)},\mathcal B_{C_n})\\
 &=\sum_{L\in A[\ell^n](k)}
       h^0(C^{(1)},\mathcal B_C\otimes L)\\
 &\ge\#(D(k)\cap A[\ell^n](k)).
 \end{split}
\]
Since \(\Delta_n\ge a(C_n)\), (2.3) proves the lower bound. The remaining
claims follow from additivity of dimension and \(p\)-rank under isogeny
and the inclusion of each old Jacobian in the next one up to isogeny.

The upper and lower bounds prove an exponent, not convergence of
\(\Delta_n/\ell^{2bn}\) or an eventual exact polynomial formula.

## 4. Prescribed finite-rank abelian directions

Let \(\Gamma\subset T_\ell(A)\) be a divisible subgroup isomorphic to
\((\mathbf Q_\ell/\mathbf Z_\ell)^r\), with \(1\le r\le2g\). The groups
\(\Gamma_n=\Gamma[\ell^n]\) define a prescribed connected
\(\mathbf Z_\ell^r\)-tower of actual étale covers of \(C\).

For each coset in (1.1) meeting \(\Gamma\), choose
\(\gamma_i\in\Gamma\cap(t_i+B_i)\). Then
\[
 \Gamma\cap(t_i+T_\ell(B_i))=\gamma_i+H_i,\qquad
 H_i=\Gamma\cap T_\ell(B_i).
\]
There are decompositions of abstract groups
\[
 H_i\simeq(\mathbf Q_\ell/\mathbf Z_\ell)^{s_i}\oplus F_i,
 \qquad F_i\text{ a finite }\ell\text{-group}.             \tag{4.1}
\]
To see this directly, express the homomorphism
\(\Gamma\to T_\ell(A/B_i)\) by its matrix over \(\mathbf Z_\ell\), using
the corresponding Tate modules. Smith normal form gives (4.1) for its
kernel. In particular, for all sufficiently large \(n\),
\[
 \#H_i[\ell^n]=|F_i|\ell^{s_i n}.                         \tag{4.2}
\]
Its divisible rank is
\[
 s_i=\dim_{\mathbf Q_\ell}(U_\Gamma\cap V_\ell B_i),
\]
where \(U_\Gamma\) is the rank-\(r\) rational Tate subspace defining
\(\Gamma\), and \(V_\ell B_i\subset V_\ell A\) has dimension
\(2\dim B_i\).

**Corollary 3.** If \(D\cap\Gamma\) is empty, every level is ordinary.
Otherwise, for
\[
 s=\max_{i:\,(t_i+B_i)\cap\Gamma\ne\varnothing}s_i,
\]
the defect in this prescribed tower satisfies
\[
 \Delta(C_{\Gamma,n})=\Theta(\ell^{sn}),\qquad
 \lim_{n\to\infty}\frac{\log_\ell\Delta(C_{\Gamma,n})}{n}=s. \tag{4.3}
\]
Indeed, after \(\ell^n\) kills \(\gamma_i\), the intersection with
\(\Gamma_n\) is a coset of \(H_i[\ell^n]\). Multiplication by \(p\)
preserves \(\Gamma\), so its finite orbit enlargement from (2.1) has
the same maximal exponent \(s\). Applying the upper nilpotent-support
bound and the lower a-number bound from Section 3 proves (4.3).

For Haar-generic rank-\(r\) rational Tate subspaces one simultaneously
has, for every \(i\),
\[
 \dim(U_\Gamma\cap V_\ell B_i)
   =\max(0,r+2\dim B_i-2g).                               \tag{4.4}
\]
This is just transversality to finitely many fixed subspaces: each
exception is a proper Schubert locus, of measure zero in the
\(\ell\)-adic Grassmannian. Equation (4.4) alone does not assert that a
particular translated coset meets \(\Gamma\).

Since \(\dim B_i\le g-1\), every curve \(C/k\), ordinary or not, has
bounded defect along Haar-generic rank-one and rank-two abelian
directions. For a fixed ordinary \(C\), every rank-one direction has
bounded defect: if an intersected coset had \(s_i=1\), then
\(H_i=\Gamma\), since every proper subgroup of a rank-one Prüfer group
is finite. That coset would contain \(\Gamma\), including zero,
contrary to \(0\notin D\). The constants are not asserted to be uniform
among directions, nor is there an arithmetic-Frobenius invariance
requirement on the direction.

## 5. Direct actual-base-change version and scope

Fix an actual finite étale map \(Z\to C\), with no Galois assumption.
In \(A=J(C^{(1)})\), replace \(D\) by the closed locus
\[
 D_Z=\{L:\ H^0(Z^{(1)},\mathcal B_Z\otimes L|_{Z^{(1)}})\ne0\}.
\]
Apply Theorem 1 to this locus, which may be all of \(A\). The same proof
gives, for the full fiber products \(Z\times_C C_n\), a total defect
\(\Theta(\ell^{2bn})\) when their bad torsion set is nonempty, with
upper constant \(g(Z)R\); if the set is empty, all components are ordinary.
Here total defect means the sum of genus minus \(p\)-rank over the
connected components.

The deck group acts transitively on these components. Their number is
bounded and eventually constant, since the fields
\(k(Z)\cap k(C_n)\) stabilize inside the fixed finite extension
\(k(Z)/k(C)\). Therefore every compatible connected-component tower has
the same growth exponent. This retains the actual maps to both \(Z\)
and \(C_n\); it does not replace them by hypothetical character data.

For a geometrically simple \(J(C)\), a proper \(D_Z\) has \(b=0\).
For general \(J(C)\), translated positive-dimensional abelian
subvarieties in \(D_Z\) give the precise possible growth exponents.
No statement here controls nonabelian towers, or isolates the growth of
one prescribed nonordinary simple isogeny factor from the total defect.
