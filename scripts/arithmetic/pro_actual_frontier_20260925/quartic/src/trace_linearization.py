"""Exact 8-by-5 affine E-linear reduction of the eliminated trace equation.
E=F_(5^7), F=F_(5^14), L=F[alpha]/(alpha^4+[7]alpha^3+[6]alpha^2+[2]alpha+[5]).
E elements are stored in the seven-coordinate F25/zeta representation of F,
with the condition x^(5^7)=x. This module does NOT enumerate all endpoint pairs
or solve all resulting norm quadrics.
"""
from trace_profiles import F,DATA,ZPOW,conjugate,family_moments
from finite_fields import pow25,sub as sub25,inv as inv25

ZERO=(F.zero,)*4
ONE=(F.one,F.zero,F.zero,F.zero)
MOD=DATA['K0_modulus']

def lc(c):return (F.const(c),F.zero,F.zero,F.zero)
def la(a,b):return tuple(F.add(x,y) for x,y in zip(a,b))
def ln(a):return tuple(F.neg(x) for x in a)
def ls(a,b):return la(a,ln(b))
def lscale(a,c):return tuple(F.scale(x,c) for x in a)
def lefscale(a,c):return tuple(F.mul(x,c) for x in a)
def lm(a,b):
    t=[F.zero]*7
    for i,x in enumerate(a):
        for j,y in enumerate(b):t[i+j]=F.add(t[i+j],F.mul(x,y))
    for i in range(6,3,-1):
        for j in range(4):t[i-4+j]=F.sub(t[i-4+j],F.scale(t[i],MOD[j]))
    return tuple(t[:4])

def endpoint(labels):
    if len(labels)!=4:raise ValueError('An end needs exactly four labels, repetitions allowed.')
    C=ZERO;M=ZERO
    for i,j in labels:
        if not (0<=i<4 and 0<=j<29):raise ValueError('Invalid label')
        C=la(C,tuple(F.scale(ZPOW[(5*j)%29],x) for x in DATA['C_rows'][i]))
        M=la(M,tuple(F.scale(ZPOW[(8*j)%29],x) for x in DATA['M_rows'][i]))
    return C,M

BETA=5
BAR_BETA=pow25(5,5)
BETA_DIFF_INV=inv25(sub25(BETA,BAR_BETA))

def decompose_F(x):
    """x=e0+beta*e1, e0,e1 in E."""
    e1=F.scale(F.sub(x,conjugate(x)),BETA_DIFF_INV)
    e0=F.sub(x,F.scale(e1,BETA))
    assert conjugate(e0)==e0 and conjugate(e1)==e1
    assert F.add(e0,F.scale(e1,BETA))==x
    return e0,e1

def ecoords(x):
    out=[]
    for f in x:out.extend(decompose_F(f))
    return out

def affine_matrix(infinity,zero):
    U,V=endpoint(infinity);W,Z=endpoint(zero);a=DATA['a']
    cols=[
      ln(lscale(la(V,Z),a)),
      ln(lscale(la(lscale(V,BAR_BETA),lscale(Z,BETA)),a)),
      lscale(la(U,W),a),
      lscale(la(lscale(U,BETA),lscale(W,BAR_BETA)),a),
      lc(pow25(a,2)),
      ln(ls(lm(U,W),lm(V,Z)))
    ]
    cols=[ecoords(c) for c in cols]
    return [[cols[j][i] for j in range(6)] for i in range(8)]

def rref(matrix):
    a=[[tuple(x) for x in row] for row in matrix];piv=[];r=0
    for col in range(5):
        p=next((i for i in range(r,len(a)) if a[i][col]!=F.zero),None)
        if p is None:continue
        a[r],a[p]=a[p],a[r];iv=F.inv(a[r][col])
        a[r]=[F.mul(x,iv) for x in a[r]]
        for i in range(len(a)):
            if i!=r and a[i][col]!=F.zero:
                c=a[i][col]
                a[i]=[F.sub(x,F.mul(c,y)) for x,y in zip(a[i],a[r])]
        piv.append(col);r+=1
    inconsistent=any(all(x==F.zero for x in row[:5]) and row[5]!=F.zero for row in a)
    return {'rank':len(piv),'pivot_columns':piv,'inconsistent':inconsistent,'rref':a}

def norm_form(a,b):
    return F.add(F.add(F.mul(a,a),F.mul(a,b)),F.scale(F.mul(b,b),2))

def check_moments(matrix,X,Y):
    x0,x1=decompose_F(X);y0,y1=decompose_F(Y)
    h=F.sub(norm_form(y0,y1),norm_form(x0,x1))
    v=[x0,x1,y0,y1,h]
    for row in matrix:
        left=F.zero
        for c,x in zip(row[:5],v):left=F.add(left,F.mul(c,x))
        assert left==row[5]
    return v

if __name__=='__main__':
    import json
    from trace_profiles import ROOT
    fixed=DATA['fixed_end_labels_infinity']
    tests=[(fixed,fixed), ([(0,0)]*4,[(0,0)]*4),
           ([(0,0),(1,1),(2,2),(3,3)],[(0,4),(1,5),(2,6),(3,7)]),
           ([(0,0),(0,1),(1,2),(3,5)],[(1,0),(1,7),(2,11),(3,18)])]
    out=[]
    for ii,(i,z) in enumerate(tests):
        matrix=affine_matrix(i,z);rr=rref(matrix)
        if ii==0:
            for eps in [F.const(2),F.add(ZPOW[1],F.one)]:
                X,Y=family_moments(eps);check_moments(matrix,X,Y)
        out.append({'infinity':i,'zero':z,'matrix':matrix,**rr})
        print(ii,'coefficient rank',rr['rank'],'inconsistent',rr['inconsistent'])
    (ROOT/'certificates/linearization_examples.json').write_text(json.dumps(out,indent=2)+'\n')
