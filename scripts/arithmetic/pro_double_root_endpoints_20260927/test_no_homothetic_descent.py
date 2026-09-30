"""Executed limitation of extending the compact leading-coefficient Frobenius factor to the whole family."""
import sys,gzip,struct,json,ctypes as ct
sys.path.insert(0,str(__import__('pathlib').Path(__file__).resolve().parent))
from exact import *
from extension import E,Poly,init
from interpolate_global import library
from fibres_u import fibre_modulus
u0=1;_,mod,_=fibre_modulus(u0);init(mod);q=E([0,1]);u=E(u0)
G=Poly(mod);Gq=Poly([E(mul(i%5,a)) for i,a in enumerate(mod) if i]).eval(q)
Gu=(2*Poly(DATA['b']).eval(q)*u+2*Poly(DATA['c']).eval(q))*E(inv(mul(3,DATA['e'][-1])))
qp=-Gu/Gq
M=7*141*9;N=133
raw=gzip.open(ROOT/'evidence/global_residual.bin.gz','rb').read();flat=struct.unpack('<%dI'%(len(raw)//4),raw)
lib=library();coefs=(ct.c_int*len(flat))(*flat);v=(ct.c_int*M)();lib.ff_evaluate_rows(coefs,N,M,u0,v)
der=(ct.c_int*((N-1)*M))(*[mul((i+1)%5,flat[(i+1)*M+j]) for i in range(N-1) for j in range(M)])
du=(ct.c_int*M)();lib.ff_evaluate_rows(der,N-1,M,u0,du)
R=[];DR=[]
for a in range(7):
 cc=[];dd=[]
 for x in range(141):
  off=(a*141+x)*9;z=E(list(v[off:off+9]));zu=E(list(du[off:off+9]))
  zq=E([mul(i%5,v[off+i]) for i in range(1,9)])
  cc.append(z);dd.append(zu+zq*qp)
 R.append(Poly(cc));DR.append(Poly(dd))
a=DR[0][140]/R[0][140]
assert not DR[6]
res=[DR[i]-R[i]*(E((1-i)%5)*a) for i in range(7)]
assert res[0] and res[0].degree()==139
out={'u_code':u0,'modulus':mod,'derivation':'delta(u)=1, delta(q)=-g_u/g_q',
     'scale_top_derivative_zero':True,'scalar_a':list(a.a),
     'defect_x_degrees':[v.degree() for v in res],
     'nonzero_coefficient_tau0_x139':list(res[0][139].a),
     'conclusion':'The complete family is not made coefficient-Frobenius by any scalar and scale rescaling over the ratio function field.'}
path=ROOT/'evidence/no_homothetic_descent.json'
if '--verify' in sys.argv:assert out==json.loads(path.read_text())
else:path.write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
