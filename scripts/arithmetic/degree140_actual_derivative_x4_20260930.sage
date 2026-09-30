"""One new infinity column: x^4 has a cancelled nominal degree-eight term.

Reuses the completed five columns. This is new local arithmetic, not a
replay of the accepted family certificates.
"""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
source=Path(__file__).with_name('degree140_polynomial_multiplier_localized_20260930.sage').read_text()
source=source[:source.index('out={(n,j):')]
exec(preparse(source))
values={n:A.zero() for n in range(3,9)};parts=[]
for name,Z in [('O4',large),('O7',small)]:
 phi=div(frobenius(Z)+qpoly,frobenius(y))
 ss=div(gs[0]*Z^3+gs[1]*Z^2+gs[2]*Z+gs[3],frobenius(y))
 lam=-(div(ss,phi)+div(tt^3,phi^2));base=df*lam.derivative()^2
 bv=int(base.valuation());lv=int(lam.valuation());maximum=11-(bv-4*lv)
 assert base.precision_absolute()>bv+maximum
 assert lam.precision_absolute()>lv+maximum
 c0=lam[lv];cp=[C.one()]
 for i in range(maximum+12):cp.append(cp[-1]*c0)
 ee=[C.one()]
 for j in range(1,maximum+1):
  ee.append(-sum((lam[lv+i]*ee[j-i]*cp[i-1] for i in range(1,j+1)),C.zero()))
 def conv(a,b,n):return [sum((a[i]*b[j-i] for i in range(j+1)),C.zero()) for j in range(n+1)]
 p2=conv(ee,ee,maximum);p3=conv(p2,ee,maximum);p4=conv(p2,p2,maximum)
 def fifth(c):return C({tuple(5*int(e0) for e0 in e):v^5 for e,v in c.dict().items()})
 p5=[fifth(ee[j//5]) if j%5==0 else C.zero() for j in range(maximum+1)]
 powers={4:p4,5:p5}
 for a,p in [(6,ee),(7,p2),(8,p3),(9,p4)]:
  powers[a]=conv(p5,p,max(-1,11-(bv-a*lv)))
 local={}
 for n in range(3,9):
  a=n+1;k=11-(bv-a*lv)
  value=A.zero() if k<0 else -project(sum((base[bv+i]*powers[a][k-i]*cp[i] for i in range(k+1)),C.zero()))/project(cp[a+k])
  values[n]+=value;local[n]=value
  print(name,n,'seconds',time.time()-start,flush=True)
 parts.append((name,local))
 save({'ring':R,'values':values,'parts':parts},str(root/'actual_derivative_x4_partial'))
assert values[8]==0
old=load(str(root/'actual_derivative_topblock.sobj'))
M=old['matrix'].augment(matrix(A,5,1,[values[n] for n in range(3,8)]))
save({'ring':R,'matrix':M,'x4':values,'parts':parts},str(root/'actual_derivative_topblock6'))
report={'scope':'infinity coefficients of x^4 actual derivative trace',
 'nominal_degree_eight_coefficient_zero':True,
 'degrees':{str(n):list(map(int,v.numerator().degrees())) if v else None for n,v in values.items()},
 'seconds':time.time()-start}
(root/'actual_derivative_x4.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
