"""Fraction-free reduction and projection on b*u^2+2*c*u+3*e=0.
Only explicitly requested open factors are removed from projection polynomials.
"""
from exact import *
import rank9 as R
B=DATA['b'];C=pc(DATA['c'],2);E3=pc(DATA['e'],3)
def quadratic_remainder(h):
 n=max(map(len,h))-1
 if n<0:return [],[],0
 hs=[trim([h[j][i] if i<len(h[j]) else 0 for j in range(9)]) for i in range(n+1)]
 a,b=hs[-1],[];den=[1]
 for p in hs[-2::-1]:
  den=pm(den,B)
  a,b=ps(pm(p,den),pm(E3,b)),ps(pm(B,a),pm(C,b))
 # b(q)^n h = a(q)+b(q)*u in the quadratic quotient.
 return a,b,n

def remove_support(p,unit):
 """Strip the entire gcd support with unit, recording exact powers/divisions."""
 out=p;removed=[1]
 while True:
  g=pgcd(out,unit)
  if len(g)==1:break
  removed=pm(removed,g);out=pexact(out,g)
 assert pm(removed,out)==p
 return out,removed

def projection(h,unit=None):
 a,b,n=quadratic_remainder(h)
 content=pgcd(a,b)
 aa=pexact(a,content);bb=pexact(b,content)
 res=pa(ps(pm(B,pp(aa,2)),pm(C,pm(aa,bb))),pm(E3,pp(bb,2)))
 # Include whole content fibres separately; they are not cancelled silently.
 primitive=res;removed=[1]
 if unit is not None:primitive,removed=remove_support(res,unit)
 return {'denominator_b_power':n,'remainder':[a,b],'content':content,
         'primitive_linear_remainder':[aa,bb],'quadratic_resultant':res,
         'allowed_projection':primitive,'removed_projection_factor':removed}

if __name__=='__main__':
 import json,time
 from branch_root import strip,weight,ud
 d=json.loads((ROOT/'work/branch_root/data.json').read_text())
 p0,p1,_=d['components'][0]['nu_coefficients'];g0,g1,_=d['components'][1]['nu_coefficients']
 h=R.minus(R.times(p1,g0),R.times(p0,g1));hp,fac=strip([h]);h=hp[0]
 print('DET stripped',fac,'weight',weight(h),'u',ud(h),flush=True)
 # q,d,b are all already excluded from the remaining square locus.
 units=pm(pm([0,1],DATA['d']),DATA['b'])
 pr=projection(h,units)
 for k in ['content','quadratic_resultant','allowed_projection','removed_projection_factor']:print(k,'degree',len(pr[k])-1,flush=True)
 print('linear degrees',[len(a)-1 for a in pr['primitive_linear_remainder']],flush=True)
 print('content residual degree',len(remove_support(pr['content'],units)[0])-1,flush=True)
 print('h1 gcd resultant',len(pgcd(pr['primitive_linear_remainder'][1],pr['allowed_projection']))-1,flush=True)
 pr.update({'determinant':h,'determinant_unit_powers':fac,'units_used_to_remove':units})
 (ROOT/'work/branch_root/projection.json').write_text(json.dumps(pr,separators=(',',':'))+'\n')
