# Coreless finite etale spans preserving a dormant projective oper

**Status: independent audit PASS, 2026-09-05.** Auditor:
`/root/dormant_mumford_coreless_construction_audit`. The
[audit record](audits/DORMANT_OPER_CORELESS_MUMFORD_CONSTRUCTION_AUDIT_2026_09_05.md)
contains the verdict and nonbreaking suggestions; consult it only if
investigating the proof. Its citation correction and clarifications
have been incorporated below. This is a
deduction from arithmetic Mumford uniformization and rigid GAGA, not a
published theorem explicitly about dormant-Hecke correspondences. The
construction gives characteristic-five examples over a complete field;
spreading and a checked specialization theorem then give examples over
the algebraic closure of F5. It does not identify any of the project's
particular endpoint curves or produce their equations.

## 1. A specific source of compact arithmetic Mumford curves

Set F=F5(T), A=F5[T], K=F5((1/T)), and let D/F be the quaternion
division algebra ramified exactly at the primes T and T^2+T+1. The latter
polynomial is irreducible over F5. In particular D splits at infinity.
Choose a maximal A-order O in D and a splitting D tensor K = M2(K).
Let Gamma be the image of O^* in PGL2(K).

Papikian--Wei, *The Eisenstein ideal and Jacquet--Langlands isogeny over
function fields*, Documenta Math. 20 (2015), Theorem 9.1 and Section 9.2,
give the uniformization

    X^an = Gamma \ Omega,   Omega = P1(C_infinity) \ P1(K),

where C_infinity is the completion of an algebraic closure of K. Since
the discriminant has an even-degree prime factor, Section 9.2 states
that Gamma is discrete and free, its tree quotient is finite, and this
is a Mumford uniformization of a proper smooth curve. The acting group
has no vertex stabilizers: a finite stabilizer in a free group is trivial.
The finite quotient of the 6-regular tree therefore has first Betti
number 2v+1 >= 3. Thus the algebraic curve has genus at least two.

Primary source, especially printed pp. 611--612:
[Papikian--Wei](https://ems.press/content/serial-article-files/26279).

## 2. A commensurator element with a coreless span

Choose any noncentral b in D(F), and put alpha_N=1+T^(-N)b. This is
nonzero and invertible in the division algebra, and alpha_N tends to
1 at infinity as N tends to infinity. Every element of D(F)^* commensurates
Gamma. To see this, put O'=alpha_N O alpha_N^(-1) and choose a nonzero
ideal a of A with aO contained in O'. A unit u of O congruent to 1
modulo aO lies in O', as does its inverse, because
u^(-1)-1=-u^(-1)(u-1) belongs to aO. This finite-index congruence
subgroup lies in O'^*. Interchanging the orders proves commensurability.

Fix a finite generating set gamma_1,...,gamma_r of Gamma. Let U be the
kernel of reduction PGL2(O_K) -> PGL2(F5), a compact open pro-5 subgroup.
Choose N large enough that

    delta_i = alpha_N gamma_i alpha_N^(-1) gamma_i^(-1) belongs to U

for every i. At least one delta_i is nonidentity. Indeed Gamma is a
nonabelian Schottky group: two noncommuting elements have distinct
pairs of fixed points, so an element centralizing both is the identity
in PGL2(K). But alpha_N is noncentral. Write alpha=alpha_N and

    H = <Gamma, alpha Gamma alpha^(-1)>.

The subgroup H is **not discrete**. For a direct proof, D(F)^*/F^* has
no element of order five: x^5 in F^* would force the minimal polynomial
of x to be purely inseparable of degree either one or five, but an
element of a quaternion algebra has minimal polynomial of degree at
most two. Hence x is scalar. If H were discrete, H intersect U would
be finite, and every finite subgroup of the pro-5 group U is a 5-group.
It would therefore be trivial. This contradicts the nonidentity delta_i.
More explicitly, such a delta_i has infinite order and its distinct
powers delta_i^(5^m) tend to the identity in U. These powers give the
identity-approaching sequence used below.

Put Gamma'=alpha Gamma alpha^(-1) and Delta=Gamma intersect Gamma'.
Their common finite-index subgroup gives actual finite etale maps
of smooth proper algebraic curves over C_infinity:

    X = Omega/Gamma  <-  Z = Omega/Delta  ->  Y = Omega/Gamma'.

Here quotient maps are finite etale analytic covering maps; algebraicity
and etaleness follow from the corresponding Mumford curves and GAGA.

This span has no core. If a nonconstant core function existed, its pullback
would be an H-invariant nonconstant meromorphic analytic function R on
Omega. Nondiscreteness supplies distinct h_n tending to 1. Choose z in
Omega avoiding the poles of R and the fixed points of every
h_m^(-1)h_n with m != n. Such a z exists: this excludes a countable set
from the uncountable set Omega. The pole set is countable because it
is the inverse image of a finite pole divisor on Z under the quotient
by the countable group Delta. Then h_n(z) are distinct, converge to z,
and R(h_n(z))=R(z). A nonzero analytic function R-R(z) cannot have zeros
accumulating at an interior point. This would force R to be locally
constant, hence constant on the connected analytic curve, a contradiction.

The argument constructs a span explicitly from the named quaternion
algebra and any sufficiently large N. No finite-field equations or
effective lower bound on N have been computed here.

## 3. The same regular dormant PGL2-oper descends through both legs

All analytic connections and GAGA in this section are over C_infinity;
connections and p-curvature are relative to this ground field, not
absolute over F5. No descent to the imperfect field K is required.

On Omega use the trivial flat PGL2-bundle together with its Borel
reduction given by the identity map Omega -> P1. For an element gamma
of PGL2(K), act simultaneously on Omega and on the P1 fiber by gamma.
This preserves the trivial relative connection, because gamma has
coefficients in the base field; it preserves the Borel reduction because
the identity map is equivariant. The Kodaira--Spencer map is an
isomorphism, since the developing map is a local coordinate.

Consequently this is an analytic PGL2-oper invariant under all of
PGL2(K), in particular Gamma, Gamma', and Delta. The induced analytic
opers on X, Y, and Z are regular everywhere. Their p-curvature is zero:
on every uniformizing chart the connection is the trivial connection.
Equivalently, the standard projective connection has Schwarzian
coefficient zero on these charts and constant Mobius transitions.

Rigid GAGA algebraizes the oper and its two pullback identifications.
One can avoid relying on an unspecified principal-bundle GAGA theorem:
use the rank-three adjoint vector bundle, its Lie bracket, its connection
(expressed as a splitting of the first-jet sequence), and the subbundles
specifying the Borel reduction. Coherent-sheaf GAGA algebraizes the bundles
and all O-linear tensor maps. The algebraized Lie-algebra frame torsor is
PGL2 because Aut(sl2)=PGL2 as smooth group schemes in characteristic
five. The faithful adjoint representation and its differential detect
zero p-curvature. Oper transversality
and zero p-curvature are identities/isomorphisms that can be checked
after analytification. Thus this supplies regular **algebraic dormant**
PGL2-opers P_X and P_Y with f^*P_X isomorphic to g^*P_Y.

For the precise coherent-sheaf GAGA input, see Example 3.2.6 and the
proof of Lemma 4.3.2, printed pp. 37--38, of
[Conrad, Relative ampleness in rigid geometry](https://math.stanford.edu/~conrad/papers/amplepaperfinal.pdf).
The dormant-oper conclusion in this section is our deduction from that
input and the displayed uniformization, not a quotation from Conrad or
Papikian--Wei.

## 4. Specialization really goes in the required direction

All the algebraic curves, maps, opers, and their matching isomorphism
descend to a finitely generated extension of F5 and spread to an integral
finite-type F5-scheme S. Shrink S so the curves are smooth proper with
geometrically integral fibers, the maps are finite etale, the oper
Kodaira--Spencer maps are isomorphisms, and zero p-curvature and matching
hold over S. Here p-curvature is relative to S, using the relative
Frobenius twist; its vanishing is a finite algebraic identity that spreads
with the other data. Their generic span remains geometrically coreless, since a
core would remain one after extension to C_infinity.

Krishnamoorthy's Lemma 4.10 explicitly proves that in a family of proper
smooth geometrically integral curves, with hyperbolic middle curve and
finite etale legs, **generic corelessness implies corelessness of every
geometric fiber**. Corollary 4.12 states the resulting specialization to
the algebraic closure of the prime field. Thus any closed point of this
S yields the required example over Fbar5, including its regular common
dormant oper. This is existence by a concrete construction and
specialization, not a computed finite-field example.

Primary source, printed pp. 1188--1189:
[Krishnamoorthy, Lemma 4.10 and Corollary 4.12](https://msp.org/ant/2018/12-5/ant-v12-n5-p05-p.pdf).

## 5. Boundary for the project's proposed implication

The independently checked construction shows that the implication
“a regular common dormant PGL2-oper forces a core” is
false even in characteristic five over Fbar5. The intrinsic oper extracted
from the project's particular pluriform may carry additional structure;
that additional structure must be retained in any proposed exclusion.
This note does not assert that the constructed invariant oper arises from
the project's shared pluriform with its generalized-Cartier condition.

As a separate easy boundary, in characteristic three the unique rank-(p-1)
dormant projective oper is already rank two. Hoshi's uniqueness theorem
then makes preservation automatic for any finite etale span, including
coreless spans. That observation alone would not settle characteristic five.

No lifting to characteristic zero, nilpotent-active indigenous bundle,
Gauss--Manin connection, or ordinarity assertion is used in this note.
