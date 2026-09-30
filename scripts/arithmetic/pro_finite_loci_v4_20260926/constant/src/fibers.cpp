#include "residual.hpp"
int main(){init_curve();auto chart=load_chart();std::vector<std::pair<F,F>>pairs={{1,2},{1,3},{1,5},{1,25},{2,2},{2,5},{5,3},{5,25},{25,2},{25,3},{25,5},{25,25}};
std::ofstream out("evidence/fibers.json");out<<"{\"scope\":\"Only the explicitly listed (h,w) fibers; all geometric lambda in each listed fiber\",\"fibers\":[";bool first=true;int count=0;
for(auto[h,w]:pairs){if(!allowed(h,w))throw std::runtime_error("chosen fiber outside open");auto src=evaluate(chart,h,w);if(!equations(src,true).empty())throw std::runtime_error("source verification failed");auto R=residual_all_scales(src);F L=expected_lead(h,w);if(R.size()!=7||R[0].deg()!=140||R[0].coef(140)!=L)throw std::runtime_error("residual leading coefficient mismatch");for(int j=1;j<7;j++)if(R[j].deg()>=140)throw std::runtime_error("scale-dependent leading coefficient");
std::vector<Poly>Ahat(141);for(int m=0;m<=140;m++){Ahat[m].resize(7);for(int j=0;j<7;j++)Ahat[m][j]=R[j].coef(140-m);Ahat[m].trim();}
std::vector<Poly>root(71);root[0]=Poly{1};F iL=FF::inv(L);for(int m=1;m<=70;m++){Poly c;for(int j=1;j<m;j++)c=c+root[j]*root[m-j];root[m]=scale(scale(Ahat[m],iL)-c,3);}
std::vector<Poly>eq,bez;Poly g;int end=70;
for(int m=71;m<=140;m++){Poly c;for(int j=std::max(0,m-70);j<=70;j++)c=c+root[j]*root[m-j];Poly e=Ahat[m]-scale(c,L);eq.push_back(e);end=m;
if(eq.size()==1){g=e;if(!g.empty()){F iv=FF::inv(g.back());g=scale(g,iv);bez.push_back(Poly{iv});}else bez.push_back({});}
else{auto[d,u,v]=xgcd(g,e);for(auto&b:bez)b=b*u;bez.push_back(v);g=d;}
if(g==Poly{1})break;}
Poly check;for(size_t i=0;i<eq.size();i++)check=check+eq[i]*bez[i];if(check!=g)throw std::runtime_error("Bezout identity failed");
std::cout<<"h="<<h<<" w="<<w<<" H="<<FF::mul(h,w)<<" q="<<FF::pow(w,3)<<" lambda_x_degrees=";for(auto&r:R)std::cout<<r.deg()<<",";std::cout<<" equations=71.."<<end<<" gcd_degree="<<g.deg()<<"\n";
if(!first)out<<",";first=false;out<<"{\"h\":"<<h<<",\"w\":"<<w<<",\"H\":"<<FF::mul(h,w)<<",\"q\":"<<FF::pow(w,3)<<",\"leading\":"<<L<<",\"residual_lambda_coefficients\":[";for(int i=0;i<7;i++){if(i)out<<",";json_poly(out,R[i]);}out<<"],\"tail_start\":71,\"tail_end\":"<<end<<",\"tail_equations\":[";for(size_t i=0;i<eq.size();i++){if(i)out<<",";json_poly(out,eq[i]);}out<<"],\"bezout\":[";for(size_t i=0;i<bez.size();i++){if(i)out<<",";json_poly(out,bez[i]);}out<<"],\"gcd\":";json_poly(out,g);out<<"}";if(g==Poly{1})count++;
}
out<<"]}\n";std::cout<<"Certified empty geometric scale fibers="<<count<<" of "<<pairs.size()<<"; this is NOT the global decision.\n";
// Independent fixed-degree Sylvester tests, including coefficient drops.
std::mt19937 gen(140);for(int n=0;n<150;n++){F a=gen()%FF::N,b=gen()%FF::N,c=gen()%FF::N,d=gen()%FF::N,q=gen()%FF::N,C=gen()%FF::N,l=gen()%FF::N;if(n%5==0)a=0;if(n%7==0)b=0;if(n%11==0)l=0;Poly U{q,0,0,0,0,1},S{d,c,FF::mul(3,b),FF::mul(2,a)},D{c,b,a};Poly fp=scale(power(U,2),l)+U*S+Poly{C};F direct=fixed_resultant(fp,D,10,2);auto abc=universal_resultant(Curve(con(a)),Curve(con(b)),Curve(con(c)),Curve(con(d)),Curve(con(q)),Curve(con(C)));F formula=FF::add(abc[0].coef(0,0),FF::add(FF::mul(l,abc[1].coef(0,0)),FF::mul(FF::pow(l,2),abc[2].coef(0,0))));if(direct!=formula)throw std::runtime_error("universal Sylvester cross-check failed");}
std::cout<<"150 direct fixed-degree Sylvester cross-checks PASS (including degree drops).\n";
}
