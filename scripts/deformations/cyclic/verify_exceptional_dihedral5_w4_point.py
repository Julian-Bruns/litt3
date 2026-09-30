#!/usr/bin/env python3
"""Verify one actual W4 tuple after an exact zero of the complete obstruction.

Uses the independent actual-comparison checks of the probe, then solves the
whole terminal primary equation and constructs both regular Hodge repairs.
Environment and precision options are those of exceptional_dihedral5_w4.py.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
from scripts.deformations.cyclic.exceptional_dihedral5_w4 import *

assert not np.any(c4), 'The complete actual fourth obstruction must vanish.'
rhs=reduce_h1(rho4)[0]
solution,pivots=linear_solve(M_z,rhs)
terminal_coefficients=np.array([cp(cc,5**(DIM-1))%5 for cc in solution])
terminal=sum((Ser(cc)*Z**ee for cc,ee in zip(terminal_coefficients,repair_exponents)),Ser(0))
assert not np.any((np.array([sum((cm(M_z[i,j],cp(terminal_coefficients[j],5)) for j in range(15)),ca(0)) for i in range(15)])-rhs)%5)

def make_terminal_curve(chi):
    vv=5*xi-25*chi-125*terminal
    def V(f):return vv*der(f)
    def phi(f):return f+V(f)+Ser(ci(2))*V(V(f))+Ser(ci(6))*V(V(V(f)))
    A=1+der(vv)+Ser(ci(2))*der(V(vv))+Ser(ci(6))*der(V(V(vv)))
    am=A-1
    q=j*(1+Ser(ci(2))*am-Ser(ci(8))*am**2+Ser(ci(16))*am**3)
    return phi,A,q

higher_G.__globals__['make_curve']=make_terminal_curve
G4,phi4,A4,q4,Taylor4=higher_G(chi,3)
rho4_repaired,jet4=rho_from(G4,phi4,I2U,I2O,25)
remaining,affine_part,formal_part=reduce_h1(rho4_repaired)
assert not np.any(remaining), ('whole terminal primary repair failed',remaining)
repair_U=-affine_lift(affine_part)
repair_O=(formal_part/j**2).mod(5)
assert repair_O.iszero() or repair_O.l>=0
H3U=[I2U[i][1]+25*repair_U*I2U[i][0] for i in range(2)]
H3O=[I2O[i][1]+25*repair_O*I2O[i][0] for i in range(2)]

def ds125(h,upper,potential,e_local):
    h=[f.mod(125) for f in h]
    def negative_covariant(v):
        return [(-v[0].deriv()+upper*v[1])/e_local,
                (-v[1].deriv()+25*potential*upper*v[0])/e_local]
    c1=negative_covariant(h)
    wr=(c1[0]*h[1]-c1[1]*h[0]).mod(125)
    eps=(Ser(mu)*wr-1).mod(125)
    assert eps.mod(5).cut(40).iszero()
    scale=1-Ser(ci(2))*eps+Ser(cm(ca(3),ci(8)))*eps**2
    h=[(scale*f).mod(125) for f in h]
    c1=negative_covariant(h)
    result=mfun([[c1[0],h[0]],[c1[1],h[1]]],lambda f:f.mod(125))
    ck=(result[0][0]*result[1][1]-result[0][1]*result[1][0]-1/Ser(mu)).mod(125).cut(40)
    assert ck.prec>=40 and ck.iszero(),('normalized determinant',ck)
    return result

I3Uraw=ds125(H3U,zeta.mod(125),P_FU,g)
I3O=ds125(H3O,zetaO,PO.frob(),g/j**2)
def lift_affine125(f):
    answer=Ser(0)
    for power in [1,5,25]:
        digit=(f-answer).mod(5*power).divint(power)
        answer=answer+power*affine_lift(digit,anti=True)
    return answer
I3U=mfun(I3Uraw,lift_affine125)
for row in I3O:
    for f in row:assert f.iszero() or f.l>=0,('formal pole',f)
full_jet=mm(mm(mi(I3O),G4),mfun(I3U,phi4))
expected_jet=[[q4.inv(),Ser(0)],[-der(q4)/A4,q4]]
for i in range(2):
    for jj in range(2):
        ck=(full_jet[i][jj]-expected_jet[i][jj]).mod(125).cut(30)
        assert ck.prec>=30 and ck.iszero(),('whole W3 filtered/graded transition',i,jj,ck)
result=dict(status='PASS actual compatible W4 curve and full W3 filtered/graded tuple',
            precision=MAX,parameters=parameters,frobenius_variant=args.frobenius_variant,
            terminal_exponents=repair_exponents,terminal_coefficients=terminal_coefficients.tolist(),
            primary_rank=len(pivots),remaining_normal_vector=remaining.tolist(),
            regular_U=encser(repair_U),regular_O=encser(repair_O),
            I3U=[[encser(f) for f in row] for row in I3U],
            I3O=[[encser(f) for f in row] for row in I3O])
(RUN_DIR/'genus6_w4_tuple.json').write_text(json.dumps(result,indent=2)+'\n')
log(result['status'])
