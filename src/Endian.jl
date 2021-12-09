"""
    is_little_endian()    

    Returns if the system has little-endian byte-order.

```jldoctest
is_little_endian()

# output

false
```
"""
function is_little_endian()::Bool
    x::UInt16 = 0x0001
    lst = reinterpret(UInt8, [x])

    if lst[1] == 0x01
        return true
    else
        return false
    end
end

function is_big_endian()::Bool
    return !is_little_endian()
end
