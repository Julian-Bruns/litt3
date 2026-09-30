"""Universal exact fixed-degree (10,2) resultant identity in characteristic 5."""
from laurent import LP
from algebra import ROOT
import json,time
LP.n=7
V=[LP.mono([int(i==j) for i in range(7)]) for j in range(7)]
a,b,c,d,Q,T,l=V
# f=l(W^5+Q)^2+(W^5+Q)(2aW^3+3bW^2+cW+d)+T
f={10:l,8:2*a,7:3*b,6:c,5:d+2*l*Q,3:2*a*Q,2:3*b*Q,1:c*Q,0:l*Q**2+d*Q+T}
powers=[(LP(0),LP(1)),(LP(1),LP(0))]
for n in range(2,11):
    u,v=powers[-1];powers.append((v-b*u/a,-c*u/a))
u=sum((f[i]*powers[i][0] for i in f),LP(0));v=sum((f[i]*powers[i][1] for i in f),LP(0))
resultant=a**9*(c*u**2-b*u*v+a*v**2)
assert all(all(e>=0 for e in m) for m in resultant.d)
delta=b*b+a*c
J=b**3-a*b*c+2*a*a*d
A=c**5-b**5*Q+a**5*Q*Q
K=a**3*Q*J-d*b**5-2*c*c*delta*delta+a*b*b*c**3
S=2*b*b*c*c+a*c**3+d*J-a*a*d*d
E=-b**5+2*a**5*Q
D2=A*A
D1=A*K+T*(E*E-2*a**5*A)
D0=a**3*(A*S+T*(E*J-a*a*K))+a**10*T*T
assert resultant==D0+l*D1+l*l*D2
assert all(m[-1]<=2 for m in resultant.d)
print('universal fixed-degree resultant identity verified; terms',len(resultant.d))
(ROOT/'data/resultant_universal.json').write_text(json.dumps({'variables':['a','b','c','d','Q','T','ell'],'terms':resultant.data()},indent=2)+'\n')
