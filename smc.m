# 滑模控制函数
function [totalAcc, hydrAcc, motAcc] = smc(vel, acc, accd, mu, hydrAcc)
  # 四种工作模式对应四种角减速度
  motorAngularAcce = [-38.43, -39.14];
  R = 0.28;
  motAccs = motorAngularAcce *R /2;
  k = 0.01;
  eta = 0.1;
  c = 1;
  e = acc -accd;
  s = c *e;
  stopped = 1;
  if vel < 0.01,
    stopped = 0;
  endif
  
  if accd < motAccs(2),
    motAcc = stopped *motAccs(2);
  elseif accd < motAccs(1),
    motAcc = stopped *Accd;
  else,
    motAcc = 0;
  endif
  
  hydrAcc = stopped *(hydrAcc -k *s -eta *sign(s));
  if hydrAcc > 0,
    hydrAcc = 0;
  endif
  totalAcc = motAcc +hydrAcc;
  
  if totalAcc < -mu *9.8,
    totalAcc = -mu *9.8;
    hydrAcc = totalAcc -motAcc;
  endif
end;
