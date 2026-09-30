# Commutators become invariant principal divisors

30 September2026. [Statement](../../Theorems/cartier_and_spin/actual_marked_incidence_symmetry.md).
Two established inputs are used without replaying their arithmetic:
the [commutative geometric endomorphism field](../jacobians/isogeny_sieves/etale_endomorphism_packets.md)
of J(X), and the signed threshold in
[the exact marked-divisor theorem](marked_divisor_relation_lattice.md).

Write v_a=[R_a-O], including v_O=0. Let L:Z^13->Gamma send the basis
vector indexed by a to v_a. Principality of the comparison norms says
that the O-column of M and the O-column of its transpose have zero
Jacobian class. Consequently the actual push-pull maps give
\[
LM=\psi L,\quad LM^t=\psi^\dagger L,
\qquad \psi=(h_1)_*h_2^*.
\]
Indeed (h2)^*(R_b-O) followed by (h1)_* is the difference between
column b and column O. This uses the actual maps and the actual
principal comparison divisor; a bare nonnegative matrix would not
supply the displayed identities.

The geometric rational endomorphism algebra of J(X) is a number field.
Thus every actual endomorphism, including psi and its Rosati adjoint,
commutes with the cubic automorphism gamma and with25-Frobenius pi.
Equality in End^0 implies equality of these actual endomorphisms,
since End(J(X)) is torsion-free. On Gamma, gamma and pi are represented
by G and F, respectively. The Frobenius action here is on the marked
Jacobian classes; no separable Frobenius map of curves is being asserted.

## The cubic commutator

Put D=MG-GM. Each column of D has degree zero, zero Jacobian class,
and support on the thirteen marked points. It is the difference of
two nonnegative columns of total degree n. Its positive and negative
parts therefore have degree at most n. It is a principal divisor.

If n<=788051, the signed marked-divisor theorem forces a function
having this divisor to belong to k(x). Its divisor is gamma-invariant.
Hence every column of D is fixed by G. In rational vector-space terms,
\[
PD=D,\qquad P=(1+G+G^2)/3.
\]
The same argument applies to D^t=G^{-1}M^t-M^tG^{-1}, using the actual
adjoint psi^dagger, which commutes with gamma^{-1}. Columns on both sides
of this transpose difference still have total degree n, because M is
doubly stochastic up to the factor n. Thus D^t has gamma-invariant
columns as well. Since P=P^t, this says DP=D.

But PG=GP=P, and consequently
\[
D=PDP=P(MG-GM)P=PMP-PMP=0.
\]
All averaging in this paragraph is rational linear algebra on integer
incidence counts. There is no division by a cover degree in a field of
characteristic five and no construction of a Galois closure.

## The coefficient-Frobenius commutator

Now put D_F=MF-FM. Its columns are again degree-zero principal marked
divisors of positive degree at most n, because psi commutes with pi.
The same signed threshold shows Im(D_F) is contained in Im(P).
The already proved MG=GM makes M preserve ker(P)=V_-. The permutation
F also preserves V_-, since it commutes with G. Therefore D_F maps
V_- into both V_- and Im(P), whose intersection is zero. It follows
that M and F commute on V_-.

The twelve-cycle F on the finite marked coordinates is the regular
Q[T]/(T^12-1) module. Its gamma-invariant part is the T^4-1 summand.
Removing that part leaves the cyclic module
\[
V_-\simeq\mathbf Q[T]/((T^{12}-1)/(T^4-1))
=\mathbf Q[T]/(T^8+T^4+1).
\]
The O-coordinate is invariant and is absent from V_-. The commutant of
a cyclic operator on this eight-dimensional module consists exactly
of its polynomials. This proves the second assertion without making
any assertion about the invariant five-dimensional block.

Finally the accepted inequality 2n<=31delta makes delta<=50842 imply
n<=788051. This substitution is only a convenient sufficient range.
The criterion is fundamentally on the actual covering degree n.

The proof yields symmetry of counts at every marked pair. It does not
identify the matched formal branches or their higher coefficients.
Hence it cannot yet be promoted to a simultaneous cubic action on T,
or to equality of the two embedded fields.
