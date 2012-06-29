class Car
  def confusing_end
    variable = "end"
    variable <<-eos
      end
    eos
  end

  def good_method()
    a_object = SomeClass.new
    a_object.do_something
  end

  def many_responsibilities
    case some_variable
    when :wheel then Wheel.rotate
    when :clutch then Clutch.next
    when :door then Door.close
    else
      do_nothing
    end
  end

  # ok
  def builder_method
    Wheel.rotate
    Clutch.next
    Door.close
  end

  def big_method
    line_one
    line_two
    line_three
    line_four
    line_five
    line_six
    line_seven
    line_iegth
  end
end
