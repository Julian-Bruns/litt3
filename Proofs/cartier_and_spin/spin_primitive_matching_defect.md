# Proof: the actual global-primitive obstruction

[Statement](../../Theorems/cartier_and_spin/spin_primitive_matching_defect.md).
Author /root,2026-09-08. This is a condition on both maps from the same
source, not a one-endpoint criterion presumed to exclude all covers.

Tensor 0->O_(C_1)->F_*O_C->B_C->0 by L_1. The projection formula
identifies its middle term with F_*L^p, and its map to B_C L_1 with the
canonical connection, viewed in the kernel of twisted Cartier. Taking
cohomology gives (1), because H1(C,L^p)=0: p(g-1)>2g-2. Serre duality
and L_1^2=omega_(C_1) give h1(L_1)=h0(L_1)=h0(L). This proves all
assertions concerning the obstruction and ambiguity. Naturality under
etale maps gives the equality of pulled-back boundary classes.

In a frame l of L, write b=b_l l^p. Since transition functions of L^p
are p-th powers, nabla(b) has coefficient db_l. Equality nabla(b)=h
means db_l=h_l eta_l. Thus on the root cover

    d(b_l/w^p)=h_l*pi^*eta_l/w^p=w^2*pi^*eta_l=alpha.

The ratio is globally defined and regular off the root divisor. At a
point P of D, the differential db_l has a simple zero. If b_l(P)=0,
its zero order is exactly2: a simple zero would give nonzero derivative,
and order>=3 would give differential order>=2, since p>2. On the root
curve, b_l therefore has order2ell and w^p has order p. The ratio has
order2ell-p=ell+2. If b_l(P)!=0 it has pole order p. Counting these poles
proves the degree formula. This argument uses the zero order of db_l,
not an invalid converse from a zero ordinary derivative to high-order
vanishing.

For completeness the corresponding base-curve ratio is
R_b=b^(p+2)/h^p. Put B=div(b). Locally in a spin frame the canonical
connection gives db_l=h_l eta_l. Ordinary differentiation, with the
denominator h_l^p horizontal, gives

    div(R_b)=(p+2)B-pD,
    div(dR_b)=(p+1)B-(p-1)D.

The second expression is a canonical divisor: its degree is2g-2, and
the frame transformations cancel since
p(p+1)-(p-1)(p+2)=2. At B outside D, b has a simple zero because its
derivative is nonzero. At B intersect D, its zero order is2 as above.
Thus the zero ramification indices are p+2 and p+4 respectively. At
D outside B the pole index is p, and the different exponent is
ord(dR_b)+2p=p+1. At every other point dR_b is a unit and R_b is finite,
so there is no further ramification. The derivative is not identically
zero. Finally deg(B)=p(g-1) gives the counts and the degree formula.
For p=5,g=2, one has0<=c<=2, giving25,30,35. No assertion about equal
completed wild fields follows merely from these different exponents.

For the actual span, f^*b_X-g^*b_Y has zero canonical connection, hence
belongs to F_Z^*H0(Z_1,L_(Z,1)). This map on sections is injective, so
t is unique. Changing either endpoint primitive adds an endpoint
horizontal section; this changes t by exactly a term in the denominator
of (2). The resulting quotient class is therefore well defined.

If it vanishes, adjust the two endpoint primitives by such horizontal
sections so that f^*b_X=g^*b_Y. The quotient of spin sections

    R_X=b_X^ell/h_X^p in k(X),   R_Y=b_Y^ell/h_Y^p in k(Y)

has equal pullbacks. These are rational functions because both numerator
and denominator are sections of L^(p*ell). Neither is constant: if
b_X^ell=c*h_X^p, then ell*div(b_X)=p*D_X, which is impossible at a point
of the nonempty REDUCED divisor D_X since ell does not divide p. Nor is
b_X zero, since nabla(b_X)=h_X!=0. Hence the field intersection contains
a nonconstant element and the span is cored.

For the dimension bound (3), the two spaces of pulled-back spin sections
have zero intersection in a coreless span with this reduced h. Otherwise
nonzero t_X,t_Y have equal pullbacks. The functions
h_X/t_X^ell and h_Y/t_Y^ell would have equal pullbacks, and could not be
constant because div(h_X)=D_X is reduced whereas ell*div(t_X) is
ell-divisible. They would again provide a core. Pullback itself is
injective on global sections. Thus their sum has dimension h0(L_X)+h0(L_Y),
and a nonzero epsilon requires at least one additional dimension.

Finally, if H0(Z,L_Z)=0, injectivity of pullback gives H0(X,L_X)=
H0(Y,L_Y)=0. Both endpoint boundaries vanish by (1) and spin Serre
duality, and epsilon=0 because its ambient source section space is zero.
The preceding argument applies. This does not assert that the unknown
source spin line is non-effective, or that effectivity is impossible.

## Boundary-independent primitives and their repeated powers

Put a=(p+1)/2, b=(p+3)/2. The identity h^(p+1)=h^p h and Cartier's
projection formula put s^a in the kernel of the twisted Cartier map
on omega tensor(omega^b)^p: indeed ell*a=1+p*b. Tensoring the first
Cartier exact sequence by omega_(1)^b gives the connection on omega^(p*b)
and obstruction H1(omega_(1)^b). This group is zero by Serre duality,
as b>1 and the genus is at least two. Thus Q exists globally regularly.

Their difference on the actual common source has zero connection,
hence is uniquely F^*R. Changing Q_i by a horizontal section changes
R by an endpoint weight-b section, proving well-definedness of the class.

Here is a direct proof of nonvanishing that requires no one-clump theorem.
Any nonzero common rational canonical tensor tau of weight m satisfies
tau^ell/s^m in k(X) intersect k(Y)=k*. At a point of the reduced D,
ell*ord(tau)=2m. Since ell is odd, ell divides m. If the mismatch class
were zero, adjusted primitives would give a nonzero common weight-p*b
tensor (its connection derivative is s^a!=0). But p*b=ell*a-1, so
ell does not divide p*b. This contradiction also works after any further
common-source refinement: the ORIGINAL embedded endpoint fields and
their intersection do not change. Replacing the endpoint fields by
larger ones is not justified by this argument and may create a core.

Finally multiplication by s_i^(p*j) is horizontal, and therefore
nabla(s_i^(p*j)Q_i)=s_i^(a+p*j). The two primitives differ by

    s_Z^(p*j) F_Z^*R = F_Z^*(s_(Z,1)^j R).

Multiplication by s_(Z,1)^j also takes endpoint weight-b sections into
endpoint weight-(b+j*ell) sections. This proves the claimed equality
of quotient classes, independently of choices. Each is still nonzero
by the same rational-weight test, since its primitive weight is
p*(b+j*ell), congruent to-1 modulo ell. Mere repetition of the power
construction thus propagates one obstruction rather than adding new ones.
