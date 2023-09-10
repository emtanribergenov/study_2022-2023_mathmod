#подключение модулей
using Plots
using DifferentialEquations

n = 4.2 #разница в скорости 
k = 16.4 #начальное расстояние от лодки до катера

#условия 1-го случая
r0_1 = k/(n+1)
theta0_1 = 0
T_1 = collect(LinRange(theta0_1, 2*pi, 1000))

#условия 2-го случая
r0_2 = k/(n-1)
theta0_2 = -pi
T_2 = collect(LinRange(theta0_2, pi, 1000))

t = collect(LinRange(0.0001, 25, 1000))

#функция, описывающая движение катера береговой охраны 
function f1(r,p,t)
return r/sqrt(n^2-1)
end

#функция, описывающая движение лодки браконьеров
function f2(t)
return tan(3/4*pi)*t
end

#моделирование движения лодки браконьеров
r1=[]
theta1=[]
for i in t
push!(r1, sqrt(i^2 + f2(i)^2))
push!(theta1, atan(f2(i)/i))
end

#решение 1-го случая
problem1 = ODEProblem(f1, r0_1, (theta0_1, 2*pi))
solution1 = solve(problem1, saveat=T_1)

#решение 2-го случая
problem2 = ODEProblem(f1, r0_2, (theta0_2, pi))
solution2 = solve(problem2, saveat=T_2)

#график в 1 случае
plot(solution1, proj=:polar, color=:red, label="Катер")
plot!(theta1, r1, proj=:polar, color=:purple, label="Лодка")

#сохранение графика
savefig("C:\\work\\study\\2022-2023\\Математическое_моделирование\\mathmod\\LabWorks\\LW2\\report\\images\\L2_jl_01.png")

#график в 2 случае
plot(solution2, proj=:polar, color=:red, label="Катер")
plot!(theta1, r1, proj=:polar, color=:purple, label="Лодка")

#сохранение графика
savefig("C:\\work\\study\\2022-2023\\Математическое_моделирование\\mathmod\\LabWorks\\LW2\\report\\images\\L2_jl_02.png")
