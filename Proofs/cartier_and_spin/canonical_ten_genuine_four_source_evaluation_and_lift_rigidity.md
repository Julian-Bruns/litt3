# Proof: genuine four-source evaluation and original lift rigidity

Version1, 3 October2026. [Statement](../../Theorems/cartier_and_spin/canonical_ten_genuine_four_source_evaluation_and_lift_rigidity.md). All maps and relative twists below are the original maps in that statement. The actual $h:T\to X$ and $q:T\to Y$ remain on the same source throughout.

## Dependencies and the integral image

Use the accepted [genuine-source extraction](../../Theorems/cartier_and_spin/canonical_ten_original_net_genuine_source_extraction.md) for the original opposite-class tuple, the small-simple exclusion, absence of characters, actual finite torsor descent, and the exact original pushout. Use [all-source semistability](../../Theorems/cartier_and_spin/actual_finite_source_strong_semistability_and_cartier_surjectivity.md) and the [eight-source Cartier constraints](../../Theorems/cartier_and_spin/canonical_ten_eight_source_cartier_constraints.md) only where a retained positive source is invoked. The new consequences are proved here.

Ordinarity gives $H^0(B)=0$, so $H^0(K)=0$. Every proper subbundle of stable rank-three degree-one $K$ has degree at most zero. Every actual finite bundle $E_M$ is strongly semistable of degree zero: a positive-degree subbundle on any Frobenius pull would pull to a positive-degree subbundle of a trivial bundle on the actual finite étale torsor, which is impossible.

Let $I$ be the locally free image of a nonzero $E_M\to K$. It is a quotient of $E_M$, so $\deg I\ge0$. If its degree is positive, stability of $K$ forces rank three, and $1\le\deg I\le1$ gives integral surjectivity. If its degree is zero, $q_1^*I$ is globally generated of degree zero and is therefore trivial: independent sections giving a generic basis have a nonzero determinant section of a degree-zero line, hence give a basis everywhere. The quotient map from the trivial $q_1^*E_M$ is a constant matrix. Thus $I$ is the actual torsor descent of a genuine quotient representation of dimension at most three. Its simple constituents are all trivial by the small-simple exclusion. Its nonzero invariant socle gives a section of $I\subset K$, a contradiction. Hence every nonzero map is an integral surjection, and none exists for $m\le3$.

For an actual positive semistable $A_n$ of slope $1/4$, every nonzero image has positive degree because it is a quotient. The same stability argument makes it an integral surjection. This uses the retained actual map, not an extracted irreducible coefficient factor.

## A dimension bound for uniformly surjective bundle maps

Let $V,W$ be bundles of ranks $m>3,3$ and degrees $e,d$ on any smooth projective curve over an algebraically closed field. Assume every nonzero map $V\to W$ is surjective and $e/m\ne d/3$. We prove
\[
\dim\operatorname{Hom}(V,W)\le m-3.
\]
Put $r=m-3$, $b=\dim\operatorname{Hom}(V,W)$. For $b>0$ the universal map on $C\times\mathbf P^{b-1}$ has a rank-$r$ vector bundle kernel $R$:
\[
0\to R\to\pi_C^*V\to\pi_C^*W\otimes\mathcal O(1)\to0.
\]
With numerical curve point class $x$ and parameter hyperplane class $t$, $x^2=0$ and
\[
c(R)=(1+t)^{-3}\left(1+ex-\frac{dx}{1+t}\right).
\]
Since $c_{r+1}(R)=0$, restriction to a curve-point fiber and its nonzero pure coefficient $(-1)^{r+1}\binom m{r+1}$ gives $b\le r+1$. If $b=r+1$, integrating the remaining $xt^r$ coefficient over $C\times\mathbf P^r$ gives
\[
0=(-1)^r\left[e\binom{m-1}r-d\binom mr\right].
\]
The ratio of these binomial coefficients is $m/3$, so $3e=md$, contradicting the slope assumption. Thus $b\le r$. These are integer intersection numbers, including in characteristic five.

Apply this to $E_M\to K$ and to $A_n\to K$. Their respective slopes $0$ and $1/4$ differ from $1/3$, proving the bounds. For $U$ of dimension four, the retained evaluation is nonzero, hence $\operatorname{Hom}(E_U,K)=kv$. Actual torsor descent gives
\[
\operatorname{Hom}(E_U,K)=\operatorname{Hom}_G(U,H^0(T_1,q_1^*K)),
\]
so its socle multiplicity is one when present and otherwise zero.

## Local restrictions and the single finite cohomology direction

Every genuine determinant character is trivial. The tame involution on simple $U$ therefore has even negative multiplicity. If it were scalar, $B=C^{-1}A^{-1}$ would make the tuple reducible; for $C=-I$ it would also give $B^5=-I$. Thus its multiplicities are $2+2$.

Scott's inequality for $\operatorname{End}(U)$ bounds the sum of centralizer dimensions by $4^2+2=18$. The tame centralizer has dimension eight, while inverse conjugacy makes the wild dimensions equal. Each is at most five. A unipotent partition of four other than $[4]$ has centralizer dimension at least six, with $[3,1]$ already giving $2^2+1^2+1^2=6$. Both wild matrices are therefore $J_4$.

A $J_4$ cannot preserve a nondegenerate symmetric form in odd characteristic. Write $(A-I)v_i=v_{i-1}$. The isometry identities successively give $\langle v_1,v_j\rangle=0$ for $j\le3$, $\langle v_2,v_2\rangle=0$, $\langle v_2,v_3\rangle=0$, and $\langle v_1,v_4\rangle=0$. This would put $v_1$ in the radical. Consequently an additional self-duality hypothesis, when supplied, gives an alternating form by Schur's lemma; it is not supplied here.

Take any nonzero $\xi\in H^1(G,U)$ and its genuine extension $0\to U\to Z_\xi\to k\to0$. Nonsplitting gives $Z_\xi^G=0$ and $(Z_\xi^*)^G$ of dimension one. Tame multiplicities are $3+2$. If $f$ is the common wild fixed-space dimension, Scott's inequality on $Z_\xi$ gives
\[
2(5-f)+2\ge 2\cdot5-0-1=9.
\]
Thus $f=1$, so both blocks are $J_5$. A split cyclic-five restriction would have $J_4\oplus J_1$, and is impossible. Every nonzero global class restricts nontrivially to either original cyclic-five subgroup. Those restriction maps are injective. For a $J_4$, the cyclic norm is $(A-I)^4=0$, and $\operatorname{rank}(A-I)=3$, so its cyclic $H^1$ has dimension one. This proves $\dim H^1(G,U)\le1$.

Under the additional ORIGINAL minimum orbit hypothesis $Z_0=U$, the genuine-source extraction identifies $e_J$ with the pushout of this finite cohomology class by the actual $v$. Both spaces of choices have dimension at most one. Thus its nonzero pushouts have at most one projective direction for fixed $U,K$. For a larger $Z_0$, no such identification with a class on $U$ has been made.

## Strict stability and the original lift space

Now retain $0\to C_5\to A_8\to K\to0$ with exactly the stability in the statement. For a nonzero $E\to C_5$ of generic rank $r<4$, the image is a proper quotient of stable degree-zero $E$, hence has strictly positive integer degree. Its saturation in stable $C_5$ has degree $<r/5<1$, impossible. For $r=4$ the map is an injection with degree-zero image. Its saturation has degree $<4/5$, so cannot gain length; it is a subbundle. The same argument for $A_8$ uses degree $<r/4$ for $r<4$, and degree $<1$ for $r=4$. This is why strict stability of the actual $A_8$ matters.

If two independent maps $E\to C_5$ existed, every nonzero pencil member would be a subbundle injection. On $Y_1\times\mathbf P^1$ the universal map would have line bundle cokernel $R_1$:
\[
0\to\pi^*E\to\pi^*C_5\otimes\mathcal O(1)\to R_1\to0.
\]
With point class $x$ and hyperplane class $t$, $x^2=t^2=0$ and
\[
c_1(R_1)=x+5t,\qquad\operatorname{ch}_2(R_1)=xt.
\]
A line bundle instead has $\operatorname{ch}_2(R_1)=c_1(R_1)^2/2=5xt$, a contradiction in rational numerical Chow theory. Hence $c_U=\dim\operatorname{Hom}(E,C_5)\le1$.

The exact Hom sequence is
\[
0\to\operatorname{Hom}(E,C_5)\to\operatorname{Hom}(E,A_8)
\to kv\xrightarrow{\partial}\operatorname{Ext}^1(E,C_5),
\qquad\partial(v)=\mu_0.
\]
It proves all stated dimensions and the affine lift alternative. For a nonzero kernel map, determinants give the quotient $\det C_5\,(\det E)^{-1}$ of degree one. Absence of genuine characters gives $\det E=\mathcal O$; it does not turn this line into a marked effective divisor.

The argument is entirely at the original level $Y_1$. A Frobenius pull may have more Hom or lift parameters, and no horizontal descent follows. In particular this proof never identifies $\mu_0$ with $e_J$ or with an annihilator lifting obstruction. Both original maps remain on $T$.

## Frozen inputs and review provenance

The following independently audited drafts are the exact inputs consolidated here. Full SHA256 values bind the reviews; no numerical replay was used.

| Source and corresponding independent audit | Source SHA256 | Audit SHA256 |
|---|---|---|
| [Genuine simple four detector](../../Research/notes/oct03_ten_hour/genuine_simple_four_detector.md), [audit](../../Research/notes/oct03_ten_hour/genuine_simple_four_detector_audit.md) | `385a68a0c1f6b55c90ded9f61b50b44b98394c2f6aea4065459c54e844a01ae6` | `d879538c44518907bc81cdba8c0e967b0c2a3fb47d0209f63fdfe5d94113bf17` |
| [Original source evaluation rigidity](../../Research/notes/oct03_ten_hour/original_source_evaluation_rigidity.md), [audit](../../Research/notes/oct03_ten_hour/original_source_evaluation_rigidity_audit.md) | `81f2bb693fdf857cb69d2d4464be5c1d417680e9dad65500a18ad9be80042cc6` | `8b64e71863c6d07d13c0a9ca8339ef87d07225bfe71e401709922b9a72f4cba2` |
| [Minimum-four original lift rigidity](../../Research/notes/oct03_ten_hour/minimum_four_original_lift_rigidity.md), [audit](../../Research/notes/oct03_ten_hour/minimum_four_original_lift_rigidity_audit.md) | `b26a61c1d4098255934779c2af9f0c7dea1d0499cf5a3f5d7c197f5dd9965469` | `14eb697ab4139d3705ec7bb85a157ba81ab785a00fd46332918b9aff92abc30d` |

Focused accepted dependency snapshots: genuine extraction theorem `1ce2c7249bcc9896e4225efb272615e01601ab85db28564530d77a394f94de58`, proof `0b77844ee76c676f626dcbca4598ea25aa1bbf6819afebe02a6d1cb7afdb53fb`; eight-source theorem `a3309595e3183b1cb758bd25f29c4c70146f9a272d9b57089105906209e1f1bc`, proof `a6d6283ee93792abb6c53d803f1b30f16d12225ab9ec227e1da264cdbc8bb893`. These are provenance snapshots, not an instruction to overwrite concurrent root integrations.
