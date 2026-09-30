"""Formal polynomial identities over Z or F5, without symbolic dependencies."""
import itertools

def ops(n,mod=None):
    one={(0,)*n:1}
    def var(i):
        m=[0]*n;m[i]=1
        return {tuple(m):1}
    def plus(a,b,sign=1):
        out=dict(a)
        for m,c in b.items():
            value=out.get(m,0)+sign*c
            if mod is not None:value%=mod
            if value:out[m]=value
            elif m in out:del out[m]
        return out
    def times(a,b):
        out={}
        for x,c in a.items():
            for y,d in b.items():
                m=tuple(v+w for v,w in zip(x,y))
                out[m]=out.get(m,0)+c*d
        if mod is not None:out={m:c%mod for m,c in out.items()}
        return {m:c for m,c in out.items() if c}
    def scale(a,c):return plus({},a,c)
    def power(a,e):
        r=one
        for _ in range(e):r=times(r,a)
        return r
    return one,var,plus,times,scale,power

def schur_identities():
    cases=[(3,(0,1,4),'h2'),(3,(0,1,5),'h3'),
           (4,(0,1,4,5),'s22'),(4,(0,1,4,8),'s52')]
    for n,columns,label in cases:
        one,var,add,mul,scale,powp=ops(n)
        elementary=[one]+[var(i)for i in range(n)]
        reduced=[]
        for k in range(max(columns)+1):
            vec=[{}for _ in range(n)]
            if k<n:vec[k]=one.copy()
            else:
                for d in range(1,n+1):
                    for r in range(n):
                        vec[r]=add(vec[r],mul(elementary[d],reduced[k-d][r]),
                                   1 if d%2 else -1)
            reduced.append(vec)
        determinant={}
        for perm in itertools.permutations(range(n)):
            term=one
            for row,col in enumerate(perm):term=mul(term,reduced[columns[col]][row])
            sign=-1 if sum(perm[i]>perm[j]for i in range(n)for j in range(i+1,n))%2 else 1
            determinant=add(determinant,term,sign)
        complete=[one]
        for k in range(1,7):
            h={}
            for d in range(1,min(k,n)+1):
                h=add(h,mul(elementary[d],complete[k-d]),1 if d%2 else -1)
            complete.append(h)
        if label=='h2':expected=complete[2]
        elif label=='h3':expected=complete[3]
        elif label=='s22':expected=add(powp(elementary[2],2),mul(elementary[1],elementary[3]),-1)
        else:expected=add(mul(complete[5],complete[2]),mul(complete[6],complete[1]),-1)
        assert determinant==expected,(columns,determinant,expected)
        print(f'PASS formal alternant/Vandermonde identity {columns} = {label}, over Z.')

def coincident_label_identity():
    # Variables c1,c2,c3,t,x. G=c1*x^4+c2*t*x^8+c3*t^2*x^12.
    one,var,add,mul,scale,power=ops(5,5)
    def monomial(exponents,c=1):return {tuple(exponents):c%5} if c%5 else {}
    g=add(add(monomial((1,0,0,0,4)),monomial((0,1,0,1,8))),
          monomial((0,0,1,2,12)))
    def dx(p):
        out={}
        for m,c in p.items():
            if m[4]:
                mm=list(m);mm[4]-=1;v=c*m[4]%5
                if v:out[tuple(mm)]=v
        return out
    gp=dx(g);gpp=dx(gp);gppp=dx(gpp)
    # det confluent [1,x,G,xG] = (G''/2)^2-G'G'''/6.
    result=add(scale(mul(gpp,gpp),4),mul(gp,gppp),-1)
    low={m:c for m,c in result.items()if m[3]<=2}
    expected=add(monomial((0,2,0,2,12)),monomial((1,0,1,2,12)),-1)
    assert low==expected,(low,expected)
    print('PASS coincident-label confluent identity: coefficients t^0,t^1 vanish; t^2=(c2^2-c1*c3)*x^12.')

def run():
    schur_identities()
    coincident_label_identity()

if __name__=='__main__':run()
