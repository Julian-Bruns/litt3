"""Discover unweighted endpoint denominators; samples are not a proof.

Use 160 samples for reconstruction, then disjoint held-out samples.
The result records coefficient polynomials and every validation outcome.
"""
import json,sys,time
from pathlib import Path
src=Path(sys.argv[1]);out=Path(sys.argv[2]);data=json.loads(src.read_text());start=time.time()
Z=PolynomialRing(GF(5),'z');z=Z.gen();u=z^4+2*z^3+z^2+2*z;v=z^3+z^2+1
K=GF(5^8,'a',modulus=u^2+u*v-3*v^2);a=K.gen();beta=-u(a)/v(a)
cache={}
def decode(n):
 n=int(n)
 if n not in cache:
  t=n;s=K.zero()
  for j in range(4):
   c=t%25;t//=25;s+=(K(c%5)+(c//5)*beta)*a^j
  cache[n]=s
 return cache[n]
cbasis=[a^j*beta^k for j in range(4) for k in range(2)]
def vector_of(c):
 vv=c.polynomial().list();return vector(GF(5),vv+[0]*(8-len(vv)))
imat=matrix(GF(5),[vector_of(c) for c in cbasis]).transpose().inverse()
def encode(c):
 vv=imat*vector_of(c);return int(sum((ZZ(vv[2*j])+5*ZZ(vv[2*j+1]))*25^j for j in range(4)))
R=PolynomialRing(K,'h');h=R.gen();rows=data['rows'];train=rows[:160];test=rows[160:]
xx=[decode(r['h']) for r in train];M=prod(h-x for x in xx)
ans=[]
for i in range(27):
 ip=R.lagrange_polynomial([(xx[j],decode(r['values'][i])) for j,r in enumerate(train)])
 try:
  nn,dd=ip.rational_reconstruction(M)
  unit=dd.leading_coefficient();nn/=unit;dd/=unit
  held=all(dd(decode(r['h'])) and nn(decode(r['h']))==dd(decode(r['h']))*decode(r['values'][i]) for r in test)
  entry={'index':i,'numerator':[encode(c) for c in nn.list()],
         'denominator':[encode(c) for c in dd.list()],
         'degrees':[int(nn.degree()),int(dd.degree())],'held_out_pass':bool(held),
         'denominator_factors':[{'degree':int(f.degree()),'exponent':int(e),'coefficients':[encode(c) for c in f.list()]} for f,e in dd.factor()]}
  ans.append(entry)
  print('row',i,'degrees',entry['degrees'],'den factors',[(x['degree'],x['exponent']) for x in entry['denominator_factors']], 'held',held,flush=True)
 except ValueError as e:
  ans.append({'index':i,'status':'reconstruction_failed','error':str(e)})
out.write_text(json.dumps({'scope':'rational discovery at one fixed w, not a global identity',
 'w':data['w'],'train':len(train),'held_out':len(test),'rows':ans,'seconds':time.time()-start},indent=2)+'\n')
