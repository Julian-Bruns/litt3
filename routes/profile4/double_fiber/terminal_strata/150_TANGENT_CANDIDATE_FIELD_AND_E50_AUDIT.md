# P129 tangent candidates and the base field

## Referee status

All enumerations, candidate coordinates, and residual polynomials in this
file are **certificate-transcript**: the programs that produced them are
absent.  Conditional on the displayed one-variable residuals being the true
local equations, their lack of a common zero over
\(k=\overline{\mathbb F}_5\) has the short exact proofs below.

No finite \(\mathbb F_5\)-enumeration establishes coverage over \(k\).

## Field convention

The solution variables are \(k\)-valued.  Coefficients and particular test
points may lie in \(\mathbb F_5\), but one may not replace \(a^5\) by \(a\)
for an unrestricted variable \(a\in k\).

The recorded candidates have prime-field coordinates, so they remain valid
points after base extension to \(k\).  What they refute are only weaker
coefficient-level obstructions, not the full double-fiber theorem.

## Recorded tangent census

The missing checker reported that the affine tangent space around \(P129\)
has rank \(12\) and dimension \(7\) over \(\mathbb F_5\).  Enumeration of
its \(5^7\) prime-field points reportedly found \(17\) rho3 coefficient-zero
points and four points satisfying both the simple-\(u30\) base equation and
repeated-\(e30\) consistency.

In the missing checker's 19-variable order, those four points were:

\[
\begin{aligned}
P129={}&(2,1,2,3,4,3,2,1,1,3,0,2,0,2,4,2,1,1,2),\\
P2={}&(2,1,2,1,4,1,4,3,3,1,4,3,1,4,4,2,1,2,2),\\
P12={}&(2,1,2,3,4,3,2,1,1,1,2,0,2,1,4,2,1,3,2),\\
P14={}&(2,1,2,0,4,0,0,4,4,2,3,1,2,3,2,2,4,3,2).
\end{aligned}
\]

The coordinate names and their order are not defined in the retained files,
so the tuples are regression data rather than independently usable points.
In any event, this is only a census of a specified affine
\(\mathbb F_5\)-slice.  It does not show that these are all \(k\)-points of
the tangent scheme or all points of the global frontier.

## Recorded \(e50\) endings

At each point, the missing symbolic checker reported ranks \(4,4,4\) at
\(e35,e40,e45\), leaving a line with parameter \(a\).  Its \(e50\)
residuals were:

\[
\begin{array}{c|llll}
&R_0(a)&R_1(a)&R_2(a)&S(a)\\
\hline
P129&
3+4a&4+a+4a^2&2+3a+a^2&2\\
P2&
1+2a&2a+a^2&2+4a+3a^2&3+3a\\
P12&
4+3a&3+a+3a^2&3+a+4a^2&1+2a\\
P14&
1+3a&3+2a^2&4a+3a^2&1+a.
\end{array}
\tag{150.1}
\]

Here \(R_0,R_1,R_2\) are the repeated residuals and \(S\) is the simple
residual.

## Exact consequence of the displayed polynomials

The \(P129\) row has \(S=2\), so it has no common zero over \(k\).
For \(P2\), the equation \(S=0\) forces \(a=4\), when \(R_0=4\).
For \(P12\), it forces \(a=2\), when \(R_1=2\).  For \(P14\), it forces
\(a=4\), when \(R_0=3\).  Thus none of the four rows in (150.1) has a
common zero over \(k\).

This last paragraph is a proof about the displayed polynomials, not a proof
that they were correctly extracted from the local curve equations.

## Remaining gap

Even after independently certifying (150.1), these four terminal kills
would cover only the recorded tangent neighborhood.  A proof still needs
the chart-wise algebraic coverage theorem in file 180, as well as the
missing repeated-\(u^{20}\) layer before the terminal analysis can be used
in the full tower.
