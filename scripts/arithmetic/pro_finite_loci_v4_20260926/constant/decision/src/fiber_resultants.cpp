#include "../../src/residual.hpp"
#include <filesystem>
#include <omp.h>
static std::vector<F> addtab,negate;
inline F fa(F a,F b){return addtab[(a%625)*625+b%625]+625*addtab[(a/625)*625+b/625];}
inline F fs(F a,F b){return fa(a,negate[b]);}
inline F fm(F a,F b){return a&&b?FF::ex[FF::lg[a]+FF::lg[b]]:0;}
Poly frem(Poly a,const Poly&b){F iv=FF::inv(b.back());for(int i=a.deg()-b.deg();i>=0;i--){F v=fm(a[i+b.deg()],iv);if(v)for(int j=0;j<=b.deg();j++)a[i+j]=fs(a[i+j],fm(v,b[j]));}a.resize(std::min(a.size(),b.size()-1));a.trim();return a;}
F resultant(Poly a,Poly b,int da,int db){if(a.deg()!=da||b.deg()!=db)return fixed_resultant(a,b,da,db);F ans=1;while(!b.empty()){if(b.deg()==0)return fm(ans,FF::pow(b[0],a.deg()));int n=a.deg(),m=b.deg();auto r=frem(a,b);if(r.empty())return 0;F c=FF::pow(b.back(),n-r.deg());if(n*m%2)c=negate[c];ans=fm(ans,c);a=std::move(b);b=std::move(r);}return 0;}
struct Gen{int index,dl;std::vector<Poly>lc;std::vector<int>lv;};
Poly at(const Gen&g,F h){Poly f(g.dl+1);for(int l=0;l<=g.dl;l++){F z=0;for(int i=g.lc[l].deg();i>=0;i--)z=fa(fm(z,h),g.lc[l][i]);f[l]=fm(z,FF::pow(h,g.lv[l]));}f.trim();return f;}
int degree_bound(const Gen&g,const Gen&h){int best=10000000;for(int w=-20;w<=20;w++){int dg=-100000,dh=-100000;for(int l=0;l<=g.dl;l++)if(!g.lc[l].empty())dg=std::max(dg,g.lc[l].deg()+g.lv[l]+w*l);for(int l=0;l<=h.dl;l++)if(!h.lc[l].empty())dh=std::max(dh,h.lc[l].deg()+h.lv[l]+w*l);best=std::min(best,h.dl*dg+g.dl*dh-w*g.dl*h.dl);}return best;}
Poly interpolate(std::vector<F>v,const std::vector<F>&nodes,const std::vector<F>&invpowers,const std::vector<F>&invdiff){int N=v.size();for(int k=0;k<N-1;k++)for(int j=N-1;j>k;j--)v[j]=fm(fs(v[j],v[j-1]),fm(invpowers[j-k-1],invdiff[k+1]));Poly p{v.back()};for(int k=N-2;k>=0;k--){p.push_back(p.back());for(int j=int(p.size())-2;j>0;j--)p[j]=fs(p[j-1],fm(nodes[k],p[j]));p[0]=fs(v[k],fm(nodes[k],p[0]));}p.trim();return p;}
F fasteval(const Poly&p,F a){F b=0;for(int i=p.deg();i>=0;i--)b=fa(fm(b,a),p[i]);return b;}
int main(int argc,char**argv){try{if(argc!=3)throw std::runtime_error("usage: fiber_resultants tail-file-prefix output-directory");std::string pref=argv[1],dir=argv[2];std::filesystem::create_directories(dir);init_curve();addtab.resize(625*625);for(F a=0;a<625;a++)for(F b=0;b<625;b++)addtab[a*625+b]=FF::add(a,b);negate.resize(FF::N);for(F a=0;a<FF::N;a++)negate[a]=FF::neg(a);
 std::ifstream in(pref+".bin",std::ios::binary);uint32_t hd[4];in.read((char*)hd,16);int start=hd[0],end=hd[1],NH=hd[2],NL=hd[3];std::vector<F>raw(size_t(end-start+1)*NH*NL);in.read((char*)raw.data(),raw.size()*4);if(!in||in.peek()!=EOF)throw std::runtime_error("bad tails binary");std::vector<Gen>gs;for(int i=0;i<3;i++){Gen g;g.index=start+i;g.dl=0;g.lc.resize(NL);g.lv.resize(NL);for(int l=0;l<NL;l++){Poly a(NH);for(int h=0;h<NH;h++)a[h]=raw[(size_t(i)*NH+h)*NL+l];a.trim();int v=0;while(v<int(a.size())&&!a[v])v++;if(v){a.erase(a.begin(),a.begin()+v);}g.lc[l]=a;g.lv[l]=v;if(!a.empty())g.dl=l;}g.lc.resize(g.dl+1);g.lv.resize(g.dl+1);gs.push_back(g);}
 int D1=degree_bound(gs[0],gs[1]),D2=degree_bound(gs[0],gs[2]),N=std::max(D1,D2)+1;std::cout<<"fixed lambda degrees="<<gs[0].dl<<","<<gs[1].dl<<","<<gs[2].dl<<"; resultant h bounds="<<D1<<","<<D2<<"; nodes="<<N<<"\n"<<std::flush;
 std::vector<F> nodes(N),ip(N),id(N),seen(FF::N);F z=FF::primitive,zi=FF::inv(z);nodes[0]=ip[0]=1;for(int i=1;i<N;i++){nodes[i]=fm(nodes[i-1],z);ip[i]=fm(ip[i-1],zi);id[i]=FF::inv(fs(nodes[i],1));}for(F h:nodes){if(seen[h]++)throw std::runtime_error("node collision");}
 std::array<std::vector<F>,2>values;for(auto&v:values)v.resize(N);int done=0;
 #pragma omp parallel for schedule(dynamic,16)
 for(int i=0;i<N;i++){auto f=at(gs[0],nodes[i]),g=at(gs[1],nodes[i]),h=at(gs[2],nodes[i]);values[0][i]=resultant(f,g,gs[0].dl,gs[1].dl);values[1][i]=resultant(f,h,gs[0].dl,gs[2].dl);
 #pragma omp atomic update
 done++;
 if(i%4096==0){
 #pragma omp critical
 std::cout<<"resultant node index="<<i<<" / "<<N<<"\n"<<std::flush;}}
 std::cout<<"node stage complete; exact univariate interpolation\n"<<std::flush;std::array<Poly,2>polys;
 #pragma omp parallel for
 for(int k=0;k<2;k++){polys[k]=interpolate(values[k],nodes,ip,id);std::cout<<"interpolated polynomial="<<k<<" degree="<<polys[k].deg()<<"\n"<<std::flush;}
 if(polys[0].deg()>D1||polys[1].deg()>D2)throw std::runtime_error("resultant degree bound violated");bool bad=false;
 #pragma omp parallel for reduction(||:bad) schedule(dynamic,16)
 for(int i=0;i<N;i++)for(int k=0;k<2;k++)if(fasteval(polys[k],nodes[i])!=values[k][i])bad=true;if(bad)throw std::runtime_error("resultant interpolation roundtrip");
 std::cout<<"all resultant interpolation nodes reproduced; checking extras\n"<<std::flush;for(F h:{0u,11111u,22222u,33333u}){auto f=at(gs[0],h),g=at(gs[1],h),r=at(gs[2],h);if(fasteval(polys[0],h)!=resultant(f,g,gs[0].dl,gs[1].dl)||fasteval(polys[1],h)!=resultant(f,r,gs[0].dl,gs[2].dl))throw std::runtime_error("extra resultant check failed");}
 std::ofstream o(dir+"/resultants.json");o<<"{\"generator_indices\":["<<gs[0].index<<","<<gs[1].index<<","<<gs[2].index<<"],\"lambda_degrees\":["<<gs[0].dl<<","<<gs[1].dl<<","<<gs[2].dl<<"],\"h_degree_bounds\":["<<D1<<","<<D2<<"],\"node_count\":"<<N<<",\"node_generator\":"<<z<<",\"extra_checks\":4,\"polynomials\":[";json_poly(o,polys[0]);o<<",";json_poly(o,polys[1]);o<<"]}\n";
 for(int k=0;k<2;k++){std::ofstream b(dir+"/res"+std::to_string(k)+".bin",std::ios::binary);b.write((char*)polys[k].data(),polys[k].size()*4);}std::cout<<"PASS: fixed-degree resultant polynomials saved; geometric common-zero decision not yet performed\n";return 0;
 }catch(const std::exception&e){std::cerr<<"FAIL: "<<e.what()<<"\n";return 1;}}
