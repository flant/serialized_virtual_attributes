require "serialized_virtual_attributes/version"
require 'active_support'

module SerializedVirtualAttributes
  extend ActiveSupport::Concern

  included do
    class_attribute :serialized_virtual_attributes
  end

  module ClassMethods
    def serialized_virtual_attribute(*args)
      options = args.extract_options!
      to = options[:to]
      return unless self.column_names.include?(to.to_s)
      
      raise ArgumentError.new("option 'to' not provided or it is not serialized to hash") if to.blank? or self.serialized_attributes[to.to_s].try(:object_class) != Hash

      typecast = options[:typecast]

      self.serialized_virtual_attributes ||= {}
      self.serialized_virtual_attributes[to] ||= Set.new

      prefix = options[:prefix]

      args.each do |a|
        accessor_name = prefix.blank? ? a : :"#{prefix}_#{a}"
        self.serialized_virtual_attributes[to] += [accessor_name]
        class_eval "
          def #{accessor_name}
            self.#{to} = {} if self.#{to}.blank?

            self.#{to}[:#{a}]
          end
        "

        if typecast.blank?
          class_eval "
            def #{accessor_name}=(value)
              self.#{to} = {} if self.#{to}.blank?

              #{to}_will_change! unless value == self.#{to}[:#{a}]

              self.#{to}[:#{a}] = value
            end
          "
        else
          class_eval "
            def #{accessor_name}=(value)
              self.#{to} = {} if self.#{to}.blank?

              value = #{typecast.name}(value) rescue nil
              #{to}_will_change! unless value == self.#{to}[:#{a}]

              self.#{to}[:#{a}] = value
            end
          "
        end

        unless ActiveRecord::VERSION::MAJOR >= 4 or options[:accessible] == false
          class_eval "
            attr_accessible :#{accessor_name}
          "
        end
      end
    end
  end
end

ActiveSupport.on_load :active_record do
  ActiveRecord::Base.send :include, ::SerializedVirtualAttributes
end
