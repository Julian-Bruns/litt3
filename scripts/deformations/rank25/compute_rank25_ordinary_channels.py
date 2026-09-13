"""Compute ordinary third-coordinate channels of the fifth comparison.

The retained regular-frame coefficient engine supplies the geometric
operations. This script records pieces, not a whole fifth-locus verdict.
Use a mutable copy of that engine, supplied as --engine.
"""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import argparse
import json
from pathlib import Path
import sys
import time
import zipfile

ap=argparse.ArgumentParser(description=__doc__)
ap.add_argument('--engine',type=Path,required=True)
ap.add_argument('--output',type=Path,required=True)
ap.add_argument('--directions',default='0,1,2,3,4,5,6')
args=ap.parse_args()
sys.path.insert(0,str(args.engine/'scripts'))
from branches import *
sys.path.insert(0,str(Path(__file__).resolve().parent))
from scripts.deformations.rank25.rank25_pro_data_model import unpack

st=time.time()
def log(*xs):print(*xs,'seconds',round(time.time()-st,2),flush=True)
def dot(a,b):
    out=0
    for c in ff.MUL[a,b]:out=ff.ADD[out,c]
    return int(out)
def projections(no):return [dot(row,no) for row in dual]
def neg(p):return ff.pscale(p,4)
def fsum(ps):
    r={}
    for p in ps:r=ff.padd(r,p)
    return r
def ffDer(p):return {ij:s.diff()*Dz0 for ij,s in p.items() if s.diff()}

root=Path(__file__).resolve().parents[3]
with zipfile.ZipFile(root/'Research/pro_inputs/rank25_all_fifth_lifts_inputs.zip') as z:
    data=unpack(json.loads(z.read('data.json')))
N=np.array([[ff.pack(c) for c in row] for row in data['kernel_basis']],dtype=np.int16)
dual=np.array([[ff.pack(c) for c in row] for row in data['obstruction_dual_rows']],dtype=np.int16)
b=base('product');fr=frobenius(b);gu=regular_SU(b,fr);tr=base_transition(b,fr,gu)
gg=ff.Geometry();br=Branches(b,gg);log('regular marked frame and Witt branch algebra')
d=ff.alg.load();xi=tr['xi'];z=W(1,1,m=25);Dz=b['Dz'];Dz0=Dz.ff()
A0=gg.A;B0=A0.diff()*Dz0/2
Nm=matrix_mul(matrix_mul(gu['SU'],[[W(),W(1)],[W(),W()]]),gu['SUinv'])
GN=matrix_mul(tr['Gamma'],matrix_map(tr['tau25'],Nm))
Hdiag=[[W(1),W()],[W(),W(-1)]]
CD=matrix_mul(matrix_mul(matrix_mul(matrix_mul(matrix_mul(tr['J'],gu['SU']),matrix_inv(tr['TP'])),Hdiag),tr['TP']),gu['SUinv'])
SR=matrix_mul(tr['Gamma'],matrix_map(tr['tau25'],gu['RR']))

def trans(c):
    zc=hscale(c,Dz)
    h=hadd(zc,hscale(hadd(hscale(br.D(zc),xi),hscale(c,(xi*Dz).diff()*Dz)),W(5)/2))
    cc=hscale(br.fo(h),tr['geval']);dc=br.fo(br.D(c))
    return [[hadd(hscale(cc,-GN[i][j]),hscale(dc,CD[i][j]*5/2)) for j in range(2)] for i in range(2)]

def source(c):
    eff=hadd(c,hscale(hadd(hscale(br.D(c),xi),hscale(c,xi.diff()*Dz)),W(5)/2))
    return [[hscale(eff,SR[i][j]) for j in range(2)] for i in range(2)]

def repair(rho):
    no,af=gg.split(rho,True)
    assert not np.any(no),('not exact',no.tolist())
    af=[[i,j,v,u,int(ff.NEG[c])] for i,j,v,u,c in af]
    hu=gg.polynomial(af);ho=ff.pscale(ff.padd(rho,hu),ff.S(1,-2))
    assert all(s.o>=0 for s in ho.values()),'nonregular formal repair'
    return hu,ho,af

origin=ff.ADD[np.array([ff.pack(c) for c in d['xi_origin']],np.int16),ff.MUL[N[0],d['u0']]]
first=[]
first_aff=[]
for j,vec in enumerate([origin,*N[:7]]):
    f=ff.pfrob(gg.cochain(vec));rho=ff.pscale(f,-A0)
    if j==0:rho=ff.padd(rho,{(0,0):tr['Gamma1'][0][1].shift(1)})
    uu,uo,af=repair(rho);first.append((f,uu,uo));first_aff.append(af)
    log('first repair',j-1,'AS degree',max(i+j for i,j,v,u,c in af) if af else -1)

def filtered_solve(v,bound):
    cols=[i for i in range(75) if sum(ff.MON[i//3])<=bound]
    aug=np.column_stack([ff.T['M'][:,cols],v]);r=0;piv=[]
    for j in range(len(cols)):
        nz=np.flatnonzero(aug[r:,j])
        if not len(nz):continue
        k=r+int(nz[0]);aug[[r,k]]=aug[[k,r]];aug[r]=ff.MUL[aug[r],ff.INV[aug[r,j]]]
        fac=aug[:,j].copy();fac[r]=0
        aug=ff.ADD[aug,ff.NEG[ff.MUL[fac[:,None],aug[r,None,:]]]]
        piv.append(j);r+=1
    assert not np.any(aug[r:,-1]),'filtered solve failed'
    coeff=np.zeros(75,np.int16)
    for i,j in enumerate(piv):coeff[cols[j]]=ff.T['FINV'][aug[i,-1]]
    assert np.array_equal(np.array([dot(row,ff.FROB[coeff]) for row in ff.T['M']]),v)
    assert not any(projections(coeff)), 'unexpected inverse-Frobenius ordinary channel'
    return coeff

out={'status':'executed geometric coefficient pieces; full family theorem not asserted',
     'precision':MAX,'frobenius_variant':os.environ.get('FROBENIUS_VARIANT','0'),
     'origin':'xi_origin + u0*nu0 in the retained one-parameter packet',
     'directions':{},'direct_unfrobenized_fourth_projection':'Separate finite adjoint certificate; not included in these channels.'}

# Reconstruct the moving fourth normal cohomology in THIS regular gauge.
# A different earlier smooth-reference convention can change these vectors
# by M-images and hence change the direct fourth-digit polynomial.
adj=json.loads((root/'Research/computations/rank25_fourth_digit_projections.json').read_text())
ell=np.array([[ff.pack(list(map(int,c))) for c in row] for row in adj['adjoint_rows']],np.int16)
def adjroot(no):return [int(ff.T['FINV'][dot(row,no)]) for row in ell]
def graphq(left,right):
    f,uu,uo=left;F,UU,UO=right
    return fsum([ff.pscale(ff.pmul(f,UU),B0),
      ff.pscale(ff.pmul(f,UO),B0.shift(2)-Dz0*A0*ff.S(1,1)),
      ff.pscale(ff.pmul(uu,UO),Dz0.shift(1))])
normal_linear=[];normal_quad=[]
for i in range(7):
    ge=trans(br.cochain(N[i]));f,uu,uo=first[i+1]
    cw=hscale(sum_h([ge[0][1],hscale(br.tau25(br.polynomial(first_aff[i+1]),xi),tr['Gamma'][0][0]),hscale(hlift(uo),-tr['Gamma'][1][1])]),z)
    lin=hff(hdivp(cw))
    no=gg.split(fsum([lin,graphq(first[0],first[i+1]),graphq(first[i+1],first[0])]))
    normal_linear.append({'normal':no.tolist(),'projection':projections(no),'direct_fourth_projection':adjroot(no)})
    for j in range(i,7):
        rq=graphq(first[i+1],first[j+1])
        if i!=j:rq=ff.padd(rq,graphq(first[j+1],first[i+1]))
        nq=gg.split(rq)
        normal_quad.append({'i':i,'j':j,'normal':nq.tolist(),'projection':projections(nq),'direct_fourth_projection':adjroot(nq)})
out['moving_fourth_normal']={'linear':normal_linear,'quadratic':normal_quad}
out['origin_vector']=origin.tolist()
log('all moving fourth normal coefficients')
for i in map(int,args.directions.split(',')):
    vec=N[i];coef=filtered_solve(vec,[0,1,1,2,2,3,3][i]);zz=ff.pfrob(gg.cochain(coef));vv=gg.cochain(vec)
    hu,ho,af=repair(ff.padd(vv,ff.pscale(zz,-A0)))
    gz=trans(br.cochain(coef));sv=source(br.cochain(vec))
    cw=hscale(sum_h([gz[0][1],sv[0][1],hscale(br.tau25(br.polynomial(af),xi),tr['Gamma'][0][0]),hscale(hlift(ho),-tr['Gamma'][1][1])]),z)
    carry=hff(hdivp(cw));carry_no=gg.split(carry)
    mixed=[]
    for j,(f,uu,uo) in enumerate(first):
        rr=fsum([
          ff.pscale(ff.pmul(zz,uu),B0),ff.pscale(ff.pmul(zz,uo),B0.shift(2)-Dz0*A0*ff.S(1,1)),
          ff.pscale(ff.pmul(f,hu),B0),ff.pscale(ff.pmul(f,ho),B0.shift(2)-Dz0*A0*ff.S(1,1)),
          ff.pscale(ff.padd(ff.pmul(uo,hu),ff.pmul(ho,uu)),Dz0.shift(1)),
          ff.pscale(ff.pmul(vv,uo),Dz0.shift(1)),ff.pscale(ff.pmul(f,vv),B0),
          neg(ff.pmul(vv,ffDer(uu)))])
        no=gg.split(rr)
        mixed.append({'first_direction':j-1,'projection':projections(no),'normal':no.tolist()})
    no0=ff.ADD[carry_no,np.array(mixed[0]['normal'],np.int16)]
    out['directions'][str(i)]={
      'fourth_digit':coef.tolist(),'fourth_affine_repair':af,
      'carry_projection':projections(carry_no),'carry_normal':carry_no.tolist(),
      'constant_projection':projections(no0),'constant_normal':no0.tolist(),
      'mixed_first_directions':mixed}
    out['seconds']=time.time()-st
    args.output.write_text(json.dumps(out,indent=2)+'\n')
    log('ordinary direction',i,'constant projections',out['directions'][str(i)]['constant_projection'])
log('completed ordinary channels',list(out['directions']))
