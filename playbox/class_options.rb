classes = options.select{|k, v| k.to_s =~ /_class$/} # extract keys ending with _class
options.delete_if {|k,v| classes.include? k} # remaining keys are normal options

# set config_class etc. using hash
classes.each_pair do |name, clazz|
  meth = "#{name}_class="
  send(meth, clazz) if self.respond_to?(meth) && clazz.is_a(Class)
end
