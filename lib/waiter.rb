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





end
