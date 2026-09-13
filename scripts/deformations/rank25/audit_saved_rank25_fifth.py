"""Independent Riccati and relative-quotient audit of a completed point replay.

Usage: python audit_saved_rank25_fifth.py ENGINE_DIR RUN_DIR [precision] [variant]
       [input_cut] [--checkpoint FILE.pickle.gz] [--out NEW_RECEIPT.json]
"""
import ast
import argparse
import gzip
import hashlib
import json
import math
from pathlib import Path
import pickle
import sys

parser=argparse.ArgumentParser(description=__doc__)
parser.add_argument('engine',type=Path);parser.add_argument('run_dir',type=Path)
parser.add_argument('precision',type=int,nargs='?',default=4200)
parser.add_argument('variant',type=int,nargs='?',default=0)
parser.add_argument('input_cut',type=int,nargs='?')
parser.add_argument('--checkpoint',type=Path)
parser.add_argument('--out',type=Path,help='Write a fresh receipt without replacing original evidence')
options=parser.parse_args()
engine=options.engine;run_dir=options.run_dir
workspace=options.precision;variant=options.variant;input_cut=options.input_cut
checkpoint=options.checkpoint or run_dir/f'fifth_checkpoint_{workspace}_{variant}.pickle.gz'
if options.checkpoint is None and not checkpoint.exists():
    checkpoint=run_dir/f'fifth_checkpoint_{workspace}_{variant}.pickle'
receipt_out=options.out or run_dir/f'independent_fifth_audit_{workspace}_{variant}.json'
if options.out is not None and receipt_out.exists():
    raise FileExistsError(receipt_out)
sys.path.insert(0,str(engine))
sys.argv=['audit','--precision',str(workspace),'--modulus','3125','--stage','5',
          '--frobenius-variant',str(variant),'--third-parameters',str(run_dir/'parameters.json'),
          '--work-output',str(run_dir)]
from base_setup import *
from as25 import AS,S,HH,SPHI,indices,pos,DATA,solve_hensel
DEG=len(T);OUT=run_dir
source=engine/'compute_next.py'
nodes=[n for n in ast.parse(source.read_text()).body if isinstance(n,ast.FunctionDef)]
exec(compile(ast.Module(body=nodes,type_ignores=[]),str(source),'exec'),globals())
checkpoint_hash=hashlib.sha256()
with checkpoint.open('rb') as fp:
    for block in iter(lambda:fp.read(4*1024**2),b''):checkpoint_hash.update(block)
with (gzip.open if checkpoint.suffix=='.gz' else open)(checkpoint,'rb') as fp:
    saved=pickle.load(fp)
if input_cut is not None:
    def truncate_saved(value):
        if isinstance(value,(AS,Ser)):return value.cut(input_cut)
        if isinstance(value,list):return [truncate_saved(v) for v in value]
        if isinstance(value,tuple):return tuple(truncate_saved(v) for v in value)
        if isinstance(value,dict):return {k:truncate_saved(v) for k,v in value.items()}
        return value
    saved=truncate_saved(saved)
globals().update(saved)
minusRpow=[[(-R[j])**i for i in range(5)] for j in range(2)]
translation={ab:[(pos[i,j],minusRpow[0][ab[0]-i]*minusRpow[1][ab[1]-j]*math.comb(ab[0],i)*math.comb(ab[1],j))
    for i in range(ab[0]+1) for j in range(ab[1]+1)] for ab in indices}
descending=sorted(indices,key=lambda ab:(sum(ab),ab),reverse=True)
u_powers={0:Ser(1)}
make_overlap(top)
for I2,Ib,uu in [(I2U,IU5,uU),(I2O,IO5,uO)]:
    trial=[Ib[i][1]+5*uu*Ib[i][0] for i in range(2)]
    assertzero(I2[0][1]*trial[1]-I2[1][1]*trial[0],625,40,'actual first Hodge graph through625')
bU=-af4fixed;bO=fo4fixed
lamU=5*uU+25*bU;lamO=5*uO+25*bO
N0=mm5(mm5(mi5(IO5),G4),mtau(IU5))
rr=AS(Z)*(N0[0][1]+N0[0][0]*tau(lamU)-lamO*N0[1][1]-lamO*N0[1][0]*tau(lamU))
riccati=rr.mod(625).divint(125).mod(5)
cr,_,_=split_cohom(riccati);Er=dual_eval(cr)
assert np.array_equal(Er,E5),'independent original-frame Riccati differs'
assert riccati.prec>=40,'insufficient tracked precision for independent comparison'
log('INDEPENDENT ORIGINAL-FRAME RICCATI PASS',Er.tolist())

packet=Path('/Users/julian/Documents/litt3/Research/pro_inputs/rank25_surface_fifth_inputs.zip')
import zipfile
with zipfile.ZipFile(packet) as z:finite=json.loads(z.read('surface.json'))
def fromcode(n):return ca([(n//5**i)%5 for i in range(4)])%5
def decode(tensor):
    shape=tensor['shape'];out=np.zeros(shape+[DEG],dtype=np.int64)
    view=out.reshape((-1,DEG))
    for i,c in tensor['nonzero']:view[i]=fromcode(c)
    return out
def fpow(a,n):return cp(a,n%(5**DEG-1))%5
params=json.loads((run_dir/'parameters.json').read_text())
lam=ca(params.get('lambda',[3,2,2,2]))%5
ss=ca(params['s'])%5 if 's' in params else fpow(lam,-2)
J=sum((np.array([[cm(v,cm(fpow(ss,a),fpow(lam,b)))%5 for v in row]
                 for row in decode(mat)]) for a,b,mat in finite['relative_J']),
      start=np.zeros((9,9,DEG),dtype=np.int64))%5
K=J[7:9,7:9]
det=(cm(K[0,0],K[1,1])-cm(K[0,1],K[1,0]))%5
assert np.any(det)
ki=ci(det)%5
solution=np.array([cm(ki,(cm(K[1,1],E5[7])-cm(K[0,1],E5[8]))%5)%5,
                   cm(ki,(cm(K[0,0],E5[8])-cm(K[1,0],E5[7]))%5)%5])
def rowdot(row,v):return sum((cm(a,b) for a,b in zip(row,v)),start=ca(0))%5
quot=[E5[0],(E5[4]-2*E5[3]-rowdot((J[4,7:9]-2*J[3,7:9])%5,solution))%5,
      (E5[5]-rowdot(J[5,7:9],solution))%5,(E5[6]-rowdot(J[6,7:9],solution))%5]
def rank(A):
    A=A.copy()%5;r=0
    for col in range(A.shape[1]):
        pivot=next((i for i in range(r,A.shape[0]) if np.any(A[i,col])),None)
        if pivot is None:continue
        A[[r,pivot]]=A[[pivot,r]];iv=ci(A[r,col])%5
        A[r]=[cm(v,iv)%5 for v in A[r]]
        for i in range(A.shape[0]):
            if i!=r and np.any(A[i,col]):A[i]=(A[i]-np.array([cm(A[i,col],v) for v in A[r]]))%5
        r+=1
    return r
rankJ=rank(J);rankaug=rank(np.concatenate([J,E5[:,None,:]],axis=1))
assert rankJ==5
assert (rankaug==5)==(not np.any(quot))
expected=cm(ca([3,0,4,0]),fpow((cm(fpow(lam,2),ss)-ca(1))%5,25))%5
receipt={'status':'PASS independent Riccati and actual four-residual projection',
    'checkpoint':str(checkpoint),'checkpoint_sha256':checkpoint_hash.hexdigest(),
    'coefficient_degree':DEG,'precision':workspace,'variant':variant,
    'independent_input_cut':input_cut,'independent_riccati_precision':riccati.prec,
    'lambda':lam.tolist(),'s':ss.tolist(),'E5':E5.tolist(),
    'riccati_E5':Er.tolist(),'residuals':[v.tolist() for v in quot],
    'rank_J':rankJ,'rank_augmented':rankaug,'candidate_trace_at_point':expected.tolist(),
    'candidate_trace_matches':bool(np.array_equal(quot[0],expected)),
    'rho5_certified_laurent_precision':rho5.prec,
    'checks':['actual affine first Hodge line through625','independent original-frame Riccati',
              'full relative matrix not restricted to moving surface tangent','all four quotient coordinates','augmented rank'],
    'seconds':time.time()-start}
with receipt_out.open('x' if options.out is not None else 'w') as stream:
    stream.write(json.dumps(receipt,indent=2)+'\n')
print(json.dumps(receipt,indent=2),flush=True)
