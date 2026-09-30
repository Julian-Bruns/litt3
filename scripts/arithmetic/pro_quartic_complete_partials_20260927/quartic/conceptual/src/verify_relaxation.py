"""An exact formal-trace counterexample, NOT a four-label endpoint witness."""
import sys,json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'src'))
sys.path.insert(0,str(Path(__file__).parent))
from exact_fields import *
from newton_endpoints import power_sums,quartic_row
Ttheta=Field(F25,[-code(20), F25.zero,F25.zero,F25.zero,F25.one],'Ttheta')
theta=Ttheta.gen
emb=lambda z: Ttheta.from_base(z)
row=lambda ns: Ttheta.row([code(n) for n in ns])
qB=row([7,21,23,3]);qA=row([21,10,15,0])
hB=row([8,1,6,10]);hA=row([6,22,13,0])
v=list(map(code,[13,17,7,0]));w=list(map(code,[8,1,17]))
qU=Ttheta.row([w[j]*qA.c[j].frob(11) for j in range(3)]+[code(7)])
hU=Ttheta.row([w[j]*hA.c[j].frob(11) for j in range(3)]+[code(18)])
qV=Ttheta.row([v[j]*qB.c[j].frob(8) for j in range(4)])
hV=Ttheta.row([v[j]*hB.c[j].frob(8) for j in range(4)])
eps=row([22,19,22,24]);x=code(9);y=code(24)
xb=x.frob(7);yb=y.frob(7)
res=[eps*(qA-emb(xb))-hB+emb(yb),
     eps*(qB-emb(y))-hA+emb(x),
     eps*qU+qV-emb(code(1))*(eps*emb(x.frob(4))-emb(yb.frob(1))),
     hU+eps*hV-emb(xb.frob(4))+eps*emb(y.frob(1))]
assert not any(res)
eta=code(22)
# Original (unnormalized) full field Frobenius identities, including theta action.
for B,A,U,V in [(qB,qA,qU,qV),(hB,hA,hU,hV)]:
    raw=[emb(eta)*z for z in [B,A,U,V]]
    for j,vc in enumerate([13,17,7,0]):
        lhs=Ttheta.row([F25.zero]*j+[raw[3].c[j]])
        rhs=emb(code(vc))*Ttheta.row([F25.zero]*j+[raw[0].c[j]]).frob(8)
        assert lhs==rhs
    for j,uc in zip([0,1,2],[3,14,20]):
        lhs=Ttheta.row([F25.zero]*j+[raw[2].c[j]])
        rhs=emb(code(uc))*Ttheta.row([F25.zero]*j+[raw[1].c[j]]).frob(11)
        assert lhs==rhs
N=lambda a:a*a.frob(7)
dC=N(hB.c[3])-N(qB.c[3]);dE=N(qA.c[1])-N(hA.c[1])
Dq=qB.c[3]*qU.c[1]-qB.c[1]*qU.c[3]
Dh=hB.c[3]*hU.c[1]-hB.c[1]*hU.c[3]
assert all([dC,dE,Dq,Dh,qB.c[3],hB.c[3],qA.c[1],hA.c[1]])
kappa=eps.c[3]/code(19);r=eps/emb(kappa)
a0=r.c[0];a2=r.c[1];a4=r.c[2]/code(7)
assert r.c[3]==code(19) and kappa and (a0 or a4)
assert (eps*eps).c[1] or (eps*eps).c[3]
assert (r*qB).c[3]/code(19)==y
assert ((r*qU).c[3]/code(19)).frob(10)==x
# Newton reconstruction from raw C,U. Constants lie in F25, making scalar powers cheap.
examples={}
for nm,B,A,U,V in [('Q',qB,qA,qU,qV),('H',hB,hA,hU,hV)]:
    C=[eta*t for t in B.c];Uraw=[eta*t for t in U.c]
    first=[(C[1]/code(1)).frob(13), (Uraw[2]/code(8)).frob(8),
           (Uraw[3]/code(6)).frob(12),(C[0]/code(20)).frob(8)]
    p=power_sums(first,119)
    compat=[C[2]-code(7)*p[6].frob(2),C[3]-code(19)*p[7].frob(3),
            Uraw[0]-code(12)*p[8].frob(11),Uraw[1]-code(18)*p[17]]
    grid=[p[116+j]-p[j] for j in range(4)]
    assert any(compat) and any(grid)
    examples[nm]={'normalized_rows':{name:[to_code(vv) for vv in val.c]
                for name,val in [('C',B),('E',A),('U',U),('V',V)]},
            'Newton_p1_to_p4':[to_code(vv) for vv in first],
            'Newton_quartic_ascending':[to_code(vv) for vv in quartic_row(first)],
            'four_Newton_compatibility_residuals':[to_code(vv) for vv in compat],
            'four_grid_residuals':[to_code(vv) for vv in grid]}
out={'status':'PASS','kind':'formal relaxation counterexample; NOT endpoint data',
     'all_four_normalized_trace_residuals_zero':True,'original_Frobenius_identities_checked':True,
     'epsilon_theta_row':[22,19,22,24],'x':9,'y':24,
     'chart':{nm:to_code(vv) for nm,vv in [('a0',a0),('a2',a2),('a4',a4),('kappa',kappa)]},
     'delta_C':to_code(dC),'delta_E':to_code(dE),
     'nonzero_D_Q_scaled':to_code(Dq),'nonzero_D_H_scaled':to_code(Dh),
     'M_checked':True, 'endpoints':examples}
print(json.dumps(out,indent=2))
