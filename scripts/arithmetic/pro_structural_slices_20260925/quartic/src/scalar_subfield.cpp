// Complete finite-subfield exclusion; no enumeration of F_(5^56).
#define main quotient_generator_main
#include "quotient.cpp"
#undef main
int main(int argc,char**argv){try{
 if(argc!=3){throw runtime_error("usage: scalar_subfield PARTNER_FILE CERTIFICATE_FILE");}init();ifstream in(argv[1]);
 readpoly(in);readpoly(in);modpoly=readpoly(in);Poly z={0,1};
 for(int i=0;i<56;i++){z=power(z,5);}
 Poly f=sub(z,Poly{0,1}),g=gcd(f,modpoly);
 cout<<"scalar values in F_(5^56): "<<g.size()-1<<"\n";
 if(g!=Poly{1})throw runtime_error("nonempty scalar subfield intersection");
 Poly inv=inverse(f);assert(mm(f,inv)==Poly{1});ofstream out(argv[2]);writepoly(out,f);writepoly(out,inv);
 cout<<"unit certificate for E^(5^56)-E modulo scalar polynomial: PASS\n";return 0;
 }catch(const exception&e){cerr<<e.what()<<'\n';return 1;}}
