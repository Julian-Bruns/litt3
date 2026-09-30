"""Validate and stream the retained compact coefficient records to a binary input."""
import gzip, json, struct, sys
from pathlib import Path
root=Path(__file__).resolve().parents[2]
out=Path(sys.argv[1]); n=0; seen=set()
with gzip.open(root/'elimination/evidence/compact.jsonl.gz','rt') as f, out.open('wb') as o:
    o.write(struct.pack('<I',89481))
    for line in f:
        j,m,h,q,x,c=json.loads(line)
        assert 0<=j<3 and 0<=m<3 and 0<=h<=12 and 0<=q<=60 and 0<=x<=46 and 0<c<390625
        key=(j,m,h,q,x);assert key not in seen;seen.add(key)
        o.write(struct.pack('<6I',j,m,h,q,x,c));n+=1
assert n==89481
print('PASS: streamed all 89481 unique compact records to',out)
