module NewtonsMethod

using ForwardDiff, LinearAlgebra

"""
    newtonroot(f, f′; x₀ = 0, tol = 1E-7, maxiter = 1000)

    Solves f(x)=0 using Newton's Method.
        
"""

function newtonroot(f, f′; x₀ = 0, tol = 1E-7, maxiter = 1000)
    x = x₀
    normdiff = Inf
    iter = 0
    while normdiff > tol && iter < maxiter

        if f′(x)==0
            println("Derivative equals to 0. Process terminated.")
            return (value = nothing, normdiff = normdiff, iter = iter)             
        end

        x_new = x - f(x)/f′(x)
        normdiff = norm(x_new - x)
        x = x_new
        iter = iter + 1
    end

    if iter == maxiter
        println("Max iteration reached. Process terminated.")
        return (value = nothing, normdiff = normdiff, iter = iter)       
    else
        return (value = x, normdiff = normdiff, iter = iter) 
    end
end

function newtonroot(f; x₀=0, tol = 1E-7, maxiter =  1000)
    D(f) = x -> ForwardDiff.derivative(f, x)
    newtonroot(f, D(f); x₀ = x₀, tol = tol, maxiter = maxiter)
end

export newtonroot

end