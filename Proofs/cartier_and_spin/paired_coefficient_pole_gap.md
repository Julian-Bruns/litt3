# Proof of the paired-coefficient pole gap

The coefficient of W^(m-j) is f a_j and is, up to sign, the
(m+j)-th elementary symmetric function of the 2m roots. Its pole
is at most the sum of the m+j largest root poles. This sum is at
most P+js: all m large roots are included, followed by j small roots.
The valuation inequality for a sum and pole(f a_j)=h+pole(a_j)
prove the first assertion, including the case a_j=0.

The coefficient of W^(2m-j) is a_j. If p_j>p_(j+1), the product
of the j largest roots is the unique term of greatest pole in that
elementary symmetric function. Its coefficient is a unit, regardless
of characteristic. There is no cancellation, so pole(a_j)=p_1+...+p_j.
Combine with the first inequality and subtract this partial sum.

For the application, etaleness splits the completed degree-ten algebra
into ten copies of the base completion. The prescribed divisor of
q=f+b^5 gives five b-roots with pole at most1, and five with poles
2+m_i. If exactly four m_i are positive, p_4>p_5=2. At j=4 the
criterion requires p_5>=7-4=3, a contradiction.

The m=5 argument was supplied in the latest Pro reply. The formulation
for arbitrary m, s and h is the local continuation here; its proof
uses only the two paired coefficient positions and the unique-largest
product. No computational certificate is needed. It is a reusable
necessary criterion, not an assertion that every higher-degree
primitive polynomial has this special paired shape.
