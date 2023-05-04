vel = 30;
lastVel = 30;
ud = 0.0;
vels = zeros(4, 100);
tm = 6;
t0 = 0;
hydrAcc = 0;

for i = 1:1:100,
  acc = (vel -lastVel) /tm *100;
  if i <50,
    mu = 0.8;
    accd = -7;
  else,
    mu = 0.6;
    accd = -5;
  endif
  [total, brake, motor] = smc(vel, acc, accd, mu, hydrAcc);
  vels(1, i) = vel;
  vels(2, i) = -total;
  vels(3, i) = -brake;
  vels(4, i) = -motor;
  hydrAcc = brake;
  dVel = tm /100 *total;
  lastVel = vel;
  vel += dVel;
  if vel <= 0 && t0 == 0,
    t0 = tm *i /100;
  endif
end;

efficiency = sum(vels(4, :)) /sum(vels(2, :))
t = linspace(0, tm);
plot(t, vels, "linewidth", 2);
line([t0, t0], [-10, 30], "linewidth", 2);
grid on;
xlabel('Time[s]');
legend('Velocity[m/s]', 'Total decceleration[m/s^2]', 'Hydraulic decceleration[m/s^2]', 'Motor decceleration[m/s^2]');
text(t0 -1, 15, [num2str(t0), 's, stopped']);
text(0, 20, ['Recovery efficiency: ',num2str(efficiency)]);
