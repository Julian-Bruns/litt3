"""Exact global graph and Cramer source in sparse K[h,w,w^-1] arithmetic."""
import json,time
from pathlib import Path
import field as F
from laurent import LP,k,h,w,s,u
import evaluate as E
ROOT=Path(__file__).resolve().parents[1]
Z=k(0)
def sadd(a,b):return [(a[i] if i<len(a) else Z)+(b[i] if i<len(b) else Z) for i in range(max(len(a),len(b)))]
def smul(a,b,n=7):
    out=[Z]*n
    for i,c in enumerate(a[:n]):
        for j,v in enumerate(b[:n-i]):out[i+j]=out[i+j]+c*v
    return out
def spow(a,n,prec=7):
    out=[k(1)]
    while n:
        if n&1:out=smul(out,a,prec)
        a=smul(a,a,prec);n//=2
    return out

def source_sym():
    z=2*w/k(E.EPS);c=k(E.CA)*h+k(E.CD)*w
    ee=-c*z-k(E.ETA)/(k(24)*z)
    ff=-w**2/k(E.EPS)-k(F.div(8,24))*z**5
    pars=[h,w,ee,ff,s,u]
    vals=[]
    for i,c0 in enumerate(E.SOURCE['constant']):
        vals.append(k(c0)+sum((k(d[i])*p for d,p in zip(E.SOURCE['directions'],pars)),Z))
    return vals

def series_for(vals,b,pole,n=7):
    out=[Z]*n
    ys=[[1],E.Y,E.spow(E.Y,2,n)]
    for (bb,i,j),cc in zip(E.SOURCE['unknowns'],vals):
        if bb!=b:continue
        # G2=y^2 D2. Do not reduce y^3 here: same infinity series.
        jj=j+2 if b=='D2' else j
        yy=E.spow(E.Y,jj,n)
        shift=pole-3*i-10*jj
        assert shift>=0
        if shift<n:
            for t,v in enumerate(yy):
                if shift+t<n:out[shift+t]=out[shift+t]+k(v)*cc
    return out

def fs_for(vals):
    aa=[3*v for v in series_for(vals,'D2',35)]
    bb=[2*v for v in series_for(vals,'G3',46)]
    cc=series_for(vals,'G4',57)
    assert bb[0]==k(F.scale(E.EPS,2)) and aa[0]==0
    rho=[]
    for i in range(5):
        val=sadd(sadd(smul(aa,spow(rho,2)),smul(bb,rho)),cc)
        rho.append(-val[i]/bb[0])
    qs=[k(v) for v in (E.series_curve([E.Q,[],[]],57)+[0]*7)[:7]]
    left=qs.copy();left[2]=left[2]+rho[0]**5
    inner=sadd(smul(aa,spow(rho,3)),[2*v for v in smul(bb,spow(rho,2))])
    right=sadd(series_for(vals,'G5',70),[Z,Z]+inner)[:7]
    fixed=E.series_curve(E.U.cmulpoly(E.U.cpow(E.U.monomial(0,1),10),E.U.powp(E.t,3)),127)
    out=sadd(smul(left,right),[k(v) for v in fixed])[:7]
    assert all(v==0 for v in out[:4])
    return out

def run():
    start=time.time();vals=source_sym();fs=fs_for(vals)
    for f in fs[4:6]:assert all(e[2]+e[3]<=1 for e in f.d)
    a,b=[fs[4].coeff_kernel(*e) for e in [(1,0),(0,1)]]
    c,d=[fs[5].coeff_kernel(*e) for e in [(1,0),(0,1)]]
    f0,g0=[f.coeff_kernel(0,0) for f in fs[4:6]]
    det=a*d-b*c
    Ns=b*g0-d*f0;Nu=c*f0-a*g0
    assert all(e[0]==0 and e[2:]==(0,0) for e in det.d)
    nums=[]
    for v in vals:
        nums.append(v.coeff_kernel(0,0)*det+v.coeff_kernel(1,0)*Ns+v.coeff_kernel(0,1)*Nu)
    # Symbolic verification of the two Cramer equations after substitution.
    assert f0*det+a*Ns+b*Nu==0
    assert g0*det+c*Ns+d*Nu==0
    # Rational expression for F6 with a common denominator det^d.
    f6=fs[6];kernel_degree=max((sum(e[2:]) for e in f6.d),default=0)
    NF6=Z
    for ex,cc in f6.d.items():
        hp,wp,sp,up=ex
        NF6=NF6+LP({(hp,wp,0,0):cc})*Ns**sp*Nu**up*det**(kernel_degree-sp-up)
    out={'parameter_names':['h','w','s','u'], 'kernel_coordinate_labels':E.SOURCE['kernel_coordinates'],
         'graph_coefficients':[v.data() for v in vals],
         'F4':fs[4].data(),'F5':fs[5].data(),'F6_before_Cramer':fs[6].data(),
         'det':det.data(),'Ns':Ns.data(),'Nu':Nu.data(),
         'source_numerators':[v.data() for v in nums],
         'F6_numerator':NF6.data(),'F6_denominator_det_power':kernel_degree}
    (ROOT/'data/cramer_symbolic.json').write_text(json.dumps(out,separators=(',',':'))+'\n')
    for hh,ww in [(1,1),(2,3),(101,102),(251,12345)]:
        dic,pars,fj,de=E.cramer(hh,ww)
        assert det.specialize(hh,ww)==de
        assert F.div(Ns.specialize(hh,ww),de)==pars[4]
        assert F.div(Nu.specialize(hh,ww),de)==pars[5]
        assert F.div(NF6.specialize(hh,ww),F.powk(de,kernel_degree))==fj[6]
    summary={'det':det.data(),'max_H_degree_of_source_numerators':max(e[0] for p in nums for e in p.d),
             'F6_kernel_degree_before_Cramer':kernel_degree,'F6_numerator_terms':len(NF6.d),
             'F6_max_H_degree':max(e[0] for e in NF6.d),
             'F4_F5_symbolic_Cramer_identities_verified':True,
             'numerical_cross_checks':4,'seconds':round(time.time()-start,3)}
    (ROOT/'evidence/cramer_summary.json').write_text(json.dumps(summary,indent=2)+'\n')
    print(json.dumps(summary,indent=2))
if __name__=='__main__':run()
