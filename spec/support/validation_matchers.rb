module ValidationMatchers

  class Validate
    include RSpec::Matchers::Pretty

    attr_accessor :attribute, :values, :target, :results, :value_description

    def initialize(attribute)
      self.attribute = attribute
    end

    def to_be(*values)
      self.values = values
      self
    end

    def to_be_blank
      self.value_description = "blank"
      self.values = [ nil, "", "   " ]
      self
    end

    def matches?(target)
      check_arguments
      self.target = target
      validate
      found_errors?
    end

    def failure_message_for_should
      "validation failed for #{attribute} of #{target.inspect}:\n"
    end

    def failure_message_for_should_not
      "Matcher does not support should_not"
    end

    def description
      raise NotImplementedError
    end

    private

    def found_errors?
      raise NotImplementedError
    end

    def check_arguments
      raise "You must specify some values" if values.blank?
    end

    def results
      @results ||= Hash.new { |hash, key| hash[key] = [] }
    end

    def validate
      store_old_values
      values.each { |value| validate_value(value) }
      restore_old_values
    end

    def validate_value(value)
      set(value)
      target.valid?
      collect_errors(value)
    end

    def store_old_values
      old_values[attribute] = target.__send__(attribute)
    end

    def restore_old_values
      target.__send__("#{attribute}=", old_values[attribute])
    end

    def old_values
      @old_values ||= {}
    end

    def collect_errors(value)
      results[value].push(*target.errors[attribute])
    end

    def set(value)
      target.__send__("#{attribute}=", value)
    end

    def value_description
      @value_description || _pretty_print(values)
    end

  end

  class ValidateAllowed < Validate

    def failure_message_for_should
      message = super
      results.each do |value, errors|
        unless errors.empty?
          message += "expected #{value.inspect} to be valid, but got: #{to_sentence(errors)}\n"
        end
      end
      message
    end

    def description
      "allow #{attribute} to be #{value_description}"
    end

    private

    def found_errors?
      results.all? { |value, errors| errors.blank? }
    end

  end

  class ValidateDenied < Validate

    def failure_message_for_should
      message = super
      results.each do |value, errors|
        if errors.empty?
          message += "expected #{value.inspect} to be invalid, but it wasn't\n"
        end
      end
      message
    end

    def description
      "deny #{attribute} to be #{value_description}"
    end

    private

    def found_errors?
      results.none? { |value, errors| errors.blank? }
    end

  end

  # :call-seq:
  #   should allow(attribute).to_be(value1, value2, ...)
  #   should allow(attribute).to_be_blank
  #
  # Checks the validity of the target by trying out values and checking that
  # they don't contain an error on the specified attribute.
  #
  # When you use <tt>to_be_blank</tt>, it will try out some blank values.
  #
  # For this matcher to work, the target must include ActiveModel::Validations.
  # ActiveRecord models do this by default.
  #
  # Specifying that an attribute allows a value to be something is not
  # something special. So for this matcher to be useful you'd normally specify
  # some values to be denied by the validators too.
  #
  # == Examples
  #
  #   # The user model validates that email addresses are valid, but to check
  #   # that we didn't make our validation too restrictive, we check that valid
  #   # email addresses are still valid.
  #   user.should allow(:email).to_be('foo@bar.com', 'foo+bar@baz.com')
  #   user.should deny(:email).to_be('foobar.com', 'foo@bar')
  #
  #   # The user model validates the presence of the login attribute
  #   user.should deny(:login).to_be_blank
  #
  # == Warning
  #
  # +should_not+ +allow+ is not supported
  def allow(attribute)
    ValidateAllowed.new(attribute)
  end

  # :call-seq:
  #   should deny(attribute).to_be(value1, value2, ...)
  #   should deny(attribute).to_be_blank
  #
  # Requires that every value passed to the attribute will trigger a validation
  # error on that attribute.
  #
  # See the +allow+ matcher for more details.
  #
  # == Examples
  #
  #   # The user model validates the presence of the login attribute
  #   user.should deny(:login).to_be_blank
  #
  # == Warning
  #
  # +should_not+ +deny+ is not supported
  def deny(attribute)
    ValidateDenied.new(attribute)
  end

end
