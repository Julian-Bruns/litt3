#include "point_io.hpp"
#include <chrono>
inline Poly paddconst(Poly p,F a){if(p.empty())p.resize(1);p[0]=add(p[0],a);trim(p);return p;}
int main(int argc,char**argv){try{
 init();if(argc<3)throw runtime_error("usage line family.txt output.json");Fam f=readfam(argv[1]);Poly t=scale(exact(A,Poly{neg(25),1}),inv(13));
 vector<F> z(7);z[f.cid?0:1]=1;z[6]=1;Pt p=point(f,z);if(!p.k||pole(p.D2)!=(f.cid?13:12))throw runtime_error("base point not in open");
 Poly pt2=pm(P,pp(t,2));Ar direction=ap(ax(0,2),pt2);
 vector<Poly> values;int maxdegree=-1;
 for(F s=0;s<7;s++){Pt ps=p;ps.N[5]=aa(ps.N[5],ac(direction,s));Poly R=residual(ps,t,f.cid,f.r);maxdegree=max(maxdegree,deg(R));values.push_back(R);}
 vector<Poly> coefficients(maxdegree+1);
 for(int i=0;i<7;i++){
  Poly ell{1};F den=1;for(int j=0;j<7;j++)if(j!=i){ell=pm(ell,Poly{neg(F(j)),1});den=mul(den,sub(i,j));}ell=scale(ell,inv(den));
  for(int d=0;d<=maxdegree;d++)coefficients[d]=pa(coefficients[d],scale(ell,coeff(values[i],d)));
 }
 // independent evaluation away from the interpolation nodes
 for(F s: {F(25),F(49)}){Pt ps=p;ps.N[5]=aa(ps.N[5],ac(direction,s));Poly R=residual(ps,t,f.cid,f.r),v(coefficients.size());for(size_t d=0;d<coefficients.size();d++)v[d]=eval(coefficients[d],s);trim(v);if(R!=v)throw runtime_error("line interpolation cross-check failed");}
 Poly lead=coefficients.back();cout<<"case="<<f.cid<<" line degree_x="<<maxdegree<<" lead degree_s="<<deg(lead)<<"\n";
 if(maxdegree!=144)throw runtime_error("expected maxdegree144");
 vector<Poly> lpowers(146);lpowers[0]={1};for(int i=1;i<146;i++)lpowers[i]=pm(lpowers[i-1],lead);
 vector<Poly> H(75);H[0]={1};
 for(int d=1;d<=74;d++){
  Poly rhs=pm(coefficients[144-d],lpowers[d-1]);
  for(int i=1;i<d;i++)rhs=ps(rhs,pm(H[i],H[d-i]));H[d]=scale(rhs,3);
 }
 auto [g,bezout73,bezout74]=xgcd(H[73],H[74]);Poly rawg=g;
 if(pa(pm(bezout73,H[73]),pm(bezout74,H[74]))!=rawg)throw runtime_error("Bezout identity");
 if(rawg!=pp(monic(lead),10))throw runtime_error("gcd is not monic leading coefficient to power 10");
 for(;;){Poly h=gcd(g,lead);if(deg(h)<=0)break;g=exact(g,h);}
 cout<<"H73 degree="<<deg(H[73])<<" H74 degree="<<deg(H[74])<<" gcd degree="<<deg(rawg)<<" saturated gcd degree="<<deg(g)<<"\n";
 auto rr=roots(lead); // since lead is a cube of a linear factor, this lists all geometric zeros if repeated-factor test passes.
 Poly leadrad=monic(lead);for(F s:rr)while(eval(leadrad,s)==0)leadrad=exact(leadrad,Poly{neg(s),1});
 if(deg(leadrad)>0)throw runtime_error("leading coefficient has nonrational roots; not all boundaries checked");
 vector<Poly> boundaries;
 for(F s:rr){Pt ps=p;ps.N[5]=aa(ps.N[5],ac(direction,s));Poly R=residual(ps,t,f.cid,f.r);boundaries.push_back(R);cout<<"boundary s="<<s<<" degree="<<deg(R)<<" square="<<squaretest(R).first<<"\n";}
 bool excluded=deg(g)==0;for(auto&R:boundaries)if(squaretest(R).first)excluded=false;
 cout<<"entire geometric line excluded="<<excluded<<"\n";
 ofstream o(argv[2]);o<<"{\"case\":"<<f.cid<<",\"base_parameters\":";jpoly(o,z);o<<",\"N5_direction\":";jar(o,direction);o<<",\"R0_coefficients_ascending_x_each_ascending_s\":[";for(size_t i=0;i<coefficients.size();i++){if(i)o<<",";jpoly(o,coefficients[i]);}o<<"],\"H73\":";jpoly(o,H[73]);o<<",\"H74\":";jpoly(o,H[74]);o<<",\"bezout73\":";jpoly(o,bezout73);o<<",\"bezout74\":";jpoly(o,bezout74);o<<",\"raw_gcd\":";jpoly(o,rawg);o<<",\"saturated_gcd\":";jpoly(o,g);o<<",\"leading_coefficient_roots\":";jpoly(o,rr);o<<",\"boundary_residuals\":[";for(size_t i=0;i<boundaries.size();i++){if(i)o<<",";jpoly(o,boundaries[i]);}o<<"],\"geometric_line_excluded\":"<<(excluded?"true":"false")<<"}\n";
 }catch(exception&e){cerr<<"ERROR: "<<e.what()<<"\n";return 1;}}
