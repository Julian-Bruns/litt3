"""Inspect the two completely determined transverse fifth components."""
import argparse,json,sys
from pathlib import Path
ap=argparse.ArgumentParser();ap.add_argument('--evidence',type=Path,required=True);ap.add_argument('--family',type=Path,required=True);ap.add_argument('--output',type=Path,required=True);args=ap.parse_args()
sys.path.insert(0,str(args.evidence/'lib'));import finite_field as F
from locus import P
d=json.loads(args.family.read_text())
def load(p):return P({tuple(e):int(c) for e,c in p})
def fp(p):return P({tuple(5*i for i in e):int(F.FROB[c]) for e,c in p.d.items()})
normal=list(map(load,d['known_nonFrobenius_normal_part']))
rows=[[load(p) for p in rr] for rr in d['root_cotangent_rows']]
known=[sum((fp(a)*b for a,b in zip(rr,normal)),P()) for rr in rows]
part=list(map(load,d['particular_cotangent_root_section']))
total=[a+fp(b) for a,b in zip(known,part)]
out={'status':'exact cotangent polynomials within independently audited support space; geometric conclusion needs reconstruction audit',
 'transverse_components':[[[list(e),int(c)] for e,c in sorted(p.d.items())] for p in total[:2]],
 'third_component_before_two_constants':[[list(e),int(c)] for e,c in sorted(total[2].d.items())]}
args.output.write_text(json.dumps(out,indent=2)+'\n')
for i,p in enumerate(total):print('component',i,p)
