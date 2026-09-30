# Proof: reduced clumps and torsion-twisted negative extensions

[Statement](../../Theorems/deformations/shared_line_extension_spectrum.md).
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

## The actual Cartier flag gives this extension

Use the characteristic-five flag from the statement. Its
graded divisor formulas give
\[
F^*A=\Omega(-3S),\qquad
F^*\det U_2=\Omega^3(-4S).
\]
Thus, for $Q=U_2/A$ and $D=QA^{-1}$,
$F^*D=\Omega(2S)$. The exact sequence
$0\to A\to U_2\to Q\to0$, twisted by $A^{-1}$, is a
common pointed extension with quotient $D$.
It is nonsplit because $U_2$ is stable. Its first Frobenius
pullback is an oper and is unstable. Frobenius injectivity
and the one-dimensional boundary space therefore identify its
class, up to a nonzero scalar, with the constructed string.

## The pointed extension reconstructs the whole Cartier bundle

The symplectic pairing on $B$ identifies the last two quotients
of its common flag with $\Omega Q^{-1}$ and $\Omega A^{-1}$.
The actual Frobenius identities for $A,D$ give
\[
F^*(A^2D^3)=\Omega^5.
\]
There is no common five-torsion, so $A^2D^3=\Omega$. The
four graded lines of $B\otimes A^{-1}$ are consequently
$\mathcal O,D,D^2,D^3$, with these common identifications.
Put $m=(R+1)/5$, so $\deg D_Y=2m$. The spectrum already
proved gives
\[
J(D)=k,\qquad J(D^2)=J(D^3)=0.
\]
Indeed $2m,3m\le R$ for $R\ge4$, while nonvanishing of
$J(D^j)$ for $j=2,3$ would require $j5^{n-1}=1$ for
an integer $n\ge1$.

Here extension classes must remain common, not just agree in
degree. For a common short exact sequence $0\to N'\to N\to
N''\to0$, the usual injectivity implication
\[
\operatorname{Ext}^1_{\rm common}(M,N')=0
\quad\Longrightarrow\quad
\operatorname{Ext}^1_{\rm common}(M,N)
\hookrightarrow\operatorname{Ext}^1_{\rm common}(M,N'')
\]
holds whenever all the relevant $\operatorname{Hom}$ groups on
$Z$ vanish. To see this without any descent assumption, use the
endpoint extension sequences. A split pushed-out extension has
unique splittings on the endpoints and on $Z$. Its two preimage
classes in $\operatorname{Ext}^1(M,N')$ agree on $Z$, since
$\operatorname{Hom}_Z(M,N'')=0$ makes that preimage unique.
They are therefore a common class and vanish by hypothesis.
For line pairs occurring here the group is exactly $J(D^j)$:
the negative-degree $\operatorname{Hom}_Z$ vanishes, so no extra
gluing parameter is lost in taking the intersection of endpoint
cohomology images. For the intermediate filtered bundles the
same Hom vanishing follows either from their stable slopes or
successively from the negative-degree graded Hom lines.

Let $E_3=A^\perp\otimes A^{-1}$ and
$E_4=B\otimes A^{-1}$. It follows that their successive
extension classes inject into
\[
\operatorname{Ext}^1_{\rm common}(D^2,D)=J(D),\qquad
\operatorname{Ext}^1_{\rm common}(D^3,D^2)=J(D),
\]
respectively. In the second assertion the possible kernel first
injects into $J(D^2)$ and then into $J(D^3)$, both zero.
Each adjacent class is nonzero. Otherwise the injectivity would
split off the positive top graded line, contradicting stability
of $A^\perp$ or $B$ on either endpoint.

Now form $\operatorname{Sym}^3E$ using the specified section $s$.
Its natural flag has these same graded lines, and its first two
steps give the original pointed extension $E$. If $e\ne0$ is
its class in $J(D)$, the three adjacent extension classes are
$e,2e,3e$. This follows by expanding the cube of the transition
matrix of $0\to\mathcal O\to E\to D\to0$. All three
coefficients are units in characteristic five. As $J(D)$ is
one-dimensional, rescale the third graded identification and
then the fourth to match the nonzero adjacent classes of
$E_3,E_4$. The preceding injections lift each match to an
isomorphism of the whole extensions. This constructs the actual
common filtered isomorphism $B=A\operatorname{Sym}^3E$.

Finally $B$ is stable on each endpoint and on $Z$. Its common
automorphisms are scalars, so fixing its first-line identification
makes this isomorphism unique. The argument classifies this
particular root selected by a flag. It makes no uniqueness claim
for roots without that flag or for an integral lift.

## Canonical Bol normalization in every clump size

Let $\tau=\mathcal O(S)\Omega^{-2}$ and
$F^*\lambda=\tau$ in the common Picard group. This unique
root exists for every $R\equiv4\pmod5$: its degree is
divisible by five in the common degree lattice. Put
$E=U_2\otimes A^{-1}$. Its first Frobenius pullback has oper
graded lines
\[
\Omega^2\tau,\qquad\Omega^3\tau.
\]
Also $(\det E)^5=\Omega(2S)=\Omega^5\tau^2$, so injectivity
of fifth powers on common Picard classes gives
$\det E=\Omega\lambda^2$.
Twist by $F^*\lambda^{-1}$ with its canonical Cartier connection.
This works for a positive-degree $\lambda$ as well as for torsion.
The actual dormant bundle $\mathcal V=E\lambda^{-1}$ has
determinant $\omega$ and Frobenius oper quotient $\omega^2$.
The scalar Bol description identifies it with one of the
five actual $\mathcal V_i$ on the genus-two endpoint, without
an additional determinant or two-torsion twist. The construction
also retains the normalized dormant bundle on $X$ and the actual
identification on $Z$. Since $F^*(A\lambda^3)=\Omega^{-5}$,
unique common roots give $A\lambda^3=\Omega^{-1}$. Substituting
in the symmetric-cube formula proves
$B=\Omega^{-1}\operatorname{Sym}^3\mathcal V$.
The pointed section of $E$ is the stated saturated line in
$\mathcal V$, and $\deg\lambda_Y=(R-4)/5$.

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
