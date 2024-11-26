using DataFrames
using Plots

# Definimos los vectores x[n] y h[n]
x = [0, 0, -2, 0, -1, 3, 0, 0]
h = [0, 0, 1, 2, 0, -1, 0, 0]

# Longitudes
len_x = length(x)
len_h = length(h)

# Calcular el rango de n para y[n]
n_start = -len_h + 1
n_end = len_x
n_range = n_start:n_end

# Resultado de la convolución
y = []
records = DataFrame(n = Int[], h_shifted = Vector{Vector{Float64}}[], product = Vector{Vector{Float64}}[], sum = Float64[])

# Realizamos la convolución paso a paso
for n in n_range
    # Desplazar y reflejar h
    h_shifted = zeros(len_x + len_h - 1)
    for k in 1:len_h
        if n - k + 1 >= 1 && n - k + 1 <= len_x
            h_shifted[n - k + 1] = h[k]
        end
    end
    
    # Multiplicar x con h_shifted
    product = x .* h_shifted[1:len_x]
    sum_product = sum(product)
    push!(y, sum_product)
    
    # Registrar los resultados en el dataframe
    push!(records, (n, h_shifted[1:len_x], product, sum_product))
end

# Imprimir la tabla completa
println(records)

# Graficar los resultados finales
plot(y, label="y[n] = x[n] * h[n]", marker=:circle, xlabel="n", ylabel="Amplitud", title="Convolución paso a paso")
