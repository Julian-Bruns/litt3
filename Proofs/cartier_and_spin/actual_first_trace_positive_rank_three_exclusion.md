# Proof: robust canonical-line trace and exclusion of the smallest rank-three branch

Version1,2 October2026.
[Statement](../../Theorems/cartier_and_spin/actual_first_trace_positive_rank_three_exclusion.md).
[Independent focused review](../../Research/audits/ACTUAL_FIRST_TRACE_POSITIVE_RANK_THREE_AUDIT_2026_10_02.md) PASS. The Galois closure
below is taken over the ONE genus-two leg only. Both original maps
are retained throughout.

## Fixed integral data and the truncated canonical line

Use [the positive plane](positive_cartier_plane_orbits.md) and
[the original generated hyperplane](cartier_generated_frobenius_hn.md).
The quotient $U/P_X=O_X(6O)$ has original-section row
\[
([19]+x,-[16]-x,[20]+[14]x+[15]x^2).
\]
The entries span $\langle1,x,x^2\rangle$: the first two sum to
$[3]\ne0$, and the last has nonzero quadratic coefficient. Thus
\[
0\to O_X(-3O)^2\to I\simeq O_X^3\to O_X(6O)\to0,
\qquad I+P_X=U.
\]
The kernel is the pullback by the cubic map $x$ of the standard
complete quadratic evaluation kernel $O_{\mathbf P^1}(-1)^2$.
In particular actual traces satisfy $J+K=H$.

The canonical line $\lambda_X=O_X(-2O)\subset P_X$ has vector
\[
([10]+[13]x,[22]x,[8])^t
\]
in the original three-section frame. The codes mean
$a+5b\mapsto a+b\beta$ in $\mathbf F_{25}$ with
$\beta^2=\beta+3$. The fixed positive-plane certificate verifies
that the quotient row annihilates this vector and that its
Frobenius evaluation is the quartic square $A_4^2dx/y^2$.
Its coefficients are regular off $O$, with a nonzero constant
third entry; at $O$ its nonzero linear terms have pole three,
while the source line supplies order two. Hence
\[
\lambda_X\cap I=\lambda_X(-O)=O_X(-3O).
\]
This is also a direct summand of $I\cap P_X=O_X(-3O)^2$, since
a nonzero map between that source and the two identical line
summands is a constant nonzero column.

Let $R$ be the reduced ten finite cubic branch points. The original
image $I$ equals $U$ off $R+O$. At a cubic branch its primitive
orders are $(1,4,7)$; saturation has primitive orders $(1,2,4)$,
so $U/I$ has length one there. At infinity the original primitive
orders are $(2,8,11)$ and the saturated orders are $(1,2,3)$,
with elementary divisors one and two. The canonical positive-plane
branch divisor is
$R_P=O+x^*\operatorname{div}_0A_4$, with twelve finite points,
disjoint from $R$. The old radical's adjunction divisor is reduced.
The determinant contact divisor between the old radical and the
canonical line is the reduced degree-twelve divisor $\Delta_X$,
DISJOINT from $R_P$. Their two fiber directions therefore span
$P_X$ at every point of $R_P$.

## A collision bound with repeated sheet representatives retained

Take a connected one-leg Galois closure $q:T\to Y$ of degree $8d$.
Its raw sheet labels are all deck conjugates of an actual map
$h_0:T\to X$ of degree $d$. Distinct conjugate positive planes
form one transitive orbit of size $N$. Each has the same number
$8d/N$ of raw representatives. Products of their determinant
lines descend through $q$ and have degree $7N/8$ downstairs.
Therefore $8\mid N$, in particular $N\ge8$.

At a fixed point $t\in T$, exactly
$|h_0^{-1}(O)\cap q^{-1}(q(t))|\le d$ raw labels map $t$ to $O$.
Call a distinct plane removed only if ALL its raw representatives
map $t$ to $O$. At most $N/8$ distinct planes are removed. Each
surviving plane therefore supplies an untruncated canonical-line
generator at $t$. This definition is deck-equivariant. It requires
no assertion that the divisor $h_i^{-1}(O)$ is intrinsic to a
distinct plane.

Here is the numerical collision principle used twice. Let distinct
saturated lines $L_i$ in a rank-two bundle on $T$ be permuted
transitively with the deck action, and suppose every pair has a
determinant collision divisor of degree $cd$. At any point of a
fixed $q$-fiber the total number of colliding unordered pairs is
the same. Each such pair contributes at least one to its divisor
at that point. Thus this number is at most
\[
\frac c8\binom N2.
\]
If $m$ surviving lines have at most two fiber directions, their
colliding pairs number at least $m^2/4-m/2$. If they have only one
direction, that number is $m(m-1)/2$. Pair divisors are formed
ONLY from distinct lines, never from duplicate raw labels.

## Exact rank-three truncated trace

Suppose the positive-plane trace has rank three. Its saturation
$E$ has perpendicular line $A$, and adjunction gives $\deg A\le0$;
duality gives $\deg E=2+\deg A\le2$. Its actual image $K$ has
$\mu_{\min}(K)\ge7/16$, by etale splitting of the stable positive
planes. Hence $\deg K\ge2$, so $K=E$, $\deg E=2$ and $\deg A=0$.

Use the canonical quadratic theorem:
$V=E/A$ has rank two and degree two; the actual containing planes
give saturated quotient lines $L_i=P_i/q^*A$ of degree $7d$ in
$q^*V$, whose determinant has degree $16d$. Distinct planes give
distinct quotient lines. Thus their pair collision divisors have
degree $2d$. The canonical-line lifts in $q^*\mathscr H$ are the
Veronese squares of these lines, with the stipulated common twist.
Their regularity and saturation, even at the two quadratic-image
defects, are part of the canonical quadratic construction.

At least $m\ge7N/8$ distinct quotient lines survive truncation at
every point. If they had at most two directions there, their pair
collisions would be at least $m^2/4-m/2$. But the preceding upper
bound is $N(N-1)/8$. Their difference is at least
\[
\frac{17N^2}{256}-\frac{5N}{16}
=\frac{N(17N-80)}{256}>0\qquad(N\ge8).
\]
There are therefore at least three surviving directions at every
point. Their Veronese squares span the rank-three fiber of
$q^*\mathscr H$. By Nakayama, the untruncated sheet generators
generate this bundle integrally, not just generically.

After an etale Galois base change the trace map is the sum of the
actual sheet maps. This equality does not divide by a degree and
remains valid when five divides $d$. Consequently the entire
trace of $\lambda_X(-O)$ equals $j(\mathscr H)$. In particular it
lies in the original-section trace $J$.

## Exact rank-two truncated trace

Suppose instead that the saturated canonical-line trace $S_Y$ has
rank two and degree zero. Each actual $\lambda_i$ is a saturated
line of degree $-2d$ in $q^*S_Y$. Distinct planes have distinct
canonical lines: the fixed positive plane is recovered as the
unique degree-nine HN line in
$\lambda_i^\perp/\lambda_i$, whose total degree is $16d$.
Thus the same $N$ labels are distinct here, and their pair collision
divisors have degree $4d$.

If the $m\ge7N/8$ survivors had only one direction, the lower
collision bound $m(m-1)/2$ would exceed the upper bound
$N(N-1)/4$ by at least
\[
\frac{17N^2}{128}-\frac{3N}{16}
=\frac{N(17N-24)}{128}>0.
\]
There are at least two surviving directions in every fiber. They
generate $q^*S_Y$, hence the actual truncated trace equals $S_Y$.
This proves $S_Y\subset J$ without promoting strong semistability.

## Actual radical loss has at most one reduced support point

Return to the rank-three positive trace and its radical $A$.
Every original source plane contains $g^*A$. For any point of Y,
its $8n$ source sheets cannot all map to $O$, since $h^{-1}(O)$
has degree $n$. Select a non-infinity sheet. If it maps outside
$R$, the equality $I=U$ gives $A\subset J$ locally. If it maps
to a cubic branch, the length-one inclusion gives
$P_X(-r)\subset I\cap P_X$; since $g$ is etale, a single base
uniformizer times $A$ is therefore in $J$ locally. Splitting the
trace algebra over the strict henselization justifies using one
sheet's inclusion; no trace-degree scalar is introduced.

Thus $A/(A\cap J)$ is killed by the maximal ideal at each support
point. A loss point moreover requires the ENTIRE original
$g$-fiber to lie in $h^{-1}(R+O)$, because any ordinary finite sheet
would contain $A$ already. This divisor has degree $11n$, whereas
two distinct $g$-fibers have degree $16n$. Hence
\[
A\cap J=A\quad\hbox{or}\quad A(-Q)
\]
for one reduced point $Q$.

## Double zeros force equality of the two original traces

The [first saturated trace theorem](first_saturated_cartier_trace.md)
gives $3\le\deg H\le4$. Put $C=J\cap E$. Since $J+E=H$,
\[
\deg C=\deg J+2-\deg H,\qquad j(\mathscr H)\subset C.
\]
The adjunction zero divisor $Z$ of $A$ has degree two. Suppose
$Z=2W$ and $J\ne H$. Both have rank four, so
$\deg J\le\deg H-1$ and $0\le\deg C\le1$. Thus
$C/j(\mathscr H)$ has length at most one.

At $W$ the exact quadratic lattice is
$j(\mathscr H)=A+E(-W)$, whose image in the fiber of $B_Y$ has
dimension one. Adding at most one unit of torsion extension gives
fiber-image rank at most two for $C$. Since $E$ is saturated in
$B_Y$, $C=J\cap E$ is saturated in $J$, and $J/C$ is a line
bundle. Adding one lift shows
\[
\operatorname{rank}(J_W\longrightarrow(B_Y)_W)\le3.
\]

Every source point over $W$ maps into $R_P$. Indeed an ordinary
positive-plane point has horizontal evaluation orders $0,1$,
whereas the saturated line $g^*A$ has order two there. Such a zero
cannot occur away from the simple positive-plane branch divisor.
Every surviving non-infinity representative therefore maps into
one of the twelve finite points of $R_P$, disjoint from the cubic
branch divisor. At each such point $I=U$ has rank-three fiber,
contained in the fiber image of $J$.

The collision argument supplies at least three distinct surviving
quotient-line directions at any point over $W$, hence in particular
a non-infinity representative exists. If the fiber image of $J$
had rank below three, this representative would already give a
contradiction. It must consequently be a rank-three hyperplane,
and every surviving original $U_i$ has this same fiber hyperplane.
Their old radicals all have the same fiber line $b$, its
perpendicular.

At $W$ every actual canonical line $\lambda_i$ has fiber $A$:
all its Veronese lifts map into the one-dimensional image of the
double-zero quadratic lattice. At each surviving non-infinity
representative, the disjointness $\Delta_X\cap R_P=\varnothing$
says that the old radical and canonical line are independent and
span $P_i$. Therefore every surviving $P_i$ has fiber
$\langle b,A\rangle$, and every surviving quotient $L_i=P_i/A$
has the SAME direction in $V$. This contradicts the three distinct
surviving directions already proved. Hence $J=H$ in the double
case, and $\deg J\ge3$.

## Split zeros exclude degree one

The inclusion $j(\mathscr H)\subset C$ gives $\deg C\ge0$, so
$\deg J\ge\deg H-2\ge1$ in any rank-three positive trace branch.
If $\deg J=1$, the degree equation forces
$\deg H=3$ and $C=j(\mathscr H)$. The double case has just been
excluded at that degree. If $Z=P+Q$ is split, the exact quadratic
lattice at each simple zero is $(\tau A,e_2,e_3)$. Thus
$A\cap J=A\cap C=A(-P-Q)$, contradicting the actual one-point
radical loss bound. This completes the rank-three positive trace
lower bound $\deg J\ge2$.

Only the selected branch is closed. A degree-one first trace can
still have rank-four positive-plane trace; no compatible common
finite coefficient or common cover is produced here.
