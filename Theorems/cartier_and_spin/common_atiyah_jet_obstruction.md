# Frobenius direct images and jets of a common simple seed

Version2,3 October2026. Let $k$ be algebraically closed of odd
characteristic $p$, and let $X\leftarrow Z\to Y$ be an actual finite
étale span of smooth projective connected hyperbolic curves with no
clump. Assume $p\nmid g(Y)-1$. Common objects retain the prescribed
identifications on the SAME source, on every relative Frobenius twist.

Let E be any common-simple bundle of rank r prime to p, with a
perfect common omega-valued pairing, symmetric or alternating.
Put H_s=F_*^[s]E on its actual relative twist. Then EVERY H_s
is common-simple. Write epsilon=a(omega),
alpha_s=a(H_s), and gamma_s=id_(H_s) tensor epsilon. One has
\[
\boxed{\quad
F^{[s]*}\varepsilon\ne0,\qquad
\gamma_s\ne0,\qquad
\alpha_s+\alpha_s^\dagger=\gamma_s.
\quad}
\tag{1}
\]
Thus no H_s has a common algebraic connection, although its
rank and endpoint degree are divisible by p for s>0.
At positive height the pulled-back scalar extension
$F^{[s]*}\varepsilon$ splits on each endpoint separately; its
nonzero common class records incompatible gluings.

The same induction gives the exact criterion
\[
\boxed{\quad
J^{\ell-1}H_s\text{ has a common algebraic connection}
\quad\Longleftrightarrow\quad p\mid\ell
\qquad(s\ge0,\ \ell\ge1).
\quad}
\tag{2}
\]
The divisible lengths have their canonical common dormant
connection. No common spin line is assumed.

Taking E=B=F_*O/O, of rank p-1 with its canonical alternating
pairing, recovers all earlier arbitrary-height Cartier assertions
and supplies the simplicity input to the
[higher Cartier filtration theorem](higher_cartier_common_filtration.md).
The result applies to any seed satisfying the stated common
simplicity, rank and pairing hypotheses.

There is a general filtered version. Suppose $E$ is common-simple,
has a perfect common $\omega$-valued self-duality, and
$\gamma_E=\operatorname{id}_E\otimes a(\omega)\ne0$.
Let $V$ have a common filtration with successive graded objects
$E,E\omega,\ldots,E\omega^{\ell-1}$, in that order, with their
specified identifications. A common connection on $V$ forces
\[
\ell a(E)+\frac{\ell(\ell-1)}2\gamma_E=0,
\qquad \ell^2\gamma_E=0.
\tag{3}
\]
Consequently $p\mid\ell$. This uses the full extension and the
comparison on $Z$, not only its endpoint degrees or associated graded.

More generally, for a perfect common $\omega^w$-valued self-duality,
the same calculation gives
\[
\ell(w+\ell-1)\gamma_E=0.
\tag{3a}
\]
The scalar detector also applies to $F_*^{[s]}L$ for ANY common
line bundle $L$: its top grade has rank one. In particular its
scalar Atiyah class remains nonzero.

There is also a one-stage classification for a weighted seed.
Let $E_0$ be common-simple of rank $r$ prime to $p$, with a perfect
common $\omega^w$-valued pairing, symmetric or alternating. Every
nonzero proper common subbundle $V\subset F_*E_0$ has
\[
\operatorname{rk}V=r\ell,\qquad
1\le\ell<p,\qquad \ell\equiv1-w\pmod p,\qquad
F^*V\simeq J^{\ell-1}E_0.
\tag{3b}
\]
If $w\equiv1\pmod p$, $F_*E_0$ is common-simple. Otherwise
there is AT MOST ONE proper nonzero common subbundle. If it exists,
it and the quotient are common-simple and their common extension
is nonsplit. This does not assert its existence or endpoint
nonsplitting. In characteristic5 it makes $F_*\omega^{-2}$ simple
and forces the only possible proper subbundle of $F_*\omega^{-1}$
to have rank3. Arbitrary weighted seeds are covered at this one
stage; the all-height assertion above requires an actual
$\omega$-valued pairing.

For any common vector bundle V and m>=1, the actual jet identity
\[
J^{pm-1}V\simeq F^*J^{m-1}(F_*V)
\tag{4}
\]
gives the canonical connection used in (2). All connections and
identifications commute with both actual endpoint maps.

The height-one/rank20 and two-block argument was returned by Pro.
The prime-to-p seed induction, arbitrary-height scalar detection,
filtered block calculation and exact jet-length criterion are
mathematical extensions; the later general argument replaces the
separate Cartier-height induction. They do not
construct a clump or settle either common-cover candidate.
[Proof](../../Proofs/cartier_and_spin/common_atiyah_jet_obstruction.md).
