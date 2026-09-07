#!/usr/bin/env sage
"""Full intrinsic N/R/norm tensor for one backup oper/cubic-twist orbit.

Independent of production. Twist -1 is trivial;0..3 select the four
nonzero J[3] Frobenius orbits. Together these five representatives cover
all405 oper/twist pairs. Both precision500 and600 jobs can be run as
independent exact consistency checks in a coordinated ten-process batch.
"""
import argparse
import hashlib
import json
import time
from pathlib import Path
from backup_genus_two_finish import atomic_json,finish


def build(twist,precision,output,linear_projection=False,positive_control=False):
    started=time.monotonic()
    state_path=Path(str(output)+'.state.sobj')
    if state_path.exists():
        saved=load(str(state_path))
        if (saved.get('format')==4 and saved.get('linear_projection',False)==linear_projection
            and saved['result'].get('positive_control',False)==positive_control):
            finish(state_path,output)
            return
    root=Path(__file__).resolve().parents[1]
    prepared=json.loads((root/'Research/computations/backup_genus_two_preparation.json').read_text())
    torsion=json.loads((root/'Research/computations/backup_genus_two_torsion.json').read_text())
    assert precision>=500 and twist in [-1,0,1,2,3]
    td=1 if twist==-1 else torsion['closed_points'][twist]['class_orbit_degree']
    field_degree=4 if positive_control else int(3*lcm(5,td))
    models=json.loads((root/'Research/computations/backup_genus_two_field_models.json').read_text())
    prime_poly=PolynomialRing(GF(5),'x')
    k=(GF(625,name='c',modulus='conway') if positive_control else
       GF(5**field_degree,name='c',modulus=prime_poly(models[str(field_degree)])))
    cfield=k.gen()
    R=PolynomialRing(k,'u'); u=R.gen()
    Frac=R.fraction_field()
    if positive_control:
        assert twist==-1
        beta=sorted((u**6-2).roots(multiplicities=False),key=str)[0]
        oldF=1+beta*u+beta**5*u**5;oldt=beta+1/Frac(u)
        rz=(4*oldt**4/(oldt**6+3)**2+oldt/(oldt**6+3))/u**4
        F=R(oldF/beta**5);P=R((oldF*rz-2*beta**2/oldF)/beta**5)
        assert F.is_monic() and F.is_squarefree() and P.degree()==3 and P[3]==2
        a=k.zero();b0,b1,b2=P[0],P[1],P[2]
    else:
        a=sorted((u**3+u+1).roots(multiplicities=False),key=str)[0]
        decode=lambda cs:sum((k(c)*a**j for j,c in enumerate(cs)),k.zero())
        polyk=lambda coeffs:R([decode(cs) for cs in coeffs])
        F=u*(u-1)*(u-2)*(u-3)*(u-a)
        oper=prepared['opers']
        b2=sorted(polyk(oper['separator_coefficients']).roots(multiplicities=False),key=str)[0]
        b0=polyk(oper['b0_coefficients'])(b2); b1=polyk(oper['b1_coefficients'])(b2)
        P=2*u**3+b2*u**2+b1*u+b0
    if twist>=0:
        row=torsion['closed_points'][twist]
        lam=sorted(polyk(row['lambda_factor_coefficients']).roots(multiplicities=False),key=str)[0]
        r=polyk(torsion['r_coefficients'])(lam)
        s=polyk(torsion['s_coefficients'])(lam)
        UU=u**2+r*u+s
        BB=R([polyk(cs)(lam) for cs in torsion['B_coefficients_as_polynomials_in_lambda']])
        a3=(1/lam).sqrt(); AA=a3*BB; VV=AA%UU
        assert AA**2-F==a3**2*UU**3
        assert gcd(UU,F)==1
    else:
        lam=r=s=a3=None; UU=R.one(); AA=VV=R.zero()
    print('field/oper/twist',twist,'degree',field_degree,'seconds',time.monotonic()-started,flush=True)

    def basis(n):
        return sorted([(i,j) for j in range(2) for i in range(n//2+1)
                       if 2*i+5*j<=n],key=lambda m:2*m[0]+5*m[1])
    def mul(x,y): return (x[0]*y[0]+F*x[1]*y[1],x[0]*y[1]+x[1]*y[0])
    def delta(x): return (F*x[1].derivative()+F.derivative()*x[1]/2,x[0].derivative())
    def sub(x,y): return tuple(xx-yy for xx,yy in zip(x,y))
    def poly(v,mons): return tuple(sum((coef*u**i for coef,(i,h) in zip(v,mons) if h==j),R.zero()) for j in range(2))
    def columns(images):
        degree=max(f.degree() for v in images for f in v)
        return matrix(k,[[v[j][i] for v in images] for j in range(2) for i in range(degree+1)])
    def kernel(n):
        mons=basis(n)
        polys=[poly(v,mons) for v in identity_matrix(k,len(mons)).rows()]
        images=[sub(delta(delta(x)),mul((P,R.zero()),x)) for x in polys]
        return [poly(v,mons) for v in columns(images).right_kernel().basis()]
    S14,S29=kernel(14),kernel(29)
    assert (len(S14),len(S29))==(4,10)
    f1=f2=None
    for trial in range(80):
        trial_integer=int(trial);small=k.zero();power=k.one()
        while trial_integer:
            small+=k(trial_integer%5)*power;power*=cfield;trial_integer//=5
        coeff=[(cfield+small)**i for i in range(4)]
        f=tuple(sum((coeff[i]*S14[i][j] for i in range(4)),R.zero()) for j in range(2))
        images=[sub(mul(f,delta(g)),mul(g,delta(f))) for g in S29]
        mat=columns(images); rhs=vector(k,mat.nrows()); rhs[0]=1
        try: sol=mat.solve_right(rhs)
        except ValueError: continue
        f1=f; f2=tuple(sum((sol[i]*S29[i][j] for i in range(10)),R.zero()) for j in range(2))
        break
    assert f1 is not None
    assert sub(mul(f1,delta(f2)),mul(f2,delta(f1)))==(R.one(),R.zero())
    print('horizontal frame',twist,time.monotonic()-started,flush=True)

    PS=PowerSeriesRing(k,'q',default_prec=precision); q=PS.gen()
    local_s=q**2+O(q**precision)
    fseries=1+sum(F[5-j]*local_s**j for j in range(1,6))
    for _ in range(12):
        polynomial=1+sum(F[5-j]*local_s**j for j in range(1,6))
        derivative=sum(j*F[5-j]*local_s**(j-1) for j in range(1,6))
        local_s-=(local_s-q**2*polynomial)/(1-q**2*derivative)
    assert (local_s-q**2*(1+sum(F[5-j]*local_s**j for j in range(1,6)))).valuation()>=precision
    LS=LaurentSeriesRing(k,'q',default_prec=precision); q=LS.gen()
    uu=1/LS(local_s); vv=uu**2/q; dq=vv/uu.derivative()
    assert (vv**2-F(uu)).valuation()>precision-100
    # Sage10.9's PARI finite-field Laurent exact-monomial indexing can
    # return a spurious coefficient outside support. List extraction is
    # explicit and is used consistently, including exact Cech monomials.
    def series_terms(f):
        return zip(f.exponents(),f.coefficients())
    def coeff_at(f,e):
        assert f.precision_absolute()==Infinity or e<f.precision_absolute()
        return f[e] if f and f.valuation()<=e<=f.degree() else k.zero()
    c=-coeff_at(dq,-2); assert c==3
    def series(f): return f[0](uu)+f[1](uu)*vv
    H=matrix(LS,[[series(f1),series(f2)],[series(delta(f1)),series(delta(f2))]])
    assert (H.det()-1).valuation()>precision-150
    Hi=matrix(LS,[[H[1,1],-H[0,1]],[-H[1,0],H[0,0]]])
    Top=matrix(LS,[[q,0],[dq,q**(-1)]])
    B0=Hi*q**(-5)*Top
    root_power=5**(field_degree-1)
    def car_root(f):
        last=int(f.precision_absolute())
        return sum((coef**root_power*q**(e//5) for e,coef in series_terms(f)
                    if e%5==0),LS.zero()).add_bigoh((last+4)//5)
    G0=B0.apply_map(car_root); epsilon=q**2*G0.det()
    assert epsilon.valuation()==0
    G=G0*diagonal_matrix(LS,[1/epsilon,1])
    Gi=q**2*matrix(LS,[[G[1,1],-G[0,1]],[-G[1,0],G[0,0]]])
    GK=matrix(LS,[[1,c/q],[0,q**2]])
    GKi=matrix(LS,[[1,-c/q**3],[0,q**(-2)]])
    def frob(f):
        if f.precision_absolute()==Infinity: return f**5
        last=int(f.precision_absolute())
        return sum((coef**5*q**(5*e) for e,coef in series_terms(f)),LS.zero()).add_bigoh(5*last)
    Topi=matrix(LS,[[q**(-1),0],[-dq,q]])
    cartier_change=Topi*q**5*H*G0.apply_map(frob)
    assert all(f.precision_absolute()>0 and f.valuation()>=0 for f in cartier_change.list())
    assert cartier_change.det().valuation()==0
    J=H.transpose(); Ji=Hi.transpose()
    JO=q**4*G.apply_map(frob).transpose()*J*GK
    assert min(f.valuation() for f in JO.list())>=0 and JO.det().valuation()==0
    if twist>=0:
        h=(vv-AA(uu)).add_bigoh(120)
        assert h.valuation()==-6
        JOtw=(q**2*G).apply_map(frob).transpose()*(h*J)*GK
        assert min(f.valuation() for f in JOtw.list())>=0 and JOtw.det().valuation()==0
    else: h=LS.one()
    print('local descent frame',twist,time.monotonic()-started,flush=True)

    # Only principal parts below20 are used. With poles<=80 these
    #100-term input expansions retain at least20 known terms after
    #every product. Avoid building160 monomials to precision500.
    us=uu.add_bigoh(100);vs=vv.add_bigoh(100)
    standard_reducers={2*i+5*j:us**i*vs**j for i,j in basis(80)}
    if twist>=0:
        affine_reducers={4+2*i:UU(us)*us**i for i in range(39)}
        affine_reducers.update({5+2*i:(vs-VV(us))*us**i for i in range(38)})
        gaps=[-3,-2,-1,0]
    else: affine_reducers=standard_reducers; gaps=[-3,-1]
    stats={'max_input_pole':0,'minimum_precision_margin':100000}
    class Cech:
      def __init__(self,lattice,lattice_inverse,reducers,negative_exponents):
        self.rank=lattice.nrows()
        self.upper=max(0,int(-min(f.valuation() for f in lattice_inverse.list())))
        self.pole=max(0,int(-min(f.valuation() for f in lattice.list())))
        self.reducers={pole:f.add_bigoh(self.upper) for pole,f in reducers.items()}
        self.exps=list(negative_exponents)+list(range(1,self.upper))
        # A zero exponent is already present exactly for I(-D).
        if self.upper==0: self.exps=[e for e in self.exps if e<0]
        self.sample_exps=list(range(-80,self.upper));self.scalar_reduction=None
        if linear_projection:
            scalar_space=VectorSpace(k,len(self.exps)); reductions={}
            for e in reversed(self.sample_exps):
                if e in self.exps:
                    reductions[e]=scalar_space.basis()[self.exps.index(e)]
                else:
                    reducer=self.reducers[-e];lead=coeff_at(reducer,e)
                    assert lead
                    reductions[e]=-sum((coef/lead*reductions[t] for t,coef in series_terms(reducer)
                                          if e<t<self.upper),scalar_space.zero())
            self.scalar_reduction=matrix(k,[reductions[e] for e in self.sample_exps]).transpose()
        self.ambient=VectorSpace(k,self.rank*len(self.exps))
        cols=[self.raw(lattice.column(i)*q**j) for i in range(self.rank)
              for j in range(self.upper+self.pole)]
        self.relations=self.ambient.subspace(cols)
        self.space=self.ambient.quotient(self.relations)
      def rem(self,f):
        f=LS(f)
        assert f.precision_absolute()>=self.upper and f.valuation()>=-80
        if f: stats['max_input_pole']=max(stats['max_input_pole'],-int(f.valuation()))
        if f.precision_absolute()!=Infinity:
            stats['minimum_precision_margin']=min(stats['minimum_precision_margin'],int(f.precision_absolute())-self.upper)
        f=f.add_bigoh(self.upper)
        for pole in sorted(self.reducers,reverse=True):
            if -pole>=self.upper: continue
            if -pole<f.valuation(): continue
            coef=coeff_at(f,-pole)
            if coef:
                f-=coef*self.reducers[pole]/coeff_at(self.reducers[pole],-pole)
        assert f.precision_absolute()>=self.upper
        bad=[int(e) for e,coef in series_terms(f) if e<=0 and e not in self.exps and coef]
        assert not bad, (bad,self.exps)
        return f
      def raw(self,vec):
        if not linear_projection:
            rr=[self.rem(f) for f in vec]
            return self.ambient([coeff_at(f,e) for f in rr for e in self.exps])
        answer=[]
        for f in vec:
            assert f.precision_absolute()>=self.upper and f.valuation()>=-80
            if f:stats['max_input_pole']=max(stats['max_input_pole'],-int(f.valuation()))
            if f.precision_absolute()!=Infinity:
                stats['minimum_precision_margin']=min(stats['minimum_precision_margin'],int(f.precision_absolute())-self.upper)
            sample=vector(k,[coeff_at(f,e) for e in self.sample_exps])
            answer.extend(self.scalar_reduction*sample)
        return self.ambient(answer)
      def project(self,vec): return vector(k,self.space(self.raw(vec)))
      def lift_raw(self,raw):
        n=len(self.exps)
        return vector(LS,[sum((raw[j*n+i]*q**e for i,e in enumerate(self.exps)),LS.zero()) for j in range(self.rank)])
      def lift(self,vec): return self.lift_raw(self.space.lift(self.space(vec)))
    BD=Gi.transpose()*(q**(-2) if twist>=0 else 1)
    BDi=G.transpose()*(q**2 if twist>=0 else 1)
    B=Cech(BD,BDi,affine_reducers,gaps)
    HL=BD.tensor_product(GK); HLi=BDi.tensor_product(GKi)
    HH=Cech(HL,HLi,affine_reducers,gaps)
    assert B.space.dimension()==4 and HH.space.dimension()==12
    alphas=[B.lift(v) for v in B.space.basis()]

    pi_bound=max(0,int(-min(f.valuation() for f in Gi.list())))
    n=pi_bound+(2 if twist>=0 else 4)
    if twist>=0:
        affine_ps=[us**i for i in range(n//2+1)]
        affine_ps += [(vs+VV(us))/UU(us)*us**i for i in range((n-1)//2+1)]
        p_names=['u^'+str(i) for i in range(n//2+1)]+['u^'+str(i)+'*(v+V)/U' for i in range((n-1)//2+1)]
    else:
        affine_ps=[us**i*vs**j for i,j in basis(n)]
        p_names=['u^'+str(i)+'*v^'+str(j) for i,j in basis(n)]
    candidates=[]
    for j in range(2):
        for f in affine_ps:
            row=vector(LS,[0,0]);row[j]=f;candidates.append(row)
    local=[q**(2 if twist>=0 else 4)*row*G for row in candidates]
    low=min(f.valuation() for row in local for f in row)
    Amat=matrix(k,[[coeff_at(row[j],e) for row in local] for j in range(2) for e in range(int(low),0)])
    akernel=Amat.right_kernel().basis_matrix()
    assert akernel.nrows()==4
    ps=[sum((coef*row for coef,row in zip(v,candidates)),vector(LS,[0,0])) for v in akernel.rows()]
    print('dimensions4,4,12',twist,time.monotonic()-started,flush=True)
    def flatten(mat): return vector(LS,[mat[i,j] for j in range(2) for i in range(2)])
    Imat=matrix(k,[HH.project(vector(LS,[alpha[0],0,alpha[1],0])) for alpha in alphas]).transpose()
    assert Imat.rank()==4
    # Every following projection needs only its bounded principal part.
    #100 terms leave an explicitly checked precision margin after all
    #negative valuations; do not multiply500-term series unnecessarily.
    Ji=Ji.apply_map(lambda f:f.add_bigoh(100)); hi=(1/h).add_bigoh(100)
    ps=[p.apply_map(lambda f:f.add_bigoh(100)) for p in ps]
    omega=Cech(matrix(LS,[[q**(-2)]]),matrix(LS,[[q**2]]),standard_reducers,[-3,-1])
    assert omega.space.dimension()==1
    kappaclass=omega.project(vector(LS,[c/q**3]))[0];assert kappaclass
    ell=matrix(k,[[omega.project(vector(LS,[alpha[0]*p[1]-alpha[1]*p[0]]))[0]/kappaclass for alpha in alphas] for p in ps])
    assert ell.rank()==4
    for rel in B.relations.basis():
        alpha=B.lift_raw(rel)
        assert all(not omega.project(vector(LS,[alpha[0]*p[1]-alpha[1]*p[0]])) for p in ps)
    enc=lambda value:[int(c) for c in value.polynomial().list()]
    encvec=lambda vec:[enc(value) for value in vec]
    result={'status':'local frames and cohomology checked; final contractions pending',
        'twist_index':twist,'precision':precision,'field_degree':field_degree,
        'positive_control':positive_control,'curve_F_coefficients':[enc(c) for c in F.list()],
        'field_modulus':[int(c) for c in k.modulus().list()],
        'alpha':enc(a),'oper_b':[enc(b0),enc(b1),enc(b2)],
        'twist':None if twist<0 else {'lambda':enc(lam),'U':[enc(c) for c in UU.list()],
                                    'A':[enc(c) for c in AA.list()],'V':[enc(c) for c in VV.list()]},
        'dimensions':{'A':4,'B':4,'H':12},'I':[encvec(row) for row in Imat.rows()],
        'ell':[encvec(row) for row in ell.rows()],
        'B_exponents':B.exps,'B_relations':[encvec(row) for row in B.relations.basis()],
        'alpha_basis':[encvec(B.space.lift(v)) for v in B.space.basis()],
        'p_basis_names':p_names,'p_coefficients':[encvec(row) for row in akernel.rows()],
        'H_exponents':HH.exps,'H_relations':[encvec(row) for row in HH.relations.basis()],
        'f1':[[enc(c) for c in f.list()] for f in f1],
        'f2':[[enc(c) for c in f.list()] for f in f2],
        'all_B_coboundary_generators_verified':False,'B_coboundary_dimension':int(B.relations.dimension()),
        'local_descent_J_frames_verified':True,'reduction_checks':stats,
        'equations':'I*b+sum p_i*b_j^5*tensor[i][j]=0; p^T*ell*b=1',
        'build_elapsed_seconds':time.monotonic()-started}
    def pack_series(f):
        return (int(f.valuation()) if f else 0,f.list(),None if f.precision_absolute()==Infinity else int(f.precision_absolute()))
    pack_vector=lambda v:[pack_series(f) for f in v]
    projection=matrix(k,[vector(k,HH.space(v)) for v in HH.ambient.basis()]).transpose()
    state={'format':4,'linear_projection':linear_projection,'k':k,'LS':LS,'HH_upper':HH.upper,'HH_exps':HH.exps,'HH_projection':projection,
           'HH_reducers':{pole:pack_series(f) for pole,f in HH.reducers.items()},
           'HH_scalar_reduction':HH.scalar_reduction,'HH_sample_exps':HH.sample_exps,
           'Ji':[[pack_series(f) for f in row] for row in Ji.rows()],'hi':pack_series(hi),
           'ps':[pack_vector(v) for v in ps],'alphas':[pack_vector(v) for v in alphas],
           'relation_alphas':[pack_vector(B.lift_raw(rel)) for rel in B.relations.basis()],
           'Imat':Imat,'result':result}
    state_path.parent.mkdir(parents=True,exist_ok=True)
    temporary=Path(str(state_path)+'.tmp.sobj');save(state,str(temporary),compress=False);temporary.replace(state_path)
    atomic_json(str(state_path)+'.tasks.json',{
        'state_sha256':hashlib.sha256(state_path.read_bytes()).hexdigest(),
        'state_path':str(state_path.resolve()),'tensor_blocks':0,'contiguous_relations_checked':0,
        'relation_count':len(state['relation_alphas']),'twist_index':twist,'field_degree':field_degree})
    print('exact tensor state saved',str(state_path),time.monotonic()-started,flush=True)
    finish(state_path,output)


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--twist',type=int,default=-1)
    parser.add_argument('--precision',type=int,default=500)
    parser.add_argument('--output',required=True)
    parser.add_argument('--linear-projection',action='store_true')
    parser.add_argument('--positive-control',action='store_true')
    args=parser.parse_args()
    build(args.twist,args.precision,args.output,args.linear_projection,args.positive_control)
