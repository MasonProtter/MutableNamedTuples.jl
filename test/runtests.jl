using Test, MutableNamedTuples

@testset "tests" begin
    mnt = MutableNamedTuple(a=1, b="hi")
    @test mnt isa MutableNamedTuple
    mnt.a = 2

    @test mnt.a == 2
    @test NamedTuple(mnt) == (;a=2, b="hi")
end
