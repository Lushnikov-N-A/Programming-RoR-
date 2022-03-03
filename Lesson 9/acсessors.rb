# frozen_string_literal: true

module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*args)
      args.each do |arg_name|
        name_arg = "@#{arg_name}".to_sym
        arg_history = "@#{arg_name}_history".to_sym

        define_method(arg_name) { instance_variable_get(name_arg) }
        define_method("#{arg_name}_history".to_sym) { instance_variable_get(arg_history) }

        define_method("#{arg_name}=".to_sym) do |value|
          instance_variable_set(name_arg, value) unless name_arg.nil?
          if instance_variable_defined?(name_arg) && !name_arg.nil?
            history = instance_variable_get(arg_history)
            history ||= []
            history.push(instance_variable_get(name_arg))
            instance_variable_set(arg_history, history)
          end
        end
      end
    end

    def strong_attr_accessor(atr, atr_class_type)
      inst_var = "@#{atr}".to_sym
      define_method(atr) { instance_variable_get(inst_var) }

      define_method("#{atr}=".to_sym) do |value|
        raise 'Variable class erors!' unless value.is_a?(atr_class_type)

        instance_variable_set(inst_var, value)
      end
    end
  end
end
