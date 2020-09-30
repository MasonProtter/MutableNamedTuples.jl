using Test, MutableNamedTuples

@testset "tests" begin
    mnt = MutableNamedTuple(a=1, b="hi")
    @test mnt isa MutableNamedTuple
    mnt.a = 2

    @test mnt.a == 2
    @test NamedTuple(mnt) == (;a=2, b="hi")
    @test collect(mnt) == [2;"hi"]
    @test length(mnt) == 2 
    @test mnt[1] == 2
    @test mnt[2] == "hi"
    @test mnt[:a] == 2
    @test mnt[:b] == "hi"

    mnt2 = MutableNamedTuple{(:a,:b)}((2,"hi"))
    @test NamedTuple(mnt2) == NamedTuple(mnt)
end


