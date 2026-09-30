#include "fast.hpp"
#include "dft.hpp"
using namespace exact;
Poly readp(std::istream&i){int n;i>>n;Poly p(n);for(auto&x:p)i>>x;p.trim();return p;}
void checkroot(int N,F w){if(390624%N||power(w,N)!=1)throw std::runtime_error("invalid root-of-unity order");for(int q:{2,3,13,313})if(N%q==0&&power(w,N/q)==1)throw std::runtime_error("root not primitive");}
std::vector<F> evaluate_poly(const Poly&p,int N,F omega){if(p.deg()>=N)throw std::runtime_error("degree exceeds evaluation count");std::vector<F>v=p;v.resize(N);return dft(v,omega);}
int main(int argc,char**argv){try{
 if(argc!=4){std::cerr<<"verify_big FIELD_DATA CERT_TEXT VALUES.bin\n";return 2;}
 loadfield(argv[1]);std::ifstream in(argv[2]);int N;F omega;in>>N>>omega;checkroot(N,omega);
 std::array<int,3> bounds{45900,46218,46980};std::vector<Poly>P,U,S;std::vector<int>vs(3);
 for(int j=0;j<3;j++){P.push_back(readp(in));in>>vs[j];U.push_back(readp(in));if(P[j].deg()>bounds[j])throw std::runtime_error("wrong resultant degree bound");for(int i=0;i<vs[j];i++)if(P[j].coef(i))throw std::runtime_error("invalid r valuation");S.push_back(Poly(std::vector<F>(P[j].begin()+vs[j],P[j].end())));}
 Poly G=readp(in);for(int j=0;j<3;j++)if(!divmod(S[j],G).second.empty())throw std::runtime_error("reported gcd does not divide cofactor");std::vector<F>vals(3*N);std::ifstream iv(argv[3],std::ios::binary);iv.read((char*)vals.data(),4*vals.size());if(iv.gcount()!=4*(int64_t)vals.size())throw std::runtime_error("wrong value count");
 for(int j=0;j<3;j++){auto v=evaluate_poly(P[j],N,omega);for(int i=0;i<N;i++)if(v[i]!=vals[j*N+i])throw std::runtime_error("interpolation verification failed");for(int i:{0,1,17,313,N-1})if(v[i]!=eval(P[j],power(omega,i)))throw std::runtime_error("DFT versus independent Horner evaluation failed");}
 int D=G.deg();for(int j=0;j<3;j++)if(!U[j].empty())D=std::max(D,S[j].deg()+U[j].deg());
 int M=0;for(int n=D+1;n<=390624;n++)if(390624%n==0){M=n;break;}if(!M)throw std::runtime_error("Bezout polynomial degree exceeds field interpolation capability");F om=EX[390624/M];checkroot(M,om);
 std::vector<F>sum(M);for(int j=0;j<3;j++)if(!U[j].empty()){auto a=evaluate_poly(S[j],M,om),b=evaluate_poly(U[j],M,om);for(int i=0;i<M;i++)sum[i]=add(sum[i],mul(a[i],b[i]));}
 if(sum!=evaluate_poly(G,M,om))throw std::runtime_error("Bezout identity failure");
 std::cout<<"All three resultant interpolation identities verified at "<<N<<" distinct roots of unity, above degrees 45900,46218,46980.\n";
 std::cout<<"Cofactor Bezout identity verified: polynomial degree bound "<<D<<", distinct evaluation points "<<M<<", right side degree "<<G.deg()<<".\n";
 }catch(const std::exception&e){std::cerr<<"ERROR "<<e.what()<<'\n';return 1;}}
