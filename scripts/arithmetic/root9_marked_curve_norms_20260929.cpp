// Exact norms of the first raw square tails on the marked-content curve.
// Fraction-free determinants clear ONLY the original q,D0 denominators.
#define ROOT9_MARKED_NO_MAIN
#include "root9_marked_function_field_20260929.cpp"
#include "pro_companion140_20260928/src/native/halfgcd.hpp"

static FP det_bareiss(std::vector<std::vector<FP>>a){int n=a.size();FP prev(1);F sign(1);for(int k=0;k<n-1;k++){
 int row=k;while(row<n&&!a[row][k])row++;if(row==n)return FP();if(row!=k){std::swap(a[row],a[k]);sign=-sign;}
 FP pivot=a[k][k];
 #pragma omp parallel for schedule(dynamic)
 for(int i=k+1;i<n;i++)for(int j=k+1;j<n;j++)a[i][j]=exact_fast(pivot*a[i][j]-a[i][k]*a[k][j],prev);
 for(int i=k+1;i<n;i++)a[i][k]=FP();prev=std::move(pivot);
 std::cout<<"{\"Bareiss_step\":"<<k<<",\"pivot_degree\":"<<prev.deg()<<"}"<<std::endl;
 }return a[n-1][n-1].scale(sign);}
int main(int argc,char**argv){try{
 if(argc<5)throw std::runtime_error("usage source-root marked_curve.json tails.json output-prefix");
 init(argv[1]);ptree data,tailsdata;boost::property_tree::read_json(argv[2],data);boost::property_tree::read_json(argv[3],tailsdata);
 FP qpoly(std::vector<F>{0,1}),d0=frow(SOURCE.get_child("D0_q"));Rat::setup(FP(0),{qpoly,d0,qpoly,qpoly,qpoly});
 std::array<Rat,6>mod;int i=0;for(auto&[k,r]:data.get_child("J_monic_H")){if(i<6)mod[i]=readrat(r);i++;}MR::setup(mod);
 std::vector<FP>norms;std::ofstream out(std::string(argv[4])+".json");out<<"{\"tail_norms\":[";int index=71;
 for(auto&[k,row]:tailsdata.get_child("tails")){
  MR v;i=0;for(auto&[j,c]:row)v.c[i++]=ratrow(c);assert(i==6);v.normalize();
  std::vector<std::vector<Rat>>ar(6,std::vector<Rat>(6));for(int j=0;j<6;j++){MR z=v*MR::powers[j];for(int i=0;i<6;i++)ar[i][j]=z.c[i].normalized();}
  std::vector<std::vector<FP>>mat(6,std::vector<FP>(6));std::array<int,5>total{};
  for(int i=0;i<6;i++){std::array<int,5>den{};for(int j=0;j<6;j++)for(int k=0;k<5;k++)den[k]=std::max(den[k],ar[i][j].den[k]);for(int k=0;k<5;k++)total[k]+=den[k];
   for(int j=0;j<6;j++){Rat z=ar[i][j];std::array<int,5>extra;for(int k=0;k<5;k++)extra[k]=den[k]-z.den[k];z.multiply_factors(extra);mat[i][j]=z.a;}
  }
  auto st=std::chrono::steady_clock::now();FP det=det_bareiss(mat);std::array<int,5>removed{};
  for(int k=0;k<2;k++){auto [n,d]=remove_frobenius(det,Rat::factors[k]);removed[k]=n;det=std::move(d);}if(!det)throw std::runtime_error("identically zero tail norm");
  if(index>71)out<<',';out<<"{\"tail\":"<<index<<",\"matrix\":[";for(int i=0;i<6;i++){if(i)out<<',';out<<'[';for(int j=0;j<6;j++){if(j)out<<',';json(out,mat[i][j]);}out<<']';}out<<"],\"removed\":["<<removed[0]<<','<<removed[1]<<"],\"norm\":";json(out,det);out<<'}';out.flush();
  std::ofstream o(std::string(argv[4])+".C"+std::to_string(index)+".txt");o<<det.deg()<<'\n';for(auto c:det.c)o<<c.v<<'\n';norms.push_back(det);
  std::cout<<"{\"tail\":"<<index<<",\"norm_degree\":"<<det.deg()<<",\"removed\":["<<removed[0]<<','<<removed[1]<<"],\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-st).count()<<"}"<<std::endl;
  if(norms.size()>=2){auto[g,a,b]=xgcd_half(norms[0],norms.back(),true);std::ofstream gfile(std::string(argv[4])+".gcd"+std::to_string(index)+".json");gfile<<"{\"gcd\":";json(gfile,g);gfile<<",\"a\":";json(gfile,a);gfile<<",\"b\":";json(gfile,b);gfile<<"}\n";std::cout<<"{\"norm_gcd_degree\":"<<g.deg()<<"}"<<std::endl;}
  index++;
 }
 out<<"]}\n";
}catch(const std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}}
