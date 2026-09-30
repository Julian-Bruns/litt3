# Proof: paired kernel polarizations and Frobenius slope

[Statement](../../../Theorems/jacobians/theta_divisors/raynaud_rank_one_dimension.md).
The [bounded audit and follow-up](../../../Research/audits/RAYNAUD_RANK_ONE_DIMENSION_AUDIT_2026_09_15.md)
pass both versions.
The user-supplied Pro reply of 15 September 2026 introduced the
inverse-Fourier-transform slope argument for the fixed mixed family.
The argument here pairs opposite translates and compares their
polarizations. This gives the dimension bound and the codimension-one
vanishing consequence. The proof uses no characteristic-zero lift.

## 1. Opposite translates have two ample kernel duals

Write \(d=\dim A\), \(\theta=i^*[\Theta_J]\), and let \(\mathscr P\)
be the Poincaré family on \(C^{(1)}\times A\), trivial on
\(\{c_0\}\times A\). Put
\[
\mathcal C_\pm=
R\pi_*(B_C\otimes L_0^{\pm1}\otimes\mathscr P),
\qquad
\mathscr K_\pm=\mathcal H^0(\mathcal C_\pm),\quad
Q_\pm=\mathcal H^1(\mathcal C_\pm).
\tag{2}
\]
The bundles in the fibers have Euler characteristic zero. These
are perfect complexes of amplitude \([0,1]\), locally represented
by square matrices, with derived base change.

The self-duality \(B_C^\vee\otimes\omega_{C^{(1)}}\simeq B_C\)
and Serre duality show that opposite twists have the same \(h^0\).
This self-duality is valid also for \(p=2\), when \(B_C\) is a theta
characteristic; alternation of the pairing is not needed. Thus both
complexes in (2) have generic kernel and cokernel rank one.

A kernel of a map between vector bundles is reflexive: its image
is torsion-free, and the depth lemma gives the second Serre condition.
On the smooth variety \(A\), a rank-one reflexive sheaf is invertible.
Hence \(\mathscr K_\pm\) are line bundles.

Set \(\mathscr M_\pm=\mathscr K_\pm^\vee\). These are ample.
Here is the general argument, which also works with any fixed
vector bundle in place of \(B_C\otimes L_0^{\pm1}\). Evaluation
of a nonzero generic kernel section at a general \(c\in C^{(1)}\)
implies
\[
H^0(A,\mathscr M_\pm\otimes\mathscr P_c)\ne0.
\tag{3}
\]
The closed support locus \(V^0(\mathscr M_\pm)\) therefore contains
the entire Abel image \(j(C^{(1)})\subset\widehat A\), where
\(j=\widehat i\circ a_C\) and \(j(c_0)=0\). That image generates
\(\widehat A\), since the dual map \(i\) has finite kernel.
In particular \(\mathscr M_\pm\) are effective.

For an effective nonample line bundle on an abelian variety,
the connected kernel of its polarization is positive-dimensional,
and its \(V^0\) is contained in one coset of the annihilator of
that kernel. Indeed, restrict a nonzero section to a general coset
of the kernel: a degree-zero line has a section only if it is
trivial. Such a proper coset cannot contain a generating curve
through the origin. This proves ampleness.

This generalizes the kernel argument in
[the jump-divisor proof, Section 7](raynaud_jump_divisor.md).
It does not assert that kernel base change is nonzero at every
parameter.

## 2. The sum of the two kernel polarizations is bounded

Let \(\iota=[-1]_A\). Relative duality gives
\[
R\mathcal Hom(\mathcal C_+,\mathcal O_A)
\simeq \iota^*\mathcal C_-[1],
\qquad Q_+^\vee\simeq\iota^*\mathscr K_-.
\tag{4}
\]
If \(U_+=\operatorname{tors}Q_+\), the reflexive hull of
\(Q_+/U_+\) is consequently \(\iota^*\mathscr M_-\).
Let \(D\) be the divisorial cycle of \(U_+\), whose coefficients
are its lengths over the height-one discrete valuation rings.
Taking determinants in (2) gives
\[
\det(\mathcal C_+)^{-1}
\simeq\mathscr M_+\otimes\iota^*\mathscr M_-\otimes\mathcal O_A(D).
\tag{5}
\]
Grothendieck--Riemann--Roch for the Poincaré family gives
\(c_1(\det(\mathcal C_+)^{-1})=(p-1)\theta\). The fixed
degree-zero twist \(L_0\) does not alter this class. Since inversion
is the identity on numerical divisor classes, (5) yields
\[
c_1(\mathscr M_+)+c_1(\mathscr M_-)+[D]=(p-1)\theta.
\tag{6}
\]
An effective divisor on an abelian variety is nef. If it is nonzero,
its intersection with \(\theta^{d-1}\) is strictly positive.
No assertion about the higher Chern character or the codimension-two
reflexive-hull defect is required.

## 3. The kernel produces a strongly semistable bundle on the curve

Use the normalized Fourier--Mukai equivalence from \(\widehat A\)
to \(A\). The actual complex \(\mathcal C_\pm\) is the transform
of \(j_*(B_C\otimes L_0^{\pm1})\). The inverse transform of the
antiample line \(\mathscr K_\pm=\mathscr M_\pm^{-1}\) is a vector
bundle \(\mathscr R_\pm\) in degree zero: antiample lines have
cohomology only in degree \(d\), which cancels the shift in the
inverse equivalence. Its rank is \(h^0(\mathscr M_\pm)\).

The needed isogeny formula is
\[
\phi_{\mathscr M_\pm}^*\mathscr R_\pm
\simeq \mathscr M_\pm^{\oplus h^0(\mathscr M_\pm)}
\tag{7}
\]
up to inversion of the line and a constant vector-space factor
according to the Poincaré sign convention; inversion has the same
numerical divisor class. In (7), “inversion” means pullback by
\([-1]\), not the dual line. In particular, if
\(\beta_\pm=c_1(\mathscr R_\pm)/\operatorname{rk}\mathscr R_\pm\),
then
\[
\phi_{\beta_\pm}=\phi_{\mathscr M_\pm}^{-1}.
\tag{8}
\]
Both are rational homomorphisms from \(\widehat A\) to \(A\).

For completeness, the isogeny formula uses no assumption about
the characteristic or degree of the isogeny. Pull the Poincaré
kernel back along \(\phi_{\mathscr M_\pm}\), apply the theorem
of the square, and change variables by addition on \(A\times A\).
The resulting direct image is the constant cohomology vector
space of \(\mathscr M_\pm^{-1}\) tensored with
\(\mathscr M_\pm\), up to the indicated inversion. Ample-line
vanishing and duality give rank \(h^0(\mathscr M_\pm)\).
Taking first Chern classes gives (8): pullback transforms a
polarization by \(\widehat\phi_{\mathscr M_\pm}\phi_\beta
\phi_{\mathscr M_\pm}\), while
\(\widehat\phi_{\mathscr M_\pm}=\phi_{\mathscr M_\pm}\).

The canonical nonzero truncation map
\(\mathscr K_\pm\to\mathcal C_\pm\) therefore gives, by the
equivalence and ordinary adjunction, an actual nonzero map
\[
\mathcal V_\pm:=j^*\mathscr R_\pm
\longrightarrow B_C\otimes L_0^{\pm1}.
\tag{9}
\]
This step keeps the actual cohomology family, rather than merely
its determinant class.

The bundles \(\mathcal V_\pm\) are strongly semistable. Pull (7)
back to \(C^{(1)}\), and normalize a reduced component of the
resulting finite cover which dominates \(C^{(1)}\). On this smooth
curve the pullback of \(\mathcal V_\pm\) is a direct sum of copies
of one line. The same is true after every Frobenius pullback.
A destabilizing subbundle would stay destabilizing on this finite
cover, because degrees and slopes multiply by its degree. This
contradicts semistability of a direct sum of equal-degree lines.
The finite cover can be inseparable; no étale trivialization is
being assumed.

The canonical inclusion \(B_C\hookrightarrow F_{C/k*}\omega_C\),
projection formula, and Frobenius adjunction turn (9) into
\[
0\ne F_{C/k}^*\mathcal V_\pm
\longrightarrow \omega_C\otimes F_{C/k}^*L_0^{\pm1}.
\tag{10}
\]
The saturated image is a line of degree at most \(2G-2\).
Strong semistability and \(\deg L_0=0\) give
\[
\lambda_\pm:=\deg(j^*\beta_\pm)
=\mu(\mathcal V_\pm)\le\frac{2(G-1)}p.
\tag{11}
\]

## 4. Trace normalization and a scalar inequality

Write \(\phi_\theta:A\to\widehat A\) for the induced polarization,
and put
\[
a_\pm=\phi_\theta^{-1}\phi_{\mathscr M_\pm}
\in\operatorname{End}^0(A),\qquad
\operatorname{tr}(u)=\tfrac12\operatorname{Tr}
(u\mid H^1_{\mathrm{et}}(A,\mathbf Q_\ell)),\quad \ell\ne p.
\tag{12}
\]
Then \(\operatorname{tr}(1)=d\), and
\[
\lambda_\pm=\operatorname{tr}(a_\pm^{-1}).
\tag{13}
\]
To check the normalization, factor \(j\) through the Abel map
to \(\widehat J\). The Poincaré formula
\([a_C(C^{(1)})]=[\Theta_{\widehat J}]^{G-1}/(G-1)!\)
identifies the degree of a pulled-back divisor with half the
trace of its polarization relative to the principal one.
Pullback of \(\beta\) along \(\widehat i\) has polarization
\(i\phi_\beta\widehat i\). Cyclicity of trace then gives
\[
\deg j^*\beta
=\tfrac12\operatorname{Tr}(\phi_\beta\phi_\theta)
=\operatorname{tr}(\phi_{\mathscr M}^{-1}\phi_\theta),
\tag{14}
\]
which is (13). For example, if \(A=J\) and
\(\mathscr M\) has class \(t\Theta_J\), the value is \(G/t\).
The formula does not make the induced polarization on \(A\)
principal.

The Rosati involution for \(\theta\) makes each \(a_\pm\)
positive and self-adjoint. For any such \(a\),
\[
\operatorname{tr}(a)\operatorname{tr}(a^{-1})\ge d^2.
\tag{15}
\]
One algebraic proof uses the positive trace form on
\(\operatorname{End}^0(A)\otimes\mathbf R\).
Positive self-adjoint \(a\) has a positive square root in this
real semisimple algebra. Cauchy--Schwarz applied to
\(a^{1/2}\) and \(a^{-1/2}\) gives (15). Thus no complex
uniformization or lift of \(A\) is used. Positivity of the
Rosati trace form is the usual polarization theorem; see
[Milne, Abelian Varieties, I.14](https://www.jmilne.org/math/CourseNotes/AV.pdf).
Alternatively (15) is the weighted arithmetic--harmonic mean
inequality for the positive eigenvalues.

Let \(x_\pm=\operatorname{tr}(a_\pm)>0\). Taking trace in (6)
and using the intersection interpretation of this trace gives
\[
x_++x_-\le(p-1)d.
\tag{16}
\]
The inequality is strict if \(D\ne0\). Combining (11),
(13), (15), and the scalar harmonic-mean inequality gives
\[
\frac{4(G-1)}p
\ \ge\ \lambda_++\lambda_-
\ \ge\ d^2\left(\frac1{x_+}+\frac1{x_-}\right)
\ \ge\ \frac{4d^2}{x_++x_-}
\ \ge\ \frac{4d}{p-1}.
\tag{17}
\]
This proves the dimension bound, including its strict form.
Pairing the opposite translates is essential: an arbitrary coset
does not have one inversion-invariant kernel polarization.

## 5. Codimension-one consequences

If \(d=G-1\), inequality (1) in the statement is impossible.
Hence no translated abelian divisor has generic defect one.
Raynaud's full theta is a proper divisor. At a generic point
of one of its divisorial components, a square cohomology matrix
over the local discrete valuation ring has determinant valuation
at least its residue corank, by Smith normal form. A component
with generic defect at least two therefore has multiplicity
at least two.

For an abelian divisor through the origin, the
[quotient a-number theorem](restricted_raynaud_complement_rank.md)
gives \(\delta\le a(J/A)\le1\), since the quotient has dimension
one. Excluding \(\delta=1\) leaves \(\delta=0\). The same
argument proves the stated larger-dimensional vanishing criterion
whenever \(a(J/A)\le1\). Frobenius twisting causes no restriction:
over the perfect ground field the abelian subvariety and its
quotient descend through that scalar twist.

The argument neither proves generic defect at most one on an
arbitrary translated abelian divisor nor excludes higher generic
defects there. For the current mixed family, the source genus
grows with the unknown degree; its dimension is below the bound.
The actual two-map nonannihilation problem remains open.

## 6. Wronskians give a bound at higher generic defect

Here suppose the two families have generic \(h^0=s\), and their
generic global sections are independent over the function field
of the curve. Their kernels \(\mathscr K_\pm\) are reflexive of
rank \(s\), and necessarily \(s\le p-1\). Put
\(\mathscr M_\pm=(\det\mathscr K_\pm)^\vee\).

There is a canonical morphism
\[
W_s:\bigwedge^s B_C\longrightarrow F_{C/k*}\omega_C^{\,q},
\qquad q=\frac{s(s+1)}2.
\tag{18}
\]
In a local parameter \(t\), send exact differentials
\(a_1(t)\,dt,\ldots,a_s(t)\,dt\) to
\[
\det\bigl(\partial_t^{\,j-1}a_i(t)\bigr)_{1\le j,i\le s}
\,(dt)^q.
\tag{19}
\]
Derivatives kill functions pulled back from \(C^{(1)}\), so (19)
is alternating and \(\mathcal O_{C^{(1)}}\)-multilinear. Under
change of parameter, its rows change triangularly, with diagonal
factors \((dt/du)^1,\ldots,(dt/du)^s\). Their product is exactly
the change of \((dt)^q\). This proves that (18) is global and
regular.

Over the function field, (19) is nonzero precisely when the
\(a_i\) are independent over the constants of \(\partial_t\),
which are \(k(C)^p\) over the original perfect ground field.
Over the generic parameter field, use instead the relative
Frobenius subfield \(k(A)(C^{(1)})\subset k(A)(C)\);
the parameter field itself need not be perfect.
A short proof works over this constant field:
divide all columns by a nonzero first entry to replace the first
function by \(1\). The Wronskian reduces to that of the derivatives
of the other ratios. Induction says that its vanishing gives a
constant linear combination of those derivatives equal to zero;
integration here only means that an element with zero derivative
belongs to that constant field. This yields a constant linear relation among
the original functions. The converse is immediate. No division
by a factorial or formal exponential is used.

Taking the determinant of universal evaluation and then (18) gives
a nonzero morphism
\[
\det\mathscr K_\pm\longrightarrow
R\pi_*\!\left(
F_*\omega_C^{\,q}\otimes L_0^{\pm s}\otimes\mathscr P^{\,s}
\right).
\tag{20}
\]
Initially take determinants where \(\mathscr K_\pm\) are locally
free. The complement has codimension at least two, and the
resulting map from a line to a vector bundle on
\(C^{(1)}\times A\) extends across it. This justifies (20)
for reflexive kernels as well. Its nonvanishing uses exactly
the function-field independence hypothesis.

Evaluation of (20) at a general point of the curve shows that
\(V^0(\mathscr M_\pm)\) contains \([s]j(C^{(1)})\). This curve
generates \(\widehat A\) and contains the origin. The argument
in Section 1 again makes \(\mathscr M_\pm\) ample. Relative
duality and determinants give exactly (6), with the same
coefficient \(p-1\); the kernel rank does not multiply that
coefficient.

Apply the inverse Fourier transform to (20). Its curve map is
now \([s]j\), because the Poincaré line is raised to its \(s\)-th
power. The resulting strongly semistable bundle has slope
\[
\deg([s]j)^*\beta_\pm
=s^2\operatorname{tr}(a_\pm^{-1}).
\tag{21}
\]
Frobenius adjunction sends its nonzero map to a map into
\(\omega_C^q\otimes F_C^*L_0^{\pm s}\). Hence
\[
\operatorname{tr}(a_\pm^{-1})
\le\frac{2q(G-1)}{p s^2}
=\frac{(s+1)(G-1)}{p s}.
\tag{22}
\]
The identical trace argument (15)--(17) now gives
\[
\frac{4d}{p-1}\le
\operatorname{tr}(a_+^{-1})+\operatorname{tr}(a_-^{-1})
\le\frac{2(s+1)(G-1)}{p s},
\tag{23}
\]
proving (2) and strictness when \(D\ne0\).

The largest coefficient in (2) occurs at \(s=1\) and is already
strictly less than one. If an abelian divisor translate is
contained in theta, both opposite generic defects agree. If its
defect exceeds \(p-1\), function-field dependence is automatic
by the rank of \(B_C\). Otherwise independence in both families
would contradict (23). If inversion preserves the translate,
the two generic evaluation ranks agree, giving the final assertion.

For clarity, a positive-dimensional parameter family with more
global sections than their function-field rank has not been
excluded by this argument. Taking its determinant would give
the zero Wronskian. Treating that determinant as nonzero would
lose the essential extra hypothesis.
