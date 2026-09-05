# Weak two-point orbifolds when the atlas Euler number is a power of two

**Status:** independently audited **PASS**, 2026-09-05.
Auditor: `/root/x_elliptic_quotient_maps`. No breaking objections. The
parameterized bound and all ten table entries were independently checked.
[Audit record](audits/ORDINARY_ATLAS_AND_WEAK_TWO_POINT_AUDIT.md).

The finite table was also checked by exact rational arithmetic. This is a
necessary-signature theorem, not a realization theorem.

## Parameterized theorem

Let C be a genus-g curve over an algebraically closed field of odd
characteristic p, with A=2g-2 a positive power of two. Suppose C maps
representably and finite étale to an effective proper orbifold with coarse
curve P1 and exactly two stacky points: one wild and one tame. Suppose the
wild inertia is weakly ramified. Write its order as Qm, with Q a positive
power of p and m prime to p, and write N>=2 for the other inertia order.

Then

\[
                         Q\le\max(A+4,7).                 \tag{1}
\]

More precisely, every signature occurs in the following finite numerical
list construction. Choose

\[
 D\mid A,\quad Q=p^v\le\max(A+4,7),\quad c\mid Q-1,
 \qquad a=\frac{Qc+D}{Q-2}\in\mathbf Z_{>0},              \tag{2}
\]

with gcd(a,D)=gcd(a,c)=1 and p not dividing a. Choose t dividing (Q-1)/c
and require N=at>=2. Then

\[
                m=ct,\qquad
                n=\deg(C/S)=\frac A D\,aQct.             \tag{3}
\]

The list consists only of necessary local and degree data; it need not
have a global realization or occur on the specified curve C.

## Proof

Weak ramification gives different exponent Qm+Q-2 and m|(Q-1), by the
graded tame-character calculation in file13. Put x=n/(Qm) and y=n/N;
these are positive integers because an étale atlas has uniform coarse
ramification fibers. Riemann--Hurwitz is

\[
                         A=x(Q-2)-y.                    \tag{4}
\]

Set d=gcd(x,y)=gcd(x,A), x=da, y=db, and D=A/d. Then gcd(a,b)=1,
gcd(a,D)=1, and

\[
                        b=a(Q-2)-D,\qquad Nb=Qma.       \tag{5}
\]

The second equation and coprimality show that p does not divide a;
otherwise p would divide b as well. Since p divides neither N nor m,
comparison of p-adic valuations in (5) gives b=Qc with p not dividing c.
Thus Nc=ma and gcd(a,c)=1, so m=ct, N=at. The condition m|(Q-1) gives
c|(Q-1) and t|(Q-1)/c. Substitution in (5) gives

\[
                 Q(a-c)=2a+D,
\]

which implies a>c. Put k=a-c>=1. Then

\[
                   k(Q-2)=2c+D.                        \tag{6}
\]

Since c<=Q-1, if Q>D+4, (6) forces k<=2.

If k=1, (6) gives Q=2c+D+2. Since Q is odd and D is a power of two,
D=1. Also c|(Q-1)=2c+2, so c divides two; hence Q is five or seven.

If k=2, (6) forces D even and c=Q-2-D/2. Divisibility c|(Q-1) implies
c|(D/2+1), giving Q<=D+3, contrary to Q>D+4.

Therefore Q<=max(D+4,7)<=max(A+4,7), proving (1). Solving (5) for a
gives (2), and the degree formula gives (3). This proves the theorem.

## Complete necessary table for p=5 and g=9

Here A=16, so Q<=20 and necessarily Q=5. The choices D|16, c|4, and
t|(4/c) in (2)--(3) give exactly the following ten triples. In this table
e=5m is the full wild inertia order; its different exponent is e+3.

\[
\begin{array}{r|r|r}
 n & e & N\\\hline
 35&5&7\\
 60&5&3\\
 70&10&14\\
 120&10&6\\
 140&20&28\\
 160&5&2\\
 240&20&12\\
 320&10&4\\
 640&20&8\\
 2240&20&7
\end{array}
\]

The finite check substitutes each divisor choice into (2), retains the
coprimality conditions, and verifies

\[
 n\left(\frac{3}{e}-\frac1N\right)=16,
 \qquad e\mid n,\quad N\mid n,\quad m\mid4.
\]

For a common orbifold of the fixed genus-nine and genus-twenty-five
curves, the degree of the second atlas is 3n. This treats the entire weak
two-point case, including mixed inertia. It does not replace the
nonweak analysis or the missing existence of a finite common orbifold.
