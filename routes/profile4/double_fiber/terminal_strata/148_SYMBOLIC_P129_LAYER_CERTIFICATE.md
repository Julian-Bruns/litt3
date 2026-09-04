# P129 post-\(e30\) layer transcript

## Referee status

The extraction of the displayed matrices and residual from the local
equations is **certificate-transcript**: the program said to perform it is
absent. Thus this file does not prove that they are the true local equations
at \(P129\).

The elementary linear algebra *after accepting those displayed data* is
exact over \(k=\overline{\mathbb F}_5\): the three matrices have rank \(4\),
and the final simple residual is the nonzero constant \(2\).

## Recorded layer data

The missing symbolic checker reported that the repeated and simple residuals
at each of \(e35,e40,e45\) are affine-linear in the current variables, with

\[
\begin{array}{c|c|c|c}
\text{layer}&\text{affine base}&\text{rank}&\text{remaining dimension}\\
\hline
e35&(4,3,1,3)&4&9\\
e40&(1,0,4,4)&4&5\\
e45&(0,1,4,2)&4&1.
\end{array}
\]

The reported coefficient columns, over \(\mathbb F_5\), are:

\[
\begin{aligned}
e35:\;&(0,4,1,4),(4,4,0,0),(0,1,4,1),(0,3,4,2),\\
 &(3,0,2,4),(2,1,1,1),(3,3,0,1),(2,4,3,1),\\
 &(3,4,0,0),(0,0,3,4),(1,0,1,4),(4,1,1,1),(3,2,3,0);\\[2mm]
e40:\;&(3,1,0,2),(4,4,0,2),(2,4,0,1),(0,3,2,4),\\
 &(2,2,4,2),(4,1,4,2),(0,3,1,0),(3,4,4,2),(1,1,4,1);\\[2mm]
e45:\;&(2,2,3,4),(0,2,1,4),(2,4,4,3),(1,0,2,0),(0,2,3,2).
\end{aligned}
\]

The minors on columns \(1,2,4,5\) at \(e35\), columns \(1,2,3,4\) at
\(e40\), and columns \(1,2,4,5\) at \(e45\) all have determinant \(2\)
in \(\mathbb F_5\).  Hence each displayed matrix has rank \(4\), over both
\(\mathbb F_5\) and \(k\).

In the variable order

\[
\begin{gathered}
u7_3,u6_2,u6_3,u5_1,u5_2,u4_0,u4_1,u4_2,u4_3,\\
u3_0,u3_1,u3_2,u3_3,u2_2,u1_0,u1_1,
\end{gathered}
\]

the reported final affine line is

\[
\begin{aligned}
\text{base}={}&(0,3,1,1,1,0,3,3,1,3,1,3,4,0,4,0),\\
\text{direction}={}&(2,0,3,1,4,4,0,1,0,2,1,4,4,1,0,0).
\end{aligned}
\]

On this line, with parameter \(a\), the reported simple-\(e50\) residual is

\[
2.
\]

## Conditional consequence

If an exact derivation verifies that these are the actual successive local
equations at \(P129\), then the ranks leave the displayed affine line and
the constant residual \(2\) makes its \(e50\) locus empty over every
characteristic-\(5\) field.  Thus \(P129\) would not extend through \(e50\).

The derivation of the displayed data and their connection to the original
local equations are not reproducible from this checkout. This conditional
terminal kill also presupposes both the unproved double-fiber specialization
and the missing repeated-\(u^{20}\) bridge when used as part of the full
tower.
