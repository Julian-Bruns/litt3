# The marked bounded-primitive annihilator cannot come from the original horizontal source

Version 2, 3 October 2026. Independent focused audit **PASS** in
[the endpoint-kernel audit](../../Research/notes/oct03_ten_hour/cartier_kernel_y_audit.md).
This is a whole exclusion of the explicitly marked branch below, not an
exclusion of all rank-three traces or of the unmarked common-cover problem.

Work in characteristic five with the fixed ordinary genus-two $Y$, its
Weierstrass point $P=P_0$, and the actual étale source $q:T\to Y$ of degree
$N$. Retain both actual finite étale endpoint maps on this same $T$.
Let $L^{16}\simeq\omega_T$, and retain the original horizontal surjection
$W\otimes\mathcal O_T\twoheadrightarrow
q^*F_Y^*K\otimes L^{-10}$,
where $K\subset B_Y$ has rank three and degree one. All twists on
$Y^{(1)}$ and $T^{(1)}$ retain their relative Frobenius conventions.

Then every line subbundle of $F_Y^*K$ has degree at most two.

Now suppose $K$ is saturated, with annihilator
$A=K^\perp\subset B_Y$, and impose the **additional exact marking**
$A\simeq\mathcal O_{Y^{(1)}}(-P^{(1)})$.
Suppose its nonzero adjunction $F_Y^*A\to\omega_Y$ vanishes at both fixed
wild points $R_+,R_-$ and the evaluation $F_Y^*K\to\omega_Y$ is surjective.
Suppose also that the actual inclusion $A\to B_Y$ lifts through
$F_{Y*}\mathcal O_Y\to B_Y$. Equivalently its adjunction has a global
primitive regular away from $P$ with pole at most five.

These hypotheses are impossible for the original horizontal source.
More precisely, in the retained coordinate model
$w^2=az^5+cz^4+d$, $a=c-1\ne0$, $c\ne0$, $d=-1$,
$P=\infty$, $R_\pm$ are the two points $z=0$, and $\eta=dz/w$,
all possible marked bounded-primitive embeddings normalize to
$\delta_e=z\,dz+ez^3\eta$, $e^2\ne c$.
Their actual evaluation kernels satisfy
$H_e=\ker(F_Y^*K_e\to\omega_Y)
\simeq\mathcal O_Y(3P)\oplus\mathcal O_Y$.
The line $\mathcal O_Y(3P)\subset H_e\subset F_Y^*K_e$ contradicts the
original source bound above.

There is also an exact cohomological test in the entire marked,
wild-avoiding first-jet chart
$\delta=z\,dz+bz^2\eta+ez^3\eta$:
$h^0(H_Y(-3P))=1$ if $b=0$, and $h^0(H_Y(-3P))=0$ if $b\ne0$.
Thus the nonlifting coefficient removes precisely this canonical
degree-three subline. This test does not classify all Picard-degree-three
lines or remove the nonlifting source branch.

No annihilator marking is inferred from its degree. Saturation is not
assumed merely from $J/K=\mathcal O$; the accepted saturation theorem
requires its actual $\ell(q_1)\ne0$ hypothesis. The nonlifting adjunction
term $bz^2\eta$, and all unproved annihilator markings, remain outside
this exclusion. In the marked chart with the actual wild-avoiding first
jet, any surviving original source must have $b\ne0$, hence a genuinely
nonzero lifting obstruction and minimal global primitive pole fifteen.

[Proof](../../Proofs/cartier_and_spin/canonical_ten_marked_bounded_primitive_cartier_exclusion.md).
