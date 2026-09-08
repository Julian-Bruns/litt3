Resolve the following remaining three-point torsion question for one
explicit curve over the algebraic closure of F_5. A proof or an exact
counterexample would complete this bounded part of a common-etale-cover
investigation; you are not asked to solve the common-cover problem.
You have no access to our files. All required context is below.

## Curve and exact goal

Choose a in F_25 with a²+4a+2=0. Let X be the smooth projective model of
y³=F(x), where

    F=x^10+(4a+2)x^9+(a+4)x^8+(3a+1)x^7+3a*x^6
       +4a*x^5+(3a+4)x^4+a*x^3+(3a+3)x²
       +(4a+2)x+(2a+1).

F is squarefree, g(X)=9, and O is its unique point at infinity. Prove
that there do not exist THREE DISTINCT finite nonbranch points P,Q,T,
with pairwise distinct x-coordinates, such that

    div(f)=9(P+Q+T)-27O,  f in k(X)^*.

Alternatively give an exact example, verifying its divisor on X.

## Proved inputs: do not rederive

1. L(nO) has basis x^i y^j, i>=0, 0<=j<=2, 3i+10j<=n.
   Every rational function of degree<=6 belongs to k(x). Nonzero
   classes [D-3O] in W_3 have unique effective degree-three representatives.

2. Every three-primary class in W_3 is killed by nine and is defined
   over F_(25^12). W_3[3] consists of exactly276 branch-supported classes
   including zero. An example in the goal would therefore have EXACT
   order nine. J(X) is absolutely simple and has no elliptic quotient.

3. All other effective degree-three configurations are settled: branch
   or infinite support, repeated support (including 2P+Q), and two
   different points in one x-fiber give no exact-order-nine class.
   W_2 has exactly66 three-primary classes, all branch-supported/killed3.

4. A certificate for the remaining configuration must be

       f=A+By+Cy², deg A=9, deg B<=5, deg C<=2, B,C nonzero.

   The binomial cases are excluded structurally: a cube norm of A+By
   or A+Cy² yields a nonconstant map to the Fermat elliptic curve,
   contradicting input2.

The new repeated-support exclusion used an everywhere-rank-eight8x9
Hasse matrix for L(27O) sections vanishing18 times at P. Its unique
section has norm S^18 sum(h_i S^i), with S=(x-x(P))/F(x(P)). Necessary
ninth-power conditions h_7 h_9-h_8²=0 and h_6 h_9²-h_8³=0 are coprime
polynomials in x(P). Explicit Bezout identities for both this and all
rank strata have been executed and replayed. This case is COMPLETE;
do not spend the request reproducing it.

## An exact 17x9 rank formulation of the remaining goal

Let R=x³+r_2 x²+r_1 x+r_0 be monic, squarefree, and coprime to F.
Let S=s_2 x²+s_1 x+s_0 satisfy S³=F modulo R. In k[x]/(R^9), define

    H=S^25 F^(-8).

This is the unique cube root of F lifting S: H³=F modulo R^9, since
(S³)^25=F^25 modulo R^25. It keeps the selected sheet at each of the
three roots of R, rather than forgetting sheets through a norm identity.

Form J(R,S) with rows n=10,...,26 and the following nine columns:

    B_i, i=0,...,5: [x^n](x^i H mod R^9),
    C_i, i=0,...,2: [x^n](x^i H² mod R^9).

The requested nonexistence is equivalent to rank J(R,S)=9 for EVERY
such R,S over k. A nonzero kernel gives B,C and

    A=-(BH+CH² mod R^9)_(degrees0 through9).

Then f has at least nine zeros at each selected point. Its pole bound
27 forces exactly the divisor in the goal. Thus rank drop is an actual
solution, not merely a necessary norm condition. Conversely every
solution supplies such R,S and a nonzero kernel. At a genuine solution,
the coefficients of BOTH R and S lie in F_(25^12), by uniqueness of D
and Frobenius invariance, although their roots can lie in a larger field.

## Desired output

Decide the goal by a proof or an executed, reproducible exact certificate.
Use the rank formulation if helpful, but choose your own method. Preserve
all rank strata, the nonzero resultant/discriminant conditions and the
actual sheetwise ninth-order vanishing. Ordinary derivatives do not test
high-order vanishing in characteristic five. A different curve, a generic
curve, or sampling finite fields does not decide this question.

If you cannot decide it, report the strongest new proved reduction that
materially shrinks this residual locus, with its exact remaining gap.
Rephrasing the matrix system or proposing an unexecuted search is not
new progress.
