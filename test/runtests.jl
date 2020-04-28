using Test, MutableNamedTuples

@test (mnt = MutableNamedTuple(a=1, b="hi")) isa MutableNamedTuple
mnt.a = 2

@test mnt.a == 2
@test NamedTuple(mnt) = (;a=2, b="hi")
