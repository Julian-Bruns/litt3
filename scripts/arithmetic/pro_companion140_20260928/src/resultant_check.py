"""Independent fixed-degree Sylvester determinant tests of the universal formula."""
from residual import *
import random

def det(matrix):
    m=[list(r) for r in matrix];z=1
    for i in range(len(m)):
        j=next((j for j in range(i,len(m)) if m[j][i]),None)
        if j is None:return 0
        if j!=i:m[j],m[i]=m[i],m[j];z=neg(z)
        piv=m[i][i];z=mul(z,piv);invp=inv(piv)
        for j in range(i+1,len(m)):
            r=mul(m[j][i],invp)
            if r:
                for k in range(i+1,len(m)):m[j][k]=sub(m[j][k],mul(r,m[i][k]))
    return z

def sylvester(f,g,m,n):
    f=list(f)+[0]*(m+1-len(f));g=list(g)+[0]*(n+1-len(g))
    assert len(f)==m+1 and len(g)==n+1
    rows=[]
    for i in range(n):rows.append([0]*i+list(reversed(f))+[0]*(n-i-1))
    for i in range(m):rows.append([0]*i+list(reversed(g))+[0]*(m-i-1))
    return det(rows)

def run():
    random.seed(14053);cases=[]
    for i in range(100):
        A,B,C,D,Q,E,V,lam=[random.randrange(N) for _ in range(8)]
        if i%3==0:A=0
        if i%5==0:B=0
        if i%7==0:lam=0
        if i%11==0:V=0
        if i%17==0:C=0
        gs=[mul(2,A),mul(3,B),C,D]
        zp=[Q,0,0,0,0,1]
        f=pa(pa(scale(ppow(zp,2),mul(lam,V)),pm(zp,[D,C,gs[1],gs[0]])),[E])
        actual=sylvester(f,[C,B,A],10,2)
        rr=critical_resultant([F.code(c) for c in gs],F.code(E),F.code(Q),F.code(V))
        calc=(rr[0]+F.code(lam)*rr[1]+F.code(power(lam,2))*rr[2]).v
        assert calc==actual
        cases.append({'A_zero':A==0,'B_zero':B==0,'lambda_zero':lam==0,'v_zero':V==0})
    print(json.dumps({'tests':len(cases),'fixed_degrees':[10,2],'degree_drop_cases':sum(c['A_zero'] or c['lambda_zero'] or c['v_zero'] for c in cases),
                      'comparison':'universal formula versus independent Sylvester determinant','status':'PASS'}))
if __name__=='__main__':run()
