class MoneyValidator < ActiveModel::Validator
  def validate(record)
    if options[:fields].any? do |field|
      # Check if number
      value = record.send(field)
      # only do the validation if something is entered
      if !(value.is_a? NilClass)
        # if either one of the condition is not met means improper money
        if !(value.is_a?( Numeric)  && decimals(value.to_f()) <=2 && value.to_f() >=0)
          record.errors[field] << " should be of proper cash value "
        end
      end
    end
    end
  end

# Get the no of decimal places
  def decimals(a)
    num = 0
    while(a != a.to_i)
      num += 1
      a *= 10
    end
    num
  end

end




