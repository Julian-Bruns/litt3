# Exact Frobenius descent of a self-correspondence

## Status and purpose

**Status: proved.**  This note determines exactly what finite-field descent
does to the commensuration attached to a self-correspondence of

\[
 S=\mathbf P^1_{\overline{\mathbf F}_5}(31,31,31).
\]

The result is weaker than saying that one element of the abstract
commensurator commutes with Frobenius.  What is canonical is a left-right
inner double coset in the abstract commensurator, and that double coset is
Frobenius-periodic.  More precisely, before passing to geometric fundamental
groups, one has an isomorphism between two open subgroups of the *arithmetic*
fundamental group over the Galois group of a finite field.

This distinction matters: the finite-field anabelian theorems recover the
isomorphism between the two source covers.  They do not extend it to an
automorphism of the target.  Such an extension is precisely the visibility
statement that remains to be proved.

## 1. The exact arithmetic statement

Let

\[
                 u,v:\mathcal T\rightrightarrows S                 \tag{25.1}
\]

be a connected representable finite etale self-correspondence.  Put

\[
 G=\pi _1^{\mathrm{et}}(S),\qquad
 H=\pi _1^{\mathrm{et}}(\mathcal T),
\]

and denote the two open embeddings, after choices of base points and paths,
by

\[
                         i,j:H\hookrightarrow G.                    \tag{25.2}
\]

They define the virtual automorphism

\[
       \theta=j i^{-1}:i(H)\buildrel\sim\over\longrightarrow j(H). \tag{25.3}
\]

### Theorem 25.1 (arithmetic extension and the two Frobenius cocycles)

There is an integer \(m\geq1\) and a model

\[
 u_m,v_m:\mathcal T_m\rightrightarrows S_m
\]

over \(\mathbf F_q\), \(q=5^m\), whose geometric fiber is (25.1).  Write

\[
 \Pi=\pi _1^{\mathrm{et}}(S_m),\qquad
 \Pi_T=\pi _1^{\mathrm{et}}(\mathcal T_m).
\]

After choices of base points and paths, the maps give open embeddings over
\(G_{\mathbf F_q}\):

\[
 \widetilde i,\widetilde j:\Pi_T\hookrightarrow\Pi,
 \qquad
 \operatorname{pr}\widetilde i
 =\operatorname{pr}_T
 =\operatorname{pr}\widetilde j.                                  \tag{25.4}
\]

Consequently

\[
 \widetilde\theta
 =\widetilde j\widetilde i^{-1}:
 \widetilde i(\Pi_T)\buildrel\sim\over\longrightarrow
 \widetilde j(\Pi_T)                                                \tag{25.5}
\]

is an isomorphism of open subgroups of \(\Pi\) inducing the identity on
\(G_{\mathbf F_q}\), and its restriction to the geometric kernels is
\(\theta\).

More explicitly, choose \(\tau\in\Pi_T\) above the arithmetic Frobenius and
put

\[
                         a=\widetilde i(\tau),\qquad
                         b=\widetilde j(\tau).
\]

Then, as isomorphisms between the appropriate open subgroups of \(G\),

\[
                         \theta\,c_a=c_b\,\theta.                   \tag{25.6}
\]

If \(F\in\Pi\) is any fixed lift of the same Frobenius and

\[
                         a=g_uF,\qquad b=g_vF
                         \quad(g_u,g_v\in G),
\]

then

\[
 c_F\theta c_F^{-1}=c_{g_v}^{-1}\theta c_{g_u}.                    \tag{25.7}
\]

Regarding \(\theta\) as an element \([\theta]\) of the abstract commensurator
\(\operatorname {Comm}(G)\), Frobenius therefore fixes only the double coset

\[
 \operatorname {Inn}(G)[\theta]\operatorname {Inn}(G)
 \ \in\ 
 \operatorname {Inn}(G)\backslash\operatorname {Comm}(G)/
 \operatorname {Inn}(G).                                         \tag{25.7a}
\]

In particular, finite descent does **not** by itself give

\[
                         c_F\theta c_F^{-1}=\theta.                 \tag{25.8}
\]

#### Proof

The stacks and maps in (25.1) are of finite presentation over
\(\overline{\mathbf F}_5\).  All their defining data therefore descend to a
finite subfield; enlarging it preserves geometric connectedness and supplies
the stated \(\mathbf F_q\)-model.

The homotopy exact sequences for the two geometrically connected stacks are

\[
 1\longrightarrow G\longrightarrow\Pi
  \longrightarrow G_{\mathbf F_q}\longrightarrow1,
 \qquad
 1\longrightarrow H\longrightarrow\Pi_T
  \longrightarrow G_{\mathbf F_q}\longrightarrow1.                \tag{25.9}
\]

A representable connected finite etale map induces an open embedding of
fundamental groups.  Geometric paths from the two images of the source base
point to the chosen target base point give (25.4); changing either path only
conjugates the corresponding embedding by an element of \(G\).  Formula
(25.5) and its compatibility with the quotient in (25.9) are immediate.

For \(h\in H\), calculate

\[
\begin{aligned}
 \theta\bigl(a\,i(h)\,a^{-1}\bigr)
 &=\theta\bigl(i(\tau h\tau^{-1})\bigr)\\
 &=j(\tau h\tau^{-1})\\
 &=b\,j(h)\,b^{-1}.
\end{aligned}
\]

This is (25.6).  Since \(a\) and \(b\) have the same image as \(F\) in
\(G_{\mathbf F_q}\), the displayed elements \(g_u,g_v\in G\) exist.  Substituting
\(c_a=c_{g_u}c_F\) and \(c_b=c_{g_v}c_F\) into (25.6) and rearranging gives
(25.7).

If the two target paths are changed by \(\alpha,\beta\in G\), then the new
commensuration is \(c_\beta[\theta]c_\alpha^{-1}\).  Changing \(F\) does the
same to its Frobenius transform.  Hence (25.7a) is intrinsic and fixed by
\(q\)-Frobenius (equivalently, it is periodic under \(5\)-Frobenius), whereas
an equality such as (25.8) requires the two path cocycles to be simultaneously
trivialized.  Nothing in finite descent does this. \(\square\)

### Corollary 25.2 (the core tower is Frobenius-stable, not forced to stop)

Let \(L_n\) be the core tower of Theorem 21.2.  Conjugation by \(\tau\)
preserves every \(L_n\).

#### Proof

This is induction on \(n\).  It is clear for \(L_0=H\).  If \(L_n\) is
preserved by \(c_\tau\), then \(i(L_n)\) and \(j(L_n)\) are preserved by
\(c_a\) and \(c_b\), respectively.  Both \(a\) and \(b\) normalize \(G\), so
conjugation by them preserves the corresponding normal cores in \(G\).
Taking the two inverse images and their intersection proves the induction
step. \(\square\)

This stability supplies no descending-chain condition.  For example,
\(\mathbf Z_5\supset5\mathbf Z_5\supset5^2\mathbf Z_5\supset\cdots\) is an
infinite chain of characteristic open subgroups.  A theorem particular to
the geometric core tower is still required.

### Proposition 25.3 (arithmetic virtual isomorphisms need not be global)

There are a finite field \(k_0\) of characteristic \(5\), smooth projective
geometrically connected curves \(C,X\) over \(k_0\), of genera \(7,4\), and
degree-two finite etale maps

\[
                            u,v:C\rightrightarrows X                 \tag{25.10}
\]

such that the arithmetic virtual isomorphism furnished by Theorem 25.1 is
not the restriction of an automorphism of \(X_{\overline{k}_0}\).

#### Proof

Start with a smooth projective genus-two curve \(B\) over
\(\overline{\mathbf F}_5\).  By SGA 1, Expose XIII, Corollaire 2.12, the
maximal prime-to-\(5\) quotient of its geometric fundamental group is the
prime-to-\(5\) completion of the genus-two surface group.  The latter
surjects onto \(S_3\): in the usual presentation,
send two of the \(a\)-generators to a transposition and a three-cycle and send
the \(b\)-generators to the identity.  Thus there is a connected finite
etale \(S_3\)-Galois cover \(C\to B\).  All of this data descends to a finite
extension \(k_0/\mathbf F_5\).

Let \(A\leq S_3\) be generated by a transposition and choose
\(\gamma\in S_3\setminus N_{S_3}(A)\).  Put

\[
                  X=C/A,\qquad u:C\longrightarrow X,
                  \qquad v=u\circ\gamma .                          \tag{25.11}
\]

After enlarging \(k_0\), all the maps and automorphisms in (25.11) are
defined over \(k_0\).  The action is free, so \(u\) and \(v\) are finite
etale of degree two.  Riemann--Hurwitz gives

\[
             g(C)-1=6(g(B)-1)=6,\qquad
             g(C)-1=2(g(X)-1),
\]

hence \(g(C)=7\) and \(g(X)=4\).

If an automorphism \(\sigma\) of \(X_{\overline{k}_0}\) satisfied
\(v=\sigma u\), then \(v\) would be invariant under every deck
transformation in \(A\).  For \(a\in A\), this would give

\[
              u\gamma a=v a=v=u\gamma,
\]

so \(\gamma a\gamma^{-1}\) would be a deck transformation of
\(u:C\to C/A\), hence an element of \(A\).  Therefore \(\gamma\) would
normalize \(A\), contrary to its choice.

If the associated virtual isomorphism were the restriction of a global
arithmetic outer automorphism, restrict farther if necessary to an open
subgroup on which the representatives agree.  The finite-field Isom theorem
would identify the resulting maps on the corresponding finite etale cover
\(D\to C\), giving \(vp=\sigma up\) for some automorphism \(\sigma\) of
\(X\).  Faithfully flat descent along \(p\) would give \(v=\sigma u\), which
was just excluded. \(\square\)

This example does not decide the special triangle orbifold \(S\).  It does
show decisively that neither finite-field descent, Frobenius periodicity of
the double class, nor the arithmetic Isom theorem can imply a
virtual-to-global extension in general.  Any extension result for \(S\) must
use its special triangle-orbifold structure.

## 2. Why the finite-field anabelian theorem does not give visibility

The issue can already be seen for schemes.  Let \(X/\mathbf F_q\) be a
hyperbolic curve and \(\Pi_X=\pi _1^{\mathrm{et}}(X)\).  A diagram

\[
 X\longleftarrow X_1\buildrel\alpha\over\longrightarrow X_2
 \longrightarrow X,                                                \tag{25.12}
\]

where the outside maps are connected finite etale covers and \(\alpha\) is
an \(\mathbf F_q\)-isomorphism, gives an outer isomorphism over
\(G_{\mathbf F_q}\) between two open subgroups of \(\Pi_X\).  Conversely, the
Tamagawa--Mochizuki isomorphism theorem, applied to the two covers, recovers
\(\alpha\) from such an arithmetic open-subgroup isomorphism.

It does **not** say that \(\alpha\) extends across (25.12) to an automorphism
of \(X\).  Indeed, extension to an automorphism \(\sigma\) of \(X\) is exactly
the additional equation

\[
                    p_2\alpha=\sigma p_1.                          \tag{25.13}
\]

On fundamental groups, (25.13) says precisely that the virtual
open-subgroup isomorphism is the restriction of the global automorphism
\(\sigma_*\) of \(\Pi_X\).  Thus the relevant anabelian theorem reconstructs
the *source isomorphism* in a correspondence; it contains no virtual-to-global
extension assertion.

The cited theorems concern curve schemes, not orbicurves.  This does not make
them stronger in the present problem.  After a further finite extension, take
a connected finite etale scheme cover \(W\to\mathcal T_m\); one may obtain one
by pulling back a finite etale scheme cover of \(S_m\), and then taking a
connected component.  Restriction of (25.5) to \(\pi_1(W)\) is induced by the
identity of the same curve \(W\), viewed through its two maps to \(S_m\).
The scheme Isom theorem recovers this source isomorphism.  It still supplies
no automorphism of the orbifold target.

Thus, even granting a direct orbifold analogue, applying an Isom theorem to
(25.5) could recover only the already given source \(\mathcal T_m\).  To deduce
visibility one would need the new relative commensurator statement

> every arithmetic virtual isomorphism arising from a self-correspondence of
> \(S\) is the restriction of one of the six automorphisms in \(S_3\).

By the visibility equivalence already established in the global route, this
statement is not a weaker anabelian input: it is another formulation of the
remaining visibility theorem.

Even the stronger, noncanonical equality (25.8) would not by itself invoke a
published Isom theorem.  Those theorems classify global arithmetic outer
isomorphisms.  They do not identify the centralizer of Frobenius inside the
abstract commensurator, whose elements are defined only on open subgroups.

## 3. The prime-to-five theorem has the same limitation

Saidi--Tamagawa prove the Isom theorem after replacing the geometric kernel
by its maximal pro-prime-to-\(p\) quotient.  Their hypothesis is an
isomorphism of the resulting **arithmetic** groups, not merely an abstract
isomorphism of geometric pro-prime-to-\(p\) groups.  Applied to open
subgroups, the conclusion is again the isomorphism of the two source curves,
not its extension to the target.

Likewise, even under a monodromy hypothesis strong enough to transport each
leg individually through a prime-to-\(5\) specialization equivalence, one does
not obtain an identification of the two characteristic-zero source curves.
Such an identification is exactly a simultaneous lift of the correspondence,
the sufficient hypothesis already isolated in file 12.  Merely assuming that
the two numerical covering degrees are prime to \(5\) is weaker still: the
Galois closure of a cover of prime-to-\(5\) degree can have order divisible by
\(5\).

The weak Hom theorem over \(\overline{\mathbf F}_p\) also does not supply the
missing extension.  Yang's Theorem 0.3 for curves of type \((0,n)\) detects
only whether the set of open homomorphisms between two tame fundamental
groups is nonempty and concludes that their minimal models are isomorphic.
It neither reconstructs a given open homomorphism nor says that it extends to
an ambient automorphism.  Yang explicitly notes in Remark 0.1.1 that the
naive Hom version for tame fundamental groups is false because of
specialization homomorphisms.

## 4. Exact remaining target

Finite-field descent therefore gives the following useful but non-closing
replacement for the informal phrase “Frobenius-periodic commensuration”:

\[
\boxed{\text{an arithmetic virtual isomorphism (25.5), which in particular
implies the Frobenius relation (25.7).}}
\]

To make this route progress one needs extra geometric information that forces
the two cocycles in (25.7) to come from one global automorphism, or that makes
the core tower stop.  None of the cited Isom or weak Hom theorems contains
that assertion.

## References

1. A. Tamagawa, *The Grothendieck conjecture for affine curves*, Compositio
   Math. **109** (1997), 135--194, Theorem 4.3.
   <https://doi.org/10.1023/A:1000114400142>
2. S. Mochizuki, *Absolute anabelian cuspidalizations of proper hyperbolic
   curves*, J. Math. Kyoto Univ. **47** (2007), 451--539, Theorem 3.12.
   <https://doi.org/10.1215/kjm/1250281022>
3. M. Saidi and A. Tamagawa, *A prime-to-\(p\) version of Grothendieck's
   anabelian conjecture for hyperbolic curves over finite fields of
   characteristic \(p>0\)*, Publ. RIMS **45** (2009), 135--186, Theorem 1
   and Corollary 3.10.
   <https://doi.org/10.2977/PRIMS/1234361157>
4. Y. Yang, *On a weak Hom-version of the Grothendieck conjecture for curves
   of type \((0,n)\) over algebraically closed fields of characteristic
   \(p>0\)*, RIMS Preprint 1879 (2017), Theorem 0.3 and Remark 0.1.1.
   <https://www.kurims.kyoto-u.ac.jp/preprint/file/RIMS1879.pdf>
5. A. Grothendieck and M. Raynaud, *Revetements etales et groupe fondamental
   (SGA 1)*, Lecture Notes in Mathematics 224, Springer, 1971, Expose XIII,
   Corollaire 2.12.
   <https://arxiv.org/abs/math/0206203>
