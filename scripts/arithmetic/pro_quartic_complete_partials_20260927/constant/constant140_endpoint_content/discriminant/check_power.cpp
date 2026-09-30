// Degree-140 fixtures attaining the universal seventieth-power ideal bound.
#define main discriminator_main_unused
#include "check_discriminant.cpp"
#undef main
int main(){try{ff::init();init_source();Poly j=Poly::mon(70)+Poly::mon(1)+Poly(1);
 for(int r:{1,2,5}){
 XP W=constantMu(j*j);W[0]=W[0]+Poly::mon(r);
 Poly g;for(auto& e:equations(W))g=gcd(g,e);
 if(!(g==Poly::mon(r)))throw std::runtime_error("synthetic square ideal mismatch");
 const int N=2504;if(N<=278*r)throw std::runtime_error("interpolation grid too short");
 F root=ff::pow(25,ff::ORD/N);std::vector<F>nodes(N),values(N);nodes[0]=1;
 for(int i=1;i<N;i++)nodes[i]=ff::mul(nodes[i-1],root);
 #pragma omp parallel for num_threads(4) schedule(static)
 for(int i=0;i<N;i++)values[i]=disc_at(W,nodes[i]);
 auto coeff=fft(values,ff::inv(root));for(F&c:coeff)c=ff::mul(c,ff::inv(N%5));Poly disc(coeff);
 if(!(disc==Poly::mon(70*r)))throw std::runtime_error("synthetic exact discriminant mismatch");
 std::cout<<"DEGREE140_SHARP_POWER_FIXTURE r "<<r<<" square_ideal mu^"<<r<<" discriminant mu^"<<70*r<<" interpolation_nodes "<<N<<" PASS\n";
 }
 std::cout<<"SEVENTIETH_POWER_IMPLEMENTATION_CHECKS PASS; UNIVERSAL_MEMBERSHIP_HAS_A_WRITTEN_PROOF\n";
}catch(std::exception&e){std::cerr<<"ERROR "<<e.what()<<"\n";return 1;}}
