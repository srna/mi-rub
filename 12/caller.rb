def cat_a
    puts caller
end
def cat_b
    cat_a
end
def cat_c
    cat_b
end
cat_c