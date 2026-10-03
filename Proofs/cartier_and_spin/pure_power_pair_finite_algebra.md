# Proof: total-degree reduction bounds the pair algebra

30 September 2026.
[Statement](../../Theorems/cartier_and_spin/pure_power_pair_finite_algebra.md).
Invert the two-by-two leading coefficient matrix. Linear combinations
of the two equations become
\[
x^m+R(x,y)=0,\qquad y^m+S(x,y)=0,
\quad\deg R,\deg S\le m-1.
\]
Whenever a monomial has an exponent at least m, substitution reduces
its total degree. Induction reduces every residue class to a linear
combination of the m^2 displayed monomials. The algebra is therefore
finite, possibly zero; its number of geometric points is at most its
dimension. No assertion of reducedness or nonemptiness is needed.

For a rational-function solution over bar(H), its finitely many
coefficients generate a finite field extension H'/H. Normalize its
numerator and denominator representations so that distinct conjugates
of that coefficient field give distinct rational-function pairs. They
all satisfy the original equations over H(t). Since finite fields are
perfect, the conjugate count is [H':H], bounded by m^2. This recovers
the coefficient-field bound without assuming it for an unknown curve.

This retains the useful algebraic step of the former fixed-V4 character
reconstruction proof. Its old degree86/87 profile searches and geometric
applications are superseded by the complete pole-twelve exclusion;
the present lemma assumes the leading-form independence explicitly.
Independent root-agent review on 30 September 2026 confirmed both the
total-degree reduction and the finite constant-field conjugate bound.
