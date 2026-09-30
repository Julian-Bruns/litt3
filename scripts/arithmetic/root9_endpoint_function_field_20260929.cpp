// Actual root-nine residual on a degree-twelve endpoint-content curve.
// The scale section and every extra pole are supplied by exact local data.
#define ROOT9_RANK 12
#define ROOT9_FAST_RAT_NORMALIZE
#define ROOT9_THREAD_RATIONAL
#define ROOT9_MARKED_NO_MAIN
#include <omp.h>
#include "root9_marked_function_field_20260929.cpp"
#include "root9_fourier_20260929.hpp"
#include "root9_curve_square_gaps_20260929.hpp"

// Coefficient sums are independent. The only growing shared caches in
// Rat become thread-local under ROOT9_THREAD_RATIONAL; field tables and
// the already constructed quotient modulus stay read-only.
Poly<MR> parallel_product(const Poly<MR>&a,const Poly<MR>&b){
 if(!a||!b)return Poly<MR>();Poly<MR>z;z.c.resize(a.c.size()+b.c.size()-1);
 #pragma omp parallel for schedule(dynamic,1)
 for(int k=0;k<(int)z.c.size();k++){
  for(int i=std::max(0,k-b.deg());i<=std::min(k,a.deg());i++)
   if(a[i]&&b[k-i])z.c[k]+=a[i]*b[k-i];
  z.c[k].normalize();
 }
 z.trim();return z;
}
Poly<MR> parallel_cube(const Poly<MR>&a){return parallel_product(parallel_product(a,a),a);}

int main(int argc,char**argv){try{
 if(argc<4)throw std::runtime_error("usage source-root model.json output-prefix [tails]");init(argv[1]);ptree data;boost::property_tree::read_json(argv[2],data);assert(data.get<int>("rank")==MRANK);std::array<FP,5>poles;int i=0;for(auto&[k,r]:data.get_child("poles"))poles[i++]=frow(r);assert(i==5);Rat::setup(FP(0),poles);
 std::array<Rat,MRANK>mod;i=0;for(auto&[k,r]:data.get_child("J_monic_H")){if(i<MRANK)mod[i]=ratrow(r);else assert(ratrow(r)==Rat(1));i++;}assert(i==MRANK+1);auto start=std::chrono::steady_clock::now();MR::setup(mod);
 MR q(ratrow(data.get_child("actual_q"))),h;h.c[1]=Rat(1);MR u=h*q,mu;i=0;for(auto&[k,r]:data.get_child("mu_H"))mu.c[i++]=ratrow(r);assert(i==MRANK);mu.normalize();
 std::array<Curve<MR>,3>co;
 if(argc>5){ptree cache;boost::property_tree::read_json(argv[5],cache);int ii=0;for(auto&[key,row]:cache.get_child("rows")){int jj=0;for(auto&[key,pol]:row){for(auto&[key,coef]:pol){MR val;int hh=0;for(auto&[key,rat]:coef){Rat scalar=ratrow(rat);for(int k=0;k<MRANK;k++)val.c[k]+=scalar*MR::powers[hh].c[k];hh++;}val.normalize();co[ii].c[jj].c.push_back(val);}co[ii].c[jj].trim();jj++;}ii++;}Curve<MR>::PQ=basepoly<MR>(PP).scale(q.inverse());}
 else co=weighted_small_critical(q,u);
 std::cout<<"{\"stage\":\"source\",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}"<<std::endl;
 Curve<MR>g;
 if(data.get_child_optional("homogeneous_num_H")){
  MR num,den;int k=0;for(auto&[key,row]:data.get_child("homogeneous_num_H"))num.c[k++]=ratrow(row);k=0;for(auto&[key,row]:data.get_child("homogeneous_den_H"))den.c[k++]=ratrow(row);auto d2=den*den,nd=num*den,n2=num*num;g=co[0]*Curve<MR>(Poly<MR>(d2))+co[1]*Curve<MR>(Poly<MR>(nd))+co[2]*Curve<MR>(Poly<MR>(n2));
 }else{auto mu2=mu*mu;g=co[0]+co[1]*Curve<MR>(Poly<MR>(mu))+co[2]*Curve<MR>(Poly<MR>(mu2));}
 for(int j=0;j<3;j++)stats("specialized_component_"+std::to_string(j),g.c[j].c);
 std::cout<<"{\"stage\":\"specialized\",\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}"<<std::endl;
 auto pq=Curve<MR>::PQ;FastK::init();fourier_setup();
 if(argc>4&&std::string(argv[4])=="curve-gaps"){curve_square_gaps(g,q,argv[3]);return 0;}
 bool use_fourier=argc>4&&(std::string(argv[4])=="fft-tails"||std::string(argv[4])=="fft-residual");
 auto rr=use_fourier?curve_norm156(g,q):(parallel_cube(g.c[0])+parallel_product(parallel_cube(g.c[1]),pq)+parallel_product(parallel_cube(g.c[2]),pq.pow(2))-parallel_product(parallel_product(parallel_product(g.c[0],g.c[1]),g.c[2]),pq).scale(MR(3))).scale(q.inverse());assert(rr.deg()==140);for(auto&x:rr.c)x.normalize();stats("residual",rr.c);
 std::ofstream out(std::string(argv[3])+".residual.json");out<<"{\"scope\":\"Only coefficients x^67 through x^140 used\",\"poles\":[";for(int k=0;k<5;k++){if(k)out<<',';json(out,Rat::factors[k]);}out<<"],\"coefficients\":[";for(int k=0;k<=140;k++){if(k)out<<',';save_mr(out,rr[k]);}out<<"]}\n";out.close();
 if(argc<5||std::string(argv[4])=="fft-residual")return 0;const int N=74;std::vector<MR>a(N);for(int k=0;k<N;k++)a[k]=rr[140-k];
 auto mul=[&](const std::vector<MR>&a,const std::vector<MR>&b){if(use_fourier)return convolution156(a,b,N);std::vector<MR>z(N);
 #pragma omp parallel for schedule(dynamic,1)
 for(int k=0;k<N;k++){for(int j=0;j<=k;j++)if(a[j]&&b[k-j])z[k]+=a[j]*b[k-j];z[k].normalize();}return z;};
 auto frob=[&](const std::vector<MR>&v,int e){std::vector<MR>z(N);for(int k=0;e*k<N;k++)z[e*k]=v[k].pow(e);return z;};
 auto a2=mul(a,a);stats("a2",a2);auto a3=mul(a2,a);stats("a3",a3);auto a13=mul(a3,frob(a2,5));stats("a13",a13);auto a63=mul(a13,frob(a2,25));stats("a63",a63);
 std::ofstream tail(std::string(argv[3])+".tails.json");tail<<"{\"raw_exponent\":63,\"tails\":[";for(int k=71;k<=73;k++){if(k>71)tail<<',';save_mr(tail,a63[k]);}tail<<"]}\n";
 std::cout<<"{\"completed\":true,\"seconds\":"<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<"}"<<std::endl;
}catch(const std::exception&e){std::cerr<<e.what()<<std::endl;return 1;}}
