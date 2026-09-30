"""Reconstruct all eleven complete affine coefficient spaces by exact linear algebra."""
from exact import *
import json, math, time
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
BLOCKS=[('C2',5),('E2',2),('H30',6),('H31',3),('H41',6),('H42',3),('H50',3),('H51',1),('H52',7),('kappa',1)]
RAW_NAMES=[f'{name}_{i}' for name,n in BLOCKS for i in range(n)]

def make_raw(v,u):
    """Parametrize finite y-contact equations. Remaining linear restrictions imposed below."""
    q={};off=0
    for name,n in BLOCKS:q[name]=FP(u[off:off+n]);off+=n
    C2,E2=q['C2'],q['E2'];kappa=q['kappa'][0]
    D2=CR([C2,E2,0]);N2=y**2*D2
    N3=CR([P*q['H30'],P*q['H31'],(B*C2).scale(3)%P])
    N40=(P*((B*q['H30']).scale(2)-(B**2*E2).scale(3)))%(P**2)
    N42=((B*N3[2]).scale(2)-(B**2*C2).scale(3))%P+P*q['H42']
    N4=CR([N40,P*q['H41'],N42])
    N50=(B*N40-B**2*N3[0]+B**3*N2[0]+B**5*v)%(P**2)+P**2*q['H50']
    N51=(B*N4[1]-B**2*N3[1])%(P**2)+P**2*q['H51']
    N52=(B*N4[2]-B**2*N3[2]+B**3*C2)%P+P*q['H52']
    N5=CR([N50,N51,N52])
    return [CR(v),CR(),N2,N3,N4, N5],kappa,D2

H=(Q-L**5)//(t**3)

def raw_constraints(v,u,root=None):
    N,k,D2=make_raw(v,u)
    conditions=[]
    # Support/infinity restrictions independent of the contact congruences.
    conditions.append(D2[1][1] if root is None else D2[0].eval(root))
    conditions.append(N[3][2][9])
    end=N[5]*Q+(y**10* t**3).scale(k)
    # Exactly the two excess-pole coefficients in (3), j=10.
    conditions += [end[0][42],end[1][39]]
    # At t=0, j=1 and j=0; all j>=2 equations vanish automatically.
    C1=(N[2]*(L**2)).scale(3)-(N[3]*L).scale(2)+N[4]
    C0=CR()
    for i in range(6):C0 += N[i]*((-L)**(5-i))
    C0=C0*H+(y**10).scale(k)
    for R,m in [(C1,t),(C0,t**2)]:
        R=R.mod(m)
        for p in R.c:conditions += [p[j] for j in range(m.deg)]
    return conditions

def solve_affine(v,root=None):
    n=len(RAW_NAMES);z=[0]*n;c0=raw_constraints(v,z,root)
    cols=[]
    for j in range(n):
        e=z.copy();e[j]=1
        cols.append([sub(a,b) for a,b in zip(raw_constraints(v,e,root),c0)])
    rows=[[cols[j][i] for j in range(n)]+[neg(c0[i])] for i in range(len(c0))]
    rr,piv=rref(rows)
    if n in piv:raise ArithmeticError('inconsistent affine system')
    free=[j for j in range(n) if j not in piv]
    origin=[0]*n
    for row,p in zip(rr,piv):origin[p]=row[-1]
    basis=[]
    for f in free:
        u=[0]*n;u[f]=1
        for row,p in zip(rr,piv):u[p]=neg(row[f])
        basis.append(u)
    return origin,basis,free,rows

def all_constraints(N,k,D2,v,root=None,homogeneous=False):
    """Independent verification against the original equations (1)--(4).
    Homogeneous means the direction v=0, not a point of an open set.
    """
    assert N[0]==CR(v) and not N[1]
    for j in range(1,6):
        c=CR()
        for i in range(j+1):c+=(N[i]*((-B)**(j-i))).scale(math.comb(5-i,j-i)%5)
        assert not c.mod_y(j),('finite',j,c.mod_y(j))
    for j in range(5):
        c=CR()
        for i in range(6-j):c+=(N[i]*((-L)**(5-i-j))).scale(math.comb(5-i,j)%5)
        c=c*(Q-L**5)
        if j==0:c+=(y**10*t**3).scale(k)
        assert not c.mod(t**(5-j)),('contact',j)
    for j in range(11):
        c=N[j] if j<6 else CR()
        if 0<=j-5<=5:c+=N[j-5]*Q
        if j==10:c+=(y**10*t**3).scale(k)
        assert c.pole()<=10+12*j-max(0,j-5),('bound',j,c.pole())
    assert N[2]==y**2*D2
    assert D2.pole()<=14 and N[3].pole()<=46 and N[4].pole()<=57
    if root is None:assert D2[1][1]==0
    else:assert D2[0].eval(root)==0

def serialize(N,k,D2):return {'N':[p.data() for p in N],'kappa':k,'D2':D2.data()}
def deserialize(d):return [CR(p) for p in d['N']],d['kappa'],CR(d['D2'])

def top_coordinates(N,k,D2,root=None):
    a=D2[0][4] if root is None else D2[1][1]
    return [k,a,N[3][0][15],N[4][0][19],N[4][2][12],N[5][2][16]]

def main():
    start=time.monotonic();roots=[r for r in range(ORDER) if P.eval(r)==0]
    assert len(roots)==10
    print('All P roots:',roots,flush=True)
    spaces=[]
    for root in [None]+roots:
        v=FP(1) if root is None else x-root
        origin,basis,free,rows=solve_affine(v,root)
        No,ko,D2o=make_raw(v,origin)
        all_constraints(No,ko,D2o,v,root)
        Bdata=[];tops=[]
        for b in basis:
            Nb,kb,D2b=make_raw(FP(),b)
            all_constraints(Nb,kb,D2b,FP(),root,True)
            Bdata.append(serialize(Nb,kb,D2b));tops.append(top_coordinates(Nb,kb,D2b,root))
        assert len(basis)==7
        topmat=[[col[j] for col in tops] for j in range(6)]
        rt,pt=rref(topmat)
        print('v root',root,'dimension',len(basis),'free',[RAW_NAMES[i] for i in free],'top_rank',len(pt),flush=True)
        spaces.append({'root':root,'v':list(v.c),'raw_origin':origin,'raw_basis':basis,'free_indices':free,'origin':serialize(No,ko,D2o),'basis':Bdata,'top_origin':top_coordinates(No,ko,D2o,root),'top_columns':tops,'top_rank':len(pt)})
    data={'encoding':'sum c_i*25^i, c_i=a_i+5*b_i; beta^2=beta+3; alpha^4+[7]alpha^3+[6]alpha^2+[2]alpha+[5]=0','field_order':ORDER,'alpha':alpha,'roots_of_P':roots,'raw_blocks':BLOCKS,'raw_names':RAW_NAMES,'spaces':spaces}
    (ROOT/'data'/'linear_spaces.json').write_text(json.dumps(data,indent=2)+'\n')
    print('Original equations verified on origins and all 77 homogeneous basis vectors. Seconds:',round(time.monotonic()-start,3))

if __name__=='__main__':main()
