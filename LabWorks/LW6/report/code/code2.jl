#подключаем модули
using Plots
using DifferentialEquations

#задаем начальные условия
N = 6666
I0 = 83
R0 = 6
S0 = N-I0-R0
a=0.01 #коэффициент заболеваемости
b=0.02 #коэффициент выздоровления

#состояние системы 
u0 = [S0, I0, R0]
#отслеживаемый промежуток времени
time = [0.0, 100.0] 

#сама система 
function M!(du, u, p, t)
	du[1] = -a*u[1]
	du[2] = a*u[1]-b*u[2]
	du[3] = b*u[2]
end

prob = ODEProblem(M!, u0, time)
sol = solve(prob, saveat=0.1)

const S = Float64[]
const I = Float64[]
const R = Float64[]

for u in sol.u
	s, i, r = u
	push!(S,s)
	push!(I,i)
	push!(R,r)
end
 
#постреоние графиков 
plt1 = plot( dpi = 300, size = (1200,700), title ="Динамика изменения числа людей в каждой из трех групп (второй случай)")

plot!( plt1, sol.t, S, color =:green, label ="Восприимчивые")

plot!( plt1, sol.t, I, color =:red, label ="Инфицированные")

plot!( plt1, sol.t, R, color =:blue, label ="Здоровые с иммунитетом")

savefig(plt1, "Jl_case2.png")