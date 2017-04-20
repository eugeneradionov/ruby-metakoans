def attribute(arg, &block)
  arg, inst_value = arg.first if arg.instance_of? Hash
  inst_var = "@#{arg}"

  define_method(arg) do
    inst_value = instance_exec(&block) if block_given?

    unless instance_variable_defined? inst_var
      instance_variable_set(inst_var, inst_value)
    end

    instance_variable_get(inst_var)
  end

  define_method("#{arg}=") { |value| instance_variable_set(inst_var, value) }
  define_method("#{arg}?") { !!instance_variable_get(inst_var) }
end
