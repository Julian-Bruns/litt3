# Frobenius on the conductor quotient: exact local part and global boundary

Version 2, 2026-09-08. Author proofs/self-checks from 2026-09-05;
independent audit pending. Consolidates the local conductor calculation
and the differential-ratio counterexample. The exact finite-field
regression was replayed successfully on 2026-09-08.
Original authors: /root/x_elliptic_quotient_maps (conductor Frobenius)
and /root/gluing_cohomology_rigidity (same-derivative counterexample).

Scope correction: the two-leg pullback kernel in Section 3 need NOT be
finite without Hom-zero. The ENTIRE kernel is exceptional. The old
unqualified finiteness claim is replaced by a proof under Hom-zero and
an explicit diagonal counterexample. No audited theorem is being enlarged.

## 1. Stable branch gluing and nilpotent higher jets

Let k be algebraically closed of characteristic p>0. Let C be a reduced
integral projective curve with smooth normalization ν:Z→C, and suppose
every completed branch is smooth. Set Q=ν_*O_Z/O_C. At a singular point P,
write r_P for the number of branches and δ_P=length(Q_P). Put

\[
 \delta=\sum_P\delta_P,\qquad b=\sum_P(r_P-1),\qquad u=\delta-b.
\]

Here b is the toric rank and u the unipotent gluing length. For a finite
dimensional semilinear Frobenius space, its eventual-image part is
bijective and its complementary eventual-kernel part is nilpotent.

Locally let A be the completed local ring of C and
B=∏_{i=1}^r k[[t_i]] its normalization. Residues give a surjection

\[
 B/A\longrightarrow k^r/k_{\rm diag}.
\]

Its kernel Q_+ is represented by tuples of positive valuation after
subtracting a diagonal constant. Constants provide an F-stable splitting,
so the quotient has a bijective part of dimension r−1. The conductor
contains ∏t_i^{c_i}k[[t_i]]. If p^a≥max_i c_i, raising any positive-valuation
tuple to p^a puts it in A. Therefore

\[
 \dim(Q_P)_{\rm st}=r_P-1,\qquad
 \dim(Q_P)_{\rm nil}=\delta_P-r_P+1.                       \tag{1}
\]

For an actual bi-etale joint image, all branches are smooth etale graphs,
and δ_P=Σ_{i<j}m_ij by the
[conductor/collision proof](100_JOINT_IMAGE_CONDUCTOR_CRITERION_FOR_BIETALE_COVERS.md).
Hence u=0 precisely when every singularity is an ordinary double point.
A transverse triple already contributes one nilpotent conductor direction.

For two branches of contact m, Q_P≅k[[x]]/(x^m), with Frobenius the pth
power. For every a≥0,

\[
 \operatorname{rank}F^a=\left\lceil m/p^a\right\rceil,\qquad
 \dim\ker F^a=m-\left\lceil m/p^a\right\rceil.             \tag{2}
\]

Its stable part is the constants. The nilpotence exponent of the
nonconstant part is the least a≥0 with p^a≥m, including exponent zero
when m=1. Thus contact p^s has exponent s even if the two branch
derivatives agree identically.

Globally, connected projectivity gives H^0(O_C)=H^0(O_Z)=k and an exact
Frobenius-equivariant sequence

\[
 0\longrightarrow H^0(Q)\longrightarrow H^1(O_C)
       \longrightarrow H^1(O_Z)\longrightarrow0.        \tag{3}
\]

Stable dimension is additive in exact sequences of finite-dimensional
semilinear Frobenius spaces over a perfect field. If f_F(C) is the stable
dimension of H^1(O_C) and f(Z) the p-rank of Z, then

\[
 f_F(C)=f(Z)+b,\qquad
 p_a(C)-f_F(C)=g(Z)-f(Z)+u.                               \tag{4}
\]

The singular cohomology therefore has a known extra nilpotent contribution;
it must not be confused with the Frobenius defect of Z.

## 2. Prime-to-p labels require a Frobenius orbit

Let L∈Pic^0(C) have order n prime to p. Choose e with p^e≡1 mod n and
an isomorphism L^(p^e)≅L. Set L_i=L^(p^i), indices modulo e.
Frobenius sends the i-th labelled cohomology to the (i+1)-st; it is NOT
an endomorphism of a single label until one takes the return F^e.
Equivalently take their direct sum with the cyclic semilinear map.

Local trivializations make the conductor map q↦v_i q^p, with v_i∈A^×.
The residue quotient is still bijective and the positive-valuation part
still nilpotent, since every iterate only multiplies by units. Therefore
the return map on each label has stable dimension r_P−1 and nilpotent
dimension δ_P−r_P+1. The whole orbit has dimensions e(r_P−1) and
e(δ_P−r_P+1). In the two-branch case multiplication by the accumulated
unit does not change ranks, so (2) for the a-th return reads
m−ceil(m/p^(ea)) for the kernel.

For EVERY label the normalization sequence is

\[
\begin{aligned}
0\to H^0(C,L_i)&\to H^0(Z,\nu^*L_i)
 \to H^0(Q\otimes L_i)\\
 &\to H^1(C,L_i)\to H^1(Z,\nu^*L_i)\to0.                 \tag{5}
\end{aligned}
\]

These sequences commute with Frobenius around the orbit. If ν^*L_i is
nontrivial, its degree zero forces H^0(Z,ν^*L_i)=0, so (5) is short exact
starting at H^0(Q⊗L_i). If ν^*L is trivial, every H^0(Z,ν^*L_i) is a
one-dimensional constant space and Frobenius between them is bijective.
Its image in the conductor spaces is therefore wholly stable. It can
remove stable gluing directions but CANNOT remove any nilpotent conductor
directions. Thus the u-dimensional nilpotent conductor part still injects
in labelled H^1(C,L_i), including at all exceptional prime-to-p labels.

This argument uses periodicity and the full H^0 terms, not a tacit
identification of Frobenius on unrelated line bundles. No p-primary or
nonperiodic-label extension is asserted.

## 3. The actual two-leg exceptional locus

For an actual bi-etale joint normalization f:Z→X, g:Z→Y, suppressing
the corresponding Frobenius twists in the notation, put

\[
 \alpha:J(X)\times J(Y)\to J(Z),\quad
 (A,B)\mapsto f^*A\otimes g^*B,\qquad
 L=(A\boxtimes B)|_C.
\]

Then ν^*L=α(A,B). The short exact form of (5) applies OFF ker α.
On the ENTIRE kernel one must retain the H^0 terms; the preceding stable
image argument applies when A and B have prime-to-p order.

The kernel need not be finite: take X=Y=Z and f=g=id. These are two
actual etale maps, C is the diagonal, and α(A,B)=A⊗B has the
positive-dimensional kernel {(A,A^(−1))}. Birational joint minimality
does not repair the old finiteness claim.

If Hom(J(X),J(Y))=0, duality also gives the reverse Hom-zero. Applying
the two norms to α(A,B)=0 yields

\[
 [d_X]A+f_*g^*B=[d_X]A=0,\qquad
 [d_Y]B+g_*f^*A=[d_Y]B=0.
\]

Thus ker α lies in the finite group scheme
J(X)[d_X]×J(Y)[d_Y], and is finite even when a degree is divisible by p.
The norm argument proves exactly the hypothesis missing in version 1.

The local calculation says that singular H^1(C,L) contains u universally
nilpotent gluing directions on every prime-to-p label. Passing through
(5) removes that forced local contribution. It does NOT determine
Frobenius on H^1(Z,α(A,B)), or prove properness of the restricted Raynaud
theta locus H^0(B_Z⊗α(A,B))≠0. At a trivial normalized label the H^0 term
in the Raynaud sequence must also be retained. One cannot infer a
two-leg theta obstruction from the singular curve's forced defect.

## 4. Identical contact and differential data, different Frobenius kernels

Already in characteristic five, compare the three graphs

\[
 \phi_1=x,\qquad \phi_2=x+x^4,\qquad
 \phi_3=x+2x^4+\varepsilon x^5,\quad \varepsilon=0,1.
                                                               \tag{6}
\]

Both original coordinate projections are etale on each branch. The FULL
derivative series are the same for both models:
1, 1+4x^3, 1+3x^3. Hence every differential ratio agrees identically.
All three contacts are 4, each conductor exponent is 8 and δ=12. Yet

\[
\begin{array}{c|ccc|cc}
\varepsilon&\operatorname{rank}1&\operatorname{rank}F&
 \operatorname{rank}F^2&\dim\ker F&\dim\ker F^2\\ \hline
0&12&3&2&9&10\\
1&12&4&2&8&10
\end{array}                                                   \tag{7}
\]

Here is a direct proof. Reduce in V=(k[x]/x^8)^3. Using w=y−x only as
an auxiliary ring generator, the image S of the local ring consists of

\[
 a(x)(1,1,1)+h(x)(0,x^4,2x^4+\varepsilon x^5),
 \qquad \deg a<8,\quad\deg h<4.
\]

Since w² vanishes modulo x^8, this is the whole ring image, of dimension
12. Frobenius has ambient image U=(span{1,x^5})^3, of dimension 6.
A vector in S∩U must have a=a_0+a_5x^5 from its first coordinate.
Its second forces h=cx; its third then contains the extra term
εc x^6. Thus dim(S∩U)=3 for ε=0 and 2 for ε=1, giving rank F=3 or 4
on V/S. The second Frobenius has ambient image k^3, meeting S only in
the diagonal, so both ranks are 2. This proves (7) over algebraically
closed k, not just a finite sample. Stable dimension is 2 in both cases.

The SAME argument works for every prime p≥5, replacing 4 by p−1,
5 by p and the cutoff 8 by 2p−2. The contacts are p−1, δ=3(p−1),
rank F is 3 versus 4 and rank F² is 2. The obstructing term x^(p+1)
lies below the cutoff exactly because p>3.

The earlier characteristic-five pair
(x,x+x^5,x+2x^5) versus (x,x+x^5,x+2x^5+x^6)
likewise has identical contacts 5 and δ=15, but ranks F of 3 versus 4
and F² of 2. Modulo x^10 its ring image has the same a·1+h·w form;
the pure x^5 Frobenius image contains the non-diagonal w direction
only in the unperturbed model. This preserves that earlier regression
without repeating its full calculation.

These are local smooth multigraphs, not asserted global common covers.
They show that contacts determine eventual stable/nilpotent dimensions,
and determine every rank for TWO branches, but even full first-derivative
ratios do not determine intermediate Frobenius ranks for THREE branches.

## 5. Exact finite-jet computation and retained regression evidence

For distinct graphs y=φ_i(x), the branch-supported polynomial
∏_{j≠i}(y−φ_j(x)) evaluates on branch i to x^(c_i) times a unit and to
zero on every other branch. Thus for N=max c_i the conductor contains
all branch-supported x^N, and the quotient is computed EXACTLY in

\[
 (k[x]/x^N)^r/\operatorname{image}
   \langle x^a y^j:0\le a<N,\ 0\le j<r\rangle.             \tag{8}
\]

The monic degree-r relation in y reduces higher y-powers, so these
generators lose no local-ring image. Frobenius is induced by x↦x^p,
with coefficients raised to p. For coefficients in F_p, exact matrix
ranks over F_p are also the semilinear ranks after algebraic closure.

The unchanged [finite-jet checker](MULTIGRAPH_CONDUCTOR_FROBENIUS_JETS.py)
implements (8). Replay: Python 3, 2026-09-08, all 15 cases PASS.
Representative outputs in characteristic five are:

| Local model | δ | successive nonzero-power kernel dimensions | stable |
| --- | ---: | --- | ---: |
| Three transverse branches | 3 | 1 | 2 |
| Four transverse branches | 6 | 3 | 3 |
| Two branches, contact 5 | 5 | 4 | 1 |
| Two branches, contact 25 | 25 | 20,24 | 1 |
| Two branches, contact 125 | 125 | 100,120,124 | 1 |
| Three contacts 5, unperturbed | 15 | 12,13 | 2 |
| Same contacts, x^6 perturbation | 15 | 11,13 | 2 |
| Four branches, contacts 25,5,5,1,1,1 | 38 | 28,34,35 | 3 |

The two contact-four models in (6) are also regression cases. The script's
finite checks support these exact examples; the proofs above, not sampled
ranks, establish (1), (2), (5) and the all-p counterexample. Neither the
jet cutoff nor these computations control normalized global cohomology.
