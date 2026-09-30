"""Global scaled source over K[q,u], denominator q*d0(q), and exact bounds.
Also verifies the supplied cubic F6 from the reconstructed source.
"""
from cramer import *

CR=json.loads((ROOT/'data/cramer.json').read_text())
D0=LP.terms({(i,j-2):c for i,j,c in CR['kernel_determinant']})
D0q=[D0.t.get((0,0),0),D0.t.get((0,3),0)]

def divide_D0(poly):
    groups={}
    for (i,j),c in poly.t.items():groups.setdefault(i,{})[j]=c
    out={}
    for i,terms in groups.items():
        lo,hi=min(terms),max(terms)
        if hi-lo<3:return None
        pp=[terms.get(j,0) for j in range(lo,hi+1)]
        quo,rem=pdm(pp,[D0q[0],0,0,D0q[1]])
        if rem:return None
        for j,c in enumerate(quo):
            if c:out[(i,j+lo)]=c
    return LP.terms(out)

class DR:
    """N / D0(w^3)^d. The numerator is Laurent in h,w."""
    __slots__=('n','d')
    def __init__(self,a=0,d=0):
        if isinstance(a,DR):self.n,self.d=a.n,a.d
        else:
            self.n,self.d=LP(a),d
            if not self.n:self.d=0
            while self.d:
                quo=divide_D0(self.n)
                if quo is None:break
                self.n=quo;self.d-=1
    @staticmethod
    def code(c):return DR(LP.code(c))
    def __add__(a,b):
        b=DR(b);d=max(a.d,b.d)
        return DR(a.n*D0**(d-a.d)+b.n*D0**(d-b.d),d)
    __radd__=__add__
    def __neg__(a):return DR(-a.n,a.d)
    def __sub__(a,b):return a+-DR(b)
    def __rsub__(a,b):return -a+b
    def __mul__(a,b):
        b=DR(b);return DR(a.n*b.n,a.d+b.d)
    __rmul__=__mul__
    def __truediv__(a,b):
        b=DR(b)
        if b.d:return DR(a.n*D0**b.d/b.n,a.d)
        return DR(a.n/b.n,a.d)
    def __rtruediv__(a,b):return DR(b)/a
    def __pow__(a,n):return DR(a.n**n,a.d*n)
    def __bool__(a):return bool(a.n)
    def __eq__(a,b):return not (a-DR(b)).n

def qpoly(row):return LP.terms({(0,3*j):c for j,c in enumerate(row) if c})

def scaled_weights():
    # Here LP's two exponent positions mean u and q, not h and w.
    den=LP.terms({(0,1):D0q[0],(0,2):D0q[1]})
    weights=[den,LP.terms({(1,0):D0q[0],(1,1):D0q[1]}),den]
    for name in ['e','f']:
        poly=LP.terms({(i,(j-2*i+1)//3):c for i,j,c in CR[name]})
        weights.append(poly*den)
    for name in ['kernel0_numerator','kernel1_numerator']:
        weights.append(LP.terms({(i,(j-2*i-1)//3+1):c for i,j,c in CR[name]}))
    return den,weights

def companion_numerator(poly):
    """Delta^2*poly(q,u) after u=e(c+3xi)/Delta. Returns A(q),B(q)."""
    b,c,e=[I[k] for k in ['b','c','e']]
    delta=ps(ppow(c,2),scale(pm(b,e),4))
    numer=[(ppow(delta,2),[]), (pm(pm(e,c),delta),scale(pm(e,delta),3)),
           (scale(pm(b,ppow(e,3)),3),pm(ppow(e,2),c))]
    rr=[[],[]]
    for (i,j),co in poly.t.items():
        assert 0<=i<=2 and j>=0
        for k in [0,1]:rr[k]=pa(rr[k],[0]*j+scale(numer[i][k],co))
    return rr

def run():
    ts=time.time()
    # Exact cubic check, not interpolation.
    mat,qs,ts0=series_basis(7,DR.code)
    par=[DR(1),DR(H),DR(W),DR(LP.from_json(CR['e'])),DR(LP.from_json(CR['f'])),
         DR(LP.from_json(CR['kernel0_numerator'])/W**2,1),DR(LP.from_json(CR['kernel1_numerator'])/W**2,1)]
    fs=fseries(par,mat,qs,ts0,7)
    assert not any(fs[:6])
    ratio=div(D0q[0],I['d'][0]);assert mul(ratio,I['d'][1])==D0q[1]
    tgt=LP.code(ratio)*(qpoly(I['e'])/W**6+qpoly(I['c'])*H/W**4+qpoly(I['b'])*H**2/W**2+qpoly(I['a0'])*H**3)
    assert fs[6]==DR(tgt,1)
    den,weights=scaled_weights()
    data=json.loads((ROOT/'data/affine_source.json').read_text())['source_G']
    out=[];bounds=[];max0=max1=-1
    for gi in range(4):
        ccc=[]
        for yj in range(3):
            row=[]
            for xi in range(max(len(data[bb][gi][yj]) for bb in range(7))):
                pp=sum((weights[bb]*LP.code(data[bb][gi][yj][xi]) for bb in range(7) if xi<len(data[bb][gi][yj])),LP(0))
                assert all(0<=i<=2 and 0<=j<=5 for i,j in pp.t)
                row.append(pp.to_json())
                aa,bb=companion_numerator(pp)
                max0=max(max0,len(aa)-1);max1=max(max1,len(bb)-1)
            ccc.append(row)
        out.append(ccc)
    assert max0<=33 and max1<=27
    obj={'denominator_uq':den.to_json(),'D0_q':D0q,'D0_over_given_d':ratio,'numerators_Gbar':out,
         'max_u_degree':2,'max_q_degree':5,'max_companion_constant_degree':max0,'max_companion_xi_coefficient_degree':max1,
         'max_companion_weighted_degree':max(max0,max1+7)}
    (ROOT/'data/scaled_source.json').write_text(json.dumps(obj,separators=(',',':'))+'\n')
    print(json.dumps({'F0_through_F5':'identically zero','F6_cubic_identity':'PASS','D0_over_given_d':ratio,'source_numerator_degrees_u_q':[2,5],
          'companion_numerator_degrees_constant_xi':[max0,max1],'companion_weighted_degree':max(max0,max1+7),'seconds':round(time.time()-ts,3)}))
if __name__=='__main__':run()
