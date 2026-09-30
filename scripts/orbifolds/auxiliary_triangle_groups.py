#!/usr/bin/env python3
"""Check two prime-to-five Galois triangle atlases, in tiny matrix groups."""
import json


def certificate(p, a, b, projective):
    identity=(1,0,0,1)
    def normalize(x):
        x=tuple(v%p for v in x)
        return min(x,tuple((-v)%p for v in x)) if projective else x
    identity=normalize(identity)
    a,b=normalize(a),normalize(b)
    def mul(x,y):
        return normalize((x[0]*y[0]+x[1]*y[2],x[0]*y[1]+x[1]*y[3],
                          x[2]*y[0]+x[3]*y[2],x[2]*y[1]+x[3]*y[3]))
    def order(x):
        y=x;n=1
        while y!=identity:y=mul(y,x);n+=1
        return n
    group={identity};queue=[identity]
    for x in queue:
        for y in (a,b):
            z=mul(x,y)
            if z not in group:group.add(z);queue.append(z)
    assert all((x[0]*x[3]-x[1]*x[2])%p==1 for x in group)
    orders=[order(a),order(b),order(mul(a,b))]
    return {'coefficient_prime':p,'projective':projective,'a':a,'b':b,
            'group_order':len(group),'inertia_orders':orders}


def main():
    answers=[certificate(3,(1,1,0,1),(1,0,1,1),False),
             certificate(7,(0,-1,1,0),(0,-1,1,1),True)]
    assert [(x['group_order'],x['inertia_orders']) for x in answers]==[
        (24,[3,3,4]),(168,[2,3,7])]
    assert all(x['group_order']%5 for x in answers)
    print(json.dumps(answers,indent=2))


if __name__=='__main__':main()
