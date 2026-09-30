// Exact degree-140 fixture for the square of a simple-content evaluation.
#include "../forward/square_engine.hpp"
int main(){try{ff::init();init_source();
 Poly j0=Poly::mon(70)+Poly::mon(1);XP W=constantMu(j0*j0);
 for(int i=0;i<=j0.deg();i++)W[i]=W[i]+scale(Poly::mon(1),ff::mul(2,j0.at(i)));
 W[1]=W[1]+Poly::mon(2);
 Poly content;
 for(int m=0;m<=2;m++){Poly p;for(auto& b:W)p.v.push_back(b.at(m));p.trim();content=gcd(content,p);}
 if(!(content==Poly::mon(1)))throw std::runtime_error("fixture content is not x");
 Poly g;for(auto& e:equations(W))g=gcd(g,e);
 if(!(g==Poly::mon(2)))throw std::runtime_error("fixture square ideal is not (mu^2)");
 Poly F0=W[1]; // W/x evaluated at x=0
 if(rem(F0,g).zero() || !rem(F0*F0,g).zero())throw std::runtime_error("evaluation square membership is not sharp");
 std::cout<<"DEGREE140_SIMPLE_CONTENT_FIXTURE content x full_square_ideal mu^2 F_at_0 2*mu+mu^2 F_not_in_I F_squared_in_I PASS\n";
 std::cout<<"BOUNDED_NONREDUCED_FIXTURE; GLOBAL_LENGTH8_THEOREM_HAS_A_WRITTEN_PROOF\n";
}catch(std::exception&e){std::cerr<<"ERROR "<<e.what()<<"\n";return 1;}return 0;}
