# Reconnecting the joint-image frontier to the earlier proofs

**Status: dependency and strategy record, 2026-09-05. Not a new theorem.**

The user requested this comparison to avoid restarting an already
developed route. The root agent reread the README, route README and
STRUCTURE index, then the relevant proofs in the unnumbered incidence
notes and files 68, 74, 75, 79--80. Two bounded subagent reviews checked
the earlier differential and conductor/coefficient statements. Full
audit records were not loaded.

## What was already known, and what is actually new

The joint-image reduction of file 100 was already present in
Proposition D.1 of
`MINIMAL_COMMON_COVER_AND_INCIDENCE_DESCENT.md` and Theorem I.1 of
`PARAMETERIZED_PUSHED_INCIDENCE_DICHOTOMY.md`.
Proposition I.7 of the latter already gives the exact total defect
and negative normal-line formulas. That note also explicitly warns
that high contacts prevent a contradiction from total defect alone.
These are established prior inputs, not new progress of file 100.

The new material in files 101--102 is the order of the **specified
differential identification in the singular-image gluing kernel**,
its global cohomological degree bound, and its contact-independent
multibranch interpolation bound. Both files have PASS audits.

No old file was deleted: file 100 is not independently audited, and
the earlier incidence notes contain additional descent conclusions
that it does not subsume.

## Exact reusable inputs

1. **Keep the cyclic diamond, file 68.1.** For genus ratio r, a common
   etale cover gives a genuine cyclic etale r-cover V/C, together with
   etale V/Y and C/X of equal degree M, and a noninvariant Y-map.
   This retains both original targets and supplies the small orbit
   that the general joint-image description lacks. For the current
   pair, r=3. The norm lower bound and nonpencil theorem in file 68
   are also valid; its general quadratic-core assertion is not.

2. **Use the repaired square, files 81--83.** The full-orbit field,
   sign-choice bounds and common local inertia data are usable as
   stated. The coefficient-field indices are not the branch count
   or tangent-ratio order of the X-by-Y image. A map from an auxiliary
   curve back to X must not be inferred without descent.

3. **Keep the genuine conductor and label formulas, files 45 and 55.**
   For (p,a):V to C-by-Y the normalization is V and at most r branches
   meet. Its conductor is the sum of coincidence divisors for a and
   its cyclic translates. The spectral C-by-projective-line image
   has the separate branch-label collision budget. Neither formula
   counts collisions across different points of the fiber of C/X.

4. **Keep the valid packing statements, files 74--75 and 79--80.**
   The quadratic involution and orthogonal-complement lemmas give
   genuine extra restrictions where their actual quotient exists.
   File 80.4 identifies the quantitative genus slope required for
   an all-degree extension. It is not enough to have an arbitrary
   linear genus bound. None of these statements excludes the
   generic birational coefficient case on its own.

5. **Keep rational-incidence descent in its exact form.** Proposition
   D.2 rules out an inseparable divisor-family factor and preserves
   the complete local fiber-product condition. But the descended
   normalization maps to the new parameter curve, not to the fixed Y.
   Minimality does not supply the missing Y-map. This is the earlier
   theorem directly enforcing the user's same-curve warning.

## The precise link between old labels and new branch counts

Let Z normalize the image of (cp,a):V to X-by-Y, and put
\(\kappa=\deg(V/Z)\). Then V/Z is etale,

\[
 d_X=rM/\kappa,\qquad d_Y=M/\kappa,\qquad\kappa\mid M.
\]

At a point (x,y) of the joint image the number of branches equals

\[
 \frac{1}{\kappa}\#\{v\in V:cp(v)=x,\ a(v)=y\}.
\]

For a hyperelliptic branch point \(P_\alpha\in Y\), with the old
divisor \(D_\alpha=p_*a^*P_\alpha\), this becomes

\[
 \operatorname{mult}_x(c_*D_\alpha)
       =\kappa\,r_\Gamma(x,P_\alpha).
\]

Thus the relevant quantities are multiplicities **after pushforward
to X**. The older collision bound controls multiplicities on C
before that pushforward. It cannot be substituted unchanged.
Moreover, even a bound at all marked branch points would not by
itself bound unmarked singularities of the joint image.

The tempting alternative of using the bound r on the C-by-Y image
also fails: the nonzero norm map J(Y) to J(C) is an essential part
of the old proof, whereas the global degree bound in file 101
requires Hom between the two target Jacobians to vanish.

## Why the older differential-power lemmas are not a missing shortcut

Reviewer: `c14_elliptic_translation`, 2026-09-05.

Files 30 and 39 constrain torsion classes on the **smooth
normalization**. In contrast, the class in file 101 lies in
\(\ker(\operatorname{Pic}(\Gamma)\to\operatorname{Pic}(Z))\).
It is already trivial on the normalization. The two types of torsion
therefore cannot be identified.

File 30's cubic differential does measure cubes of tangent ratios
at nonspecial collisions. A proof that an appropriate power descends
as a unit across the singular image would control those ratios;
file 30 itself does not prove this descent. Its one-31-cycle profile
also cannot be imposed on arbitrary degrees.

File 34 requires the **global** differential ratio to be a fifth
power in the function field. The gluing theorem does not establish
that. Pointwise fifth-power residues impose no condition over the
algebraic closure of a finite field.

File 39's Schwarzian-preservation and seven-divisibility conclusions
remain useful for the original triangle route, but neither its
third-order hypothesis nor its cover-degree parameter is supplied
by files 101--102. These results are retained as conditional filters,
not transferred to the genus-nine/genus-25 pair.

## Strategic decision

Continue with the **earlier cyclic diamond and its fixed branch
labels**. Use files 101--102 as an added test of first-derivative
compatibility, not as a replacement route based only on singularity
totals. A useful next deduction must either control the pushed
collision divisors on X or relate the sign/torsion labels to the
actual differential identifications. No existing theorem presently
provides either missing implication.
