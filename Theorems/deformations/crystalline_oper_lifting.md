# A crystalline oper determines a unique lift of its curve

Let $C/k$ be a smooth projective connected curve of genus at least two,
where $k$ is algebraically closed of characteristic $p>2$. Let
$\mathcal H$ be a locally free rank-two crystal on $(C/W(k))_{\rm cris}$.
Write $(H,\nabla)$ for its evaluation on $C$. Suppose that a line
subbundle $L\subset H$ has Kodaira--Spencer isomorphism
\[
L\xrightarrow{\sim}(H/L)\otimes\omega_C.
\]
There is a unique marked smooth proper formal lift $\mathfrak C/W(k)$
on which $L$ lifts to a line subbundle of the evaluation of the FIXED
crystal $\mathcal H$. The line lift is unique as well. The curve and
line algebraize. No Frobenius structure on $\mathcal H$ is required.

The same assertion through $W_m=W(k)/p^m$ holds for a locally free
rank-two crystal on $(C/W_m)_{\rm cris}$. There is no loss of precision
in this assertion about a specified crystal.

The construction commutes with finite étale pullback. Consequently,
if an actual finite bi-étale span carries compatible such crystal-line
pairs on its endpoints, its ORIGINAL two maps lift together over $W(k)$,
or over $W_m$ in the truncated-crystal case. Compatibility may instead
be witnessed after a connected finite étale refinement of the source.

There is a stronger descent version. Suppose rank-two isocrystals
$\mathcal E_X,\mathcal E_Y$ have isomorphic pullbacks on the actual
source, and $\mathcal E_Y$ has an integral crystal lattice with an
oper line as above. Then this lattice and line descend through the
other leg, and the original span lifts over $W(k)$. No integral
lattice or Hodge line on $X$ needs to be specified in advance.
Here an isocrystal means a crystal with $p$ inverted; a Frobenius
structure is still unnecessary.

The reason is rigidity of the lattice: two integral lattices in the
same rank-two isocrystal, with oper reductions of equal degree, differ
by a power of $p$. Finite one-leg Galois descent removes that power.
This does not presume a source simultaneously Galois over both ends.

Here a crystal is an integral object, evaluated functorially on all
the indicated divided-power thickenings. A mod-$p$ connection, a
rational isocrystal with no chosen lattice, or two unrelated lifts
does not supply this hypothesis. In particular a Frobenius cycle may
permute rank-two summands of a larger crystal: a single compatible
summand with the displayed isomorphism already suffices.

## Ramified coefficients with an oper modulo p

Let $A/W(k)$ be a finite totally ramified complete DVR extension and
put $R=A/pA$. Let $C_0/R$ be a smooth proper curve whose reduced
fiber has genus at least two. A FIXED locally free rank-two crystal
on $(C_0/A)_{\rm cris}$, for the usual divided powers on $(p)$,
with an oper line in its evaluation on $C_0$, determines a unique
marked smooth proper lift over $A$, including its line. This statement
has no bound on the ramification index of $A$.

In the coefficient application, begin with a rank-two $A$-coefficient
crystal on $(C/W(k))_{\rm cris}$, locally free over the crystalline
structure sheaf tensored with $A$. View its mod-$p$ evaluation as a
rank-two bundle on $C_R=C\times_k R$. Suppose its oper line is given
over ALL of $R$, not just modulo the uniformizer. Pull back the
crystal to $C_R/A$ and identify coefficient $A$ with base $A$ by
the multiplication map. The preceding assertion applies.

The one-endpoint descent assertion also holds in this setting for
rationally compatible $A[1/p]$-coefficient crystals. Stability of the
oper reduction modulo a uniformizer gives uniqueness of the lattice
up to a uniformizer power; the line over $R$ is uniquely determined
by its reduction. Thus the original two maps lift together over $A$.
Supplying only a line modulo the uniformizer does not in general
supply the required line over $R$.

There is a sharper precision criterion. Write $p=u\pi^e$ in $A$.
The same coefficient application works if the initial oper line is
supplied on $C\times\operatorname{Spec}(A/\pi^a)$, where
\[
1\le a\le e,\qquad (p-1)a>e.
\]
The resulting lift retains this entire initial thickening. The
one-endpoint descent argument applies as well. The strict inequality
is the divided-power convergence threshold; a line only modulo
$\pi$ is sufficient by this criterion precisely when $e<p-1$.
Equality $(p-1)a=e$ also suffices if the reduced connection has
ZERO $p$-curvature. No conclusion below the threshold, or at equality
without this extra condition, is asserted.

For a lattice with a horizontal Frobenius step of integral height
$a\le e$, or a finite cycle with this bound on every step,
a stronger criterion uses that height instead of
the coefficient ramification: an initial oper over $A/\pi^n$ suffices
when $(p-1)n>a$. In particular $n=a\ge1$ always suffices, with no
condition on $a/e$. The
[Frobenius Taylor theorem](frobenius_taylor_thickness.md) constructs
the needed integral transport and proves this extension. This extra
conclusion does require the specified Frobenius bound; the preceding
crystal-only criteria remain valid without it.

Version5,20 September2026. Author proof. The stable-lattice argument
removes the need to supply integral compatibility on both ends;
the ramified argument retains an oper on a sufficiently thick
characteristic-$p$ coefficient base, including the full modulo-$p$ case.
[Proof](../../Proofs/deformations/crystalline_oper_lifting.md).
