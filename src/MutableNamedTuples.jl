module MutableNamedTuples

export MutableNamedTuple

struct MutableNamedTuple{N,T <: Tuple{Vararg{<:Ref}}}
    nt::NamedTuple{N, T}
end
MutableNamedTuple(;kwargs...) = MutableNamedTuple(NamedTuple{keys(kwargs.data)}(Ref.(values(kwargs.data))))

Base.keys(::MutableNamedTuple{names}) where {names} = names 
Base.values(mnt::MutableNamedTuple) = (x -> x[]).(values(getfield(mnt, :nt)))
refvalues(mnt::MutableNamedTuple) = values(getfield(mnt, :nt))

Base.NamedTuple(mnt::MutableNamedTuple) = NamedTuple{keys(mnt)}(values(mnt))
Base.Tuple(mnt::MutableNamedTuple) = values(mnt)


function Base.show(io::IO, mnt::MutableNamedTuple{names}) where {names}
    print(io, "MutableNamedTuple", NamedTuple(mnt))
end

Base.getproperty(mnt::MutableNamedTuple, s::Symbol) = getproperty(NamedTuple(mnt), s)

function Base.setproperty!(mnt::MutableNamedTuple, s::Symbol, x)
    i = findfirst(x -> x === s, keys(mnt))
    refvalues(mnt)[i][] = x
end


end # module
