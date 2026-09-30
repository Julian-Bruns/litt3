# A polynomial test and three-state recurrence for pointed Frobenius

Version1,2026-09-15; independently audited. Let k be algebraically closed of odd
characteristic p, let C:v²=F(u) with F monic squarefree of degree5,
and let O be infinity. Put P=p^h>=5 and A_h=F^((P−1)/2).
No ordinariness or finite-field assumption is needed.

Every nonsplit extension0->O_C->E->omega_C->0 has projective
coordinates in the Cech basis v/u,v/u²,v/u³ of H1(omega_C^-1).
After h pullbacks, write its class as

    v A_h(u)(lambda0*u^(2P)+lambda1*u^P+lambda2)/u^(3P).

The lambda coordinates range over all geometric P². For every monic
divisor R of F of degree d=0,1 or2, put S=F/R and make the following
two blocks, with column indices0<=i<=a and row indices1<=j<=−b−1:

| Source basis | a | Target b | Multiplier G |
| --- | --- | --- | --- |
| kappa*u^i | floor((P−1−d)/2) | floor((−P−6+d)/2) | R*A_h |
| (v/kappa)*u^i | floor((P−6+d)/2) | floor((−P−1−d)/2) | S*A_h |

Here kappa²=R is the two-torsion notation, including the split R1
case. Each block has n=a+1 columns and n+2 rows. Its actual entry is

    M_R,j,i(lambda)=sum_(s=0)^2 lambda_s*[u^((s+1)P−i−j)]G.   (1)

An empty-column block is automatically injective. The following
conditions are equivalent:

1. Every nonsplit pointed E has semistable F^h*E.
2. Both blocks have full column rank at every geometric projective
   lambda, for all sixteen R labels.
3. In each nonempty block its maximal minors form a basis of the
   homogeneous degree-n polynomials in lambda0,lambda1,lambda2.

Thus the exact evaluation criterion in the
[finite-height proof](../../Proofs/deformations/pointed_extensions_frobenius.md#5-replace-the-projective-charts-by-a-published-resultant)
applies directly to these polynomial coefficients. No Laurent precision,
chosen square roots of series, or numerical parameter search is needed.

Moreover all their scalar coefficients have a fixed three-state
recurrence. Let c_h(m)=[u^m]A_h, extended by zero, A_0=1, and set

    v_h(m)=(c_h(m),c_h(m−1),c_h(m−2))^t,
    B_r[j,t]=[u^(r−j+pt)]F^((p−1)/2), 0<=j,t<=2, 0<=r<p.

Then, with entrywise p-th powers and all integer m,

    v_(h+1)(pm+r)=B_r*v_h(m)^[p].                          (2)

The initial vector is v_0(m)=(1_(m=0),1_(m=1),1_(m=2))^t.
Formula(2) computes a coefficient using h digit steps. Multiplication
by R or S in(1) uses at most six such coefficients. Over F_(p^f)
the coefficient-Frobenius phases repeat with period dividing f.
This is a bounded recurrence for ENTRIES; it does not by itself
prove constant rank of the growing blocks at every h.

At the cubic characteristic-five backup, every complete block at
h2 and h3 agrees with the earlier Laurent construction after the
specified invertible parameter and target basis changes. The
existing certified semistability results are unchanged.

[Proof and matrix comparisons](../../Proofs/deformations/genus_two_pointed_polynomial_test.md).
