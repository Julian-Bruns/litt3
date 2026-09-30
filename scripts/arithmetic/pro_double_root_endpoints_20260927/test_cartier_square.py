"""Executed supplementary tests, including nonreduced rings and late traps.
The scheme equivalence is proved in REPORT.md; bounded tests do not replace it.
"""
import random,json,time
from exact import ROOT
from extension import E,Poly,init
from residual import sm
from cartier_square import build,check_identities,equations

def test_context(mod,name):
 init(mod);rng=random.Random(270926);D=len(mod)-1
 root=[Poly(E([rng.randrange(390625) for _ in range(D)])) for _ in range(71)]
 root[0]=Poly(1);A=sm(root,root,141)
 m=build(A);rr=check_identities(m)
 assert m['B']==root and not any(rr) and not any(equations(m))
 # Excluding late equations is genuinely insufficient.
 z=[Poly() for _ in range(141)];z[0]=Poly(1);z[125]=Poly(1)
 mm=build(z);ee=equations(mm)
 assert not any(ee[:67]) and not any(ee[67:69]) and ee[69]==Poly(4)
 z[125]=Poly();z[126]=Poly(1)
 mm=build(z);ee=equations(mm)
 assert any(ee[:67])
 # A nilpotent deformation is retained, not radicalized.
 if D==2 and mod==[0,0,1]:
  eps=E([0,1]);assert eps and not eps*eps
  z=[Poly() for _ in range(141)];z[0]=Poly(1);z[125]=Poly(eps)
  mm=build(z);ee=equations(mm)
  assert ee[-1]==Poly(-eps) and ee[-1] and not ee[-1]*ee[-1]
 return {'ring':name,'exact_square':'accepted with original root','T125_late_trap':'rejected by final quadratic only','T126_late_trap':'rejected','nilpotents_retained':D==2}

if __name__=='__main__':
 t=time.time();records=[test_context([0,1],'K'),test_context([0,0,1],'K[epsilon]/epsilon^2')]
 out={'status':'passed','checks':records,'seconds':round(time.time()-t,3),'scope':'bounded software tests supporting, not replacing, the universal algebraic proof'}
 (ROOT/'logs/cartier_square_tests.json').write_text(json.dumps(out,indent=2)+'\n')
 print('EXPONENT-13 FULL SQUARE SCHEME TESTS PASSED',json.dumps(out),flush=True)
