require 'active_support/concern'
require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/class/attribute'
require 'active_model/naming'
require 'active_model/conversion'
require 'tire'

module ConfigurableSearch

  extend ActiveSupport::Concern

  included do
    extend ActiveModel::Naming
    include ActiveModel::Conversion
    attr_reader :queries
    private
    class_attribute :search_source
  end

  def initialize(params)
    @queries = self.class.allowed_params.inject({}) do |memo,(k,v)|
      value = params[k]

      if value && (v[:options].blank? || v[:options].is_a?(Symbol) || Array(value).all?{|a| v[:options].include? a})
        memo[k] = value
      else
        memo[k] = v.fetch(:default, '')
      end
      memo
    end
  end

  def results
    @results ||= query
  end

  def query
    raise NotImplementedError, 'Implement #query in your search classes'
  end

  def queries_with_options
    @queries_with_options ||= queries.inject({}) do |memo,(k,v)|
      memo[k] = {}
      memo[k][:value] = v.is_a?(Array) ? v.join(',') : v
      memo[k][:label] = self.class.allowed_params[k][:label]

      if options = self.class.allowed_params[k][:options]
        options = instance_eval(&options) if options.respond_to?(:to_proc)
        memo[k][:options] = options
      end
      memo
    end
  end

  def options_for(key)
    queries_with_options[key].fetch(:options, [])
  end

  protected

  def search(options = {}, &block)
    options = options.merge(wrapper: self.class.search_source)
    s = Tire::Search::Search.new(self.class.search_source.tire.index.name, options)
    yield s
    s.results
  end

  module ClassMethods
    def search_for(source_class)
      self.search_source = source_class
    end

    def allowed_params
      @allowed_params ||= {}
    end

    def search_option(name, opts = {})
      allowed_params[name] = opts
    end
  end

end
