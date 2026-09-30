#include "source.hpp"
int main(){
 try{
 input::init();using namespace input;
 if(Q.deriv()!=P*A.pow(2))throw std::runtime_error("Q derivative");
 if((Q-B0.pow(5))%P.pow(2))throw std::runtime_error("B0 congruence");
 if((Q-L0.pow(5))%A.pow(3))throw std::runtime_error("L0 congruence");
 if(gcd(P,P.deriv()).deg()!=0||gcd(A,A.deriv()).deg()!=0||gcd(P,A).deg()!=0)throw std::runtime_error("squarefree/coprime");
 Poly product(1);for(int r:roots){if(P.eval(F::code(r)))throw std::runtime_error("wrong root");product*=x-Poly(F::code(r));}if(product!=P)throw std::runtime_error("P roots product");
 std::cout<<"input checks PASS; primitive="<<kfield::primitive<<" epsilon="<<eps<<" eta="<<eta<<" Ca="<<Ca<<" Cd="<<Cd<<"\n";
 for(int ir=0;ir<10;ir++){
  auto start=std::chrono::steady_clock::now();auto sp=reconstruct(F::code(roots[ir]));
  std::vector<std::vector<F>> tops(4,std::vector<F>(sp.dirs.size()));
  auto tt=top_coordinates(sp.base);
  for(size_t j=0;j<sp.dirs.size();j++){
   auto v=top_coordinates(sp.dirs[j]);for(int i=0;i<4;i++)tops[i][j]=v[i];
  }
  auto tr=rref(tops,sp.dirs.size());
  if(sp.basis.size()!=6||tr.piv.size()!=4)throw std::runtime_error("affine/top rank mismatch");
  auto check=[&](Source s,bool dir){auto v=top_coordinates(s);if(s.g[1].c[1][12]!=(dir?F(0):eps))throw std::runtime_error("epsilon mismatch");if(s.g[1].c[0][15]!=Ca*v[0]+Cd*v[1])throw std::runtime_error("c mismatch");};
  check(sp.base,false);for(auto d:sp.dirs)check(d,true);
  std::string fn="data/source_"+std::to_string(roots[ir])+".json";std::ofstream out(fn);
  out<<"{\"r\":"<<roots[ir]<<",\"rank\":"<<sp.rank<<",\"rows\":"<<sp.nrow<<",\"columns\":"<<sp.particular.size()<<",\"particular\":";write_vector(out,sp.particular);out<<",\"basis\":[";
  for(size_t j=0;j<sp.basis.size();j++){if(j)out<<",";write_vector(out,sp.basis[j]);}out<<"],\"G_base\":";write_source(out,sp.base);out<<",\"G_directions\":[";
  for(size_t j=0;j<sp.dirs.size();j++){if(j)out<<",";write_source(out,sp.dirs[j]);}out<<"]}\n";
  double sec=std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count();
  std::cout<<"r="<<roots[ir]<<" rows="<<sp.nrow<<" columns="<<sp.particular.size()<<" rank="<<sp.rank<<" affine_dim="<<sp.basis.size()<<" top_rank="<<tr.piv.size()<<" source checks PASS sec="<<sec<<std::endl;
 }
 }catch(const std::exception& e){std::cerr<<"FAIL "<<e.what()<<"\n";return 1;}
}
