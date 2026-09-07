# Coprime quotient and canonical-torsion sieves for actual cored spans

Work over an algebraically closed field. All orbifolds below are smooth,
proper, connected, effective Deligne--Mumford curves. All asserted atlases
are actual representable finite etale maps.

## 1. Disjoint inertia gives a genus inequality

Suppose T_1->S and T_2->S are finite etale of degrees a,b, with S
hyperbolic. Write c,d for the genera of the coarse curves of T_1,T_2,
and kappa=deg(omega_S)>0. If every stabilizer order on T_1 is coprime
to every stabilizer order on T_2, then

    kappa <= 2 + 2(c-1)/a + 2(d-1)/b.                    (1)

In particular, if both coarse curves are P1, then

    kappa <= 2 - 2/a - 2/b.                            (2)

The proof uses the ACTUAL stack fiber product, whose stabilizers are
trivial, and the arithmetic genus of its full reduced joint image.
It allows disconnected fiber products and wild inertia on S.

To apply this to endpoints X,Y with specified finite Galois quotients
X->T_1=[X/A], Y->T_2=[Y/B], one must prove that their actual maps to S
factor through these quotients. Equality of the coarse maps under A,B
is sufficient, because S is effective and separated. Low-degree pencil
bounds can establish this factorization; it is NOT automatic.

## 2. Uniform tame fibers carry bounded torsion classes

Let C->S be an atlas of degree N, with coarse S=P1 and tame stabilizer
orders e_i. Suppose K_C is linearly equivalent to hO, h=2g(C)-2.
Let H be the pullback of a degree-one divisor on P1, and let D_i be
the reduced fiber at the i-th stacky point, so e_i D_i is linearly
equivalent to H. Put

    E=lcm(e_i),       A=E*h/N.

Then A is a positive integer and, in Pic^0(C),

    A[H-NO]=0,
    A e_i [D_i-(N/e_i)O]=0.                            (3)

Thus low-degree torsion-exclusion results for W_r(C,O) apply to the
actual branch fibers whenever A e_i has the relevant prime support.
For example, if W_r(C,O) has no nonzero ell-primary torsion and
A e_i is an ell-power, every such fiber of size <=r is linearly
equivalent to (N/e_i)O. If that size is greater than one and less than
the gonality of C, reducedness makes it impossible.

This is a tame-fiber criterion, not a wild ramification assertion.

## 3. Fixed-pair consequence

For the fixed genus-nine X and genus-twenty-five Y, there is NO common
effective orbifold S with actual finite etale atlases from both curves
and deg(X/S)<=8. Consequently its effective common-orbifold atlas,
if one exists, must have

    deg(X/S) >= 9.                                    (4)

This is NOT a lower bound on deg(Z/Y): a jointly minimal joint image
can be only one component of X x_S Y, of smaller projection degree.

The proof combines the already audited independent-pencil and
two-primary W3 statements with (1)-(3). In the final degree-eight
case, Y's hyperelliptic map forces an actual etale map to a genus-three
curve, contradicting absolute simplicity of J(Y).

No whole dormant-oper candidate is excluded. This neither treats
larger cored degrees nor coreless spans, and does not use or prove A18.
The parametrized mechanisms (1)-(3), not the isolated cutoff8, are the
reusable content.

Version1, author proof,2026-09-07; no independent audit claimed.
[Proof](../Solutions/Sol_cored_quotient_torsion_sieves.md).
