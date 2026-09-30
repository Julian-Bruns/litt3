"""Exact Hom(F^2 R_v,K) reconstruction for u=0, v=y^2(x^-6+[18]x^-4)."""
import json,time
import numpy as np
import period_two as p
ff=p.ff

def scale(f,c):return {m:ff.multiply(v,c) for m,v in f.items() if v and c}
def negative(f):return {m:ff.negative(v) for m,v in f.items()}
def positive(f):return {m:v for m,v in f.items() if m[0]>=0}
def monomial(m):return {tuple(m):1}

def construct_hom(v):
 e={(-i,2):c for i,c in enumerate(ff.C_COEFFICIENTS,1)}
 eq=p.frobenius(e,25);vq=p.frobenius(v,25)
 # Independent choices in f10, f11, and top h00,h01.
 free=[(name,m) for name,d in [('f10',31),('f11',131),('h00',20),('h01',120)] for m in p.section_monomials(d)]
 row0=p.cech_monomials(-155);row1=p.cech_monomials(-144)
 cols=[];t=time.time()
 for j,(name,mon) in enumerate(free):
  f10=monomial(mon) if name=='f10' else {}; f11=monomial(mon) if name=='f11' else {}
  ef10=p.multiply_functions(e,f10);ef11=p.multiply_functions(e,f11)
  f00=positive(ef10);f01=positive(ef11)
  if name=='h00':f00=p.add_functions(f00,monomial(mon))
  if name=='h01':f01=p.add_functions(f01,monomial(mon))
  t12=p.add_functions(p.multiply_functions(vq,f10),p.multiply_functions(eq,f11))
  f12=negative(positive(t12))
  g12=p.add_functions(f12,t12)
  t02=p.add_functions(p.add_functions(p.multiply_functions(vq,f00),p.multiply_functions(eq,f01)),negative(p.multiply_functions(e,g12)))
  cols.append([t02.get(m,0) for m in row0]+[t12.get(m,0) for m in row1])
  if j%50==0:print('column',j,'/',len(free),'seconds',round(time.time()-t,2),flush=True)
 A=np.array(cols,dtype=np.uint8).T
 return A,free,row0,row1
if __name__=='__main__':
 v={(-6,2):1,(-4,2):18}
 A,free,row0,row1=construct_hom(v)
 r,ker,piv=p.rref_nullspace(A)
 print('matrix',A.shape,'rank',r,'kernel dimension',ker.shape[1])
 rank2,_,rows=p.rref_nullspace(A.T)
 det=p.determinant(A[np.ix_(rows,piv)])
 print('minor determinant',det)
 np.savez_compressed(p.HERE/'hom_test_data.npz',matrix=A,kernel=ker,rows=np.array(rows),columns=np.array(piv),free=np.array([[['f10','f11','h00','h01'].index(name),*m] for name,m in free]),row0=np.array(row0),row1=np.array(row1))
 (p.HERE/'hom_test_certificate.json').write_text(json.dumps({'bundle':'u=0, v=y^2(x^-6+[18]x^-4)','Hom':'Hom(F_abs^{2*} R_v,K)','shape':list(A.shape),'rank':r,'dimension':int(ker.shape[1]),'minor_determinant':det,'minor_rows_zero_based':rows,'minor_columns_zero_based':piv},indent=2)+'\n')
