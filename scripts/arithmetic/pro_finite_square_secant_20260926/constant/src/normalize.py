"""Normalize directly to H,q,mu without choosing a cube root of q.
Output barred coefficients for Y^3=P/q and Z=Y*V-B0.
"""
from residual import *
from symbolic import SYMBOLIC_FILE,symbolic_chart

def normalized_sources():
 obj=json.loads(SYMBOLIC_FILE.read_text()) if SYMBOLIC_FILE.exists() else symbolic_chart()
 coords=[{(a,b):c for a,b,c in row} for row in obj['coordinates']]
 mons=set().union(*(d.keys() for d in coords))
 out=[{} for _ in range(4)]
 for ah,bw in mons:
  gs=as_G([d.get((ah,bw),0) for d in coords]);gg=barred(gs)[:4]
  for j,g in enumerate(gg,start=2):
   for iy,pol in enumerate(g):
    for ix,c in enumerate(pol):
     if c:
      e=bw-ah+iy+j-1
      assert e%3==0,(j,ah,bw,iy,e)
      key=(ah,e//3,iy,ix)
      out[j-2][key]=add(out[j-2].get(key,0),c)
 out=[{m:c for m,c in d.items() if c} for d in out]
 qbar={(0,2,1,i):c for i,c in enumerate(pquo(psub(Q,ppow(B0,5)),ppow(P,2))) if c}
 C={(0,3,0,i):c for i,c in enumerate(t3) if c}
 return out+[qbar,C]

def write_sources():
 out=normalized_sources()
 obj={'variables':['H','q','Y','x'],'curve_relation':'Y^3=P(x)/q','coefficient_encoding':'K integer codes','mu_coefficient':'independent mu','residual_formula':'Rcal=q^-15*t^-15*Norm_Y Res_(10,2)(mu*(V^5+qbar)^2+(V^5+qbar)*(g2*V^3+g3*V^2+g4*V+g5)+C,3*g2*V^2+2*g3*V+g4)','coefficient_names':['g2','g3','g4','g5','qbar','C'],'coefficients':[[list(m)+[c] for m,c in sorted(d.items())] for d in out]}
 (ROOT/'evidence/normalized_sources.json').write_text(json.dumps(obj,separators=(',',':'))+'\n')
 lines=[]
 for d in out:
  lines.append(str(len(d)))
  lines.extend(' '.join(map(str,(*m,c))) for m,c in sorted(d.items()))
 (ROOT/'evidence/normalized_sources.dat').write_text('\n'.join(lines)+'\n')
 for hv,wv in [(1,2),(25,6),(12345,67890)]:
  H=mul(hv,wv);q=power(wv,3);gs=make_chart(hv,wv)['G'];gg=barred(gs)[:4]
  for i,d in enumerate(out[:4],start=2):
   # Evaluation in the ORIGINAL curve ring (replace Y by y/w).
   r=cp(ZERO)
   for (a,b,j,k),c in d.items():
    e=mul(c,mul(mul(power(H,a),power(q,b)),power(wv,-j)))
    r=cadd(r,cscale(monomial(k,j),e))
   assert r==cscale(gg[i-2],power(wv,i-1))
 print('normalized source term counts',[len(d) for d in out])
 print('H degree',[max(m[0] for m in d) for d in out])
 print('q exponent ranges',[(min(m[1] for m in d),max(m[1] for m in d)) for d in out])
 return obj

if __name__=='__main__':write_sources()
