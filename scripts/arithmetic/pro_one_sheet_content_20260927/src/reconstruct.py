"""Reconstruct the affine-six source from all 149 original linear equations."""
from algebra import *
import json,time
Prow=[11,22,18,5,19,20,15,16,9,22,1];Arow=[1,21,14,22,13]
Qrow=[0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24]
Brow=[8,14,19,2,10,19,3,24,18,16];Lrow=[18,20,20,15]
alpha=25;EPS=24+4*25+23*15625;ETA=11+18*625+20*15625;CD=3+10*25+625+14*15625

def uni(row):return {(i,0):u for i,u in enumerate(row) if u}
P,A,Q,B0,L0=map(uni,[Prow,Arow,Qrow,Brow,Lrow]);Ppowers=[pone(2)]
for i in range(1,30):Ppowers.append(pmul(Ppowers[-1],P))
def red(a):
 out={}
 for (i,j),c in a.items():out=padd(out,{(i,j):c} if j<3 else pscale(pshift(Ppowers[j//3],(i,j%3)),c))
 return out
def cmul(a,b):return red(pmul(a,b))
def cpow(a,k):return red(ppow(a,k,2))
def udiv(a,b,strict=True):return pdivide_univ(a,{i:c for (i,j),c in b.items()},0,strict)
def cmod(a,b):return udiv(a,b,False)[1]
def yrem(a,k):
 out={}
 for j in range(3):out=padd(out,cmod({(i,jj):c for (i,jj),c in a.items() if jj==j},Ppowers[max(0,(k-j+2)//3)]))
 return out
t=udiv(pscale(A,inv(13)),{(1,0):1,(0,0):neg(alpha)})[0];M=udiv(psub(Q,ppow(L0,5)),ppow(t,3))[0];N=red({(0,10):1})
def get_bases(d):return [(i,j) for j in range(3) for i in range(max(0,(d-10*j)//3+1))]
bases=[get_bases(d) for d in [12,46,57,70]];columns=[(g,m) for g,bs in enumerate(bases) for m in bs];assert len(columns)==155
B02=ppow(B0,2);B03=pmul(B02,B0);L02=ppow(L0,2);L03=pmul(L02,L0);t2=ppow(t,2);t3=pmul(t2,t)
def conditions(gs,constant=False):
 G2,G3,G4,G5=gs
 a=psub(G3,pscale(cmul(B0,G2),3))
 b=padd(psub(G4,pscale(cmul(B0,G3),2)),pscale(cmul(B02,G2),3))
 d=psub(padd(psub(G5,cmul(B0,G4)),cmul(B02,G3)),cmul(B03,G2))
 c=padd(psub(G4,pscale(cmul(L0,G3),2)),pscale(cmul(L02,G2),3))
 dd=psub(padd(psub(G5,cmul(L0,G4)),cmul(L02,G3)),cmul(L03,G2))
 endpoint=cmul(M,dd);lead=cmul(Q,G5)
 if constant:endpoint=padd(endpoint,N);lead=padd(lead,cmul(t3,N))
 parts=[yrem(a,3),yrem(b,4),yrem(d,5),cmod(c,t),cmod(endpoint,t2)]
 out={(g,*m):u for g,z in enumerate(parts) for m,u in z.items()}
 for k,mon in enumerate([(42,0),(39,1)]):
  c=lead.get(mon,0)
  if c:out[(5+k,0,0)]=c
 return out

def main():
 started=time.time();conds=[]
 for g,m in columns:
  gs=[{}, {}, {}, {}];gs[g]=red(pshift({m:1},(0,2))) if g==0 else {m:1};conds.append(conditions(gs))
 rhs=conditions([{}, {}, {}, {}],True);keys=sorted(set(rhs).union(*(set(c) for c in conds)))
 rows=[[c.get(m,0) for c in conds]+[neg(rhs.get(m,0))] for m in keys]
 print('linear_system rows cols',len(rows),len(rows[0])-1,flush=True)
 rr,piv=rref(rows);assert all(not any(r[:155]) and not r[155] for r in rr[len(piv):]);free=[j for j in range(155) if j not in piv]
 print('rank',len(piv),'free',[(j,columns[j]) for j in free],flush=True);assert len(piv)==149 and len(free)==6
 sols=[[0]*7 for _ in range(155)]
 for k,j in enumerate(free):sols[j][k+1]=1
 for i,j in enumerate(piv):
  sols[j][0]=rr[i][-1]
  for k,l in enumerate(free):sols[j][k+1]=neg(rr[i][l])
 targets=[columns.index((0,(4,0))),columns.index((2,(19,0))),columns.index((2,(12,2))),columns.index((3,(16,2)))];chosen=targets.copy()
 for j in free:
  _,pv=rref([sols[c][1:]+[0] for c in chosen+[j]])
  if len(pv)>len(chosen):chosen.append(j)
  if len(chosen)==6:break
 assert len(chosen)==6
 ir,ip=rref([sols[j][1:]+[int(i==k) for k in range(6)] for i,j in enumerate(chosen)]);assert ip==list(range(6));invmat=[r[6:] for r in ir]
 old=[]
 for i in range(6):
  c=0
  for k,j in enumerate(chosen):c=sub(c,mul(invmat[i][k],sols[j][0]))
  old.append([c]+invmat[i])
 final=[]
 for row in sols:
  ans=[row[0]]+[0]*6
  for i in range(6):
   if row[i+1]:ans=[add(a,mul(row[i+1],b)) for a,b in zip(ans,old[i])]
  final.append(ans)
 for k,j in enumerate(chosen):assert final[j]==[0]+[int(i==k) for i in range(6)]
 for row in rows:
  for k in range(7):
   ans=0
   for c,s in zip(row[:155],final):ans=add(ans,mul(c,s[k]))
   assert ans==(row[-1] if k==0 else 0)
 assert final[columns.index((1,(12,1)))]==[EPS]+[0]*6
 assert final[columns.index((1,(15,0)))]==[0,0,CD,0,0,0,0]
 output={'field':{'p':5,'iota_polynomial':[2,4,1],'alpha_F25_polynomial':[5,2,6,7,1]},'P':Prow,'A':Arow,'Q':Qrow,'B0':Brow,'L0':Lrow,'t':dumps(t),'M':dumps(M),'epsilon':EPS,'eta':ETA,'Cd':CD,'coordinates':['h','w','e','f','u','v'],'coordinate_indices':chosen,'coordinate_monomials':[[columns[j][0],*columns[j][1]] for j in chosen],'columns':[[g,*m] for g,m in columns],'affine_source':final,'rank':149,'constraint_count':len(rows)}
 (ROOT/'data'/'affine_source.json').write_text(json.dumps(output,separators=(',',':'))+'\n')
 import hashlib
 digest=hashlib.sha256(json.dumps(rows,separators=(',',':')).encode()).hexdigest()
 evidence={'matrix_sha256':digest,'all_affine_equations_verified':len(rows)*7,'rank':149,'variables':155,'coordinates':output['coordinate_monomials']}
 (ROOT/'evidence'/'affine_checks.json').write_text(json.dumps(evidence,indent=2)+'\n');print(json.dumps(evidence),flush=True)
if __name__=='__main__':main()
