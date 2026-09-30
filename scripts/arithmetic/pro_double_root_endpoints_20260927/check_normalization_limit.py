"""Exact counterexample to extra polynomial cancellation by Z0.
This is on the excluded F6=0 divisor, not a square witness or an exclusion.
"""
import json,gzip,time
from exact import DATA,ROOT
from extension import E,Poly,init
modulus=json.load(open(ROOT/'evidence/ratio_factorizations.json'))['zero_F_projection']['factors'][0][0]
init(modulus);q=E([0,1]);aa={k:Poly(DATA[k]).eval(q) for k in ['a0','b','c','e']}
a,b,c,e=[aa[k] for k in ['a0','b','c','e']];u=(2*b*c-3*a*e)/(2*a*c-4*b*b)
assert not b*u*u+2*c*u+3*e and not a*u*u+4*b*u+2*c
js=json.load(gzip.open(ROOT/'evidence/normalized_jets.json.gz','rt'))
records=[]
for n in range(3):
 vals=[]
 for p in js[n]:
  acc=E()
  for i in range(len(p)//9-1,-1,-1):
   acc=acc*u+Poly(p[9*i:9*i+9]).eval(q)
  vals.append(acc.a)
 records.append(vals)
 print(n,vals)

assert not any(records[0][0]) and any(records[1][0])
result={"status":"passed", "scope":"counterexample to Z0-divisibility, on the already excluded F6=0 divisor", "modulus":modulus, "q":[0,1], "u":list(u.a), "jet_values":records, "is_square_witness":False}
(ROOT/"logs/normalization_limit.json").write_text(json.dumps(result,indent=2)+"\n")
