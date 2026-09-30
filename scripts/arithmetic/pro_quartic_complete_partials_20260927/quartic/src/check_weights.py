"""Optional corroboration of the proved bound: all 40,920 residue histograms."""
import json
from math import comb
count=0;max_mass=0
for n0 in range(30):
 for n1 in range(30-n0):
  for n2 in range(30-n0-n1):
   for n3 in range(30-n0-n1-n2):
    ns=[n0,n1,n2,n3,29-n0-n1-n2-n3]
    masses=[sum(ns[j]*((j+c)%5) for j in range(5)) for c in range(5)]
    assert sum(masses)==290 and len({r%5 for r in masses})==5
    c=min(range(5),key=lambda c:masses[c])
    assert masses[c]<=56
    if masses[c]<5:c=(c+1)%5
    mass=masses[c]
    assert 5<=mass<=56
    count+=1;max_mass=max(max_mass,mass)
assert count==comb(33,4)==40920
print(json.dumps({'status':'PASS','histograms':count,'maximum_selected_mass':max_mass,
                 'integer_lifts_used':False},indent=2))
