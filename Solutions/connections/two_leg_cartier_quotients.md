# Proof: the only defects are common Cartier tensors

[Statement](../../Theorems/connections/two_leg_cartier_quotients.md).
The no-intersection case is from the user's NC Pro response2026-09-08;
the general defect formulas and arbitrary-characteristic formulation
are the main agent's extension. Both fields retain their actual embeddings.

For each of A,B,M the p-basis expansion gives ker D=M^p,
ker C_x=D(M), and surjective C_x. For example
C_x(x^(p-1)c^p)=c. The change-of-coordinate rule is

    C_x(b^(pm+1)h)=b^(m+1) C_u(h).

These prove that all maps in the statement are well-defined, including
their restrictions to the I_j. The p-basis fact follows directly from
[Stacks 0CCV, Lemma53.13.3](https://stacks.math.columbia.edu/tag/0CCV)
over a perfect constant field; Cartier's rule also follows by writing
the same differential in the two separating coordinates.

## The Frobenius kernel

If a^p=A0+b^(pm)B0, differentiation gives

    tau=DA0=-b^(pm+1) B0' in I_(pm+1), C(tau)=0.

Changing the endpoint decomposition changes tau by D(I_pm). Changing
a by an endpoint sum does not change that quotient class. If its class
is zero, subtract an element of I_pm to make both endpoint derivatives
zero. The two terms are then endpoint p-th powers; their unique roots
show [a]=0 in Q_m. Conversely, given tau in I_(pm+1) with C(tau)=0,
Cartier-zero holds in both endpoint fields. Integrate it separately as
DA0=tau and B0'=-tau/b^(pm+1). Their sum A0+b^(pm)B0 has derivative
zero and hence equals a^p in M. This constructs the inverse and proves
the first defect formula. These identifications are additive; Frobenius
and inverse Frobenius affect their scalar conventions.

## The middle defect

If Da=A0+b^(pm+1)B0, then

    c=C_x(A0)=-b^(m+1)C_u(B0) in I_(m+1).

Different endpoint decompositions change c by C(I_(pm+1)); changing a
by an endpoint sum changes nothing. If c is in that image, adjust the
decomposition to make both Cartier images zero, integrate separately,
and conclude [a] is in im F. Conversely, for any c in I_(m+1),
surjectivity of endpoint Cartier gives A0,B0 with the two displayed
Cartier values. Their sum has Cartier zero, so is Da for some a in M.
This proves the second defect formula.

If C_x(a)=A0+b^(m+1)B0, choose endpoint Cartier preimages A1,B1.
Then a-A1-b^(pm+1)B1 has Cartier zero and is a derivative. This proves
exactness at Q_(pm+1), without any intersection assumption. The final
surjectivity follows from that of C_x. The asserted exact sequence and
iterated saturation now follow.

For the geometric no-clump application, a nonzero common rational tensor
would have a common saturated pole set, hence a clump; if regular it
would directly violate the hypothesis. Therefore all positive I_j vanish.
Neither ordinarity nor Hom(J_X,J_Y)=0 was used. No bound on a rational
primitive's poles, and no common projective connection, was deduced.
