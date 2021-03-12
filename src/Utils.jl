function is_little_endian()
    x::UInt16 = 0x0001
    lst = reinterpret(UInt8, [x])

    if lst[1] == 0x01
        return true
    else
        return false
    end
end

function is_big_endian()
    return !is_little_endian()
end


