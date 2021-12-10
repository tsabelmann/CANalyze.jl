"""
    is_little_endian() -> Bool

Returns whether the system has little-endian byte-order

# Returns
- `Bool`: The system has little-endian byte-order
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
    is_big_endian() -> Bool

Returns whether the system has big-endian byte-order

# Returns
- `Bool`: The system has big-endian byte-order
"""
function is_big_endian()::Bool
    return !is_little_endian()
end
