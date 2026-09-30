#define USE_GMP_PACKING
#include "finite_series_fast.hpp"
#include <map>
struct Raw{std::string name;std::vector<std::array<U,3>>terms;};
static Raw readraw(std::istream&i){Raw r;int n;i>>r.name>>n;r.terms.resize(n);for(auto&t:r.terms)i>>t[0]>>t[1]>>t[2];if(!i)throw std::runtime_error("chart input failed");return r;}
static SPoly convert(const Raw&r){SPoly f;std::vector<BP>powers(250);powers[0]={1};for(int i=1;i<250;i++)powers[i]=bm(powers[i-1],br({0,1}));for(auto&t:r.terms){int i=t[0],j=t[1];if(i>=250)throw std::runtime_error("v degree bound");f.resize(std::max(f.size(),size_t(j+1)));f[j]=ba(f[j],bscl(powers[i],t[2]));}st(f);return f;}
static void write_result(std::ostream&o,const std::string&key,const EA&a){outsp(o,key,a.n);}
int main(int argc,char**argv){try{if(argc<5){std::cerr<<"usage: finite_fibers_fast chart Ehat factors prefix [start stop branch]\n";return 2;}initfield(nullptr);std::ifstream ii(argv[1]);U r,pr;ii>>r>>pr;std::vector<Raw>raw(14);for(auto&x:raw)x=readraw(ii);std::ifstream ff(argv[3]);int nf;ff>>nf;std::vector<BP>fac(nf);for(auto&f:fac)f=inup(ff);int first=argc>5?std::stoi(argv[5]):0,last=argc>6?std::stoi(argv[6]):nf,branch=argc>7?std::stoi(argv[7]):0;if(branch<0||branch>3)throw std::runtime_error("bad branch");if(first<0||last>nf||first>last)throw std::runtime_error("factor range must satisfy 0 <= start <= stop <= factor_count");
 for(int index=first;index<last;index++){auto start=std::chrono::steady_clock::now();VF=fac.at(index);std::vector<SPoly>p;for(auto&x:raw)p.push_back(convert(x));SPoly initial=p[0];if(initial.empty()||initial.back()!=BP{1})throw std::runtime_error("nonmonic fiber");std::ofstream out(std::string(argv[4])+"_f"+std::to_string(index)+"_b"+std::to_string(branch)+".txt");out<<"r "<<r<<" factor "<<index<<" branch "<<branch<<"\n";out<<"v_modulus\n";outup(out,VF);outsp(out,"initial_S_modulus",initial);
 BP v=br({0,1});bool excluded=false;std::string reason;
 for(int k=1;k<=3;k++)if(p[k].empty()){excluded=true;reason=raw[k].name;break;}if(v.empty()){excluded=true;reason="v";}
 if(excluded){out<<"excluded_base "<<reason<<"\n";std::cout<<"r="<<r<<" f="<<index<<" degree="<<VF.size()-1<<" branch="<<branch<<" BASE_EXCLUDED="<<reason<<std::endl;continue;}
 BP q=bscl(bi(bm(bm(v,v),v)),pr),a0;for(U c:UP{245794,356725,33043,315361,163299,214299,311173,89654})a0=ba(bm(a0,q),cn(c));BP a1=bm(q,ba(cn(299833),bscl(q,232505)));
 if(a0.empty()||us(q,{1}).empty()||us(q,{15383}).empty()){out<<"excluded_base q_open\n";std::cout<<"r="<<r<<" f="<<index<<" degree="<<VF.size()-1<<" branch="<<branch<<" BASE_EXCLUDED=q_open"<<std::endl;continue;}
 SPoly psiN=sa(sc(p[5],a0),sc(p[4],a1));SPoly op={{1}};for(auto&a:std::vector<SPoly>{p[4],p[5],psiN,p[6+2*branch],p[7+2*branch]})op=sr(sm(op,a),initial);
 SPoly allowed=initial;for(;;){SPoly g=sg(allowed,op);if(g.size()<=1)break;allowed=sx(allowed,g);}SPoly removed=sx(initial,allowed);outsp(out,"open_polynomial",op);outsp(out,"allowed_S_modulus",allowed);outsp(out,"removed_S_factor",removed);
 if(removed.size()>1&&!spmod(op,6,removed).empty())throw std::runtime_error("saturation coverage failed");if(allowed.size()==1){out<<"empty_allowed_fiber\n";std::cout<<"r="<<r<<" f="<<index<<" degree="<<VF.size()-1<<" branch="<<branch<<" ALLOWED_EMPTY=1"<<std::endl;continue;}
 auto oi=sxg(op,allowed);if(oi[0]!=SPoly{{1}})throw std::runtime_error("allowed open gcd");outsp(out,"open_inverse",sr(oi[1],allowed));SF=allowed;
 EA H=EA(p[4])*einverse(EA(p[5])),mu=EA(p[6+2*branch])*einverse(EA(p[7+2*branch])),qE(q);write_result(out,"H",H);write_result(out,"q",qE);write_result(out,"mu",mu);
 std::array<BP,61>qp;qp[6]={1};for(int i=7;i<61;i++)qp[i]=bm(qp[i-1],q);BP iq=bi(q);for(int i=5;i>=0;i--)qp[i]=bm(qp[i+1],iq);
 std::array<EA,13>hp;hp[0]=EA(1);for(int i=1;i<13;i++)hp[i]=hp[i-1]*H;std::ifstream ei(argv[2]);std::string name;int n;ei>>name>>n;std::map<int,BP>groups;for(int i=0;i<n;i++){int x,y,h,qq,m;U c;ei>>x>>y>>h>>qq>>m>>c;int k=x+64*y+256*h+4096*m;groups[k]=ba(groups[k],bscl(qp.at(qq+6),c));}
 std::array<std::array<std::array<EA,47>,3>,3>E;for(auto&[k,c]:groups){int x=k%64,y=(k/64)%4,h=(k/256)%16,m=k/4096;E[m][y][x]=E[m][y][x]+EA(c)*hp[h];}
 std::array<ES,3>e;const int deg[3]={46,43,40};EA musq=mu*mu;for(int j=0;j<3;j++){e[j].resize(FP);for(int i=0;i<=deg[j];i++){int x=deg[j]-i;e[j][i]=E[0][j][x]+E[1][j][x]*mu+E[2][j][x]*musq;}}
 auto a3=es_fast(es_fast_square(e[0]),e[0]);auto b3=es_fast(es_fast_square(e[1]),e[1]);auto c3=es_fast(es_fast_square(e[2]),e[2]);auto abc=es_fast(es_fast(e[0],e[1]),e[2]);UP P={1,22,9,16,15,20,19,5,18,22,11};ES u=esa(esa(esp(c3,um(P,P),EA(1)),esh(esp(esa(b3,esc(abc,2)),P,qE),1)),esh(esp(a3,{1},qE*qE),2));EA ilc=einverse(u[0]);write_result(out,"raw_leading",u[0]);write_result(out,"raw_leading_inverse",ilc);for(auto&x:u)x=x*ilc;
 auto root=sqrt_fast_power(u);auto root_square=es_fast_square(root);for(int i=0;i<FP;i++)if(!(root_square[i]-u[i]).zero())throw std::runtime_error("formal root square identity mismatch");write_result(out,"C71",root[71]);write_result(out,"C72",root[72]);auto uv=unit_tails(root[71],root[72]);write_result(out,"U",uv[0]);write_result(out,"V",uv[1]);out<<"PASS\n";
 std::cout<<"r="<<r<<" f="<<index<<" degree="<<VF.size()-1<<" branch="<<branch<<" allowed_S_degree="<<SF.size()-1<<" algebra_dimension="<<(VF.size()-1)*(SF.size()-1)<<" TAIL_UNIT_IDENTITY=1 FORMAL_ROOT_SQUARE_IDENTITY=1 seconds="<<std::chrono::duration<double>(std::chrono::steady_clock::now()-start).count()<<std::endl;
 }
 return 0;}catch(std::exception&e){std::cerr<<e.what()<<"\n";return 1;}}
