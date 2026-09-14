# Exact finite-algebra computation conventions

Let R=K[z_1,...,z_n], I an ideal, and A=R/I a nonzero finite-dimensional
commutative algebra. Its length D=dim_K(A) includes residue degrees and
multiplicities. A known length is established independently of the
candidate certificate. Fix a monomial order when using leading monomials.

A derived polynomial belongs to I by exact ideal-preserving operations.
A certificate records enough exact identities to check this membership.
A certified kernel basis satisfies the original matrix equation and has
independent columns numbering the original matrix's nullity.

Write N for the nilradical. In characteristic p, F_A(a)=a^q for a
specified q=p^r. This is semilinear over a perfect field K, and linear
over K=F_q. A closed point P has residue degree d_P=[kappa(P):K] and
local length ell_P=length(A_P); it contributes d_P*ell_P to D.
Over a perfect field it gives d_P geometric points, each of multiplicity
ell_P. The p-power map over F_q need not be F_q-linear.

Standard monomials of a monomial ideal are the monomials outside it;
their number is its colength, possibly infinite. These conventions
allow nonreduced algebras and do not assume a single algebra generator
or rational roots.
