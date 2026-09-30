# Common line extensions: Frobenius roots and finite clump jets

Version4,20September2026. Let $k=\overline{\mathbf F}_p$, with $p$
odd, and let $X\xleftarrow fZ\xrightarrow gY$ be an actual coreless
finite étale span with $g(Y)=2$. Assume singleton clumps are excluded
and there is no shared regular one-form. All line bundles below are
COMMON triples, with their specified identification on $Z$.
Write $\Omega$ for the common canonical line and
\[
J(L)=H^1_{\rm common}(L^{-1}).
\]
This means the intersection of the two actual endpoint images in
$H^1(Z,L_Z^{-1})$. Write $F^*$ for the semilinear Frobenius map;
on common line classes it is $L\mapsto L^{\otimes p}$.
Equivalently all the assertions retain the successive relative
Frobenius twists. No equation identifies two distinct curve models.

## Vanishing and the precise possible line classes

If $\deg L_Y>0$ and $J(L)\ne0$, a clump exists. Let its reduced
common divisor be $S$, with $R=\deg S_Y$. For
$0<\deg L_Y\le2R$, nonvanishing implies that the degree is even,
say $2m$, and
\[
L^{\otimes p^n}\simeq \Omega(2S)
\quad\text{as COMMON lines for some }n\ge1.
\tag{1}
\]
In this range $\dim J(L)\le1$. Every nonzero class gives matching
stable pointed rank-two bundles
$0\to\mathcal O\to E\to L\to0$, whose first Frobenius instability
is exactly at $n$. In particular
\[
m p^n=R+1.
\]
Thus (1) specifies the entire line-bundle class, not just its
degree or its image modulo torsion.

## Every larger degree is an exact finite-jet problem

Suppose $d=\deg L_Y>2R$, and put
\[
b=\left\lfloor\frac{d-1}{2R}\right\rfloor.
\]
Write $H^0_{\rm common}(bS,L^{-1}(bS)|_{bS})$ for the pairs
of sections on the two endpoint thickenings whose pullbacks agree
on the ACTUAL common thickening $bS_Z$. Boundary maps give an
isomorphism
\[
J(L)\simeq
H^0_{\rm common}(bS,L^{-1}(bS)|_{bS}).
\tag{2}
\]
In particular
\[
\dim J(L)\le b.
\tag{3}
\]
This controls arbitrary degree, not just powers of the canonical
line. Every nonzero class in this range is initially unstable.
Its maximal line is $L(-cS)$, where $1\le c\le b$ is the
actual pole order of its unique common principal part. Formula (2)
keeps the finite jet identifications through both maps; the degrees
or the reduced support alone do not determine its dimension.

Together, (1), its complete root string below, and (2) reduce
ALL common extensions of positive line degree. The large-degree
part requires only jets of order $\lfloor(d-1)/(2R)\rfloor$
at the clump; it contains no additional Frobenius-stable extension
branch. If there is no clump, all these groups vanish.

## A clump constructs its full twisted string

Put $R+1=u p^a$, with $p\nmid u$. The clump-size theorem gives
$a\ge1$. There are unique common lines $M_0,\ldots,M_a$ with
\[
M_a=\Omega(2S),\qquad M_i^{\otimes p}=M_{i+1},
\qquad \deg M_{i,Y}=2u p^i.
\]
The conormal map along the reduced divisor $S$ gives a canonical
nonzero boundary class in $J(M_a)$, and
\[
\dim J(M_a)=1.
\]
Every Frobenius arrow
$J(M_{i-1})\to J(M_i)$ whose source line has degree greater than
two on $Y$ is an isomorphism. Consequently:

- If $u>1$, all $a+1$ spaces form a string of nonzero lines.
- If $u=1$ and $M_0\not\simeq\Omega$ as a common line, the same
  conclusion holds, including the first arrow.
- If $u=1$ and $M_0=\Omega$, $J(M_1)$ is a line and the exact
  first-Witt sequence is
  $0\to F^*J(\Omega)\to J(\Omega^p)\xrightarrow{\chi}k$.
  Exactly one possibility occurs: a joint tangent line and no
  simultaneous $W_2$ lift, or zero joint tangent and a unique
  simultaneous marked $W_2$ lift.

Together with (1), this determines EVERY $J(L)$ for common lines
with $0<\deg L_Y\le2R$: only the displayed roots can occur, and
their values are as above. The first-Witt assertion is the existing
normalized lifting theorem; a nontrivial torsion twist supplies
no ordinary $W_2$ normalization.

More explicitly put
\[
\rho=\mathcal O(2S)\Omega^{-R},\qquad
M_0=\Omega^u\eta.
\]
Both $\rho$ and $\eta$ are finite common torsion lines of order
prime to $p$, and $\eta^{p^a}=\rho$. If the primitive common
canonical tensor has zero multiplicity $e$, then
\[
\operatorname{ord}(\eta)=\operatorname{ord}(\rho)
 =\frac{e}{\gcd(e,2)}.
\]
Thus the new string exists even when $e>2$. In that case its
nontrivial twist is essential; it does not produce an untwisted
joint tangent or a simultaneous Witt lift.

## Identification with the characteristic-five Cartier flag

For either selected pair, in the line branch of the
[common Cartier flag](../cartier_and_spin/common_cartier_subbundles.md),
put $Q=U_2/A$ and $D=Q A^{-1}$. Then
\[
D^5=\Omega(2S),\qquad
0\longrightarrow\mathcal O
\longrightarrow U_2\otimes A^{-1}
\longrightarrow D\longrightarrow0
\]
represents the nonzero line $J(M_{a-1})$. Its first Frobenius
pullback is unstable. This identifies the flag's actual extension
with the canonical boundary string, rather than merely comparing
their degrees.

This pointed extension determines the WHOLE Cartier bundle. With
$E=U_2\otimes A^{-1}$ there is an isomorphism of actual common
filtered bundles
\[
B\simeq A\otimes\operatorname{Sym}^3E,
\qquad A^2D^3\simeq\Omega.
\]
The flag corresponds to the subbundles generated successively by
$s^3,s^2E,s\operatorname{Sym}^2E,\operatorname{Sym}^3E$, where
$s:\mathcal O\hookrightarrow E$ is its specified section.
Once the identification of the first line is fixed, this filtered
isomorphism is unique. This conditional root is singled out by
the common flag; arbitrary symmetric-cube roots of $B$ need not
be unique. It supplies no integral Frobenius crystal or Witt lift.

For EVERY $R$ in this line branch, let $\lambda$ be the unique
common Frobenius root of $\mathcal O(S)\Omega^{-2}$. There is
an actual common canonical-determinant dormant Bol bundle $\mathcal V$
such that
\[
E=\mathcal V\otimes\lambda,\qquad
B=\Omega^{-1}\operatorname{Sym}^3\mathcal V,\qquad
\deg\lambda_Y=\frac{R-4}{5}.
\]
The pointed section is a common saturated inclusion
$\lambda^{-1}\hookrightarrow\mathcal V$. On the genus-two
endpoint $\mathcal V$ is one of the five actual $\mathcal V_i$;
its Frobenius oper quotient is precisely $\omega_Y^2$, with
no unrecorded two-torsion normalization.

If $R=4$, $\tau=\mathcal O(S)\Omega^{-2}$ and $\lambda$ are
torsion. In particular $H^0(\mathcal V_i\otimes\lambda)\ne0$.
For the cubic backup, its established torsion vanishing implies
that $\tau_Y$ has a prime factor $\ell\ne5$ on which the order of
arithmetic Frobenius on $J(Y)[\ell]$ is divisible by five.
In particular a four-point backup clump whose primitive zero
multiplicity $e$ is supported only on $2,3$ must have $e=1$ or2.
Every other four-point clump requires such a bad prime, necessarily
at least7, in $e$ and in the endpoint order of $\tau_Y$.
This restriction has no bound on the covering degrees or on $e$.
It uses the backup's torsion theorem and is not asserted for the
main endpoint without that additional input.

The construction is conditional on a clump. The no-clump case
still has no such extension and is not excluded. Author proof
with focused degree, Cartier, and common-torsion checks.
[Proof](../../Proofs/deformations/shared_line_extension_spectrum.md).
