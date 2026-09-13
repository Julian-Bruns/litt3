"""Choose exact off-curve points that distinguish remaining covariants."""
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
import argparse,json,sys,zipfile
from pathlib import Path
import numpy as np
ap=argparse.ArgumentParser();ap.add_argument('--evidence',type=Path,required=True);ap.add_argument('--family',type=Path,required=True);ap.add_argument('--output-dir',type=Path,required=True);args=ap.parse_args()
sys.path.insert(0,str(args.evidence/'lib'));import finite_field as F
from locus import P,U,A,B,q,qi,v1,v2
root=Path(__file__).resolve().parents[3];sys.path.insert(0,str(root/'scripts'))
from scripts.deformations.rank25.rank25_pro_data_model import unpack,evaluate_fourth,ZERO
d=json.loads(args.family.read_text());args.output_dir.mkdir(parents=True,exist_ok=True)
theta0=P('3440')+q**2*(P('0343')+A*F.ff('1313')+B*F.ff('2324'))
theta0+=A**2*F.ff('2142')+A*B*F.ff('2010')+B**2*F.ff('3022')
theta0+=A**3*F.ff('0023')+A**2*B*F.ff('3122')+A*B**2*F.ff('4224')+B**3*F.ff('2132')
uc=-theta0*qi**2*F.inv(F.ff('2110'))
xs=[uc,v1+q*F.ff('4331'),v2+q*F.ff('2234'),A+'3003',B+'0314',q*F.ff('3112'),q,P(),P()]
def ev(p,a,b,c):
    out=0
    items=p.d.items() if isinstance(p,P) else ((tuple(e),v) for e,v in p)
    for e,v in items:
        assert e[0]==e[4]==e[5]==0
        term=v
        for x,n in zip([a,b,c],e[1:4]):
            term=F.mul(term,F.power(x,n) if n>=0 else F.power(F.inv(x),-n))
        out=F.add(out,term)
    return out
with zipfile.ZipFile(root/'Research/pro_inputs/rank25_all_fifth_lifts_inputs.zip') as z:fourth=unpack(json.loads(z.read('fourth.json')))
chosen=[];combined=np.zeros((0,len(d['remaining_cotangent_root_sections'])),np.uint16);rank=0
for a,b,c in [(1,0,1),(0,1,1),(1,1,1),(F.ff('0100'),1,2),(2,F.ff('0100'),3)]:
    mat=np.array([[ev(col[j],a,b,c) for col in d['remaining_cotangent_root_sections']] for j in range(3)],np.uint16)
    r=len(F.rref(np.vstack([combined,mat]),False)[1]);role='fit' if r>rank else 'independent_check'
    if role=='fit' or len(chosen)<2:
        x=[ev(p,a,b,c) for p in xs];digits=[[int(n) for n in F.D[v]] for v in x]
        assert evaluate_fourth([tuple(v) for v in digits],fourth)==[ZERO]*9
        name='point_'+str(len(chosen));record={'x':digits,'chart_coordinates':{'A':int(a),'B':int(b),'q':int(c)},'role':role,'remaining_evaluation_matrix':mat.tolist()}
        (args.output_dir/(name+'.json')).write_text(json.dumps(record,indent=2)+'\n');chosen.append({'name':name,**record})
        combined=np.vstack([combined,mat]);rank=r
    if rank==len(d['remaining_cotangent_root_sections']) and len(chosen)>=2:break
assert rank==len(d['remaining_cotangent_root_sections'])
# A genuinely different coefficient-Frobenius checkpoint, not used to fit.
a,b,c=F.ff('0100'),F.ff('0010'),F.ff('1100')
x=[ev(p,a,b,c) for p in xs];digits=[[int(n) for n in F.D[v]] for v in x]
assert evaluate_fourth([tuple(v) for v in digits],fourth)==[ZERO]*9
record={'x':digits,'chart_coordinates':{'A':int(a),'B':int(b),'q':int(c)},'role':'independent_check'}
(args.output_dir/'point_2.json').write_text(json.dumps(record,indent=2)+'\n');chosen.append({'name':'point_2',**record})
(args.output_dir/'selection.json').write_text(json.dumps({'status':'exact distinguishing point selection','rank':rank,'points':chosen},indent=2)+'\n')
print(json.dumps({'rank':rank,'points':[(p['name'],p['role'],p['chart_coordinates']) for p in chosen]},indent=2))
