"""Convert the whole source to H,q and Y=y/w, with Y^3=P/q.
Output all coefficients of w^2 G_i as polynomials /d(q), then barred numerators.
No parameters are specialized. All divisions in x are exact.
"""
import json,time
from pathlib import Path
import field as F
import poly as U
from laurent import LP
import evaluate as E
ROOT=Path(__file__).resolve().parents[1]

def addterm(out,e,c):
    v=F.add(out.get(e,0),c)
    if v:out[e]=v
    else:out.pop(e,None)

def plus(a,b):
    out=a.copy()
    for e,c in b.items():addterm(out,e,c)
    return out

def scale(a,c):return {e:F.mul(v,c) for e,v in a.items() if F.mul(v,c)}
def times_xpoly(a,p):
    out={}
    for (h,q,x,y),c in a.items():
        for i,v in enumerate(p):
            if v:addterm(out,(h,q,x+i,y),F.mul(c,v))
    return out

def div_y(a,n):
    grouped={}
    for (h,q,x,y),c in a.items():
        yy=(y-n)%3;e=(n+yy-y)//3
        key=(h,q+e,yy,e)
        v=grouped.setdefault(key,[])
        while len(v)<=x:v.append(0)
        v[x]=F.add(v[x],c)
    out={}
    for (h,q,y,e),p in grouped.items():
        v=U.exactdiv(U.trim(p),U.powp(E.P,e))
        for x,c in enumerate(v):
            if c:addterm(out,(h,q,x,y),c)
    return out

def todata(a):return [[list(e),c] for e,c in sorted(a.items())]
def fromdata(data):return {tuple(e):c for e,c in data}

def evaluate(a,H,q,Y_curve=True):
    out=U.zero()
    for (hp,qp,x,y),c in a.items():
        v=F.mul(c,F.mul(F.powk(H,hp),F.powk(q,qp)))
        while len(out[y])<=x:out[y].append(0)
        out[y][x]=F.add(out[y][x],v)
    return [U.trim(v) for v in out]

def run():
    start=time.time();d=json.loads((ROOT/'data/cramer_symbolic.json').read_text());source=E.SOURCE
    GG={i:{} for i in ['G2','G3','G4','G5']}
    for (block,x,y),terms in zip(source['unknowns'],d['source_numerators']):
        for (hp,wp,ss,uu),c in terms:
            assert not ss and not uu
            yy=y+2 if block=='D2' else y
            weight=hp+wp+yy
            assert weight%3==0
            qq=weight//3
            dest='G2' if block=='D2' else block
            if yy<3:addterm(GG[dest],(hp,qq,x,yy),c)
            else:
                for ix,p in enumerate(E.P):
                    if p:addterm(GG[dest],(hp,qq-1,x+ix,yy-3),F.mul(c,p))
    assert min(e[1] for a in GG.values() for e in a)>=0
    B,B2,B3=E.B,U.powp(E.B,2),U.powp(E.B,3)
    bars={}
    bars['g2']=div_y(GG['G2'],2)
    bars['g3']=div_y(plus(GG['G3'],scale(times_xpoly(GG['G2'],B),2)),3)
    bars['g4']=div_y(plus(plus(GG['G4'],scale(times_xpoly(GG['G3'],B),3)),scale(times_xpoly(GG['G2'],B2),3)),4)
    bars['g5']=div_y(plus(plus(plus(GG['G5'],scale(times_xpoly(GG['G4'],B),4)),times_xpoly(GG['G3'],B2)),scale(times_xpoly(GG['G2'],B3),4)),5)
    psi={}
    for (hp,wp,ss,uu),c in d['F6_numerator']:
        assert not ss and not uu and (hp+wp-1)%3==0
        addterm(psi,(hp,(hp+wp-1)//3),c)
    lead=[]
    for (h,q),c in psi.items():
        if h==3:
            while len(lead)<=q:lead.append(0)
            lead[q]=c
    assert U.evalp(lead,10149)==0 and U.evalp(lead,118020)==0
    fac=U.scale(U.shift(U.mul([F.neg(10149),1],[F.neg(118020),1]),2),lead[-1])
    assert fac==lead
    # Confirm the full rational formulas against four independent source evaluations.
    for h,w in [(1,1),(2,3),(101,102),(251,12345)]:
        q=F.powk(w,3);H=F.div(h,w);dd=F.add(47171,F.mul(357608,q))
        dic,pars,fs,det=E.cramer(h,w)
        for name in GG:
            actual=U.cscale(dic[name],F.mul(w,w))
            # Substitute old y=wY: multiply character-j coefficient by w^j.
            actual=[U.scale(p,F.powk(w,j)) for j,p in enumerate(actual)]
            got=U.cscale(evaluate(GG[name],H,q),F.inv(dd))
            assert actual==got
        ps=0
        for (hp,qp),c in psi.items():ps=F.add(ps,F.mul(c,F.mul(F.powk(H,hp),F.powk(q,qp))))
        assert F.div(ps,F.mul(q,F.powk(dd,2)))==fs[6]
    out={'variables':['H','q','x','Y'],'curve_relation':'Y^3=P(x)/q',
         'd_q_ascending':[47171,357608],
         'G_numerators':{name:todata(a) for name,a in GG.items()},
         'barred_numerators':{name:todata(a) for name,a in bars.items()},
         'Psi_variables':['H','q'],'Psi':todata(psi),'Psi_leading_H_coefficient':lead,
         'Qbar_x_polynomial':U.exactdiv(U.sub(E.Q,U.frob(E.B)),U.powp(E.P,2)),
         'residual_relation':'Rcal = q^(-51) d(q)^(-36) Norm(Res(fstar,Dstar))/(t^15 v^3)',
         'fstar':'d*q*mu*v*(Z^5+q^2*Y*Qbar_x_polynomial)^2 +(Z^5+q^2*Y*Qbar_x_polynomial)*(n_g2*Z^3+n_g3*Z^2+n_g4*Z+n_g5)+d*q^4*t^3',
         'Dstar':'3*n_g2*Z^2+2*n_g3*Z+n_g4'}
    (ROOT/'data/cube_free.json').write_text(json.dumps(out,separators=(',',':'))+'\n')
    summary={'source_degree_bounds':{name:{'H':max(e[0] for e in a),'q_min':min(e[1] for e in a),'q_max':max(e[1] for e in a),'x':max(e[2] for e in a),'terms':len(a)} for name,a in GG.items()},
         'barred_degree_bounds':{name:{'H':max(e[0] for e in a),'q_min':min(e[1] for e in a),'q_max':max(e[1] for e in a),'x':max(e[2] for e in a),'terms':len(a)} for name,a in bars.items()},
         'Psi_H_degree':3,'Psi_q_degree':max(e[1] for e in psi),'Psi_terms':len(psi),
         'Psi_lead_H_factorization':{'constant':lead[-1],'q_power':2,'roots':[10149,118020]},
         'symbolic_y_divisions_exact':True,'source_cross_checks':4,'seconds':round(time.time()-start,3)}
    (ROOT/'evidence/cube_free_summary.json').write_text(json.dumps(summary,indent=2)+'\n')
    print(json.dumps(summary,indent=2))
if __name__=='__main__':run()
