from ff25 import *
import pathlib,json,time
root=pathlib.Path(__file__).resolve().parents[1]
data=[int(x) for x in (root/'data/signature_resultant.txt').read_text().split()]
r=monic(data[1:]);assert len(r)-1==data[0]
P=[11,22,18,5,19,20,15,16,9,22,1];A=[1,21,14,22,13]
bad=mul(mul(P,A),derivative(A))
removed=[]
while True:
 g=gcd(r,bad)
 if len(g)==1:break
 removed.append(g);r=exactdiv(r,g)
 print('removed bad degree',len(g)-1,'remaining',len(r)-1,flush=True)
r_sf=exactdiv(r,gcd(r,derivative(r)))
print('clean degree',len(r)-1,'squarefree degree',len(r_sf)-1)
(root/'data/signature_clean.json').write_text(json.dumps({'raw_degree':data[0],'removed_bad_factors':removed,'clean':r,'squarefree':r_sf},indent=2)+'\n')
(root/'data/signature_clean.txt').write_text(str(len(r_sf)-1)+'\n'+' '.join(map(str,r_sf))+'\n')
