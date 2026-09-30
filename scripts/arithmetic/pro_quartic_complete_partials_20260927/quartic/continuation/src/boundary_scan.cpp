#include "pair_kernel.hpp"
int main(int argc,char**argv){
 auto begin=std::chrono::steady_clock::now();init();init_labels();
 K ie=K::code(22).inverse();for(auto& lab:labels)for(F& f:lab)f=f.times(ie);
 std::vector<IX> reps;uint64_t normalized=0,normalized_ad=0;
 for(int j=0;j<116;++j)for(int k=j;k<116;++k)for(int l=k;l<116;++l){IX ix={0,j,k,l};++normalized;if(!admissible(ix))continue;++normalized_ad;if(canonical(ix)==ix)reps.push_back(ix);}
 std::cerr<<"{\"stage\":\"canonical_endpoints\",\"normalized\":"<<normalized<<",\"admissible\":"<<normalized_ad<<",\"representatives\":"<<reps.size()<<"}\n";
 int start=argc>1?std::stoi(argv[1]):0,stop=argc>2?std::stoi(argv[2]):reps.size();stop=std::min(stop,int(reps.size()));
 if(start<0||start>stop)throw std::runtime_error("bad representative range");
 if(argc>3){std::ofstream o(argv[3]);for(size_t i=0;i<reps.size();++i){o<<"{\"index\":"<<i<<",\"Q\":";print_ix(reps[i],o);o<<"}\n";}}
 std::vector<std::vector<uint32_t>> nc(q),ne(q);uint64_t endpoints=0;
 for(int i=0;i<116;++i)for(int j=i;j<116;++j)for(int k=j;k<116;++k)for(int l=k;l<116;++l){IX ix={i,j,k,l};if(!admissible(ix))continue;++endpoints;EP p=ep(ix);uint32_t id=pack(ix);nc[p.C.c[3].norm()].push_back(id);ne[p.E.c[1].norm()].push_back(id);}
 std::cerr<<"{\"stage\":\"norm_index\",\"admissible_endpoints\":"<<endpoints<<",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-begin).count()<<"}\n";
 uint64_t tested=0,both=0,nc_only=0,ne_only=0,consistent=0,quad=0,lower=0;
 std::array<uint64_t,5> ranks{},cranks{};
 K bet=K::code(5),one(1);
 for(int qi=start;qi<stop;++qi){IX ix=reps[qi];EP Q=ep(ix);F A=Q.E,B=Q.C;int nC=B.c[3].norm(),nE=A.c[1].norm();
  std::vector<uint32_t> hs=nc[nC];hs.insert(hs.end(),ne[nE].begin(),ne[nE].end());std::sort(hs.begin(),hs.end());hs.erase(std::unique(hs.begin(),hs.end()),hs.end());
  for(uint32_t id:hs){IX hx=unpack(id);EP H=ep(hx);F C=H.C,D=H.E;++tested;bool ce=C.c[3].norm()==nC,ee=D.c[1].norm()==nE;if(ce&&ee)++both;else if(ce)++nc_only;else if(ee)++ne_only;else throw std::runtime_error("bucket coverage error");
   std::array<F,4> cols={-A-D,-A.times(bet)-D.times(one-bet),B+C,B.times(one-bet)+C.times(bet)};F W=A*D-B*C;Affine af=solve(cols,W);++ranks[af.rank];if(!af.consistent)continue;++consistent;++cranks[af.rank];int qr=quadratic(af.p,cols,W);if(af.rank==4&&!qr)++quad;if(af.rank<4)++lower;
   std::cout<<"{\"kind\":\"boundary_linear_candidate\",\"q_index\":"<<qi<<",\"norm_c_equal\":"<<(ce?"true":"false")<<",\"norm_e_equal\":"<<(ee?"true":"false")<<",\"rank\":"<<af.rank<<",\"Q\":";print_ix(ix,std::cout);std::cout<<",\"H\":";print_ix(hx,std::cout);std::cout<<",\"particular\":";pv(af.p);std::cout<<",\"nullspace\":[";for(size_t t=0;t<af.null.size();++t){if(t)std::cout<<',';pv(af.null[t]);}std::cout<<"],\"quadric_at_particular\":"<<qr<<"}\n";
  }
  if((qi+1)%1000==0)std::cerr<<"{\"stage\":\"progress\",\"completed_representatives\":"<<qi+1<<",\"tested\":"<<tested<<"}\n";
 }
 std::cerr<<"{\"kind\":\"summary\",\"start\":"<<start<<",\"stop\":"<<stop<<",\"representatives_total\":"<<reps.size()<<",\"endpoints\":"<<endpoints<<",\"tested\":"<<tested<<",\"norm_c_only\":"<<nc_only<<",\"norm_e_only\":"<<ne_only<<",\"both_norms_equal\":"<<both<<",\"rank_counts\":[";for(int i=0;i<5;++i){if(i)std::cerr<<',';std::cerr<<ranks[i];}std::cerr<<"],\"consistent_rank_counts\":[";for(int i=0;i<5;++i){if(i)std::cerr<<',';std::cerr<<cranks[i];}std::cerr<<"],\"linear_consistent\":"<<consistent<<",\"rank4_quadric_pass\":"<<quad<<",\"consistent_lower_rank\":"<<lower<<",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-begin).count()<<"}\n";
}
