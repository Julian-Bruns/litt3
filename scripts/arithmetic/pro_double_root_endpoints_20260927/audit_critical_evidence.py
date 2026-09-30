"""Hash, shape and support checks for the new essential global arrays."""
import gzip,json,struct,hashlib
from exact import ROOT
from critical_certificate import run as verify_bezout

def run():
 jraw=gzip.open(ROOT/'evidence/normalized_full_jets.json.gz','rb').read()
 jm=json.loads((ROOT/'evidence/normalized_full_jets.json').read_text());jets=json.loads(jraw)
 assert hashlib.sha256(jraw).hexdigest()==jm['jets_raw_sha256']
 assert len(jets)==141 and all(len(r)==7 for r in jets)
 assert all(len(p)%9==0 and all(0<=a<390625 for a in p) for r in jets for p in r)
 assert jets[:75]==json.loads(gzip.open(ROOT/'evidence/normalized_jets.json.gz','rb').read())
 for n,r in enumerate(jets):
  for s,p in enumerate(r):
   wt=max((2*(j//9)+j%9 for j,a in enumerate(p) if a),default=-1)
   assert wt==jm['coefficient_weights'][n][s]
 assert all(not jets[0][i] for i in range(1,7))
 assert all(not jets[1][i] for i in range(1,7))
 assert all(not jets[2][i] for i in range(2,7))
 cm=json.loads((ROOT/'evidence/critical_model.json').read_text())
 for name,m in cm['outputs'].items():
  raw=gzip.open(ROOT/'evidence'/f'{name}.bin.gz','rb').read()
  assert hashlib.sha256(raw).hexdigest()==m['raw_sha256']
  sh=m['shape'];nn=1
  for n in sh:nn*=n
  assert len(raw)==4*nn
  vals=struct.unpack('<%dI'%nn,raw);weight=44 if name=='critical_delta' else 224
  for iu in range(sh[0]):
   for j in range(3):
    for x in range(sh[2]):
     for q in range(9):
      a=vals[(((iu*3+j)*sh[2]+x)*9+q)]
      assert 0<=a<390625
      if a:assert 6*iu+2*j+3*q<=weight
 verify_bezout(True)
 print('ALL NEW GLOBAL ARRAY HASHES, SHAPES, WEIGHTS AND BEZOUT IDENTITY PASSED',flush=True)
if __name__=='__main__':run()
