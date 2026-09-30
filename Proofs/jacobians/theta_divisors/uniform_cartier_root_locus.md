# Proof: the root dictionary and Cartier kernel bundle

[Statement](../../../Theorems/jacobians/theta_divisors/uniform_cartier_root_locus.md).

## 1. Compressing the weight to a residue

Let s have weight d, divisor eD, er=2d. Choose1<=u<=4 with ud=1mod5,
write q=(ud-1)/5, and ue=5b+a with0<=a<=4. Since5 does not divide d,
neither e nor r is divisible by5; ar=2mod5, so a!=0. A leading zero
of order4mod5 has nonzero Cartier image. Thus Cartier-zero excludes
a=4 and r=3mod5, leaving exactly the stated values of a.

Divide s^u by the fifth power of the canonical section of O(bD).
This gives the specified section sigma with divisor aD of

    omega tensor L_s^5, L_s=omega^q(-bD), deg L_s=j=(ar-2)/5.

Its twisted Cartier image vanishes iff C_(C,q)(s^u)=0, by the product
rule. Put M=Fr_Pic(L_s), where coefficient Frobenius satisfies
V Fr_Pic=[5], Fr_Pic V=[5]. Then V(M)=O(aD)omega^(-1).

## 2. One prime-to5 point, with an exact converse

Write ell=[D-rO], mu=M-O(jO1). The relation just obtained is
V(mu)=a ell. Choose integers c,z with ac+5z=1. Set

    theta=c mu+z Fr_Pic(ell).

Then V(theta)=ell and a theta=mu. These formulas give an isomorphism
between the two parameter descriptions; they do not choose a division
point noncanonically. Since omega=O(2O),

    L_s=O(jO) tensor ell^(-b),
    M=O(jO1) tensor theta^(-5b)
     =O(jO1) tensor theta^a.

It follows that theta^(a+5b)=theta^(ue)=O. The integer ue is prime
to5, proving that an actual tensor selects a prime-to5 theta.

Conversely suppose theta is prime-to5 and(D,theta) lies in Z_r.
Put d0=r/gcd(r,2), e0=2/gcd(r,2) and N=ell^e0. Its order n is
prime to5. There is a unique tensor up to scalar of weight d=d0 n
and divisor eD, e=e0 n, because N^n=O. For u,q,b as in Section1,
V(theta^e)=N^n=O. But theta^e has prime-to5 order and ker V is a
5-group, so theta^e=O. Hence theta^(-5b)=theta^a and its compressed
section is exactly the specified section in Z_r, up to scalar. It is
Cartier-zero, proving the converse. Minimality of n proves the minimal
weight statement. The same calculation, or the generalized Cartier
product rule, handles larger p-prime powers.

V is an isomorphism on prime-to5 torsion, so a fixed ell has at most
one prime-to5 lift. Other geometric lifts are only a relaxation of
the tensor criterion.

## 3. The parameter space and the codimension bound

The isogeny V is finite flat of degree25, and etale if C is ordinary.
Thus T_r is projective and finite flat over Sym^r(C). To see it is
connected, factor V into a radicial isogeny followed by its etale
quotient torsor. The Abel map identifies H1_et(-,F5) of J(C) and C,
so the latter torsor stays connected along P -> P+(r-1)O, hence over
Sym^r(C). Radicial base change preserves connectedness.

For r>=3 all degree-r line bundles have h0=r-1 and H1=0; the usual
Poincare family therefore realizes T_r as a P^(r-2)-bundle over J1.
Its tautological section line gives the specified section of O(D).
Taking its ath power, and using M=O(jO1)theta^a, gives the specified
line in H0(omega tensor V(M))=H0(O(aD)). Normalizations differ only by
a line from the base, which does not change any vanishing locus.

For r>=4 allowed, j>0. The twisted Cartier target has fiber
H0(omega_(C^(1)) tensor M) and constant rank j+1: its degree is j+2>2
and H1 vanishes by Serre duality. The domain has constant rank ar-1.
Cohomology and base change make these vector bundles, and Cartier is
a relative bundle map. Its restriction to the specified section line
is locally a column of j+1 equations. Krull's height bound gives the
claimed component dimensions, also after restricting to reduced D.
The cases r=1,2 have j=0 and are not included in this constant-rank claim.
