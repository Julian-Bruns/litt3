# Proof of uniform integral Cartier trace generation

[Statement](../../Theorems/cartier_and_spin/lambda_cartier_transport_generation.md).
This extends the earlier
[three-form generation theorem](cartier_kernel_generated_subbundle.md),
whose useful local certificates and four-round bound are retained.
The new argument permits negative strongly semistable generators and
excludes their last possible four-point defect by common line extensions.

## Strong semistability and normalized slope survive induction

Finite étale pullback preserves semistability: over a separate one-leg
Galois closure, a destabilizing Harder–Narasimhan subbundle is invariant
and descends, contradicting semistability downstairs. Pushforward also
preserves semistability. Its pullback to a one-leg Galois closure splits
as conjugate pullbacks of the original semistable bundle, all with the
same slope. Semistability of a pullback implies semistability downstairs.
These constructions assume no simultaneous Galois source.

Relative Frobenius commutes with both operations by the cartesian
Frobenius square for finite étale maps. Applying the argument at every
Frobenius height proves preservation of strong semistability.
Pushforward keeps degree and multiplies rank by the étale degree, by
Riemann–Roch and unramified Riemann–Hurwitz; pullback multiplies degree
and keeps rank. Every alternating full pull/push generator therefore has
the same normalized slope $\mu$; its slope on $Y$ is $\mu$.

Start from $V_X$, take its full pull/push at each step, and compose its
map with actual trace to $B$. Flatness of pullback and exactness of finite
pushforward show that its image is exactly the transport of the preceding
actual image. All actual images are locally free quotients of these
strongly semistable generators. No semistability of the images is assumed.

## Generic rank grows at every alternating step

Splitting the actual finite étale algebra shows that complete transport
is the sum of the subspaces on all sheets. Independent idempotent
components give $M\subseteq T_h(M)$ and the $g$ analogue without degree
division. Saturation commutes with finite étale pullback, so a transported
saturated bundle descends through the leg just used.

If successive saturated images have the same rank, their inclusion is
equality: its torsion quotient embeds in the locally free quotient by
the smaller saturated subbundle. The preceding bundle descends through
the other leg, so equality gives a common saturated subbundle $U$.
Suppose its rank is $r<4$. If there is no clump, the
[common Cartier-subbundle classification](common_cartier_subbundles.md)
excludes it. Otherwise let $S$ be the clump, with $R=\deg S_Y\ge4$.
The classification gives the actual first Frobenius image
\[
\operatorname{im}(F_Y^*U_Y\to\omega_Y)
=\omega_Y(-(4-r)S_Y),
\]
of degree $2-(4-r)R\le-2$. The actual coefficient image has full generic
rank in $U$, so its Frobenius adjunction image is a nonzero line subsheaf
of this line. It is a quotient of the first Frobenius generator and has
degree at most $-2$. That generator is semistable of slope $5\mu>-2$,
a contradiction. Thus each alternating step raises rank until four,
and three steps from a nonzero seed suffice.

## The integral defect is bounded and stabilizes

The genus-two images now have rank four and are locally free quotients
of semistable generators of slope $\mu$. Hence
\[
\deg J_i\ge\lceil4\mu\rceil\ge-1,\qquad
\operatorname{length}(B_Y/J_i)=4-\deg J_i\le5.
\]
Actual trace gives $J_i\subseteq J_{i+1}$. A strict inclusion decreases
this integer length. Equality in a whole round fixes both transports,
as the intermediate image lies between its equal endpoints. At most
five strict rounds are possible, so $J_5$ is fixed.

A nonzero stable defect gives an actual common effective determinant
divisor pair. Corelessness makes its coefficients constant on the clump.
The [genus-two clump restriction](../shared_tensors/genus_two_clump_connection_reduction.md)
gives $R\ge4$ and $R\equiv4\pmod5$. A positive multiple of $R$ at most
five is four. Thus the defect is a reduced four-point clump and
$\deg J_Y=0$. We exclude this possibility next.

## Local flag of the stable colength-one lattice

The common stable lattice equals $B$ off the clump and has colength one
at each clump point. Its Cartier-fiber image in
$\langle z,z^2,z^3,z^4\rangle$ is an arbitrary hyperplane.
In adjunction-coefficient orders the four primitive directions are
$0,1,2,3$. Row reduction gives three pivot orders, omitting $j-1$ for
some $1\le j\le4$. The missing horizontal generator is multiplied by the
Frobenius-target parameter $z^5$, giving order $j-1+5$.
Higher lattice coefficients do not change these initial orders.

The four orders have distinct residues modulo five. The jet-minor
Vandermonde calculation of the common Cartier-subundle proof, using
derivatives at most three and invertible factorials, gives actual
graded defects $d_i=e_i-i+1$ for the sorted orders. They are exactly
\[
(1,1,1,2),\quad(0,1,1,3),\quad(0,0,1,4),\quad(0,0,0,5).
\]
This includes mixed hyperplanes. The actual Frobenius filtration
commutes with both étale maps, and its graded images are common line
triples $L_i=\Omega^i(-d_iS)$. Their common effective defects make the
tuple constant along the connected clump. Their degrees on $Y$ are
$2i-4d_i$.

## Common extensions and compatible line quotients

The no-shared-form hypothesis permits use of
[the common line-extension spectrum](../deformations/shared_line_extension_spectrum.md)
and [clump-fiber detection](../shared_tensors/clump_fiber_picard.md).
For positive gap $D\le8$, only degree two can have a nonzero common
extension. For $D>8$, principal-part orders obey
$1\le c\le\lfloor(D-1)/8\rfloor$ and require
\[
L\Omega^c\in\mathbf Z[\Omega(S)].
\]
This group's degrees on $Y$ are multiples of six. Gap twelve vanishes
($c=1$ gives fourteen), gap fourteen vanishes ($c=1$ gives sixteen),
and gap eighteen vanishes ($c=1,2$ give twenty and twenty-two).
A nonzero gap-ten or gap-sixteen extension has exact pole order one.

For a common extension $0\to Q\to E\to P\to0$ of either last gap,
a nonzero class has unique maximal line $P(-S)$ and quotient $Q(S)$.
Uniqueness makes these lines and maps compatible under actual étale
pullback. A zero positive-gap extension has compatible splittings:
negative-degree Hom spaces vanish, so the splitting is unique on each
endpoint and on the source.

Let $K_i$ be the actual flag tail with $K_i/K_{i+1}=L_i$.
A compatible quotient of $K_{i+1}$ gives a compatible pushout of
$0\to K_{i+1}\to K_i\to L_i\to0$. Projection to a split bottom line,
or the unstable rank-two quotient just described, gives a genuine
common line quotient of $K_i$.

For $(1,1,1,2)$, the first adjunction quotient $L_1$ has degree $-2$.

For $(0,1,1,3)$, the degrees are $(2,0,2,-4)$.
Project successively onto $L_4$: the gaps from $L_3,L_2,L_1$ are
$6,4,6$, all forbidden. The quotient has degree $-4$.

For $(0,0,1,4)$, the degrees are $(2,4,2,-8)$.
The tail $K_3$ has gap ten and gives quotient $Q=L_4$ of degree $-8$
if split, or $Q=L_4(S)$ of degree $-4$ if nonsplit.
The next gaps from $L_2$ are twelve or eight, both zero, so the quotient
extends to $K_2$. The final gaps from $L_1$ are ten or six, giving
a quotient of degree $-8$ or $-4$.

For $(0,0,0,5)$, the degrees are $(2,4,6,-12)$.
The first gap eighteen is zero. The next gap sixteen gives
$Q=L_4$ of degree $-12$ or $Q=L_4(S)$ of degree $-8$.
The final gaps fourteen or ten give degree $-12$, $-8$, or $-4$.

Every tuple therefore gives a compatible common line quotient of
$F^*J$ of degree at most $-2$. But $F^*J_Y$ is a quotient of a semistable
generator of slope $5\mu>-2$. This is impossible.
The stable image is consequently $B_Y$, proving $J_5=B_Y$.
We have not inferred étale triviality or strong semistability of $J$.

## Support improves the slope threshold

Assume instead $\mu>-4/5$ and the stated reduced support bound.
Any proper common generic saturation of rank $r$ has adjunction image
$\omega_X(-(4-r)S_X)$. Inclusion of the original seed forces
\[
(4-r)S_X\le D_{\mathrm{seed}}.
\]
But the reduced clump has $\deg S_X=(g(X)-1)R\ge4(g(X)-1)$, contradicting
the seed's reduced support bound. Thus the generic ranks still increase
to four in three steps, without using the original slope threshold.

Now $\deg J_i\ge\lceil4\mu\rceil\ge-3$, so the integral defect is at
most seven. A proper stable determinant defect is a positive multiple
of $R\equiv4\pmod5$. Its bound seven again forces $R=4$ and coefficient
one. The same four local tuples and common extension quotients apply.
For the first tuple the adjunction quotient is $\Omega(-S)$, and retaining
the seed image forces $S_X\le D_{\mathrm{seed}}$, already impossible.
For each of the remaining three tuples the reviewed quotient degree is
at most $-4$. The first Frobenius generator has slope $5\mu>-4$, excluding
all those quotients. The stable image is full. At most seven strict
integral rounds are possible, so $J_7=B_Y$.

For the fixed line maps with $2\le r\le6$, Frobenius adjunction has zero
divisor $2R_X+5(r-2)O$: the canonical inclusion into $\lambda_X$ adds
the displayed multiple of $O$. Since $O\in R_X$, its reduced support is
still $R_X$, of size thirteen below $4(g(X)-1)=32$. The asserted slope
range and generation follow. All these are actual maps; no assumption
about arbitrary negative coefficient bundles has been added.

## Distinguished line and four actual endpoint maps

First note that negative seeds are plentiful without the fixed
distinguished line. In characteristic five, $B_X$ has rank four and
degree $4(g(X)-1)$, hence Euler characteristic zero. Twisting by one
point adds four, so $h^0(B_X(P))\ge4$. Every point supplies a nonzero
map $\mathcal O(-P)\to B_X$. The line is strongly semistable and has
normalized slope $-1/(g(X)-1)>-2/5$ for genus at least four. The
general theorem applies on any actual span with its stated coreless,
clump and shared-form hypotheses. Thus full trace generation is a
general linear phenomenon, independent of the special marked
divisor arithmetic. The fixed line below gives additional shorter
adjunction bounds, not an admissible-object extraction.

For the fixed genus-nine curve, $\lambda_X$ has degree $-2$, normalized
slope $-1/4>-2/5$. The selected-pair inputs include corelessness, singleton
exclusion and absence of shared forms; the last also follows from
[fixed-X form descent](two_form_map_descent.md). The theorem applies.
The older direct generic check remains useful: a proper common rank-$r$
bundle containing $\lambda_X$ would force $(4-r)S_X\le2R_X$, whose left
degree is at least 32 and right degree 26.

For the shorter adjunction assertion, the initial actual adjunction zero
divisor is $2h^*R_X$. Over a split finite étale disk, complete trace
transport of a line image takes the minimum of its valuations over the
fiber: arbitrary idempotent components are independently available and
the parameter changes have unit derivative. Frobenius base change
commutes with this operation. This again uses no degree inversion.
All initial zero coefficients are two, so after the first $g$ transport
every adjunction zero coefficient is zero or two. If its zero divisor on
$Y$ is $D_Y$, containment of the original image gives
\[
g^*D_Y\le2h^*R_X,\qquad 8\deg h\,\deg D_Y\le26\deg h.
\]
Hence $D_Y$ is either zero or $2[y]$ for one point $y$.

The next $h,g$ round can only decrease this divisor, again keeping
coefficients zero or two. If it leaves the nonzero divisor unchanged,
the intermediate pulled-back divisor lies between equal starting and
ending divisors and must equal both. It is then an actual common divisor
whose genus-two support is the singleton $y$, a forbidden singleton
clump. Therefore the divisor is zero after $g,h,g$, proving full actual
adjunction at the third unsaturated transport. Higher Cartier-fiber
defects can still remain at this stage; they are removed by the later
integral-cycle argument.

For the algebra assertion, complete a local disk on $Y$. Surjectivity of
adjunction means some local section of $E_Y$ represents a function $f$
whose derivative is a unit. Subtracting its constant residue, which lies
in the included constants, makes it a uniformizer. The powers
$1,f,f^2,f^3,f^4$ form a basis over the fifth-power local subring: modulo
its maximal ideal they are a basis of the truncated ring in a parameter,
and Nakayama applies to the finite free rank-five module. Thus their
products generate the complete Frobenius algebra locally. Faithful
flatness of completion proves the asserted sheaf equality.
The preimage $E_Y$ contains the constant line. Neither this algebra equality
nor the generator construction supplies a strongly semistable or
étale-trivial presentation.

Form the actual finite étale path space
\[
(z_0,z_1,z_2,z_3),\qquad
g(z_0)=g(z_1),\quad h(z_1)=h(z_2),\quad g(z_2)=g(z_3).
\]
Its endpoint distinguished lines span the three-step transported generic
space, which is all of $B_Z$. Choose four independent endpoint lines.
Take the ordered fourfold path fiber product over the initial $Z$, and
a connected component containing that generic tuple.
It is an actual connected finite étale refinement $Z'\to Z$.
The four endpoint projections composed with $h$ give actual finite
étale maps $h_i:Z'\to X$ with independent distinguished lines.
The starting projection composed with $g$ retains an actual $Y$-map.
No simultaneous Galois source or equality of endpoint fields is assumed.

This is integral linear trace generation. It supplies no finite spectral
orbit, invariant admissible line, or common-cover exclusion.
