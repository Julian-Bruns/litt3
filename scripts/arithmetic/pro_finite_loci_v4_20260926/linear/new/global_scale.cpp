// Compact Frobenius presentation of the leading scale coefficient, and a
// coefficientwise identity check against the expanded global residual.
#define main global_interpolation_entry_unused
#include "global_interpolate.cpp"
#undef main
Curve fifth_curve(const Curve& a){Curve out;for(int j=0;j<3;j++){if(!a.c[j])continue;Poly z;z.c.resize(5*a.c[j].deg()+1);for(int i=0;i<=a.c[j].deg();i++)z.c[5*i]=a.c[j][i].pow(5);z.trim();out.c[(5*j)%3]+=z*P.pow((5*j)/3);}return out;}
int main(int argc,char**argv){try{
 if(argc!=3 && !(argc==4 && std::string(argv[3])=="--compact-only"))throw std::runtime_error("usage: global_scale ROOT_CODE GENERATED_DIR [--compact-only]");bool verifyN=(argc==3);input::init();int rr=std::stoi(argv[1]);fs::path dir=argv[2];auto c=cramer(reconstruct(F::code(rr)));
 F pr=F::code(kfield::primitive),zh=pr.pow(kfield::N/8),zw=pr.pow(kfield::N/48),zq=zw.pow(3);Rows vals(16,std::vector<F>(8*65));Poly den=P.pow(20)*input::t.pow(8),vx=input::x-Poly(F::code(rr));
 for(int j=0;j<16;j++){F w=zw.pow(j),q=w.pow(3);Rows hv(8,std::vector<F>(65));for(int i=0;i<8;i++){F H=zh.pow(i);std::vector<F> vec;for(auto& a:c.num)vec.push_back(a.eval(H,w));auto s=source_from_vector(vec);auto T0=fifth_curve(s.g[2])-input::Q*fifth_curve(F(2)*s.g[1])+input::Q.pow(2)*fifth_curve(F(3)*s.g[0]);Poly v=(T0.norm()*vx).exactdiv(den)*q.pow(20);if(v.deg()>64)throw std::runtime_error("V x degree");for(int x=0;x<=64;x++)hv[i][x]=v[x];}
  hv=dft(hv,zh.pow(-5));for(int i=0;i<8;i++)for(int x=0;x<=64;x++){hv[i][x]*=F(8).inv();if(i==7&&hv[i][x])throw std::runtime_error("V u tail");vals[j][65*i+x]=hv[i][x];}
 }
 vals=dft(vals,zq.pow(-5));for(auto& row:vals)for(F& a:row)a*=F(16).inv();Rows V(7,std::vector<F>(16*65));long long nt=0;for(int u=0;u<7;u++)for(int b=0;b<16;b++)for(int x=0;x<=64;x++){F a=vals[b][65*u+x];V[u][65*b+x]=a;nt+=bool(a);}
 F lead=(-F(2)*F::code(24)*input::eps.pow(5)).pow(3);Poly lex=Poly::mon(4,lead)*(Poly::mon(1)-Poly(c.pivot.pow(5))).pow(3);
 for(int u=0;u<7;u++)for(int b=0;b<16;b++)if(V[u][65*b+64]!=(u?F():lex[b]))throw std::runtime_error("V leading coefficient");
 write_rows(dir/"leading_scale_V.bin",V);
 // Square V in the smaller variables u,b,x, before substituting u=H^5,b=q^5.
 struct Term{int u,b,x;F a;};std::vector<Term> ts;for(int u=0;u<7;u++)for(int b=0;b<16;b++)for(int x=0;x<=64;x++)if(V[u][65*b+x])ts.push_back({u,b,x,V[u][65*b+x]});
 std::vector<F> sq(13*31*129);for(size_t i=0;i<ts.size();i++)for(size_t j=i;j<ts.size();j++){auto a=ts[i],b=ts[j];F v=a.a*b.a;if(i!=j)v*=F(2);sq[((a.u+b.u)*31+a.b+b.b)*129+a.x+b.x]+=v;}
 Poly d6=(Poly::mon(1)-Poly(c.pivot)).pow(6),tv=input::t*vx;std::vector<F> want(13*181*141);
 for(int u=0;u<13;u++)for(int b=0;b<31;b++)for(int x=0;x<129;x++)if(F a=sq[(u*31+b)*129+x])for(int j=0;j<=6;j++)if(d6[j])for(int k=0;k<=tv.deg();k++)if(tv[k])want[(u*181+5*b+10+j)*141+x+k]+=a*d6[j]*tv[k];
 if(verifyN)for(int h=0;h<=72;h++){auto N=read_rows(dir/("N_H_"+std::to_string(h)+".bin"),181,NC);for(int q=0;q<=180;q++)for(int x=0;x<=140;x++){F ex=(h%5==0&&h<=60)?want[(h/5*181+q)*141+x]:F();if(N[q][6*141+x]!=ex)throw std::runtime_error("global leading scale identity mismatch");}}
 std::ofstream js(dir/"leading_scale_verification.json");js<<"{\"r\":"<<rr<<",\"V_nonzero_terms\":"<<nt<<",\"V_degree_bounds_u_b_x\":[6,15,64],\"u_equals_H_fifth\":true,\"b_equals_q_fifth\":true,\"scale_identity\":\"[mu^6]N=t*v*q^10*(q-pivot)^6*V(H^5,q^5,x)^2\",\"all_global_coefficients_verified\":"<<(verifyN?"true":"false")<<",\"V_x64_scalar_code\":"<<lead<<",\"V_x64\":\"scalar*b^4*(b-pivot^5)^3\",\"degree70_square_witness\":false}\n";
 std::cout<<"r="<<rr<<" PASS: V terms="<<nt<<(verifyN?", every coefficient of global leading-scale identity verified; scalar=":", compact reconstruction ONLY; scalar=")<<lead<<". Not a degree-70 square witness.\n";return 0;
 }catch(std::exception&e){std::cerr<<"ERROR "<<e.what()<<"\n";return 1;}}
