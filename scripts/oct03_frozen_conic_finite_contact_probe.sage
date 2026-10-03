"""One bounded exact probe; no assertion about arbitrary geometric s.

At an ordinary finite C10 point assume X1,X2,q0(x1),q0(x2),P(x1),P(x2)
are nonzero and s=z(P)^3 is nonzero. Ramification index ten makes the
actual coarse tensor agree with its frozen conic through order nine.
Thus H(X2)-H(X1) has contact at least ten on X2^2=s X1^2+d(s-1),
H(X)=X^3 P(X-1)^2/(X^2+d)^11, provided kappa^3=1.

This script constructs the polynomial norm of its numerator, records
generic gcd degrees, and factors its 23 nontrivial F25 specializations.
Norm multiplicity >=10 is only a necessary gate; bad or two-branch
collisions are not silently removed. s=1, finite P-branches, X_i=0 and
arbitrary geometric s remain separate. Runtime externally limited30s.
"""
import json, time
started=time.monotonic()
k=GF(25,name='beta',modulus=GF(5)['b'].gen()**2-GF(5)['b'].gen()-3)
beta=k.gen()
def elt(n): return k(n%5)+k(n//5)*beta
Rx=PolynomialRing(k,'v');v=Rx.gen()
P=sum(elt(n)*v**i for i,n in enumerate([11,22,18,5,19,20,15,16,9,22,1]))
Pshift=P(v-1);square=Pshift**2
Even=sum(square[2*i]*v**i for i in range(11))
Odd=sum(square[2*i+1]*v**i for i in range(10))
Rs=PolynomialRing(k,'s');s=Rs.gen();Fs=Rs.fraction_field()
R=PolynomialRing(Fs,'X');X=R.gen();d=elt(23)
T=s*X**2+d*(s-1)
A=T**2*Odd(T);B=T*Even(T)
C=A-s**11*X**3*Pshift(X)**2
N=C**2-T*B**2
assert N!=0
generic={'degree_X':int(N.degree()),'gcd_with_derivative_degree':int(gcd(N,N.derivative()).degree()),
         'gcd_with_first_four_Hasse_degree':int(gcd([N]+[N.derivative(i)/factorial(i) for i in range(1,5)]).degree())}
rows=[]
for n in range(1,25):
    sv=elt(n)
    if sv==1: continue
    specialized=Rx([c(s=sv) for c in N.list()])
    fact=list(specialized.factor())
    rows.append({'s_code':n,'degree':int(specialized.degree()),
                 'maximum_geometric_root_multiplicity':max([int(e) for f,e in fact],default=0),
                 'factors_of_multiplicity_at_least_ten':[
                     {'degree':int(f.degree()),'multiplicity':int(e),'factor':str(f)}
                     for f,e in fact if e>=10]})
result={'scope':'generic norm gcd plus23 s inF25*,s!=1; no arbitrary geometric parameter decision',
        'field':'F25,beta^2=beta+3','generic':generic,'specializations':rows,
        'elapsed_seconds':time.monotonic()-started,'unresolved':[
            'arbitrary geometric s outside F25','s=1 diagonal frozen conic',
            'finite P-branch points','X1=0 orX2=0','ordinary necessary-jet implication requires separate symbolic review']}
print(json.dumps(result,indent=2))
