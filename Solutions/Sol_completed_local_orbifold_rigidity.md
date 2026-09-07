# Proof: completed branch extensions determine the effective orbifold

[Statement and audit metadata](../Theorems/Thm_completed_local_orbifold_rigidity.md).
All stacks below are effective proper orbifold curves admitting an
actual finite étale atlas by a smooth projective scheme curve.

## 1. The local extension is intrinsic, and the fiber product is étale

Given an actual atlas X→S, take its Galois closure W→S in the
finite-étale covering category. Then W→X is étale, W is a smooth
projective scheme, and S=[W/G]. At a point w the local quotient is by
its inertia group, with fixed field the completed coarse curve.
Since k is algebraically closed, the completion of W→X is trivial.
Thus X's completed extension is Galois and independent of the point
over a given coarse point. This is also
[the local-normality criterion, §3](Sol_unimodular_atlas_normality.md);
the given atlas need not be Galois.

For two atlases of the SAME S, their surjective étale fiber product
shows that these fixed-base completed extensions agree. No simultaneous
Galois closure of two arbitrary endpoint maps has been presumed.

Now suppose S_1,S_2 have matching extensions at every point of their
identified coarse curve B. Any component D of the normalization of
X_1×_B X_2 dominates both X_i: its generic field is a compositum of
finite separable extensions of k(B). Locally the tensor products are

    L_b⊗_(k((t_b)))L_b = ∏ L_b,

because L_b is Galois. Their normalized complete local rings therefore
equal those on each X_i. Both finite projections D→X_i are étale,
including at unramified points where L_b=k((t_b)).
Thus D is a common actual scheme atlas.

## 2. The presenting groupoids agree

The schemes R_i=D×_(S_i)D are normal and finite étale over D.
They map finitely to D×_B D: finiteness over D remains finiteness
over the intermediate finite base algebra. Effectiveness makes each
R_i generically the FULL separable relation D×_B D.
Hence both are the normalization of(D×_B D)_red, with identical maps.

Their identity, inverse and composition maps agree generically.
The relevant sources are reduced finite-étale covers of D and targets
are separated, so those maps agree everywhere. The groupoids coincide,
giving S_1=[D/R_1]≅[D/R_2]=S_2 over B. The converse is Section1.
Neither arbitrary gerbes nor realizability of proposed branch data is asserted.

## 3. One wild scalar can be aligned globally

For the [Hermitian local filtration](Sol_hermitian_local_normality.md),
a completed extension over a fixed parameter is aF_t up to source change,
with scalar ambiguity μ_((p²−1)/t). Identify the two coarse P¹ curves
with wild point0 and tame point∞. A GLOBAL scaling aligns the two
wild scalars; the tame completed extension is uniquely determined by
its prime-to-p order m. The remaining extensions are trivial.
Sections1–2 therefore prove uniqueness when such an orbifold exists.
The cases(t,m)=(8,7),(24,21) will now receive actual models.

## 4. The two Hermitian quotients realize the signatures

Let H:y^5+y=x^6, genus10, with G_1=PSU_3(5), G_2=PGU_3(5),
of orders126000,378000. Their rational-point stabilizers are respectively
P⋊C_8 and P⋊C_24; see
[Montanucci–Zini, §2(I) and the paragraph after(IV), pp.2–3](https://arxiv.org/pdf/1804.03398).
The rational orbit consists of all126 points of H(F_25).
Every nonidentity element of the explicit Sylow-five P fixes only
infinity. Sylow conjugacy therefore places every wild point in this orbit.

Since H/P has rational invariant u=x^25−x, Lüroth makes H/G_i rational.
The wild different is E+143 with E=1000 or3000. Hurwitz gives

    ∑_j(1−1/m_j)=2+18/|G_i|−(E+143)/E
                 =6/7 or20/21

for all other, tame short orbits. Each summand is at least1/2;
there is exactly one, of order7 or21. Thus[H/G_i] realize the two
signatures, and Section3 identifies every actual orbifold of either
type with the corresponding model. Subgroup inclusion gives a degree3
finite étale map[H/G_1]→[H/G_2].

## 5. An explicit common genus-two atlas

On the equivalent Fermat model H:X^6+Y^6+Z^6=0, take a primitive
cube root ζ. The elements D=diag(1,ζ,ζ²) and
S:(X,Y,Z)↦(Y,Z,X) lie in PSU, commute projectively and generate
A≅C_3². On XYZ≠0 put

    r_1=X³/(XYZ), r_2=Y³/(XYZ), r_3=Z³/(XYZ),
    a=r_1+r_2+r_3, b=(r_1−r_2)(r_2−r_3)(r_3−r_1).

These are A-invariant, with r_1r_2r_3=1 and∑_(i<j)r_i r_j=a²/2.
The cubic discriminant gives

    b²=−a^6/4+5a³−27=a^6+3 in characteristic five.            (1)

This defines a smooth genus-two Q′. The function a has exactly18
simple poles, at intersections with the coordinate lines: its numerator
cannot vanish there, since a sixth root of−1 has cube different from−1.
Thus deg(a)=18 and H→Q′ has degree9, necessarily separable.
Hurwitz gives18=9·2, proving it is étale, and |A|=9 identifies Q′=H/A.
It is therefore an actual atlas of both quotient stacks.

For an explicit isomorphism Q′≅Q:y²=x^5−x, its branch set a^6=2 is
a norm circle in F_25. Choose ξ∈F_25∖F_5 and β^6=2 in F_25.
The Möbius map x↦β(x−ξ)/(x−ξ^5) sends P¹(F_5) onto that circle,
identifying the hyperelliptic double covers over algebraically closed k.

Any other curve atlas C of either stack has a common finite étale
cover with Q: take a component of C×_S Q. Both actual maps already exist.

## 6. The same class contains an ordinary Fermat quartic

Let T have function field

    k(t)(u_1,u_2,u_3),   u_1²=t, u_2²=t²−1, u_3²=t²+1.

The square classes are independent by their distinct simple roots.
This C_2³-cover has six branch points, including∞, with inertia
generated by individual sign changes; Hurwitz gives g(T)=5.
The order-four subgroup of even sign changes meets every inertia
trivially. Its quotient is Q via y=u_1u_2u_3, so T→Q is étale.

The simultaneous sign change also meets no inertia and acts freely.
Its quotient has genus3. The invariant coordinates[u_1:u_2:u_3]
satisfy u_3^4−u_2^4=4u_1^4 and identify it with that smooth quartic:
the ratios determine the u_i up to simultaneous sign using
u_3²−u_2²=2. Over k it is a Fermat quartic F, and T→F is étale of degree2.

The three even nontrivial characters give a prime-to-five isogeny
from J(F) to the elliptic factors v²=t³−t, t³+t, t⁴−1.
Their squared polynomials have t⁴ coefficients3,2,3, respectively,
so F is ordinary. The Cartier–Manin entries of(t^5−t)² at4,3,9,8
all vanish, making Q superspecial. This genuine bi-étale example
rules out ordinary-versus-superspecial as an unrestricted obstruction.

The fixed genus-nine curve is not thereby shown to be an atlas.
Membership in Q's common-cover class does not imply the converse
atlas assertion; small cored cases and the coreless branch remain open.
