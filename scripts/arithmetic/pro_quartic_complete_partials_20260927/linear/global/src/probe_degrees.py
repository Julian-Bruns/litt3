import sys,time,json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'src'));sys.path.insert(0,str(ROOT/'conceptual/src'))
import field as F,poly as U,evaluate as E,polynomial_model as PM,cube_free as CF

def theta_model(H,q,mu):
 dat=PM.DATA;dd=F.add(47171,F.mul(357608,q))
 ng=[CF.evaluate(CF.fromdata(dat['barred_numerators']['g'+str(i)]),H,q) for i in range(2,6)]
 Qstar=[[],U.scale(dat['Qbar_x_polynomial'],F.powk(q,2)),[]]
 ll=[U.scale([F.neg(9),1],F.mul(dd,F.mul(q,mu))),[],[]]
 C=[U.scale(U.powp(E.t,3),F.mul(dd,F.powk(q,4))),[],[]]
 U.set_curve(U.scale(E.P,F.inv(q)))
 try:
  rr=E.resultant(U.cscale(ng[0],3),U.cscale(ng[1],2),ng[2],ng[3],Qstar,C,ll)
  return [U.scale(U.exactdiv(p,U.mul(U.powp(E.t,5),[F.neg(9),1])),F.powk(q,-5)) for p in rr]
 finally:U.set_curve(E.P)

def getcol(th):return [U.coeff(th[y],x) for y in range(3) for x in range(47)]
def divided(xs,vs):
 v=[row[:] for row in vs];degs=[-1]*len(v[0])
 for i in range(len(v)):
  for j,c in enumerate(v[0]):
   if c:degs[j]=i
  v=[[F.div(F.sub(v[k+1][j],v[k][j]),F.sub(xs[k+i+1],xs[k])) for j in range(len(v[0]))] for k in range(len(v)-1)]
 return degs
start=time.time()
for variable,n,fixed in [('H',25,1),('q',67,1)]:
 xs=list(range(1,n+1));vals=[]
 for i,z in enumerate(xs):
  H,q=(z,fixed) if variable=='H' else (fixed,z)
  th0=theta_model(H,q,0);thp=theta_model(H,q,1);thm=theta_model(H,q,4)
  vals.append(getcol(th0)+getcol(U.cscale(U.csub(thp,thm),3))+getcol(U.cscale(U.csub(U.cadd(thp,thm),U.cscale(th0,2)),3)))
 degs=divided(xs,vals)
 print(variable, [max(degs[i*141:(i+1)*141]) for i in range(3)],'seconds',time.time()-start,flush=True)
