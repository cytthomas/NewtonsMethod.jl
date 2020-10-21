using Test
using NewtonsMethod

@testset "NewtonsMethod.jl" begin

    f1(x) = x^3 + 3*x^2 - 90*x + 216    # first equation with real root
    f1′(x) = 3*x^2 + 6*x - 90
    (x1a, difference1a, iteration1a) = newtonroot(f1, f1′)                      
    (x1b, difference1b, iteration1b) = newtonroot(f1)                           
    (x1c, difference1c, iteration1c) = newtonroot(f1, x₀ = BigFloat(0.0), tol = 1E-100)        
    (x1d, difference1d, iteration1d) = newtonroot(f1, maxiter = 5)              
    (x1e, difference1e, iteration1e) = newtonroot(f1, tol = 1E-10)     
    
    #testing if solutions are actually roots 
    @test f1(x1a) ≈ 0        
    @test f1(x1b) ≈ 0          
    @test f1(x1c) ≈ 0

    @test iteration1d <= 5           # testing if maxiter works
    @test difference1e < 1E-10         # testing if tol works

    f2(x) = 1 - x*sin(x*π/2)    # second equation with real root
    f2′(x) = -sin(x*π/2) - x*π/2*cos(x*π/2)
    (x2a, difference2a, iteration2a) = newtonroot(f2, f2′,x₀=2) 
    (x2b, difference2b, iteration2b) = newtonroot(f2, x₀=2) 
    (x2c, difference2c, iteration2c) = newtonroot(f2, x₀ = BigFloat(2.0))
    (x2d, difference2d, iteration2d) = newtonroot(f2, x₀=2, maxiter = 5)              
    (x2e, difference2e, iteration2e) = newtonroot(f2, x₀=2, tol = 1E-10)  
    (x2f, difference2f, iteration2f) = newtonroot(f2)       # here, choosing initial value 0 leads to derivative being 0. This should lead to output nothing for value   
    @test abs(f2(x2a)-0) < 1E-6
    @test abs(f2(x2b)-0) < 1E-6
    @test abs(f2(x2c)-0) < 1E-6
    @test iteration2d <= 5            
    @test difference2e < 1E-10
    @test x2f == nothing      # testing if value is nothing

    f3(x) = 3*exp(2*x) - 6*x^2  # third equation with real root
    f3′(x) = 6*exp(2*x) - 12*x
    (x3a, difference3a, iteration3a) = newtonroot(f3, f3′)
    (x3b, difference3b, iteration3b) = newtonroot(f3) 
    (x3c, difference3c, iteration3c) = newtonroot(f3, x₀ = BigFloat(0.0), tol = 1E-100) 
    (x3d, difference3d, iteration3d) = newtonroot(f3, maxiter = 5)              
    (x3e, difference3e, iteration3e) = newtonroot(f3, tol = 1E-10)  
    @test f3(x3a) ≈ 0
    @test f3(x3b) ≈ 0
    @test f3(x3c) ≈ 0
    @test iteration3d <= 5            
    @test difference3e < 1E-10

    f4(x) = x^2 + 2 # this equation has no real root. NewtonsMethod should output nothing for value
    f4′(x) = 2*x
    (x4a, difference4a, iteration4a) = newtonroot(f4, f4′, x₀=2)
    (x4b, difference4b, iteration4b) = newtonroot(f4, x₀=2) 
    (x4c, difference4c, iteration4c) = newtonroot(f4, x₀=2)
    (x4d, difference4d, iteration4d) = newtonroot(f4, x₀=2, maxiter = 5)              
    (x4e, difference4e, iteration4e) = newtonroot(f4, x₀=2, tol = 1E-10)  
    (x4f, difference4f, iteration4f) = newtonroot(f4)  
    @test x4a == nothing
    @test x4b == nothing
    @test x4c == nothing
    @test iteration4d <= 5            
    @test difference4e >= 1E-10  # since it should not converge, difference should be larger than tol
    @test x4a == nothing       # testing again if derivative equals 0 output nothing

end

