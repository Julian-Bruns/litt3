#include "../../src/residual.hpp"
#include <filesystem>
int main(int argc,char**argv){try{
 if(argc!=3)throw std::runtime_error("usage: fiber_input w output-directory");init_curve();auto parsed_w=std::stoul(argv[1]);if(parsed_w==0||parsed_w>=FF::N)throw std::runtime_error("w must be a nonzero K-code");F w=F(parsed_w);std::string dir=argv[2];std::filesystem::create_directories(dir);auto chart=load_chart();const int N=37;
 std::vector<std::vector<F>> vals(N,std::vector<F>(7*141));
 for(int h=0;h<N;h++){auto rr=residual_all_scales(evaluate(chart,h,w));for(int m=0;m<7;m++)for(int x=0;x<=140;x++)vals[h][m*141+140-x]=rr[m].coef(x);}
 std::vector<Poly> cof(7*141);Poly base{1};for(int k=0;k<N;k++){for(int i=0;i<7*141;i++)cof[i]=cof[i]+scale(base,vals[k][i]);for(int j=N-1;j>k;j--)for(int i=0;i<7*141;i++)vals[j][i]=FF::div(FF::sub(vals[j][i],vals[j-1][i]),FF::sub(j,j-k-1));base=base*Poly{FF::neg(k),1};}
 std::vector<F> checks;for(F h=0;h<N;h++)checks.push_back(h);for(F h:{73u,105u,113265u})checks.push_back(h);for(F h:checks){auto rr=residual_all_scales(evaluate(chart,h,w));for(int m=0;m<7;m++)for(int x=0;x<=140;x++)if(eval(cof[m*141+140-x],h)!=rr[m].coef(x))throw std::runtime_error("extra residual evaluation failed");}
 std::ofstream o(dir+"/fiber_input.json");o<<"{\"w\":"<<w<<",\"q\":"<<FF::pow(w,3)<<",\"variables\":[\"h\",\"lambda\",\"T\"],\"convention\":\"T^140 R(1/T;h,w,lambda)\",\"terms\":[";bool first=true;int nt=0;
 for(int h=0;h<N;h++)for(int m=0;m<7;m++)for(int x=0;x<=140;x++)if(F c=cof[m*141+x].coef(h)){if(!first)o<<",";first=false;o<<"["<<h<<","<<m<<","<<x<<","<<c<<"]";nt++;}o<<"]}\n";
 std::ofstream bin(dir+"/fiber_input.bin",std::ios::binary);for(int x=0;x<=140;x++)for(int m=0;m<7;m++)for(int h=0;h<N;h++){F c=cof[m*141+x].coef(h);bin.write((char*)&c,4);}
 std::cout<<"w="<<w<<" q="<<FF::pow(w,3)<<" exact h interpolation through degree36; full grid roundtrip=37; extra full residual checks=3; terms="<<nt<<"\n";
 // Support-only bounds for coefficients in A^63, computed in tropical semirings.
 const int CUT=125,INF=100000;std::vector<int> lo(CUT,INF),hi(CUT,-INF),lm(CUT,-INF);
 for(int x=0;x<CUT;x++)for(int m=0;m<7;m++)for(int h=0;h<N;h++)if(cof[m*141+x].coef(h)){lo[x]=std::min(lo[x],h);hi[x]=std::max(hi[x],h);lm[x]=std::max(lm[x],m);}
 std::vector<int> v(CUT,INF),b(CUT,-INF),l(CUT,-INF);v[0]=b[0]=l[0]=0;
 for(int it=0;it<63;it++){std::vector<int> vv(CUT,INF),bb(CUT,-INF),ll(CUT,-INF);for(int i=0;i<CUT;i++)for(int j=0;i+j<CUT;j++)if(v[i]<INF&&lo[j]<INF){vv[i+j]=std::min(vv[i+j],v[i]+lo[j]);bb[i+j]=std::max(bb[i+j],b[i]+hi[j]);ll[i+j]=std::max(ll[i+j],l[i]+lm[j]);}v=vv;b=bb;l=ll;}
 std::ofstream bounds(dir+"/tail_support_bounds.json");bounds<<"{\"w\":"<<w<<",\"bounds\":[";for(int i=0;i<CUT;i++){if(i)bounds<<",";bounds<<"["<<i<<","<<v[i]<<","<<b[i]<<","<<l[i]<<"]";if(i>=71&&i<77)std::cout<<"C"<<i<<" h bounds "<<v[i]<<".."<<b[i]<<", lambda degree <="<<l[i]<<"\n";}bounds<<"]}\n";
 return 0;
 }catch(const std::exception&e){std::cerr<<"FAIL: "<<e.what()<<"\n";return 1;}}
