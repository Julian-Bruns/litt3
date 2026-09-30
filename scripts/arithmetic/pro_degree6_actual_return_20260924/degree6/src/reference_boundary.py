"""Independent small-sample re-evaluation of the genus-zero certificate.
Uses the simple L-first field engine and polynomial-list operations, not C++.
"""
from reference_field import ReferenceField

def genus0_values(data,indices):
 j,k,l,u,t,v=indices;F=ReferenceField(data['KM'],data['LM'])
 A,M,S=F.add,F.mul,F.scale
 def sub(a,b):return F.sub(a,b)
 def outer(name,i,e,m=1):return F.outer(data[name][i],data['ZP'][(m*e)%29])
 def diff(name,i,e,j,f,m=1):return sub(outer(name,i,e,m),outer(name,j,f,m))
 a=sub(F.embed(data['ROOTS'][0]),F.embed(data['ROOTS'][j]))
 b=sub(F.embed(data['ROOTS'][k]),F.embed(data['ROOTS'][l]))
 f=diff('HS',0,0,j,u);c=diff('FS',0,0,j,u,4);d=diff('GS',0,0,j,u,5);e=diff('JS',0,0,j,u,8)
 vm=(v+t)%29
 h=diff('HS',k,v,l,vm);ii=diff('FS',k,v,l,vm,4);jj=diff('GS',k,v,l,vm,5);kk=diff('JS',k,v,l,vm,8)
 D=sub(M(h,ii),M(b,jj));T=[sub(M(h,d),M(b,c)),sub(M(b,a),M(h,f))]
 U=[sub(M(jj,d),M(ii,c)),sub(M(ii,a),M(jj,f))]
 def pa(x,y):return [A(x[i] if i<len(x) else F.zero(),y[i] if i<len(y) else F.zero()) for i in range(max(len(x),len(y)))]
 def pm(x,y):
  z=[F.zero() for _ in range(len(x)+len(y)-1)]
  for i,vv in enumerate(x):
   for j,ww in enumerate(y):z[i+j]=A(z[i+j],M(vv,ww))
  return z
 def sc(x,z,shift=0):return [F.zero()]*shift+[M(vv,z) for vv in x]
 P=pa(pa(pa(pa(sc(U,S(M(e,D),2)),sc(pm(T,U),S(h,3))),sc(U,S(M(c,D),3),1)),sc(U,S(M(a,D),3),2)),sc(T,S(M(a,D),4),1))
 Q=pa(pa(pa(pa(sc(pm(T,T),S(kk,2),1),sc(T,S(M(f,D),3),1)),sc(pm(T,U),S(ii,3),1)),sc(pm(U,U),S(b,3),1)),sc(pm(T,U),S(b,4)))
 P+= [F.zero()]*(4-len(P));Q+=[F.zero()]*(4-len(Q))
 B=[[F.zero() for _ in range(3)] for _ in range(3)]
 for i in range(1,4):
  for j in range(i):
   z=sub(M(P[i],Q[j]),M(P[j],Q[i]))
   for r in range(i-j):B[i-1-r][j+r]=A(B[i-1-r][j+r],z)
 return D,U[0],F.det3(B)
