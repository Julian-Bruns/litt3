"""Construct (10) by exact polynomial divisions, without inverting P or y."""
from algebra import *
from laurent import LP
import json,time
LP.n=3
H=LP.mono((1,0,0));q=LP.mono((0,1,0));x=LP.mono((0,0,1))
def pol(a):return sum((LP(c)*x**i for i,c in enumerate(a) if c),LP(0))
PP=pol(P);BB=pol(B0);tt=pol(t)
source=json.loads((ROOT/'data/normalized_source.json').read_text())
U={};V={};ZZ={}
for i in range(2,6):
    U[i]=LP(0);V[i]=LP(0);ZZ[i]=LP(0)
    for m,j,ha,qa,c in source[str(i)]:
        v=LP.mono((ha,qa,m),c)
        if j==0:U[i]+=v
        elif j==1:V[i]+=v
        else:ZZ[i]+=v

def exactx(f,g):
    """Divide by a constant-coefficient x-polynomial, exact including all H,q."""
    ans={}
    hq=sorted(set((a,b) for a,b,_ in f.d))
    for a,b in hq:
        row=[0]*(1+max(c for aa,bb,c in f.d if (aa,bb)==(a,b)))
        for (aa,bb,c),v in f.d.items():
            if (aa,bb)==(a,b):row[c]=v
        qr=pexact(row,g)
        for c,v in enumerate(qr):
            if v:ans[a,b,c]=v
    return LP(ans)

def main():
    st=time.time();k0=3794
    assert U[2]==k0*PP and not V[2]
    a3=exactx(U[3]-3*BB*U[2],P);b3=exactx(V[3],P);c3=exactx(ZZ[3]-3*BB*ZZ[2],P)
    a4=exactx(U[4]-2*BB*U[3]+3*BB**2*U[2],ppow(P,2))
    b4=exactx(V[4]-2*BB*V[3],P)
    c4=exactx(ZZ[4]-2*BB*ZZ[3]+3*BB**2*ZZ[2],P)
    Z=ZZ[2]
    eq=[Z**3+q**5*power(k0,3)*PP,
        c3*Z**2-q**3*k0*b3*Z+q**5*power(k0,2)*a3,
        a4*Z**2-k0*c4*Z+q**3*power(k0,2)*b4]
    data={n:f.data() for n,f in zip(['Z','A3','B3','C3','A4','B4','C4'],[Z,a3,b3,c3,a4,b4,c4])}
    data.update({f'E{i+1}':e.data() for i,e in enumerate(eq)})
    for i,e in enumerate(eq):print('E'+str(i+1),'terms',len(e.d),'degrees',tuple(max(m[j] for m in e.d) for j in range(3)),flush=True)
    assert [len(e.d) for e in eq]==[431,391,241]
    (ROOT/'data/incidence.json').write_text(json.dumps(data,indent=2)+'\n')
    # Identify the H-coefficient in Z, compare against powers of t.
    zh=LP({(0,b,c):v for (a,b,c),v in Z.d.items() if a==1})
    print('coefficient of H in Z',zh)
    for n in ['A3','B3','A4','B4']:
        print(n,data[n])
    print('elapsed_seconds',round(time.time()-st,3),flush=True)
if __name__=='__main__':main()
