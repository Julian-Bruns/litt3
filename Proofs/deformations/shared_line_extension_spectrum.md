# Proof: reduced clumps and torsion-twisted negative extensions

[Statement](../../Theorems/deformations/shared_line_extension_spectrum.md).
[Independent bounded review](../../Research/audits/CARTIER_SYMMETRIC_POWER_RECONSTRUCTION_AUDIT_2026_10_03.md).
Version5,3 October2026.
All pullbacks are the given actual finite étale maps. Cohomology
classes and the identifications of line bundles are retained.

## Positive line extensions remain nonsplit

Let $d=\deg L_Y>0$. Riemann--Hurwitz and the two degree equalities
give $\deg L_C=d(g(C)-1)$ on either endpoint and on the source.
The stable Cartier bundle $B_C$ has slope $g(C)-1$ and rank
$p-1>1$. Thus $\operatorname{Hom}(L_C,B_C)=0$, including $d=1$:
in the equal-slope case a nonzero map between these stable bundles
would have to be an isomorphism. The Frobenius sequence therefore
makes $H^1(L_C^{-1})\to H^1(L_C^{-p})$ injective. The same
argument applies at every later power and on $Z$.

Negative-degree cohomology pullback through each finite étale map
is injective as well. This follows from the degree-zero semistability
of the finite-étale permutation bundle and its quotient by constants.
Hence a nonzero common class gives actual nonsplit pointed extensions
$0\to\mathcal O_C\to E_C\to L_C\to0$ on both endpoints, identified
on $Z$, remaining nonsplit under every Frobenius pullback.

The common $E$ cannot be strongly semistable. Otherwise
[common quotient rigidity](../shared_tensors/common_finite_coefficients.md)
would make its quotient $L$ have the same slope as $E$, contrary to
$\deg L_C>0$. Let $n\ge0$ be its first Frobenius-instability index.
The maximal destabilizing lines agree after étale pullback.
They have positive degree and consequently project nontrivially
to $L^{p^n}$. An everywhere invertible projection would split
the extension. Its nonempty common zero divisor therefore
produces a clump. This proves the first assertion even when no
clump was initially assumed.

## The genus-two degree bound retains the whole determinant

Write $S$ for the unique reduced clump and $R=\deg S_Y\ge2$.
If $E$ is initially unstable, its maximal line is
$L(-bS)$ for an integer $b\ge1$, and $bR<d/2$.
This is impossible when $d\le2R$.

A strictly semistable rank-two bundle is an extension of two
equal-degree lines and remains semistable under Frobenius.
Thus, in this range, $E$ is stable and $n\ge1$. Let $N$ be
the maximal line in $F^{n*}E$. Its second fundamental map
\[
N\longrightarrow (F^{n*}E/N)\otimes\omega
\]
is nonzero: a horizontal $N$ would descend and destabilize the
preceding iterate. On $Y$ its zero-divisor degree is
$p^n d-2\deg N+2$, which is at most one. It is a common
effective divisor and $R\ge2$, so it is zero. Therefore $d$ is
even, say $d=2m$, and $\deg N_Y=mp^n+1$.

The pointed section is horizontal. At a zero of its projection
to $F^{n*}E/N$, its nonzero value lies in $N$. The invertible
second fundamental map makes the derivative of that projection
nonzero. Thus the zero is simple. Its divisor is exactly $S$,
not a higher multiple. Equivalently $N=L^{p^n}(-S)$.
Taking determinants in the invertible second fundamental map
gives $N^2=L^{p^n}\Omega$. Substitution yields
\[
L^{p^n}=\Omega(2S)
\]
as COMMON lines. This proves (1), including its torsion content.

For $d=2m$, the unstable-or-strictly-semistable extension locus
in $\mathbf P H^1(Y,L_Y^{-1})$ is the secant hypersurface
described in [the general secant calculation](two_leg_negative_extensions.md#4-stable-extensions-secants-and-genus-two-w2-rigidity).
That calculation assumes only the degree $2m$ of $L$, not that
$L$ is canonical. Every nonzero common class in the range under
consideration is stable, so the projective common subspace avoids
this hypersurface. It consequently has dimension at most zero,
or $\dim J(L)\le1$.

## Large degree reduces exactly to finite principal parts

The first-instability argument has a useful consequence without
the small-degree hypothesis. If a common pointed extension is
initially semistable, it is stable (strict semistability would
persist under Frobenius). Its first instability still has a
nonzero second fundamental map whose common zero divisor has
degree at most one on Y, so the same calculation gives
$p^n d=2(R+1)$ for some $n\ge1$. Since $p\ge3$ and $R\ge2$,
this forces $d\le2R$. Therefore every nonzero common class with
$d>2R$ is initially unstable.

Its unique maximal line $N$ projects nontrivially to $L$.
The projection's divisor is $cS$ for some $c\ge1$, and the
strict instability inequality is
\[
N=L(-cS),\qquad d-cR>d/2.
\]
Consequently $c\le b=\lfloor(d-1)/(2R)\rfloor$. The lift
$N\to E$ kills the extension class under
$H^1(L^{-1})\to H^1(L^{-1}(cS))$, and therefore under
$H^1(L^{-1})\to H^1(L^{-1}(bS))$.

On each endpoint and on Z, use the principal-parts sequence
\[
0\longrightarrow L^{-1}
\longrightarrow L^{-1}(bS)
\longrightarrow L^{-1}(bS)|_{bS}
\longrightarrow0.
\]
The middle line has negative degree: $bR<d/2<d$.
Its boundary map is therefore injective on all three curves.
The preceding paragraph shows that every common extension has
unique endpoint principal parts of this order. Their pullbacks
agree on Z because their boundary classes agree and the source
boundary is injective. Conversely any pair of matching principal
parts has matching boundary classes. This proves the exact
isomorphism (2), including its source identification.

Restriction of a common principal part to the length-b neighborhood
of a SINGLE point of $S_Z$ is injective. A zero germ at one point
forces zero germs at all points in the same f-fiber and g-fiber:
the maps on these completed neighborhoods are isomorphisms, since
the maps are étale. Propagate through the connected physical clump.
The local principal-parts space is b-dimensional, proving (3).

Finally take a nonzero principal part of exact pole order c. That
order is constant on the clump by the same propagation. The
corresponding lift $L(-cS)\to E$ is saturated. Locally the lift
has coordinates $(u,t^c)$ in a frame adapted to the pointing,
where u is a unit precisely because the order c is exact. Its
degree is greater than d/2, so it is the unique maximal line.
This also proves the claimed identification of c with the actual
Harder--Narasimhan defect, rather than just an upper bound on it.

## The boundary class needs no power of a canonical tensor

Set $M=\Omega(2S)$. The simple principal-parts sequence is
\[
0\longrightarrow\Omega^{-1}(-2S)
\longrightarrow\Omega^{-1}(-S)
\longrightarrow\Omega^{-1}(-S)|_S
\longrightarrow0.
\]
The conormal map
$\mathcal O(-S)|_S\xrightarrow{d}\omega|_S$ is an isomorphism.
It canonically identifies the final sheaf with $\mathcal O_S$.
The section $1$ therefore supplies matching principal parts
on the two endpoints. Their boundary is nonzero because
$H^0(\Omega_C^{-1}(-S_C))=0$. This constructs a canonical
nonzero common class in $J(M)$.

Its line degree on $Y$ is $2(R+1)$. The large-degree formula
applies with $b=1$, so the space has dimension at most one.
The constructed nonzero boundary proves that it is exactly a line.

## Unique common roots and the Frobenius arrows

By the [invariant Picard theorem](../shared_tensors/saturated_divisor_relations.md),
the group of common lines is an extension of $e_0\mathbf Z$,
$e_0=1$ or2, by a finite group $T$ of order prime to $p$.
Here the absence of shared one-forms supplies the prime-to-$p$
assertion. Thus multiplication by $p$ is injective and its image
consists exactly of classes whose normalized degree is divisible
by $p$. This constructs the unique $M_i$ in the statement.

Put $m_i=u p^i$. For $i\ge1$, the canonical connection on
$M_i^{-1}=F^*M_{i-1}^{-1}$ sends the common space $J(M_i)$
into $J(M_i\Omega^{-1})$. The latter line has degree
$2(m_i-1)$ on $Y$, with $1\le m_i-1\le R$.
Its common extension group is zero: the required equality
$(m_i-1)p^n=R+1$ is impossible, because $m_i-1$ is prime
to $p$ and strictly greater than $u$. Hence every class of
$J(M_i)$ is horizontal for this canonical connection.

For a negative line $L$ on the relative Frobenius target,
Cartier and the curve's cohomological dimension give
\[
0\longrightarrow H^1(L)
\longrightarrow H^1_{\rm dR}(F^*L)
\longrightarrow H^0(L\otimes\omega)
\longrightarrow0.
\]
This is the projection-formula form of the
[Cartier isomorphism](https://web.math.princeton.edu/~nmk/old/nilpconn.pdf#page=27).
For the lines here, forgetting the connection embeds this de Rham
group into $H^1(F^*L)$, with image the kernel of the canonical
derivative: $H^0(F^*L\otimes\omega)=0$.

Take $L=M_{i-1}^{-1}$. If $m_{i-1}>1$, the last Cartier term
has negative degree and is zero. Every common horizontal class
therefore has unique endpoint preimages under Frobenius.
Their pullbacks agree by Frobenius injectivity on $Z$. This
proves that the asserted arrows are isomorphisms, not just
injections.

If $u=1$, the final term at the first arrow is the degree-zero
common line $\Omega M_0^{-1}$. Its space of common sections is
zero unless $M_0=\Omega$ as a common line: any nonzero such
section would trivialize both lines and their identification.
In the nontrivial-twist case the same endpoint-preimage argument
therefore still works, even if a single endpoint's Cartier term
does not vanish by itself.

When $M_0=\Omega$, the exact joint sequence is the established
[normalized first-Witt sequence](two_leg_negative_extensions.md#2-an-arbitrary-simultaneous-w2-lift-supplies-such-an-extension).
The middle space is a line by the boundary construction and the
already proved arrows. Its normalization either vanishes, giving
one tangent line, or is an isomorphism, giving the unique marked
$W_2$ lift. No such scalar normalization occurs for a nontrivial
common torsion twist.

## Torsion order and exhaustiveness

The lines $\rho$ and $\eta$ have degree zero, hence lie in $T$.
Their equality $\eta^{p^a}=\rho$ preserves order because $p$
is prime to $|T|$. If the primitive common tensor has divisor
$eS$, its weight $d_0$ satisfies $2d_0=eR$. For an integer
$q\ge1$, the equality $\rho^q=\mathcal O$ is equivalent to
the existence of a common canonical tensor of weight $qR$
and divisor $2qS$. The polynomial common section ring says
precisely that $e\mid2q$. Thus its least possible $q$ is
$e/\gcd(e,2)$.

Finally (1) forces any low-degree nonzero $J(L)$ to be a
Frobenius root of this same $M_a$. The degree equation identifies
its place in the string, and injectivity of multiplication by $p$
on common Picard classes identifies the line itself. This proves
exhaustiveness, including the vanishing of odd-degree cases.

## A Cartier line gives the direct symmetric-power reconstruction

Put $h=(p-1)/2$, $j=(p-3)/2$ and $r=p-2$.
The clump-size theorem gives $R\equiv-1\pmod p$.
Both $\Omega(-rS)$ and $\mathcal O(S)\Omega^{-h}$
therefore have normalized degree divisible by $p$.
The invariant Picard theorem constructs their unique common
roots $A,\lambda$, retaining the relative twists.

Adjunction of $F^*A=\Omega(-rS)\hookrightarrow\Omega$
gives the common map $A\to F_*\Omega$. A nonzero Cartier
image has common zero-divisor degree
\[
2-\frac{2-rR}{p}=\frac{2(p-1)+(p-2)R}{p}.
\]
This is a positive multiple of $R$. Since $R\ge p-1$
and $R\equiv-1\pmod p$, it forces $R=p-1$ and that
multiple to be one. Comparing the actual line equality
$A=\Omega^{(1)}(-S^{(1)})$ with $F^*A$ then gives
$\tau^2=\mathcal O$. Thus outside that boundary the map
lies in $B$. Its coefficient has order $r<p-1$ at $S$;
the rank-one jet calculation makes it saturated.

Conversely any common saturated line in $B$ has adjoint
divisor $cS$, with $0\le c\le p-2$. Its degree equation
gives $c\equiv-2\pmod p$, hence $c=p-2$.
Unique common roots and the specified zero divisor identify
it with $A$, including the actual map up to scalar.

Write the canonical section of
$\mathcal O(S)=\Omega^hF^*\lambda$ locally as $a$.
The first-line Cartier condition is $C(a^{p-2}dz)=0$;
the equality $F^*(A\lambda^{p-2})=\Omega^{-pj}$
fixes its scalar normalization up to one common scalar.
Apply [the intrinsic scalar reconstruction and product lemma](../projective_connections/dormant_bol_complex.md#canonical-roots-from-scalar-products)
on both endpoints. Since the data match through the ACTUAL
maps, it gives common $E,s,D,V$ and
\[
B=A\operatorname{Sym}^{p-2}E
 =\Omega^{-j}\operatorname{Sym}^{p-2}V,\qquad
D=\Omega\lambda^2,\quad D^p=\Omega(2S).
\]
The specified first line fixes the isomorphism uniquely.

The degree of $D_Y$ is $2(R+1)/p\le2R$.
The constructed $E$ is stable and first becomes unstable at
height one; its nonsplit class therefore lies in the already
classified nonzero line $J(M_{a-1})$. Unique common roots
identify $D=M_{a-1}$, rather than just their degrees.

The rank-$i$ member generated by
$s^{r-i+1}\operatorname{Sym}^{i-1}E$ has Frobenius oper
grades $\Omega^t(-(p-1-i)S)$, $1\le t\le i$:
use the oper grades $\mathcal O(S),\Omega(S)$ of $F^*E$
and $F^*A=\Omega(-(p-2)S)$.
For $p=5$ the established proper-subobject classification
identifies this flag with $A,U_2,A^\perp,B$.
It also identifies $V_Y$ with one of the five normalized
Bol bundles. No complete higher-prime subobject lattice
or integral crystal is inferred.

## Four-point torsion exclusion

Now take $R=4$. The lines $\tau,\lambda$ have degree zero,
and the specified nowhere-zero section of $E$ gives
$H^0(\mathcal V_i\lambda)\ne0$.

The finite common torsion order is prime to five, and fifth-root
transport preserves its order on either endpoint. In particular
$\lambda_Y$ has exactly the same order as $\tau_Y$.
For the backup, the [dormant theta torsion theorem](../projective_connections/backup_dormant_theta_divisors.md)
annihilates all five section spaces for torsion supported on
primes $\ell\ne5$ where the arithmetic Frobenius order on
$J(Y)[\ell]$ is prime to five. This includes every mixed
$\{2,3\}$-primary line. Hence $\tau_Y$ in the line branch must
contain a bad prime in this precise sense.

At $R=4$ the primitive zero multiplicity equals the order of
the COMMON line $\tau$: its $q$th power is trivial exactly
when there is a canonical tensor with divisor $qS$ and weight
$2q$, and the primitive common section ring makes the least
such $q$ equal to $e$. Thus an $e$ supported on $2,3$ cannot
lie in the line branch. The remaining common-two-torsion
alternative has exactly $e=1$ or2. This proves the unrestricted
torsion-support exclusion for four-point backup clumps.

The new content concerns all common line classes and retains their
torsion. It supplies no clump, no general untwisted tangent, and
no unmarked common-cover exclusion on its own.
