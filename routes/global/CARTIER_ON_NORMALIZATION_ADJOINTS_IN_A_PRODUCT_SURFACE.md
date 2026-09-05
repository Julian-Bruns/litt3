# Cartier on normalization adjoints in a product surface

Date: 2026-09-05. Author: Codex, canonical-trace comparison agent.
Status: standard formulas and elementary deductions; author check, not
independently audited. No new generic-rank theorem or novelty claim.

## Exact source matches

1. Kudo--Harashita, *Computing the space of differential forms of a plane
   curve and its Cartier-Manin matrix*, [Theorem 2.2 and Section 6, (6.1)](https://arxiv.org/pdf/2203.11801).
   The theorem describes regular differentials on the normalization using
   conductor conditions on two affine charts, including possible
   singularities at infinity. Section 6 records and applies the
   Stoehr--Voloch formula. Their plane algorithm is not itself a global
   theorem for product surfaces; the surface formulation below follows
   from the local residue calculation and duality.
2. Schwede, *F-adjunction*, [Proposition 7.2, its proof, and Remark 7.3](https://msp.org/ant/2009/3-8/ant-v3-n8-p03-s.pdf).
   The proof identifies hypersurface dualizing Frobenius with ambient
   dualizing Frobenius precomposed with multiplication by the defining
   equation to power p^e-1. Remark 7.3 explicitly allows the divisor to be
   nonnormal or reducible when it is Gorenstein in codimension one and S2.
   Lemma 8.1 and Proposition 8.2 give normalization extension and conductor
   compatibility for the corresponding p^(-e)-linear maps.

The original formula is Stoehr--Voloch, *A formula for the Cartier operator
on plane algebraic curves*, J. reine angew. Math. 377 (1987), 49--64,
[DOI](https://doi.org/10.1515/crll.1987.377.49). Its formula was checked here
in the first primary source above; the original full proof was not
independently inspected in this bounded check.

## 1. The surface residue/adjoint formula

Let k be perfect of characteristic p>0, S a smooth surface, and
j:C -> S an integral effective Cartier divisor. Let nu:Z -> C be its
smooth normalization and put pi=j nu. Let c be the conductor ideal on C,
and let A be its inverse image in O_S. Thus A contains O_S(-C).

Finite duality and hypersurface adjunction identify

\[
 \nu_*\omega_Z=\mathfrak c\,\omega_C,
 \qquad \omega_C=\omega_S(C)|_C.
\]

Consequently there is an exact sequence

\[
 0\longrightarrow\omega_S\longrightarrow
       \mathcal A\,\omega_S(C)\xrightarrow{\mathrm{res}}
       \pi_*\omega_Z\longrightarrow0.                 \tag{1}
\]

For clarity, the finite-duality identification can be seen locally by
trivializing the invertible sheaf omega_C. Then
Hom_(O_C)(nu_*O_Z,O_C) is the conductor, viewed inside the common
function field, and finite duality identifies this Hom with nu_*omega_Z.

Write F_S:S -> S^(1) for relative Frobenius; superscript (1) on C, A,
and pi denotes base change by Frobenius of k. Ambient Cartier/trace
induces a canonical operator

\[
 \mathcal C_{S,C}:F_{S*}\omega_S(C)
       \longrightarrow\omega_{S^{(1)}}(C^{(1)}),       \tag{2}
\]

by the inclusion omega_S(C) -> omega_S(pC), followed by projection
formula and Tr_(F_S):F_(S*)omega_S -> omega_(S^(1)).

In local etale coordinates x,y, write C=(F=0). Use the residue convention
res(h dx wedge dy/F)=h dx/F_y. If

\[
 T_{xy}\left(\sum a_{ij}x^iy^j\right)
    =\sum_{i,j\equiv p-1\ (\mathrm{mod}\ p)}
        a_{ij}^{1/p}x^{(i-p+1)/p}y^{(j-p+1)/p},
\]

then the familiar p^(-1)-semilinear notation for (2) is

\[
 \frac{h\,dx\wedge dy}{F}\longmapsto
       \frac{T_{xy}(F^{p-1}h)\,dx\wedge dy}{F}.        \tag{3}
\]

This notation identifies the underlying twists over the perfect field.
In the intrinsic k-linear relative-Frobenius version, the output
coordinates, divisor equation, and forms lie on S^(1). In particular one
must not p-th-root the coefficients and independently twist them a second
time. The intrinsic construction (2) fixes all these conventions.

Taking residues gives

\[
 \mathcal C_Z\left(\frac{h\,dx}{F_y}\right)
       =T_{xy}(F^{p-1}h)\frac{dx}{F_y}.                \tag{4}
\]

The local numerator represents a differential regular on the
normalization exactly when its class modulo F lies in c. Equation (4)
therefore shows

\[
              T_{xy}(F^{p-1}\mathcal A)
                         \subset\mathcal A^{(1)}.    \tag{5}
\]

One way to verify (4) without any smoothness assumption on C at its
singular points is to check Cartier--residue compatibility on the dense
smooth locus. Both resulting differentials are rational differentials
on Z, so equality there proves equality everywhere. Regularity of
Cartier on Z then proves (5). Changing the lift h by F b changes the
output numerator by F^(1) times the ambient Cartier numerator of b, so
the residue formula is independent of that lift.

Thus (1) is compatible with the Cartier operators on its three terms.
The middle operator

\[
 C_{\rm adj}:F_{S*}(\mathcal A\omega_S(C))
        \longrightarrow\mathcal A^{(1)}\omega_{S^{(1)}}(C^{(1)})
\]

is locally surjective. Indeed, lift a target normalization differential
using the surjectivity of Cartier on the smooth curve Z; lift its source
through (1); the remaining error is an ambient regular two-form, which
can be corrected using surjectivity of Cartier on S. All these steps
are sheaf-local, not assertions about global sections.

Taking kernels in this diagram yields the exact ambient presentation

\[
 0\longrightarrow\ker(C_S:F_{S*}\omega_S\to\omega_{S^{(1)}})
   \longrightarrow\ker C_{\rm adj}
   \longrightarrow\pi^{(1)}_*B_Z\longrightarrow0,     \tag{6}
\]

where B_Z=F_(Z*)O_Z/O_(Z^(1)) is canonically identified with the kernel
of Cartier on F_(Z*)omega_Z. This is an identity for the actual embedded
curve and its actual normalization.

For any line bundle N on S^(1), the same diagram can be tensorized with
N. Equivalently use F_S^*N on the untwisted source before applying
projection formula. For S=X times Y and N=L external-tensor M this is
the precise twisted diagram relevant to the two-leg theta question.

## 2. What the two etale projections impose locally

Now let S=X times Y and assume both maps Z -> X and Z -> Y are etale.
At a geometric point of C, take local parameters x on X and y on Y.
The completed normalization is a product of k[[x]], and the branches
have equations

\[
       y=\phi_i(x),\qquad \phi_i'(0)\ne0.
\]

Up to a unit, F is the product of y-phi_i(x). On branch i put

\[
 d_i=F_y(x,\phi_i(x))
            =\prod_{j\ne i}(\phi_i(x)-\phi_j(x)).
\]

The conductor in the completed normalization is exactly

\[
 \mathfrak c=F_y\overline{\mathcal O}_C
            =F_x\overline{\mathcal O}_C.              \tag{7}
\]

For the first equality, Lagrange interpolation shows that a tuple
supported on branch i belongs to O_C precisely when its sole entry is
divisible by d_i. Indeed its unique representative of y-degree less than
the number of branches is the entry times
product_(j!=i)(y-phi_j)/d_i; its leading coefficient gives the necessary
divisibility, and the displayed formula gives sufficiency. Since the
conductor consists of tuples whose product with every branch idempotent
still belongs to O_C, this proves the assertion. For the second equality
differentiate F(x,phi_i(x))=0:

\[
                  F_x=-\phi_i'(x)F_y.
\]

The multiplier is a unit because the other projection is etale. Thus
each partial derivative cuts out exactly the conductor divisor on Z;
their ratio is the actual invertible differential ratio -dy/dx. In
particular, (4) applied to adjoint numerators F_y b is simply the usual
branchwise Cartier operator on b dx. Both legs are retained, but the
formula itself imposes no global invertibility assertion.

## 3. A local boundary: arbitrary tangent-contact defect remains possible

For any integer m>=2 consider only the formal reduced curve

\[
                     (y-x)(y-x-x^m)=0.
\]

Both normalization branches map etale to both coordinate disks: their
y-derivatives with respect to x are 1 and 1+m x^(m-1), both units.
Nevertheless its normalization quotient is

\[
 \overline A/A\simeq k[[x]]/(x^m),
              \qquad F(\bar b)=\overline{b^p}.
\]

Indeed the image of A in k[[x]] direct-sum k[[x]] consists exactly of
pairs whose difference is divisible by x^m. The Frobenius-stable part
of the quotient has dimension 1, and its nilpotent part has dimension
m-1, with unbounded nilpotence index as m grows. Thus smooth bi-etale
branch graphs alone do not bound this local nilpotent defect. This is
a FORMAL LOCAL test, not a construction of a connected global projective
bi-etale correspondence or a counterexample to restricted properness.

## Exact limit of the literature check

No checked source deduces generic twisted Frobenius injectivity from
(7), the two unit conormal derivatives, or birationality of normalization.
The source formulas supply the actual adjoint Cartier operator to test;
local surjectivity does not imply surjectivity on global sections after
a degree-zero twist.

A near-match requiring care is Miller--Schwede,
[*Semi-log canonical vs F-pure singularities*, Lemma 4.2](https://arxiv.org/pdf/1101.1033).
Its normalization-divisor formula is stated for S2, G1, SEMINORMAL
schemes. Tangent branch graphs need not be seminormal, so that theorem
was not used to infer extra consequences here. Their Lemma 3.1 provides
general conductor compatibility for p^(-e)-linear maps, but those maps
on structure sheaves, after trivializing dualizing sheaves, must not be
confused with an untwisted Cartier operator on the normalization.

Terzi's [Remark 10](https://arxiv.org/pdf/2309.06901) gives an ambient
cohomology computation under p_g(S)=q(S)=0. A product of two hyperbolic
curves does not satisfy these hypotheses. It supplies no stronger
two-leg generic-rank theorem for the present setting.
