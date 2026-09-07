#!/usr/bin/env sage
"""One-pass native Singular provenance for a complete backup atlas chart.

Optional incidence-subideal mode retains ALL twelve incidence rows and
proves their ideal is the unit ideal; its thirteenth multiplier is zero.
This is a sufficient exact certificate, not an omitted-boundary test.
Rooted-incidence mode takes coefficient fifth roots and uses bilinear
projection rows; every resulting unit identity is raised to the fifth
power and explicitly descended to the same twelve original equations.
No completed unit proof is published until all thirteen original rows
are independently reconstructed and their polynomial identity verified.
"""
import argparse,hashlib,json,os,signal,subprocess,time
from pathlib import Path


def run(tensor_path,chart,seconds,work,output,incidence_subideal,row_reduce,rooted_incidence,rooted_atlas):
    started=time.monotonic();raw=Path(tensor_path).read_bytes();data=json.loads(raw)
    prime=PolynomialRing(GF(5),'x')
    k=GF(5**data['field_degree'],name='c',modulus=prime(data['field_modulus']));c=k.gen()
    decode=lambda cs:k(prime(cs))
    names=['p'+str(i) for i in range(4)]+['b'+str(j) for j in range(chart+1,4)]+['z']
    R=PolynomialRing(k,names=names,order='degrevlex')
    pp=list(R.gens()[:4]);bb=[R.zero()]*chart+[R.one()]+list(R.gens()[4:-1]);z=R.gens()[-1]
    original=[sum(decode(data['I'][h][j])*bb[j] for j in range(4))+
        sum(decode(data['tensor'][i][j][h])*pp[i]*bb[j]**5 for i in range(4) for j in range(4)) for h in range(12)]
    norm=sum(decode(data['ell'][i][j])*pp[i]*bb[j] for i in range(4) for j in range(4))
    original.append(z*norm-1)
    assert not(rooted_incidence and rooted_atlas)
    assert not(rooted_atlas and incidence_subideal)
    rooted=rooted_incidence or rooted_atlas
    incidence_subideal=incidence_subideal or rooted_incidence
    search_names=(['v'+str(i) for i in range(4)]+names[4:-1]+(['w'] if rooted_atlas else [])) if rooted else (names[:-1] if incidence_subideal else names)
    S=PolynomialRing(k,names=search_names,order='degrevlex')
    loc=dict(zip(names,R.gens()));loc['c']=c
    search_loc=dict(zip(search_names,S.gens()));search_loc['c']=c
    parse=lambda text:S(sage_eval(text,locals=search_loc))
    if rooted:
        I=matrix(k,[[decode(co) for co in row] for row in data['I']],implementation='generic')
        pivots=list(I.transpose().pivots());assert len(pivots)==4
        selector=matrix(k,4,12,implementation='generic')
        for j,h in enumerate(pivots):selector[j,h]=1
        left=I.matrix_from_rows(pivots).inverse()*selector
        assert left*I==identity_matrix(k,4)
        projection=matrix(k,[[k(h==j)-sum(I[h,l]*left[l,j] for l in range(4)) for j in range(12)]
                             for h in range(12) if h not in pivots],implementation='generic')
        assert projection*I==0 and projection.nrows()==8
        tensor=matrix(k,[[decode(data['tensor'][i][j][h]) for i in range(4) for j in range(4)]
                         for h in range(12)],implementation='generic')
        NN=projection*tensor;SS=-left*tensor
        vv=list(S.gens()[:4]);bs=[S.zero()]*chart+[S.one()]+list(S.gens()[4:7-chart])
        root_exponent=5**(data['field_degree']-1)
        def rooted_bilinear(row):
            coefficients=[co**root_exponent for co in row]
            assert all(a**5==b for a,b in zip(coefficients,row))
            return sum((coefficients[4*i+j]*vv[i]*bs[j] for i in range(4) for j in range(4)),S.zero())
        nn=[rooted_bilinear(row) for row in NN.rows()]
        ss=[rooted_bilinear(row) for row in SS.rows()]
        base_search=nn+[ss[h]-bs[h] if h<=chart else bs[h]-ss[h]**5 for h in range(4)]
        def push_fifth(poly):
            # Replace v_i^5 by p_i and, in full mode, w^5 by z.
            return R({tuple(list(ex[:4])+[5*power for power in ex[4:7-chart]]+[ex[len(ex)-1] if rooted_atlas else 0]):co**5
                      for ex,co in S(poly).dict().items()})
        left_original=[sum((co*f for co,f in zip(row,original[:12])),R.zero()) for row in left.rows()]
        for h in range(8):
            assert push_fifth(nn[h])==sum((co*f for co,f in zip(projection.row(h),original[:12])),R.zero())
        for h in range(4):
            assert push_fifth(base_search[8+h])==(-left_original[h] if h<=chart else left_original[h]**5)
        if rooted_atlas:
            ell=matrix(k,[[decode(co) for co in row] for row in data['ell']],implementation='generic')
            root_norm=sum((ell[i,j]**root_exponent*vv[i]*ss[j] for i in range(4) for j in range(4)),S.zero())
            base_search.append(S.gens()[-1]*root_norm-1)
            norm_correction=[-z*sum((ell[i,j]*pp[i]*left[j,h] for i in range(4) for j in range(4)),R.zero())
                             for h in range(12)]
            assert push_fifth(base_search[-1])==original[-1]+sum((cc*f for cc,f in zip(norm_correction,original[:12])),R.zero())
    else:
        base_search=[S(f) for f in original[:12 if incidence_subideal else 13]]
    search=list(base_search)
    transformation=identity_matrix(k,len(search))
    if row_reduce:
        from atlas_native_rref import NativeRref
        exponents=sorted(set(ex for f in search for ex in f.dict()),key=lambda ex:(-sum(ex),tuple(ex)))
        M=matrix(k,[[f.dict().get(ex,k.zero()) for ex in exponents] for f in search],implementation='generic')
        reduced,transformation=NativeRref(k).rref(M,audit_sage=True)
        search=[S({ex:co for ex,co in zip(exponents,row) if co}) for row in reduced.rows()]
        assert search==[sum((cc*f for cc,f in zip(row,base_search)),S.zero()) for row in transformation.rows()]
    work=Path(work);work.mkdir(parents=True,exist_ok=True);target=Path(output)
    modulus=PolynomialRing(GF(5),'c')(data['field_modulus'])
    body='ring r=(5,c),(%s),dp; minpoly=%s; short=0;\n'%(','.join(S.variable_names()),modulus)
    body+='ideal I='+',\n'.join(str(f) for f in search)+';\n'
    input_hash=hashlib.sha256(body.encode()).hexdigest()
    input_path=work/'input.sing'
    if input_path.exists():assert hashlib.sha256(input_path.read_bytes()).hexdigest()==input_hash
    else:input_path.write_text(body)
    basis_path=work/'basis.txt';weights_path=work/'weights.txt';complete=work/'complete.txt'
    out={'tensor_path':str(Path(tensor_path).resolve()),'tensor_sha256':hashlib.sha256(raw).hexdigest(),
         'twist_index':data['twist_index'],'chart_first_nonzero_b':int(chart),
         'field_degree':data['field_degree'],'field_modulus':data['field_modulus'],
         'variables':names,'original_equations':[str(f) for f in original],
         'engine':'native Singular liftstd with simultaneous original-row provenance',
         'incidence_subideal':bool(incidence_subideal),'rooted_incidence':bool(rooted_incidence),
         'rooted_full_atlas':bool(rooted_atlas),
         'search_variables':search_names,'constant_row_reduction':bool(row_reduce),
         'search_rows':len(search),'input_sha256':input_hash,'status':'native_liftstd_pending'}
    print('search input',len(search),'row degrees',[f.total_degree() for f in search],
          'preparation seconds',time.monotonic()-started,flush=True)
    def checkpoint():
        out['elapsed_seconds']=time.monotonic()-started
        temporary=work/'result.json.tmp';temporary.write_text(json.dumps(out,indent=1,default=int)+'\n');temporary.replace(work/'result.json')
    if not complete.exists():
        assert not basis_path.exists() and not weights_path.exists(), 'Preserve partial solver artifacts; use a new bounded attempt directory.'
        # Parser roundtrip validates every search coefficient independently.
        roundtrip=work/'roundtrip.txt'
        if not roundtrip.exists():
            program=body+'int ii; for(ii=1;ii<=size(I);ii++){write(%s,string(I[ii]));} quit;\n'%json.dumps(str(roundtrip))
            test=subprocess.run(['Singular','-q'],input=program,text=True,capture_output=True,timeout=float(10))
            assert test.returncode==0
        assert [parse(line) for line in roundtrip.read_text().splitlines()]==search
        out['native_parser_roundtrip_verified']=True
        program=body+'option(prot); matrix T; ideal G=liftstd(I,T);\n'
        program+='int ii; for(ii=1;ii<=size(G);ii++){write(%s,string(G[ii]));}\n'%json.dumps(str(basis_path))
        program+='if(size(G)==1 && deg(G[1])==0 && G[1]!=0){for(ii=1;ii<=nrows(T);ii++){write(%s,string(T[ii,1]/G[1]));}}\n'%json.dumps(str(weights_path))
        program+='write(%s,string(size(G))+","+string(nrows(T))+","+string(ncols(T))); quit;\n'%json.dumps(str(complete))
        program_path=work/'solve.sing';program_path.write_text(program)
        stop=[]
        signal.signal(signal.SIGTERM,lambda *_:stop.append(True));signal.signal(signal.SIGINT,lambda *_:stop.append(True))
        with (work/'solver.log').open('w') as log:
            proc=subprocess.Popen(['Singular','-q',str(program_path)],stdout=log,stderr=subprocess.STDOUT)
            print('native liftstd start',data['twist_index'],chart,'pid',proc.pid,'search rows',len(search),flush=True)
            while proc.poll() is None:
                if stop or time.monotonic()-started>=seconds:
                    proc.terminate()
                    try:proc.wait(timeout=float(2))
                    except subprocess.TimeoutExpired:proc.kill();proc.wait()
                    break
                time.sleep(float(.2))
        out['solver_returncode']=proc.returncode
        if not complete.exists():
            out['status']='bounded_native_liftstd_incomplete';checkpoint()
            print(json.dumps({'status':out['status'],'elapsed_seconds':out['elapsed_seconds']}),flush=True);return
    sizes=[int(value) for value in complete.read_text().strip().split(',')]
    basis=[parse(line) for line in basis_path.read_text().splitlines()]
    assert sizes==[len(basis),len(search),len(basis)]
    out['completed_solver_seconds']=time.monotonic()-started
    out['groebner_basis']=[str(f) for f in basis];checkpoint()
    if len(basis)==1 and basis[0] and basis[0].total_degree()==0:
        weights=[parse(line) for line in weights_path.read_text().splitlines()]
        assert len(weights)==len(search)
        assert sum((h*f for h,f in zip(weights,search)),S.zero())==1
        weights=[sum((h*cc for h,cc in zip(weights,transformation.column(j))),S.zero()) for j in range(transformation.ncols())]
        assert sum((h*f for h,f in zip(weights,base_search)),S.zero())==1
        if rooted:
            fifth_weights=[push_fifth(h) for h in weights]
            lifted=[sum((fifth_weights[a]*projection[a,h] for a in range(8)),R.zero())+
                    sum((fifth_weights[8+j]*(-1 if j<=chart else left_original[j]**4)*left[j,h]
                         for j in range(4)),R.zero()) for h in range(12)]
            if rooted_atlas:
                lifted=[h+fifth_weights[-1]*cc for h,cc in zip(lifted,norm_correction)]+[fifth_weights[-1]]
            out['rooted_unit_identity_raised_and_descended_to_original_rows']=True
        else:lifted=[R(h) for h in weights]
        if incidence_subideal:lifted.append(R.zero())
        assert len(lifted)==13 and sum((h*f for h,f in zip(lifted,original)),R.zero())==1
        out.update(status='empty_chart_exact_original_equation_certificate',
                   unit_certificate_multipliers=[str(h) for h in lifted],
                   exact_unit_identity_verified_against_all13_original_rows=True)
        checkpoint();target.parent.mkdir(parents=True,exist_ok=True)
        temporary=Path(str(target)+'.tmp');temporary.write_text(json.dumps(out,indent=1,default=int)+'\n');temporary.replace(target)
    else:
        out['status']='nonunit_subideal_basis_candidate_not_an_atlas_solution';checkpoint()
    print(json.dumps({key:out[key] for key in ['twist_index','chart_first_nonzero_b','status','elapsed_seconds']},indent=1,default=int),flush=True)


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--tensor',required=True);parser.add_argument('--chart',type=int,choices=range(4),required=True)
    parser.add_argument('--seconds',type=int,default=30);parser.add_argument('--work',required=True);parser.add_argument('--output',required=True)
    parser.add_argument('--incidence-subideal',action='store_true');parser.add_argument('--row-reduce',action='store_true')
    parser.add_argument('--rooted-incidence',action='store_true',help='All projected/rooted incidence equations; exact fifth-power descent of unit identities.')
    parser.add_argument('--rooted-atlas',action='store_true',help='Root all incidence rows AND retain the inverse-norm equation, with exact original-row descent.')
    args=parser.parse_args();run(args.tensor,args.chart,args.seconds,args.work,args.output,args.incidence_subideal,args.row_reduce,args.rooted_incidence,args.rooted_atlas)
