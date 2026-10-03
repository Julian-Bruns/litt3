#!/usr/bin/env sage
"""NEW exact m9 source leading plane; fixed tiny coefficient check only."""
import json,time
from pathlib import Path
started=time.monotonic();F=GF(25,'b',modulus=PolynomialRing(GF(5),'t')([2,4,1]));b=F.gen();R=PolynomialRing(F,'x');x=R.gen()
def code(c):return F(c%5)+F(c//5)*b
def poly(cs):return R([code(c) for c in cs])
P=poly([11,22,18,5,19,20,15,16,9,22,1]);Z=poly([15,19,24,12,10,19,3,24,18,16]);q=poly([13,18,24]);q3=poly([1,22,9,1]);ell=x+code(12)
rows=matrix(F,[[((Z*x**j)%P)[i] for j in range(4)] for i in [9,8]])
assert rows.rank()==2 and rows[0].dot_product(vector(F,ell.list()+[0,0]))==0
assert ((Z*ell)%P)[8]==b and not ((Z*ell)%P)[9]
assert matrix(F,[vector(F,g.list()+[0]*(4-len(g.list()))) for g in [q3,q,ell]]).rank()==3
assert all(not ((Z*g)%P)[9] for g in [q3,q,ell]) and all(not ((Z*g)%P)[8] for g in [q3,q])
def coords(v):return [int(c) for c in v.polynomial().list()]
out={'scope':'NEW source-only m9 leading plane: kernel of the single rem(Zdelta3,P)[9] gap has basis q3,q,ell=x+[12]; second gap detects exactly ell with value beta. No critical root or fourth moment assumed.','field_modulus':[int(c) for c in F.modulus().list()],'gap_matrix':[[coords(v) for v in row] for row in rows],'rank_both':int(rows.rank()),'rank_single':int(rows[:1].rank()),'ell':[coords(v) for v in ell.list()],'ell_remainder':[coords(v) for v in ((Z*ell)%P).list()],'complete':True,'seconds':time.monotonic()-started}
folder=Path('/Users/julian/Documents/litt3-computation-data/oct02_m9_uniform');(folder/'source_pole14_leading_plane.json').write_text(json.dumps(out,indent=2)+'\n');print('SOURCE pole14 plane ell=x+[12], rem8=beta',out['seconds'],flush=True)
