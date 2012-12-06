class Demo
    @@var = 99
    CONST = 1.23
private
    def private_method
    end
protected
    def protected_method
    end
public
    def public_method
        @inst = 1
        i = 1
        j = 2
        local_variables
    end
    def Demo.class_method
    end
end

d= Demo.new
p d.public_method.to_a
p d.instance_variables.to_a