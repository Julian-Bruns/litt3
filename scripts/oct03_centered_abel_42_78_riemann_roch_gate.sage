"""PREPARED ONLY: fixed centered Abel-class orders7/13 via RR ranks.

No execution/lease is inferred. NEW changed purpose, no Frobenius,
point counting, source enumeration, old certificate replay, or GB.
For T0=(U=0,y=y0), test 42(T0-O),78(T0-O) principal by jet maps
L(mO)->k[[U]]/(U^m), with the exact monomial basis pole3i+10j<=m.
Full column rank records a nonzero pivot minor and rules out principal.
Any rank loss remains UNRESOLVED; no principal/divisor claim from rank loss.
"""
from sage.all import *
import json,time
started=time.monotonic()
Fp=GF(5);R=PolynomialRing(Fp,'Y');Y=R.gen()
modulus=Y**6+3*Y**3+4
K=GF(5**6,name='y0',modulus=modulus);y0=K.gen()
beta=y0**3-3
assert beta**2==beta+3 and y0**3==3+beta
def elt(n):return K(n%5)+K(n//5)*beta
def code(a):
    t=K(a).polynomial().list()
    return sum(int(c)*5**i for i,c in enumerate(t))
def emit(row):
    row['elapsed_seconds']=time.monotonic()-started
    print(json.dumps(row),flush=True)
p=[elt(n) for n in [8,3,21,23,22,12,22,21,1,22,1]]
assert p[0]==y0**3
zeta=p[0]**8
assert zeta**3==1 and zeta!=1 and y0**25==zeta*y0
inv_3y02=K(2)*p[0]**(-1)*y0
assert 3*y0**2*inv_3y02==1
emit({'event':'centered_abel_rr_setup','field':'F5[y0]/(y0^6+3*y0^3+4)',
      'encoding':'sum c_i*5^i for sum c_i*y0^i,0<=i<6',
      'beta_embedding':'beta=y0^3-3','modulus_coefficients':[4,0,0,3,0,0,1],
      'center':'T0=(U=0,y=y0)','p_coefficients_F25_encoding':[8,3,21,23,22,12,22,21,1,22,1],
      'beta_encoded':code(beta),'y0_encoded':code(y0),'zeta_encoded':code(zeta),
      'scope':'fixed divisor classes42(T0-O),78(T0-O);no source enumeration'})
series=[y0];square=[y0**2]
for n in range(1,78):
    cross=sum(series[i]*series[n-i] for i in range(1,n))
    known=y0*cross+sum(series[i]*square[n-i] for i in range(1,n))
    yn=((p[n] if n<len(p) else K(0))-known)*inv_3y02
    series.append(yn);square.append(cross+2*y0*yn)
for n in range(78):
    assert sum(series[i]*square[n-i] for i in range(n+1))==(p[n] if n<len(p) else 0)
emit({'event':'centered_abel_rr_exact_series','precision':78,
      'y_series_coefficients':[code(a) for a in series],
      'y_square_series_coefficients':[code(a) for a in square],
      'identity':'y(U)^3=p(U) modulo U^78;constant y0'})
coefficient_series=[[K(1)]+[K(0)]*77,series,square]
all_pass=True
for m in [42,78]:
    basis=[(i,j) for j in range(3) for i in range((m-10*j)//3+1)]
    assert len(basis)==m-8
    M=matrix(K,m,len(basis),lambda r,c:
             coefficient_series[basis[c][1]][r-basis[c][0]] if r>=basis[c][0] else K(0))
    pivot_rows=list(M.transpose().pivots())
    row={'event':'centered_abel_rr_rank','m':m,'basis_U_i_y_j':basis,
         'rows':m,'columns':len(basis),'rank':len(pivot_rows),
         'jet_matrix_encoded':[[code(a) for a in M.row(i)] for i in range(m)],
         'pivot_rows':pivot_rows}
    if len(pivot_rows)==len(basis):
        minor=M.matrix_from_rows(pivot_rows);det=minor.det();assert det!=0
        row.update({'verdict':'PASS','pivot_minor_determinant_encoded':code(det),
                    'conclusion':str(m)+'*(T0-O) is nonprincipal'})
    else:
        all_pass=False
        row.update({'verdict':'UNRESOLVED',
                    'conclusion':'rank loss;class not excluded,no principal/existence claim'})
    emit(row)
emit({'event':'centered_abel_rr_complete','both_pass':all_pass,
      'conclusion':'6*(T0-O) has neither order7 nor13;conditional all-center sixfold branch excluded' if all_pass
      else 'one or both fixed divisor classes remain unresolved;no whole branch exclusion'})
