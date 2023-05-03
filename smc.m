# 滑模控制函数
function [totalAcc, hydrAcc] = smc(vel)
  # 四种工作模式对应四种角减速度
  motorAngularAcce = [-38.43, -39.14, -158.84, -240.82];
  ud = 0.0;
  R = 0.28;
  k = 2;
  eta = 1.1;
  c = 1;
  e = (vel -ud) /R;
  s = c *e;
  if vel > 25,
    motAngAcc = motorAngularAcce(4);
  elseif vel > 20,
    motAngAcc = motorAngularAcce(3);
  elseif vel > 15,
    motAngAcc = motorAngularAcce(2);
  elseif vel > 1,
    motAngAcc = motorAngularAcce(1);
  else,
    motAngAcc = 0;
  endif
  
  hydrAngularAcc = -motAngAcc -k *s -eta *sign(s);
  if hydrAngularAcc > 0,
    hydrAngularAcc = 0;
  endif
  totalAngularAcc = motAngAcc +hydrAngularAcc;
  totalAcc = R *totalAngularAcc;
  hydrAcc = R *hydrAngularAcc;
end;
