# Proof: a dormant normal form and one highest-height certificate

[Statement](../../Theorems/deformations/pointed_extensions_frobenius.md) · [Focused integration review](../../Research/audits/POINTED_HIGHEST_HEIGHT_INTEGRATION_2026_10_03.md).
Version8,3 October2026.

## 1. One dormant jet model in every odd characteristic

Let $h$ be the first unstable index, $b=p^{h-1}$ and
$E'=F^{(h-1)*}E$, with its specified determinant $\omega_1^b$.
The original nonsplit extension is semistable: a line of degree
at least two would split its degree-two quotient. At the last
relative step $F:C_0\to C_1$, the maximal line is not horizontal,
since $E'$ is semistable. Its nonzero second fundamental map
bounds its degree by $pb<\deg N\le pb+1$, hence $\deg N=pb+1$.
The map is therefore an isomorphism to the quotient $Q$ tensored with $\omega_0$:
\[
Q^2=\omega_0^{pb-1},\qquad
Q=\omega_0^{(pb-1)/2}\tau,\qquad F^*\tau_1=\tau.
\]
Relative Frobenius identifies the two-torsion groups. Put
$L_1=\omega_1^{(1-b)/2}\tau_1$.
The ACTUAL normalized canonical connection
$H=F^*(E' L_1)$ has quotient $\omega_0^{(p-1)/2}$
and determinant the canonical flat $F^*\omega_1$.

The intrinsic quotient-jet map
$v\mapsto j^1(q(v))-\operatorname{inclusion}(q(\nabla v))$
is an isomorphism to $J^1(\omega_0^{(p-1)/2})$:
its two grade maps are the identity and minus the second
fundamental isomorphism. The specified flat determinant makes
its scalar equation $a''=ra$ trace zero. The
[intrinsic Bol jet construction](../projective_connections/dormant_bol_complex.md)
then gives its regular dormant $r$ and canonical descent $V_r$,
with $\det V_r=\omega_1$. Cartier descent retains the actual
isomorphism
$E'=V_r\omega_1^{(b-1)/2}\tau_1$.
This uses every relative twist, without choosing a spin lift.

Stability of $V_r$ makes any nonzero section of $V_r\tau_1$
nowhere zero: its saturated line has degree less than one.
Its quotient is $\omega_1$ and the pointed extension is nonsplit.
Two independent sections would either generate the same trivial
line or have a nonzero canonical wedge with a zero; in the latter
case a constant linear combination vanishes there. Both are
impossible. Thus the first-height section is unique up to scalar.

For $h\ge2$, Serre duality identifies $H^1(E')^\vee$ with
$H^0(V_r\omega_1^{(1-b)/2}\tau_1)$, whose stable slope is
negative. Hence $h^0(E')=2b-2$ by Riemann--Roch.
The original pointed section must still survive all earlier steps;
this dimension is not an instability exclusion.

## 2. The polynomial criterion already sees every earlier height

For C_T:v²=F_T(u)=u(u−1)(u−2)(u−3)(u−T), put P=5^h and
A=F_T^((P−1)/2). The
[general polynomial theorem](../../Theorems/deformations/genus_two_pointed_polynomial_test.md)
constructs the whole connecting map
\[
H^0(\mathcal O((P-1)O)\otimes\tau)
\longrightarrow H^1(\mathcal O(-(P+1)O)\otimes\tau),
\]
for all sixteen two-torsion labels R, using only coefficients of
R*A and (F_T/R)*A. Its kernel is Hom(omega^((P+1)/2) tensor tau,F^h*E).
The theorem proves that absence of these kernels is equivalent to
semistability through index h, including earlier possible instability.
Its proof supplies the two Cech bases, every matrix entry and the
Frobenius transport of projective parameters. No dormant quotient-jet
identification from Section1 is needed for this numerical criterion.

For R1 the parity blocks have column counts(P+1)/2 and(P−5)/2;
for the other labels they have counts(P−1)/2 and(P−3)/2. Each has
exactly two more rows than columns. This yields n13,10 or12,11 at
P25 and n63,60 or62,61 at P125.

## 3. One fourth-height certificate replaces the earlier computations

For a block with $n$ columns, the polynomial theorem identifies
all-geometric constant rank with invertibility of its square
degree-$n$ maximal-minor coefficient map. Its size is
$\binom{n+2}{2}$, by the published Busé/Eagon--Northcott criterion
already used in that theorem. To prove this at $P=625$, use the
equivalent, smaller whole-row-module test.

Constant row operations normalize the pencil to
\[
\begin{pmatrix}x_0I+x_1A+x_2B\\x_1C+x_2D\end{pmatrix}.
\]
On $x_1\ne0$, put $t=x_2/x_1$.
A rank drop at some geometric $x_0$ is an eigenvector of
$A+tB$ in $\ker(C+tD)$. Cayley--Hamilton makes the common kernel
of the rows $(C+tD)(A+tB)^j$, $0\le j<n$, invariant.
A nonzero invariant subspace has an eigenvector over the algebraic
closure. Thus the exact criterion is generation of ALL $k[t]^n$
by those rows: a nonzero cokernel has a nonzero closed-point
fiber by Nakayama. Rank over $k(t)$ alone is insufficient.
On $x_1=0,x_2\ne0$ the same test uses $DB^j$; $[1:0:0]$
is covered by full-rank normalization.
The [observability audit](../../Research/audits/POINTED_OBSERVABILITY_AUDIT_2026_09_15.md)
checks this equivalence and the unsaturated row operations.

The [native engine](../../scripts/deformations/pointed_popov_native.cpp)
uses only field normalization, monomial row subtraction and pivot
swaps retaining both generators. These preserve the whole module.
Distinct leading positions give a weak-Popov basis; in full rank,
the determinant degree is the sum of its row degrees.
Rank $n$ and degree sum zero therefore certify $k[t]^n$.
The [bounded implementation audit](../../Research/audits/POINTED_POPOV_NATIVE_AUDIT_2026_09_16.md)
checks42 independent pencils and35 direct modules, including a
failure supported only over an extension field. Its trusted-input
dimension scope includes every block here.

The [wrapper](../../scripts/deformations/run_pointed_popov_native.py)
builds the matrices directly from the
[polynomial builder](../../scripts/deformations/pointed_frobenius_polynomial.py)
over canonical $\mathbf F_{125}$, checks both matrix inverses and
every infinity rank, and compares four whole initial Krylov-row
hashes with independent Sage multiplication.
The [fourth-height receipt](../../../litt3-computation-data/unmarked_extension_spectrum_20260915/native_height4_all/receipt.json)
contains all32 blocks, with columns310--313. Each whole row module
passes, at observation powers155 or156; all infinity ranks are full.
The receipt's wrapper, engine and builder hashes match these sources.

Consequently every pointed extension at the cubic backup remains
semistable through height four. Pulling back a destabilizing line
preserves destabilization, so every earlier height is semistable
as well. The polynomial criterion then makes every earlier
coefficient determinant nonzero at the backup. This supplies the
nonvanishing for ALL the degree bounds below from the single
fourth-height computation. The earlier Laurent, basis-comparison
and interpolation algorithms are no longer mathematical inputs.
Their receipts and independent audits retain their original
provenance; no earlier numerical claim is retroactively changed.

## 4. Transfer by the coefficient-resultant degree

Write a=(P−1)/2 and n0=a+1. For a chosen R let delta be1 or0
according as u−T divides R. The entries of the two polynomial blocks
have T-degree at most $a+\delta$ and $a+1-\delta$,
because F_T, R and F_T/R have T-degrees1,delta,1−delta. Taking a
coefficient of u or lambda cannot increase this degree. If an
(n+2)-by-n block has entry degree at most D, each maximal minor
has coefficient degree at most nD. Its square coefficient determinant
has size q=binomial(n+2,2), hence degree at most nDq.

For R1 the bounds are n0*a*binomial(n0+2,2) and
(a−2)*(a+1)*binomial(a,2). Every other block has n<=a and D<=a+1,
so its bound is at most a*(a+1)*binomial(a+2,2), smaller than the
first R1 bound. Therefore a single bound works for ALL32 blocks:
\[
B(P)=\frac{(P^2-1)(P+3)(P+5)}{32}.
\]
It gives B25=16380, B125=8124480 and B625=4829577480.
These are bounds on the
POLYNOMIAL-basis coefficient determinants, not on kernel coordinates
or on the former Laurent-basis determinants. Each belongs to F5[T]
and is nonzero at alpha by Section3 and the polynomial criterion.
Thus it cannot vanish at any t with [F5(t):F5]>B(P). No product of the32
determinants is needed. The bound applies to each determinant separately.

The [joint-tangent theorem](pointed_bundle_instability.md) supplies
a finite first-instability index for a nonzero shared tangent over
bar(F5). On the fourth-height endpoints Sections2--4 exclude indices
one through four. Parts7--8 of the
[two-leg extension theorem](two_leg_negative_extensions.md)
then force the unique simultaneous W2 lift for exceptional clump
sizes4,24,124,624 and put any joint tangent at size at least3124.
This is a corollary input only for that final statement; the polynomial
calculation uses no assumed span or clump. No all-height semistability
or common-cover conclusion follows.

The already selected main parameter still qualifies: its degree
over F25 is a prime larger than the fixed arithmetic bound K,
and \(K>336000^2=112896000000>B(625)\). Its degree over F5
is at least that large. This uses the same parameter as before.

## 5. Exact first-height classification and cubic transfer

Section1 identifies first-height unstable nonsplit pointed extensions
with nonzero sections of $V_r\tau$, for an ACTUAL dormant connection
and a two-torsion line. Conversely such a section is nowhere zero,
gives the nonsplit extension with quotient $\omega$, and its oper line
of degree6 makes the first Frobenius pullback unstable.

The [elliptic incidence theorem](../projective_connections/genus_two_dormant_parameter_curve.md)
therefore gives the exact failure locus: $t=4$, or
\[
Q(A)=A^3+3A^2+4=0,\qquad
z=(t+1)^{-1},\quad A=(z^5-z)^4.
\]
It is proved directly by the intrinsic Bol kernel, two torsion orbits
and CM trace13, without using this family classification. Relative
Frobenius twists permute the locus because its equations are over
$\mathbf F_5$. The Hasse determinant is $3(t+1)^4$, so all sixty
cubic failures are ordinary. This replaces the complete collection
of31 first-height determinant factorizations; its
[original receipt](../../../litt3-computation-data/unmarked_extension_spectrum_20260915/first_height_rosenhain_invariant_20260916.json)
remains provenance and its producer is deleted completely.

In $u\mapsto1/(u+1)$ the fixed branch set is $\mathbf F_5$.
Its affine group preserves $A$ and each ordinary fiber of $A$
is one twenty-point orbit. The good cubic transfer needs only the
following finite-field identity, not another determinant calculation.

For z in F125 outside F5, put \(w=z^5-z\). Trace zero gives
\(w^{25}+w^5+w=0\), whence
\[
A^6+A+1=(A^3+3A^2+4)(A^3+2A^2+4A+4)=0.
\]
Both cubics are irreducible with constant term4. Their roots have
norm1, hence are fourth powers in F125. For every fourth root w,
its trace is w(A^6+A+1)=0, giving twenty z in F125 per A-value.
The good and bad sets each consist of three affine orbits, cyclically
permuted by Frobenius. For the backup alpha^3+alpha+1=0, direct reduction gives A=alpha+1,
which lies in the good cubic. All sixty good cubic curves are therefore isomorphic
to coefficient twists of the backup. Isomorphism and field Frobenius
preserve the pointed-extension problem at every fixed height,
so the completed fourth-height test applies to all sixty.

The [focused transfer review](../../Research/audits/FIRST_HEIGHT_ELLIPTIC_TRANSFER_AUDIT_2026_10_03.md)
checks the converse, relative twists, acyclic intrinsic foundation and
retirement of the entire first-height producer. Higher-height inputs
and original certificates are unchanged.
