#include "../src/source.hpp"
using BP=std::vector<Poly>; // H, then q
BP trimB(BP a){while(!a.empty()&&a.back().zero())a.pop_back();return a;}
BP addB(const BP&a,const BP&b){BP c(std::max(a.size(),b.size()));for(int i=0;i<int(c.size());i++)c[i]=(i<int(a.size())?a[i]:Poly())+(i<int(b.size())?b[i]:Poly());return trimB(c);}
BP mulB(const BP&a,const BP&b){if(a.empty()||b.empty())return {};BP c(a.size()+b.size()-1);for(int i=0;i<int(a.size());i++)for(int j=0;j<int(b.size());j++)c[i+j]=c[i+j]+a[i]*b[j];return trimB(c);}
BP scB(BP a,F c){for(auto&p:a)p=scale(p,c);return trimB(a);}
BP qB(BP a,int n){for(auto&p:a)p=shift(p,n);return a;}
BP subB(const BP&a,const BP&b){return addB(a,scB(b,4));}
BP powB(BP a,int n){BP c{Poly(1)};while(n){if(n&1)c=mulB(c,a);n>>=1;if(n)a=mulB(a,a);}return c;}
F evalB(const BP&a,F H,F q){F v=0;for(int i=int(a.size())-1;i>=0;i--)v=ff::add(ff::mul(v,H),eval(a[i],q));return v;}
BP readpart(const std::string&path,int j0,int m0,int x0){std::ifstream in(path);std::string s;in>>s;BP a;int j,h,q,m,x,c;while(in>>j>>h>>q>>m>>x>>c)if(j==j0&&m==m0&&x==x0){if(int(a.size())<=h)a.resize(h+1);if(int(a[h].v.size())<=q)a[h].v.resize(q+1);a[h].v[q]=c;}return trimB(a);}
void show(const std::string&name,const Poly&p){std::cout<<name<<" degree "<<p.deg()<<" row";for(F c:p.v)std::cout<<' '<<c;std::cout<<'\n';}
int main(int argc,char**argv){try{ff::init();init_source();std::string ep=argc>1?argv[1]:"inputs/E_records.tsv";auto A=readpart(ep,0,2,43),A1=readpart(ep,0,2,42),B=readpart(ep,0,1,45),B1=readpart(ep,0,1,44),D=readpart(ep,1,2,39),E=readpart(ep,1,1,42),FF=readpart(ep,2,1,38),G=readpart(ep,2,2,35);
auto c5=scB(qB(mulB(powB(A,2),B),2),3);
auto c51=addB(scB(qB(addB(mulB(powB(A,2),B1),scB(mulB(mulB(A,A1),B),2)),2),3),subB(scB(qB(mulB(powB(D,2),E),1),3),scB(qB(mulB(A,addB(mulB(D,FF),mulB(E,G))),1),3)));
// Clear a monomial q-factor, harmless on q!=0, before an affine-H resultant.
auto removeq=[](BP z){int v=100000;for(auto&p:z)for(int q=0;q<=p.deg();q++)if(p.at(q)){v=std::min(v,q);break;}for(auto&p:z){if(!p.zero())p=Poly(std::vector<F>(p.v.begin()+v,p.v.end()));}return std::make_pair(z,v);};
auto [b,bq]=removeq(c5);auto [r,rq]=removeq(c51);std::cout<<"c5 H_degree "<<b.size()-1<<" q_factor "<<bq<<" c51 H_degree "<<r.size()-1<<" q_factor "<<rq<<"\n";if(b.size()!=2)throw std::runtime_error("not affine");Poly z;int nr=r.size()-1;for(int i=0;i<=nr;i++)z=z+ r[i]*ppow(-b[0],i)*ppow(b[1],nr-i);show("b0",b[0]);show("b1",b[1]);show("affine_resultant",z);Poly known=Poly::mon(1)*a0poly()*Poly(std::vector<F>{ff::neg(15383),1})*Poly(std::vector<F>{4,1});Poly zz=z;while(true){Poly gg=gcd(zz,known);if(gg.deg()<1)break;zz=exactdiv(zz,gg);}show("resultant_after_removing_known_q_factors",zz);
}catch(const std::exception&e){std::cerr<<e.what()<<'\n';return 1;}return 0;}
