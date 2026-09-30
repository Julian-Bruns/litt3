"""Verify the new formulas and small algebra identities; NOT a solution search."""
import sys,json,time,itertools,random,platform
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'src'))
sys.path.insert(0,str(Path(__file__).parent))
from exact_fields import *
from newton_endpoints import *

def polynomial_product_of_roots(roots):
    field=roots[0].field; out=[field.one]
    for r in roots:
        q=[field.zero]*(len(out)+1)
        for i,v in enumerate(out):q[i]-=r*v;q[i+1]+=v
        out=q
    return out

def recurrence_jacobian(coeff,stop=119):
    """Jacobian with respect to descending nonleading monic coefficients."""
    field=coeff[0].field; c=[None,*list(reversed(coeff[:-1]))]
    p=[field(4)];der=[[field.zero]*4]
    for n in range(1,stop+1):
        kmax=min(n-1,4) if n<=4 else 4
        val=-field(n)*c[n] if n<=4 else field.zero
        d=[-field(n) if n==j+1 else field.zero for j in range(4)] if n<=4 else [field.zero]*4
        for k in range(1,kmax+1):
            val-=c[k]*p[n-k]
            for j in range(4):d[j]-=c[k]*der[n-k][j]+(p[n-k] if k==j+1 else field.zero)
        p.append(val);der.append(d)
    J=[[der[116+i][j]-der[i][j] for j in range(4)] for i in range(4)]
    return p,J

def determinant(a):
    a=[r[:] for r in a]; field=a[0][0].field; ans=field.one
    for j in range(len(a)):
        k=next((k for k in range(j,len(a)) if a[k][j]),None)
        if k is None:return field.zero
        if k!=j:a[j],a[k]=a[k],a[j];ans=-ans
        pivot=a[j][j];ans*=pivot
        for k in range(j+1,len(a)):
            t=a[k][j]/pivot
            for l in range(j,len(a)):a[k][l]-=t*a[j][l]
    return ans

def falling(m,k):
    ans=1
    for j in range(k):ans=ans*(m-j)%5
    return ans

def permutations_identity(weights,slots):
    """F_5 at coordinate idempotents, evaluated by its 120-term definition."""
    out=0
    for perm in itertools.permutations(range(5)):
        used=set();term=1;cycles=0
        for i in range(5):
            if i in used:continue
            cyc=[];k=i
            while k not in used:used.add(k);cyc.append(slots[k]);k=perm[k]
            cycles+=1
            term=term*weights[cyc[0]]%5 if len(set(cyc))==1 else 0
        out=(out+(-1 if (5-cycles)%2 else 1)*term)%5
    return out

start=time.monotonic()
# All Fourier/power-sum indices in the trace table.
congruences=[]
for name,entries in TABLE.items():
    m=PHASE_EXP[name]
    for j,spec in enumerate(entries):
        if spec is None:continue
        n,k=spec;got=n*pow(5,k,116)%116
        assert got%4==j and got%29==m
        congruences.append([name,j,n,k,got])
# Single-label coefficient identities in the ORIGINAL alpha tower.
c=evaluate(CODES['c'],alpha_T);e=evaluate(CODES['e'],alpha_T)
f=evaluate(CODES['f'],alpha_T);g=evaluate(CODES['g'],alpha_T)
identities=[e-embed(code(17),T)-embed(code(22),T)*c**3,
            g-embed(code(9),T)-embed(code(17),T)*e,
            f-g-embed(code(13),T)-embed(code(20),T)*c*c]
assert all(t==T.zero for t in identities)
# Deterministic boundary and interior endpoint examples.
cases=[[(0,0)]*4,[(0,0)]*3+[(1,3)],
       [(0,0),(2,0),(1,3),(3,3)],
       [(0,0),(0,0),(1,2),(3,7)],
       [(0,0),(1,0),(2,9),(3,23)],
       [(0,0),(0,1),(0,2),(0,3)],
       [(0,0),(1,4),(2,8),(3,13)],
       [(0,4),(1,4),(2,4),(3,4)]]
rng=random.Random(1160429)
for _ in range(4):cases.append([(rng.randrange(4),rng.randrange(29)) for j in range(4)])
for ix,labels in enumerate(cases):
    raw=direct_traces(labels);first=direct_first(labels)
    assert reconstruct_first(raw['C'],raw['U'])==first
    assert traces_from_first(first)==raw
    assert not any(compatibility_residuals(raw['C'],raw['U']))
    roots=[K(pow(2,i,5))*zeta**j for i,j in labels]
    assert quartic_row(first)==polynomial_product_of_roots(roots)
    assert not any(grid_residuals(first))
    if ix in [0,4]:assert decode_roots_from_quartic(first)==sorted(labels)
# All multiplicity partitions of four, in the cheap F25 subfield.
clusters=[[1,1,1,1],[1,1,1,2],[1,1,2,2],[1,1,2,3],[1,2,3,4]]
jacobians=[]
for roots in clusters:
    roots=list(map(F25,roots));poly=polynomial_product_of_roots(roots)
    p,J=recurrence_jacobian(poly)
    assert not any(p[116+i]-p[i] for i in range(4))
    det=determinant(J);assert det
    jacobians.append({'root_codes':[to_code(t) for t in roots],
                      'Jacobian_determinant_code':to_code(det)})
# Off-grid quartics and zero roots are rejected, including repeated roots.
for roots in [[F25.zero]*4,[beta]*4,[F25.one,beta,F25(2),F25(3)]]:
    first=[sum((r**n for r in roots),F25.zero) for n in range(1,5)]
    p=power_sums(first,119);assert any(p[116+j]-p[j] for j in range(4))
# Canonical multiplicity aliasing: degree-four trace identity, not rank alone.
bad_weights=[4,4,1];slots=[0,0,0,0,1]
assert permutations_identity(bad_weights,slots)==1
profile_checks=0;rejected=0;accepted=0
for weights in itertools.product(range(5),repeat=5):
    if sum(weights)%5!=4:continue
    profile_checks+=1
    if sum(weights)==4:
        accepted+=1
        # Any allocation of five slots must exceed some multiplicity.
        for cuts in itertools.combinations(range(9),4):
            # all weak five-part compositions of five
            cuts=(-1,*cuts,9)
            ks=[cuts[i+1]-cuts[i]-1 for i in range(5)]
            assert sum(ks)==5
            value=1
            for m,k in zip(weights,ks):value=value*falling(m,k)%5
            assert value==0
    else:
        rejected+=1;left=5;ks=[]
        for m in weights:k=min(m,left);ks.append(k);left-=k
        assert left==0
        value=1
        for m,k in zip(weights,ks):value=value*falling(m,k)%5
        assert value!=0
out={'status':'PASS','classification':'formula and proof corroboration, NOT endpoint-pair search',
     'python':platform.python_version(),'trace_table_congruences':congruences,
     'coefficient_identity_remainders':[encode(t) for t in identities],
     'endpoint_examples':len(cases),'endpoint_example_labels':cases,
     'repeated_root_Jacobians':jacobians,'off_grid_quartics_rejected':3,
     'polarized_identity_bad_profile_value':1,
     'five_idempotent_profiles_checked':profile_checks,'mass_four_profiles':accepted,
     'higher_mass_aliases_rejected':rejected,'seconds':time.monotonic()-start}
print(json.dumps(out,indent=2))
