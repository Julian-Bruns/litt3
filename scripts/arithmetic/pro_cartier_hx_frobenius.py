# Imported from the user-supplied Pro certificate, 23 September 2026.
# Original bytes and provenance are retained in litt3-computation-data.
"""Exact certificate for the first Frobenius pullback of H_X.

Requires Python 3 and NumPy. Run:
    python cartier_HX_frobenius_certificate.py

Field codes: [n0+5*n1] = n0+n1*a, a^2=a+3 over F_5.
All polynomial lists are in ascending order.

The geometric bundle model is explained in the accompanying answer.
This script certifies polynomial identities, matrix ranks, and the
nowhere-vanishing section of F_abs^*H_X(-118 O). It does NOT decide
the existence of the original etale correspondence.

Absolute Frobenius is used only in this computation: coefficients AND
coordinates are raised to the fifth power. No untransported relative
twists are identified.
"""

# Exact arithmetic for F_25 = F_5[a]/(a^2-a-3).
p = 5
def fadd(x,y): return ((x%5+y%5)%5) + 5*((x//5+y//5)%5)
def fneg(x): return ((-x%5)%5)+5*((-(x//5))%5)
def fsub(x,y): return fadd(x,fneg(y))
def fmul(x,y):
    a,b=x%5,x//5; c,d=y%5,y//5
    return (a*c+3*b*d)%5 + 5*((a*d+b*c+b*d)%5)
def fpow(x,n):
    r=1
    while n:
        if n&1:r=fmul(r,x)
        x=fmul(x,x);n//=2
    return r
def finv(x):
    if x==0:raise ZeroDivisionError
    return fpow(x,23)
def trim(a):
    a=list(a)
    while a and a[-1]==0:a.pop()
    return a
def padd(a,b):
    return trim([fadd(a[i] if i<len(a) else 0,b[i] if i<len(b) else 0)
                 for i in range(max(len(a),len(b)))])
def pneg(a):return [fneg(x) for x in a]
def psub(a,b):return padd(a,pneg(b))
def pscale(a,c):return trim([fmul(x,c) for x in a])
def pmul(a,b):
    r=[0]*(len(a)+len(b)-1) if a and b else []
    for i,x in enumerate(a):
        for j,y in enumerate(b):
            r[i+j]=fadd(r[i+j],fmul(x,y))
    return trim(r)
def pdivmod(a,b):
    a=trim(a);b=trim(b);q=[0]*max(0,(len(a)-len(b)+1))
    while a and len(a)>=len(b):
        i=len(a)-len(b);c=fmul(a[-1],finv(b[-1]));q[i]=c
        for j,v in enumerate(b):a[i+j]=fsub(a[i+j],fmul(c,v))
        a=trim(a)
    return trim(q),a
def pmonic(a):return pscale(a,finv(a[-1])) if a else []
def pgcd(a,b):
    while b:a,b=b,pdivmod(a,b)[1]
    return pmonic(a)
def ppow(a,n):
    r=[1]
    while n:
        if n&1:r=pmul(r,a)
        a=pmul(a,a);n//=2
    return r
def pder(a):return trim([fmul(i%5,a[i]) for i in range(1,len(a))])
P=[11,22,18,5,19,20,15,16,9,22,1]
q0=[24,2,1];q1=[5,16,0,1];q2=[5,20,0,0,8,1]
qs=[q0,q1,q2]

def pdet3(M):
    s=[]
    for pmt,sgn in [((0,1,2),1),((1,2,0),1),((2,0,1),1),
                    ((0,2,1),-1),((2,1,0),-1),((1,0,2),-1)]:
        v=pmul(pmul(M[0][pmt[0]],M[1][pmt[1]]),M[2][pmt[2]])
        s=padd(s,v) if sgn==1 else psub(s,v)
    return s

# Polynomial extended Euclid and an etale-root lift modulo powers of P.
def pxgcd(a,b):
    r0,r1=trim(a),trim(b); s0,s1=[1],[];t0,t1=[],[1]
    while r1:
        quo,rem=pdivmod(r0,r1)
        r0,r1=r1,rem
        s0,s1=s1,psub(s0,pmul(quo,s1))
        t0,t1=t1,psub(t0,pmul(quo,t1))
    c=finv(r0[-1])
    return pscale(r0,c),pscale(s0,c),pscale(t0,c)
def pmod(a,m):return pdivmod(a,m)[1]
def pinvmod(a,m):
    g,s,t=pxgcd(a,m)
    assert g==[1]
    return pmod(s,m)
def pcomposemod(a,b,m):
    s=[]
    for c in reversed(a): s=padd(pmod(pmul(s,b),m),[c])
    return pmod(s,m)
def ppowerchar(a, power=5):
    out=[0]*((len(a)-1)*power+1) if a else []
    for i,c in enumerate(a):out[i*power]=fpow(c,power)
    return trim(out)

# btilde is a root of P and equals x modulo P, modulo P^m.
def rootlift(m):
    mod=ppow(P,m)
    b=[0,1]
    # Newton doubling by iteration, always reduced modulo final modulus
    for _ in range((m-1).bit_length()+1):
        e=pcomposemod(P,b,mod)
        if not e: break
        der=pcomposemod(pder(P),b,mod)
        b=pmod(psub(b,pmul(e,pinvmod(der,mod))),mod)
    assert not pcomposemod(P,b,mod)
    return b,mod
b2,mod2=rootlift(2)

import numpy as np, time
ADD=np.array([[fadd(a,b) for b in range(25)] for a in range(25)],dtype=np.uint8)
SUB=np.array([[fsub(a,b) for b in range(25)] for a in range(25)],dtype=np.uint8)
MUL=np.array([[fmul(a,b) for b in range(25)] for a in range(25)],dtype=np.uint8)
INV=np.array([0]+[finv(a) for a in range(1,25)],dtype=np.uint8)
def rank25(M, with_kernel=False):
    M=np.array(M,dtype=np.uint8,copy=True)
    rows,cols=M.shape
    piv=[];r=0
    for c in range(cols):
        v=np.flatnonzero(M[r:,c])
        if len(v)==0:continue
        k=r+int(v[0])
        if k!=r:M[[r,k]]=M[[k,r]]
        M[r]=MUL[M[r],INV[M[r,c]]]
        ix=np.flatnonzero(M[:,c]) if with_kernel else np.flatnonzero(M[r+1:,c])+r+1
        ix=ix[ix!=r]
        if len(ix):
            M[ix]=SUB[M[ix],MUL[M[ix,c,None],M[r,None,:]]]
        piv.append(c);r+=1
        if r==rows:break
    if not with_kernel:return r
    free=[c for c in range(cols) if c not in set(piv)]
    K=[]
    for f in free:
        v=np.zeros(cols,dtype=np.uint8);v[f]=1
        for rr,c in enumerate(piv):v[c]=SUB[0,M[rr,f]]
        K.append(v)
    return r,K

q5=[ppowerchar(q) for q in qs]
qp5=[ppowerchar(pder(q)) for q in qs]
qhat5_raw=[ppowerchar(pcomposemod(q,b2,mod2)) for q in qs]
qphat5_raw=[ppowerchar(pcomposemod(pder(q),b2,mod2)) for q in qs]
def hf_matrix(n,j):
    # c_i = y^j a_i(x)/y^25. F*H(-n O).
    bounds=[(250+offset-n-10*j)//3 for offset in [50,25,0]]
    m=(25-j+2)//3 # ceil((25-j)/3)
    mod=ppow(P,m);mdeg=len(mod)-1
    qs5hat=[pmod(q,mod) for q in qhat5_raw]
    qps5hat=[pmod(q,mod) for q in qphat5_raw]
    # rows for the exact syzygy plus two rootwise congruences.
    exactlen=max(bounds[i]+len(q5[i]) for i in range(3))
    columns=[]
    labels=[]
    for i in range(3):
        for e in range(bounds[i]+1):
            col=np.zeros(exactlen+2*mdeg,dtype=np.uint8)
            col[e:e+len(q5[i])]=q5[i]
            for block,v in enumerate([qs5hat[i],qps5hat[i]]):
                w=pmod([0]*e+v,mod)
                col[exactlen+block*mdeg:exactlen+block*mdeg+len(w)]=w
            columns.append(col);labels.append((i,e))
    return np.array(columns,dtype=np.uint8).T,labels,bounds,m


def main() -> None:
    # Saturation check at the ten cubic branch points:
    # q, q', q'' have nonzero determinant at every root of P.
    wronskian = pdet3([
        qs, [pder(q) for q in qs],
        [pder(pder(q)) for q in qs]
    ])
    assert pgcd(P, pder(P)) == [1]
    assert pgcd(P, wronskian) == [1]

    report = []
    expected_dimensions = {126: 0, 123: 0, 120: 0, 119: 0, 118: 1}
    for n, expected in expected_dimensions.items():
        blocks = []
        dimension = 0
        for j in range(3):
            matrix, labels, bounds, exponent = hf_matrix(n, j)
            rank = rank25(matrix)
            dimension += matrix.shape[1] - rank
            blocks.append({
                "j": j, "rows": matrix.shape[0],
                "columns": matrix.shape[1], "rank": rank
            })
        assert dimension == expected
        report.append({"n": n, "h0": dimension, "blocks": blocks})
        print(f"n={n}: h0={dimension}; "
              + ", ".join(f"j={b['j']}: {b['rows']}x{b['columns']}, "
                          f"rank {b['rank']}" for b in blocks))

    matrix, labels, bounds, exponent = hf_matrix(118, 1)
    rank, kernel = rank25(matrix, with_kernel=True)
    assert len(kernel) == 1
    numerator = [[0] * (bound + 1) for bound in bounds]
    for coefficient, (i, e) in zip(kernel[0], labels):
        numerator[i][e] = int(coefficient)
    numerator = [trim(a) for a in numerator]

    # The section is c_i = a_i/P^8.
    syzygy = []
    for a, q in zip(numerator, q5):
        syzygy = padd(syzygy, pmul(a, q))
    assert not syzygy
    assert [len(a) - 1 for a in numerator] == [55, 49, 40]

    # No zero away from the cubic branch points and infinity.
    assert pgcd(pgcd(numerator[0], numerator[1]), numerator[2]) == [1]

    # Branch-point regularity is already encoded by the j=1 matrix.
    # To check nonvanishing, inspect the next rootwise coefficient.
    # The two residuals are computed modulo P^9, then divided by P^8.
    modulus = ppow(P, 9)
    denominator = ppow(P, 8)
    residuals = []
    for raw in [qhat5_raw, qphat5_raw]:
        pairing = []
        for a, q in zip(numerator, raw):
            pairing = padd(pairing, pmul(a, pmod(q, modulus)))
        remainder = pmod(pairing, modulus)
        quotient, error = pdivmod(remainder, denominator)
        assert not error
        residuals.append(quotient)
    assert residuals == [[], [13, 5, 20, 0, 23, 14, 0, 18, 4]]
    assert pgcd(pgcd(residuals[0], residuals[1]), P) == [1]

    # Orders of the three coefficients in the infinity lattice,
    # before twisting down by 118 O.
    infinity_orders = [
        290 - 3 * (len(numerator[0]) - 1),
        265 - 3 * (len(numerator[1]) - 1),
        240 - 3 * (len(numerator[2]) - 1)
    ]
    assert infinity_orders == [125, 118, 120]
    assert min(infinity_orders) == 118

    print("The section of F_abs^*H_X(-118 O) is nowhere vanishing.")
    print("Certified exact sequence: O(118 O) -> F_abs^*H_X -> O(127 O).")
    print("No conclusion about the existence of the etale diagram is asserted.")

    import json
    from pathlib import Path
    destination = (Path(__file__).resolve().parents[3] / "litt3-computation-data" / "radical_orbit_replies_20260923" / "executed" / "cartier_HX_frobenius_certificate.json")
    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.write_text(json.dumps({
        "field": "F_5[a]/(a^2-a-3)",
        "P": P, "q": qs,
        "wronskian": wronskian,
        "rank_report": report,
        "section": {
            "description": "c_i=a_i/P^8 in the pulled-back q-frame",
            "numerators": numerator,
            "branch_residuals": residuals,
            "infinity_orders_before_twist": infinity_orders
        },
        "scope": "First Frobenius bundle calculation, not a decision of case (A)."
    }, indent=2) + "\n", encoding="utf-8")

if __name__ == "__main__":
    main()
