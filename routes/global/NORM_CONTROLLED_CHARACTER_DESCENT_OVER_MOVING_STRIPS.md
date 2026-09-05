# Norm-controlled character descent over moving strips

Date: 2026-09-05.
Norm refinement proposed by `/root`; verification and write-up:
`/root/canonical_trace_algebra`.
Status: complete author proof; not independently audited.
The arithmetic no-new-factor input cited below is retained as a prior
input, not independently re-audited here. No novelty claim.
No existing file or fixed curve is changed.

This supplies a uniformity statement beyond
[fixed-corner character descent](FIXED_CORNER_CHARACTER_DESCENT_FOR_VARYING_TARGET_LIFTS.md):
the intermediate curves may vary, provided the relevant norm degrees
have bounded \(\ell\)-adic valuation and the Hom vanishing persists.
It still requires that the composite map actually descend to the
chosen intermediate curve. It does not produce that descent.

## 1. The intersection is killed by a norm degree

Let \(k\) be algebraically closed, and let
\[
                         X\xleftarrow f C\xrightarrow g V
                                                                    \tag{1.1}
\]
be finite étale maps of smooth projective connected hyperbolic curves.
Assume
\[
                         \operatorname{Hom}(J_X,J_V)=0.
                                                                    \tag{1.2}
\]
Let \(B_X\subset J_C\) be the sum of the images of all homomorphisms
\(J_X\to J_C\). In particular it contains \(f^*J_X\) and
\(u^*J_X\) for every morphism \(u:C\to X\).
Set
\[
                         E=B_X\cap g^*J_V,
                         \qquad e=\deg g.                     \tag{1.3}
\]

**Norm lemma.** Multiplication by \(e\) kills \(E\). In particular,
for every prime \(\ell\ne\operatorname{char}k\),
\[
                        \ell^{v_\ell(e)}E(k)[\ell^\infty]=0.
                                                                    \tag{1.4}
\]

**Proof.** For every \(\varphi:J_X\to J_C\), (1.2) gives
\(g_*\varphi=0\), so \(g_*\) vanishes on \(B_X\). On the other
hand, the norm identity \(g_*g^*=[e]\) on \(J_V\) implies
\[
                (g^*g_*)|_{g^*J_V}=[e]|_{g^*J_V}.
\]
Restricting to the intersection (1.3) proves \([e]E=0\).
These are identities of homomorphisms on the corresponding subgroup
schemes: the identity on \(g^*J_V\) can be checked after the
surjective isogeny \(J_V\to g^*J_V\). Thus no reducedness or
prime-to-characteristic assumption on \(e\) is required.
On \(\ell\)-primary geometric torsion, the factor of \(e\) prime
to \(\ell\) is invertible, which gives (1.4). \(\square\)

In particular one may always use \(v_\ell(\deg g)\) for the cutoff
in the fixed-corner theorem, although the actual exponent of \(E\)
may be smaller.

## 2. A uniform theorem with varying intermediate curves

Fix \(X\), \(k\), and \(\ell\ne\operatorname{char}k\), but allow
the curves \(C_\alpha,V_\alpha\), and the finite étale maps
\[
                X\xleftarrow{f_\alpha}C_\alpha
                       \xrightarrow{g_\alpha}V_\alpha
\]
to vary. Assume for every \(\alpha\) that
\[
 \operatorname{Hom}(J_X,J_{V_\alpha})=0,
 \qquad v_\ell(\deg g_\alpha)\le c                         \tag{2.1}
\]
for a single integer \(c\ge0\).

Let \(q_\alpha:W_\alpha\to C_\alpha\) be any actual connected
finite étale Galois cover with specified product group
\(H_{X,\alpha}\times H_{V,\alpha}\), both finite abelian
\(\ell\)-groups. Require its two character line-bundle subgroups to
satisfy
\[
 \Lambda_{X,\alpha}\subset f_\alpha^*J_X(k),\qquad
 \Lambda_{V,\alpha}\subset g_\alpha^*J_{V_\alpha}(k).          \tag{2.2}
\]
The character subgroups and the connected-cover requirement have
the exact meaning of Section 2 of the fixed-corner theorem.

Let \(\pi_j:X_j\to X\) be any connected cyclic étale cover of
\(\ell\)-power degree, and suppose an actual map
\(r_\alpha:W_\alpha\to X_j\) satisfies
\[
                    \pi_jr_\alpha=u_\alpha q_\alpha
\]
for some finite étale map \(u_\alpha:C_\alpha\to X\).
The maps \(u_\alpha\), the cyclic target covers, and their degrees
may all vary.

**Theorem.** Every such \(r_\alpha\) is invariant under
\(\ell^cH_{V,\alpha}\) and descends, retaining étaleness, to
\[
                   W_\alpha/(\ell^cH_{V,\alpha})\longrightarrow X_j.
                                                                    \tag{2.3}
\]
More precisely, the image of the opposite deck factor
\(H_{V,\alpha}\) acting on this lift has order dividing
\(\deg g_\alpha\).

**Proof.** Let \(L_j\in J_X\) be the faithful character line of
the cyclic target cover. Character descent gives the unique expression
\[
                     u_\alpha^*L_j=\xi_X+\xi_V,
                     \qquad\xi_i\in\Lambda_{i,\alpha}.
\]
The subvariety \(B_{X,\alpha}\) defined as in Section 1 contains both
\(u_\alpha^*L_j\) and \(\xi_X\); hence \(\xi_V\) lies in the
intersection \(E_\alpha\) of (1.3), with \(g=g_\alpha\).
The norm lemma kills it by \(\deg g_\alpha\), and thus by
\(\ell^c\) on \(\ell\)-primary torsion.

As in the fixed-corner proof, connectedness gives an actual
equivariance homomorphism
\[
 H_{X,\alpha}\times H_{V,\alpha}
                         \longrightarrow\operatorname{Gal}(X_j/X)
\]
for \(r_\alpha\). Its restriction to the opposite factor has
character line \(\xi_V\). The target is cyclic and its chosen
character faithful, so the order of this image equals the order
of \(\xi_V\). This proves the divisibility assertion and (2.3).
All descended maps are actual factors of finite étale maps.
\(\square\)

If all \(\deg g_\alpha\) divide an integer \(D\), one may take
\(c=v_\ell(D)\). If one only knows the numerical bound
\(\deg g_\alpha\le D\), the valid automatic choice is instead
\(c=\lfloor\log_\ell D\rfloor\). A numerical upper bound alone
does not imply a bound by \(v_\ell(D)\).

## 3. Strip components have the required degree divisibility

Fix an actual finite étale map \(C_0\to Y_0\) of degree \(D\),
with \(C_0\) connected. Let \(Y_n\to Y_0\) be any connected
finite étale Galois cover, and let \(C_n\) be a connected component
of \(C_0\times_{Y_0}Y_n\). Then
\[
                            \deg(C_n/Y_n)\mid D.              \tag{3.1}
\]
Indeed the Galois group of \(Y_n/Y_0\) acts transitively on the
components of the fiber product, since its quotient is connected
\(C_0\). These components have equal degree over \(Y_n\), as deck
transformations also act by automorphisms of the base. Their degrees
sum to the degree \(D\) of the entire base change, proving (3.1).
No Galoisness of \(C_0/Y_0\) is required.

If the covers \(Y_n/Y_0\) are abelian and \(Y_0\) has genus two
over \(\overline{\mathbf F}_5\), the prior
[no-new-large-simple-factor theorem](ABELIAN_ETALE_TOWERS_ACQUIRE_NO_LARGE_SIMPLE_FACTOR.md#4-all-genus-two-bases-with-no-ordinarity-assumption)
gives, for the fixed genus-nine \(X\) of file 76,
\[
                         \operatorname{Hom}(J_X,J_{Y_n})=0
                         \quad\text{for every }n.             \tag{3.2}
\]
Its input is the certified geometric simplicity and number-field
endomorphism algebra of \(J_X\), with dimension nine and maximal
abelian subfield degree two. The packet inequality is
\(9>2(2-1)\), and the old genus-two packet cannot contain \(J_X\).
This application requires no ordinarity assumption on \(Y_0\) or
\(Y_n\). The arithmetic certificates underlying that prior theorem
are not re-audited by the present norm calculation.

Thus, whenever an actual \(C_0\) also maps finite étale to this \(X\),
the moving-strip family \(C_n\) satisfies (2.1) with
\(c=v_\ell(D)\). This is conditional on the given actual maps;
no common cover is constructed or asserted to exist here.

The same conclusion holds for any other fixed \(X\) and tower
for which (3.2) is separately established. It is not claimed from
Hom vanishing at \(Y_0\) alone.

## 4. The exact relative-width statement for rectangles

Suppose an actual compatible cyclic two-leg rectangle has stabilized
connected product tails after a corner \((a,a)\). Fix \(b\ge a\),
and put
\[
                         C_n=W_{b,n},\qquad n\ge a.
\]
Assume \(\operatorname{Hom}(J_X,J_{Y_n})=0\) for every \(n\),
and let \(D=\deg(W_{b,a}/Y_a)\). By applying (3.1) to the base
\(Y_a\), the maps \(g_n:C_n\to Y_n\) have degrees dividing
\(D\). Set \(c=v_\ell(D)\).

For \(m\ge b\) and \(N\ge n\), the actual cover
\[
                       W_{m,N}\longrightarrow C_n
\]
has the product tails from X-level \(b\) to \(m\) and Y-level
\(n\) to \(N\). Its X-character subgroup lies in the pullback
of \(J_X\), and its Y-character subgroup lies in \(g_n^*J_{Y_n}\).
These assertions use the stabilized product action; characters of
the relevant coordinate subgroups extend to the original finite
abelian deck groups.

Consequently, if an actual map
\[
                         r:W_{m,N}\longrightarrow X_j
\]
has composite to \(X\) descending to **any** finite étale map
\(u_n:C_n\to X\), then \(r\) itself descends to
\[
                       W_{m,\min\{N,n+c\}}\longrightarrow X_j.
                                                                    \tag{4.1}
\]
The number \(c\) of possible additional Y-layers is independent
of \(n,m,N,j\), and of the varying maps \(u_n\).

Using \(Y_n\), rather than the original \(Y_0\), as the norm base
is the substantive improvement: \(\deg(C_n/Y_n)\) stays bounded,
while \(\deg(C_n/Y_0)\) grows with the strip level. Uniform Hom
vanishing for the \(Y_n\) is what licenses this change of base.

## 5. Remaining boundary

Equation (4.1) is a uniform **relative-width** conclusion, not a
uniform absolute Y-cutoff. A lower level \(n\) to which the
composite descends must already have been obtained.

In particular, if the current strip theorem gives only descent of
the composite to \(W_{b,N}\), take \(n=N\) in (4.1). Then the
opposite tail over that strip is trivial, and (4.1) adds nothing.
It does not force \(N\) to be bounded, select a fixed corner, or
show that arbitrary unbounded correspondences are compatible.

Likewise, for the other strip \(W_{m,b}\), the degree over the fixed
Y-level typically grows with \(m\); one cannot apply the uniform
norm estimate there without checking a different bounded-degree
Hom-orthogonal base. No such base is supplied by this note.

Thus the new theorem removes the dependence of the character cutoff
on moving strip Jacobians **under the explicit degree and Hom
hypotheses**. It does not supply the missing composite descent,
rectangle cofinality, or a common-cover exclusion.
