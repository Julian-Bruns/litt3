from ff25 import *
import json,pathlib
root=pathlib.Path(__file__).resolve().parents[1]
P=[11,22,18,5,19,20,15,16,9,22,1];A=[1,21,14,22,13]
p,a=Rat(P),Rat(A);ap=a.der();app=ap.der();appp=app.der();pp=p.der();ppp=pp.der()
T=a*(p*appp+Rat(2)*pp*app)**2/(p**2*app**3)
b=a*ppp/(pp*ap)+Rat(2)*a*app/(ap**2)+Rat(2)
G=ap**3*p**2
DG=G.der()/ap
D2G=DG.der()/ap
D3G=D2G.der()/ap
g1=DG/G;g2=Rat(3)*D2G/G;g3=D3G/G
z2=g2/g1**2;z3=g3/g1**3
cert={}
for name,f,m in [('critical_values_A',a,derivative(A)),('critical_Aprime',T,derivative(A)),('branch_P',b,P),('Aroot_g1',g1,A),('Aroot_z2',z2,A),('Aroot_z3',z3,A)]:
 r=ratmod(f,m);mp=minpoly_mod(r,m)
 print(name,'algebra dim',len(m)-1,'minpoly deg',len(mp)-1,'minpoly',mp,'nonzero',gcd(r,m)==[1],'squarefree',gcd(mp,derivative(mp))==[1])
 cert[name]={'modulus':m,'rational_numerator':f.a,'rational_denominator':f.b,'value_modulus':r,'minimal_polynomial':mp,'nonzero':gcd(r,m)==[1],'minpoly_squarefree':gcd(mp,derivative(mp))==[1]}
for name,m in [('P',P),('A',A),('Aprime',derivative(A))]:
 print(name,'squarefree',gcd(m,derivative(m))==[1])
print('pairwise gcds',gcd(P,A),gcd(P,derivative(A)),gcd(A,derivative(A)))
(root/'data/boundary_certificates.json').write_text(json.dumps(cert,indent=2)+'\n')

for key,expected in [('critical_values_A',3),('critical_Aprime',3),('branch_P',10),('Aroot_z3',4)]:
    assert len(cert[key]['minimal_polynomial'])-1==expected
    assert cert[key]['minpoly_squarefree']
assert cert['critical_Aprime']['nonzero'] and cert['Aroot_g1']['nonzero']
assert cert['Aroot_z2']['minimal_polynomial']==[1,1]
assert gcd(P,derivative(P))==gcd(A,derivative(A))==gcd(derivative(A),derivative(derivative(A)))==[1]
assert gcd(P,A)==gcd(P,derivative(A))==gcd(A,derivative(A))==[1]
print('All boundary and Morse conditions: PASS')
