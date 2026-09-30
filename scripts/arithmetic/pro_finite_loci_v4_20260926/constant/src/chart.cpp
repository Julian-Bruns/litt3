#include "laurent.hpp"
int main(){init_curve();auto basis=load_basis();
// Rebase the six translation directions to h,w,e,f and two free coordinates.
std::vector<std::vector<F>>m(4,std::vector<F>(7));
for(int b=0;b<6;b++){m[0][b]=basis[b+1][0].coef(4,2);m[1][b]=basis[b+1][2].coef(19,0);m[2][b]=basis[b+1][2].coef(12,2);m[3][b]=basis[b+1][3].coef(16,2);}
std::vector<Source> cs(7);cs[0]=basis[0];std::vector<int>free;
for(int k=0;k<4;k++){auto a=m;a[k][6]=1;auto piv=rref(a,6);if(piv.size()!=4)throw std::runtime_error("four-coordinate rank failure");for(int b=0;b<4;b++)for(int s=0;s<4;s++)cs[k+1][s]=cs[k+1][s]+scale(basis[piv[b]+1][s],a[b][6]);if(k==0){for(int j=0;j<6;j++)if(std::find(piv.begin(),piv.end(),j)==piv.end())free.push_back(j);for(int b=0;b<2;b++){cs[b+5]=basis[free[b]+1];for(int j=0;j<4;j++)for(int s=0;s<4;s++)cs[b+5][s]=cs[b+5][s]-scale(basis[piv[j]+1][s],a[j][free[b]]);}}}
F eps=FF::add(24,FF::add(FF::mul(4,25),FF::mul(23,FF::pow(25,3))));
F eta=FF::add(11,FF::add(FF::mul(18,FF::pow(25,2)),FF::mul(20,FF::pow(25,3))));
F cd=FF::add(3,FF::add(FF::mul(10,25),FF::add(FF::pow(25,2),FF::mul(14,FF::pow(25,3)))));
LP h=lm(1),w=lm(0,1),r=lm(0,0,1),s=lm(0,0,0,1);LP z=scale(w,FF::div(2,eps));
LP e=-scale(w*z,cd)-div_mono(LP(eta),scale(z,24));
LP f=-scale(w*w,FF::inv(eps))-scale(power(z,5),FF::div(8,24));
std::array<LP,6>par={h,w,e,f,r,s};PSource ps;for(int k=0;k<4;k++){ps[k]=pcurve(cs[0][k]);for(int j=0;j<6;j++)add_scaled(ps[k],cs[j+1][k],par[j]);}
auto[Fj,rho]=fjets(ps);for(int j=0;j<4;j++)if(!Fj[j].empty())throw std::runtime_error("F0..F3 nonzero");
std::array<std::array<LP,3>,2> eq;
for(int i=0;i<2;i++)for(auto[ex0,v]:Fj[4+i]){Ex ex=ex0;int d=ex[2]+ex[3];if(d>1||ex[2]<0||ex[3]<0)throw std::runtime_error("kernel system nonlinear");int j=ex[2]?1:(ex[3]?2:0);ex[2]=ex[3]=0;accumulate(eq[i][j],ex,v);}
LP det=eq[0][1]*eq[1][2]-eq[0][2]*eq[1][1];
std::cout<<"kernel determinant=";json_lp(std::cout,det);std::cout<<"\n";
LP rr=div_mono(-eq[0][0]*eq[1][2]+eq[0][2]*eq[1][0],det);
LP ss=div_mono(-eq[0][1]*eq[1][0]+eq[0][0]*eq[1][1],det);
for(auto&c:ps)for(auto&p:c)for(auto&v:p)v=subrs(v,rr,ss);
auto[Ffinal,rfinal]=fjets(ps);for(int j=0;j<6;j++)if(!Ffinal[j].empty())throw std::runtime_error("F0..F5 failed after repair");
const F ac[]={89654,311173,214299,163299,315361,33043,356725,245794};LP psi;for(int i=0;i<8;i++)psi=psi+lm(0,3*i,0,0,ac[i]);psi=psi+lm(1,4,0,0,299833)+lm(1,7,0,0,232505);
LP expected=div_mono(psi,lm(0,3,0,0,FF::pow(299619,2)));
if(Ffinal[6]!=expected)throw std::runtime_error("F6 formula failed");
std::cout<<"symbolic F0..F5=0 and supplied F6 identity PASS\n";
std::ofstream out("evidence/chart.json");out<<"{\"variables\":[\"h\",\"w\",\"r\",\"s\"],\"kernel_basis_free_indices\":["<<free[0]<<","<<free[1]<<"],\"kernel_determinant\":";json_lp(out,det);out<<",\"kernel_solution\":[";json_lp(out,rr);out<<",";json_lp(out,ss);out<<"],\"F6\":";json_lp(out,Ffinal[6]);out<<",\"G\":[";size_t terms=0;
for(int k=0;k<4;k++){if(k)out<<",";out<<"[";for(int j=0;j<3;j++){if(j)out<<",";out<<"[";for(size_t i=0;i<ps[k][j].size();i++){if(i)out<<",";json_lp(out,ps[k][j][i]);terms+=ps[k][j][i].size();}out<<"]";}out<<"]";}out<<"]}\n";
std::ofstream text("evidence/chart.txt");for(auto&c:ps)for(auto&p:c){text<<p.size()<<"\n";for(auto&v:p){text<<v.size();for(auto[ex,c]:v)text<<" "<<ex[0]<<" "<<ex[1]<<" "<<c;text<<"\n";}}
std::cout<<"source Laurent monomials="<<terms<<"\n";
// Exact checks at parameters spanning several different q values (not a geometric exclusion).
for(F hv:{1u,2u,5u,25u,1024u})for(F wv:{2u,3u,5u,25u}){auto src=evaluate(ps,hv,wv);if(!equations(src,true).empty())throw std::runtime_error("specialized source failed");if(pole(div_y(src[0],2))!=12)throw std::runtime_error("D2 pole failure");}
std::cout<<"20 exact specialized source checks PASS\n";
}
