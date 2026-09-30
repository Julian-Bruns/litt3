# Centering at the quadratic critical polynomial's vertex

30 September2026.
[Statement](../../Theorems/cartier_and_spin/degree_ten_centered_cubic_energy.md).
The weighted moment identities and the zero quartic remainder give
\[
\operatorname{Tr}(1/\phi)=E_1=0,
\quad c=\tfrac12\operatorname{Tr}(b^2/\phi^2),
\quad d=\tfrac13\operatorname{Tr}(b^3/\phi^2),
\qquad\phi=b^5+f.
\]
Under a base translation by a, c is unchanged, d becomes d+2ac,
and E3 becomes E3+3 da E2. Consequently d/(2c) translates by a
where defined. Expanding the centered cube proves the formula
for I3; the terms involving E1 and Tr(1/phi) vanish. The cleared
formula then proves invariance globally, including zeros of c.

Use the regular local primitive frames of the uniform energy
theorem. At a selected finite endpoint the first two weighted
moments give sum a_i=sum b_i=sum a_i^2=0 for the small-root
expansions w_i=a_i r+b_i r2+O(r3). Hence c has order at least-3,
d at least-3, E2 at least-2, and E3 at least-3. The Wronskian
c dd-d dc has order at least-6 because its order-minus-seven
terms cancel. It follows that I3 has order at least-9. The
polynomial t has a simple zero at each such endpoint.

Away from selected endpoints, an integral root with phi a unit
contributes regularly. At a pole of w of order m>=1, phi has pole
5m. Its contributions to c and d have orders8m and7m, to E2
at least3m-2, and to E3 at least2m-3. Thus c,d,E2 and their
derivatives are regular there, while E3 has at most a simple pole.
The only possible finite poles of this kind lie in h_*G. In the
constant profile h_*G=10O. In the linear profile
h_*G=3R_r+7O, with R_r=(r,0); the function v=x-r has order three
at R_r and removes the possible simple pole. Translation invariance
permits the regular primitive frame at the cubic branch points too.

At infinity, in the short frame q has pole seven. Small roots have
pole at most one; large roots have pole m>=2. The moment cancellations
already proved give ord(c)>=13 and ord(E2)>=4. Directly, small
roots contribute to d from order11, while large roots start at14.
All roots contribute to E3 from order at least one: for large roots
the bound is2m-3. Therefore the two terms of I3 each have order
at least27. Multiplication by t9 costs81 at infinity, and by a
linear v costs a further three. This proves the stated bounds.
Since div(omega0^3)=48O, the scalar spaces have pole bounds102
and105; Riemann--Roch gives dimensions94 and97.

Finally c,d and their derivatives are independent of the scale.
The generalized numerator theorem gives deg(Delta2 E3)<=6, and
deg(Delta2 E2)<=5, proving the scale bound for I3.

## Why a cubic moment is a new test

Over k[[r]] put q=1+r, tau=1 and
\[
H=W^5+W^3-1,\qquad
F=(W^5+q)H+1
=W^{10}+W^8+rW^5+(1+r)W^3-r.
\]
Its reduction has a triple root at zero and seven distinct nonzero
roots. The latter lift etale. The triple cluster is tame of index
three: its normalization is given by
\[
r=\frac{W^3(1+W^5+W^7)}{1-W^3-W^5}=W^3+O(W^6).
\]
If u^3=r, then W=u+O(u4). Also phi=W5+1+r=1+O(u3).
The local quadratic source energy has possible terms u^-4 and
u^-1 before nonnegative orders. Their cubic traces vanish, so E2
is regular. Here c=1,d=0 and Qsharp=E2. However E3 has leading
term
\[
\operatorname{Tr}\bigl((\tfrac13u^{-2})^3\bigr)(dr)^3
=\tfrac19 r^{-2}(dr)^3\ne0.
\]
Thus I3=E3 has a genuine double pole at this ramification point.
The polynomial has constant Frobenius remainder and fifth-power
norm; these do not erase this distinction. This is a formal local
example, not an admissible proper-curve realization on the fixed X.
