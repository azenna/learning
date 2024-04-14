from math import *

wv = 25.0
g = -9.8
t = 3
dist = 45

# 45 = cos(a)*wv*t
# -(.5*g*t**2)/(wv*t) = sin(a)
angle_elev = acos(dist/(wv*t))
print(f"angle of elev: {degrees(angle_elev)}")

hpv = cos(angle_elev)*wv
print(f"hightest point velocity {hpv}")

y = .5*g*t**2 + sin(angle_elev)*wv*t 
print(f"y {y}")

vyf = g*t + sin(angle_elev)*wv
vfx = cos(angle_elev)*wv

vf_mag = hypot(vyf, vfx)
print(f"final velocity {vf_mag}")

def circular_acceleration(vel, r): return vel**2/r
r = 14
ls = 6.2

print(f"acceleration: {circular_acceleration(ls, r)}")

print(f"period: {2 * pi * r / ls}")

bar_h = 3.048
dist = 10.9728

min = atan(10/36)
print(f"min {degrees(min)}")

a = radians(38)
y = sin(a)
x = cos(a)

# 0 = v0^2 + 2*g*bar_h
# 0 = (sin(a)*v0)^2 + 2*g*bar_h
# -2*g*bar_h = (sin(a)*v0)^2
# sqrt(-2*g*bar_h) = sin(a)*v0
# v0 = sqrt(-2*g*bar_h)/sin(a)
v0 = sqrt(-2*g*bar_h)/sin(a)
print(f"initial velocity {v0}")


ve = 12.0
ra = radians(30)
