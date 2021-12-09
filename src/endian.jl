"""
is_little_endian()    

Returns `true` if the system has little-endian byte-order.
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

"""
is_big_endian()    

Returns `big` if the system has big-endian byte-order.
"""
function is_big_endian()::Bool
    return !is_little_endian()
end
