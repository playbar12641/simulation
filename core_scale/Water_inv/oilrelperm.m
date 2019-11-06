function kro=oilrelperm(So,reservoir)


Swr=reservoir.relperm.Swr;
no=reservoir.relperm.no;
Sor=reservoir.relperm.Sor;

if So>1-Swr
    So=1-Swr;
end

if So<Sor
    So=Sor;
end

koep=reservoir.relperm.koep;

S=(So-Sor)/(1-Swr-Sor);
%S=(So-Sor)/(1-Sor);
kro=koep*S^no;