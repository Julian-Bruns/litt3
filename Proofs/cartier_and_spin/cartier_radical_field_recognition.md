# Proof: the Cartier radical and a rigid weight-31 tensor

[Statement](../../Theorems/cartier_and_spin/cartier_radical_field_recognition.md).
22 September 2026;
[independent audit: PASS](../../Research/audits/CARTIER_RADICAL_LINE_RECOGNITION_AUDIT_2026_09_22.md).
Both original common-cover problems remain open.

Let h_i:T->X be actual finite etale maps from the same smooth proper
connected curve to the fixed genus-nine X. Put C=X^(1), and let
ell=U^perp=O_C(-3O) be the canonical radical of the saturated
evaluation hyperplane of its three exact forms. Inside B_T on T^(1),
write ell_i=h_i^(1)*ell. Then
\[
\boxed{\ell_i=\ell_j\quad\Longleftrightarrow\quad
h_i^*k(X)=h_j^*k(X).}
\tag{1}
\]
The equality is of the actual embedded subbundles, not just their
isomorphism classes. Equivalently h_j=gamma^e h_i for some e in
{0,1,2}. This does not assert that generic orthogonality of DISTINCT
lines forces equality.

The proof constructs a weight-31 tensor with thirty-one reduced
zero locations, each of multiplicity sixteen. A literal
tensor-preserving orbifold atlas of X has degree one. Scalar sharing
is handled by rescaling the second labeled endpoint, not by declaring
the chosen tensor invariant under the cubic automorphism.

## 1. The radical's Frobenius evaluation

The inputs are the
[evaluation lattice](../../Theorems/cartier_and_spin/cartier_kernel_generated_subbundle.md),
the [symplectic splitting](../../Theorems/cartier_and_spin/cartier_symplectic_reduction_split.md),
and the [certified Wronskian](../../Proofs/cartier_and_spin/fixed_x_kernel_wronskian.md).
They give
\[
\ell=\mathcal O_C(-3O),\quad\omega_C=\mathcal O_C(16O),\quad
\operatorname{div}(\det\mathrm{ev})=R+3O,
\]
where R consists of the ten cubic branch points. Write
F=F_X:X->C. Adjunction for B_X subset F_*omega_X gives a canonical
nonzero morphism
\[
\varepsilon:F^*\ell\longrightarrow\omega_X.
\tag{2}
\]
Its degree of zeros is 16-5(-3)=31. We now determine the divisor,
rather than using only its degree.

Let s_0,s_1,s_2 be the three global exact sections and beta their
actual alternating Cartier pairing. Symplectic contraction gives
an isomorphism det U=ell tensor omega_C and the section
\[
r=\beta(s_1,s_2)s_0-\beta(s_0,s_2)s_1
       +\beta(s_0,s_1)s_2\in H^0(C,\ell\otimes\omega_C).
\]
In a symplectic frame this is precisely the image of
s_0 wedge s_1 wedge s_2; hence div(r)=R+3O, including the
evaluation multiplicities at infinity.

Use theta=dx/y^2 and the established coefficient polynomials
s_i=q_i(x)theta, beta(s_i,s_j)=b_ij(x)theta. In the recorded
absolute-Cartier convention, Frobenius pullback and evaluation give
\[
(\varepsilon\otimes1)(F^*r)
=\bigl(b_{12}^5q_0-b_{02}^5q_1+b_{01}^5q_2\bigr)\theta^6
=3P(x)^2W(x)\theta^6.
\tag{3}
\]
The powers here are full polynomial fifth powers. Thus both
coefficients and exponents are raised to fifth powers; no scalar
twist is suppressed. The small exact
[verifier](../../scripts/arithmetic/cartier_radical_evaluation.py)
checks this identity from the previously recorded q,b,P,W rows;
the [exact receipt](../../../litt3-computation-data/cartier_radical_contact_20260922/evaluation.json)
records the common degree-27 coefficient row. The independent audit
replayed the identity without importing the verifier's arithmetic module.

The right side of (3) has divisor
6R+x^*div_0(W)+15O. Subtracting F^*div(r)=5R+15O gives
\[
\operatorname{div}(\varepsilon)=D:=R+x^*\operatorname{div}_0(W).
\tag{4}
\]
The Wronskian has seven simple roots disjoint from P. Therefore D
is reduced of degree 10+3*7=31. This identifies the existing
Wronskian residue support as an invariant of the embedded radical
line itself, independent of its chosen three global generators.

Choose a trivialization ell^16 tensor omega_C^3=O_C. It is unique
up to a scalar. The canonical line-bundle identification
F^*omega_C=omega_X^5 then turns the sixteenth power of (2) into
\[
\Psi_X\in H^0(X,\omega_X^{31}),\qquad
\operatorname{div}(\Psi_X)=16D.
\tag{5}
\]
Explicitly Psi_X is a nonzero scalar multiple of
(y W(x))^16 theta^31. In particular gamma^*Psi_X=zeta_3^2 Psi_X.
It is NOT literally invariant under gamma.

## 2. Equality of pulled lines supplies exact tensor matching

All constructions above commute with the actual etale maps, using
B_T=h_i^(1)*B_X and the cartesian relative-Frobenius squares.
If ell_i=ell_j as embedded subbundles, their adjunction morphisms
F_T^*ell_i->omega_T coincide. The two pulled trivializations of
ell_i^16 tensor omega_(T^(1))^3 differ by a global unit on the
proper connected curve T^(1), hence by a constant. Consequently
\[
h_i^*\Psi_X=c\,h_j^*\Psi_X\qquad(c\in k^*).
\tag{6}
\]
Place Psi_X on the FIRST labeled copy of X and c Psi_X on the
SECOND. These specified tensors now have equal pullbacks.

The [ramified-root contact theorem](../../Theorems/shared_tensors/ramified_root_contact_core.md)
applies with weight w=31, zero multiplicity a=16, and characteristic
five. Indeed 5 does not divide w(a+w), the first contact index is
q=4, and w(q-2)=62>16. It supplies a core and a common effective
proper smooth DM curve via its finite TENSOR-PRESERVING groupoid.
The specified tensors descend along that groupoid to one literal
rational canonical tensor on the coarse curve. In particular the
FIRST X-atlas pulls that tensor back to Psi_X exactly.

This last step does not assert that a chosen trivialization descends
merely because ell does. Exact matching in (6), after rescaling the
second endpoint, is what makes the preserving groupoid available.
For h_j=gamma h_i it permits two degree-one endpoint identifications
with differently scaled tensors; it does not quotient the first
tensor by gamma.

## 3. A literal weight-31 atlas has degree one

We prove the needed quotient assertion for ANY regular weight-31
tensor on this X whose divisor is 16D with D reduced of degree31.
Suppose X->S is a representable finite etale atlas of a smooth proper
effective DM curve and the tensor descends literally. Let n be the
atlas degree and C_0 the coarse curve. The coarse map X->C_0 is
finite separable of degree n.

If g(C_0)>0, its Jacobian is an isogeny subfactor of the geometrically
simple J(X). It must therefore have dimension nine. Riemann--Hurwitz
then gives n=1. It remains to rule out C_0=P^1.

For a coarse point b, write e_b for its inertia order and delta_b
for its different exponent in the local atlas. A representable etale
SCHEME atlas has uniform local ramification over b: after a strictly
henselian quotient chart, every component is the same inertia torsor.
Thus e_b divides n, there are n/e_b points above b, and the same
different occurs at each. This uniformity would be false for an
arbitrary finite separable map, which is not the object used here.

Let r_b be the order of the descended rational tensor. At every
point above b its pulled-back order m_b is either 0 or16 and
\[
m_b=e_b r_b+31\delta_b.
\tag{7}
\]
Hence D is a union of full coarse fibers. Let k be the number of
UNRAMIFIED coarse fibers in D. Each contributes n points, so nk<=31.

The derivative character of the inertia has cyclic prime-to-five
image of order m, with wild kernel of order 5^a; see
[Stacks, Lemma15.114.5](https://stacks.math.columbia.edu/tag/09E3).
Invariance of the
leading tensor term gives m dividing m_b+31. Therefore a tame
branch has e_b=31 off D or e_b=47 on D, and in either case r_b=-30.
At a wild branch, put q_b=5^a>=5 and
u_b=delta_b-(e_b-1). The lower-ramification formula
delta_b=sum_(j>=0)(|I_j|-1) gives
u_b>=q_b-1>=4. Equation (7) becomes
\[
r_b+31=\frac{m_b+31-31u_b}{e_b}<0,
\]
so the integer r_b is at most -32. There are no other poles. At
unramified points the tensor has order16 on D and order0 elsewhere.
Since its coarse degree is -62, if t is the number of tame branches,
\[
16k-30t-\sum_{\mathrm{wild}\ b}(-r_b)=-62,
\qquad-r_b\ge32.
\tag{8}
\]

First suppose k=0. The only possibilities in (8) are:

- one wild pole of order62 and no tame pole;
- one tame pole of order30 and one wild pole of order32.

In the first case (7) at the wild point gives
m_b=31(delta_b-2e_b), which cannot be16. No coarse fiber can then
supply D, a contradiction.

In the second case, a wild point in D would satisfy
31delta_b-32e_b=16, hence e_b=15 modulo31. But at a D-point the
tame quotient divides47, so e_b=5^a or47*5^a. The order of5
modulo31 is3; the possible residues are
1,5,25,16,18,28, never15. Thus the wild fiber is outside D.
The unique tame branch must supply all of D and has inertia47.
Then n/47=31, so n=1457, incompatible with the wild inertia
dividing n. This excludes k=0.

It follows that k>=1 and n<=31. At a D-point, inertia is now a
power of five, since47>n. The prime-to-five part of n divides every
fiber cardinality in D and hence divides31. The remaining degrees
are n=1,5,25,31. For n=5 or25 every possible nontrivial inertia is
a five-group. Every term |I_j|-1 in its different is divisible by
four. Consequently the total different degree is divisible by four,
whereas Riemann--Hurwitz requires
\[
\deg\operatorname{Diff}(X/\mathbf P^1)=16+2n=2\pmod4.
\]
For n=31, there is no wild ramification and every branch has inertia31;
Riemann--Hurwitz would give 16=-62+30t, impossible for integer t.
Degree one to P^1 is also impossible for genus nine. This rules out
the rational coarse case and proves that every literal atlas has n=1.

Returning to Section2, the common tensor-preserving atlas from the
first X has degree one, so its coarse field is the first embedded
X-field. The second X-atlas has the same degree by etale degree/genus
comparison; therefore the two actual embedded fields are equal.
Conversely equal fields give maps differing by gamma^e, which preserves
the exact three-space and its radical. This proves (1).

### Literal and projective atlases are different

Sections2--3 also prove that a scalar equality between pullbacks of
Psi_X along two actual X-maps forces equality of their fields, even
without first identifying the radical lines. Consequently an effective
orbifold atlas preserving the PROJECTIVE tensor [Psi_X] has degree
one or three, and is respectively the identity or [X/<gamma>]. Here
projective preservation means that the two pulled tensors on every
connected component of the self-correspondence differ by a constant.

To see this, take the genuine Galois closure of this ONE atlas and
write its group as G. Every conjugate X-map has scalar-shared Psi_X,
so all its X-fields coincide. Hence G acts on that one field through
Aut(X)=C3. Its fixed field is the coarse field of the original
orbifold, so the atlas degree is the order of that image. Degree
three is the actual cubic quotient; its nontrivial character on
Psi_X is allowed. The same conclusion holds if the embedded radical
line itself descends to the orbifold, by (1). No simultaneous Galois
closure of a coreless two-map span is used.

## 4. A pair's finite contact locus cannot supply the missing boundary

Now retain an actual second map pi:T->Y with g(Y)=2. Set d=deg h_i;
then deg pi=8d. For distinct X-fields, (1) says that the radical
lines are distinct. Their alternating pairing is a section of
\[
\operatorname{Hom}(\ell_i\otimes\ell_j,\omega_{T^{(1)}}),
\qquad\deg=16d+3d+3d=22d.
\]
If it is nonzero, its zero divisor has degree exactly22d. That
divisor cannot descend through pi^(1), since 22/8 is not an integer.

More strongly, in a coreless span with singleton clumps excluded,
its support contains NO nonempty finite subset saturated for both
h_i^(1) and pi^(1). Such a subset would have at most two points in
its Y-image, while the established
[clump-size restriction](../../Theorems/shared_tensors/genus_two_clump_connection_reduction.md)
requires at least four. This conclusion uses the actual degree ratio
and the original two-map hypotheses, not only a rank-four vector space.

If the pairing vanishes identically, it defines no finite zero locus.
The saturation L of ell_i+ell_j is then a Lagrangian plane contained
in U_i. Its quotient by ell_i is a line subbundle of
\[
U_i/\ell_i=\mathcal O(6h_i^{(1)*}O)
          \oplus\mathcal O(10h_i^{(1)*}O),
\]
so deg L<=7d. The nonzero determinant map
ell_i tensor ell_j->det L has a zero divisor of degree
deg L+6d, between zero and13d. If nonempty, its support likewise
contains no nonempty bi-saturated subset when singleton clumps are
excluded. An identically orthogonal pair is not excluded here;
only its proposed finite-boundary construction is bounded.

An invariant union over many different pairs can have much larger
degree. Neither the single-pair calculation nor (1) proves that
such a union descends through both original maps.

There is nevertheless a precise map-descent consequence. Suppose
pi:T->W is any actual finite etale projection and the embedded line
h^(1)*ell descends to a subbundle of B_W. Then there is an ORIGINAL
intermediate etale curve
\[
T\longrightarrow W'\longrightarrow W,
\]
where W'->W is cyclic etale of degree one or three, and h factors
through a finite etale map W'->X.

Indeed take the genuine Galois closure U->W of pi, with group G,
and put H=Gal(U/T). The conjugate actual U->X maps all have the
same pulled embedded radical line, so (1) makes their X-fields
equal. Therefore G acts on this one field through Aut(X)=C3.
Let N be the kernel. Since h is defined on T, H is contained in N.
Thus W'=U/N is an intermediate of the ORIGINAL projection, its
map to W has group G/N, and the X-map descends to W'. It is etale
because this can be checked after the surjective etale source
cover U->W'. In particular the only
obstruction to descent all the way to W is the stated cyclic
degree-three quotient. The existing actual cubic cored companion
realizes that ambiguity.

The numerical identity receipt is stored outside the repository at
[evaluation.json](../../../litt3-computation-data/cartier_radical_contact_20260922/evaluation.json).
The calculation and the field-recognition argument passed the linked independent audit.
