"""Seek a smaller unit certificate among exact degree-ten leading rows.

This is certificate optimization, not a repetition of the full input
construction. A subset unit certificate is sufficient; a failed subset
does not exclude a certificate using other rows.
"""
import sys,json,time
from pathlib import Path
root=Path(sys.argv[1]);start=time.time()
data=load(str(root/'trace_exact_degree10_leading_basis.sobj'))
R=data['ring'];H,q=R.gens();Psi=data['Psi'];lookup=dict(data['inputs'])
choices=[(0,2,6),(0,1,2,6),(0,2,3,6),(0,2,6,7)]
results=[]
for indices in choices:
    t=time.time(); I=R.ideal([lookup[i] for i in indices]); G=list(I.groebner_basis())
    target=None
    J=R.ideal(G)
    for degree in range(21):
        for a in range(degree+1):
            candidate=H^a*q^(degree-a)
            if not J.reduce(candidate):target=candidate;break
        if target is not None:break
    result={'rows':list(map(int,indices)), 'basis_size':len(G),
            'basis_degrees':[int(g.degree()) for g in G],
            'target':str(target),'seconds':time.time()-t}
    results.append(result);print(json.dumps(result),flush=True)
    save({'ring':R,'Psi':Psi,'inputs':[(i,lookup[i]) for i in indices],
          'ideal_basis':G,'removed_units':data['removed_units'],
          'parent':data['parent'],'degree':data['degree']},
         str(root/('trace_exact_degree10_subset_'+'_'.join(map(str,indices)))))
    (root/'trace_exact_degree10_small_lift_search.json').write_text(
        json.dumps({'scope':'subset leading-ideal optimization','results':results},indent=2)+'\n')
