"""Reconstruct all source coefficients by exact linear algebra, no geometric search."""
import json,time,sys
from pathlib import Path
import field as F
import poly as U
ROOT=Path(__file__).resolve().parents[1]

def row_reduce(rows,n,verbose=False):
    rows=[row.copy() for row in rows];pivs=[];r=0
    for c in range(n):
        k=next((k for k in range(r,len(rows)) if rows[k][c]),None)
        if k is None:continue
        rows[r],rows[k]=rows[k],rows[r]
        vi=F.inv(rows[r][c]);rows[r]=[F.mul(v,vi) for v in rows[r]]
        for k in range(len(rows)):
            if k!=r and rows[k][c]:
                v=rows[k][c]
                for j in range(c,n+1):rows[k][j]=F.sub(rows[k][j],F.mul(v,rows[r][j]))
        pivs.append(c);r+=1
        if verbose and r%25==0:print('rank so far',r,flush=True)
    for row in rows[r:]:assert not row[n],('inconsistent',row)
    return rows[:r],pivs

def setup():
    F.init();inp=json.loads((ROOT/'data/input.json').read_text())
    P,A,Q,B,L=[inp[s] for s in ['P','A','Q','B0','L0']]
    U.set_curve(P)
    t=U.exactdiv(A,U.scale([F.neg(25),1],13))
    V=U.exactdiv(U.sub(Q,U.frob(L)),U.powp(t,3))
    assert U.gcd(V,t)==[1]
    assert U.evalp(P,9)==0
    assert U.deriv(Q)==U.mul(P,U.powp(A,2))
    assert not U.rem(U.sub(Q,U.frob(B)),U.powp(P,2))
    assert not U.rem(U.sub(Q,U.frob(L)),U.powp(A,3))
    return inp,P,A,Q,B,L,t,V

def build_constraints():
    inp,P,A,Q,B,L,t,V=setup()
    B2=U.powp(B,2);B3=U.mul(B,B2);L2=U.powp(L,2);L3=U.mul(L,L2)
    t2=U.powp(t,2);t3=U.mul(t2,t)
    y2=U.monomial(0,2);y10=U.cpow(U.monomial(0,1),10)
    blocks=[('D2',14),('G3',46),('G4',57),('G5',70)]
    unknowns=[(b,i,j) for b,d in blocks for i,j in U.basis(d)]
    zero=U.zero()
    def constraints(cfs):
        D2,G3,G4,G5=cfs
        G2=U.cmul(y2,D2)
        a=U.csub(G3,U.cscale(U.cmulpoly(G2,B),3))
        b=U.cadd(U.csub(G4,U.cscale(U.cmulpoly(G3,B),2)),U.cscale(U.cmulpoly(G2,B2),3))
        c=U.csub(U.cadd(U.csub(G5,U.cmulpoly(G4,B)),U.cmulpoly(G3,B2)),U.cmulpoly(G2,B3))
        der=U.cadd(U.csub(U.cscale(U.cmulpoly(G2,L2),3),U.cscale(U.cmulpoly(G3,L),2)),G4)
        val=U.csub(U.cadd(U.csub(G5,U.cmulpoly(G4,L)),U.cmulpoly(G3,L2)),U.cmulpoly(G2,L3))
        val=U.cmulpoly(val,V)
        top=U.cmulpoly(G5,Q)
        out=[U.evalp(D2[0],9)]
        for aa,m in [(a,3),(b,4),(c,5)]:
            rr=U.cmod_y(aa,m)
            for j in range(3):
                d=10*max(0,(m-j+2)//3)
                out.extend(U.coeff(rr[j],i) for i in range(d))
        for aa,pp in [(der,t),(val,t2)]:
            rr=U.crem_poly(aa,pp)
            for j in range(3):out.extend(U.coeff(rr[j],i) for i in range(len(pp)-1))
        out.extend([U.coeff(top[0],42),U.coeff(top[1],39)])
        assert len(out)==150
        return out
    columns=[]
    for b,i,j in unknowns:
        cfs=[U.zero() for _ in blocks];cfs[[v[0] for v in blocks].index(b)]=U.monomial(i,j)
        columns.append(constraints(cfs))
    rhs=[0]*150
    rrv=U.crem_poly(y10,t2)
    off=1+120+9
    for j in range(3):
        for i in range(6):rhs[off+j*6+i]=F.neg(U.coeff(rrv[j],i))
    const=U.cadd(U.cmulpoly(U.monomial(0,0),U.mul([F.neg(9),1],U.powp(Q,2))),U.cmulpoly(y10,t3))
    rhs[-2]=F.neg(U.coeff(const[0],42));rhs[-1]=F.neg(U.coeff(const[1],39))
    rows=[[col[i] for col in columns]+[rhs[i]] for i in range(150)]
    return inp,unknowns,rows,constraints,(t,V)

def run():
    start=time.time()
    inp,unknowns,rows,constraints,tv=build_constraints();n=len(unknowns)
    red,pivs=row_reduce(rows,n,True);free=[i for i in range(n) if i not in pivs]
    assert len(free)==6
    base=[0]*n;dirs=[[0]*n for _ in free]
    for k,c in enumerate(free):dirs[k][c]=1
    for row,c in zip(red,pivs):
        base[c]=row[-1]
        for k,f in enumerate(free):dirs[k][c]=F.neg(row[f])
    # Reparameterize: h,w,e,f and two original free coordinates.
    targets=[('D2',1,1),('G4',19,0),('G4',12,2),('G5',16,2)]
    indices=[unknowns.index(v) for v in targets]
    chosen=[];test=[]
    for i in indices:
        test.append([d[i] for d in dirs]+[0])
    _,pp=row_reduce(test,6);assert len(pp)==4
    for f in free:
        rr,pp=row_reduce(test+[[d[f] for d in dirs]+[0]],6)
        if len(pp)>len(test):test.append([d[f] for d in dirs]+[0]);chosen.append(f)
        if len(test)==6:break
    assert len(test)==6
    indices+=chosen
    # Invert a 6x6 matrix using 6 RHS solves.
    invcols=[]
    M=[[d[i] for d in dirs] for i in indices]
    for j in range(6):
        rr,pp=row_reduce([M[i]+[int(i==j)] for i in range(6)],6)
        assert pp==list(range(6));invcols.append([r[-1] for r in rr])
    ndirs=[]
    for col in invcols:
        ndirs.append([sumk(F.mul(col[k],dirs[k][i]) for k in range(6)) for i in range(n)])
    nb=[F.sub(base[i],sumk(F.mul(base[indices[k]],ndirs[k][i]) for k in range(6))) for i in range(n)]
    # Verify *every* original linear equation for affine origin and six directions.
    for row in rows:
        assert sumk(F.mul(row[i],nb[i]) for i in range(n))==row[-1]
        for d in ndirs:assert sumk(F.mul(row[i],d[i]) for i in range(n))==0
    eps=F.code(inp['epsilon_K_digits']);Ca=F.code(inp['Ca_K_digits']);Cd=F.code(inp['Cd_K_digits'])
    ic=unknowns.index(('G3',15,0));ieps=unknowns.index(('G3',12,1))
    assert nb[ic]==0 and [d[ic] for d in ndirs]==[Ca,Cd,0,0,0,0]
    assert nb[ieps]==eps and all(d[ieps]==0 for d in ndirs)
    out={'variables':['h','w','e','f','s','u'],'kernel_coordinates':[unknowns[i] for i in chosen],
         'unknowns':unknowns,'constant':nb,'directions':ndirs,'t':tv[0],'U':tv[1],
         'rank':len(pivs),'dimension':6,'equation_count':len(rows)}
    (ROOT/'data/source_affine.json').write_text(json.dumps(out,separators=(',',':'))+'\n')
    summary={'unknowns':n,'rank':len(pivs),'dimension':6,'equations':len(rows),'kernel_coordinates':out['kernel_coordinates'],
             'all_equations_verified_for_origin_and_six_directions':True,'top_coordinate_relations_verified':True,
             'gcd_U_t_is_one':True,'seconds':round(time.time()-start,3)}
    (ROOT/'evidence/source_summary.json').write_text(json.dumps(summary,indent=2)+'\n')
    print(json.dumps(summary,indent=2))

def sumk(seq):
    a=0
    for b in seq:a=F.add(a,b)
    return a

if __name__=='__main__':run()
