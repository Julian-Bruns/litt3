"""Direct numerical checks of the unreduced congruences (1)–(5).
These validate reconstruction; they are not a geometric square search.
"""
from residual import *
from math import comb

def check(h,w):
 d=make_chart(h,w);gs=d['G']
 Ns={0:constant(1),1:cp(ZERO),2:gs[2],3:gs[3],4:gs[4],5:cadd(gs[5],frompoly(Q))}
 for j in range(1,6):
  val=cp(ZERO)
  for i in range(j+1):
   term=cmulpoly(Ns[i],ppow(pscale(B0,4),j-i));val=cadd(val,cscale(term,comb(5-i,j-i)%5))
  assert crem_y(val,j)==ZERO
 for j in range(5):
  Wcoeff=cp(ZERO)
  for i in range(6):
   if j<=5-i:
    v=cmulpoly(Ns[i],ppow(pscale(L0,4),5-i-j));Wcoeff=cadd(Wcoeff,cscale(v,comb(5-i,j)%5))
  val=cmulpoly(Wcoeff,psub(Q,ppow(L0,5)))
  if j==0:val=cadd(val,cmulpoly(y10,t3))
  assert crem_poly(val,ppow(t,5-j))==ZERO
 for j in range(11):
  val=cadd(Ns.get(j,ZERO),cmulpoly(Ns.get(j-5,ZERO),Q))
  if j==10:val=cadd(val,cmulpoly(y10,t3))
  assert pole(val)<=10+12*j-max(0,j-5)
 assert pole(cdiv_y(gs[2],2))==12
 assert pole(gs[3])<=46 and pole(gs[4])<=57
 assert coeff(gs[3],12,1)==EPS
 assert coeff(gs[3],15)==mul(CD,w)
 assert Fseries(gs,h,w)[:6]==[0]*6
 return {'h':h,'w':w,'conditions_1_to_5':'PASS','F0_to_F5':'PASS','F6':d['F6']}

def run():
 out=[check(h,w) for h,w in [(1,1),(1,2),(2,3),(25,6),(12345,67890)]]
 (ROOT/'evidence/original_equations_checks.json').write_text(json.dumps(out,indent=2)+'\n')
 print(json.dumps(out,sort_keys=True))

if __name__=='__main__':run()
