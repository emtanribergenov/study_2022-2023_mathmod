#подключаем модули
using Plots
using DifferentialEquations

#задаем коэффициенты согласно варианту 
a = 0.32
b = 0.04
c = 0.42
d = 0.02

#задаем начальные условия
x0 = c / d
y0 = a / b

#состояние системы 
u0 = [x0, y0]
#отслеживаемый промежуток времени
time = [0.0, 120.0] 

print("x0 = ")
println(x0)
print("y0 = ")
println(y0)

#сама система 
function M!(du, u, p, t)
	du[1] = -a*u[1]+b*u[1]*u[2]
	du[2] = c*u[2]-d*u[1]*u[2]
end

prob = ODEProblem(M!, u0, time)
sol = solve(prob, saveat=0.05)

const X = Float64[]
const Y = Float64[]

for u in sol.u
	x, y = u
	push!(X,x)
	push!(Y,y)
end
 
#постреоние графиков 
plt1 = plot( dpi = 300, size = (700,500), title ="Изменение численности хищников и численности жертв")

plot!( plt1, sol.t, X, color =:red, label ="Численность хищников")

plot!( plt1, sol.t, Y, color =:blue, label ="Численность жертв")

savefig(plt1, "Jl2.png")

plt2 = plot( dpi = 300, size = (700,500), title ="График зависимости численностей")

plot!( plt2, Y, X, color =:red, label ="Зависимость численности хищников от численности жертв")

savefig(plt2, "Jl_php2.png")