# Genus two: bounded Raynaud monodromy excludes actual common covers

Date: 2026-09-05.

Status: collaborative author proof, root and gluing_cohomology_rigidity;
not independently audited. The cited positive Raynaud proofs were read,
including their monodromy and node-inertia steps. This is an application
of published generic ordinarity, not a new generic ordinarity theorem.

This note constructs auxiliary genus-two curves. It makes no claim about
the fixed genus-25 curve of file 76, and requires no common orbifold.

## 1. The group classes and the theorem

Fix an algebraically closed field \(k\) of characteristic \(p>2\).
Call a finite group \(Q\) admissible if \(p\nmid |Q|\) and either:

1. \(Q\) has an abelian normal subgroup with cyclic quotient; or
2. \(Q\) has odd order and nilpotency class at most two.

The second condition equivalently says that \(Q\) is a central extension
of two finite abelian groups, with odd order. The trivial group is allowed.

**Theorem.** For every integer \(B\ge1\), there is a nonempty
Zariski-open substack
\[
               \mathcal U_B\subset\mathcal M_{2,k}=\mathcal H_{2,k}
\]
such that every connected Galois étale cover of every geometric
\(Y\in\mathcal U_B\), with admissible group \(Q\) of order at most \(B\),
is ordinary.

More generally, let \(W\to Y\) be connected Galois étale with group \(G\).
If its \(p\)-Sylow subgroup \(P\) is normal and \(Q=G/P\) is admissible
with \(|Q|\le B\), then \(W\) is ordinary. There is no bound on \(|P|\).

Consequently, for every nonordinary smooth proper connected curve \(X/k\),
there is no actual correspondence
\[
                      X\longleftarrow Z\longrightarrow Y
\]
with both arrows finite étale and with the Galois closure of the
\(Y\)-leg satisfying that group condition.
The \(Y\)-leg itself need not be Galois; the correspondence need not
have a core.

The open has dimension three. Over \(\overline{\mathbf F}_p\) it contains
curves defined over finite extensions of \(\mathbf F_p\), outside any
prescribed finite set of geometric isomorphism classes.

## 2. Exact published generic input

Michel Raynaud, *Revêtements des courbes en caractéristique p > 0 et
ordinarité*, Compositio Math. 123 (2000), 73–88,
[primary PDF](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/16AB72912D3CE32BFC5D012B1025A8E4/S0010437X00000440a.pdf/revetements-des-courbes-en-caracteristique-pandgt0-et-ordinarite.pdf).

Corollary 8, p. 77, proves generic ordinarity for abelian-by-cyclic groups
with prime-to-\(p\) cyclic quotient. Theorem 14, pp. 82–83, proves it
for central extensions of two abelian groups whose order is prime to
\(g!\). At genus two the latter restriction is exactly odd order.
Both statements concern the geometric generic curve of full moduli.
Since \(\mathcal H_2=\mathcal M_2\), no transfer to a smaller locus is needed.

Proof checkpoints: Proposition 6 moves a nondegenerate rank-two abelian
quotient to an elliptic tail, keeping its intermediate degeneration of
compact type. The abelian upper cover then extends étale. For Theorem 14,
Corollary 11 and Lemma 12 find a symplectic pair with trivial commutator;
Proposition 13 and Lemma 15 kill node inertia after monodromy transport.
The normalized components are handled inductively. In genus two they
are covers of ordinary elliptic curves.

These are the only generic ordinarity inputs used below. In particular
the theorem is not asserted for every solvable group.

## 3. Why a fixed finite group list gives an actual nonempty open

Here is a spreading argument that does not assume a Hurwitz space is
finite étale without accounting for its automorphisms.

Let \(\mathscr Q\) be a finite list of prime-to-\(p\) groups for which all
covers of the geometric generic genus-two curve are ordinary. Include the
trivial group. Work on a connected fine level-four moduli scheme \(S\)
over \(\mathcal M_2\), with its universal smooth proper curve
\(\mathcal C\to S\). The chosen component maps finite étale and
surjectively to \(\mathcal M_2\); \(S\) is integral and normal.
Let \(K=k(S)\).

There are finitely many connected \(Q\)-torsors on
\(\mathcal C_{\overline K}\), for each \(Q\in\mathscr Q\).
Indeed its prime-to-\(p\) fundamental group has four topological
generators, so there are at most \(|Q|^4\) homomorphisms to \(Q\);
surjectivity and conjugacy only reduce the number.
Choose representatives of every isomorphism class for every group.
Their sources are ordinary by the generic input.

All these finitely many covers, with their group actions, descend
simultaneously to a finite separable extension \(K'/K\).
To remove any inseparability issue, first descend from \(\overline K\)
to \(K^{\mathrm{sep}}\) using invariance of finite étale covers under
purely inseparable extension, then use finite presentation.

Normalize \(S\) in \(K'\). After shrinking a nonempty open \(S_1\subset S\),
the normalization \(S'\to S_1\) is finite étale and surjective, and all
the covers extend as finite étale torsors
\[
                         \mathcal W_i\longrightarrow\mathcal C_{S'} .
\]
Shrink \(S_1\) once more so their fibers are geometrically connected,
always replacing \(S'\) by its full inverse image. Such simultaneous
shrinking is possible by removing finite images of the finitely many
closed bad loci upstairs. Thus \(S'\to S_1\) remains finite étale and
surjective. The sources are smooth and proper over \(S'\).

For **every** geometric point \(s\) of \(S'\), these specializations
exhaust the \(Q\)-torsors on \(\mathcal C_s\), for every \(Q\in\mathscr Q\).
The reason is smooth-proper prime-to-\(p\) specialization:
\[
          \pi_1(\mathcal C_{\overline K'})^{(p')}
                        \simeq \pi_1(\mathcal C_s)^{(p')}.
\]
This identifies \(Q\)-torsors, and does so compatibly with the torsors
already spread over \(S'\). Thus no unlisted prime-to-\(p\) cover appears
on a special fiber. This is the step for which prime-to-\(p\) group order,
not merely bounded degree, is essential.

For precise base-change statements, see the Stacks Project,
[Theorem 58.30.3](https://stacks.math.columbia.edu/tag/0BUQ)
and the descent lemmas cited in its proof. The proof of that theorem
uses tame ramification and purity; it does not assert constancy of
arbitrary \(p\)-divisible monodromy.

For each family \(\mathcal W_i/S'\), failure of ordinarity is closed:
it is the vanishing locus of the determinant of the linearized
Frobenius on \(R^1(\mathcal W_i/S')_*\mathcal O_{\mathcal W_i}\).
The union of these finitely many closed loci avoids the generic point.
Its image in \(S_1\) is closed, since \(S'\to S_1\) is finite, and is
proper. Its complement \(S_2\) is a nonempty open on which all the
required covers are ordinary.

The image of \(S_2\) in \(\mathcal M_2\) is open, since the level map
is étale. The condition is intrinsic to the geometric curve, so this
image has the asserted property. Irreducibility and dimension of
\(\mathcal M_2\) give dimension three.

This argument keeps all covers separately. It does not assume their
compositum is ordinary or that its Galois group remains in the chosen
class.

Apply it to the finite list of admissible groups of order at most \(B\)
to prove the first assertion of the theorem.

## 4. Exponent bounds suffice; no restricted Burnside theorem is needed

Fix \(N\ge1\) with \(p\nmid N\). There is a nonempty open
\(\mathcal U^{\mathrm{exp}}_N\subset\mathcal M_2\) with the same
conclusion whenever the admissible quotient \(Q\) has exponent dividing
\(N\), without separately specifying its order.

Only four-generated groups need be considered: every prime-to-\(p\)
quotient of a genus-two fundamental group is four-generated.
The following elementary bounds therefore give a finite group list.

**Class-two case.** If \(Q\) is generated by \(x_1,\ldots,x_4\),
has class at most two and exponent dividing \(N\), then
\(Q/[Q,Q]\) has order at most \(N^4\), while \([Q,Q]\) is generated by
the six central commutators \([x_i,x_j]\), each of order dividing \(N\).
Hence
\[
                            |Q|\le N^{10}.
\]
Odd order is still required for application of Raynaud.

**Abelian-by-cyclic case.** Let \(A\triangleleft Q\) be abelian and
let \(Q/A\) be cyclic of order \(c\). Then \(c\mid N\).
Schreier's generator bound gives
\[
               d(A)\le 1+c(4-1)=3c+1.
\]
Since \(A\) is abelian of exponent dividing \(N\),
\[
                  |Q|=c|A|
                       \le cN^{3c+1}
                       \le N^{3N+2}.
\]
These bounds are deliberately not claimed optimal.

For \(N\ge2\), take
\[
                       B_N=N^{\max(10,\,3N+2)}.
\]
For \(N=1\), take \(B_1=1\).
The preceding theorem with \(B=B_N\) proves the exponent formulation.
An unbounded normal \(p\)-Sylow may still be placed above this bounded
prime-to-\(p\) quotient.

## 5. The unbounded normal \(p\)-Sylow and the same common source

Let \(P\triangleleft G\) be a \(p\)-Sylow. The quotient
\(V=W/P\to Y\) is connected Galois étale with group \(Q=G/P\);
hence \(V\) is ordinary by the bounded condition.
The map \(W\to V\) is Galois étale of \(p\)-power degree.
The Deuring–Shafarevich and Riemann–Hurwitz formulas give
\[
             f_W-1=|P|(f_V-1),\qquad
             g_W-1=|P|(g_V-1),
\]
so \(f_W=g_W\).
Equivalently, apply Crew, *Etale p-covers in characteristic p*,
Corollary 1.8.3, pp. 36–37
([primary PDF](https://www.numdam.org/item/CM_1984__52_1_31_0.pdf)).

Now start with the actual common source \(Z\).
Its finite étale Galois closure over \(Y\) is again a smooth proper
curve \(W\), and \(W\to Z\to X\) is still finite étale.
If \(X\) is nonordinary, Cartier on its holomorphic differentials has
nonzero kernel. Choose a nonzero differential in that kernel.
Its pullback to \(W\) is nonzero by separability, remains holomorphic,
and is Cartier-zero by functoriality. Thus \(W\) cannot be ordinary.
This is the required contradiction.

No map is reconstructed after passing to a smaller unrelated curve.
The given \(Y\)-leg, its genuine Galois closure, and the map to the same
\(X\) are retained throughout.

## 6. Scope and a genuinely nonabelian enlargement

For \(p=5\), the exponent-four version includes the dihedral group of
order eight: its rotation subgroup is abelian and its quotient is
cyclic. Thus it controls normal \(5\)-Sylow extensions with a nonabelian
prime-to-five quotient, beyond the earlier abelian-quotient corollary.

The dihedral quotient is compatible with an actual genus-two étale
cover: in the presentation
\(\langle a_1,b_1,a_2,b_2\mid[a_1,b_1][a_2,b_2]=1\rangle\),
send both \(a_i\) to a rotation \(r\) of order four and both \(b_i\)
to a reflection \(s\). Each commutator is \(r^2\), so the relation holds,
and the map is surjective. The prime-to-five surface-group
presentation gives the corresponding étale cover.

For a genus-nine target \(X\), Riemann–Hurwitz independently requires
eight to divide the degree of \(W\to Y\). Odd-order quotients with a
normal \(5\)-Sylow already fail that elementary test; the theorem does
not claim an additional fixed-\(X\) obstruction in those vacuous cases.
Even-order abelian-by-cyclic quotients such as this dihedral group do
not have that problem.

Finally, the theorem does not control arbitrary solvable groups,
nonnormal \(p\)-Sylows, or unbounded prime-to-\(p\) exponents.
It supplies no ordinarity certificate for a prescribed curve.
Its finite-field points may be chosen outside any finite set because a
nonempty three-dimensional open cannot be exhausted by that set.
