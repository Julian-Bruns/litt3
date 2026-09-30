"""Executed tests of all 70 square equations, including the late 16."""
from extension import init,E,Poly
from residual import square_equations,bp_mul
import random
init([0,1]);rng=random.Random(271926)
# J(x,mu)=j0(x)+mu*j1(x), with j0 monic degree 70, j1 degree <=64.
j0=Poly([rng.randrange(390625) for _ in range(70)]+[1]);j1=Poly([rng.randrange(390625) for _ in range(65)])
R=bp_mul([j0,j1],[j0,j1]);Eqs=square_equations(R,True)
assert len(Eqs)==70 and not any(Eqs)
# Ahat=1+T^126.  Its first 54 equations vanish; a late equation does not.
co=[0]*141;co[140]=1;co[14]=1
bad=square_equations([Poly(co)],True)
assert not any(bad[:54]) and any(bad[54:])
assert bad[54+1]!=0  # index 126, not the first late index 125
print('All 70 equations accept an exact polynomial square; the late-tail trap is rejected only by the last 16.')
