# Proof: complementary dormant operators and horizontal sections

[Statement](../../Theorems/projective_connections/dormant_bol_complex.md).
Write L^2=omega, n=g-1, and use a.f=a^p f on scalar F_* modules.
Projection embeds the dormant descent W in F_*(L^-1); adjunction gives
p deg A<=-deg L<0 for every line subbundle A of W. Thus W is stable.

## The intrinsic complex

The rank-two oper gives D2:L^-1->L^3, locally D^2-r.
Its(p-3)rd symmetric power has scalar quotient L^(3-p) and normalized
scalar operator of order p-2,

    Q0:L^(3-p) -> L^(p-1).

Jets up to order p-3 reconstruct its horizontal section: the factorial
coefficients are units. Thus Q0 glues intrinsically, with horizontal
kernel descending to Sym^(p-3)(W). Tensor by the horizontal line
F^*L=L^p to get D_(p-2):L^3->L^(2p-1). The target is L^-1 F^*omega,
whose rank-two horizontal subsheaf is W omega.

Exactness is local in regular frames. Etale locally choose a spin frame
e_t^2=dt and horizontal solutions U,T with U a unit and Wronskian1.
The oper condition makes z=T/U an etale coordinate, with
dz=U^-2 dt and e_z=U^-1 e_t. In these compatible frames

    D2 f=U^-3 partial_z^2(f/U),
    D_(p-2) f=U^(-(2p-1)) partial_z^(p-2)(U^3 f).

The second transformation is the symmetric-power density rule tensored
by F^*L; pth powers are horizontal. The scalar maps are consequently
partial_z^2 and partial_z^(p-2). On1,z,...,z^(p-1) over the Frobenius
target their ranks are p-2 and2, consecutive compositions vanish,
and the first image is the second kernel. Cartier descent identifies
that kernel with L Sym^(p-3)(W), and the final image with W omega.
This includes p=3, where Q0 is the ordinary first derivative.

This quotient is the rank-two case of Wakabayashi,
[Duality for Dormant Opers, Proposition5.2.2 and Remark5.2.3,
pp308-309](https://www.ms.u-tokyo.ac.jp/journal/jms240301.pdf#page=38).
In the source's notation B=L,
alpha:W^vee->F_{C/k*}(B^vee), and
H=F_{C/k}^*(Coker(alpha)); the proposition identifies H with the
complementary dormant rank-(p-2) oper. The local calculation identifies
its descent with L Sym^(p-3)(W). Relative and absolute Frobenius differ
by the base-field twist.

## Twists, dimensions and residue duality

Tensor(1) by N and use F^*N=N^p to obtain(2), with middle kernel
I=L Sym^(p-3)(W) N. If d=deg N>3n/p, then

    H1(L^-1 N^p)=0,    H1(I)=0,    H1(W omega N)=0.

The first is a degree bound, the second follows from the first short
exact sequence, and the third is Serre dual to H0(W N^-1)=0 by stability.
Thus the final global map is onto. Riemann--Roch gives

    h0(W omega N)=2(n+d),    h0(L^3 N^p)=2n+pd,

so its kernel has dimension(p-2)d. The first sequence identifies its
quotient by the preceding global image with H1(W N).

Dualize the second short exact sequence and tensor by omega.
Finite-Frobenius duality gives

    (F_*(L^3 N^p))^vee omega = F_*(L^-1 N^-p).

Locally this is the perfect Cartier pairing on1,z,...,z^(p-1).
The left term is W N^-1, and the quotient I^vee omega has no H0
because H1(I)=0. The induced H1 map is therefore injective, with
image the annihilator of the global kernel.

It is a nonzero constant times the scalar horizontal inclusion:
for f=sum a_i z^i, the final derivative is
(p-2)!(a_(p-2)-a_(p-1)z). Its determinant pairing with a+bz equals
-(p-2)! times the coefficient of z^(p-1) in(a+bz)f.
This proves(3), including its image and normalization.

## Global generation and simple scalar zeros

Suppose d>=2g-1=2n+1. The Serre-dual obstruction to evaluation at P
is W N^-1 omega(P), stable of slope2n+1-d<=0. It has no section,
including at slope zero, so W N is globally generated.
Riemann--Roch gives h0(W N)=2(d-n). The incidence of sections vanishing
at some point of a curve has codimension at least one for a generated
rank-two bundle. Thus a general section is nowhere zero.

In a flat spin coordinate its scalar projection, in regular density
frames, is a(z)^p+z b(z)^p. This and its first derivative vanish together
exactly when a and b vanish at the point, which is precisely a zero
of the descended section. Hence a nonzero scalar tensor has reduced
zeros exactly when its descended section is nowhere zero.

## Characteristic five and the horizontal tower

For p=5, differentiating U^2,UT,T^2 with D^2U=rU gives
Q0=D^3-4rD-2Dr=D^3+rD+3Dr. These are the scalar atlas operators.

For N=L tau^2, tau^3=O gives N^5=L^5 tau. Substitution yields(4),
I_tau=Sym^2(W) omega tau^2, and the dual source W L^-1 tau.
Here d=n and chi(V)=0, giving the dimensions and the nonacyclic gap.

For N=L tau^2 omega^j, the first term of(2) is V omega^j and its
scalar line is omega^(2+5j) tau. For j>=1, its degree d=(2j+1)n
is at least2n+1, so the preceding global-generation and dimension
calculation applies. This proves the full horizontal tower and its
reduced-zero assertion, in every genus.

Finally det V=omega tau gives Hom(V,omega^2 tau)=V omega by
rank-two duality; surjections correspond to nowhere-zero sections.
At tau=O, linearizing the dormant equation r''-3r^2=0 gives
(delta r)''-r delta r=0, exactly the j=0 scalar kernel.
Jets, the oper connection and Frobenius descent commute with etale
pullback, completing the stated compatibility.
