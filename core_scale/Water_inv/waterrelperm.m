function krw=waterrelperm(Sw,reservoir)


Swr=reservoir.relperm.Swr;
nw=reservoir.relperm.nw;
Sor=reservoir.relperm.Sor;

if Sw>1-Sor
    Sw=1-Sor;
end

if Sw<Swr
    Sw=Swr;
end


kwep=reservoir.relperm.kwep;

S=(Sw-Swr)/(1-Swr-Sor);


krw=kwep*S^nw;