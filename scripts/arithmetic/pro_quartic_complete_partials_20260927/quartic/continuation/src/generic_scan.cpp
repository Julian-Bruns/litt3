#include "generic_kernel.hpp"
#include <string>
int main(int argc,char**argv){
 if(argc<3){std::cerr<<"usage: generic_scan canonical_Q_index canonical_Q_index_stop [two-label|two-phase|all]\n";return 2;}
 int start=std::stoi(argv[1]),stop=std::stoi(argv[2]);std::string mode=argc>3?argv[3]:"two-label";
 if(mode!="two-label"&&mode!="two-phase"&&mode!="all")throw std::runtime_error("bad mode");
 auto begin=std::chrono::steady_clock::now();init();init_labels();K eta=K::code(22),ie=eta.inverse();
 for(auto& lab:labels)for(F& f:lab)f=f.times(ie);
 std::vector<IX> reps;
 for(int j=0;j<116;++j)for(int k=j;k<116;++k)for(int l=k;l<116;++l){IX ix={0,j,k,l};if(admissible(ix)&&canonical(ix)==ix)reps.push_back(ix);}
 if(start<0||stop>int(reps.size())||start>stop)throw std::runtime_error("bad range");
 for(int qi=start;qi<stop;++qi){IX ix=reps[qi];std::set<int> types,phases;for(int v:ix){types.insert(v);phases.insert(v/4);}if(mode=="two-label"&&types.size()!=2)continue;if(mode=="two-phase"&&phases.size()!=2)continue;
  EP Q=ep(ix);F A=Q.E,B=Q.C;std::array<F,116> ws;for(int i=0;i<116;++i)ws[i]=A*labels[i][1]-B*labels[i][0];
  uint64_t total=0,ad=0,boundary=0,generic=0,zpass=0,tpass=0,eq3pass=0,eq4pass=0;
  auto qb=std::chrono::steady_clock::now();
  for(int i=0;i<116;++i)for(int j=i;j<116;++j){F Cij=labels[i][0]+labels[j][0],Dij=labels[i][1]+labels[j][1],Wij=ws[i]+ws[j];
   for(int k=j;k<116;++k){F Cijk=Cij+labels[k][0],Dijk=Dij+labels[k][1],Wijk=Wij+ws[k];
    for(int l=k;l<116;++l){IX hx={i,j,k,l};++total;if(!admissible(hx))continue;++ad;
     F C=Cijk+labels[l][0],D=Dijk+labels[l][1],W=Wijk+ws[l];Generic r=first_residual(A,B,C,D,W);if(!r.nonsingular){++boundary;continue;}++generic;if(!r.Z.zero())continue;++zpass;second_residual(r,A,B,C,D,W);auto [x,y]=moments(r);
     F eq6=W-A.times(x)-D.times(x.bar())+B.times(y.bar())+C.times(y)+F(K(sub(x.norm(),y.norm()),0));
     if(!eq6.c[1].zero()||!eq6.c[2].zero()||!eq6.c[3].zero()||eq6.c[0]*K(mul(r.den,r.den),0)!=r.T)throw std::runtime_error("residual replay failure");
     std::cout<<"{\"kind\":\"generic_Z_candidate\",\"q_index\":"<<qi<<",\"Q\":";print_ix(ix,std::cout);std::cout<<",\"H\":";print_ix(hx,std::cout);std::cout<<",\"delta_x\":"<<r.dx<<",\"delta_y\":"<<r.dy<<",\"x\":";pk(x);std::cout<<",\"y\":";pk(y);std::cout<<",\"T\":";pk(r.T);std::cout<<",\"equation6_residual\":";pk(eq6.c[0]);std::cout<<"}\n";
     if(!r.T.zero())continue;
     ++tpass;F eps=(D-F(x))/(B-F(y));if(eps*(A-F(x.bar()))!=C-F(y.bar()))throw std::runtime_error("first-two recovery");
     auto Qs=endpoint(ix),Hs=endpoint(hx);F eq3=eps*(Qs[2]-F(x.frob(4)))+Qs[3]+F(y.bar().frob(1));
     if(!eq3.zero())continue;
     ++eq3pass;F eq4=Hs[2]+eps*(Hs[3]+F(y.frob(1)))-F(x.bar().frob(4));if(!eq4.zero())continue;
     ++eq4pass;
     std::cout<<"{\"kind\":\"full_four_trace_candidate\",\"q_index\":"<<qi<<",\"Q\":";print_ix(ix,std::cout);std::cout<<",\"H\":";print_ix(hx,std::cout);std::cout<<",\"x\":";pk(x);std::cout<<",\"y\":";pk(y);std::cout<<",\"epsilon\":";pf(eps);std::cout<<"}\n";
    }
   }
  }
  std::cerr<<"{\"kind\":\"generic_summary\",\"mode\":\""<<mode<<"\",\"q_index\":"<<qi<<",\"Q\":";print_ix(ix,std::cerr);std::cerr<<",\"total\":"<<total<<",\"admissible\":"<<ad<<",\"norm_boundary_skipped\":"<<boundary<<",\"generic_tested\":"<<generic<<",\"Z_pass\":"<<zpass<<",\"T_pass\":"<<tpass<<",\"eq3_pass\":"<<eq3pass<<",\"eq4_pass\":"<<eq4pass<<",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-qb).count()<<"}\n";
 }
 std::cerr<<"{\"kind\":\"completed\",\"start\":"<<start<<",\"stop\":"<<stop<<",\"mode\":\""<<mode<<"\",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-begin).count()<<"}\n";
}
