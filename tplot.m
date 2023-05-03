vel = 30;
ud = 0.0;
vels = zeros(4, 100);
tm = 3;
t0 = 0;

for i = 1:1:100,
  [total, brake] = smc(vel);
  vels(1, i) = vel;
  vels(2, i) = -total;
  vels(3, i) = -brake;
  vels(4, i) = -total +brake;
  dVel = tm /100 *total;
  vel += dVel;
  if abs(vel) <= 0.01 && t0 == 0,
    t0 = tm *i /100;
  endif
end;

t = linspace(0, tm);
plot(t, vels, "linewidth", 2);
line([t0, t0], [-20, 80], "linewidth", 2);
grid on;
xlabel('Time[s]');
legend('Velocity[m/s]', 'Total decceleration[m/s^2]', 'Hydraulic decceleration[m/s^2]', 'Motor decceleration[m/s^2]');
text (t0 +0.1, 20, "2.07s, stopped");