class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    #split text into array of words
    word_array=@text.split

    @word_count = word_array.length

    x = 0
    character_count = 0
    while x < word_array.length
      current_word_length = word_array[x].length.to_i
      character_count = character_count + current_word_length
      x = x + 1
    end

    @character_count_without_spaces = character_count

    #================================================================================
    #removes special word from text string - counts the number of characters removed from original text string
    #divides by length of special word to get number of occurances
    #================================================================================
    text_without_special_word = @text.downcase.gsub(@special_word.downcase,"")
    length_without_special_word = text_without_special_word.length.to_i
    length_of_special_word = @special_word.length.to_i

    @occurrences = ((@character_count_with_spaces.to_i - length_without_special_word) / length_of_special_word).to_i

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    monthly_interest_rate = @apr /100/12
    number_of_payments = @years * 12

    numerator = (monthly_interest_rate * @principal) * (1 + monthly_interest_rate)**number_of_payments
    denominator = (1+monthly_interest_rate)**number_of_payments - 1




    @monthly_payment = numerator / denominator

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = (@ending - @starting).to_f
    @minutes = (@seconds / 60).to_f
    @hours = (@minutes / 60).to_f
    @days = (@hours / 24).to_f
    @weeks = (@days / 7).to_f
    @years = (@days / 365).to_f

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @sorted_numbers.first

    @maximum = @sorted_numbers.last

    @range = @maximum - @minimum

      if @count%2 == 0
        median = (@sorted_numbers[(@count / 2) - 1] + @sorted_numbers[(@count / 2)]) / 2
      else
        median = @sorted_numbers[(@count / 2)]
      end

    @median = median

      x = 0
      sum = 0
      while x < @count
        sum = sum + @numbers [x]
        x = x + 1
      end

    @sum = sum

    @mean = @sum / @count

      x = 0
      sum_of_variance = 0
      while x < @count
        sum_of_variance = (@numbers[x] - @mean)**2 + sum_of_variance
        x = x + 1
      end

    @variance = sum_of_variance / @count

    @standard_deviation = @variance**0.5

      x = 0
      count = 0
      current_max_count = 0
      current_mode = 0

      while x < @count

        y = x

        while true
          if @sorted_numbers [x] == @sorted_numbers [y]
            count = count + 1
          else
            break
          end
          y= y+1
        end

        if count > current_max_count
          current_max_count = count
          current_mode = @sorted_numbers[x]
        end

        count = 0
        x=x+1
      end

    @mode = current_mode
#done
    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
