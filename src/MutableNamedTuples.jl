module MutableNamedTuples

export MutableNamedTuple, MNT

struct MutableNamedTuple{N,T <: Tuple{Vararg{<:Ref}}}
    nt::NamedTuple{N, T}
end

MutableNamedTuple(; kwargs...) = MutableNamedTuple(NamedTuple{keys(kwargs)}(Ref.(values(values(kwargs)))))

function MutableNamedTuple{names}(tuple::Tuple) where names
    MutableNamedTuple(NamedTuple{names}(Ref.(tuple)))
end

const MNT = MutableNamedTuple

Base.keys(::MutableNamedTuple{names}) where {names} = names 
Base.values(mnt::MutableNamedTuple) = getindex.(values(getfield(mnt, :nt)))
refvalues(mnt::MutableNamedTuple) = values(getfield(mnt, :nt))

Base.NamedTuple(mnt::MutableNamedTuple) = NamedTuple{keys(mnt)}(values(mnt))
Base.Tuple(mnt::MutableNamedTuple) = values(mnt)


function Base.show(io::IO, mnt::MutableNamedTuple{names}) where {names}
    print(io, "MutableNamedTuple", NamedTuple(mnt))
end

Base.getproperty(mnt::MutableNamedTuple, s::Symbol) = getfield(getfield(mnt, :nt), s)[]

function Base.setproperty!(mnt::MutableNamedTuple, s::Symbol, x)
    nt = getfield(mnt,:nt)
    getfield(nt,s)[] = x
end
Base.propertynames(::MutableNamedTuple{T,R}) where {T,R} = T

Base.length(mnt::MutableNamedTuple) = length(getfield(mnt, :nt))
Base.iterate(mnt::MutableNamedTuple, iter=1) = iterate(NamedTuple(mnt), iter)
Base.firstindex(mnt::MutableNamedTuple) = 1
Base.lastindex(mnt::MutableNamedTuple) = lastindex(NamedTuple(mnt))
Base.getindex(mnt::MutableNamedTuple, i::Int) = getfield(NamedTuple(mnt), i)
Base.getindex(mnt::MutableNamedTuple, i::Symbol) = getfield(NamedTuple(mnt), i)
function Base.indexed_iterate(mnt::MutableNamedTuple, i::Int, state=1) 
    Base.indexed_iterate(NamedTuple(mnt), i, state) 
end

end # module
