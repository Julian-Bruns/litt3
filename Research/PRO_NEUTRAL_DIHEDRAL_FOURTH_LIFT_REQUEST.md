# Evaluate the first secondary obstruction of an actual neutral cover

Compute the exact scalar fourth-Witt obstruction on the explicit genus-six
curve below, and identify the geometric contribution that controls it.
This is a concrete test of non-Galois descent: an actual degree-five map
repairs its base's first obstruction while preserving defect one. All
compatible third lifts of this source are known, and a new audited
comparison proves that their next obstruction is the SAME scalar.

The target is

\[
c_4=\epsilon_T(T_3(0))\in\operatorname{coker}\Psi_T\simeq k,
\qquad
\epsilon_T(T_3(b))=c_4\quad\text{for every }b\in k.
\]

Here \(k=\overline{\mathbf F}_5\). All previous filtered objects,
graded identifications, the original flat periodicity twist, and the
marking of the second Witt lift are fixed below. Use the explicit target
functional in Section4, or state the exact nonzero scaling of your
normalization. The parameter-independence and primary computations are
established inputs, so the new work is the value of this scalar.

If \(c_4\ne0\), every compatible third lift of this fixed source fails
at the fourth level; this supplies a sharp finite obstruction to the
actual neutral repair. If \(c_4=0\), give one explicit fourth curve
digit and its compatible Hodge line; all members of the third-lift line
then admit some fourth extension. Either verdict determines our next
step. Derive the scalar from a reusable normal-cocycle or residue formula
that exposes how the divided linear carry and quadratic first repairs
combine. This fixed-cover calculation is the single requested theorem.

## 1. Fixed base pair and its full first-lift data

Work over k, with

\[
t^4+4t^3+t^2+4t+3=0,\quad
F=u(u-1)(u-2)(u-3)(u-t),\quad C:v^2=F.
\]

Put \(\eta=du/v\), \(z=u^2/v\), \(D_C=v\partial_u\),
\(h_0=4t+3\), and \(\mu=4+4t\). The active admissible projective
connection is

\[
r_C=2(F'/F)^2-F''/F+P/F,
\quad
P=2u^3+(2t+3)u^2+(3t^2+3)u+2t^3+4t^2+4t+4.
\]

In the eta spin frame its companion connection is
\(d-\left(\begin{smallmatrix}0&1\\ P&0\end{smallmatrix}\right)\eta\).
The actual square-trivial flat periodicity line is
\(\mathscr L=\mathcal O_C(W_t-O)\), with the trivialization of its
square from \(u-t\). It is nonsplit and is retained in the preceding
filtered input. The next transform uses that preceding input, not only
the mod-five Higgs bundle.

The following facts and their exact source files are established inputs.
The base has ordinary Jacobian and Hodge defect one. Its actual Hodge
operator, in the eta-inverse tangent frame before Cech reduction, is

\[
\Psi_C(f)=A_C f^5,\qquad
A_C=(u-t)(u-h_0)^2/\mu.
\]

The canonical marked C2 is specified relative to the coefficientwise
reference curve by overlap \(\exp(5\xi_C D_C)\), where

\[
\xi_C=(2+4t+t^2+3t^3)z^{-3}
 +(3+3t+t^3)z^{-1}+(4+3t^3)z.
\]

Use the smooth marked reference C3ref with overlap

\[
1+5\xi_C D_C+\frac{25}{2}(\xi_C D_C)^2\pmod {125}.
\]

The coefficient ring is
\((\mathbf Z/125)[T]/(T^4+4T^3+T^2+4T+3)\), with Witt Frobenius
\(\Phi(T)=122+113T+25T^2+10T^3\pmod {125}\).
Further precision means the unique unramified extension and its actual
Witt Frobenius, not fifth powering lifted coefficients.

The complete first comparison, including its flat identification, is
implemented in `compute_genus2_w3_obstruction.py` and described in
`Sol_explicit_genus_two_witt_obstruction.md`. In particular it retains
the nonsplit double, the order-five jet-transition entry, and the
quadratic Taylor term. Its obstruction representative is

\[
\rho_C(C3ref)=a_0z^{-3}+a_1z^{-1}+a_2z,
\quad(a_0,a_1,a_2)=(1+4t+2t^2,1+t+t^3,t+2t^2+2t^3).
\]

Its cokernel class is \(\mu^{-1}\ne0\). Thus this C2 has no compatible
C3, although its underlying smooth curve has lifts.
In the Laurent-u tangent basis \((v/u,v/u^2,v/u^3)\), the same
representative has coefficients

\[
\rho_u=(a_0,\ a_1-(t+1)a_0,\ a_2+(t+1)a_0).
\]

The primary variation convention, at every valid next step, is
\(\rho(S+\xi)=\rho(S)-\Psi_S(\xi)\). A compatible lift means that
the specified previous Hodge line lifts in the higher inverse-Cartier
transform, with its projective graded identification and actual flat
periodicity line. The Hodge line, once it exists, is unique because its
normal line is the negative tangent line. The supplied definitions and
proofs fix this convention.

## 2. The original actual neutral cover

Let

\[
R=u(u-1),\quad S=(u^2+1)(u-t),\quad
D:\kappa^2=R,\ \ell^2=S,\ v=\kappa\ell.
\]

Set \(H=t^2+2\) and choose \(\lambda^4=H^{-1}\). On the affine
chart take

\[
w^5-w=\lambda^5\ell(u-2t).
\]

At infinity the coordinate is \(w_O=w-\lambda\ell/u\), and

\[
w_O^5-w_O=\lambda^5\ell\left(
\frac{4t}{u^2}-\frac{1+2t^2}{u^3}
 +\frac{2t}{u^4}-\frac{t^2}{u^5}\right).
\]

These charts define an actual finite etale cyclic-five cover W of D.
Its automorphisms

\[
\sigma(w)=w+1,\qquad
\tau(\kappa,\ell,w)=(-\kappa,-\ell,-w)
\]

satisfy \(\tau\sigma\tau=\sigma^{-1}\). The original map is

\[
h:T=W/\langle\tau\rangle\longrightarrow C.
\]

It is finite etale, non-Galois of degree five, with genus(T)=6 and
Galois closure W of genus11. Defects are
\((d_C,d_D,d_W,d_T)=(1,1,2,1)\), and pullback on the primary
obstruction cokernel C to T is zero. Thus T2, the unique lift of this
cover over the fixed C2, admits compatible T3 repairs.

For clarity, the semilinear Fitting types are known and important:

| Curve | Bijective dimension | Nilpotent block lengths |
|---|---:|---|
| C | 1 | 2 |
| D | 4 | 2 |
| W | 20 | 4,6 |
| T | 9 | 6 |

The cyclic obstruction module on W is \(k[e]/(e^2)\), but the
Fitting nilpotent space on C is two-dimensional. These are different
invariants; a simple-zero descent theorem does not settle this test.

The cover construction, its original quotient marking, all actual
Hodge matrices, and the Fitting computations are independently audited.
The accompanying fifteen-cover computation includes this as row zero.

## 3. Explicit complete affine line of first repairs

Let T3ref be the unique etale lift of h over C3ref. It is a smooth
reference, not a compatible Hodge lift. Put

\[
k_C=\frac vu+4\frac v{u^2}+(4+t+3t^2)\frac v{u^3},
\qquad a=2+2t+4t^3.
\]

In the eta-inverse tangent frame on W define the tau-invariant class

\[
\xi_T=(4+4t+t^3)\frac vu+(1+3t^3)\frac v{u^2}
 +(t+2)\lambda^3\frac\kappa u\,w
 +\lambda^2a w^2 k_C.
\]

Exact Cech reduction gives

\[
\Psi_T(\xi_T)=h^*\rho_C(C3ref),\qquad
\ker\Psi_T=k\,h^*k_C.
\]

Consequently **every compatible marked third lift** of this T2 is

\[
T_3(b)=T3ref+\xi_T+b\,h^*k_C,\qquad b\in k.
\]

Each carries the unique compatible Hodge line and the fixed other data.
No member extends the original map to any marked C3, because the base
obstruction is nonzero and tangent H1 pullback is injective for this
individual finite etale map. The next scalar determines whether these
members extend compatibly to W4.

All these tangent directions preserve the hyperelliptic involution of T,
induced by \(\kappa\mapsto-\kappa\) with ell and w fixed. Its tangent
eigenspaces have dimensions11 and4. The latter Hodge block is invertible.
This permits a smaller hyperelliptic calculation without dropping the
actual previous tuple.

### Established relative comparison: the parameter cannot alter c4

The actual comparison has already proved

\[
\epsilon_T(T_3(b'))-\epsilon_T(T_3(b))=0
\qquad (b,b'\in k).
\]

Use this as an input. The proof and exact checks are in
`Sol_neutral_five_fourth_parameter_independence.md` and
`neutral5_parameter_independence_audit.json`. Its precise mechanism
helps isolate the new calculation:

- On the actual cyclic AS algebra, the particular first repairs have
  degree at most2 in w, while changing b has degree0. These are
  respectively \(e^2\mathscr A\) and \(e^4\mathscr A\).
- The integral equivariant Cech primitive chooses the ACTUAL first
  Hodge-generator repairs in those same subspaces. Relative quadratic
  products have degree at most2 and vanish in \(k[e]/e^2\).
- The remaining relative divided linear carry is zero by a full-lattice
  norm identity. For the actual additive two-digit response A2, lift
  an invariant lower-kernel direction as N*alpha. Then
  \(A2(alpha)=e\zeta+5v\) and \(A2(Nalpha)=5Nv\), since Ne=0
  integrally. Its divided reduction is e4*vbar, also zero in the
  actual cokernel. No division is moved through an augmentation ideal.

This relative argument leaves the absolute value at b=0 untouched.
The square of its degree-two particular repair can reach AS degree4,
so that contribution must be evaluated together with its divided carry.

## 4. Smaller exact model over F625

The files `neutral5_hyperelliptic_model.json` and
`neutral5_hyperelliptic_hodge.json` contain an independently checked
degree13 hyperelliptic model and all small cohomology coordinates.
Here is its precise dictionary, so it can be regenerated.

Take the ordinary elliptic curve \(E:\ell^2=u^3-tu^2+u-t\).
Factor its multiplication-by-five x-coordinate map through relative
Frobenius by removing the common exponent five from its variable:

\[
q(s)=N(s)/D(s),\qquad D=d^2,\quad \deg N=5,\ \deg d=2.
\]

With \(S_5=s^3-t^5s^2+s-t^5\), the saved polynomial J satisfies

\[
J^2 S_5=N^3-tN^2D+ND^2-tD^3.
\]

The original T and map are

\[
T:Y^2=G=N(N-D)S_5,\quad u=N/D,\quad v=JY/d^5,
\quad h^*\eta=-H D\,ds/Y.
\]

The last sign is frozen by the saved J. The explicit identification
with the Artin--Schreier model is, on \(y^2=S_5\),

\[
B_0=(2+3t+3t^2+2t^3)s+(3+t+2t^2),
\quad w=\lambda y B_0/d,\quad \ell=Jy/d^3.
\]

In particular \(s_0=w/(\lambda\ell)=B_0D/J\) is defined over F625.
The particular repair is also defined over that smaller field: replace
its last two terms above by

\[
\frac{t+2}{H}\frac vu s_0
 +\frac{aS}{H}s_0^2k_C.
\]

In the \((ds/Y)^{-1}\) frame the exact Hodge multiplier is the polynomial

\[
A_T=H^4 D(N-tD)(N-h_0D)^2/\mu.
\]

The tangent basis is \(Y/s^i\), \(1\le i\le11\), followed by
\(1/s^i\), \(1\le i\le4\). The two Hodge matrix blocks are simply

\[
(M_+)_{ij}=[s^{5j-i}]A_TG^2,\qquad
(M_-)_{ij}=[s^{5j-i}]A_T.
\]

Their ranks are10 and4. The saved primary vectors satisfy the full
semilinear repair equation, not only equality after projecting to the
cokernel. Their transport from the original Cech cover uses residue
reciprocity at the roots of N and d, with exact rational principal
parts; `neutral5_hyperelliptic_hodge.py` implements this dictionary.

This characteristic-five model is a choice of coordinates on the
original source, not a replacement of its marked C2 by a coefficientwise
hyperelliptic lift. Retain or calculate the corresponding marked curve
gluing when using these smaller coordinates at higher precision.

For a completely fixed scalar coordinate, use the row
`obstruction_dual` in `neutral5_hyperelliptic_hodge.json`, acting on
the eleven positive tangent coordinates in their displayed order.
It is the unique left null vector of M+ whose first coordinate is1.
Thus if r4 is the actual next normal cocycle in that cohomology basis,
the requested scalar is the ordinary row pairing c4=obstruction_dual*r4.
All serialized coefficients in this small-model file use the basis
(1,t,t²,t³). This normalization keeps coefficient-Frobenius transport
in the construction, rather than inserting an additional Frobenius
into the final target functional.

## 5. The new computation and its deliverables

Execute these four tasks as parts of the single obstruction calculation:

1. Construct the actual next inverse-Cartier normal comparison for
   T3(0), including its first Hodge-generator correction, the prescribed
   graded/jet transition and the original flat twist. Keep the preceding
   filtered object and every divided Taylor contribution at the required
   precision. Show which exact normal cocycle represents c4. A formula
   extracting only its required residue is sufficient if all discarded
   terms are controlled at the cochain level.
2. Evaluate c4 exactly in the stated target normalization. Separately
   identify the divided linear carry, the products of first repairs,
   and the graded/jet or preceding-input contributions, then combine
   them in the actual obstruction quotient. A coordinate-dependent
   decomposition is acceptable with its choices recorded. The final
   scalar must be obtained from the complete geometric comparison.
3. Use the established parameter-independence to decide the entire
   third-lift line. If c4=0, compute one actual fourth curve digit
   cancelling the representative and give the compatible Hodge line.
   If c4 is nonzero, state the resulting nonexistence for every b.
4. Independently check the controlling coefficient and geometric
   normalization: change local Frobenius choices or Cech primitives,
   preserve the original marking, and test coefficient-Frobenius
   transport using coefficients outside F5. Supply executable
   exact-arithmetic source, enough intermediate data to replay, and the
   actual output of every test you execute.

The geometric term is the point of the exercise. The old abstract norm
mode, the first-rank calculation and a zero primary obstruction are
already known. A calculation on an actual compatible T3 can distinguish
them from a persistent geometric repair. Here the first repairs have
Artin--Schreier degree two, so their products can reach degree four;
the degree-one product cancellation from simpler covers is insufficient.
The integral remainder of the linear repair must be retained alongside
those products until the final obstruction quotient is taken.

The higher construction is that of LSZ,
https://arxiv.org/html/1311.6424v4, and the maximal-Higgs lifting
construction of LSYZ, https://arxiv.org/html/1404.0538v2. Use the
explicit base certificate for the normalized first comparison and its
original twist. Its established statements and the primary-cover
certificates are inputs to use, rather than tasks to repeat.

The archive preserves the scripts/Research/Solutions/Definitions
directory structure. The base higher-Witt script uses Python and NumPy.
The small-model and AS preparation scripts use Sage; their complete
finite-field outputs are serialized so the new calculation can also
consume them using an independent exact-arithmetic implementation.
Use the small Hodge/repair identities for input sanity checks and put
the substantive computation into the next normal cocycle.

Work through the objective list to an evidence-backed result. Quality
and completeness matter more than speed; take the time needed for the
actual higher comparison and its independent checks. Keep intermediate
artifacts so a promising calculation can be resumed and audited.
