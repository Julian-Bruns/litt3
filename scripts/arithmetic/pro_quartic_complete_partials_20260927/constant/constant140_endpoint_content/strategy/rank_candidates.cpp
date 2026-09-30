#define main archived_frontier_main
#include "../continuation/frontier.cpp"
#undef main
Poly readrow(std::string p){std::ifstream in(p);std::vector<F>a;F x;while(in>>x)a.push_back(x);return Poly(a);}
Poly radical(Poly f){if(f.deg()<=0)return f;Poly df=derivative(f);if(df.zero()){Poly a;for(int i=0;i<=f.deg();i+=5)a.v.push_back(ff::pow(f.at(i),78125));return radical(a);}Poly c=gcd(f,df),w=exactdiv(f,c),r=w;while(c.deg()>0){Poly g=gcd(c,w);c=exactdiv(c,g);if(g.deg()==0)break;}if(c.deg()>0)r= r*exactdiv(radical(c),gcd(r,radical(c)));return scale(r,ff::inv(r.v.back()));}
int main(int argc,char**argv){ff::init();init_source();std::string pref=argc>1?argv[1]:"build/rank2";auto f=readrow(pref+"_resultant_current_open_gcd.dat");auto r=radical(f);show("candidate_radical",r);show("radical_derivative_gcd",gcd(r,derivative(r)));std::ofstream out(pref+"_candidate_radical.dat");for(F c:r.v)out<<c<<' ';out<<'\n';}
