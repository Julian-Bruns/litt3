"""Verify retained interpolated resultant polynomials and large Bezout identities.
The --full workflow separately recomputes every Sylvester-resultant value.
"""
import json,subprocess,array,sys
from ff import ROOT

def main(index=3,sign=0):
 p=ROOT/'certificates'/f'exceptional_branch_{index}_{sign}.json';D=json.loads(p.read_text())
 text=[f"{D['N']} {D['omega']}"]
 for j in range(3):
  for x in [D['resultants'][j],D['r_valuations'][j],D['cofactor_bezout_coefficients'][j]]:
   text.append(str(x) if isinstance(x,int) else ' '.join(map(str,[len(x)]+x)))
 g=D['cofactor_gcd'];text.append(' '.join(map(str,[len(g)]+g)))
 f=ROOT/'data'/f'big_check_{index}_{sign}.txt';f.write_text('\n'.join(text)+'\n')
 valbin=ROOT/'data'/f'parametric_values_{index}_{sign}.bin';valjson=ROOT/'data'/f'parametric_values_{index}_{sign}.json'
 if valjson.exists():
  aa=array.array('i',json.loads(valjson.read_text())['pair_major_values']);valbin.write_bytes(aa.tobytes())
 elif valbin.exists():
  aa=array.array('i');aa.frombytes(valbin.read_bytes());valjson.write_text(json.dumps({'format':'pair-major exact K coefficient codes; three blocks of N entries; sample R=omega^i','N':D['N'],'omega':D['omega'],'pair_major_values':aa.tolist()},separators=(',',':'))+'\n')
 else:raise FileNotFoundError('No retained exact resultant values')
 subprocess.run([str(ROOT/'src/verify_big'),str(ROOT/'data'),str(f),str(valbin)],check=True)
 print('Verified large certificate',index,sign,flush=True)
if __name__=='__main__':main(*(map(int,sys.argv[1:])) if len(sys.argv)>1 else (3,0))
