#include "sparse.hpp"
#include <set>
int main(int argc,char**argv){try{if(argc!=4){std::cerr<<"usage: build_fixed Ehat jobs output_directory\n";return 2;}initfield(nullptr);std::vector<U>P={11,22,18,5,19,20,15,16,9,22,1};initP(P);std::ifstream input(argv[1]);std::string name;Poly E=read_poly(input,name);std::ifstream jobs(argv[2]);int n;jobs>>n;std::set<U>qs;for(int i=0;i<n;i++){std::string id;U q;int d;jobs>>id>>q>>d;qs.insert(q);U c;for(int j=0;j<=d;j++)jobs>>c;}
 for(U q:qs){std::array<Poly,3>cpt;for(auto [m,c]:E.t)cpt[ky(m)].put(key(kx(m),0,kh(m),0,kmu(m)),kmul(c,kpow(q,kq(m))));for(int j=0;j<3;j++)stats("fixed_component "+std::to_string(q)+" "+std::to_string(j),cpt[j]);Poly Pq;for(int i=0;i<int(P.size());i++)if(P[i])Pq.put(key(i,0,0,0),kmul(P[i],kinv(q)));
  Poly NN=powp(cpt[0],3);NN+=Pq*powp(cpt[1],3);NN+=(Pq*Pq)*powp(cpt[2],3);NN=NN-(Pq*cpt[0]*cpt[1]*cpt[2]).scale(3);NN=NN.scale(kpow(q,-28));stats("fixed_R "+std::to_string(q),NN);
  int dx=0;for(auto [m,c]:NN.t)dx=std::max(dx,kx(m));assert(dx==140);for(auto [m,c]:NN.t)if(kx(m)==140)assert(!kmu(m));
  std::ofstream out(std::string(argv[3])+"/R_q"+std::to_string(q)+".txt");write_poly(out,"R",NN);
 }return 0;}catch(std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
