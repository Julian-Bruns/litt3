"""New local data for transferring the actual divided-trace method.

Use the accepted symbolic source; do not replay its reconstruction.
"""
import sys,json,time
from pathlib import Path
src=Path(sys.argv[1]);out=Path(sys.argv[2]);out.mkdir(parents=True,exist_ok=True)
st=time.time();d=load(str(src/'actual_delta.sobj'));gs=d['source_G'];P=d['P']
X=P.parent();FF=X.base_ring();HW=FF.ring();h,w=HW.gens();K=HW.base_ring();a=K.gen()
beta=-(a^4+2*a^3+a^2+2*a)/(a^3+a^2+1)
def dec(c):
 z=K.zero()
 for i in range(4):
  t=c%25;c//=25;z+=(K(t%5)+(t//5)*beta)*a^i
 return z
Y=gs[0].parent();y=Y.gen();x=X.gen();B=X(list(map(dec,[8,14,19,2,10,19,3,24,18,16])))
def divy(z,n):
 z=z%(y^3-P);v=Y.zero()
 for j in range(3):
  s=(j-n)%3;ee=(n+s-j)//3
  if ee>=0:co,rem=z[j].quo_rem(P^ee);assert not rem
  else:co=z[j]*P^(-ee)
  v+=Y(co)*y^s
 return v
aa=divy(gs[0],2);bb=divy(gs[1]-3*B*gs[0],3)
cc=divy(gs[2]-2*B*gs[1]+3*B^2*gs[0],4)
ee=divy(gs[3]-B*gs[2]+B^2*gs[1]-B^3*gs[0],5)
r=dec(9);rows={}
for name,z in [('a',aa),('b',bb),('c',cc),('e',ee)]:
 vals=[z[j](r) for j in range(3)]
 rows[name]=vals
 print(name,'first three y-jets',vals,flush=True)
print('a0zero',not rows['a'][0],'b0factor',rows['b'][0].factor(),flush=True)
F5=GF(5)
def pv(c):return vector(F5,[K(c).polynomial()[i] for i in range(8)])
change=matrix(F5,[pv(beta^j*a^i) for i in range(4) for j in range(2)]).transpose().inverse()
def enc(c):
 z=change*pv(c)
 return int(sum(ZZ(z[2*i])*25^i+ZZ(z[2*i+1])*5*25^i for i in range(4)))
for name,c in [('a1',rows['a'][1]),('b0',rows['b'][0])]:
 p=HW(c);v=-p.monomial_coefficient(w)/p.monomial_coefficient(h)
 print('root H of',name,enc(v),'factor constant',enc(p.monomial_coefficient(h)),flush=True)
save(dict(d,primitive=[aa,bb,cc,ee],marked_jets=rows),str(out/'primitive_local_data'))
(out/'primitive_local_data.json').write_text(json.dumps({'scope':'new exact root-nine local jets; no exclusion',
 'jets':{k:[str(x) for x in v] for k,v in rows.items()},'seconds':time.time()-st},indent=2)+'\n')
