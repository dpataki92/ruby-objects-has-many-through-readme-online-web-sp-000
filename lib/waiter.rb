class Waiter

  attr_accessor :name, :yrs_experience

  @@all = []

  def initialize(name, yrs_experience)
    @name = name
    @yrs_experience = yrs_experience
    @@all << self
  end

  def self.all
    @@all
  end

  def new_meal(customer, total, tip=0)
    Meal.new(self, customer, total, tip)
  end

  def meals
    Meal.all.select do |meal|
      meal.waiter == self
    end
  end

  def best_tipper
    best_tipped_meal = meals.max do |meal_a, meal_b|
      meal_a.tip <=> meal_b.tip
    end

    best_tipped_meal.customer
  end

  def most_frequent_customer
    frequenter_table = {}
    meals.each do |meal|
      if frequenter_table[meal.customer.name] == nil
        frequenter_table[meal.customer.name] = 1
      else
        frequenter_table[meal.customer.name] += 1
      end
    end
    most_frequent = frequenter_table.max_by {|k,v| v}
    most_frequent[0]
  end

  def average_tips
    most_experienced_tips = []
    least_experienced_tips = []
    most_experienced = Waiter.all.max do |waiter_1, waiter_2|
      waiter_1.yrs_experience <=> waiter_2.yrs_experience
    end
    least_experienced = Waiter.all.min do |waiter_1, waiter_2|
      waiter_1.yrs_experience <=> waiter_2.yrs_experience
    end
    meals.each do |meal|
      if meal.waiter == most_experienced
        most_experienced_tips << meal.tip
      elsif meal.waiter == least_experienced
        least_experienced_tips << meal.tip
      end
    end
    puts "The average tips for the most experienced waiter is = #{most_experienced_tips.sum / most_experienced_tips.length}"
    puts "The average tips for the least experienced waiter is = #{least_experienced_tips.sum / least_experienced_tips.length}"
  end

end


jason = Waiter.new("Jason", 4)
robert = Waiter.new("Robert", 2)
carlos = Waiter.new("Carlos", 3)
lisa = Customer.new("Lisa", 24)
tim = Customer.new("Tim", 35)
terrance = Customer.new("Terrance", 27)

terrance.new_meal(jason, 50, 3)
lisa.new_meal(jason, 40, 10)
tim.new_meal(jason, 45, 8)
tim.new_meal(jason, 45, 7)
terrance.new_meal(robert, 40)
lisa.new_meal(robert, 32, 5)
tim.new_meal(robert, 70, 6)
