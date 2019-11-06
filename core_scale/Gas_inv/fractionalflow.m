function fw=fractionalflow(l,reservoir)

miuo=reservoir.fluid.oil.miu;
miuw=reservoir.fluid.water.miu;
Bo=reservoir.fluid.oil.B;
Bw=reservoir.fluid.water.B;

Sw=reservoir.Sw(l);
So=reservoir.So(l);


krw=waterrelperm(Sw,reservoir);
kro=waterrelperm(So,reservoir);


ft=krw/miuw/Bw+kro/miuo/Bo;

fw=(krw/miuw/Bw)/ft;