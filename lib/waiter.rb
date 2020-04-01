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

  def self.average_tips
    most_experienced_tips = []
    least_experienced_tips = []
    most_experienced = 1
    least_experienced = 1
    Waiter.all.each do |waiter|
      all_tips = waiter.meals.collect {|meal| meal.tip}
      if waiter.yrs_experience > most_experienced
        most_experienced = waiter.yrs_experience
        most_experienced_tips = all_tips
      elsif waiter.yrs_experience < least_experienced
        least_experienced = waiter.yrs_experience
        least_experienced_tips = all_tips
      end
    end
    puts most_experienced_tips
    puts least_experienced_tips
    "The average tips for the most experienced waiter is #{most_experienced_tips.sum / most_experienced_tips.length}$."
    "The average tips for the least experienced waiter is #{least_experienced_tips.sum / least_experienced_tips.length}$."
  end

end
