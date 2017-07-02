gen ln1=ln(price1)
gen ln2=ln(price2)
gen ln3=ln(price3)
gen ln4=ln(price4)
gen ln5=ln(price5)

gen f1=ln1-ln2
gen f2=ln2-ln3
gen f3=ln3-ln4
gen f4=ln4-ln5

gen f1y1=f1+ln1
gen f2y2=f2+ln1
gen f3y3=f3+ln1
gen f4y4=f4+ln1

gen l1=-ln1[_n-1]
gen l2=-ln1[_n-2]
gen l3=-ln1[_n-3]
gen l4=-ln1[_n-4]

gen y1y1=l1+ln1
gen y2y1=l2+ln1
gen y3y1=l3+ln1
gen y4y1=l4+ln1
