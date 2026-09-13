# Proof: reconstruct Raynaud theta from twelve Kummer points

[Statement](../../../Theorems/jacobians/theta_divisors/backup_raynaud_quadric.md).
Author /root,2026-09-08. The actual geometric theta divisor, not a finite
sample surrogate, is identified below.

## 1. Why one quadric suffices

For odd p, Tong's Propositions1.2.3.1 and1.2.3.3 show that Theta_B is
linearly equivalent to(p-1)Theta for any symmetric principal theta
defined by a theta characteristic, and descends to an effective Cartier
divisor on the Kummer quotient. The proof of1.2.3.3 identifies its line
bundle there with O((p-1)/2), where O(1) pulls back to2Theta.
Here p=5, so the descended divisor belongs to |O_Kum(2)|.
The genus-two Kummer is a quartic hypersurface in P3. The hypersurface
sequence, twisted by2, gives

    H^0(P3,O(2)) -> H^0(Kum,O(2))

as an isomorphism (H^0(O(-2))=H^1(O(-2))=0). Thus the actual theta
section is a unique quadric up to nonzero scalar. In particular there
is no unaccounted translate, odd section, or extra quadric relation.

Primary sources, relevant proofs/formulas read:
[Tong, Sections1.2.3, pp.6-7](https://arxiv.org/pdf/0712.2046), and
[Corte-Real Santos--Flynn, Section2, equations2.2-2.4](https://people.maths.ox.ac.uk/flynn/arts/art43.pdf).
The latter supplies the standard coordinates used here over any field
of characteristic different from2. Its symmetric-polar formula gives
the displayed polynomial expression for w after reducing V0^2-F modulo U.
This expression remains valid at repeated U; no division by its
discriminant is used in the certificate.

## 2. Recovering all twenty-four nonzero kernel classes

Work in F_(5^12) and embed alpha as a root of alpha^3+alpha+1. Let

    H_ij=[u^(5i-j)]F^2,  i,j=1,2.

The certificate checks det(H)!=0. A holomorphic logarithmic differential
omega=(a+b*u)du/v satisfies Cartier(omega)=omega exactly when

    (a^5,b^5)^T=H(a,b)^T.

Because H_10!=0, this becomes a=(b^5-H_11*b)/H_10 and the additive
degree25 polynomial printed in the source. All25 roots are distinct and
are found in the indicated field. For each nonzero pair(a,b), solve the
following LINEAR system for A of degree<=5 and B of degree<=2:

    A'=(a+b*u)B,
    F B'+F'B/2=(a+b*u)A.

The exact kernel has dimension1 in every case, with deg A=5. Normalize
A monic. The equations are precisely dlog(A+vB)=omega. Thus the divisor
of h=A+vB is divisible by5 at every point. Its unique pole has order10
at O, so div(h)=5D-10O for an effective degree-two D. Its nonzero
logarithmic differential proves [D-2O]!=0: if D-2O were principal,
h would be a constant times a fifth power. Distinct logarithmic forms
give distinct classes, since the same divisor class gives functions
differing by a constant times a fifth power. Ordinarity gives exactly25
geometric 5-torsion points; hence the24 constructed classes exhaust
J[5](k)-{0}.

The norm identity is checked coefficientwise:

    A^2-F B^2=U^5,  U monic of degree2.

To recover the selected sheet, cancel gcd(A,B) ONLY in the ratio A/B,
then set V0=-A_reduced/B_reduced mod U. The certificate checks that
B_reduced is coprime to U and U divides V0^2-F. Common factors at
branch points really occur and must not be discarded. At a nonbranch
zero, the ratio selects the zero sheet; simultaneous zeros on both
sheets would make D a hyperelliptic fiber and the class zero, already
excluded. At a branch zero there is only one point. Therefore these
Mumford coordinates represent the classes just constructed, including
branch-point and repeated-divisor cases.

## 3. The exact interpolation certificate and twist

The24 classes give12 distinct Kummer points. The matrix evaluating the
ten quadratic monomials at them has rank9. Its one-dimensional kernel,
normalized at K0^2, is EXACTLY the coefficient list in the statement.
Every coefficient is checked to belong to F125, then expressed in
1,alpha,alpha^2. The source checks equality to the literal saved list.

For each constructed class m, Fr(m) is a nonzero point of ker V.
Tensoring the defining sequence of B_C shows that every such point
lies on Theta_B. Relative Frobenius sends the Kummer coordinates to
their fifth powers on the coefficient-twisted curve. The inverse
coefficient-Frobenius transport of the actual theta quadric therefore
vanishes at all12 certificate points. By rank9 and Section1 it must
be Q, up to scalar. This proves the equation on the ENTIRE Jacobian.
Also V Fr=[5], and Fr preserves geometric torsion orders, proving
the last equivalence in the statement.

Replay (one core):

    OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1 MKL_NUM_THREADS=1 VECLIB_MAXIMUM_THREADS=1 sage scripts/genus_two/backup_raynaud_quadric.sage

The original diagnostic completed in0.280s; the frozen checker reports
its own elapsed time. It replays exact polynomial identities and ranks,
not floating-point interpolation. No solution of the residual singleton
intersection or prime-to5 torsion test is claimed here.
