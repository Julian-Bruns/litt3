"""Compare existing regenerated source chunks with the archived exact sample records.
No source is reconstructed by this audit: run the commands in README first.
With no arguments, check all 133 nodes. Otherwise pass the integer K codes to audit.
"""
from pathlib import Path
import sys,json,gzip,hashlib,struct
ROOT=Path(__file__).resolve().parent.parent
records=json.loads((ROOT/'evidence/global_samples.json').read_text())
expected={s['u_code']:s for s in records['samples']}
nodes=[int(v) for v in sys.argv[1:]] if len(sys.argv)>1 else sorted(expected)
for node in nodes:
 if node not in expected:raise ValueError(f'K code {node} is not an archived interpolation node')
 path=ROOT/'work/global_samples'/f'{node}.json'
 if not path.exists():raise FileNotFoundError(f'{path}: regenerate the source sample first')
 current=json.loads(path.read_text());raw=gzip.open(path.with_suffix('.bin.gz'),'rb').read()
 assert len(raw)==7*141*9*4,node
 assert hashlib.sha256(raw).hexdigest()==expected[node]['digest'],node
 for key in ['u_code','modulus','shape','digest','degrees_x']:
  assert current[key]==expected[node][key],(node,key)
 assert all(v<390625 for v in struct.unpack('<%dI'%(len(raw)//4),raw)),node
print(f'All {len(nodes)} regenerated sample chunks exactly match the archived source records and raw coefficient digests. Nodes: {nodes}',flush=True)
