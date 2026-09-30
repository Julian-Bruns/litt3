"""Reconstruct the C++ input header from the exact problem constants."""
from genus1_boundary import *

def input_arrays():
 d=locdata();lm,zp,*_=setup_evaluator()
 return dict(KM=MOD,LM=lm,ROOTS=[as4(x) for x in d['roots']],HS=[as4(x) for x in d['h_roots']],FS=[as4(x) for x in d['f_roots']],GS=[as4(x) for x in d['g_roots']],JS=[as4(kmul(kmul(f,f),kk)) for f,kk in zip(d['f_roots'],d['K_roots'])],ZP=zp.tolist())

def header_text(arrays):
 text='// Generated exactly by make_cpp_input.py; F25 uses beta^2=beta+3.\n'
 for key,val in arrays.items():
  if isinstance(val[0],list):text+=f'static const int {key}[{len(val)}][{len(val[0])}] = '+'{'+','.join('{'+','.join(map(str,r))+'}' for r in val)+'};\n'
  else:text+=f'static const int {key}[{len(val)}] = '+'{'+','.join(map(str,val))+'};\n'
 return text

def make():
 arrays=input_arrays()
 (ROOT/'src/boundary_input.hpp').write_text(header_text(arrays))
 (ROOT/'data/boundary_input.json').write_text(json.dumps(arrays,indent=2))
 assert pow(25,4,29)==24
 print('generated exact C++ input')
if __name__=='__main__':make()
