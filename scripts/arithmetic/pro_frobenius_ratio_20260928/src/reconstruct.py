"""Reconstruct the six-dimensional affine source by exact linear algebra.
The compressed equations used here are proved in REPORT.md and all full
congruences (1)--(4) are independently rechecked by verify_source().
"""
from pathlib import Path
import json, math, time
import numpy as np
from ff import *
ROOT=Path(__file__).resolve().parents[1]
P=Poly([11,22,18,5,19,20,15,16,9,22,1]); A=Poly([1,21,14,22,13])
Q=Poly([0,11,6,21,22,0,15,21,9,4,0,1,1,24,14,0,3,9,8,24])
B0=Poly([8,14,19,2,10,19,3,24,18,16]); L0=Poly([18,20,20,15])
alpha=25;r=9;v=X-r;t=A//((X-alpha)*13)
epsilon=sumf([24,mul(4,alpha),mul(23,power(alpha,3))])
eta=sumf([11,mul(18,power(alpha,2)),mul(20,power(alpha,3))])
Cd=sumf([3,mul(10,alpha),power(alpha,2),mul(14,power(alpha,3))])
Ca=sumf([18,mul(14,alpha),mul(10,power(alpha,2)),mul(19,power(alpha,3))])
ZERO=(Poly(),Poly(),Poly());ONE=(Poly(1),Poly(),Poly());Y=(Poly(),Poly(1),Poly())
def ca(a,b):return tuple(a[i]+b[i] for i in range(3))
def cn(a):return tuple(-x for x in a)
def cs(a,b):return ca(a,cn(b))
def cm(a,b):
    if isinstance(b,(int,Poly)):return tuple(x*b for x in a)
    o=[Poly() for _ in range(5)]
    for i in range(3):
        for j in range(3):o[i+j]=o[i+j]+a[i]*b[j]
    o[0]=o[0]+o[3]*P;o[1]=o[1]+o[4]*P
    return tuple(o[:3])
def cp(a,n):
    o=ONE
    while n:
        if n&1:o=cm(o,a)
        n//=2
        if n:a=cm(a,a)
    return o
def cc(p):return (Poly(p),Poly(),Poly())
def monomial(i,j):
    o=[Poly(),Poly(),Poly()];o[j]=X**i;return tuple(o)
def basis(d):return [(i,j) for j in range(3) for i in range((d-10*j)//3+1)]
def pole(a):return max([3*i+10*j for j in range(3) for i in range(len(a[j])) if a[j][i]]+[-1])
def cyrem(a,j):return tuple(a[k]%(P**max(0,(j-k+2)//3)) for k in range(3))
def cmod(a,p):return tuple(x%p for x in a)
def flatten(a,degs):return [a[j][i] for j in range(3) for i in range(degs[j])]
def fcoeff(G):
    G2,G3,G4,G5=G
    F3=ca(cm(G2,-3%5*B0),G3)
    F4=ca(ca(cm(G2,3*(B0**2)),cm(G3,(-2%5)*B0)),G4)
    F5=ca(ca(ca(cm(G2,-B0**3),cm(G3,B0**2)),cm(G4,-B0)),G5)
    # Source D2 is not recovered here. Its one evaluation condition is added separately.
    out=[]
    for j,F in [(3,F3),(4,F4),(5,F5)]:
        rem=cyrem(F,j);out+=flatten(rem,[10*max(0,(j-k+2)//3) for k in range(3)])
    delta=(Q-L0**5)//(t**3)
    E0=ca(ca(ca(cm(G2,-L0**3),cm(G3,L0**2)),cm(G4,-L0)),G5)
    E1=ca(ca(cm(G2,3*(L0**2)),cm(G3,(-2%5)*L0)),G4)
    out+=flatten(cmod(cm(E0,delta),t**2),[6]*3)
    out+=flatten(cmod(cm(E1,delta),t),[3]*3)
    out += [(Q*G5[0])[42],(Q*G5[1])[39]]
    return out

def verify_source(G,D2,affine=True):
    assert not any(D2[j][i] for j in range(3) for i in range(len(D2[j])) if 3*i+10*j>14)
    assert D2[0].eval(r)==0
    assert G[0]==cm(D2,cp(Y,2))
    N=[cc(v if affine else 0),ZERO,G[0],G[1],G[2],ca(G[3],cc(v*Q if affine else 0))]
    for j in range(1,6):
        acc=ZERO
        for i in range(j+1):acc=ca(acc,cm(N[i],(math.comb(5-i,j-i)%5)*((-B0)**(j-i))))
        assert not any(cyrem(acc,j)),('constraint1',j)
    delta=Q-L0**5
    for j in range(5):
        acc=ZERO
        for i in range(6-j):acc=ca(acc,cm(N[i],(math.comb(5-i,j)%5)*((-L0)**(5-i-j))))
        acc=cm(acc,delta)
        if j==0 and affine:acc=ca(acc,cm(cp(Y,10),t**3))
        assert not any(cmod(acc,t**(5-j))),('constraint2',j)
    for j in range(11):
        acc=N[j] if j<6 else ZERO
        if j>=5:acc=ca(acc,cm(N[j-5],Q))
        if j==10 and affine:acc=ca(acc,cm(cp(Y,10),t**3))
        assert pole(acc)<=10+12*j-max(0,j-5),('constraint3',j,pole(acc))
    assert pole(G[1])<=46 and pole(G[2])<=57
    assert G[1][1][12]==(epsilon if affine else 0)
    h=D2[1][1];w=G[2][0][19];c=G[1][0][15]
    assert c==add(mul(Ca,h),mul(Cd,w))
    return True

def main():
    start=time.time()
    assert P.eval(r)==0 and A.eval(alpha)==0 and Q.derivative()==P*A**2
    assert not (Q-B0**5)%(P**2) and not (Q-L0**5)%(A**3)
    assert t.degree()==3 and t[3]==1
    desc=[];basisG=[];basisD=[]
    for block,d in enumerate([14,46,57,70]):
        for i,j in basis(d):
            D=monomial(i,j) if block==0 else ZERO
            g=[ZERO]*4;g[block]=cm(D,cp(Y,2)) if block==0 else monomial(i,j)
            desc.append([block,i,j]);basisG.append(tuple(g));basisD.append(D)
    cols=[]
    for D,G in zip(basisD,basisG):cols.append([D[0].eval(r)]+fcoeff(G))
    mat=np.array(cols,dtype=np.uint32).T
    rhs=np.zeros(mat.shape[0],dtype=np.uint32)
    # The inhomogeneous terms only occur in the j=0 endpoint congruence and at pole 127.
    a=flatten(cmod(cn(cp(Y,10)),t**2),[6]*3)
    rhs[121:139]=a
    rhs[-1]=neg((t**3*P**3)[39])
    aug=np.concatenate((mat,rhs[:,None]),axis=1)
    rr,pivs=rref(aug);rank=len(pivs)
    assert mat.shape==(150,156) and rank==150 and max(pivs)<156
    # Fix top coordinates h,w,e,f, then retain the final two free variables as kernel coordinates.
    tops=[]
    for target in [(0,1,1),(2,19,0),(2,12,2),(3,16,2)]:
        row=np.zeros(156,dtype=np.uint32);row[desc.index(list(target))]=1;tops.append(row)
    m2=np.concatenate((mat,np.array(tops,dtype=np.uint32)),axis=0)
    rh2=np.zeros((154,5),dtype=np.uint32);rh2[:150,0]=rhs
    for i in range(4):rh2[150+i,i+1]=1
    rr,pivs=rref(np.concatenate((m2,rh2),axis=1))
    assert len(pivs)==154 and max(pivs)<156
    free=[i for i in range(156) if i not in pivs]
    solutions=[]
    for k in range(7):
        sol=np.zeros(156,dtype=np.uint32)
        if k<5:
            for i,p in enumerate(pivs):sol[p]=rr[i,156+k]
        else:
            sol[free[k-5]]=1
            for i,p in enumerate(pivs):sol[p]=neg(int(rr[i,free[k-5]]))
        solutions.append(sol)
    stored=[]
    for k,sol in enumerate(solutions):
        G=[ZERO]*4;D=ZERO
        for val,gi,di in zip(sol,basisG,basisD):
            if val:
                G=[ca(G[j],cm(gi[j],int(val))) for j in range(4)];D=ca(D,cm(di,int(val)))
        verify_source(G,D,k==0)
        stored.append({'D2':[p.tolist() for p in D], 'G':[[p.tolist() for p in g] for g in G]})
    output={'field':'F25[alpha]/(alpha^4+[7]alpha^3+[6]alpha^2+[2]alpha+[5])','variables':['1','h','w','e','f','k0','k1'], 'kernel_free_monomials':[desc[i] for i in free], 'basis':stored, 'constants':{'epsilon':epsilon,'eta':eta,'Ca':Ca,'Cd':Cd,'t':t.tolist()}}
    (ROOT/'data'/'source_affine6.json').write_text(json.dumps(output,separators=(',',':'))+'\n')
    result={'source_matrix_shape':list(mat.shape),'rank':rank,'affine_dimension':156-rank,'top_augmented_rank':154,'kernel_free_monomials':output['kernel_free_monomials'],'full_source_checks':7,'elapsed_seconds':round(time.time()-start,3),'constants':output['constants']}
    (ROOT/'checks'/'source_check.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result,indent=2))
if __name__=='__main__':main()
