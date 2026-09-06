# Prime-ratio diamonds and the corrected coefficient reduction

Cleaned by /root, 2026-09-06. The numbering below is retained for
dependencies. The previously asserted general quadratic intersection
was rejected by the 2026-09-04 audit of c14_elliptic_translation:
[audit metadata](audits/66_68_QUADRATIC_CORE_FIELD_INTERSECTION_AUDIT.md).
Its invalid proof and unconditional divisor list have been removed.
The complete corrected replacement is
[file81, independently audited PASS](81_FULL_ORBIT_INTERPOLATION_AND_CUBIC_SIGN_MONODROMY.md).

The prime-ratio diamond, norm bound, nonpencil theorem, case A, and
direct case-B Prym inequality below are retained. The quadratic-square
conclusions in case B require the displayed EXTRA intersection hypothesis;
it is automatic when the coefficient degree is two. This is a reduction,
not an all-degree common-cover exclusion.

All curves are smooth projective connected over an algebraically closed
field. Let r be an odd prime and g(X)=s+1, g(Y)=rs+1, s>=1.

## 1. The prime-ratio diamond (Theorem 68.1)

A common finite etale cover gives an equal-degree diagram

    V --a--> Y,     V --p--> C --c--> X,
    deg(p)=r,      deg(a)=deg(c)=M,

where p is a C_r-torsor with generator beta and a beta!=a.

**Proof.** Take a Galois closure W->X of a common cover, with group G
and induced degree-N etale map W->Y. Riemann--Hurwitz gives |G|=rN.
A Sylow r-subgroup P has order r^{v_r(N)+1}, so W->Y cannot descend
through W/P. In a composition series
1=P_0 normal P_1 normal ... normal P_j=P, with successive quotients C_r,
choose the first step where the map ceases to be invariant. Set
V=W/P_i, C=W/P_(i+1), M=N/|P_i|. The induced maps are etale and
deg(C/X)=|G|/(r|P_i|)=M. QED.

## 2. Norm obstruction (Lemma 68.2, Theorem 68.3, Corollary 68.4)

**Lemma 68.2.** If p:R->D is finite separable of degree r and b:R->Y
is finite, then p_*b^*=0 on Jacobians implies a degree-r pencil on Y.

**Proof.** The Rosati-dual homomorphism is induced by the family
d |-> O_Y(b_*p^*d) in Pic^r(Y). If it is zero, these moving divisors
lie in one complete linear system. They have no common base point:
for any y, parameters whose divisor contains y form the finite set
p(b^{-1}(y)). The family is nonconstant since b is surjective. Thus the
complete system is basepoint-free and has positive dimension. Two
suitable sections without common zeros give a degree-r map to P1. QED.

Assume J(Y) is absolutely simple and Y has no degree-r pencil.
For h=p_*a^*:J(Y)->J(C), the lemma implies h!=0, hence dim im(h)=rs+1.
The composite c_*h is zero because g(X)<g(Y). Thus

    rs+1 <= dim Prym(C/X)=(M-1)s,  so M>=r+2.       (68.13)

This is Theorem 68.3. If char(k)!=2,r and Y is hyperelliptic,
the missing pencil hypothesis follows: a degree-r map and the
hyperelliptic map have coprime degrees and generate k(Y), so
Castelnuovo--Severi would give g(Y)<=r-1, a contradiction.
This is Corollary 68.4.

## 3. The coefficient curve and nonpencil result (Proposition 68.4a)

For the remainder assume char(k)!=2,r, Y hyperelliptic with simple
Jacobian, and write k(Y)=k(t,z), z^2=f(t). Put F=k(C), K=k(V).
The element t is primitive in K/F: if beta fixed t, its odd order
would also force it to fix z, contradicting a beta!=a.

The homogeneous norm of the hyperelliptic pencil is a degree-r binary
form. Its r+1 coefficients generate a basepoint-free line bundle L on C
of degree2M. Their span W satisfies

    3 <= dim W <= r+1.                              (68.17a)

**Nonpencil proof.** Dimension one cannot generate a positive-degree
line bundle. If dim W=2, the coefficient pencil expresses V as the
normalized integral fiber product of maps

    C -> P1_b of degree2M,   R:P1_t -> P1_b of degree r.

Let A be the 2rs+4 hyperelliptic branch points and B=R(A).
For b in B put k_b=|A intersect R^{-1}(b)| and let l_b count the
other points in that fiber. Etaleness of V/C and the fact that
V->P1_t has local indices2 on A and1 elsewhere imply a common
local index2*rho_b for every point of C above b, and indices rho_b
at the A-points and2*rho_b at the other points of R^{-1}(b).
Consequently

    r=rho_b(k_b+2l_b),  rho_b in {1,r},  k_b odd.

The contribution above b to Diff(C/P1_b) is at least
(M/rho_b)(2rho_b-1)>=M. Its total degree is2M(s+2); hence |B|<=2s+4.
Since k_b<=r, |B|>=ceil((2rs+4)/r), and the sum of the odd k_b is
even. Thus |B| is2s+2 or2s+4. The same index identities give

    R^*B = A modulo2.

The double cover of P1_b branched at B therefore receives a degree-r
map from Y. Its genus is s or s+1, positive and strictly below g(Y),
contradicting simplicity of J(Y). QED.

Let B now denote the smooth normalized coefficient image, with
q:C->B, coefficient degree e=[F:k(B)], and image degree d. Thus
L=q^*A_B, deg(A_B)=d, and ed=2M. Put E=k(B)(t).
The degree-r norm polynomial is irreducible over F, hence over k(B).
The incidence equation has bidegrees r,d, giving

    [E:k(B)]=r,  [K:E]=e,  [E:k(t)]=d,  FE=K.

## 4. Correct scope of the square-root dichotomy (Theorem 68.5)

### A. z belongs to E — unconditional

The maps V->E->Y are finite etale, of degrees e and n=M/e=d/2.
Trace functoriality and Lemma68.2 give

    q_*h=[e](E/B)_*(E/Y)^* != 0,
    rs+1 <= g(B) <= ns+1,  n>=r.

With eta_A=ns+1-g(B), Riemann--Hurwitz gives

    deg Diff(C/B)=2e eta_A,  deg Diff(E/B)=2r eta_A.

Thus these lower maps are etale simultaneously; n=r forces eta_A=0.
For separability of C/B, base change by E gives K/E, which is an
intermediate extension of the etale extension K/k(Y).

### B. z does not belong to E — unconditional part

Set E'=E(z). Then E'/E is quadratic, e is even, [K:E']=e/2,
and E'->Y is finite etale of degree d. Always

    q_*h=0,  im(h) subset Prym(C/B),  g(B)<=(M-r)s.  (68.27)

**Proof.** Let gamma generate E'/E and b:E'->Y. It induces the
hyperelliptic involution on Y. For pi:E'->E,

    pi^* pi_* b^*=(1+gamma^*)b^*=0,

so pi_*b^*=0, since pi^* has finite kernel. Factor the full trace
V->B through E'->E->B to obtain q_*h=0. The dimension of im(h)
is rs+1, giving (68.27). This proof uses no field-intersection formula.
The extension C/B is separable, for example by file81's full-orbit
construction, so the stated Prym dimension is valid. QED.

### B. Additional quadratic-square consequences — CONDITIONAL

Impose the extra hypothesis

    D=F intersect E' has [D:k(B)]=2.                 (*)

Then m=e/2, [F:D]=m, [E':D]=r, and F tensor_D E'=K: the equality
of the latter degree with [K:F]=r proves linear disjointness.
The normalized square has lower maps C->D and E'->D of degrees m,r.
Writing h_D=(E'/D)_*(E'/Y)^*, Lemma68.2 and base change give

    h_D!=0, h=(C/D)^*h_D,
    rs+1 <= g(D) <= ds+1,  d>=r,
    eta=ds+1-g(D),
    deg Diff(C/D)=e eta,  deg Diff(E'/D)=2r eta.

Thus d=r forces eta=0. Hypothesis(*) is automatic when e=2:
then E'=K, so F intersect E'=F and [F:k(B)]=2.
It is NOT justified in general by compositum degrees.

## 5. Correct replacement for the former divisor list (Corollary 68.6)

The old unconditional case-B list, including e in {1,2} in the
initial interval or at prime M, is withdrawn. Use
[file81, Theorems81.1--81.2](81_FULL_ORBIT_INTERPOLATION_AND_CUBIC_SIGN_MONODROMY.md):
the coefficients of the FULL interpolation polynomial Q(t_i)=z_i
generate an intermediate field D with

    j=[D:k(B)]<=2^r,  m=[F:D],  e=mj,
    m divides M,  N=M/m=jd/2>=r.

Here j=1 is case A; otherwise j is even. For r3,
j is in {1,2,4,8}. This retains all sign choices and replaces the
unproved quadratic intersection. Its proof and group refinements are
retained in file81, not duplicated here.

The unconditional odd-degree observation survives: odd e implies
case A, so odd e>1 forces M>=3r. The stronger case-B divisor list
may be used ONLY after separately proving (*).
