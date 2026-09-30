#include "generic_kernel.hpp"
#include <random>
int main(){
 init();init_labels();K ie=K::code(22).inverse();for(auto&lab:labels)for(F&f:lab)f=f.times(ie);
 std::mt19937_64 gen(260926);auto rk=[&](){int a=gen()%q;int b=gen()%q;return K(a,b);};
 auto ix=[&](){IX a;do{for(int&v:a)v=gen()%116;std::sort(a.begin(),a.end());}while(!admissible(a));return a;};
 uint64_t generic=0,boundary=0,planted=0;
 for(int trial=0;trial<10000;++trial){IX qx=ix(),hx=ix();EP Q=ep(qx),H=ep(hx);F A=Q.E,B=Q.C,C=H.C,D=H.E,W=A*D-B*C;Generic r=first_residual(A,B,C,D,W);if(!r.nonsingular){++boundary;continue;}++generic;second_residual(r,A,B,C,D,W);auto[x,y]=moments(r);
  F v=W-A.times(x)-D.times(x.bar())+B.times(y.bar())+C.times(y)+F(K(sub(x.norm(),y.norm()),0));
  if(!v.c[1].zero()||!v.c[3].zero()||v.c[2]*K(r.den,0)!=r.Z||v.c[0]*K(mul(r.den,r.den),0)!=r.T)throw std::runtime_error("generic identities fail");
  K bet=K::code(5),one(1);std::array<F,4>cols={-A-D,-A.times(bet)-D.times(one-bet),B+C,B.times(one-bet)+C.times(bet)};Affine af=solve(cols,W);if(af.rank!=4)throw std::runtime_error("rank-four check fails");
  bool linear_expected=r.Z.zero()&&r.S.b==0;if(af.consistent!=linear_expected)throw std::runtime_error("affine consistency comparison fails");
  if(trial<16){std::cout<<"{\"kind\":\"generic_formula_sample\",\"Q\":";print_ix(qx,std::cout);std::cout<<",\"H\":";print_ix(hx,std::cout);std::cout<<",\"delta_x\":"<<r.dx<<",\"delta_y\":"<<r.dy<<",\"x\":";pk(x);std::cout<<",\"y\":";pk(y);std::cout<<",\"Z\":";pk(r.Z);std::cout<<",\"T\":";pk(r.T);std::cout<<"}\n";}
 }
 while(planted<1000){IX qx=ix();EP Q=ep(qx);F A=Q.E,B=Q.C,eps;for(K&v:eps.c)v=rk();if(eps.c[3].zero())continue;K y=(eps*B).c[3]/eps.c[3],x=rk();F D=eps*(B-F(y))+F(x),C=eps*(A-F(x.bar()))+F(y.bar());if(!D.c[3].zero())throw std::runtime_error("planted D3");F W=A*D-B*C;Generic r=first_residual(A,B,C,D,W);if(!r.nonsingular)continue;second_residual(r,A,B,C,D,W);auto[xr,yr]=moments(r);if(!r.Z.zero()||!r.T.zero()||xr!=x||yr!=y)throw std::runtime_error("planted formula failure");
  if(planted<8){std::cout<<"{\"kind\":\"synthetic_formula_sample_not_endpoint_witness\",\"Q\":";print_ix(qx,std::cout);std::cout<<",\"epsilon\":";pf(eps);std::cout<<",\"x\":";pk(x);std::cout<<",\"y\":";pk(y);std::cout<<",\"delta_x\":"<<r.dx<<",\"delta_y\":"<<r.dy<<"}\n";}
  ++planted;
 }
 std::cerr<<"{\"status\":\"PASS\",\"deterministic_endpoint_pairs\":10000,\"norm_distinct_pairs\":"<<generic<<",\"norm_boundary_pairs\":"<<boundary<<",\"synthetic_positive_formula_tests\":"<<planted<<",\"synthetic_tests_are_endpoint_witnesses\":false}\n";
}
