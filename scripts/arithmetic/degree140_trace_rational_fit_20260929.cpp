// Discovery only: rational reconstruction of fixed-w trace coefficients.
// A successful finite-grid fit is not a geometric identity certificate.
#include "fast.hpp"
#include <sstream>
using namespace exact;
std::pair<Poly,Poly> reconstruct(const Poly&mod,const Poly&value,int bound){
 Poly r0=mod,r1=value,t0{},t1{1};
 while(r1.deg()>bound){auto qr=divmod(r0,r1);auto nt=t0-qr.first*t1;r0=r1;r1=qr.second;t0=t1;t1=nt;}
 if(t1.empty())throw std::runtime_error("no rational denominator");
 auto g=gcd(r1,t1);if(!g.empty()){r1=pdivide(r1,g);t1=pdivide(t1,g);}
 F lc=inv(t1.back());return {scale(r1,lc),scale(t1,lc)};
}
int main(int argc,char**argv){try{
 if(argc!=4){std::cerr<<"usage: fit FIELD_DATA TABLE TRAINING_COUNT\n";return 2;}
 loadfield(argv[1]);std::ifstream in(argv[2]);int n,ncols;in>>n>>ncols;
 std::vector<F> xs(n);std::vector<std::vector<F>> ys(n,std::vector<F>(ncols));
 for(int i=0;i<n;i++){in>>xs[i];for(auto&c:ys[i])in>>c;}
 int train=std::stoi(argv[3]);if(train>n)throw std::runtime_error("too few samples");
 std::vector<Poly> polys(ncols);Poly base{1};
 for(int i=0;i<train;i++){
  F invb=inv(eval(base,xs[i]));
  for(int j=0;j<ncols;j++){F d=mul(sub(ys[i][j],eval(polys[j],xs[i])),invb);polys[j]=polys[j]+scale(base,d);}
  base=base*Poly{neg(xs[i]),1};
 }
 std::cout<<"{\"status\":\"discovery_only\",\"training\":"<<train<<",\"total\":"<<n<<",\"coefficients\":[";
 for(int j=0;j<ncols;j++){
  auto [a,b]=reconstruct(base,polys[j],(train-1)/2);int bad=0,poles=0;
  for(int i=0;i<n;i++){F d=eval(b,xs[i]);if(!d)poles++;if(eval(a,xs[i])!=mul(d,ys[i][j]))bad++;}
  if(j)std::cout<<',';std::cout<<"{\"index\":"<<j<<",\"numerator_degree\":"<<a.deg()<<",\"denominator_degree\":"<<b.deg()<<",\"mismatches\":"<<bad<<",\"sample_poles\":"<<poles<<",\"numerator\":";jsonpoly(std::cout,a);std::cout<<",\"denominator\":";jsonpoly(std::cout,b);std::cout<<'}';
 }
 std::cout<<"]}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}}
