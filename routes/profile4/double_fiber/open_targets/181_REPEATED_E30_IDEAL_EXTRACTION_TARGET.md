# Repeated-\(e30\) ideal-extraction target

## Status

**open missing-input target**.  Older notes say that a program constructs the
repeated-\(e30\) system after the repeated-\(u25\) solve, but that program is
absent.  No explicit \(e30\) generator is retained here.

This extraction lies downstream both of the unproved entry-zero
specialization \(c=d=2\) and of the missing repeated-\(u20\) note 100.
Reconstructing the \(e30\) formulas repairs neither earlier gap.

## Required construction

Work over \(k=\overline{\mathbb F}_5\), while keeping coefficients in
\(\mathbb F_5\) whenever the formulas permit.  On each priority chart

\[
\mathcal C_3=D(\Delta\rho_3),\qquad
\mathcal C_4=V(\rho_3)\cap D(\Delta\rho_4),
\]

perform the following operations symbolically.

1. Display the repeated-\(u25\) affine system

   \[
   b_{25}+M_{25}X=0
   \]

   in all new \(u25\) variables.

2. Display the selected \(3\times3\) pivot minor \(\mu_c\).  Over
   \(D(\mu_c)\), solve the three pivot variables in terms of all non-pivot
   variables \(y_1,\ldots,y_n\).

3. Substitute that solve into the repeated-\(e30\) residual.  Prove the
   reported assertion that its three components are affine-linear in the
   \(y_j\), and display the resulting rational forms

   \[
   E_{c,i}(r,y)=e_{c,i}(r)+\sum_j e_{c,ij}(r)y_j,
   \qquad i=0,1,2.
   \tag{181.1}
   \]

   If nonlinear or Frobenius terms in the \(y_j\) occur, retain them and
   correct the downstream ideal instead of forcing the affine ansatz.

4. Clear a displayed common power of \(\mu_c\) and retain \(\mu_c\) in the
   saturation element.  Clearing denominators without saturation introduces
   spurious points on the pivot divisor.

The output must specify the ambient polynomial ring, variable order, every
generator, and every factor inverted.  A reference to a function name or a
stored cache is not a reproducible certificate.

## Chart ideals

Let \(F_c\) be the complete list of retained low-data, non-pivot
simple-\(u30\), and base-residual equations on chart \(c\).  If
\(\widetilde E_{c,i}\) are the cleared forms from (181.1), define

\[
\begin{aligned}
I_3&=(F_3+\langle\widetilde E_{3,0},
\widetilde E_{3,1},\widetilde E_{3,2}\rangle):g_3^\infty,\\
I_4&=(F_4+\langle\rho_3,\widetilde E_{4,0},
\widetilde E_{4,1},\widetilde E_{4,2}\rangle):g_4^\infty,
\end{aligned}
\tag{181.2}
\]

where \(g_3\) contains \(\Delta\rho_3\mu_3\), \(g_4\) contains
\(\Delta\rho_4\mu_4\), and each also contains every earlier pivot whose
inverse was used.  These are the ideals required by file 180.

## Recorded diagnostic, not proof

At the prime-field point called \(P129\), the missing evaluator reported a
rank-\(3\) repeated-\(e30\) affine system in sixteen free variables, hence a
thirteen-dimensional affine solution space, with one solution beginning

\[
u7_3=4,\qquad u6_2=2,\qquad u6_3=1
\]

and all other displayed free variables zero.  This is useful as a regression
test for a reconstructed formula, but it neither supplies the polynomials in
(181.1) nor proves anything about all \(k\)-valued points.

## Completion criterion

This target is complete only when the exact data in (181.1)--(181.2) can be
checked from the repository.  Tail coverage is a separate next theorem:
one must still prove the radical containments and terminal unit-ideal checks
specified in file 180.
