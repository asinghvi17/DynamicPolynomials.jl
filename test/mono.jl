@testset "PolyVar and Monomial tests" begin
    @testset "polyvar macro index set" begin
        n = 3
        @polyvar x[1:n] y z[1:n-1]
        @test isa(x, Vector{PolyVar{true}})
        @test isa(y, PolyVar{true})
        @test isa(z, Vector{PolyVar{true}})
    end
    @testset "PolyVar" begin
        @test zero(PolyVar{true}) == 0
        @test one(PolyVar{false}) == 1
        @polyvar x
        @test zero(x) isa Term{true, Int}
        @test one(x) isa Term{true, Int}
    end
    @testset "Monomial" begin
        @test zero(Monomial{false}) == 0
        @test one(Monomial{true}) == 1
        @polyvar x
        @test_throws ArgumentError Monomial{true}([x], [1,0])
        @test zero(x^2) isa Term{true, Int}
        @test one(x^2) isa Term{true, Int}
    end
    @testset "MonomialVector" begin
        @polyvar x y
        @test_throws ArgumentError MonomialVector{true}([x], [[1], [1,0]])
        X = MonomialVector([x, 1, x*y])
        @test variables(X) == [x, y]
        @test X.Z == [[1, 1], [1, 0], [0, 0]]
        @test isa(MonomialVector{true}([1]), MonomialVector{true})
        @test isa(MonomialVector{false}([1]), MonomialVector{false})
    end
end
