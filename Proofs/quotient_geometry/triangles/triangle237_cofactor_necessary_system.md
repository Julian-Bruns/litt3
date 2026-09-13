# Proof: the degree84 differential and cofactor reductions

[Statement](../../../Theorems/quotient_geometry/triangles/triangle237_cofactor_necessary_system.md).
Author /root,2026-09-10. Focused audits by
/root/audit_degree84_differential_system certify the new dictionary
and cofactor coverage. Inherited census/endpoint results retain their
own evidence scope. No ideal has been declared empty here.

## 1. The actual quotient and its horizontal polynomial

The preceding triangle237 theorem leaves only hyperelliptic-factor
maps. Every Weierstrass point has composite index twice its quotient
index; among2,3,7 this can only be2. Thus the six Weierstrass points,
including the fixed infinity, are exactly the simple zeros of q.
The other fibers supply the monic A18,C6 and leading-minus-one B14
in the statement. Infinity gives q=s/u+O(u^-2), with s nonzero.

The ramification contribution18+28+36 equals2*42-2. Consequently
q'=-s*A*B^2/C^8, including its scalar from infinity. Differentiating
q and q-1 gives the two displayed derivative identities. In
characteristic five the second is3(BC)'+sA. Hence A4=A9=A14=0.
For the computational localization g=loc*s-1 these are exact ideal
consequences: loc*(s*a_i)-a_i*g=a_i.

The triangle scalar solution y0=t^2(t-1)^2 pulls back locally as
Y=y0(q)/sqrt(q'). For h=F^2AC, direct substitution gives

    Y^2/h^2=-s^3 A^5 B^10/C^50.

Its derivative is zero. Since2 is invertible, Y'/Y=h'/h, hence
h''=r_u h, without requiring that Y itself descend. The regular
dormant potential is r_u=2(F'/F)^2-F''/F+P/F. Expanding h=F^2H
gives

    h''-r_u*h=F*(F H''+4F'H'+(3F''-P)H).

Thus H=AC satisfies the required equation. The known quintic is
irreducible overF125; coefficient Frobenius transports all normalized
equations and the nonzero guard, allowing one beta representative.

## 2. A five-by-six kernel over the constant field

The exact script below finds H0,H1 of degree4, checks the original
ODE coefficientwise, their gcd1, and their nonzero Wronskian cF.
For any other rational solution H, write its vector(H,H') in their
invertible fundamental matrix. Differentiating that expression shows
both coefficients have derivative zero, so lie in k(u^5). Therefore
H0,H1 span all rational solutions over that constant field.

Since A4=A9=A14=0, A=sum_(j=0)^3 u^j A_j(T), with deg A_j<=3.
The equation CA=H0*f0+H1*f1 gives a vector in the stated matrix kernel
over k(T). Multiplication by C is invertible in k(u)/k(T). Its first
four columns are independent; rank is below5 exactly when BOTH
H0/C and H1/C have zero u^4-coordinate.

Write D_i(T) for the u^4-coordinate of H_i C^4 modulo u^5-T.
Division by C multiplies this by the common nonzero denominator C^5,
so both coordinates vanish precisely when D0=D1=0. Let r be any
root of the actual squarefree C. At T=r^5, the quotient algebra is
k[u]/((u-r)^5), and

    H_i*C^4=H_i(r)*C'(r)^4*(u-r)^4 mod (u-r)^5.

Consequently D_i(r^5)=H_i(r)*C'(r)^4. Because gcd(H0,H1)=1,
these cannot both vanish. Thus rank is5 for every actual C, not only
for generic six coefficients, and its signed cofactor vector is nonzero.

## 3. Primitivity removes the apparent cofactor boundary

The first four cofactor entries use three multiplication-by-C columns
and two constant horizontal columns. They have degree at most3 in T
and in the C coefficients. Thus deg_u A_raw<=18. Both the actual
kernel vector and the cofactor vector span the same line over k(T),
so A_raw=f(T)A for a nonzero rational f.

The four A_j(T) are primitive: a common nonconstant polynomial factor
would give A a factor g(u^5), with root multiplicities at least5,
contradicting the squarefreeness of the actual A. Gauss's elementary
divisibility argument therefore makes f polynomial. Since A has
degree18 and A_raw has degree at most18, f is a nonzero constant.
Its value is L, proving both L!=0 and A=A_raw/L on the entire actual
domain. This is why no omitted L=0 geometric chart must be searched.

## 4. Reproduction and limitation

    sage scripts/orbifolds/diagnose_triangle237_cofactor_reduction.sage --system-diagnostics

The generic-field kernel is checked by direct polynomial substitution;
all six signed minors are independently formed by permutation expansion
and their five kernel identities checked. The resulting A_raw satisfies
the original ODE identically, not merely at sampled C values.

The current cleared full system has22variables and86equations, including
the full passport and two inverse guards. It has31846terms and maximum
degree11. This is a reduction of variables, not a demonstrated runtime
gain: the larger term count may matter. Neither this diagnostic nor
the ongoing bounded native run supplies an emptiness result.
